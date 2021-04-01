

#!/bin/bash


#Synopsis: bash multiple_fasta_combined.sh


set -ue


#input source



read -p 'Please enter the file name of accession id list: ' ids

read -p 'What will be your output name?? ' output



echo '
This code will download fasta files for all ids listed in your given id list.
Please hang on!!!!'
 
# The code
epost -db nuccore -input $ids -format acc | efetch -format fasta > $output


echo '

Job done!!'
