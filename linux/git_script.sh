#!/bin/bash

read -p "Please provide your commit message: " MSG


# Add files to stage
git add .

# Git commit with a argument parameter
git commit -a -m "${MSG}"

# push the changes
git push

# Show a message
echo
echo "Your changes are updated."


