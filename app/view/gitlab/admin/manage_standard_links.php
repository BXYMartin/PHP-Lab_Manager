<!DOCTYPE html>
<html class="" lang="en">
<head  >

    <? require_once VIEW_PATH.'gitlab/common/header/include.php';?>
    <script src="<?=ROOT_URL?>dev/js/admin/manage_standard_link.js?v=<?=$_version?>" type="text/javascript" charset="utf-8"></script>
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
                                <a id="state-opened"  title="标准关联管理" href="#" ><span>标准关联管理</span>
                                </a>
                            </li>
                        </ul>
                        <div class="nav-controls margin-md-l">
                            <a class="btn btn-new btn_group_add js-key-create" data-target="#modal-group_add" data-toggle="modal" href="#modal-group_add">
                                <i class="fa fa-plus"></i> 新增关联
                            </a>
                        </div>
                    </div>

                    <div class="content-list pipelines">

                            <div class="table-holder">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th class="js-pipeline-info pipeline-info">父集</th>
                                        <th class="js-pipeline-stages pipeline-info">子集</th>
                                        <th class="pipeline-info" style="text-align: right;">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="list_render_id">


                                    </tbody>
                                </table>
                            </div>
                            <div class="gl-pagination" id="pagination">

                            </div>

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
            <div class="modal-content modal-middle" style="min-height: 60% !important;">
                <div class="modal-header">
                    <a class="close js-key-modal-close1" data-dismiss="modal" href="#">×</a>
                    <h3 class="modal-header-title">新增关联</h3>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="format" id="format" value="json">
                        <div class="form-group">
                            <label class="control-label" for="id_name">父级条目:<span class="required"> *</span></label>
                            <div class="col-sm-8">
                                <div class="form-group">
                                    <div id="position_father_render_id"></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="id_name">子级条目:<span class="required"> *</span></label>
                            <div class="col-sm-8">
                                <div class="form-group">
                                    <div id="position_child_render_id"></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label" for="id_description">描述:</label>
                            <div class="col-sm-8">
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

    </div>
</section>

<script type="text/html"  id="list_tpl">
    {{#available_links}}

        <tr class="commit">
            <td>
            {{#with father}}
            <strong>{{standard}}</strong> -> <strong class="prepend-left-5">{{number}}.</strong> {{standard_name}}
            {{/with}}
            </td>
            <td>
            {{#with child}}
            <strong>{{standard}}</strong> -> <strong class="prepend-left-5">{{number}}.</strong> {{standard_name}}
            {{/with}}
            </td>
            </td>
            <td  >
                <div class="controls member-controls " style="float: right">
                    <a class="group_for_delete btn btn-transparent  "  href="javascript:;" data-value="{{sid}}" style="padding: 6px 2px;">
                        <i class="fa fa-trash"></i>
                        <span class="sr-only">Remove</span>
                    </a>
                </div>

            </td>
        </tr>
    {{/available_links}}

</script>

<script type="text/html" id="position_father_tpl">
<div class="issuable-form-select-holder">

    <input type="hidden" name="params[father_sid]" value="" />
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
            <span class="dropdown-toggle-text is-default" id="father_selector">请选择条目</span>
            <i class="fa fa-chevron-down"></i>
        </button>

        <div class="dropdown-menu dropdown-select dropdown-menu-paging dropdown-menu-labels dropdown-menu-selectable js-multiselect">
                <div class="dropdown-page-one">
                    <div class="dropdown-title">
                        <span>选择条目</span>
                        <button class="dropdown-title-button dropdown-menu-close" aria-label="Close" type="button">
                            <i class="fa fa-times dropdown-menu-close-icon"></i>
                        </button>
                    </div>

                    <div class="dropdown-content ">
                        <ul>
                        {{#edit_data}}
                            <li>
                                <strong style="font-size: 15px;">{{standard_name}}</strong>
                            </li>
                                {{#section}}
                                    <li>
                                    <a href='javascript:$("input[name=\"params[father_sid]\"]").val({{sid}});$("#father_selector").text("{{standard_name}}").removeClass("is-default");'>{{number}}. {{standard_name}}</a>
                                    </li>
                                    {{#section}}
                                        <li>
                                        <a href='javascript:$("input[name=\"params[father_sid]\"]").val({{sid}});$("#father_selector").text("{{standard_name}}").removeClass("is-default");'>{{number}}. {{standard_name}}</a>
                                        </li>
                                        {{#section}}
                                            <li>
                                            <a href='javascript:$("input[name=\"params[father_sid]\"]").val({{sid}});$("#father_selector").text("{{standard_name}}").removeClass("is-default");'>{{number}}. {{standard_name}}</a>
                                            </li>
                                        {{/section}}
                                    {{/section}}
                                {{/section}}
                            <li class="divider"></li>
                        {{/edit_data}}
                        </ul>
                    </div>
                </div>
            </div>
    </div>
</div>
</script>



<script type="text/html" id="position_child_tpl">
<div class="issuable-form-select-holder">

    <input type="hidden" name="params[child_sid]" value="" />
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
            <span class="dropdown-toggle-text is-default" id="child_selector">请选择条目</span>
            <i class="fa fa-chevron-down"></i>
        </button>

        <div class="dropdown-menu dropdown-select dropdown-menu-paging dropdown-menu-labels dropdown-menu-selectable js-multiselect">
                <div class="dropdown-page-one">
                    <div class="dropdown-title">
                        <span>选择条目</span>
                        <button class="dropdown-title-button dropdown-menu-close" aria-label="Close" type="button">
                            <i class="fa fa-times dropdown-menu-close-icon"></i>
                        </button>
                    </div>

                    <div class="dropdown-content ">
                        <ul>
                        {{#edit_data}}
                            <li>
                                <strong style="font-size: 15px;">{{standard_name}}</strong>
                            </li>
                                {{#section}}
                                    <li>
                                    <a href='javascript:$("input[name=\"params[child_sid]\"]").val({{sid}});$("#child_selector").text("{{standard_name}}").removeClass("is-default");'>{{number}}. {{standard_name}}</a>
                                    </li>
                                    {{#section}}
                                        <li>
                                        <a href='javascript:$("input[name=\"params[child_sid]\"]").val({{sid}});$("#child_selector").text("{{standard_name}}").removeClass("is-default");'>{{number}}. {{standard_name}}</a>
                                        </li>
                                        {{#section}}
                                            <li>
                                            <a href='javascript:$("input[name=\"params[child_sid]\"]").val({{sid}});$("#child_selector").text("{{standard_name}}").removeClass("is-default");'>{{number}}. {{standard_name}}</a>
                                            </li>
                                        {{/section}}
                                    {{/section}}
                                {{/section}}
                            <li class="divider"></li>
                        {{/edit_data}}
                        </ul>
                    </div>
                </div>
            </div>
    </div>
</div>
</script>




<script type="text/javascript">

    var $standard = null;
    $(function() {

        var options = {
            list_render_id:"list_render_id",
            list_tpl_id:"list_tpl",
            position_father_render_id:"position_father_render_id", 
            position_child_render_id:"position_child_render_id",
            position_father_tpl_id:"position_father_tpl",
            position_child_tpl_id:"position_child_tpl",
            filter_form_id:"filter_form",
            filter_url:"<?=ROOT_URL?>admin/standard/filterLink",
            get_url:"<?=ROOT_URL?>admin/standard/getLink",
            update_url:"<?=ROOT_URL?>admin/standard/updateLink",
            add_url:"<?=ROOT_URL?>admin/standard/addLink",
            delete_url:"<?=ROOT_URL?>admin/standard/deleteLink",
            pagination_id:"pagination",
        }
        window.$standard = new Standard( options );
        window.$standard.fetchLinks(  );

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
