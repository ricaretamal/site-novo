#!/bin/sh

# DB data
DB_NEW="mst_novo"
DB_OLD="mst_antigo"
USER="root";
PASS=""

# HOST data
HOST="http://mst.localhost"


echo "-----------------------"
echo "Criando banco zerado..."
echo ""
mysqladmin -fu $USER -p$PASS drop $DB_NEW && echo "OK" || echo "[ERRO] ao dropar $DB_NEW"
mysqladmin -u $USER -p$PASS create $DB_NEW && echo "OK" || echo "[ERRO] ao criar $DB_NEW"
echo "-----------------------"

echo "Subindo sql base..."
mysql -u $USER -p$PASS $DB_NEW < mst-completo.sql && echo "OK" || echo "[ERRO] ao subir mst-completo.sql"
mysql -u $USER -p$PASS $DB_NEW < mst-extra.sql && echo "OK" || echo "[ERRO] ao subir mst-extra.sql"
echo "-----------------------"

echo "Subindo paginas, blocks, menus, views..."
mysql -u $USER -p$PASS $DB_NEW < mst-paginas.sql && echo "OK" || echo "[ERRO] ao subir mst-paginas.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-cache.sql && echo "OK" || echo "[ERRO] ao subir mst-cache.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-views.sql && echo "OK" || echo "[ERRO] ao subir mst-views.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-blocks.sql && echo "OK" || echo "[ERRO] ao subir mst-blocks.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-boxes.sql && echo "OK" || echo "[ERRO] ao subir mst-boxes.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-menu.sql && echo "OK" || echo "[ERRO] ao subir mst-menu.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-cck.sql && echo "OK" || echo "[ERRO] ao subir mst-cck.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-imagecache.sql && echo "OK" || echo "[ERRO] ao subir mst-imagecache.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-locales.sql && echo "OK" || echo "[ERRO] ao subir mst-locales.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-system.sql && echo "OK" || echo "[ERRO] ao subir mst-system.sql!"
mysql -u $USER -p$PASS $DB_NEW < mst-ubercart.sql && echo "OK" || echo "[ERRO] ao subir mst-ubercart.sql!"



echo "-----------------------"

echo "Importando secoes..."
wget -q -P /tmp $HOST/sites/mst/tools/01-migrador-secoes.php && echo "OK" || echo "[ERRO] ao importar secoes!"
echo "-----------------------"

echo "Importando revistas, especiais, jornais e paginas..."
wget -q -P /tmp $HOST/sites/mst/tools/02-migrador-edicoes.php && echo "OK" || echo "[ERRO] ao importar revistas, especias, jornais e paginas!"
echo "-----------------------"

echo "Subindo termos"
mysql -u $USER -p$PASS $DB_NEW < mst-term.sql && echo "OK" || echo "[ERRO] ao subir mst-term.sql!"
echo "-----------------------"

echo "Importando imagens..."
wget -q -P /tmp $HOST/sites/mst/tools/03-migrador-imagens.php && echo "OK" || echo "[ERRO] ao importar imagens!"
echo "-----------------------"

echo "Importando mural..."
wget -q -P /tmp $HOST/sites/mst/tools/04-migrador-comments.php && echo "OK" || echo "[ERRO] ao importar mural!"
echo "-----------------------"
