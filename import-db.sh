#!/bin/bash
# Import database dump into MySQL container

DB_CONTAINER=$(docker compose ps -q db)
DB_NAME="db"
DB_USER="user"
DB_PASS="pass"
DUMP_FILE="./db-dump.sql"

if [ ! -f "$DUMP_FILE" ]; then
  echo "Database dump file $DUMP_FILE not found!"
  exit 1
fi

echo "Importing database from $DUMP_FILE..."
docker exec -i $DB_CONTAINER mysql -u$DB_USER -p$DB_PASS $DB_NAME < $DUMP_FILE
echo "Database import complete."

