<?php
/**
 * @author  lijia168
 * 安装程序代码参考自 https://www.cnblogs.com/lijia168/p/6704079.html
 */

set_time_limit(0);   //设置运行时间
error_reporting(E_ALL & ~E_NOTICE);  //显示全部错误
define('ROOT_PATH', dirname(dirname(__FILE__)));  //定义根目录
define('DBCHARSET', 'UTF8');   //设置数据库默认编码
require_once('./include/function.php');

if (function_exists('date_default_timezone_set')) {
    date_default_timezone_set('Asia/Shanghai');
}
input($_GET);
input($_POST);


//判断是否安装过程序
if (is_file('lock') && $_GET['step'] != 5) {
    @header("Content-type: text/html; charset=UTF-8");
    echo "System already initialized, if you prefer a reinstall, please remove the lock file under install directory.";
    exit;
}

$html_title = 'Audit Manager Installation Guide';
$html_header = <<<EOF
<div class="header">
  <div class="layout">
    <div class="title">
      <h5></h5>
      <h2>Audit Manager Installation Guide</h2>
    </div>
    <div class="version">Version: 1.2</div>
  </div>
</div>
EOF;

$html_footer = <<<EOF
<div class="footer">
  <h5>Powered by <span class="blue">Audit Manager</span><span class="orange"></span></h5>
  <h6>Copyright 2020 &copy; <a href="#" target="_blank">Audit Manager Team</a></h6>
</div>
EOF;
$step = 0;

if (isset($_GET['action']) && $_GET['action'] == 'check_mysql_connect') {
    header('Content-Type:application/json');
    echo json_encode(check_mysql());
    die;
}

if (isset($_GET['action']) && $_GET['action'] == 'check_redis_connect') {
    header('Content-Type:application/json');
    $ret = check_redis();
    echo json_encode($ret);
    die;
}

if (in_array($_GET['step'], array(1, 2, 3, 4, 5))) {
    $step = (int)$_GET['step'];
}
list($fetch_php_bin_ret, $php_bin) = get_php_bin_dir();
switch ($step) {
    case 1:
        require('./include/var.php');
        env_check($env_items);
        dirfile_check($dirfile_items);
        function_check($func_items);
        extension_check($extension_items);
        break;
    case 2:
        $install_error = '';
        $install_recover = '';
        //step3($install_error, $install_recover);
        break;
    case 3:
        $install_error = '';
        $install_recover = '';
        $demo_data = file_exists('./data/utf8_add.sql') ? true : false;
        importSql($install_error, $install_recover);
        break;
    case 4:

        break;
    case 5:
        $sitepath = strtolower(substr($_SERVER['PHP_SELF'], 0, strrpos($_SERVER['PHP_SELF'], '/')));
        $sitepath = str_replace('install', "", $sitepath);
        $http_type = (
            (isset($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) == 'on')
            || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')
        ) ? 'https://' : 'http://';
        $auto_site_url = strtolower($http_type . $_SERVER['HTTP_HOST'] . $sitepath);
        break;
    default:
        # code...
        break;
}

include("step_{$step}.php");
