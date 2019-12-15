<?php

namespace main\app\ctrl\admin;

use main\app\classes\UserLogic;
use main\app\ctrl\BaseCtrl;
use main\app\ctrl\BaseAdminCtrl;
use main\app\model\user\UserGroupModel;
use main\app\model\user\UserModel;
use main\app\model\user\GroupModel;
use main\app\model\standard\StandardModel;

/**
 * 标准管理
 */
class Standard extends BaseAdminCtrl
{

    static public $pageSizes = [20, 50, 100];
    static public $standard = null;

    public function pageIndex()
    {
        $data = [];
        $data['title'] = 'Users';
        $data['nav_links_active'] = 'standard';
        $data['available_standards'] = $this->fetchAllStandards();
        if (self::$standard == null) 
            self::$standard = $data['available_standards'][0];
        $data['left_nav_active'] = self::$standard;
        $data['sub_nav_active'] = 'modify';
        $this->render('gitlab/admin/standards.php', $data);
    }

    public function pageEditStandards()
    {
        $data = [];
        $data['title'] = 'Users';
        $data['nav_links_active'] = 'standard';
        $data['sub_nav_active'] = 'setting';
        $data['available_standards'] = array_values($this->fetchAllStandards());
        $this->render('gitlab/admin/manage_standards.php', $data);
    }

    public function fetchAllStandards()
    {
        $standardModel = new StandardModel();
        $all = $standardModel->getAll();
        return $all;
    }

    public function fetchStandards()
    {
        $data['available_standards'] = $this->fetchAllStandards();
        $this->ajaxSuccess('', $data);
    }

    /**
     * @param array $params
     * @throws \Exception
     */
    public function filter($params = [])
    {
        $page_size = intval($params['page_size']);
        if (!in_array($page_size, self::$pageSizes)) {
            $page_size = self::$pageSizes[0];
        }
        $name = trimStr($params['name']);
        $page = max(1, (int)$params['page']);

        $userLogic = new UserLogic();
        //  select g.* ,count(u.id) as cc from
        // main_group g left join user_group u on g.id=u.group_id
        //  group by u.group_id;
        list($rows, $total) = $userLogic->groupFilter($name, $page, $page_size);

        $data['groups'] = $rows;
        $data['total'] = (int)$total;
        $data['pages'] = max(1, ceil($total / $page_size));
        $data['page_size'] = (int)$page_size;
        $data['page'] = (int)$page;
        $this->ajaxSuccess('', $data);
    }

    public function get($id)
    {
        $id = (int)$id;
        $model = new StandardModel();
        $group = $model->getBySid($id);

        $this->ajaxSuccess('ok', (object)$group);
    }


    /**
     * 添加组
     * @param array $params
     */
    public function add($params = null)
    {
        if (empty($params)) {
            $this->ajaxFailed('错误', '没有提交表单数据');
        }

        if (!isset($params['name']) || empty($params['name'])) {
            $errorMsg['name'] = '参数错误';
        }

        if (isset($params['name']) && empty($params['name'])) {
            $errorMsg['name'] = 'name_is_empty';
        }

        if (!empty($errorMsg)) {
            $this->ajaxFailed('参数错误', $errorMsg, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }

        $info = [];
        $info['name'] = $params['name'];
        if (isset($params['description'])) {
            $info['description'] = $params['description'];
        }
        else {
            $info['description'] = "No Description...";
        }

        $model = new StandardModel();
        if (isset($model->getByName($info['name'])['sid'])) {
            $this->ajaxFailed('提示', '该名称已经被使用', BaseCtrl::AJAX_FAILED_TYPE_TIP);
        }

        list($ret, $msg) = $model->add($info['name'], $info['description']);
        if ($ret) {
            $this->ajaxSuccess('操作成功');
        } else {
            $this->ajaxFailed('服务器错误', '插入数据失败,详情:' . $msg);
        }
    }

    /**
     * @param $id
     * @param $params
     * @throws \Exception
     */
    public function update($id, $params)
    {
        $errorMsg = [];
        if (empty($params)) {
            $this->ajaxFailed('错误', '没有提交表单数据');
        }
        if (isset($params['name']) && empty($params['name'])) {
            $errorMsg['name'] = '名称不能为空';
        }

        if (!empty($errorMsg)) {
            $this->ajaxFailed('参数错误', $errorMsg, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }

        $id = (int)$id;

        $info = [];
        $info['standard_name'] = $params['name'];
        if (isset($params['description'])) {
            $info['description'] = $params['description'];
        }
        else {
            $info['description'] = "No Description...";
        }

        $model = new StandardModel();
        $group = $model->getByName($info['standard_name']);
        //var_dump($group);
        if (isset($group['sid']) && ($group['sid'] != $id)) {
            $this->ajaxFailed('name_exists', [], 600);
        }

        $ret = $model->updateById($id, $info);
        if ($ret[0]) {
            $this->ajaxSuccess('修改成功！');
        } else {
            $this->ajaxFailed('服务器错误,请重试', $ret, 500);
        }
    }

    /**
     * @param $id
     * @throws \Exception
     */
    public function delete($id)
    {
        if (!isset($id)) {
            $this->ajaxFailed('参数错误', 'id不能为空');
        }
        $id = (int)$id;
        $model = new StandardModel();
        $ret = $model->deleteById($id);
        if (!$ret[0]) {
            $this->ajaxFailed('服务器错误', '删除失败');
        } else {
            $this->ajaxSuccess('操作成功');
        }
    }

    /**
     * @param null $group_id
     * @param null $user_ids
     * @throws \Exception
     */
    public function addUser($group_id = null, $user_ids = null)
    {
        if (empty($group_id)) {
            $this->ajaxFailed('参数错误', '用户组不能为空');
        }

        if (empty($user_ids)) {
            $this->ajaxFailed('参数错误', '用户id不能为空');
        }
        if (is_string($user_ids)) {
            $user_ids = explode(',', $user_ids);
        }
        $group_id = (int)$group_id;

        $userModel = new UserGroupModel();
        foreach ($user_ids as $uid) {
            $userModel->add($uid, $group_id);
        }
        $this->ajaxSuccess('操作成功');
    }

    /**
     * @param null $group_id
     * @param null $uid
     * @throws \Exception
     */
    public function removeUser($group_id = null, $uid = null)
    {
        if (empty($uid)) {
            $this->ajaxFailed('参数错误', '用户id不能为空');
        }
        if (empty($group_id)) {
            $this->ajaxFailed('参数错误', '用户组id不能为空');
        }

        $userModel = new UserGroupModel();
        $group_id = (int)$group_id;
        $uid = (int)$uid;
        $ret = $userModel->deleteByGroupIdUid($group_id, $uid);
        if (!$ret) {
            $this->ajaxFailed('服务器错误', '删除失败');
        } else {
            $this->ajaxSuccess('操作成功');
        }
    }

    public function updateIndex($standard)
    {
        self::$standard = $standard;
        $this->pageIndex();
    }
}
