<ul class="nav-links center user-profile-nav scrolling-tabs">
    <li class="js-activity-tab  <? if($profile_nav=='activity'){ echo 'active';} ?>">
        <a href="<?=ROOT_URL?>user/profile/<?=$user_id?>"><i class="fa fa-calculator" ></i> Activity Log</a>
    </li>

    <li class="js-projects-tab <? if($profile_nav=='have_join_projects'){ echo 'active';} ?>">
        <a  href="<?=ROOT_URL?>user/have_join_projects/<?=$user_id?>"><i class="fa fa-product-hunt" ></i> Involved Project</a>
    </li>
    <li class="js-groups-tab <? if($profile_nav=='log_operation'){ echo 'active';} ?>">
        <a href="<?=ROOT_URL?>user/log_operation/<?=$user_id?>"><i class="fa fa-archive" ></i> Operation Log</a>
    </li>

</ul>
