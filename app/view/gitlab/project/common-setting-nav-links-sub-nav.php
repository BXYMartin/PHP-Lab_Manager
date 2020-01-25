
<div class="scrolling-tabs-container sub-nav-scroll">
    <div class="fade-left">
        <i class="fa fa-angle-left"></i>
    </div>
    <div class="fade-right">
        <i class="fa fa-angle-right"></i>
    </div>

    <div class="nav-links sub-nav scrolling-tabs is-initialized">
        <ul class="container-fluid">
            <li class="<? if($sub_nav_active=='basic_info') echo 'active';?>">
                <a title="General" href="<?=$project_root_url?>/settings_profile">
                    <span>Basic Info</span>
                </a>
            </li>
            <li class="<? if($sub_nav_active=='issue_type') echo 'active';?>">
                <a title="事项类型" href="<?=$project_root_url?>/settings_issue_type">
                    <span>Task Type</span>
                </a>
            </li>
            <li class="<? if($sub_nav_active=='version') echo 'active';?>">
                <a title="版 本" href="<?=$project_root_url?>/settings_version">
                    <span>Version</span>
                </a>
            </li>
            <li class="<? if($sub_nav_active=='module') echo 'active';?>">
                <a title="模 块" href="<?=$project_root_url?>/settings_module">
                    <span>Module</span>
                </a>
            </li>
            <li class="<? if($sub_nav_active=='label') echo 'active';?>">
                <a title="标 签" href="<?=$project_root_url?>/settings_label">
                    <span>Label</span>
                </a>
            </li>
            <!--li class="<? if($sub_nav_active=='permission') echo 'active';?>">
                <a title="权 限" href="<?=$project_root_url?>/settings_permission">
                    <span>权 限</span>
                </a>
            </li-->

            <li class="<? if($sub_nav_active=='project_member') echo 'active';?>">
                <a title="项目成员" href="<?=$project_root_url?>/settings_project_member"><span>Audit Member</span>
                </a>
            </li>
            <li class="<? if($sub_nav_active=='project_role') echo 'active';?>">
                <a title="项目角色" href="<?=$project_root_url?>/settings_project_role"><span>Audit Role</span>
                </a>
            </li>
        </ul>
    </div>
</div>
