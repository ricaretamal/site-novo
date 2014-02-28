mysqldump -u root mst_novo blocks blocks_roles > mst-blocks.sql 
mysqldump -u root mst_novo views_view views_display > mst-views.sql
mysqldump -u root mst_novo boxes > mst-boxes.sql
mysqldump -u root mst_novo imagecache_preset imagecache_action > mst-imagecache.sql
mysqldump -u root mst_novo content_node_field content_node_field_instance content_type_product > mst-cck.sql
# mysqldump -u root mst_novo menu_links > mst-menu.sql
mysqldump -u root mst_novo uc_cart_products  uc_countries uc_order_admin_comments uc_order_comments uc_order_line_items uc_order_log uc_order_products  uc_order_statuses uc_orders uc_product_classes uc_product_features uc_products uc_store_footers uc_zones ca_predicates > mst-ubercart.sql
mysqldump -u root mst_novo system > mst-system.sql
