<?php
// $Id: node.tpl.php,v 1.7 2007/08/07 08:39:36 goba Exp $
?>
  <div class="node<?php if ($sticky) { print " sticky"; } ?><?php if (!$status) { print " node-unpublished"; } ?>">
    <span class="submitted"><?php print $submitted?></span>
    <div class="content"><?php print $content?></div>
    <div class="taxonomy" style="width: 500px; float: left"><h3><?php print $terms?></h3>
<?php print $variables['imageGalleryNavigation']; ?></div>
    <?php if ($links) { ?><div class="links" style="width: 500px; float: left">&raquo; <?php print $links?></div><?php }; ?>
  </div>
