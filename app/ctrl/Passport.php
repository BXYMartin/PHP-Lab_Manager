<?php
/**
 * Created by PhpStorm.
 */

namespace main\app\ctrl;

use main\app\classes\UserAuth;
use main\app\classes\UserLogic;
use main\app\classes\SystemLogic;
use main\app\model\user\EmailFindPasswordModel;
use main\app\model\user\UserModel;
use main\app\model\SettingModel;
use main\app\model\user\UserTokenModel;
use main\app\model\user\LoginlogModel;
use main\app\model\user\EmailVerifyCodeModel;
use \main\lib\CaptchaBuilder;
use main\app\classes\SettingsLogic;

/**
 * 用户账号相关功能
 */
class Passport extends BaseCtrl
{

    /**
     * 登录状态保持对象
     * @var \main\app\classes\UserAuth;
     */
    protected $auth;

    /**
     * Passport constructor.
     * @throws \Exception
     */
    public function __construct()
    {
        parent::__construct();
        $this->auth = UserAuth::getInstance();
    }

    /**
     * 登录页面
     */
    public function pageLogin()
    {
        $data = [];
        $data['title'] = 'Login';
        $data['is_login_page'] = true;
        $data['captcha_login_switch'] = (new SettingsLogic())->loginRequireCaptcha();
        $data['captcha_reg_switch'] = (new SettingsLogic())->regRequireCaptcha();
        $this->render('gitlab/passport/login.php', $data);
    }

    /**
     * 输出验证码
     */
    public function pageOutputCaptcha($mode)
    {
        if (!in_array($mode, array('login', 'reg'))) {
            $mode = 'login';
        }
        $builder = new CaptchaBuilder;
        $builder->build(150, 40);
        if ($mode == 'login') {
            $_SESSION['captcha_login'] = $builder->getPhrase();
        }
        if ($mode == 'reg') {
            $_SESSION['captcha_reg'] = $builder->getPhrase();
        }
        header('Content-type: image/jpeg');
        $builder->output();
    }

    /**
     * 注销
     */
    public function pageLogout()
    {
        UserAuth::getInstance()->logout();
        $this->pagelogin();
    }

    /**
     * 登录
     * @param string $username
     * @param string $password
     * @param string $ios_token
     * @param string $android_token
     * @param string $version
     * @param string $openid
     * @param string $display_name
     * @param string $headimgurl
     * @param int $source
     * @throws \Exception
     */
    public function doLogin(
        $username = '',
        $password = '',
        $ios_token = '',
        $android_token = '',
        $version = '',
        $openid = '',
        $display_name = '',
        $headimgurl = '',
        $source = 0
    )
    {
        if (empty($username)) {
            $this->ajaxFailed('Error', 'Username is empty!');
        }

        if (empty($password)) {
            $this->ajaxFailed('Error', 'Password is empty!');
        }

        $userModel = UserModel::getInstance('');
        $final = [];
        $final['user'] = new \stdClass();
        $final['msg'] = '';
        $final['code'] = 0;
        // sleep( 5 );
        // 使用对称aes加密解密
        if (isset($_POST["aes_json"]) && isset($_POST["passphrase"])) {
            $passPhrase = getConfigVar('data')['login']['pass_phrase'];
            $password = cryptoJsAesDecrypt($passPhrase, $_POST["aes_json"]);
            //$final['$password'] = $password;
        }
        // $err = [];
        // 检查登录错误次数,一个ip的登录错误次数限制
        $times = 0;
        $settingModel = SettingModel::getInstance();
        $muchErrTimesCaptcha = $settingModel->getSettingValue('muchErrorTimesCaptcha');
        $ipAddress = getIp();
        $reqVerifyCode = isset($_REQUEST['vcode']) ? $_REQUEST['vcode'] : false;
        $arr = $this->auth->checkIpErrorTimes($reqVerifyCode, $ipAddress, $times, $muchErrTimesCaptcha);
        list($ret, $retCode, $tip) = $arr;
        if (!$ret) {
            $this->ajaxFailed('Message', $tip, $retCode);
        }
        // 检车登录账号和密码
        list($ret, $user) = $this->auth->checkLoginByUsername($username, $password);
        // print_r($user);
        if ($ret != UserModel::LOGIN_CODE_OK) {
            $code = intval($ret);
            $tip = 'Wrong Password';
            $arr = $this->auth->checkRequireLoginVCode($ipAddress, $times, $muchErrTimesCaptcha);
            list($ret2, $code2) = $arr;
            if (!$ret2) {
                $code = $code2;
                $tip = 'Failed Too Many Times, Captcha Needed!';//$arr['msg'];
            }
            $this->ajaxFailed('Error', $tip, $code);
        }
        unset($_SESSION['login_captcha'], $_SESSION['login_captcha_time']);

        // 更新登录次数
        $this->auth->updateIpLoginTime($times, $muchErrTimesCaptcha);

        if (intval($user['status']) == UserModel::STATUS_PENDING_APPROVAL) {
            $this->ajaxFailed('Message', 'User not activated yet!');
        }

        if ($user['status'] != UserModel::STATUS_NORMAL) {
            $this->ajaxFailed('Message', 'User has been disabled!');
        }
        if ($openid) {
            $info['weixin_openid'] = $openid;
            if (!$user['avatar']) {
                $info['avatar'] = $headimgurl;
            }
            $info['weixin_openid'] = $openid;
            $userModel->updateUserById($info, $user['uid']);
        }
        if ($ios_token) {
            $info['ios_token'] = $ios_token;
        }
        if ($android_token) {
            $info['android_token'] = $android_token;
        }
        if ($version) {
            $info['version'] = $version;
        }
        if ($display_name) {
            $info['display_name'] = $display_name;
        }
        if ($source) {
            $info['source'] = $source;
        }

        $this->auth->autoLogin($user);

        // 更新登录信息
        $userModel->uid = $user['uid'];
        $this->updateLoginInfo($userModel->uid);
        // 处理登录返回值
        $this->processLoginReturn($final, $user);
        // 记录登录日志,用于只允许单个用户登录
        $loginLogModel = new LoginlogModel();
        $loginLogModel->loginLogInsert($user['uid']);
        //$this->auth->kickCurrentUserOtherLogin($user['uid']);
        @setcookie('check_browser_flag', '', time() + 3600 * 4, '/', getCookieHost());
        $this->ajaxSuccess($final['msg'], $final);
    }

    /**
     * 处理登录返回值
     * @param $final
     * @param $user
     */
    private function processLoginReturn(&$final, $user)
    {
        // 生成和刷新token
        $userTokenModel = new UserTokenModel($user['uid']);
        list($ret, $token, $refresh_token) = $userTokenModel->makeToken($user);
        if (!$ret) {
            $this->ajaxFailed('Error', 'Failed to refresh tokens!');
        }

        $final['token'] = $token;
        $final['refresh_token'] = $refresh_token;
        $tokenCfg = getConfigVar('data');
        $final['token_expire'] = intval($tokenCfg['token']['expire_time']);

        if (isset($user['password'])) {
            unset($user['password']);
        }
        // $_SESSION[UserAuth::SESSION_UID_KEY] = $user['uid'];
        $this->auth->login($user);
        $_SESSION['user_info'] = $user;

        $userLogic = new UserLogic();
        $final['user'] = $userLogic->formatUserInfo($user);

        $final['code'] = UserModel::LOGIN_CODE_OK;
        $final['msg'] = 'Login Success!';
    }

    /**
     * 更新登录信息
     * @param $uid
     */
    private function updateLoginInfo($uid)
    {
        $updateInfo = array();
        if (isset($_REQUEST['ios_token']) && !empty($_REQUEST['ios_token'])) {
            $updateInfo['ios_token'] = str_replace(array(" ", '<', '>'), array('', '', ''), $_REQUEST['ios_token']);
        }

        if (isset($_REQUEST['android_token']) && !empty($_REQUEST['android_token'])) {
            $updateInfo['android_token'] = str_replace(
                array(" ", '<', '>'),
                array('', '', ''),
                $_REQUEST['android_token']
            );
        }
        $updateInfo['last_login_time'] = time();
        if (!empty($updateInfo)) {
            $userModel = UserModel::getInstance($uid);
            $userModel->updateUser($updateInfo);
            unset($updateInfo);
        }
    }

    /**
     * 注销接口
     * @throws \Exception
     */
    public function doLogout()
    {
        //清除会话
        UserAuth::getInstance()->logout();
        $this->ajaxSuccess('ok');
    }


    /**
     * 邮箱注册注册
     * @throws \Exception
     */
    public function register()
    {
        //参数检查
        $settingModel = new SettingModel();

        $err = [];
        // 是否需要图形验证码
        if ($settingModel->getSettingValue('reg_require_pic_code')) {
            $captchaCode = $_POST['captcha_code'];
            if (empty($captchaCode)) {
                $err['captcha_code'] = 'Empty Catpcha!';
            }
            if (isset($_SESSION['reg_captcha'])
                && $captchaCode !== $_SESSION['reg_captcha']
                && (time() - $_SESSION['reg_captcha_time']) > 300) {
                $this->ajaxFailed('Error', 'Wrong Captcha Code!');
                $err['captcha_code'] = 'Wrong Captcha Code!';
            }
            if (isset($_SESSION['reg_captcha'])) {
                unset($_SESSION['reg_captcha']);
            }
            if (isset($_SESSION['reg_captcha_time'])) {
                unset($_SESSION['reg_captcha_time']);
            }
        }
        if (!isset($_POST['email']) || empty($_POST['email'])) {
            $err['email'] = 'Email can\'t be empty!';
        }
        if (!isset($_POST['email_confirmation']) || empty($_POST['email_confirmation'])) {
            $err['email_confirmation'] = 'Email confirmation can\'t be empty!';
        }
        if ($_POST['email'] != $_POST['email_confirmation']) {
            $err['email_confirmation'] = 'Inconsistent email input!';
        }
        if (!isset($_POST['username']) || empty($_POST['username'])) {
            $err['username'] = 'Username can\'t be empty!';
        }
        if (!isset($_POST['password']) || empty($_POST['password'])) {
            $err['password'] = 'Password can\'t be empty!';
        }
        if (!isset($_POST['display_name']) || empty($_POST['display_name'])) {
            $err['display_name'] = 'Auditor Initials can\'t be empty!';
        }
        $username = trimStr($_POST['username']);
        $email = trimStr($_POST['email']);
        $password = trimStr($_POST['password']);
        $displayName = trimStr(safeStr($_POST['display_name']));
        $avatar = isset($_POST['avatar']) ? safeStr($_POST['avatar']) : "";
        if (strlen($password) > 20) {
            $err['password'] = 'Password too long!';
        }
        // 检查参数是否正确
        if (!empty($err)) {
            $this->ajaxFailed('Parameter Error', $err, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }

        // 检查用户名和email是否可用
        $err = [];
        $userModel = UserModel::getInstance('');
        $user = $userModel->getByEmail($email);
        if (isset($user['uid'])) {
            $err['email'] = 'This email has already been used!';
        }
        $user = $userModel->getByUsername($username);
        if (isset($user['uid'])) {
            $err['username'] = 'This username has already been used!';
        }
        unset($user);
        if (!empty($err)) {
            $this->ajaxFailed('Parameter Error', $err, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }

        $userInfo = [];
        $userInfo['password'] = UserAuth::createPassword($password);
        $userInfo['email'] = safeStr($email);
        $userInfo['username'] = safeStr($username);
        $userInfo['display_name'] = safeStr($displayName);
        $userInfo['status'] = UserModel::STATUS_PENDING_APPROVAL;
        $userInfo['create_time'] = time();
        $userInfo['avatar'] = $avatar;

        $userModel = new UserModel();
        list($ret, $user) = $userModel->addUser($userInfo);
        if ($ret == UserModel::REG_RETURN_CODE_OK) {
            $this->sendActiveEmail($user, $email, $displayName);
            $this->ajaxSuccess('Register Success');
        } else {
            $this->ajaxFailed('Error', 'Register Failed: ' . $user);
        }
    }

    /**
     * 发送邮箱待激活的emaiil
     * @param array $user
     * @param string $email
     * @return array
     */
    private function sendActiveEmail($user, $email = '', $username = '')
    {

        $verifyCode = randString(32);
        $emailVerifyCodeModel = new EmailVerifyCodeModel();
        $row = $emailVerifyCodeModel->getByEmail($email);
        if (isset($row['email'])) {
            if (time() - intval($row['time']) < 30) {
                return [false, 'Please try again in 30s!'];
            }
        }

        list($flag, $insertId) = $emailVerifyCodeModel->add($user['uid'], $email, $username, $verifyCode);
        if ($flag && APP_STATUS != 'travis') {
            $args = [];
            $args['{{site_name}}'] = 'PRIME Lab';
            $args['{{name}}'] = $user['display_name'];
            $args['{{display_name}}'] = $user['display_name'];
            $args['{{email}}'] = $email;
            $args['{{url}}'] = ROOT_URL . 'passport/active_email?email=' . $email . '&verify_code=' . $verifyCode;
            $mailConfig = getConfigVar('mail');
            $body = str_replace(array_keys($args), array_values($args), $mailConfig['tpl']['active_email']);
            // echo $body;die;
            $systemLogic = new SystemLogic();
            list($ret, $errMsg) = $systemLogic->mail($email, 'Audit Manager User Activation Email', $body);
            //var_dump($ret, $errMsg);
            if (!$ret) {
                return [false, 'send_email_failed:' . $errMsg];
            }
        } else {
            //'很抱歉,服务器繁忙，请重试!!';
            return [false, 'server_error_insert_failed:' . $insertId];
        }
        return [true, 'ok'];
    }


    /**
     * 打开邮箱,激活用户
     */
    public function pageActiveEmail()
    {
        if (!isset($_GET['email'])) {
            $this->error('Parameter Error', 'email_param_error');
            return;
        }
        if (!isset($_GET['verify_code'])) {
            $this->error('Parameter Error', 'verify_code_param_error');
            return;
        }
        $email = trimStr($_GET['email']);
        $verifyCode = trimStr($_GET['verify_code']);

        $userModel = UserModel::getInstance('');
        $user = $userModel->getByEmail($email);
        if (!isset($user['email'])) {
            $this->error('Error', 'email_exist');
            return;
        }
        unset($user);

        // 校验验证码
        $emailVerifyCodeModel = new EmailVerifyCodeModel();
        $find = $emailVerifyCodeModel->getByEmailVerify($email, $verifyCode);

        if (!isset($find['email']) || $verifyCode != $find['verify_code']) {
            $this->error('Error', 'Activation link has already been expired or activated!');
            return;
        }

        if ((time() - (int)$find['time']) > 3600) {
            $this->error('Error', 'Activation link has been expired!');
            return;
        }

        //参数检查
        $userInfo = [];
        $userInfo['status'] = UserModel::STATUS_NORMAL;
        // $userInfo['email'] = $find['email'];
        // $userInfo['username'] = $find['username'];
        $userModel->uid = $find['uid'];
        list($ret, $msg) = $userModel->updateUser($userInfo);
        if ($ret) {
            $emailVerifyCodeModel->deleteByEmail($email);
            $this->info('Message', 'Activation success!');
        } else {
            $this->info('Message', 'Activation Failed: ' . $msg);
        }
    }

    public function pageFindPassword()
    {
        $this->render('gitlab/passport/find_password.php');
    }

    /**
     * 发送找回密码
     * @throws \Exception
     */
    public function sendFindPasswordEmail()
    {
        $email = null;
        if (isset($_REQUEST['email'])) {
            $email = $_REQUEST['email'];
        }
        if (empty($email)) {
            $this->ajaxFailed('Error', 'Email can\'t be empty!', BaseCtrl::AJAX_FAILED_TYPE_TIP);
        }
        $userModel = UserModel::getInstance();
        $user = $userModel->getByEmail($email);
        if (!isset($user['uid'])) {
            $this->ajaxFailed('Error', 'Email not exist!', BaseCtrl::AJAX_FAILED_TYPE_TIP);
        }
        $verifyCode = randString(32);
        $emailFindPwdModel = new EmailFindPasswordModel();

        $row = $emailFindPwdModel->getByEmail($email);
        if (isset($row['email'])) {
            if (time() - intval($row['time']) < 59) {
                //$this->ajaxFailed('提示', '操作过于频繁请稍后再发送', BaseCtrl::AJAX_FAILED_TYPE_TIP);
            }
        }
        list($flag, $insertId) = $emailFindPwdModel->add($email, $verifyCode);
        if ($flag && APP_STATUS != 'travis') {
            $args = [];
            $args['{{site_name}}'] = (new SettingsLogic())->showSysTitle();
            $args['{{name}}'] = $user['display_name'];
            $args['{{email}}'] = $email;
            $args['{{verifyCode}}'] = $verifyCode;
            $url = ROOT_URL . 'passport/display_reset_password?email=' . $email . '&verify_code=' . $verifyCode;
            $args['{{url}}'] = $url;
            $mailConfig = getConfigVar('mail');
            $body = str_replace(array_keys($args), array_values($args), $mailConfig['tpl']['reset_password']);
            //echo $body;
            //@TODO 异步发送
            $systemLogic = new SystemLogic();
            list($ret, $errMsg) = $systemLogic->mail($email, 'Audit Manager Reset My Password Email', $body);
            if (!$ret) {
                $this->ajaxFailed('Error', 'Failed Sending Email: ' . $errMsg);
            }
        } else {
            //'很抱歉,服务器繁忙，请重试!!';
            $this->ajaxFailed('Error', 'Insertion Failed: ' . $insertId);
        }
        $this->ajaxSuccess('ok');
    }


    public function pageDisplayResetPassword()
    {
        if (!isset($_GET['email'])) {
            $this->error('Error', 'Email is empty!');
            return;
        }
        if (!isset($_GET['verify_code'])) {
            $this->error('Error', 'Captcha is empty!');
            return;
        }
        $email = trimStr($_GET['email']);
        $verifyCode = trimStr($_GET['verify_code']);

        // 校验验证码
        $emailFindPwdModel = new EmailFindPasswordModel();
        $find = $emailFindPwdModel->getByEmailVerifyCode($email, $verifyCode);

        if (!isset($find['email']) || $verifyCode != $find['verify_code']) {
            $this->error('Error', 'Activation link has been expired!');
            return;
        }
        if ((time() - (int)$find['time']) > 36000) {
            $this->error('Error', 'Activation link has been expired!');
            return;
        }
        $data = ['email' => $email, 'verify_code' => $verifyCode];
        $this->render('gitlab/passport/reset_password.php', $data);
    }

    /**
     * 处理重置密码
     * @throws \Exception
     */
    public function pageResetPassword()
    {
        if (!isset($_POST['email'])) {
            $this->error('Error', 'Email is empty!');
            return;
        }
        if (!isset($_POST['verify_code'])) {
            $this->error('Error', 'Captcha is empty!');
            return;
        }
        if (!isset($_POST['password'])) {
            $this->error('Error', 'Password is empty!');
            return;
        }
        if (!isset($_POST['password_confirmation'])) {
            $this->error('Error', 'Password confirmation is empty!');
            return;
        }
        $email = trimStr($_POST['email']);
        $verifyCode = trimStr($_POST['verify_code']);
        $password = trimStr($_POST['password']);
        $passwordConfirmation = trimStr($_POST['password_confirmation']);

        $userModel = UserModel::getInstance('');
        $user = $userModel->getByEmail($email);
        if (!isset($user['email'])) {
            $this->error('Error', 'Email not exist!');
            return;
        }
        // 校验验证码
        $emailFindPwdModel = new EmailFindPasswordModel();
        $find = $emailFindPwdModel->getByEmailVerifyCode($email, $verifyCode);

        if (!isset($find['email']) || $verifyCode != $find['verify_code']) {
            $this->error('Error', 'Activation link has been expired!');
            return;
        }

        if ((time() - (int)$find['time']) > (3600 * 24)) {
            $this->error('Error', 'Activation link has been expired!');
            return;
        }
        if ($password != $passwordConfirmation) {
            $this->error('Error', 'Password is inconsistent!');
            return;
        }

        $userInfo = [];
        $userInfo['password'] = UserAuth::createPassword($password);
        $userModel->uid = $user['uid'];
        list($ret, $msg) = $userModel->updateUser($userInfo);
        if ($ret) {
            $emailFindPwdModel->deleteByEmail($email);
            $this->info('Message', 'Password reset success!');
        } else {
            $this->info('Error', 'Password reset failed: ' . $msg);
        }
    }

    /**
     * 检查邮箱是否
     * @param string $email
     */
    public function emailExist($email)
    {
        if (empty($email)) {
            echo 'true';
            die;
        }
        $userModel = UserModel::getInstance();
        $user = $userModel->getByEmail($email);
        if (!isset($user['uid'])) {
            echo 'false';
            die;
        }
        echo 'true';
        die;
    }

    /**
     * 检查用户名你是否存在
     * @param string $username
     */
    public function usernameExist($username = '')
    {
        if (empty($username)) {
            echo 'true';
            die;
        }
        $userModel = UserModel::getInstance();
        $user = $userModel->getByUsername($username);
        if (!isset($user['uid'])) {
            echo 'false';
            die;
        }
        echo 'true';
        die;
    }
}
