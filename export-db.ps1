# Export database from MySQL container

$DB_CONTAINER = docker compose ps -q db
$DB_NAME = "db"
$DB_USER = "user"
$DB_PASS = "pass"
$DUMP_FILE = "./db-dump.sql"

Write-Host "Exporting database to $DUMP_FILE..."

docker exec -i $DB_CONTAINER mysqldump --no-tablespaces -u$DB_USER -p$DB_PASS $DB_NAME | Out-File -FilePath $DUMP_FILE -Encoding utf8

Write-Host "Database export complete."
