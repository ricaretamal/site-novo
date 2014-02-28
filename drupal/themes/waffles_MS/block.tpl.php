<!-- start block.tpl.php -->
<div class="block-wrapper <?php print $block_zebra; ?>">
  
      
        <div id="block-<?php print $block->module .'-'. $block->delta; ?>" class="block block-<?php print $block->module ?>">
          <?php if ($block->subject): ?>
            <?php if ($rounded_block): ?>
          <div class="block-icon pngfix"></div>
            <?php endif; ?>
          <h2 class="title block-title pngfix"><?php print $block->subject ?></h2>
          <?php endif; ?>
          <div class="content">
            <?php print $block->content ?>
          </div>
        </div>
  
  
  
</div>
<!-- /end block.tpl.php -->
