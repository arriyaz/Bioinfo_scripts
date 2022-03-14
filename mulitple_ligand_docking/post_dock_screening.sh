#!/bin/bash

# The script was prepared by: Anisur Rahman Riyaz
# Email: arriyaz.nstu@gmail.com

# Use openbable 3.1.0 or above version.

# Stop on any error.
set -ue

# Get the input
read -e -p "Please provide the name of conda environment: " ENVT 
read -e -p "Please provide the threshold value (with minus sign): " VALUE 
read -e -p "What is the path of the csv files: " CSVPATH
read -e -p "What is the path of the sdf files: " SDFPATH


# Activate the dvf environment
eval "$(conda shell.bash hook)" 
conda activate ${ENVT}


mkdir -p screened_ligands


LIGANDNAME=$(ls -1 all_csv | sed 's/_output.csv//g' | sed 's/all_//g')

for FILE in $(find ${CSVPATH} -type f -name "*.csv")

do

LIGANDNAME=$(basename $FILE | sed 's/_output.csv//g' | sed 's/all_//g')
awk -v var=$VALUE -F "," 'NR==1 || $2 < var1 && $2 != NULL {print $0}' $FILE > screened_ligands/${LIGANDNAME}_screened.csv

CSVFILE=screened_ligands/${LIGANDNAME}_screened.csv

mkdir -p SMILES
touch SMILES/${LIGANDNAME}_SMILES.txt

IDS=$(cat $CSVFILE | cut -d ',' -f 1 | sed 's/.pdbqt//g' | sed 1d)

for SDF in $IDS
do

echo "Generating Canonical SMILES for ${SDF}.sdf"
obabel \
	${SDFPATH}/${LIGANDNAME}_split/${SDF}.sdf -ocan >> SMILES/${LIGANDNAME}_SMILES.txt

# End of second for loop
done 

# End of first for loop
done

