
<div class="scrolling-tabs-container sub-nav-scroll">
    <div class="fade-left">
        <i class="fa fa-angle-left"></i>
    </div>
    <div class="fade-right">

    </div>

    <div class="nav-links sub-nav scrolling-tabs is-initialized">
        <ul class="container-fluid">
            <li class="filter_nav_li <? if($sys_filter=='' && empty($active_id)) echo 'active';?>">
                <a title="Audit Plans" href="<?=$issue_main_url?>"><span>Audit Plans</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='assignee_mine') echo 'active';?>">
                <a title="Audit Plans Assigned To Me" href="<?=$issue_main_url?>?sys_filter=assignee_mine">
                    <span>My Tasks</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='my_unsolved') echo 'active';?>">
                <a title="Unresolved Audit Plans Assigned To Me" href="<?=$issue_main_url?>?sys_filter=my_unsolved">
                    <span>My Unresolved Tasks</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='my_report') echo 'active';?>">
                <a title="My Reported Problems" href="<?=$issue_main_url?>?sys_filter=my_report"><span>My Reported Problems</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='open') echo 'active';?>">
                <a title="Plans With Opened Status" href="<?=$issue_main_url?>?sys_filter=open"><span>Opened Plans</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='unsolved') echo 'active';?>">
                <a title="Plans With Unsolved Status" href="<?=$issue_main_url?>?sys_filter=unsolved"><span>Unsolved Plans</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='active_sprint_unsolved') echo 'active';?>">
                <a title="Plans With Unsolved Status In Current Sprint" href="<?=$issue_main_url?>?sys_filter=active_sprint_unsolved"><span>Unsolved Plans In Current Sprint</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='done') echo 'active';?>">
                <a title="Plans With Finished Status" href="<?=$issue_main_url?>?sys_filter=done"><span>Finished</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='recently_create') echo 'active';?>">
                <a title="Sorted By Create Date" href="<?=$issue_main_url?>?sys_filter=recently_create"><span>Recently Created</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='recently_resolve') echo 'active';?>">
                <a title="Plans Recently Solved" href="<?=$issue_main_url?>?sys_filter=recently_resolve"><span>Recently Solved</span>
                </a>
            </li>
            <li class="filter_nav_li <? if($sys_filter=='recently_update') echo 'active';?>">
                <a title="Plans Recently Updated" href="<?=$issue_main_url?>?sys_filter=recently_update"><span>Recently Updated</span>
                </a>
            </li>
            <?php if( $favFilters) { ?>
            <li class="filter_nav_li  ">
                <a id="custom-filter-more" title="Favorite Filter <a>Manage</a>" href="#"><span>Custom Filter</span><i class="fa fa-caret-down"></i>
                </a>
            </li>
            <?php } ?>
        </ul>

    </div>

</div>
