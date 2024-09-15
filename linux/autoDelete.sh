#!/bin/bash

# Clean everything in the temp directory older than 30 days
find "$HOME/temp" -mindepth 1 -mtime +30 -depth -exec rm -rf {} \;
