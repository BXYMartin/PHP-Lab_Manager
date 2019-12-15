<!DOCTYPE html>
<html class="" lang="en">
<head  >

    <? require_once VIEW_PATH.'gitlab/common/header/include.php';?>
    <script src="<?=ROOT_URL?>dev/js/admin/standard.js?v=<?=$_version?>" type="text/javascript" charset="utf-8"></script>
    <script src="<?=ROOT_URL?>dev/lib/handlebars-v4.0.10.js" type="text/javascript" charset="utf-8"></script>


    <script src="<?=ROOT_URL?>dev/lib/bootstrap-select/js/bootstrap-select.js" type="text/javascript" charset="utf-8"></script>
    <link href="<?=ROOT_URL?>dev/lib/bootstrap-select/css/bootstrap-select.css" rel="stylesheet">

    <script src="<?=ROOT_URL?>dev/lib/bootstrap-paginator/src/bootstrap-paginator.js?v=<?= $_version ?>"  type="text/javascript"></script>

    <script src="<?=ROOT_URL?>dev/lib/bootstrap-3.3.7/js/bootstrap.min.js"></script>

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
                            <a class="btn btn-new btn_group_add js-key-create" href='javascript:$("#modal-group_add").modal();'>
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
          action="<?=ROOT_URL?>admin/standard/add"
          accept-charset="UTF-8"
          method="post">
        <div class="modal-dialog">
            <div class="modal-content modal-middle">
                <div class="modal-header">
                    <a class="close js-key-modal-close1" data-dismiss="modal" href="#">×</a>
                    <h3 class="modal-header-title">新增条目</h3>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="format" id="format" value="json">
                        <div class="form-group">
                            <label class="control-label" for="id_name">添加位置:<span class="required"> *</span></label>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div id="position_render_id"></div>
                                </div>
                            </div>
                        </div>

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

<div class="modal" id="modal-group_more">
    <form class="js-quick-submit js-upload-blob-form form-horizontal" id="form_more"
          action="<?=ROOT_URL?>admin/standard/addLine"
          accept-charset="UTF-8"
          method="post">
        <div class="modal-dialog">
            <div class="modal-content modal-middle">
                <div class="modal-header">
                    <a class="close js-key-modal-close2" data-dismiss="modal" href="#">×</a>
                    <h3 class="modal-header-title">添加条目</h3>
                </div>

                <div class="modal-body">
                    <input type="hidden" name="params[sid]" id="more_id" value="">
                    <input type="hidden" name="params[standard]" value="<? echo $left_nav_active; ?>" />
                    <input type="hidden" name="format" id="format" value="json">

                    <div class="form-group">
                        <label class="control-label" for="id_name">显示名称:<span class="required"> *</span></label>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input type="text" class="form-control" name="params[name]" id="more_name"  value="" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="id_description">描述:</label>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input type="text" class="form-control" name="params[description]" id="more_description"  value="" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button name="submit" type="button" class="btn btn-save js-key-modal-enter2" id="btn-group_more">保存</button>
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
                    <h3 class="modal-header-title">编辑条目</h3>
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
    <div class="panel-group" id="accordion" style="padding: 10px 20px;">
    {{#section}}
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title" style="float: left">
                    <a data-toggle="collapse" data-parent="#accordion"
                       href="#section_{{sid}}">
                            {{standard_name}}
                    </a>
                </h4>

                <div class="controls member-controls " style="float: right">
                    <a class="group_for_more btn btn-transparent " href="#" data-value="{{sid}}" style="padding: 6px 2px;">添加 </a>
                    <a class="group_for_edit btn btn-transparent " href="#" data-value="{{sid}}" style="padding: 6px 2px;">编辑 </a>
                    <a class="group_for_delete btn btn-transparent  "  href="javascript:;" data-value="{{sid}}" style="padding: 6px 2px;">
                        <i class="fa fa-trash"></i>
                        <span class="sr-only">Remove</span>
                    </a>
                </div>
                <div class="clearfix"></div>
            </div>
            <div id="section_{{sid}}" class="panel-collapse collapse in">
                <div class="panel-body">
                    
                    <div class="panel-group" id="accordion_{{sid}}">
                    {{#section}}
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title" style="float: left">
                                    <a data-toggle="collapse" data-parent="#accordion_{{parent_id}}"
                                       href="#header_{{sid}}">
                                            {{standard_name}}
                                    </a>
                                </h4>

                                <div class="controls member-controls " style="float: right">
                                    <a class="group_for_more btn btn-transparent " href="#" data-value="{{sid}}" style="padding: 6px 2px;">添加 </a>
                                    <a class="group_for_edit btn btn-transparent " href="#" data-value="{{sid}}" style="padding: 6px 2px;">编辑 </a>
                                    <a class="group_for_delete btn btn-transparent  "  href="javascript:;" data-value="{{sid}}" style="padding: 6px 2px;">
                                        <i class="fa fa-trash"></i>
                                        <span class="sr-only">Remove</span>
                                    </a>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div id="header_{{sid}}" class="panel-collapse collapse">
                                <div class="panel-body">

                                    <div class="panel-group" id="accordion_{{sid}}">
                                    {{#section}}
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title" style="float: left">
                                                    <a data-toggle="collapse" data-parent="#accordion_{{parent_id}}"
                                                       href="#detail_{{sid}}">
                                                            {{standard_name}}

                                                    </a>
                                                </h4>
                                            <div class="controls member-controls " style="float: right">
                                                <a class="group_for_more btn btn-transparent " href="#" data-value="{{sid}}" style="padding: 6px 2px;">添加 </a>
                                                <a class="group_for_edit btn btn-transparent " href="#" data-value="{{sid}}" style="padding: 6px 2px;">编辑 </a>
                                                <a class="group_for_delete btn btn-transparent  "  href="javascript:;" data-value="{{sid}}" style="padding: 6px 2px;">
                                                    <i class="fa fa-trash"></i>
                                                    <span class="sr-only">Remove</span>
                                                </a>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>

                                        </div>
                                    {{/section}}
                                    </div>


                                </div>
                            </div>
                        </div>
                    {{/section}}
                    </div>


                </div>
            </div>
        </div>
    {{/section}}
    </div>

</script>

<script type="text/html" id="position_tpl">
<div class="issuable-form-select-holder">
    {{#edit_data}}
    <input type="hidden" name="params[sid]" value="{{sid}}" />
    {{/edit_data}}
    <input type="hidden" name="params[standard]" value="{{standard}}" />

    <div class="dropdown">
        <button class="dropdown-menu-toggle js-extra-options js-filter-submit js-issuable-form-dropdown js-label-select"
                data-default-label="Positions"
                data-field-name=""
                data-labels=""
                data-namespace-path=""
                data-project-path=""
                data-show-no="true"
                data-toggle="dropdown"
                data-multiselect="true"
                type="button">
            <span class="dropdown-toggle-text">{{standard}}</span>
            <i class="fa fa-chevron-down"></i>
        </button>

    </div>
</div>
</script>




<script type="text/javascript">

    var $standard = null;
    $(function() {

        var options = {
            list_render_id:"list_render_id",
            list_tpl_id:"list_tpl",
            position_render_id:"position_render_id",
            position_tpl_id:"position_tpl",
            filter_form_id:"filter_form",
            filter_url:"<?=ROOT_URL?>admin/standard/filter",
            get_url:"<?=ROOT_URL?>admin/standard/get",
            update_url:"<?=ROOT_URL?>admin/standard/update",
            add_url:"<?=ROOT_URL?>admin/standard/addLine",
            set_url:"<?=ROOT_URL?>admin/standard/updateIndex",
            delete_url:"<?=ROOT_URL?>admin/standard/deleteLine",
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
