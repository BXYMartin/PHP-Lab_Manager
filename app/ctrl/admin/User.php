<?php

namespace main\app\ctrl\admin;

use main\app\classes\SystemLogic;
use main\app\classes\UserAuth;
use main\app\classes\ConfigLogic;
use main\app\classes\UserLogic;
use main\app\ctrl\BaseCtrl;
use main\app\ctrl\BaseAdminCtrl;
use main\app\model\project\ProjectModel;
use main\app\model\project\ProjectRoleModel;
use main\app\model\project\ProjectUserRoleModel;
use main\app\model\user\UserGroupModel;
use main\app\model\user\UserModel;
use main\app\model\user\GroupModel;


/**
 * 系统模块的用户控制器
 */
class User extends BaseAdminCtrl
{

    static public $pageSizes = [10, 20, 50, 100];

    /**
     * @throws \Exception
     */
    public function pageIndex()
    {
        $data = [];
        $data['title'] = 'User Management';
        $data['nav_links_active'] = 'user';
        $data['left_nav_active'] = 'user';
        ConfigLogic::getAllConfigs($data);

        $data['group_id'] = 0;
        if (isset($_GET['group_id'])) {
            $data['group_id'] = (int)$_GET['group_id'];
        }
        $data['status_approval'] = UserModel::STATUS_PENDING_APPROVAL;
        $this->render('gitlab/admin/users.php', $data);
    }

    /**
     *
     * @return int|null
     */
    private function getParamUserId()
    {
        $userId = null;
        if (isset($_GET['_target'][3])) {
            $userId = (int)$_GET['_target'][3];
        }
        if (isset($_REQUEST['uid'])) {
            $userId = (int)$_REQUEST['uid'];
        }
        if (!$userId) {
            $this->ajaxFailed('uid_is_null');
        }
        return $userId;
    }

    /**
     * 用户查询
     * @param int $uid
     * @param string $username
     * @param int $group_id
     * @param string $status
     * @param string $order_by
     * @param string $sort
     * @param int $page
     * @param int $page_size
     * @throws \Exception
     */
    public function filter(
        $uid = 0,
        $username = '',
        $group_id = 0,
        $status = '',
        $order_by = 'uid',
        $sort = 'desc',
        $page = 1,
        $page_size = 20
    )
    {
        $groupId = intval($group_id);
        $orderBy = $order_by;
        $pageSize = intval($page_size);
        if (!in_array($pageSize, self::$pageSizes)) {
            $pageSize = self::$pageSizes[1];
        }
        $uid = intval($uid);
        $groupId = intval($groupId);
        $username = trimStr($username);
        $status = intval($status);

        $userLogic = new UserLogic();
        $ret = $userLogic->filter($uid, $username, $groupId, $status, $orderBy, $sort, $page, $pageSize);
        list($users, $total, $groups) = $ret;
        $data['groups'] = array_values($groups);
        $data['total'] = $total;
        $data['pages'] = ceil($total / $pageSize);
        $data['page_size'] = $pageSize;
        $data['page'] = $page;
        $data['users'] = array_values($users);
        $this->ajaxSuccess('ok', $data);
    }


    /**
     * 禁用用户
     * @throws \Exception
     */
    public function disable()
    {
        $userId = $this->getParamUserId();
        $userInfo = [];
        $userModel = UserModel::getInstance();
        $userInfo['status'] = UserModel::STATUS_DISABLED;
        $userModel->uid = $userId;
        $userModel->updateUser($userInfo);
        $this->ajaxSuccess('Operation Success');
    }

    /**
     * 激活用户
     * @throws \Exception
     */
    public function active()
    {
        $userId = $this->getParamUserId();
        $userInfo = [];
        $userModel = UserModel::getInstance();
        $userInfo['status'] = UserModel::STATUS_NORMAL;
        $userModel->uid = $userId;
        $userModel->updateUser($userInfo);
        $this->ajaxSuccess('Operation Success');
    }

    /**
     * 获取单个用户信息
     * @throws \Exception
     */
    public function get()
    {
        $userId = $this->getParamUserId();
        $userModel = UserModel::getInstance($userId);

        $userModel->uid = $userId;
        $user = $userModel->getUser();
        if (isset($user['password'])) {
            unset($user['password']);
        }
        if (!isset($user['uid'])) {
            $this->ajaxFailed('Parameter Error');
        }
        UserLogic::formatAvatarUser($user);

        $user['is_cur'] = "0";
        if ($user['uid'] == UserAuth::getId()) {
            $user['is_cur'] = "1";
        }
        $this->ajaxSuccess('ok', (object)$user);
    }

    /**
     * 用户
     * @throws \Exception
     */
    public function gets()
    {
        $userLogic = new UserLogic();
        $users = $userLogic->getAllNormalUser();
        $this->ajaxSuccess('ok', $users);
    }

    /**
     * @throws \Exception
     */
    public function userGroup()
    {
        $userId = $this->getParamUserId();
        $data = [];
        $userGroupModel = new UserGroupModel();
        $data['user_groups'] = $userGroupModel->getGroupsByUid($userId);
        $groupModel = new GroupModel();
        $data['groups'] = $groupModel->getAll(false);
        $this->ajaxSuccess('ok', $data);
    }

    /**
     *
     * @param $params
     * @throws \Exception
     */
    public function updateUserGroup($params)
    {
        $userId = $this->getParamUserId();
        $groups = $params['groups'];
        if (!is_array($groups)) {
            $this->ajaxFailed('param_is_error');
        }
        $userLogic = new UserLogic();
        list($ret, $msg) = $userLogic->updateUserGroup($userId, $groups);
        if ($ret) {
            $this->ajaxSuccess("Operation Success", $msg);
        }
        $this->ajaxFailed($msg);
    }

    /**
     * 添加用户
     * @param $params
     * @throws
     */
    public function add($params)
    {
        $errorMsg = [];
        if (empty($params)) {
            $this->ajaxFailed('Parameter Error', 'Empty parameters!');
        }
        if (!isset($params['password']) || empty($params['password'])) {
            $errorMsg['password'] = 'Please enter password!';
        }
        if (!isset($params['email']) || empty($params['email'])) {
            $errorMsg['email'] = 'Please enter email address!';
        }
        if (!isset($params['username']) || empty($params['username'])) {
            $errorMsg['username'] = 'Please enter username!';
        }
        if (!isset($params['display_name']) || empty($params['display_name'])) {
            $errorMsg['display_name'] = 'Please enter auditor initials!';
        }
        if (!empty($errorMsg)) {
            $this->ajaxFailed('Parameter Error', $errorMsg, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }

        $display_name = $params['display_name'];
        $password = trimStr($params['password']);
        $username = trimStr($params['username']);
        $email = trimStr($params['email']);
        $disabled = isset($params['disable']) ? true : false;
        $userInfo = [];
        $userInfo['email'] = str_replace(' ', '', $email);
        $userInfo['username'] = $username;
        $userInfo['display_name'] = $display_name;
        $userInfo['password'] = UserAuth::createPassword($password);
        $userInfo['create_time'] = time();
        $userInfo['title'] = isset($params['title']) ? $params['title'] : '';
        if ($disabled) {
            $userInfo['status'] = UserModel::STATUS_DISABLED;
        } else {
            $userInfo['status'] = UserModel::STATUS_NORMAL;
        }

        $userModel = UserModel::getInstance();
        $user = $userModel->getByEmail($email);
        if (isset($user['email'])) {
            $this->ajaxFailed('Email is already in use!');
        }
        $user2 = $userModel->getByUsername($username);
        if (isset($user2['email'])) {
            $this->ajaxFailed('Username is already in use!');
        }
        unset($user, $user2);

        list($ret, $user) = $userModel->addUser($userInfo);
        if ($ret == UserModel::REG_RETURN_CODE_OK) {
            if (isset($params['notify_email']) && $params['notify_email'] == '1') {
                $sysLogic = new SystemLogic();
                $content = "Created User:<br>Username: {$username}<br>Password: {$password}<br><br>Please visit " . ROOT_URL . " to login.<br>";
                $sysLogic->mail([$email], "Audit Manager New User Notification Email", $content);
            }
            $this->ajaxSuccess('Success', 'Successfully Created User');
        } else {
            $this->ajaxFailed('Error', "Insertion Failed: " . $user);
        }
    }

    /**
     * @param $params
     * @throws \Exception
     */
    public function update($params)
    {
        $userId = $this->getParamUserId();
        $errorMsg = [];
        if (empty($params)) {
            $this->ajaxFailed('Parameter Error');
        }
        if (isset($params['display_name']) && empty($params['display_name'])) {
            $errorMsg['display_name'] = 'Please input auditor initials!';
        }
        if (!empty($errorMsg)) {
            $this->ajaxFailed('Parameter Error', $errorMsg, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }

        $info = [];
        if (isset($params['password']) && !empty($params['password'])) {
            $info['password'] = UserAuth::createPassword($params['password']);
        }
        if (isset($params['display_name'])) {
            $info['display_name'] = $params['display_name'];
        }
        if (isset($params['title'])) {
            $info['title'] = $params['title'];
        }
        if (isset($params['disable']) && (UserAuth::getId() != $userId)) {
            $info['status'] = UserModel::STATUS_DISABLED;
        } else {
            $info['status'] = UserModel::STATUS_NORMAL;
        }

        $userModel = UserModel::getInstance($userId);
        $userModel->uid = $userId;
        $userModel->updateUser($info);

        $this->ajaxSuccess('Success', 'Successfully Updated User');
    }

    /**
     * 删除用户
     * @throws \Exception
     */
    public function delete($uid)
    {
        $userId = $this->getParamUserId();
        if (empty($uid)) {
            $this->ajaxFailed('no_uid');
        }
        if ($userId == UserAuth::getId()) {
            $this->ajaxFailed('Logic Error', 'Can\'t operate on yourself!');
        }

        // @todo 要处理删除后该用户关联的事项
        $userModel = new UserModel();
        $user = $userModel->getByUid($userId);
        if (empty($user)) {
            $this->ajaxFailed('Parameter Error', 'User not exist!');
        }
        if ($user['is_system'] == '1') {
            $this->ajaxFailed('Logic Error', 'Can\'t delete prebuilt user!');
        }

        $ret = $userModel->deleteById($userId);
        if (!$ret) {
            $this->ajaxFailed('System Error', 'Database operation failed!');
        } else {
            $userModel = new UserGroupModel();
            $userModel->deleteByUid($userId);
            $this->ajaxSuccess('Success', 'Successfully Deleted User');
        }
    }

    /**
     * 批量删除帐户
     * @throws \Exception
     */
    public function batchDisable()
    {
        if (empty($_REQUEST['checkbox_id']) || !isset($_REQUEST['checkbox_id'])) {
            $this->ajaxFailed('no_request_uid');
        }

        $userModel = UserModel::getInstance();
        foreach ($_REQUEST['checkbox_id'] as $uid) {
            $userModel->uid = intval($uid);
            $userInfo = [];
            $userInfo['status'] = UserModel::STATUS_DISABLED;
            list($ret, $msg) = $userModel->updateUser($userInfo);
            if (!$ret) {
                $this->ajaxFailed('server_error_update_failed:' . $msg);
            }
        }
        $this->ajaxSuccess('Success', 'Successfully Disabled User');
    }

    /**
     * 批量恢复帐户
     * @throws \Exception
     */
    public function batchRecovery()
    {
        if (empty($_REQUEST['checkbox_id']) || !isset($_REQUEST['checkbox_id'])) {
            $this->ajaxFailed('no_request_id');
        }

        $userModel = UserModel::getInstance();

        foreach ($_REQUEST['checkbox_id'] as $id) {
            $userModel->uid = intval($id);
            $userInfo = [];
            $userInfo['status'] = UserModel::STATUS_NORMAL;
            $userModel->updateUser($userInfo);
        }
        $this->ajaxSuccess('Success', 'Successfully Recovered User');
    }
}
