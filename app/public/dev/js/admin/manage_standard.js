
var Standard = (function() {

    var _options = {};

    // constructor
    function Standard(  options  ) {
        _options = options;

        $("#btn-group_add").click(function(){
            Standard.prototype.add();
        });

        $("#btn-group_update").click(function(){
            Standard.prototype.update();
        });

        $("#btn-group-add-user").click(function(){
            Standard.prototype.groupAddUser();
        });


        $("#btn-group_filter").click(function(){
            Standard.prototype.fetchGroups( );
        });

        $("#btn-group_reset").click(function(){
            Standard.prototype.formReset( );
            Standard.prototype.fetchGroups();
        });

        $(".filter_page_size").click(function () {
            $(".filter_page_size").each(function () {
                $(this).removeClass("active");
            });
            $(this).addClass("active");

            $('#filter_page_size').val( $(this).attr('data-value') );
            Standard.prototype.fetchStandards();

        });
    };

    Standard.prototype.getOptions = function() {
        return _options;
    };

    Standard.prototype.setOptions = function( options ) {
        for( i in  options )  {
           // if( typeof( _options[options[i]] )=='undefined' ){
                _options[i] = options[i];
           // }
        }
    };

    Standard.prototype.fetchStandards = function(  ) {

        // url,  list_tpl_id, list_render_id
        var params = {  format:'json' };
        $.ajax({
            type: "GET",
            dataType: "json",
            async: true,
            url: _options.filter_url,
            data: {'standard': _options.standard} ,
            success: function (resp) {
                auth_check(resp);
                if(resp.data.available_standards != undefined && resp.data.available_standards.length){
                    var source = $('#'+_options.list_tpl_id).html();
                    var template = Handlebars.compile(source);
                    var result = template(resp.data);
                    $('#' + _options.list_render_id).html(result);

                    $(".group_for_edit").click(function(){
                        Standard.prototype.edit( $(this).attr("data-value") );
                    });

                    $(".group_for_delete").click(function(){
                        Standard.prototype._delete( $(this).attr("data-value") );
                    });

                    var page_options = {
                        currentPage: resp.data.page,
                        totalPages: resp.data.pages,
                        onPageClicked: function(e,originalEvent,type,page){
                            console.log("Page item clicked, type: "+type+" page: "+page);
                            $("#filter_page").val( page );
                            Standard.prototype.fetchStandards( );
                        }
                    }
                    $('#'+_options.pagination_id).bootstrapPaginator( page_options );
                }else{
                    var emptyHtml = defineStatusHtml({
                        message : '暂无数据',
                        type: 'error',
                        handleHtml: ''
                    })
                    $('#list_render_id').append($('<div id="list_render_id_wrap"></div>'))
                    $('#list_render_id_wrap').append(emptyHtml.html)
                }


            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    }

    Standard.prototype.groupAddUser = function(  ) {

        var method = 'post';
        var params = $('#form_add').serialize();
        $.ajax({
            type: method,
            dataType: "json",
            async: true,
            url: _options.group_users_add_url,
            data: params ,
            success: function (resp) {
                auth_check(resp);
                notify_success( resp.msg );
                if( resp.ret == 200 ){
                    window.location.reload();
                }
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    }

    Standard.prototype.formReset = function(  ) {

        $("#filter_page").val("1");
        $("#filter_page_size").val("20");
        $("#filter_name").val("");
        $('#filter_page_view').html( $('#filter_page_view').attr("data-title-origin") );
    }

    Standard.prototype.edit = function(id ) {

        var method = 'get';
        $.ajax({
            type: method,
            dataType: "json",
            async: true,
            url: _options.get_url+"?id="+id,
            data: { id:id} ,
            success: function (resp) {

                auth_check(resp);
                $("#modal-group_edit").modal();
                $("#edit_id").val(resp.data.sid);
                $("#edit_name").val(resp.data.standard_name);
                $("#edit_description").val(resp.data.description);
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    }

    Standard.prototype.add = function(  ) {

        var method = 'post';
        var params = $('#form_add').serialize();
        alert(params);
        $.ajax({
            type: method,
            dataType: "json",
            async: true,
            url: _options.add_url,
            data: params ,
            success: function (resp) {
                console.log(resp);
                auth_check(resp);
                notify_success( resp.msg );
                if( resp.ret == 200 ){
                    window.location.reload();
                }
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
                console.log(res);
            }
        });
    }

    Standard.prototype.update = function(  ) {

        var method = 'post';
        var params = $('#form_edit').serialize();
        $.ajax({
            type: method,
            dataType: "json",
            async: true,
            url: _options.update_url,
            data: params,
            success: function (resp) {
                auth_check(resp);
                notify_success( resp.msg );
                if( resp.ret == 200 ){
                    window.location.reload();
                }
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    }

    Standard.prototype._delete = function(id ) {

        if  (!window.confirm('您确认删除该项吗?')) {
            return false;
        }

        var method = 'GET';
        $.ajax({
            type: method,
            dataType: "json",
            data:{ id:id },
            url: _options.delete_url,
            success: function (resp) {
                console.log(resp);
                auth_check(resp);
                notify_success( resp.msg );
                if( resp.ret == 200 ){
                    window.location.reload();
                }
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    }

    Standard.prototype.groupRemoveUser = function( group_id,uid ) {

        if  (!window.confirm('您确认删除该项吗?')) {
            return false;
        }

        var method = 'GET';
        $.ajax({
            type: method,
            dataType: "json",
            data:{group_id:group_id, uid:uid },
            url: _options.group_users_delete_url,
            success: function (resp) {
                auth_check(resp);
                notify_success( resp.msg );
                if( resp.ret == 200 ){
                    window.location.reload();
                }
            },
            error: function (res) {
                notify_error("请求数据错误" + res);
            }
        });
    }



    return Standard;
})();


