#!/bin/bash

# This script was written by
# Anisur Rahman
# arriyaz.nstu@gmail.com


var1=$(ls SMILES/ )
var2=$(ls ADMET/ )

mkdir -p Combined ADMET_filtered

set -- $var2

for SMILEFILE in $var1
do

# Remove pathname from the variable and take only pathaname
SMILESNAME=$(basename ${SMILEFILE} | sed 's/.txt//g')


# Add Header Line to Original SMILES file and save it in temp1 file
sed '1 i\Original SMILES,PubChem CID' SMILES/${SMILEFILE} > temp1

# Convert the tab sepration inTO comma separated
tr '\t' "," < temp1 > temp2

# Add original SMILES to ADMET data
# Combine the column of both file
paste -d ',' temp2 ADMET/$1 > Combined/${SMILESNAME}.csv

# Remove temporary files
rm -rf temp1 temp2

# Filter only those ligand with are accepted by Lipinski, Pfizer, GSK, GoldenTriangle rule.
# These rules are in 88-91 column in our file.
awk -F "," 'NR==1 || \
	$88=="Accepted" &&\
	$89=="Accepted" &&\
	$90=="Accepted" &&\
	$91=="Accepted" \
	{print $0}' \
	Combined/${SMILESNAME}.csv >\
	ADMET_filtered/${SMILESNAME}.csv

# Remove filtered file which contains no data
# These files contain only one header file

if [ "$( wc -l < ADMET_filtered/${SMILESNAME}.csv )" -eq 1 ];
then
    rm -rf ADMET_filtered/${SMILESNAME}.csv
fi
	

shift
done



