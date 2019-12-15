<!DOCTYPE html>
<html class="" lang="en">
<head  >

    <? require_once VIEW_PATH.'gitlab/common/header/include.php';?>
    <script src="<?=ROOT_URL?>dev/js/admin/standard.js?v=<?=$_version?>" type="text/javascript" charset="utf-8"></script>
    <script src="<?=ROOT_URL?>dev/lib/handlebars-v4.0.10.js" type="text/javascript" charset="utf-8"></script>

    <script src="<?=ROOT_URL?>dev/lib/bootstrap-select/js/bootstrap-select.js" type="text/javascript" charset="utf-8"></script>
    <link href="<?=ROOT_URL?>dev/lib/bootstrap-select/css/bootstrap-select.css" rel="stylesheet">

    <script src="<?=ROOT_URL?>dev/lib/bootstrap-paginator/src/bootstrap-paginator.js?v=<?= $_version ?>"  type="text/javascript"></script>

</head>

<body class="" data-group="" data-page="projects:issues:index" data-project="xphp">
<? require_once VIEW_PATH.'gitlab/common/body/script.php';?>

<section class="has-sidebar page-layout max-sidebar">
    <? require_once VIEW_PATH . 'gitlab/common/body/page-left.php'; ?>

    <div class="page-layout page-content-body system-page">
<? require_once VIEW_PATH.'gitlab/common/body/header-content.php';?>

<script>
    var findFileURL = "";
</script>
<div class="page-with-sidebar system-page">
    <? require_once VIEW_PATH.'gitlab/admin/common-page-nav-admin.php';?>


    <div class="content-wrapper page-with-layout-nav page-with-sub-nav">
        <div class="alert-wrapper">
            <div class="flash-container flash-container-page">
            </div>
        </div>
        <div class=" container-fluid">
            <div class="content" id="content-body">
                <?php include VIEW_PATH.'gitlab/admin/common_standard_left_nav.php';?>
                <div class="container-fluid row  has-side-margin-left "  >
                    <div class="top-area">
                        <ul class="nav-links">
                            <li class="active" data-value="">
                                <a id="state-opened"  title="标准规范" href="#" ><span>标准规范</span>
                                </a>
                            </li>
                        </ul>
                        <div class="nav-controls margin-md-l">
                            <a class="btn btn-new btn_group_add js-key-create" data-target="#modal-group_add" data-toggle="modal" href="#modal-group_add">
                                <i class="fa fa-plus"></i> 新增条目
                            </a>
                        </div>
                    </div>

                    <div class="content-list pipelines">
                        <table>
                        <div id="list_render_id">
                        </div>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal" id="modal-group_add">
    <form class="js-quick-submit js-upload-blob-form form-horizontal"  id="form_add"
          action="<?=ROOT_URL?>admin/group/add"
          accept-charset="UTF-8"
          method="post">
        <div class="modal-dialog">
            <div class="modal-content modal-middle">
                <div class="modal-header">
                    <a class="close js-key-modal-close1" data-dismiss="modal" href="#">×</a>
                    <h3 class="modal-header-title">新增用户组</h3>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="format" id="format" value="json">
                    <div class="form-group">
                            <label class="control-label" for="id_name">名称:<span class="required"> *</span></label>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="params[name]" id="id_name"  value="" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label" for="id_description">描述:</label>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="params[description]" id="id_description"  value="" />
                                </div>
                            </div>
                        </div>
                </div>
                <div class="modal-footer form-actions">
                    <button name="submit" type="button" class="btn btn-create js-key-modal-enter1" id="btn-group_add">保存</button>
                    <a class="btn btn-cancel" data-dismiss="modal" href="#">取消</a>
                </div>
            </div>
        </div>
    </form>
</div>

<div class="modal" id="modal-group_edit">
    <form class="js-quick-submit js-upload-blob-form form-horizontal" id="form_edit"
          action="<?=ROOT_URL?>admin/group/update"
          accept-charset="UTF-8"
          method="post">
        <div class="modal-dialog">
            <div class="modal-content modal-middle">
                <div class="modal-header">
                    <a class="close js-key-modal-close2" data-dismiss="modal" href="#">×</a>
                    <h3 class="modal-header-title">编辑用户组</h3>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="id" id="edit_id" value="">
                    <input type="hidden" name="format" id="format" value="json">

                    <div class="form-group">
                        <label class="control-label" for="id_name">显示名称:<span class="required"> *</span></label>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input type="text" class="form-control" name="params[name]" id="edit_name"  value="" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="id_description">描述:</label>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input type="text" class="form-control" name="params[description]" id="edit_description"  value="" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button name="submit" type="button" class="btn btn-save js-key-modal-enter2" id="btn-group_update">保存</button>
                    <a class="btn btn-cancel" data-dismiss="modal" href="#">取消</a>
                </div>
            </div>
        </div>
    </form>
</div>

    </div>
</section>

<script type="text/html"  id="list_tpl">
    <div class="panel-group" id="accordion">
    {{#section}}
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion"
                       href="#section_{{id}}">
                            {{title}}
                    </a>
                </h4>
            </div>
            <div id="section_{{id}}" class="panel-collapse collapse in">
                <div class="panel-body">
                    
                    <div class="panel-group" id="accordion">
                    {{#header}}
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion"
                                       href="#header_{{id}}">
                                            {{title}}

                                    </a>
                                </h4>
                            </div>
                            <div id="header_{{id}}" class="panel-collapse collapse in">
                                <div class="panel-body">

                                    <div class="panel-group" id="accordion">
                                    {{#detail}}
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion"
                                                       href="#detail_{{id}}">
                                                            {{title}}

                                                    </a>
                                                </h4>
                                            </div>
                                            <div class="controls member-controls " style="float: right">

                                                <a class="group_for_users btn btn-transparent " href="<?=ROOT_URL?>admin/user/index/?group_id={{id}}" data-value="{{id}}" style="padding: 6px 2px;">所属成员 </a>
                                                <a class="group_for_edit_users btn btn-transparent " href="<?=ROOT_URL?>admin/group/edit_users/{{id}}" data-value="{{id}}" style="padding: 6px 2px;">编辑成员 </a>
                                                <a class="group_for_edit btn btn-transparent " href="#" data-value="{{id}}" style="padding: 6px 2px;">编辑 </a>
                                                <a class="group_for_delete btn btn-transparent  "  href="javascript:;" data-value="{{id}}" style="padding: 6px 2px;">
                                                    <i class="fa fa-trash"></i>
                                                    <span class="sr-only">Remove</span>
                                                </a>
                                            </div>

                                        </div>
                                    {{/detail}}
                                    </div>


                                </div>
                            </div>
                        </div>
                    {{/header}}
                    </div>


                </div>
            </div>
        </div>
    {{/section}}
    </div>

</script>



<script type="text/javascript">

    var $standard = null;
    $(function() {

        var options = {
            list_render_id:"list_render_id",
            list_tpl_id:"list_tpl",
            filter_form_id:"filter_form",
            filter_url:"<?=ROOT_URL?>admin/standard/filter",
            get_url:"<?=ROOT_URL?>admin/standard/get",
            update_url:"<?=ROOT_URL?>admin/standard/update",
            add_url:"<?=ROOT_URL?>admin/standard/add",
            set_url:"<?=ROOT_URL?>admin/standard/updateIndex",
            delete_url:"<?=ROOT_URL?>admin/standard/delete",
            pagination_id:"pagination",
            standard:<?php echo "'"; echo $left_nav_active; echo "'"; ?>
        }
        window.$standard = new Standard( options );
        window.$standard.fetchStandards(  );

        $("#modal-group_add").on('show.bs.modal', function (e) {
            keyMaster.addKeys([
                {
                    key: ['command+enter', 'ctrl+enter'],
                    'trigger-element': '.js-key-modal-enter1',
                    trigger: 'click'
                },
                {
                    key: 'esc',
                    'trigger-element': '.js-key-modal-close1',
                    trigger: 'click'
                }
            ])
        })

        $('#modal-group_add').on('hidden.bs.modal', function (e) {
            keyMaster.delKeys([['command+enter', 'ctrl+enter'], 'esc'])
        })

        $("#modal-group_edit").on('show.bs.modal', function (e) {
            keyMaster.addKeys([
                {
                    key: ['command+enter', 'ctrl+enter'],
                    'trigger-element': '.js-key-modal-enter2',
                    trigger: 'click'
                },
                {
                    key: 'esc',
                    'trigger-element': '.js-key-modal-close2',
                    trigger: 'click'
                }
            ])
        })

        $('#modal-group_edit').on('hidden.bs.modal', function (e) {
            keyMaster.delKeys([['command+enter', 'ctrl+enter'], 'esc'])
        })
    });

</script>
</body>
</html>
