<?php

namespace main\app\model\issue;

use main\app\model\DbModel;

/**
 *  描述模板模型
 *
 */
class IssueStandardDescModel extends DbModel
{
    public $prefix = 'issue_';

    public $table = 'standard_desc';

    const   DATA_KEY = 'issue_standard_desc/';

    public $fields = '*';

    public $primaryKey = 'sid';

    /**
     * 用于实现单例模式
     * @var self
     */
    protected static $instance;

    /**
     * 创建一个自身的单例对象
     * @param bool $persistent
     * @throws \PDOException
     * @return self
     */
    public static function getInstance($persistent = false)
    {
        $index = intval($persistent);
        if (!isset(self::$instance[$index]) || !is_object(self::$instance[$index])) {
            self::$instance[$index]  = new self($persistent);
        }
        return self::$instance[$index];
    }

    public function getByIssueId($issue_id)
    {
        $conditions['issue_id'] = $issue_id;
        $row = $this->getRow('*', $conditions);
        return $row;
    }

    public function getBySid($id)
    {
        $conditions['sid'] = $id;
        $row = $this->getRow('*', $conditions);
        return $row;
    }

    public function addItem($info)
    {
        return $this->insert($info);
    }

    public function updateItemById($id, $info)
    {
        $where = ['sid' => $id];
        return $this->update($info, $where);
    }

    public function deleteItemById($id)
    {
        $where = ['sid' => $id];
        return $this->delete($where);
    }

}
