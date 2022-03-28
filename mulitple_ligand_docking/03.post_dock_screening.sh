#!/bin/bash

# The script was prepared by: Anisur Rahman Riyaz
# Email: arriyaz.nstu@gmail.com

# Use openbable 3.1.0 or above version.

# Stop on any error.
set -ue

# Check if the system cotains cowsay command
if ! command -v cowsay &> /dev/null
then
    echo "	Command 'cowsay' could not be found"
    echo "	You can install it by using following commamd: "
    echo 
    echo "	sudo apt install cowsay"
    echo
	
    exit
fi

# Get the input
read -e -p "Please provide the name of conda environment: " ENVT 
read -e -p "Please provide the threshold value (with minus sign): " VALUE 
read -e -p "What is the path of the csv files: " CSVPATH
read -e -p "What is the path of the sdf files: " SDFPATH


# Activate the dvf environment
eval "$(conda shell.bash hook)" 
conda activate ${ENVT}


mkdir -p screened_ligands SMILES

# If SMILES directory contains previous files remove them.
if [ -n "$(ls -A SMILES/ 2> /dev/null)" ]
then
  echo "SMILES directory cotains previous files."
  echo "Removing them........"
  sleep 1s
  rm -rf SMILES/*.txt
fi

LIGANDNAME=$(ls -1 all_csv | sed 's/_output.csv//g' | sed 's/all_//g')

for FILE in $(find ${CSVPATH} -type f -name "*.csv")

do

LIGANDNAME=$(basename $FILE | sed 's/_output.csv//g' | sed 's/all_//g')
awk -v var=$VALUE -F "," 'NR==1 || $2 < var1 && $2 != NULL {print $0}' $FILE > screened_ligands/${LIGANDNAME}_screened.csv

CSVFILE=screened_ligands/${LIGANDNAME}_screened.csv


# Create a textfile for each LIGAND
touch SMILES/${LIGANDNAME}_SMILES.txt

IDS=$(cat $CSVFILE | cut -d ',' -f 1 | sed 's/.pdbqt//g' | sed 1d)

for SDF in $IDS
do

echo "Generating Canonical SMILES for ${SDF}.sdf"
obabel \
	${SDFPATH}/${LIGANDNAME}_split/${SDF}.sdf -ocan >> SMILES/${LIGANDNAME}_SMILES.txt


# End of second for loop
done
echo 
cowsay Splitting ${LIGANDNAME}_SMILES.txt file
echo ...
echo ....
echo .....
sleep 2s

## Now split SMILES files so that each file contain no more than 500 SMILES
## We are splitting these file so that we can use each file as input for ADMETlab 2.0 webserver
## Here, ${LIGANDNAME}_SMILES will use as PREFIX for each splitted



split \
	-l 500 \
	-d \
	SMILES/${LIGANDNAME}_SMILES.txt \
	SMILES/${LIGANDNAME}_SMILES_ \
	--additional-suffix=.txt

rm -rf SMILES/${LIGANDNAME}_SMILES.txt

# End of first for loop
done



