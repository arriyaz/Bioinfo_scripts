#!/bin/bash



# Clean everything in the temp directory older than 30 days
find "$HOME/temp" -mindepth 1 -mtime +30 -depth -exec rm -rf {} \;

# Clean old files from the Downloads folder (uncomment to activate the code)
find "$HOME/Downloads" -mindepth 1 -mtime +40 -depth -exec rm -rf {} \;
