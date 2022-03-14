#!/bin/bash

# The script was prepared by: Anisur Rahman Riyaz
# Email: arriyaz.nstu@gmail.com

# Use openbable 3.1.0 or above version.


# Stop on any error.
set -ue

# Get the input
read -e -p "Please provide the name of conda environment: " ENVT 
read -e -p "Please provide the path of the folder which contain sdf files: " SDFFILEPATH

echo
echo


# Activate the dvf environment
eval "$(conda shell.bash hook)" 
conda activate ${ENVT}


# List the name of sdf files and remove .sdf extension from the names
names=$(ls -1 ${SDFFILEPATH}/ | sed 's/.sdf//g')

for x in $names
do

# Create necessary directory
mkdir -p split_sdfs/${x}_split all_pdbqt/${x}

echo
echo
echo "Echo splitting the ${x} file"
echo
echo

# Split the multi sdf file into into separate sdf files
obabel \
    -isdf ${SDFFILEPATH}/${x}.sdf \
    -osdf \
    -O split_sdfs/${x}_split/*.sdf\
    --split


# Deleting the files with zero size
find split_sdfs/${x}_split/ -size 0 -print -delete

echo
echo
echo "Minimizing the energy of ${x} ligands"
echo
echo


# Energy minimization of ligands.
obminimize \
    -ff MMFF94 \
    -n 1000 \
    split_sdfs/${x}_split/*.sdf


echo
echo
echo "Converting sdf to pdbqt of ${x} files"
echo
echo

# convert sdf to pdbqt
obabel \
    -isdf split_sdfs/${x}_split/*.sdf\
    -opdbqt \
    -O all_pdbqt/${x}/*.pdbqt 

done
echo
echo
echo "........"
echo "........."
echo ".........."
echo "Ligand preparation is completed."
