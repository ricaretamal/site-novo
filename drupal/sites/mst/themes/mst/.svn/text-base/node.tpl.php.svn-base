<?php
// $Id: node.tpl.php,v 1.7 2007/08/07 08:39:36 goba Exp $
?>
  <div class="node<?php if ($sticky) { print " sticky"; } ?><?php if (!$status) { print " node-unpublished"; } ?>">
    <?php if ($picture) {
      print $picture;
    }?>
    <?php if ($page == 0) { ?>
<!-- pagina inicial -->
<h2 class="title"><a href="<?php print $node_url?>"><?php print $title?></a></h2>
    <div class="content"><a href="<?php print $node_url?>"><?php print $content?></a></div>
<!-- todas as outras -->
<?php } else { ?>

    <span class="submitted"><?php print $submitted?></span>
    <div class="content"><?php print $content?></div>
    <div class="taxonomy"><h3><?php print $terms?></h3></div>
    <?php if ($links) { ?><div class="links">&raquo; <?php print $links?></div><?php }; ?>
<?php }; ?>
  </div>
