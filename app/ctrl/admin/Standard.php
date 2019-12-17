<?php

namespace main\app\ctrl\admin;

use main\app\classes\UserLogic;
use main\app\ctrl\BaseCtrl;
use main\app\ctrl\BaseAdminCtrl;
use main\app\model\standard\StandardModel;
use main\app\model\standard\StandardLinkModel;

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
        $data['available_standards'] = $this->fetchAllRoots();
        if (self::$standard == null) 
            self::$standard = $data['available_standards'][0]['standard_name'];
        $data['left_nav_active'] = self::$standard;
        $data['sub_nav_active'] = 'modify';
        $data['section'] = $this->fetchThisStandard(self::$standard);
        $data['edit_data'] = $this->fetchThisStandardFlat(self::$standard);
        $this->render('gitlab/admin/standards.php', $data);
    }

    public function pageEditLinks()
    {
        $data = [];
        $data['title'] = 'Users';
        $data['nav_links_active'] = 'standard';
        $data['sub_nav_active'] = 'setting';
        $data['left_nav_active'] = 'link';
        $data['available_standards'] = array_values($this->fetchAllRoots());
        $this->render('gitlab/admin/manage_standard_links.php', $data);
    }
    public function pageEditStandards()
    {
        $data = [];
        $data['title'] = 'Users';
        $data['nav_links_active'] = 'standard';
        $data['sub_nav_active'] = 'setting';
        $data['left_nav_active'] = 'edit';
        $data['available_standards'] = array_values($this->fetchAllRoots());
        $this->render('gitlab/admin/manage_standards.php', $data);
    }

    public function fetchAllLinks()
    {
        $standardLinkModel = new StandardLinkModel();
        return $standardLinkModel->getAll();
    }

    public function fetchThisStandardFlat($name)
    {
        $standardModel = new StandardModel();
        return $standardModel->flat($name);
    } 

    public function fetchThisStandard($name)
    {
        $standardModel = new StandardModel();
        return $standardModel->show($name);
    } 

    public function fetchAllRoots()
    {
        $standardModel = new StandardModel();
        $all = $standardModel->getAll();
        return $all;
    }

    public function fetchAllStandards()
    {
        $standardModel = new StandardModel();
        $all = $standardModel->show();
        return $all;
    }

    public function fetchStandards()
    {
        $data['available_standards'] = $this->fetchAllRoots();
        $this->ajaxSuccess('', $data);
    }

    /**
     * @param array $params
     * @throws \Exception
     */
    public function filterLink()
    {
        $data = [];
        $data['edit_data'] = $this->fetchAllStandards();
        $links = $this->fetchAllLinks();
        foreach ($links as &$link) {
            $model = new StandardModel();
            $father_parent = $model->getBySid((int) $link['father_sid']);
            $link['father'] = $father_parent;
            while($father_parent['parent_id'] != "0") {
                $father_parent = $model->getBySid((int) $father_parent['parent_id']);
            }
            $link['father']['standard'] = $father_parent['standard_name'];
            $child_parent = $model->getBySid((int) $link['child_sid']);
            $link['child'] = $child_parent;
            while($child_parent['parent_id'] != "0") {
                $child_parent = $model->getBySid((int) $child_parent['parent_id']);
            }
            $link['child']['standard'] = $child_parent['standard_name'];
        }
        $data['available_links'] = array_values($links);
        $this->ajaxSuccess('', $data);
    }

    public function addLink($params = [])
    {
        if (empty($params)) {
            $this->ajaxFailed('错误', '没有提交表单数据');
        }

        if (!isset($params['father_sid']) || !isset($params['child_sid'])) {
            $this->ajaxFailed('参数错误', '选择条目为空', BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }

        if (!isset($params['description'])) {
            $params['description'] = "No Description...";
        }

        $model = new StandardLinkModel();
        $history = $model->getByDetail($params['father_sid'], $params['child_sid']);
        if ($history != false) {
            $this->ajaxFailed('该条目已经存在', '该条目已经存在', BaseCtrl::AJAX_FAILED_TYPE_TIP);
        }

        list($ret, $msg) = $model->add($params['father_sid'], $params['child_sid'], $params['description']);
        if ($ret) {
            $this->ajaxSuccess('操作成功');
        } else {
            $this->ajaxFailed('服务器错误', '插入数据失败,详情:' . $msg);
        }

    }

    /**
     * @param array $params
     * @throws \Exception
     */
    public function filter($standard)
    {
        $data = [];
        $data['available_standards'] = $this->fetchAllRoots();
        $data['edit_data'] = $this->fetchThisStandardFlat($standard);
        $data['standard'] = $standard;
        $data['section'] = $this->fetchThisStandard($standard);
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

        if (isset($params['number']) && empty($params['number'])) {
            $errorMsg['number'] = '序号不能为空';
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

        $info['number'] = $params['number'];
        $model = new StandardModel();
        $group = $model->getBySid($id);
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
    public function deleteLink($id)
    {
        if (!isset($id)) {
            $this->ajaxFailed('参数错误', 'id不能为空');
        }
        $id = (int)$id;
        $model = new StandardLinkModel();
        $ret = $model->deleteById($id);
        if (!$ret) {
            $this->ajaxFailed('服务器错误', '删除失败');
        } else {
            $this->ajaxSuccess('操作成功');
        }
    }

    /**
     * @param $id
     * @throws \Exception
     */
    public function deleteLine($id)
    {
        if (!isset($id)) {
            $this->ajaxFailed('参数错误', 'id不能为空');
        }
        $id = (int)$id;
        $model = new StandardModel();
        $ret = $model->deleteNode($id);
        if (!$ret[0]) {
            $this->ajaxFailed('服务器错误', '删除失败');
        } else {
            $this->ajaxSuccess('操作成功');
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
    public function addLine($params = [])
    {
        if (empty($params)) {
            $this->ajaxFailed('参数错误', '参数不能为空');
        }

        if (empty($params["sid"])) {
            $this->ajaxFailed('参数错误', '添加位置不能为空');
        }

        if (empty($params["number"])) {
            $this->ajaxFailed('参数错误', '添加序号不能为空');
        }
        if (empty($params["name"])) {
            $this->ajaxFailed('参数错误', '添加信息不能为空');
        }
        if (!isset($params["description"])) {
            $params["description"] = 'Blank';
        }
        $sid = (int)$params["sid"];

        $model = new StandardModel();
        $ret = $model->addLine($sid, $params["name"], $params["description"], $params["number"], $params["standard"]);
        if ($ret[0])
            $this->ajaxSuccess('操作成功');
        else
            $this->ajaxFailed($ret[1], $ret[1]);
    }

    public function updateIndex($standard)
    {
        self::$standard = $standard;
        $this->pageIndex();
    }
}
