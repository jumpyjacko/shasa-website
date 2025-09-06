@echo off
REM Export database from MySQL container

REM Set variables
SET DB_NAME=db
SET DB_USER=user
SET DB_PASS=pass
SET DUMP_FILE=db-dump.sql

REM Get the container ID for the db service
FOR /F "tokens=*" %%i IN ('docker compose ps -q db') DO SET DB_CONTAINER=%%i

echo Exporting database to %DUMP_FILE%...
docker exec -i %DB_CONTAINER% mysqldump --no-tablespaces -u%DB_USER% -p%DB_PASS% %DB_NAME% > %DUMP_FILE%
echo Database export complete.
pause
