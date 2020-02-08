<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title><?php echo $html_title; ?></title>
    <link href="css/install.css" rel="stylesheet" type="text/css">
    <script src="js/jquery.js"></script>
    <script src="js/jquery.icheck.min.js"></script>
    <script>
        $(document).ready(function () {
            $('input[type="radio"]').on('ifChecked', function (event) {
                if (this.id == 'radio-0') {
                    $('.select-module').show();
                } else {
                    $('.select-module').hide();
                }
            }).iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'
            });
            $('input[type="checkbox"]').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                radioClass: 'iradio_flat-green'
            });
            $('#next').click(function () {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    async: true,
                    url: "./index.php?action=check_redis_connect",
                    data: $('#install_form').serialize(),
                    success: function (resp) {
                        if(resp.ret!=200){
                            alert( resp.msg);
                            return;
                        }else{
                            alert( "Server Successfully Connected!" );
                            $('#install_form').submit();
                        }
                    },
                    error: function (res) {
                        alert("Connection Error: " + res);
                    }
                });
            });
        });

    </script>
</head>

<body>
<?php ECHO $html_header; ?>
<div class="main">
    <div class="step-box" id="step2">
        <div class="text-nav">
            <h1>2</h1>
            <h2>Server Setup</h2>
            <h5 style="color: red">Use Redis & Async Server is Efficient</h5>
        </div>
        <div class="procedure-nav">
            <div class="schedule-ico"><span class="a"></span><span class="b"></span><span class="c"></span><span
                        class="d"></span></div>
            <div class="schedule-point-now"><span class="a"></span><span class="b"></span><span class="c"></span><span
                        class="d"></span></div>
            <div class="schedule-point-bg"><span class="a"></span><span class="b"></span><span class="c"></span><span
                        class="d"></span></div>
            <div class="schedule-line-now"><em></em></div>
            <div class="schedule-line-bg"></div>
            <div class="schedule-text"><span class="a">Env Setup</span><span class="b">Server Setup</span><span class="c">Database Setup</span><span class="d">Install</span></div>
        </div>
    </div>
    <form method="post" id="install_form" action="index.php?step=3">
        <input type="hidden" value="3" name="step">

        <div class="form-box control-group">
            <fieldset>
                <legend>Redis Server</legend>
                <div>
                    <span>Access Data Quickly</span>
                </div>
                <div>
                    <label>Server Address</label>
                    <span>
                        <input type="text" name="redis_host"
                               value="<?php echo $_POST['redis_host'] ? $_POST['redis_host'] : '127.0.0.1'; ?>">
                  </span> <em>Normally 127.0.0.1</em>
                </div>

                <div>
                    <label>Redis Port</label>
                    <span>
                    <input type="text" name="redis_port" maxlength="20"
                           value="<?php echo $_POST['redis_port'] ? $_POST['redis_port'] : '6379'; ?>">
                  </span> <em>Default Port is 6379</em>
                </div>

                <div>
                    <label>Password</label>
                    <span>
                    <input type="text" name="redis_password" maxlength="40"
                           value="<?php echo $_POST['redis_password'] ? $_POST['redis_password'] : ''; ?>">
                    </span> <em>Fill in if Password Exist</em>
                </div>
                <div>
                    <label></label>
                    <span> </span>
                </div>
            </fieldset>
            <fieldset>
                <legend>Socket Server</legend>
                <div>
                    <span>For Real Time Data Transfer, Email Async Server etc.</span>
                </div>
                <div>
                    <label>Server Address</label>
                    <span>
                        <input type="text" name="socket_host"
                               value="<?php echo $_POST['socket_host'] ? $_POST['socket_host'] : '127.0.0.1'; ?>">
                  </span> <em>Normally 127.0.0.1</em>
                </div>

                <div>
                    <label>Port</label>
                    <span>
                    <input type="text" name="socket_port" maxlength="20"
                           value="<?php echo $_POST['socket_port'] ? $_POST['socket_port'] : '9002'; ?>">
                  </span> <em>Default Port is 9002</em>
                </div>
                <div>
                    <label>PHP Executable Path</label>
                    <span>
                    <input type="text" name="php_bin"
                           value="<?php echo $_POST['php_bin'] ? $_POST['php_bin'] : $php_bin; ?>">
                  </span> <em><?php  if(!$fetch_php_bin_ret){ echo 'Warning: Please specify the path manually!';}?></em>
                </div>
            </fieldset>
        </div>

        <div class="btn-box">
            <a href="index.php?step=1" class="btn btn-primary">Previous</a>
            <a id="next"   href="javascript:void(0);"   class="btn btn-primary">Next</a>
        </div>
    </form>
</div>
<?php ECHO $html_footer; ?>
</body>
</html>
