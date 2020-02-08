<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title><?php echo $html_title;?></title>
<link href="css/install.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery.js"></script>
<script>
$(document).ready(function(){
    $('#next').on('click',function(){
        if (typeof($('.no').html()) == 'undefined'){
            $(this).attr('href','index.php?step=2');
        }else{
            alert($('.no').eq(0).parent().parent().find('td:first').html()+' Check Failed!');
            $(this).attr('href','###');
        }
    });
});
</script>
</head>
<body>
<?php echo $html_header;?>
<div class="main">
  <div class="step-box" id="step1">
    <div class="text-nav">
      <h1>1</h1>
      <h2>Installation</h2>
      <h5>Check Server Environment & Permissions</h5>
    </div>
    <div class="procedure-nav">
      <div class="schedule-ico"><span class="a"></span><span class="b"></span><span class="c"></span><span class="d"></span></div>
      <div class="schedule-point-now"><span class="a"></span><span class="b"></span><span class="c"></span><span class="d"></span></div>
      <div class="schedule-point-bg"><span class="a"></span><span class="b"></span><span class="c"></span><span class="d"></span></div>
      <div class="schedule-line-now"><em></em></div>
      <div class="schedule-line-bg"></div>
      <div class="schedule-text"><span class="a">Env Setup</span><span class="b">Server Setup</span><span class="c">Database Setup</span><span class="d">Install</span></div>
    </div>
  </div>
  <div class="content-box">
    <table width="100%" border="0" cellspacing="2" cellpadding="0">
      <caption>
      Environment Check List
      </caption>
      <tr>
        <th scope="col">Check List</th>
        <th width="25%" scope="col">Minimum Requirement</th>
        <th width="25%" scope="col">Recommended</th>
        <th width="25%" scope="col">Current Setup</th>
      </tr>
      <?php foreach($env_items as $v){?>
      <tr>
        <td scope="row"><?php echo $v['name'];?></td>
        <td><?php echo $v['min'];?></td>
        <td><?php echo $v['good'];?></td>
        <td><span class="<?php echo $v['status'] ? 'yes' : 'no';?>"><i></i><?php echo $v['cur'];?></span></td>
      </tr>
      <?php }?>
    </table>
    <table width="100%" border="0" cellspacing="2" cellpadding="0">
      <caption>
      File Permission Check List
      </caption>
      <tr>
        <th scope="col">Directory</th>
        <th width="25%" scope="col">Required</th>
        <th width="25%" scope="col">Current</th>
      </tr>
      <?php foreach($dirfile_items as $k => $v){?>
      <tr>
        <td><?php echo $v['path'];?> </td>
        <td><span>Read/Write</span></td>
        <td><span class="<?php echo $v['status'] == 1 ? 'yes' : 'no';?>"><i></i><?php echo $v['status'] == 1 ? 'Read/Write' : 'Read Only';?></span></td>
      </tr>
      <?php }?>
    </table>
      <table width="100%" border="0" cellspacing="2" cellpadding="0">
          <caption>
          Extension Check List
          </caption>
          <tr>
              <th scope="col">Extension</th>
              <th width="25%" scope="col">Required</th>
              <th width="25%" scope="col">Current</th>
          </tr>
          <?php foreach($extension_items as $k =>$v){?>
              <tr>
                  <td><?php echo $v['name'];?></td>
                  <td><span>Install</span></td>
                  <td><span class="<?php echo $v['status'] == 1 ? 'yes' : 'no';?>"><i></i><?php echo $v['status'] == 1 ? 'Installed' : 'Not Installed';?></span></td>
              </tr>
          <?php }?>
      </table>
    <table width="100%" border="0" cellspacing="2" cellpadding="0">
      <caption>
      Function Check List
      </caption>
      <tr>
        <th scope="col">Directory</th>
        <th width="25%" scope="col">Required</th>
        <th width="25%" scope="col">Current</th>
      </tr>
      <?php foreach($func_items as $k =>$v){?>
      <tr>
        <td><?php echo $v['name'];?>()</td>
        <td><span>Supported</span></td>
        <td><span class="<?php echo $v['status'] == 1 ? 'yes' : 'no';?>"><i></i><?php echo $v['status'] == 1 ? 'Supported' : 'Not Supported';?></span></td>
      </tr>
      <?php }?>

    </table>
  </div>
    <div class="btn-box" style="text-align:left">Note: Grant Read/Write Access to Current PHP User, Linux Example: chown -R www:www /var/lib/php/session </div>

  <div class="btn-box"><a href="index.php" class="btn btn-primary">Previous</a><a href='##' id="next" class="btn btn-primary">Next</a></div>
</div>
<?php echo $html_footer;?>
</body>
</html>
