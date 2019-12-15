<?php

namespace main\app\model\standard;

use main\app\classes\UserAuth;
use main\app\model\DbModel;
use main\app\model\NestedSetModel;


/**
 *
 * User model
 * @author Sven
 */
class StandardModel extends DbModel
{
    public $prefix = 'standard_';

    public $table = 'main';

    public $fields = ' * ';

    public $primaryKey = 'sid';

    public $nestedSet;
    const  DATA_KEY = 'standard/';

    const  REG_RETURN_CODE_OK = 1;
    const  REG_RETURN_CODE_EXIST = 2;
    const  REG_RETURN_CODE_ERROR = 3;

    /**
     * 登录成功
     */
    const  LOGIN_CODE_OK = 1;

    /**
     * 已经登录过了
     */
    const  LOGIN_CODE_EXIST = 2;

    /**
     * 登录失败
     */
    const  LOGIN_CODE_ERROR = 3;

    /**
     * 登录需要验证码
     */
    const  LOGIN_REQUIRE_VERIFY_CODE = 4;

    /**
     * 验证码错误
     */
    const  LOGIN_VERIFY_CODE_ERROR = 5;

    /**
     * 错误次数太多
     */
    const  LOGIN_TOO_MUCH_ERROR = 5;

    const  STATUS_PENDING_APPROVAL = 0;
    const  STATUS_NORMAL = 1;
    const  STATUS_DISABLED = 2;
    public static $status = [
        self::STATUS_PENDING_APPROVAL => '审核中',
        self::STATUS_NORMAL => '正常',
        self::STATUS_DISABLED => '禁用'
    ];

    public $sid = '';
    /**
     * 用于实现单例模式
     * @var self
     */
    protected static $instance;


    /**
     * 创建单例对象
     * @param string $uid
     * @param bool $persistent
     * @return mixed
     * @throws \Exception
     */
    public static function getInstance($uid = '', $persistent = false)
    {
        $index = $uid . strval(intval($persistent));
        if (!isset(self::$instance[$index]) || !is_object(self::$instance[$index])) {
            self::$instance[$index] = new self($uid, $persistent);
        }
        return self::$instance[$index];
    }

    /**
     * StandardModel constructor.
     * @param string $uid
     * @param bool $persistent
     * @throws \Exception
     */
    public function __construct($sid = '', $persistent = false)
    {
        parent::__construct($persistent);
        $this->sid = $sid;
        $this->nestedSet = new NestedSetModel($this->realConnect()->pdo);
    }

    public function getAll($primaryKey = true)
    {
        return $this->nestedSet->getRoots();
    }

    /**
     * 取得一个用户的基本信息
     * @return array
     */
    public function getStandard()
    {
        $fields = '*';
        $conditions = array('sid' => $this->sid);
        $finally = $this->getRow($fields, $conditions);
        return $finally;
    }

    /**
     * @param $sid
     * @return array
     */
    public function getBySid($sid)
    {
        $fields = 'sid, standard_name, description';
        $where = array('sid' => $sid);
        $finally = $this->getRow($fields, $where);
        return $finally;
    }

    public function getByName($name)
    {
        $fields = "*, {$this->primaryKey}";
        $where = ['standard_name' => trim($name)];
        $stand = $this->getRow($fields, $where);
        return $stand;
    }

    public function flat($name) {
        $sid = $this->getByName($name);
        return $sid;
    }

    public function show($name) {
        $sid = $this->getByName($name)['sid'];
        $source = [];
        $this->nestedSet->treeze($source, $sid);
        return $source;
    }

    /**
     * 添加用户
     * @param array $userInfo 提交的用户信息
     * @return array
     */
    public function add($name, $description)
    {
        $info = [];
        $info['standard_name'] = $name;
        $info['description'] = $description;
        $ret = $this->nestedSet->createRoot($info);
        return [$ret, '操作成功'];
    }


    public function addLine($sid, $name, $description, $parent)
    {
        $info = [];
        $treeId = $this->getByName($parent)['tree_id'];
        $info['standard_name'] = $name;
        $info['description'] = $description;
        $ret = $this->nestedSet->createChild($sid, $info, $treeId);
        return [$ret, '操作成功'];
    }


    /**
     * 更新用户的信息
     * @param $updateInfo
     * @param $uid
     * @return array
     * @throws \Exception
     */
    public function updateById($sid, $updateInfo)
    {
        if (empty($updateInfo)) {
            return [false, __CLASS__ . __METHOD__ . '参数$update_info不能为空'];
        }
        if (!is_array($updateInfo)) {
            return [false, __CLASS__ . __METHOD__ . '参数$update_info必须是数组'];
        }
        if (!isset($sid)) {
            return [false, __CLASS__ . __METHOD__ . '参数$sid不能为空'];
        }
        // $key = self::DATA_KEY . 'uid/' . $uid;
        $where = ['sid' => $sid];
        $ret = $this->update($updateInfo, $where);
        return [$ret];
    }

    public function deleteById($sid)
    {
        if (!isset($sid)) {
            return [false, __CLASS__ . __METHOD__ . '参数$sid不能为空'];
        }
        // $key = self::DATA_KEY . 'uid/' . $uid;
        $ret = $this->nestedSet->deleteTree($sid);
        return [$ret];
    }


    public function deleteNode($sid)
    {
        if (!isset($sid)) {
            return [false, __CLASS__ . __METHOD__ . '参数$sid不能为空'];
        }
        // $key = self::DATA_KEY . 'uid/' . $uid;
        $ret = $this->nestedSet->deleteNodeAndChildren($sid);
        return [True];
    }


    /**
     * 更新一个用户的信息
     * @param $updateInfo
     * @return array
     * @throws \Exception
     */
    public function updateUser($updateInfo)
    {
        if (empty($updateInfo)) {
            return [false, 'update info is empty'];
        }
        if (!is_array($updateInfo)) {
            return [false, 'update info is not array'];
        }
        $uid = $this->uid;
        // $key = self::DATA_KEY . 'uid/' . $uid;
        $where = ['uid' => $uid];//"  where `uid`='$uid'";
        $ret = $this->update($updateInfo, $where);
        return $ret;
    }
}
