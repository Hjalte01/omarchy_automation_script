#!/bin/bash


URL="$1"

if [ -z "$URL" ]; then
  echo "Error: no URL provided(empty)"
  echo "Usage: $0 <url>"
  exit 1
fi 

firefox "$URL"
