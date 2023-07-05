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


read -r -e -p "Please insert the directory name that contain the abi/ab1 sequences: " ABI_dir
read -r -e -p "Please provide a output directory: " OUT_dir

rm -Rf $OUT_dir && mkdir ${OUT_dir} ${OUT_dir}_temp

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
    -outseq ${OUT_dir}_temp/${NAME}.fa
    

# Input FASTA file
input_file=${OUT_dir}_temp/${NAME}.fa


# Extract filename without extension
filename=$(basename "$input_file")
filename="${filename%.*}"

# Replace the header with the filename
seqkit replace -p "(.+)" -r "${filename}" "${input_file}" > ${OUT_dir}/${NAME}.fa

# Remove temp file
rm -rf ${OUT_dir}_temp/${NAME}.fa

done

echo 
