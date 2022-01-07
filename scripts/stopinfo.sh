#!/usr/bin/env bash

# usage
# ./stopinfo.sh $API_KEY 550685

if [ -z "$1" ]; then
  echo "No API_KEY supplied"
  exit 1
fi

if [ -z "$2" ]; then
  echo "No STOP_ID supplied"
  exit 1
fi

API_KEY=$1
STOP_ID=$2

curl "http://bustime.mta.info/api/where/stop/MTA_$STOP_ID.json?key=$API_KEY" \
  | jq > results/stopinfo.json
