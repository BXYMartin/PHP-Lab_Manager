<?php

namespace main\app\model\issue;

use main\app\model\CacheModel;

/**
 *  描述模板模型
 *
 */
class IssueStandardPersonModel extends CacheModel
{
    public $prefix = 'issue_';

    public $table = 'standard_person';

    const   DATA_KEY = 'issue_standard_person/';

    public $fields = '*';

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

    public function updateById($id, $info)
    {
        return $this->updateById($id, $info);
    }

    public function deleteById($id)
    {
        return $this->deleteById($id);
    }

}
