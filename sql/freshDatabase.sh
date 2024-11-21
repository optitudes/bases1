#!/bin/bash
# este script sirve para refrescar la base de datos con el archivo db.sql 

# Configuración de la base de datos
DB_USER="root"
DB_PASSWORD="mundoc"
DB_NAME="bases1"
SQL_FILE="db.sql"

# Paso 1: Conectar a MySQL y eliminar y crear la base de datos
mysql -u $DB_USER -p$DB_PASSWORD <<EOF
DROP DATABASE IF EXISTS $DB_NAME;
CREATE DATABASE $DB_NAME;
EXIT
EOF

# Paso 2: Importar la información desde el archivo SQL
mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME < $SQL_FILE

echo "La base de datos $DB_NAME ha sido recreada e inicializada con éxito."

