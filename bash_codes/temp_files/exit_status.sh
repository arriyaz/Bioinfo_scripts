
#!/bin/bash

read -p "Please enter the host url: " HOST

#HOST="google.com"

ping -c 1 $HOST

RETURN_CODE=$?

if [ "$RETURN_CODE" -eq "0" ]
then
    echo "$HOST reachable."
else
    echo "$HOST unreachable."
fi
