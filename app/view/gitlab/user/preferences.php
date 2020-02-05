<!DOCTYPE html>
<html class="" lang="en">
<head  >

    <? require_once VIEW_PATH.'gitlab/common/header/include.php';?>
    <script src="<?=ROOT_URL?>gitlab/assets/webpack/profile.56fab56f950907c5b67a.bundle.js"></script>
    <script src="<?=ROOT_URL?>dev/lib/handlebars-v4.0.10.js" type="text/javascript" charset="utf-8"></script>

</head>
<body class="" data-group="" data-page="profiles:show" data-project="">
<? require_once VIEW_PATH.'gitlab/common/body/script.php';?>

<section class="has-sidebar page-layout max-sidebar">
    <? require_once VIEW_PATH . 'gitlab/common/body/page-left.php'; ?>

    <div class="page-layout page-content-body background-white">
<? require_once VIEW_PATH.'gitlab/common/body/header-content.php';?>

<script>
    var findFileURL = "";
</script>
<div class="page-with-sidebar">

    <div class="content-wrapper page-with-layout-nav page-with-sub-nav">
        <div class="alert-wrapper">

            <div class="flash-container flash-container-page">
            </div>

        </div>

            <div class="content padding-0" id="content-body">
                <div class="cover-block user-cover-block">
                    <div class="scrolling-tabs-container">
                        <div class="fade-left">
                            <i class="fa fa-angle-left"></i>
                        </div>
                        <div class="fade-right">
                            <i class="fa fa-angle-right"></i>
                        </div>
                        <?php
                        $profile_nav='preferences';
                        include_once VIEW_PATH.'gitlab/user/common-setting-nav.php';
                        ?>
                    </div>
                </div>
                <div class="container-fluid container-limited">
                    <form class="row prepend-top-default js-preferences-form" id="user_setting"
                          action="/user/setPreferences" accept-charset="UTF-8" data-remote="true" method="post">
                        <input name="utf8" type="hidden" value="✓">
                        <input type="hidden" name="_method" value="post">
                        <!--<div class="col-lg-4 application-theme">
                            <h4 class="prepend-top-0">
                                Navigation theme
                            </h4>
                            <p>Customize the appearance of the application header and navigation sidebar.</p>
                        </div>
                        <div class="col-lg-8 application-theme">
                            <label><div class="preview ui-indigo"></div>
                                <input type="radio" value="1" checked="checked" name="user[theme_id]" id="user_theme_id_1">
                                Indigo
                            </label><label><div class="preview ui-light-indigo"></div>
                                <input type="radio" value="6" name="user[theme_id]" id="user_theme_id_6">
                                Light Indigo
                            </label><label><div class="preview ui-blue"></div>
                                <input type="radio" value="4" name="user[theme_id]" id="user_theme_id_4">
                                Blue
                            </label><label><div class="preview ui-light-blue"></div>
                                <input type="radio" value="7" name="user[theme_id]" id="user_theme_id_7">
                                Light Blue
                            </label><label><div class="preview ui-green"></div>
                                <input type="radio" value="5" name="user[theme_id]" id="user_theme_id_5">
                                Green
                            </label><label><div class="preview ui-light-green"></div>
                                <input type="radio" value="8" name="user[theme_id]" id="user_theme_id_8">
                                Light Green
                            </label><label><div class="preview ui-red"></div>
                                <input type="radio" value="9" name="user[theme_id]" id="user_theme_id_9">
                                Red
                            </label><label><div class="preview ui-light-red"></div>
                                <input type="radio" value="10" name="user[theme_id]" id="user_theme_id_10">
                                Light Red
                            </label><label><div class="preview ui-dark"></div>
                                <input type="radio" value="2" name="user[theme_id]" id="user_theme_id_2">
                                Dark
                            </label><label><div class="preview ui-light"></div>
                                <input type="radio" value="3" name="user[theme_id]" id="user_theme_id_3">
                                Light
                            </label></div>
                        <div class="col-sm-12">
                            <hr>
                        </div>-->
                        <div class="col-lg-4 profile-settings-sidebar">
                            <h4 class="prepend-top-0">
                                Navigation Bar
                            </h4>
                            <p>
                                You can select different setup for the navigation bar here.
                            </p>
                        </div>
                        <div class="col-lg-8 syntax-theme">
                            <label><div class="preview"><img class="js-lazy-loaded" src="<?=ROOT_URL?>gitlab/images/white-scheme-preview.png"></div>
                                <input type="radio" value="top" checked="checked" name="params[scheme_style]" id="scheme_top">
                                Minimized
                            </label><label><div class="preview"><img class="js-lazy-loaded" src="<?=ROOT_URL?>gitlab/images/solarized-light-scheme-preview.png"></div>
                                <input type="radio" value="left" name="params[scheme_style]" id="scheme_left">
                                Left
                            </label>
                        </div>
                        <div class="col-sm-12">
                            <hr>
                        </div>
                        <div class="col-lg-3 profile-settings-sidebar">
                            <h4 class="prepend-top-0">
                                Layout
                            </h4>
                            <p>
                                This setting allows you to customize system layout and default layout.
                            </p>
                        </div>
                        <div class="col-lg-9">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label class="label-light" for="layout">Page Layout:</label>
                                    </div>
                                    <div class="col-lg-4">
                                        <select class="form-control" name="params[layout]" id="layout">
                                            <option selected="selected" value="fixed">Fixed</option>
                                            <option value="fluid">Fluid</option></select>
                                    </div>
                                    <div class="col-lg-6">
                                        <span class="help-block">Select from fixed(1200px maximum) or fluid(100%).</span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label class="label-light" for="project_view">Project View:</label>
                                    </div>
                                    <div class="col-lg-4">
                                        <select class="form-control" name="params[project_view]" id="project_view">
                                            <option selected="selected" value="issues">Audit Plans</option>
                                            <option value="summary">Customer Summary</option>
                                            <option value="backlog">To-dos</option>
                                            <option value="sprints">Sprints</option>
                                            <option value="board">Board</option>
                                        </select>
                                    </div>
                                    <div class="col-lg-6">
                                        <span class="help-block">Select what you want to see on project overview page.</span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <label class="label-light" for="issue_view">Audit View:</label>
                                    </div>
                                    <div class="col-lg-4">
                                        <select class="form-control" name="params[issue_view]" id="issue_view">
                                            <option selected="selected" value="list">Table View</option>
                                            <option value="detail">Detailed View</option>
                                            <option value="responsive">Responsive View</option>
                                        </select>
                                    </div>
                                    <div class="col-lg-6">
                                        <span class="help-block">Select the style you want on the audit view page.</span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <input id="commit" type="button" name="commit" value="Save" class="btn btn-save js-key-enter">
                            </div>

                        </div>

                    </form>
                </div>
            </div>

    </div>
</div>

    </div>
</section>
<script src="<?=ROOT_URL?>dev/js/user/preferences.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

    var $userSetting = null;
    $(function() {
        var options = {
            form_id:'user_setting',
            uid:window.current_uid,
            get_url:"<?=ROOT_URL?>user/getPreferences",
            update_url:"<?=ROOT_URL?>user/setPreferences",
        }

        $('#commit').bind('click',function(){
            window.$userSetting.update();
        })
        window.$userSetting = new UserSetting( options );
        window.$userSetting.fetch( window.current_uid );
    });



</script>


</body>
</html>
