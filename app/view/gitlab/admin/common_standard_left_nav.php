<?php
if( !isset($left_nav_active) ){
    $left_nav_active = '';
}
if( !isset($sub_nav_active) ){
    $sub_nav_active = '';
}

?>

<aside aria-live="polite" class="js-right-sidebar left-sidebar right-sidebar-expanded affix-top"
       data-spy="affix" tabindex="0"  >
    <div class="issuable-sidebar">

        <div class="admin-menu-links">
            <div class="admin_left_header aui-nav-heading  <? if($sub_nav_active=='setting') echo 'active';?>"><strong>Standard Management</strong></div>
            <ul class="aui-nav" resolved="">
                <li class="<? if($left_nav_active=='edit') echo 'active';?>"><a href="<?=ROOT_URL?>admin/standard/pageEditStandards">Standard Edit</a>
                <li class="<? if($left_nav_active=='link') echo 'active';?>"><a href="<?=ROOT_URL?>admin/standard/pageEditLinks">Link Edit</a>
                </li>
            </ul>
            <div class="admin_left_header aui-nav-heading  <? if($sub_nav_active=='modify') echo 'active';?>"><strong>Standard Refine</strong></div>
            <ul class="aui-nav" resolved="">
                <? foreach ($available_standards as $standard) { ?>
                    <li class="<? if($left_nav_active==$standard['standard_name']) echo 'active';?>"><a href="<?=ROOT_URL?>admin/standard/updateIndex?standard=<? echo $standard['standard_name']; ?>"><? echo $standard['standard_name']; ?></a>
                    </li>
                <? } ?>
            </ul>

        </div>
    </div>
</aside>
