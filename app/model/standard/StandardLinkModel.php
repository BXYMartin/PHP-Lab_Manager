<?php

namespace main\app\model\standard;

use main\app\classes\UserAuth;
use main\app\model\DbModel;

/**
 *
 * User model
 * @author Sven
 */
class StandardLinkModel extends DbModel
{
    public $prefix = 'standard_link_';

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
    }

    public function getAll($primaryKey = true)
    {
        $fields = "sid," . $this->getTable() . '.* ';
        return $this->getRows($fields, [], null, 'sid', 'asc', null, $primaryKey);
    }

    /**
     * 取得一个用户的基本信息
     * @return array
     */
    public function getLink()
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
        $fields = 'sid,' . $this->getTable() . '.* ';
        $where = array('sid' => $sid);
        $finally = $this->getRow($fields, $where);
        return $finally;
    }

    public function getByDetail($father_sid, $child_sid)
    {
        $fields = 'sid,' . $this->getTable() . '.* ';
        $where = array('father_sid' => $father_sid, 'child_sid' => $child_sid);
        $finally = $this->getRow($fields, $where);
        return $finally;
    }

    /**
     * 添加用户
     * @param array $userInfo 提交的用户信息
     * @return array
     */
    public function add($father_sid, $child_sid, $description)
    {
        $info = [];
        $info['father_sid'] = $father_sid;
        $info['child_sid'] = $child_sid;
        $info['description'] = $description;
        $ret = $this->insert($info);
        return [$ret, '操作成功'];
    }

}
