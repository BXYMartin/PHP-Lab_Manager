<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title><?php echo $html_title;?></title>
    <link href="css/install.css" rel="stylesheet" type="text/css">
    <link href="css/perfect-scrollbar.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/perfect-scrollbar.min.js"></script>
    <script type="text/javascript" src="js/jquery.mousewheel.js"></script>
</head>
<body>
<?php echo $html_header;?>
<div class="main">
    <div class="text-box" id="text-box">
        <div class="license">
            <h1>License Agreement</h1>
            <p>To be filled.</p>
            <h3>I. Detailed</h3>
            <ol>
                <li></li>
            </ol>
            <p></p>
            <p align="right">Company</p>
        </div>
    </div>
    <div class="btn-box"><a href="index.php?step=1" class="btn btn-primary">Agree and Proceed</a><a href="javascript:window.close()" class="btn">Cancel</a></div>
</div>
<?php echo $html_footer;?>
<script type="text/javascript">
    $(document).ready(function(){
        //自定义滚定条
        $('#text-box').perfectScrollbar();
    });
</script>
</body>
</html>
