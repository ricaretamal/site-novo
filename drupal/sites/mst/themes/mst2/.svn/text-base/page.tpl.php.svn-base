<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="<?php print $language->language; ?>" xml:lang="<?php print $language->language; ?>">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><?php print $head_title; ?></title>
    <?php print $head; ?>
    <?php print $styles; ?>
    <?php print $scripts; ?>
    <!--
      Using conditional comments to load some CSS files with specific styles and CSS hacks for IE.
      There are some non-standard hacks that relate to all IE versions and some
      That are needed only for IE6 (or lower if your theme supports it),
      so I added two different files - one for all IE versions and one for IE6 and below.
      Hopefully, IE8 and above won't need any of this mess.
      For more information: http://msdn.microsoft.com/en-us/library/ms537512.aspx
    -->
    <!--[if IE]>
	<link rel="stylesheet" href="<?php print $base_path . path_to_theme() ?>/ie.css" type="text/css" media="screen" charset="utf-8" />
	<style type="text/css" media="screen">
	body {behavior: url(sites/mst/themes/mst2/csshover.htc);} 
	</style>
	<?php if ($language->dir == 'rtl') :?>
	<link rel="stylesheet" href="<?php print $base_path . path_to_theme() ?>/ie-rtl.css" type="text/css" media="screen" charset="utf-8" />
      <?php endif ?>
    <![endif]-->
    <!--[if lt IE 7]>
      <link rel="stylesheet" href="<?php print $base_path . path_to_theme() ?>/ie6.css" type="text/css" media="screen" charset="utf-8" />
      <?php if ($language->dir == 'rtl') :?>
      <link rel="stylesheet" href="<?php $base_path . print path_to_theme() ?>/ie6-rtl.css" type="text/css" media="screen" charset="utf-8" />
      <?php endif ?>
    <![endif]-->

  </head>
  <body class="<?php print $body_classes; ?>">
    <div id="page">
      <div id="header">
        <div id="header_content">
          <?php if ($logo): ?>
          <div id="site-logo">
            <a href="<?php print $base_path; ?>" title="<?php print t('Home'); ?>" rel="home"><img src="<?php print $logo; ?>" alt="<?php print t('Home'); ?>" id="logo-image" /></a>
          </div>
          <?php endif; ?>
          <!-- /logo -->


          <div id="site-details">
            <?php if ($site_name): ?>
            <h1 id='site-name'>
              <a href="<?php print $base_path; ?>" title="<?php print t('Home'); ?>" rel="home"><?php print $site_name; ?></a>
            </h1>
            <?php endif; ?>
            <!-- /site-name -->

            <?php if ($site_slogan): ?>
            <blockquote id='site-slogan'>
              <?php print $site_slogan; ?>
            </blockquote>
            <?php endif; ?>
            <!-- /site-slogan -->

          </div>
          <!-- /site-details -->
    
          <?php if ($header): ?>
          <div id="header-blocks">
            <?php print $header; ?>
          </div>
          <?php endif; ?>
          <!-- /header-blocks -->
        </div>

        <?php if ($main_nav): ?>
        <div id="main-nav">
          <?php print $main_nav; ?>
        </div>
        <?php endif; ?>
        <!-- /main-nav -->
      </div>
      <!-- /header -->

      <div id="main">
	
	<?php if ($left): ?>
        <div id="sidebar-left">
          <?php print $left; ?>
        </div>
        <?php endif; ?>
        <!-- /sidebar-left -->

        <?php if ($right): ?>
        <div id="sidebar-right">
          <?php print $right; ?>
        </div>
        <?php endif; ?>
        <!-- /sidebar-right -->

        <div id="content">
          <?php if (!empty($tabs)): ?>
          <div class="tabs">
            <?php print $tabs; ?>
          </div>
          <?php endif; ?>
          <!-- /tabs -->

         <?php if ($breadcrumb or $title or $help or $messages): ?>
         <div id="content-header">
           <?php print $breadcrumb; ?>
           <?php print $messages; ?>
           <?php print $help; ?>
           <?php if ($title): ?>
           <div class="content-title">
             <h2 class="title">
               <?php print $title; ?>
                 </h2>
               </div>
           <?php endif; ?>
         </div>
         <?php endif; ?>
         <!-- /content-header -->

         <?php if ($mission): ?>
         <div id="mission">
           <?php print $mission; ?>
         </div>
         <?php endif; ?>
         <!-- /mission -->

         <?php if (!empty($content_top)):?>
         <div id="content-top">
           <?php print $content_top; ?>
         </div>
         <?php endif; ?>
         <!-- /content-top -->

         <?php if (!empty($content)):?>
         <div id="content-area">
           <?php print $content; ?>
         </div>
         <?php endif; ?>
         <!-- /content -->

         <?php if (!empty($content_bottom)):?>
         <div id="content-bottom">
           <?php print $content_bottom; ?>
         </div>
         <?php endif; ?>
         <!-- /content-bottom -->
        </div>
      </div>
      <!-- /main -->
      <div id="footer">
        <?php print $footer; ?>
        <p id="footer-message"><?php print $footer_message; ?></p>
      </div>
      <!-- /footer-wrap -->      
    </div>
    <!-- /page -->
    <?php print $closure; ?>
  </body>
</html>
