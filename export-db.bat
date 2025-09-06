@echo off
REM Import database dump into MySQL container

REM Set variables
SET DB_NAME=db
SET DB_USER=user
SET DB_PASS=pass
SET DUMP_FILE=db-dump.sql

IF NOT EXIST %DUMP_FILE% (
    echo Database dump file %DUMP_FILE% not found!
    pause
    exit /b 1
)

REM Get the container ID for the db service
FOR /F "tokens=*" %%i IN ('docker compose ps -q db') DO SET DB_CONTAINER=%%i

echo Importing database from %DUMP_FILE%...
docker exec -i %DB_CONTAINER% mysql -u%DB_USER% -p%DB_PASS% %DB_NAME% < %DUMP_FILE%
echo Database import complete.
pause
