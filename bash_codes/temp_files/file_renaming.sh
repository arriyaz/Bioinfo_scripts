#! /bin/bash

PICTURES=$(ls *jpeg)
DATE=$(date +%F)

for x in $PICTURES
do
    echo "Renaming ${x} to ${DATE}-${x}"
    mv ${x} ${DATE}-${x}
done
