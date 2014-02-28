<?php
// $Id: page.tpl.php,v 1.28 2008/01/24 09:42:52 Exp $
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="<?php print $language->language ?>" xml:lang="<?php print $language->language ?>" dir="<?php print $language->dir ?>">

<head>
  <title><?php print $head_title ?></title>
  <?php print $head ?>
  <?php print $styles ?>
  <?php print $scripts ?>
<!--[if IE]>
<style type="text/css" media="screen">
body {behavior: url(sites/mst/themes/mst/csshover.htc);} 
</style>
<![endif]-->
  <script type="text/javascript"><?php /* Needed to avoid Flash of Unstyle Content in IE */ ?> </script>
</head>

<body>

<div id="wrapper">
    
<div id="header">

       <div id="logo">
      <?php if ($logo) { ?><a href="<?php print $front_page ?>" title="<?php print t('Home') ?>"><img src="<?php print $logo ?>" alt="<?php print t('Home') ?>" /></a><?php } ?>
      <?php if ($site_name) { ?><h1 class='site-name'><a href="<?php print $front_page ?>" title="<?php print t('Home') ?>"><?php print $site_name ?></a></h1><?php } ?>
    </div>

    <div id="menu">
    <?php print $header ?>
    </div>


</div>

<div id="content">
    <?php if ($left) { ?><div id="sidebar-left"><?php print $left ?></div><?php } ?>
    <div valign="top">
    </div>
      <div id="main">
	<?php if ($busca) { ?><div id="busca"><?php print $busca ?></div><?php } ?>
        <?php print $breadcrumb ?>

        <div id="container-content">
	<?php if (!$is_front) { ?>
 	  <h1 class="title"><?php print $title ?></h1>
          <div class="tabs"><?php print $tabs ?></div>
          <?php if ($show_messages) { print $messages; } ?>
          <?php print $help ?>
	<?php } ?>
	  <p>
          <?php print $content; ?>
	  </p>
        <div id="container-destaque">
          <?php if ($destaque1) { ?><div id="destaque1"><?php print $destaque1 ?></div><?php } ?>
          <?php if ($destaque2) { ?><div id="destaque2"><?php print $destaque2 ?></div><?php } ?>
	  <?php if ($listagem) { ?><div id="listagem"><?php print $listagem ?></div><?php } ?>
        </div>

        </div>
      <p id="container-feed"><?php print $feed_icons; ?></p>
      </div>
    <?php if ($right) { ?><div id="sidebar-right"><?php print $right ?></div><?php } ?>

</div>

<div id="footer">
  <?php print $footer_message ?>
  <?php print $footer ?>
</div>

</div>
<?php print $closure ?>
</body>
</html>
