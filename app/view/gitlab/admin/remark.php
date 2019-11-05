<!DOCTYPE html>
<html class="" lang="en">
<head  >
    <?php require_once VIEW_PATH.'gitlab/common/header/include.php';?>
    <script src="<?=ROOT_URL?>dev/lib/handlebars-v4.0.10.js" type="text/javascript" charset="utf-8"></script>
    <script src="<?=ROOT_URL?>dev/lib/bootstrap-paginator/src/bootstrap-paginator.js?v=<?= $_version ?>"  type="text/javascript"></script>
    <script src="<?=ROOT_URL?>dev/js/admin/project.js?v=<?=$_version?>" type="text/javascript" charset="utf-8"></script>
</head>
<body class="" data-group="" data-page="projects:issues:index" data-project="xphp">
<? require_once VIEW_PATH.'gitlab/common/body/script.php';?>

<section class="has-sidebar page-layout max-sidebar">
    <? require_once VIEW_PATH . 'gitlab/common/body/page-left.php'; ?>

    <div class="page-layout page-content-body system-page">
<?php require_once VIEW_PATH.'gitlab/common/body/header-content.php';?>

<script>
    var findFileURL = "";
</script>
<div class="page-with-sidebar">

    <?php require_once VIEW_PATH.'gitlab/admin/common-page-nav-admin.php';?>

    <div class="content-wrapper page-with-layout-nav page-with-sub-nav">
        <div class="alert-wrapper">

            <div class="flash-container flash-container-page">
            </div>

        </div>
        <div class="content" id="content-body">
            <div class="container-fluid">
                <div class="top-area">
                    <ul class="nav-links user-state-filters" style="float:left">
                        <li class="active" data-value="">
                            <h4 style="margin-left: 12px;">
                            <select id="month" onchange="update();">
                              <option value="0">本月</option>
                              <option value="-1">上个月</option>
                              <option value="-2">两个月前</option>
                              <option value="-3">三个月前</option>
                            </select>
                            绩效结算
                            </h4>
                        </li>
                    </ul>
                    <div class="nav-controls" style="right: ">
                        <!--a class="btn has-tooltip" title="" href="#" data-original-title="邀请用户">
                            <i class="fa fa-rss"></i>
                        </a-->
                        <div class="project-item-select-holder">
                            <a class="btn btn-new" id="download" onclick="tablesToExcel(['viewTable'], ['PRIME Lab Manager Remarks'], 'Excel')">
                                <i class="fa fa-cloud-download"></i>
                                导出表格
                            </a>
                        </div>
                    </div>
                </div>

                <div class="content-list pipelines">
                    <div class="table-holder">
                        <table class="table" id="viewTable">
                            <thead id="header_id">
                            </thead>
                            <tbody id="render_id">
                            </tbody>
                        </table>
                    </div>
                    <div class="gl-pagination" id="ampagination-bootstrap">
                    <h5 id="date_id" style="color: #555;"></h5>

                    </div>
                </div>


            </div>
        </div>

    </div>
</div>

    </div>
</section>
<script type="text/html" id="date_tpl">
<div>
{{date}}
</div>
</script>
<script type="text/html" id="header_tpl">
    <tr>
        <th class="js-pipeline-info pipeline-info">用户名</th>
        <th class="js-pipeline-info pipeline-info">负责项目数</th>
        <th class="js-pipeline-info pipeline-info">完成总任务数</th>
        {{#issues}}
        <th class="js-pipeline-info" data-value="{{name}}"><i class="fa {{font_awesome}}"></i></th>
        {{/issues}}
    </tr>
</script>
<script type="text/html" id="remark_tpl">
    {{#users}}
        <tr class="commit">
            <td data-value="{{username}}">
                <strong>
                    {{username}}
                </strong>
            </td>
            <td data-value="{{project}}">
                {{project}}
            </td>
            <td data-value="{{issue}}">
                {{issue}}
            </td>
            {{#issues}}
            <td data-value="{{count}}">
                {{count}}
            </td>
            {{/issues}}
        </tr>
    {{/users}}

</script>

<script>
    function update() {
        document.getElementById("render_id").style.visibility = "hidden";
        var obj = document.getElementById("month");
        var index = obj.selectedIndex;
        var value = parseInt(obj.options[index].value);
        fetchRemarkList('/admin/remark/filterData', 'remark_tpl', 'render_id', value, 1);
        fetchHeaderList('/admin/remark/filterHeaderData', 'header_tpl', 'header_id');
        fetchDateList('/admin/remark/filterDateData', 'date_tpl', 'date_id', value, 1);
        document.getElementById("render_id").style.visibility = "visible";
    }

    update();

    var tablesToExcel = (function() {
        var uri = 'data:application/vnd.ms-excel;base64,'
            , tmplWorkbookXML = '<' + '?xml version="1.0"?><' + '?mso-application progid="Excel.Sheet"?><Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">'
            + '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office"><Author>Axel Richter</Author><Created>{created}</Created></DocumentProperties>'
            + '<Styles>'
            + '<Style ss:ID="Currency"><NumberFormat ss:Format="Currency"></NumberFormat></Style>'
            + '<Style ss:ID="Date"><NumberFormat ss:Format="Medium Date"></NumberFormat></Style>'
            + '</Styles>'
            + '{worksheets}</Workbook>'
            , tmplWorksheetXML = '<Worksheet ss:Name="{nameWS}"><Table>{rows}</Table></Worksheet>'
            , tmplCellXML = '<Cell{attributeStyleID}{attributeFormula}><Data ss:Type="{nameType}">{data}</Data></Cell>'
            , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
            , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) };
        return function(tables, wsnames, appname) {
            var ctx = "";
            var workbookXML = "";
            var worksheetsXML = "";
            var rowsXML = "";
            
            var obj = document.getElementById("month");
            var offset = parseInt(obj.options[obj.selectedIndex].value);
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth() + 1 + offset;
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            var wbname = year + "-" + month + " 绩效考核表.xls"; 
            for (var i = 0; i < tables.length; i++) {
                if (!tables[i].nodeType) tables[i] = document.getElementById(tables[i]);
                for (var j = 0; j < tables[i].rows.length; j++) {
                    rowsXML += '<Row>';
                    for (var k = 0; k < tables[i].rows[j].cells.length; k++) {
                        var dataType = tables[i].rows[j].cells[k].getAttribute("data-type");
                        var dataStyle = tables[i].rows[j].cells[k].getAttribute("data-style");
                        var dataValue = tables[i].rows[j].cells[k].getAttribute("data-value");
                        dataValue = (dataValue)?dataValue:tables[i].rows[j].cells[k].innerHTML;
                        var dataFormula = tables[i].rows[j].cells[k].getAttribute("data-formula");
                        dataFormula = (dataFormula)?dataFormula:(appname=='Calc' && dataType=='DateTime')?dataValue:null;
                        ctx = {  attributeStyleID: (dataStyle=='Currency' || dataStyle=='Date')?' ss:StyleID="'+dataStyle+'"':''
                            , nameType: (dataType=='Number' || dataType=='DateTime' || dataType=='Boolean' || dataType=='Error')?dataType:'String'
                            , data: (dataFormula)?'':dataValue
                            , attributeFormula: (dataFormula)?' ss:Formula="'+dataFormula+'"':''
                        };
                        rowsXML += format(tmplCellXML, ctx);
                    }
                    rowsXML += '</Row>'
                }
                ctx = {rows: rowsXML, nameWS: wsnames[i] || 'Sheet' + i};
                worksheetsXML += format(tmplWorksheetXML, ctx);
                rowsXML = "";
            }
 
            ctx = {created: (new Date()).getTime(), worksheets: worksheetsXML};
            workbookXML = format(tmplWorkbookXML, ctx);
 
            console.log(workbookXML);
 
            var link = document.createElement("A");
            link.href = uri + base64(workbookXML);
            link.download = wbname || 'Workbook.xls';
            link.target = '_blank';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    })();

</script>

</body>
</html>
