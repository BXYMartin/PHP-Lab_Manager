<?php

namespace main\app\ctrl\admin;

use main\app\ctrl\BaseAdminCtrl;
use main\app\model\issue\IssueModel;
use main\app\model\issue\IssueTypeModel;
use main\app\model\project\ProjectModel;
use main\app\model\ActivityModel;
use main\app\model\project\ProjectLabelModel;
use main\app\model\project\ProjectUserRoleModel;
use main\app\model\project\ProjectVersionModel;
use main\app\model\project\ProjectModuleModel;
use main\app\classes\ProjectLogic;
use main\app\classes\UserAuth;
use main\app\classes\UserLogic;
use main\app\classes\PermissionLogic;
use main\app\classes\SystemLogic;
use main\app\classes\ConfigLogic;
use main\app\classes\IssueFilterLogic;
use main\app\ctrl\BaseCtrl;
use main\app\model\project\ProjectRoleModel;
use main\app\model\user\UserGroupModel;
use main\app\model\user\UserModel;
use main\app\model\user\GroupModel;

/**
 * 系统管理的项目模块
 */
class Remark extends BaseAdminCtrl
{
    public static $page_sizes = [10, 20, 50, 100];

    public function pageIndex()
    {
        $data = [];

        // $data['list'] = $list;
        $data['title'] = 'Remarks';
        $data['nav_links_active'] = 'remark';
        $data['left_nav_active'] = 'list';
        $this->render('gitlab/admin/remark.php', $data);
    }

    /**
     * 获取关联用户的项目数据
     * @throws \Exception
     */
    public function gets()
    {
        $projectLogic = new ProjectLogic();
        $rows = $projectLogic->projectListJoinUser();
        $this->ajaxSuccess('ok', $rows);
    }


    /**
     * 项目查询
     * @param int $page
     * @throws \Exception
     */
    public function filterDateData($month = 0)
    {
        $firstDayCode = strtotime(date("Y-m-01 ") . $month . " month");
        $firstDay = date("Y-m-d ", $firstDayCode);
        $lastDayCode = strtotime("$firstDay +1 month -1 day");
        $lastDay = date(" Y-m-d ", $lastDayCode);

        $data['date'] = $firstDay."~".$lastDay;
        $this->ajaxSuccess('操作成功', $data);
    }

    /**
     * 项目查询
     * @param int $page
     * @throws \Exception
     */
    public function filterHeaderData()
    {
        $issueType = new IssueTypeModel();
        $allIssue = $issueType->getAllItem();

        $data['issues'] = array_values($allIssue);
        $this->ajaxSuccess('操作成功', $data);
    }

    /**
     * 项目查询
     * @param int $page
     * @throws \Exception
     */
    public function filterData($month = 0, $page = 1)
    {
        $pageLength = 30;


        $data['total'] = count($projects);
        $data['page'] = $page;
        $data['pages'] = $pageLength;

        $userLogic = new UserLogic();
        $ret = $userLogic->getAllNormalUser();
        $data['users'] = array_values($ret);
        $issueFilterLogic = new IssueFilterLogic();

        foreach($data['users'] as &$item) {
            [$rows, $count] = $issueFilterLogic->getsByResolveAssignee($item['uid'], $data['page'], $data['pages']);
            $firstDayCode = strtotime(date("Y-m-01 ") . $month . " month");
            $firstDay = date("Y-m-d", $firstDayCode);
            $lastDayCode = strtotime("$firstDay +1 month -1 day");
            $sCount = 0;
            $issueType = new IssueTypeModel();
            $allIssue = $issueType->getAllItem();
            foreach ($allIssue as $issue) {
                $list['count'] = 0;
                $item['issues'][$issue['name']] = $list;
            }
            foreach ($rows as $everyone) {
                $issueDay = strtotime($everyone['start_date']);
                if ($issueDay >= $firstDayCode 
                    and $issueDay <= $lastDayCode) {
                    $sCount++;
                    foreach ($allIssue as $issue) {
                        if ($everyone['issue_type'] == $issue['id']) {
                            $item['issues'][$issue['name']]['count']++;
                        }
                    }
                }
            }
            $item['issues'] = array_values($item['issues']);
            $item['issue'] = $sCount;
        }

        $projectLogic = new ProjectLogic();
        $projects = $projectLogic->projectListJoinUser();
        foreach ($data['users'] as &$item) {
            $pCount = 0;
            foreach ($projects as &$project) {
                if ($item['uid'] == $project['lead'])
                    $pCount++;
            }
            $item['project'] = $pCount;
        }

        $this->ajaxSuccess('操作成功', $data);
    }


    /**
     * 更新
     * @param $params
     * @throws \Exception
     */
    public function update($params)
    {
        $projectId = null;
        if (isset($_GET['_target'][3])) {
            $projectId = (int)$_GET['_target'][3];
        }
        if (isset($_REQUEST['project_id'])) {
            $projectId = (int)$_REQUEST['project_id'];
        }
        if (empty($projectId)) {
            $this->ajaxFailed('参数错误', '项目id不能为空');
        }
        // @todo 全局权限
        $model = new ProjectModel();
        $ret = $model->updateById($projectId, $params);

        if (!$ret) {
            $this->ajaxFailed('服务器错误', '更新数据失败');
        } else {
            $this->ajaxSuccess('操作成功');
        }
    }


    /**
     * 删除项目
     * @throws \Exception
     */
    public function delete()
    {
        $projectId = null;
        $projectTypeId = null;

        if (isset($_GET['_target'][3])) {
            $projectId = (int)$_GET['_target'][3];
        }
        if (isset($_REQUEST['project_id'])) {
            $projectId = (int)$_REQUEST['project_id'];
        }
        if (empty($projectId)) {
            $this->ajaxFailed('参数错误', '项目id不能为空');
        }


        if (isset($_REQUEST['project_type_id'])) {
            $projectTypeId = (int)$_REQUEST['project_type_id'];
        }
        if (empty($projectTypeId)) {
            $this->ajaxFailed('参数错误', '项目类型id不能为空');
        }

        $currentUid = $uid = UserAuth::getId();
        $model = $projectModel = new ProjectModel($uid);
        $project = $projectModel->getById($projectId);

        $model->db->beginTransaction();

        $retDelProject = $model->deleteById($projectId);
        if ($retDelProject) {
            // 删除对应的事项
            $issueModel = new IssueModel();
            $issueModel->deleteItemsByProjectId($projectId);

            // 删除版本
            $projectVersionModel = new ProjectVersionModel($uid);
            $projectVersionModel->deleteByProject($projectId);

            // 删除模块
            $projectModuleModel = new ProjectModuleModel($uid);
            $projectModuleModel->deleteByProject($projectId);

            // @todo 删除标签

            // @todo 删除初始化的角色

            $activityModel = new ActivityModel();
            $activityInfo = [];
            $activityInfo['action'] = '删除了项目';
            $activityInfo['type'] = ActivityModel::TYPE_PROJECT;
            $activityInfo['obj_id'] = $projectId;
            $activityInfo['title'] = $project['name'];
            $activityModel->insertItem($currentUid, $projectId, $activityInfo);
        }

        $model->db->commit();
        $this->ajaxSuccess('操作成功');
    }
}
