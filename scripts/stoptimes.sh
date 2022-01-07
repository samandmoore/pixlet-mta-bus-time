#!/usr/bin/env bash

# usage
# ./stoptimes.sh $API_KEY 550685

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

curl http://bustime.mta.info/api/siri/stop-monitoring.json \
  --data-urlencode "key=$API_KEY" \
  --data-urlencode "version=2" \
  --data-urlencode "MonitoringRef=$STOP_ID" \
  | jq > results/stoptimes.json
