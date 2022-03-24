#!/bin/bash

read -p "Please provide your commit message: " MSG

# Add all
git add .

# Git commit with a argument parameter
git commit -m "${MSG}"

# push the changes
git push
