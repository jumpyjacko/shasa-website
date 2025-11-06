#!/bin/sh
set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

SECONDS=0

echo -e "\033[32m --== Starting Wordpress website ==-- \033[0m"

(
    set +e
    echo "Pulling latest from git..."
    echo -e "\033[90m"
    git pull
    echo -e "\033[0m"
)

if ! docker compose ps >/dev/null 2>&1; then
    echo "First run, building containers..."
    docker compose up -d --build
else
    echo "Starting containers..."
    docker compose up -d
fi

echo ""
echo "Waiting for containers to be ready..."
sp='|/-\'
end=$((SECONDS + 15))
while [ $SECONDS -lt $end ]; do
  printf "\r${CYAN}${sp:i++%${#sp}:1}${RESET}"
  sleep 0.1
done
while [ "$(docker compose ps --services --filter "status=running" | wc -l)" -lt "$(docker compose ps --services | wc -l)" ]; do
  echo "Still starting up..."
  sleep 10
done

echo -e "\033[32m    Done!\033[0m"

echo ""
echo "Running post-start scripts..."
echo -e "\033[90m"
./import-db.sh
echo -e "\033[0m"

duration=$SECONDS
echo -e "\033[32m"
printf "Containers started in %dm %ds\n" $((duration / 60)) $((duration % 60))
echo -e "\033[0m"

echo -e "\033[90mContainers started and healthy.\033[0m"
echo -e "Website is found at: \033[34mhttp://localhost:8080\033[0m"
echo -e " Admin dashboard at: \033[34mhttp://localhost:8080/wp-admin\033[0m"
echo -e " Admin credentials are:"
echo -e "    username: \033[34muser\033[0m"
echo -e "    password: \033[34mpass\033[0m"

echo -e "\033[38;5;248m"
echo -e "To save changes to the website, run:"
echo -e "    ./export-db.sh"
echo -e "Stop the containers with:"
echo -e "    docker compose down"
echo -e "Clean up containers and volumes (will reset to first-build state), run:"
echo -e "    docker compose down --rmi all --volumes --remove-orphans"
echo -e "\033[0m"
