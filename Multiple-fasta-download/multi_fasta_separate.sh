#!/bin/bash


#Synopsis: bash multiple_fasta_separate.sh

set -ue

#input source
read -p 'Please enter the name of id list: ' ids

MYAPI="44d3b65de1af15d5c060b727dab6a952fa09"

echo "
Downloading the fasta files......"



# Run the code
parallel --delay 2 --jobs 1 --results fasta_files/{}.fa efetch -api_key $MYAPI -db nuccore -id {} -format fasta :::: $ids


# Remove unnecessary files
rm -f fasta_files/*.err
rm -f fasta_files/*.fa.seq

echo '

Job Done!!!'
echo 'Please find your files inside "fasta_files" directory under the current directory.

'
