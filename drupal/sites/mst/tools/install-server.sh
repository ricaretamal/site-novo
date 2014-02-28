#!/bin/sh

# DB data
DB_NEW="mst2"
DB_OLD="mst"
USER="mst2";
PASS="d#s3j)sdAt5rR$"

# HOST data
HOST="http://www2.mst.org.br/drupal"


echo "-----------------------"
echo "Criando banco zerado..."
echo "(digite senha de root)"
echo ""
mysqladmin -fu root -p drop $DB_NEW && echo "OK" || echo "[ERRO] ao dropar $DB_NEW"
mysqladmin -u root  -p create $DB_NEW && echo "OK" || echo "[ERRO] ao criar $DB_NEW"
echo "-----------------------"

echo "Subindo sql base..."
echo "(digite senha normal daqui em diante)"
mysql -u $USER -p $DB_NEW < mst-completo.sql && echo "OK" || echo "[ERRO] ao subir mst-completo.sql"
mysql -u $USER -p $DB_NEW < mst-extra.sql && echo "OK" || echo "[ERRO] ao subir mst-extra.sql"
echo "-----------------------"

echo "Subindo paginas, blocks, menus, views..."
mysql -u $USER -p $DB_NEW < mst-paginas.sql && echo "OK" || echo "[ERRO] ao subir mst-paginas.sql!"
mysql -u $USER -p $DB_NEW < mst-cache.sql && echo "OK" || echo "[ERRO] ao subir mst-cache.sql!"
mysql -u $USER -p $DB_NEW < mst-views.sql && echo "OK" || echo "[ERRO] ao subir mst-views.sql!"
mysql -u $USER -p $DB_NEW < mst-blocks.sql && echo "OK" || echo "[ERRO] ao subir mst-blocks.sql!"
mysql -u $USER -p $DB_NEW < mst-boxes.sql && echo "OK" || echo "[ERRO] ao subir mst-boxes.sql!"
mysql -u $USER -p $DB_NEW < mst-menu.sql && echo "OK" || echo "[ERRO] ao subir mst-menu.sql!"
mysql -u $USER -p $DB_NEW < mst-cck.sql && echo "OK" || echo "[ERRO] ao subir mst-cck.sql!"
mysql -u $USER -p $DB_NEW < mst-imagecache.sql && echo "OK" || echo "[ERRO] ao subir mst-imagecache.sql!"
mysql -u $USER -p $DB_NEW < mst-locales.sql && echo "OK" || echo "[ERRO] ao subir mst-locales.sql!"
mysql -u $USER -p $DB_NEW < mst-system.sql && echo "OK" || echo "[ERRO] ao subir mst-system.sql!"
mysql -u $USER -p $DB_NEW < mst-ubercart.sql && echo "OK" || echo "[ERRO] ao subir mst-ubercart.sql!"

echo "Rode o $HOST/sites/mst/tools/01-migrador-secoes.php"
echo "Rode o $HOST/sites/mst/tools//02-migrador-edicoes.php"
echo "Importe a tabela mst-term"
echo "Rode $HOST/sites/mst/tools/03-migrador-imagens.php"
echo "Rode $HOST/sites/mst/tools/04-migrador-comments.php"

