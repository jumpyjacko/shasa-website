# SHASA Website
A functional mock-up of a [SHASA](https://shasa.com.au) website redesign with Wordpress.

## Project Overview
This repository includes a Wordpress website including content (no sensitive information) with dummy data and content copied from pages
on the original site. This is done via containers using Docker. Included are some workflow scripts for Mac and Windows (Using a bash terminal).

The website can be run on any Windows or Mac computers with `git`, `docker`, and a unix shell (Terminal on Mac and Bash on Windows).

A more comprehensive setup guide can be found on a Google Doc included with the assignment submission, under the "Repository Manual" page tab.

This repository is not made with production in mind and is mainly for mock-up website development, and plugin testing without having to run a
dedicated server.


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
