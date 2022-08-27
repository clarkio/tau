#!/bin/bash

# setup postgres database. It needs to run twice because
# of something with containers :shrug:
./wait_for_postgres.py
./wait_for_postgres.py

# create our database schema
./manage.py migrate

# prepares all of the django static files excluding the tau dashboard (more on that later)
# make sure to type 'yes' when prompted
./manage.py collectstatic --noinput

# setup dependencies for the website client application
# and build the components for the client application
cd tau-dashboard
npm i
npm run build

# change back to the root directory and
# gather all of the static dashboard files and
# put them in a place to be hosted by django
cd ../
./manage.py collect_dashboard

# set up routes in the database so this django server can create
# routes that match API routes from Twitch's Helix API
./manage.py import_helix_endpoints helix_endpoints.json

# set up event sub endpoints in the database so this django server
# can subscribe to the respective event sub endpoints from Twitch
./manage.py import_eventsub_subscriptions eventsub_subscriptions.json


# *** Do the following manually on your own ***

# Part 1
# Open a new terminal (or tab) and run the following:
# Spin up the worker process to manage all of the websocket
# and webhook subscriptions to Twitch and also manage all of
# your Twitch API keys (e.g. renewing access tokens, etc.)
# ./manage.py worker

# Part 2
# Open a new terminal (or tab) and run the following
# Run the django server so we can access
# it from http://localhost:8000
# ./manage.py runserver
