#!/usr/bin/env bash

# usage
# ./delete.sh $API_KEY

if [ -z "$1" ]; then
  echo "No API_KEY supplied"
  exit 1
fi

API_KEY=$1

curl --request DELETE \
  --url https://api.tidbyt.com/v0/devices/virulently-courageous-pleasing-boxer-d48/installations/nycbustime \
  --header "Authorization: Bearer $API_KEY" \
  --header "Content-Type: application/json"
