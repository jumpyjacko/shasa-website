# Import database dump into MySQL container

$DB_CONTAINER = docker compose ps -q db
$DB_NAME = "db"
$DB_USER = "user"
$DB_PASS = "pass"
$DUMP_FILE = "./db-dump.sql"

if (-Not (Test-Path $DUMP_FILE)) {
    Write-Host "Database dump file $DUMP_FILE not found!"
    exit 1
}

Write-Host "Importing database from $DUMP_FILE..."

Get-Content $DUMP_FILE | docker exec -i $DB_CONTAINER mysql -u$DB_USER -p$DB_PASS $DB_NAME

Write-Host "Database import complete."
