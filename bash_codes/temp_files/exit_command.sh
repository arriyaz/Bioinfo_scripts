#!/bin/bash

HOST="gle.com"

ping -c 1 $HOST
RETURN_CODE=$?

if [ "$RETURN_CODE" -ne "0" ]
then
    echo "$HOST unreachable"
    exit 1
fi

echo "$HOST reachable"
exit 0

