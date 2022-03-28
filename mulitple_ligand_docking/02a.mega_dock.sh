#!/bin/bash

# The script was prepared by: Anisur Rahman Riyaz
# Email: arriyaz.nstu@gmail.com

# Stop on any error.
set -ue

read -e -p "Please provide the name of conda environment: " ENVT 
read -e -p "What is your config file: " CONFIGFILE
read -e -p "Plase provide the PATH of ligands forlder: "  LIGANDPATH
read -e -p "What will be your ligand list name? " LIGANDLIST
read -e -p "What is the receptor name? " RECEPTOR

# Activate the dvf environment
eval "$(conda shell.bash hook)" 
conda activate ${ENVT}

# create necessary folder
mkdir -p ligand_names/ docking_results/${LIGANDLIST}

# List all ligand names
ls -1 ${LIGANDPATH} | grep .pdbqt > ligand_names/${LIGANDLIST}.txt
LIGAND=$(cat ligand_names/${LIGANDLIST}.txt)

# Create a run log file
echo "## List of completed ligands" > run_log.txt

# Create a csv file that will contain all results of ${i} together
echo "ligand,affinity (kcal/mol)" > docking_results/all_best_output.csv



for x in $LIGAND
do
## Perform docking
vina \
    --receptor ${RECEPTOR} \
    --config ${CONFIGFILE} \
    --ligand ${LIGANDPATH}/${x} \
    --log docking_results/${LIGANDLIST}/${x}.log \
    --out docking_results/${LIGANDLIST}/${x}_output


### Save result in the main result file
### Extract only the binding affinity of the first mode

# Open the log file
RESULT=$(cat docking_results/${LIGANDLIST}/${x}.log | \
    # Extract first four line of result
    grep -w mode -A 3 | \
    # take only result line
    tail -1 |   \
    # Replace multiple spaces with single space
    tr -s ' ' | \
    # Remove space from the begining of the line
    sed 's/^[ \t]*//' | \
    # Take only second column, which is the actual result
    cut -d " " -f2)

# Save into main csv file
echo "${x},${RESULT}" >> docking_results/all_best_output.csv

echo "Docking of ligand ${x} is done!!!"
echo "Completed     ${x}" >> run_log.txt

echo
echo

done


echo ".."
echo "...."
echo "Docking of ${LIGANDLIST} files is done"
echo "Good luck!!"

echo "................................................"
echo "This script was prepared by: Anisur Rahman Riyaz"
echo "Email: arriyaz.nstu@gmail.com"

echo
echo



