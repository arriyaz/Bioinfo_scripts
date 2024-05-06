#! /bin/bash 

# clean everything in the temp directory older than 30 days find
$HOME/temp/* -mtime +30 -exec rm -rf {} \;
