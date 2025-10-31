# SHASA Website
A functional mock-up of a [SHASA](https://shasa.com.au) website redesign with Wordpress.


## Development Setup
Install `git` and `docker`

Open a terminal in this directory. (Use Git Bash terminal on Windows)

### First time build
Run `docker compose up --build`.

After it finishes building, press `<Ctrl+C>` to stop the website.

### Running the website
Run `docker compose up -d`.
Run `./import-db.sh`.

Go to `http://localhost:8080`. (Ensure you are using `http` not `https`).

### Admin Panel
Go to `http://localhost:8080/wp-admin`. The username is `user` and password is `pass`.
