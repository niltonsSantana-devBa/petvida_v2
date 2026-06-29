#!/bin/bash
# Script de backup do banco petvida_v2
# Uso: ./database/backup/script.sh
# O arquivo será salvo em: database/backup/files/

DATA=$(date +%Y%m%d_%H%M%S)
ARQUIVO="files/petvida_${DATA}.sql"
USER="root"
PASSWORD="NILton@1112"
DATABASE="petvida_v2"

mysqldump -u "$USER" -p"$PASSWORD" "$DATABASE" --result-file="$ARQUIVO"

echo "Backup criado: database/backup/$ARQUIVO"
