#!/bin/bash

read -p "Please provide your commit message : " MSG


# Git commit with a argument parameter
git commit -a -m "${MSG}"

# push the changes
git push
