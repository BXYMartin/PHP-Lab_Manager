<?php
/**
 * Created by PhpStorm.
 */

namespace main\app\ctrl\project;

use main\app\classes\LogOperatingLogic;
use main\app\classes\PermissionLogic;
use main\app\classes\UserAuth;
use main\app\classes\UserLogic;
use main\app\classes\IssueFilterLogic;
use main\app\ctrl\Agile;
use main\app\ctrl\BaseCtrl;
use main\app\ctrl\issue\Main as IssueMain;
use main\app\model\OrgModel;
use main\app\model\ActivityModel;
use main\app\model\project\ProjectLabelModel;
use main\app\model\project\ProjectMainExtraModel;
use main\app\model\project\ProjectModel;
use main\app\model\agile\SprintModel;
use main\app\model\project\ProjectModuleModel;
use main\app\classes\SettingsLogic;
use main\app\classes\ProjectLogic;
use main\app\classes\RewriteUrl;
use main\app\model\user\UserModel;

/**
 * 项目
 */
class Main extends Base
{
    /**
     * Main constructor.
     * @throws \Exception
     */
    public function __construct()
    {
        parent::__construct();
        parent::addGVar('top_menu_active', 'project');
    }

    public function pageIndex()
    {
    }

    /**
     * @throws \Exception
     */
    public function pageNew()
    {
        $orgModel = new OrgModel();
        $orgList = $orgModel->getAllItems();

        $userLogic = new UserLogic();
        $users = $userLogic->getAllNormalUser();
        $data = [];
        $data['title'] = 'Create Company';
        $data['sub_nav_active'] = 'project';
        $data['users'] = $users;

        $data['org_list'] = $orgList;
        $data['full_type'] = ProjectLogic::faceMap();

        $data['project_name_max_length'] = (new SettingsLogic)->maxLengthProjectName();
        $data['project_key_max_length'] = (new SettingsLogic)->maxLengthProjectKey();

        $this->render('gitlab/project/main_form.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageHome()
    {
        $data = [];

        $data['nav_links_active'] = 'home';
        $data['sub_nav_active'] = 'profile';
        $data['scrolling_tabs'] = 'home';
        $data = RewriteUrl::setProjectData($data);
        $data['title'] = $data['project_name'];
        // 权限判断
        if (!empty($data['project_id'])) {
            $data['issue_main_url'] = ROOT_URL . substr($data['project_root_url'], 1) . '/issues';
            if (!$this->isAdmin && !PermissionLogic::checkUserHaveProjectItem(UserAuth::getId(), $data['project_id'])) {
                $this->warn('Warning', 'You don\'t have access to this project, please contact administrator for permission!');
                die;
            }
        }

        $projectMainExtraModel = new ProjectMainExtraModel();
        $projectExtraInfo = $projectMainExtraModel->getByProjectId($data['project_id']);

        if (empty($projectExtraInfo)) {
            $data['project']['detail'] = '';
        } else {
            $data['project']['detail'] = $projectExtraInfo['detail'];
        }

        $userLogic = new UserLogic();
        $userList = $userLogic->getUsersAndRoleByProjectId($data['project_id']);
        $data['members'] = $userList;

        $this->render('gitlab/project/home.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageProfile()
    {
        $this->pageHome();
    }

    /**
     * @throws \Exception
     */
    public function pageIssueType()
    {
        $data = [];
        $data['nav_links_active'] = 'home';
        $data['sub_nav_active'] = 'issue_type';
        $data['scrolling_tabs'] = 'home';
        $data = RewriteUrl::setProjectData($data);

        // 权限判断
        if (!empty($data['project_id'])) {
            if (!$this->isAdmin && !PermissionLogic::checkUserHaveProjectItem(UserAuth::getId(), $data['project_id'])) {
                $this->warn('Warning', 'You don\'t have access to this project, please contact administrator for permission!');
                die;
            }
        }
        $projectLogic = new ProjectLogic();
        $list = $projectLogic->typeList($data['project_id']);
        $data['title'] = 'Task Type - ' . $data['project_name'];
        $data['list'] = $list;

        $this->render('gitlab/project/issue_type.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageVersion()
    {
        $projectModel = new ProjectModel();
        $projectName = $projectModel->getNameById($_GET[ProjectLogic::PROJECT_GET_PARAM_ID]);

        $data = [];
        $data['title'] = 'Version - ' . $projectName['name'];
        $data['nav_links_active'] = 'home';
        $data['sub_nav_active'] = 'version';
        $data['scrolling_tabs'] = 'home';

        $data['query_str'] = http_build_query($_GET);
        $data = RewriteUrl::setProjectData($data);

        $this->render('gitlab/project/version.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageModule()
    {
        $userLogic = new UserLogic();
        $users = $userLogic->getAllNormalUser();

        $projectModuleModel = new ProjectModuleModel();
        $count = $projectModuleModel->getAllCount($_GET[ProjectLogic::PROJECT_GET_PARAM_ID]);

        $projectModel = new ProjectModel();
        $projectName = $projectModel->getNameById($_GET[ProjectLogic::PROJECT_GET_PARAM_ID]);

        $data = [];
        $data['title'] = 'Module - ' . $projectName['name'];
        $data['nav_links_active'] = 'home';
        $data['sub_nav_active'] = 'module';
        $data['users'] = $users;
        $data['query_str'] = http_build_query($_GET);
        $data['count'] = $count;

        $data = RewriteUrl::setProjectData($data);

        $this->render('gitlab/project/module.php', $data);
    }

    /**
     * 跳转至事项页面
     * @throws \Exception
     */
    public function pageIssues()
    {
        $issueMainCtrl = new IssueMain();
        $issueMainCtrl->pageIndex();
    }

    /**
     * backlog页面
     * @throws \Exception
     */
    public function pageBacklog()
    {
        $agileCtrl = new Agile();
        $agileCtrl->pageBacklog();
    }

    /**
     * Sprints页面
     * @throws \Exception
     */
    public function pageSprints()
    {
        $agileCtrl = new Agile();
        $agileCtrl->pageSprint();
    }

    /**
     * Kanban页面
     * @throws \Exception
     */
    public function pageKanban()
    {
        $agileCtrl = new Agile();
        $agileCtrl->pageBoard();
    }

    /**
     * 设置页面
     * @throws \Exception
     */
    public function pageSettings()
    {
        $this->pageSettingsProfile();
    }

    /**
     * @throws \Exception
     */
    public function pageChart()
    {
        $chartCtrl = new Chart();
        $chartCtrl->pageProject();
    }

    /**
     * @throws \Exception
     */
    public function pageChartSprint()
    {
        $chartCtrl = new Chart();
        $chartCtrl->pageSprint();
    }


    /**
     * @todo 此处有bug, 不能即是页面有时ajax的处理
     * @throws \Exception
     */
    public function pageSettingsProfile()
    {
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }
        $projectModel = new ProjectModel();
        $info = $projectModel->getById($_GET[ProjectLogic::PROJECT_GET_PARAM_ID]);

        $projectMainExtra = new ProjectMainExtraModel();
        $infoExtra = $projectMainExtra->getByProjectId($info['id']);
        if ($infoExtra) {
            $info['detail'] = $infoExtra['detail'];
        } else {
            $info['detail'] = '';
        }


        $orgModel = new OrgModel();
        $orgList = $orgModel->getAllItems();
        $data['org_list'] = $orgList;

        $orgName = $orgModel->getOne('name', array('id' => $info['org_id']));
        $data['title'] = 'Settings';
        $data['nav_links_active'] = 'setting';
        $data['sub_nav_active'] = 'basic_info';

        //$data['users'] = $users;
        $info['org_name'] = $orgName;
        $data['info'] = $info;
        $data['full_type'] = ProjectLogic::faceMap();

        $data = RewriteUrl::setProjectData($data);

        $this->render('gitlab/project/setting_basic_info.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageSettingsIssueType()
    {
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }

        $projectLogic = new ProjectLogic();
        $list = $projectLogic->typeList($_GET[ProjectLogic::PROJECT_GET_PARAM_ID]);

        $data = [];
        $data['title'] = 'Task Type';
        $data['nav_links_active'] = 'setting';
        $data['sub_nav_active'] = 'issue_type';

        $data['list'] = $list;

        $data = RewriteUrl::setProjectData($data);

        // 空数据
        $data['empty_data_msg'] = 'Empty customer type';
        $data['empty_data_status'] = 'list';  // bag|list|board|error|gps|id|off-line|search
        $data['empty_data_show_button'] = false;

        $this->render('gitlab/project/setting_issue_type.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageSettingsVersion()
    {
        // $projectVersionModel = new ProjectVersionModel();
        // $list = $projectVersionModel->getByProject($_GET[ProjectLogic::PROJECT_GET_PARAM_ID]);
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }
        $data = [];
        $data['title'] = 'Version';
        $data['nav_links_active'] = 'setting';
        $data['sub_nav_active'] = 'version';

        $data['query_str'] = http_build_query($_GET);

        $data = RewriteUrl::setProjectData($data);

        $this->render('gitlab/project/setting_version.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageSettingsModule()
    {
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }

        $userLogic = new UserLogic();
        $users = $userLogic->getAllNormalUser();

        $projectModuleModel = new ProjectModuleModel();
        //$list = $projectModuleModel->getByProjectWithUser($_GET[ProjectLogic::PROJECT_GET_PARAM_ID]);
        $count = $projectModuleModel->getAllCount($_GET[ProjectLogic::PROJECT_GET_PARAM_ID]);

        $data = [];
        $data['title'] = 'Module';
        $data['nav_links_active'] = 'setting';
        $data['sub_nav_active'] = 'module';
        $data['users'] = $users;
        $data['query_str'] = http_build_query($_GET);
        //$data['list'] = $list;
        $data['count'] = $count;

        $data = RewriteUrl::setProjectData($data);
        $this->render('gitlab/project/setting_module.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageSettingsLabel()
    {
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }

        $data = [];
        $data['title'] = 'Label';
        $data['nav_links_active'] = 'setting';
        $data['sub_nav_active'] = 'label';
        $data['query_str'] = http_build_query($_GET);

        $data = RewriteUrl::setProjectData($data);
        $this->render('gitlab/project/setting_label.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageSettingsLabelNew()
    {
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }
        $data = [];
        $data['title'] = 'Label';
        $data['nav_links_active'] = 'setting';
        $data['sub_nav_active'] = 'label';
        $data['query_str'] = http_build_query($_GET);
        $data = RewriteUrl::setProjectData($data);
        $this->render('gitlab/project/setting_label_new.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageSettingsLabelEdit()
    {
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }

        $id = isset($_GET['id']) && !empty($_GET['id']) ? intval($_GET['id']) : 0;
        if ($id > 0) {
            $projectLabelModel = new ProjectLabelModel();
            $info = $projectLabelModel->getById($id);

            $data = [];
            $data['title'] = 'Label';
            $data['nav_links_active'] = 'setting';
            $data['sub_nav_active'] = 'label';

            $data['query_str'] = http_build_query($_GET);
            $data = RewriteUrl::setProjectData($data);

            $data['row'] = $info;
            $this->render('gitlab/project/setting_label_edit.php', $data);
        } else {
            echo 404;
            exit;
        }
    }

    /**
     * @throws \Exception
     */
    public function pageSettingsPermission()
    {
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }

        $data = [];
        $data['title'] = 'Permission';
        $data['nav_links_active'] = 'setting';
        $data['sub_nav_active'] = 'permission';
        $data = RewriteUrl::setProjectData($data);
        $this->render('gitlab/project/setting_permission.php', $data);
    }

    /**
     * @throws \Exception
     */
    public function pageSettingsProjectMember()
    {
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }

        $memberCtrl = new Member();
        $memberCtrl->pageIndex();
    }

    /**
     * @throws \Exception
     */
    public function pageSettingsProjectRole()
    {
        if (!isset($this->projectPermArr[PermissionLogic::ADMINISTER_PROJECTS])) {
            $this->warn('Warning', 'This page is only available for project administrators!');
            die;
        }

        $roleCtrl = new Role();
        $roleCtrl->pageIndex();
    }

    /**
     * @throws \Exception
     */
    public function pageActivity()
    {
        $data = [];
        $data['title'] = 'Activity';
        $data['top_menu_active'] = 'time_line';
        $data['nav_links_active'] = 'home';
        $data['scrolling_tabs'] = 'activity';

        $this->render('gitlab/project/activity.php', $data);
    }

    /**
     * 项目统计页面
     * @throws \Exception
     */
    public function pageStat()
    {
        $statCtrl = new  Stat();
        $statCtrl->pageIndex();
    }

    /**
     * 迭代统计页面
     * @throws \Exception
     */
    public function pageStatSprint()
    {
        $statCtrl = new  StatSprint();
        $statCtrl->pageIndex();
    }

    /**
     * 获取项目信息
     * @param $id
     * @throws \Exception
     */
    public function fetch($id)
    {
        $id = intval($id);
        // 权限判断
        if (!empty($id)) {
            if (!$this->isAdmin && !PermissionLogic::checkUserHaveProjectItem(UserAuth::getId(), $id)) {
                $this->ajaxFailed('Permission Error', 'You don\'t have access to this project, please contact administrator for permission');
            }
        }
        $projectModel = new ProjectModel();
        $project = $projectModel->getById($id);
        if (empty($project)) {
            $project = new \stdClass();
            $this->ajaxSuccess('ok', $project);
        }

        $projectMainExtraModel = new ProjectMainExtraModel();
        $projectExtraInfo = $projectMainExtraModel->getByProjectId($id);
        if (empty($projectExtraInfo)) {
            $project['detail'] = '';
        } else {
            $project['detail'] = $projectExtraInfo['detail'];
        }

        $project['count'] = IssueFilterLogic::getCount($id);
        $project['no_done_count'] = IssueFilterLogic::getNoDoneCount($id);
        $sprintModel = new SprintModel();
        $project['sprint_count'] = $sprintModel->getCountByProject($id);
        $project = ProjectLogic::formatProject($project);
        $this->ajaxSuccess('ok', $project);
    }


    /**
     * 新增项目
     * @param array $params
     * @throws \Exception
     */
    public function create($params = array())
    {
        if (!$this->isAdmin) {
            $this->ajaxFailed('Permission Error', 'You don\'t have permission to create customer');
        }

        if (empty($params)) {
            $this->ajaxFailed('Error', 'No data available');
        }

        $err = [];
        $uid = $this->getCurrentUid();
        $projectModel = new ProjectModel($uid);
        $settingLogic = new SettingsLogic;
        $maxLengthProjectName = $settingLogic->maxLengthProjectName();
        $maxLengthProjectKey = $settingLogic->maxLengthProjectKey();

        if (!isset($params['name'])) {
            $err['Customer Name'] = 'Customer Name Unset';
        }
        if (isset($params['name']) && empty(trimStr($params['name']))) {
            $err['Customer Name'] = 'Empty Customer Name';
        }
        if (isset($params['name']) && strlen($params['name']) > $maxLengthProjectName) {
            $err['Customer Name'] = 'Customer Name Too Long, No Longer Than ' . $maxLengthProjectName;
        }
        if (isset($params['name']) && $projectModel->checkNameExist($params['name'])) {
            $err['Customer Name'] = 'Customer Name Exist';
        }

        if (!isset($params['org_id'])) {
            //$err['org_id'] = '请选择一个组织';
            $params['org_id'] = 1; // 临时使用id为1的默认组织
        } elseif (isset($params['org_id']) && empty(trimStr($params['org_id']))) {
            $err['组织'] = 'Empty Organization';
        }

        if (!isset($params['key'])) {
            $err['Customer Key'][] = 'Customer Key Unset';
        }
        if (isset($params['key']) && empty(trimStr($params['key']))) {
            $err['Customer Key'][] = 'Empty Customer Key';
        }
        if (isset($params['key']) && strlen($params['key']) > $maxLengthProjectKey) {
            $err['Customer Key'][] = 'Customer Key Too Long, No Longer Than ' . $maxLengthProjectKey;
        }
        if (isset($params['key']) && $projectModel->checkKeyExist($params['key'])) {
            $err['Customer Key'][] = 'Customer Key Exists';
        }
        if (isset($params['key']) && !preg_match("/^[a-zA-Z0-9]+$/", $params['key'])) {
            $err['Customer Key'][] = 'Only Numbers and Letters are allowed for Customer Key';
        }

        $userModel = new UserModel();
        if (!isset($params['lead'])) {
            $err['Assignee'] = 'Please Select Assignee';
        } elseif (isset($params['lead']) && intval($params['lead']) <= 0) {
            $err['Assignee'] = 'Please Select Assignee';
        } elseif (empty($userModel->getByUid($params['lead']))) {
            $err['Assignee'] = 'Wrong Assignee';
        }

        if (!isset($params['type'])) {
            $err['Customer Type'] = 'Please Select Customer Type';
        } elseif (isset($params['type']) && empty(trimStr($params['type']))) {
            $err['Customer Type'] = 'Empty Customer Type';
        }

        if (!empty($err)) {
            $txt = "Error Occurred:";
            foreach ($err as $key => $value) {

                $txt = $txt . "<br>- " . $key;
                if (is_array($value)) {
                    foreach ($value as $item)
                        $txt = $txt . "<br> · " . $item;
                }
                else {
                    $txt = $txt . "<br> · " . $value;
                }
            }
            $this->ajaxFailed($txt, $err, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }

        //$params['key'] = mb_strtoupper(trimStr($params['key']));
        $params['key'] = trimStr($params['key']);
        $params['name'] = trimStr($params['name']);
        $params['type'] = intval($params['type']);

        if (!isset($params['lead']) || empty($params['lead'])) {
            $params['lead'] = $uid;
        }

        $info = [];
        $info['name'] = $params['name'];
        $info['org_id'] = $params['org_id'];
        $info['key'] = $params['key'];
        $info['lead'] = $params['lead'];
        $info['description'] = $params['description'];
        $info['type'] = $params['type'];
        $info['category'] = 0;
        $info['url'] = isset($params['url']) ? $params['url'] : '';
        $info['create_time'] = time();
        $info['create_uid'] = $uid;
        $info['avatar'] = !empty($params['avatar_relate_path']) ? $params['avatar_relate_path'] : '';
        $info['detail'] = isset($params['detail']) ? $params['detail'] : '';
        //$info['avatar'] = !empty($avatar) ? $avatar : "";

        $projectModel->db->beginTransaction();

        $orgModel = new OrgModel();
        $orgInfo = $orgModel->getById($params['org_id']);

        $info['org_path'] = $orgInfo['path'];

        $ret = ProjectLogic::create($info, $uid);
        //$ret['errorCode'] = 0;
        $final = array(
            'project_id' => $ret['data']['project_id'],
            'key' => $params['key'],
            'org_name' => $orgInfo['name'],
            'path' => $orgInfo['path'] . '/' . $params['key'],
        );
        if (!$ret['errorCode']) {
            // 初始化项目角色
            list($flagInitRole, $roleInfo) = ProjectLogic::initRole($ret['data']['project_id']);
            // 把项目负责人赋予该项目的管理员权限
            list($flagAssignAdminRole) = ProjectLogic::assignAdminRoleForProjectLeader($ret['data']['project_id'], $info['lead']);

            //写入操作日志
            $logData = [];
            $logData['user_name'] = $this->auth->getUser()['username'];
            $logData['real_name'] = $this->auth->getUser()['display_name'];
            $logData['obj_id'] = 0;
            $logData['module'] = LogOperatingLogic::MODULE_NAME_PROJECT;
            $logData['page'] = $_SERVER['REQUEST_URI'];
            $logData['action'] = LogOperatingLogic::ACT_ADD;
            $logData['remark'] = 'Created Customer';
            $logData['pre_data'] = [];
            $logData['cur_data'] = $info;
            LogOperatingLogic::add($uid, 0, $logData);

            if ($flagInitRole && $flagAssignAdminRole) {
                $projectModel->db->commit();

                $currentUid = $this->getCurrentUid();
                $activityModel = new ActivityModel();
                $activityInfo = [];
                $activityInfo['action'] = 'Created Customer';
                $activityInfo['type'] = ActivityModel::TYPE_PROJECT;
                $activityInfo['obj_id'] = $ret['data']['project_id'];
                $activityInfo['title'] = $info['name'];
                $activityModel->insertItem($currentUid, $ret['data']['project_id'], $activityInfo);

                $this->ajaxSuccess('Successfully Created Customer', $final);
            } else {
                $projectModel->db->rollBack();
                $this->ajaxFailed('Error', 'Project Role Insertion Failed: ' . $roleInfo);
            }
        } else {
            $projectModel->db->rollBack();
            $this->ajaxFailed('Error', 'Insertion Failed: ' . $ret['msg']);
        }
    }

    /**
     * 更新
     * 注意：该方法未使用,可以删除该方法
     * @param $project_id
     * @throws \Exception
     */
    public function update($project_id)
    {
        // 判断权限:全局权限和项目角色
        if (!isset($this->projectPermArr[PermissionLogic::BROWSE_ISSUES])) {
            $this->ajaxFailed('Permission Error', 'Requires project administrator to operate');
        }

        $uid = $this->getCurrentUid();
        $projectModel = new ProjectModel($uid);
        // $this->param_valid($projectModel, $name, $key, $type);

        $key = null;
        $projectId = intval($project_id);
        $err = [];
        $info = [];
        if (isset($_REQUEST['name'])) {
            $name = trimStr($_REQUEST['name']);
            if ($projectModel->checkIdNameExist($projectId, $name)) {
                $err['name'] = 'Customer name already exists';
            }
            $info['name'] = trimStr($_REQUEST['name']);
        }
        if (isset($_REQUEST['key'])) {
            $key = trimStr($_REQUEST['key']);
            if ($projectModel->checkIdKeyExist($projectId, $key)) {
                $err['key'] = 'Customer key already exists';
            }
            $info['key'] = trimStr($_REQUEST['key']);
        }

        if (!empty($err)) {
            $this->ajaxFailed('Error', $err, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }

        if (isset($_REQUEST['type'])) {
            $info['type'] = intval($_REQUEST['type']);
        }
        if (isset($_REQUEST['lead'])) {
            $info['lead'] = intval($_REQUEST['lead']);
        }
        if (isset($_REQUEST['description'])) {
            $info['description'] = $_REQUEST['description'];
        }
        if (isset($_REQUEST['category'])) {
            $info['category'] = (int)$_REQUEST['category'];
        }
        if (isset($_REQUEST['url'])) {
            $info['url'] = $_REQUEST['url'];
        }
        if (isset($_REQUEST['avatar'])) {
            $info['avatar'] = $_REQUEST['avatar'];
        }
        if (empty($info)) {
            $this->ajaxFailed('Parameter Error', 'No data available');
        }
        $project = $projectModel->getRowById($projectId);
        $ret = $projectModel->updateById($projectId, $info);
        if ($ret[0]) {
            if ($project['key'] != $key) {
                // @todo update issue key
            }
            $currentUid = $this->getCurrentUid();
            $activityModel = new ActivityModel();
            $activityInfo = [];
            $activityInfo['action'] = 'Updated Details of';
            $activityInfo['type'] = ActivityModel::TYPE_PROJECT;
            $activityInfo['obj_id'] = $projectId;
            $activityInfo['title'] = $project['name'];
            $activityModel->insertItem($currentUid, $projectId, $activityInfo);

            $this->ajaxSuccess('Successfully Updated Details');
        } else {
            $this->ajaxFailed('Error', 'Insertion Failed: ' . $ret[1]);
        }
    }
}
