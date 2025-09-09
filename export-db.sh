#!/bin/bash
# Export database from MySQL container

DB_CONTAINER=$(docker compose ps -q db)
DB_NAME="db"
DB_USER="user"
DB_PASS="pass"
DUMP_FILE="./db-dump.sql"

echo "Exporting database to $DUMP_FILE..."
docker exec -i $DB_CONTAINER mysqldump --no-tablespaces -u$DB_USER -p$DB_PASS $DB_NAME > $DUMP_FILE
echo "Database export complete."
