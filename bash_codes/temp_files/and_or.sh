#!/bin/bash

HOST="gle.com"

# ping -c 1 $HOST && echo "$HOST reachable."

ping -c 1 $HOST || echo "$HOST unreachable."