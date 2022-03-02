#!bin/bash

# The script was prepared by: Anisur Rahman Riyaz
# Email: arriyaz.nstu@gmail.com

read -e -p "Please provide the name of conda environment: " ENVT 
read -e -p "What is your config file: " CONFIGFILE
read -e -p "What is the path of your main compounds folder: " COMPOUNDPATH

echo
echo


# Activate the dvf environment
eval "$(conda shell.bash hook)" 
conda activate ${ENVT}

# Create a run log file
echo "## List of completed ligands" > run_log.txt

# Create a directory to save ligand list
mkdir -p ligand_names/

# List the main name of ligand compound
COMPOUNDS=$(ls -1 ${COMPOUNDPATH}/)

for i in $COMPOUNDS
do

# Create result directory for each compound
mkdir -p docking_results/${i}


# List all ligand names
ls -1 ${COMPOUNDPATH}/${i} | grep .pdbqt > ligand_names/${i}.txt

# Save ligand name in a variable
LIGAND=$(cat ligand_names/${i}.txt)


# Create a csv file that will contain all results of ${i} together
echo "ligand,affinity (kcal/mol)" > docking_results/${i}/all_${i}_output.csv


for x in $LIGAND
do
## Perform docking
vina \
    --config ${CONFIGFILE} \
    --ligand ${COMPOUNDPATH}/${i}/${x} \
    --log docking_results/${i}/${x}.log \
    --out docking_results/${i}/${x}_output


### Save result in the main result file
### Extract only the binding affinity of the first mode

# Open the log file
RESULT=$(cat docking_results/${i}/${x}.log | \
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
echo "${x},${RESULT}" >> docking_results/${i}/all_${i}_output.csv

echo
echo
# End of 2nd for loop
done

echo "Docking of ${i} files is done"
echo "Completed     ${i}" >> run_log.txt

# End 1st for loop
done

echo ".."
echo "...."
echo "All docking is done"
echo "Good luck!!"

echo "................................................"
echo "This script was prepared by: Anisur Rahman Riyaz"
echo "Email: arriyaz.nstu@gmail.com"

echo
echo





