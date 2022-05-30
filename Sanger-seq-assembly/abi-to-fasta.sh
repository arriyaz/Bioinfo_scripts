#!/bin/bash

# The script was prepared by: Anisur Rahman (Riyaz)
# Email: arriyaz.nstu@gmail.com

# Stop on any error.
set -ue


# Check if you have merger tool installed
if ! command -v seqret &> /dev/null
then
	echo
    echo "	Command 'seqret' could not be found"
    echo "	Install 'emboss' command line tool to use merger command"
    echo
    echo
	
    exit
fi

# Check if you have cowsay tool installed
if ! command -v cowsay &> /dev/null
then
	echo
    echo "	You don't have 'cowsay' tool installed"
    echo "	I'm going to install cowsay"
	sudo apt install cowsay
    echo

fi

read -r -e -p "Please insert the directory name that contain the abi/ab1 sequences: " ABI_dir
read -r -e -p "Please provide a output directory: " OUT_dir

rm -Rf $OUT_dir && mkdir ${OUT_dir}

ABI_file=$(ls -1 ${ABI_dir}/ | sort | grep .ab[1i])

for FILE in ${ABI_file}
do

NAME=$(echo $FILE | sed 's/.ab[1i]//g')

seqret \
    -sequence ${ABI_dir}/$FILE \
    -sformat1 abi \
    -osformat2 fasta \
    -auto \
    -stdout \
    -outseq ${OUT_dir}/${NAME}.fa


done

echo 


