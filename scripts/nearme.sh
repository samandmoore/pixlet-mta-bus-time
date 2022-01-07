#!/usr/bin/env bash

# usage
# ./nearme.sh $API_KEY

if [ -z "$1" ]; then
  echo "No API_KEY supplied"
  exit 1
fi

API_KEY=$1

curl "http://bustime.mta.info/api/where/stops-for-location.json?lat=40.765302&lon=-73.931708&latSpan=0.005&lonSpan=0.005&key=$API_KEY" \
  | jq > results/nearme.json
