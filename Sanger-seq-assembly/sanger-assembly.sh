#!/bin/bash

# The script was prepared by: Anisur Rahman (Riyaz)
# Email: arriyaz.nstu@gmail.com

# Stop on any error.
set -ue


# Check if you have merger tool installed
if ! command -v merger &> /dev/null
then
	echo
    echo "	Command 'merger' could not be found"
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


echo "What is the number of your assembly, single or multiple?"
read -r -e -p "Please insert 'S' for single or 'M' for multiple assembly: " ASSEMBLY_NO
echo
echo

if [ "$ASSEMBLY_NO" == 'S' ] || [ "$ASSEMBLY_NO" == 's' ];
then
	cowsay "We are going to perform single sanger assembly."
	echo 

	# Get the input
	read -r -e -p "What is your forward sequence file: " FORWARD
	read -r -e -p "What is your reverse sequence file: " REVERSE
	read -r -p "Please provide the output file name (without '.fa'): " OUTPUT


	# Merge the sequences
	merger \
		"$FORWARD" \
		"$REVERSE" \
		-sreverse2 \
		-outfile "${OUTPUT}".aln \
		-outseq temp.fa 
	
	# Rename the fasta header with filename
	sed -i "s/^>.*/>${OUTPUT}/" temp.fa

	# Make the sequences uppercase
	awk 'BEGIN{FS=" "}{if(!/>/){print toupper($0)}else{print $1}}' temp.fa > "${OUTPUT}".fa

	# Remove temp file
	rm -rf temp.fa


elif [ "$ASSEMBLY_NO" == 'M' ] || [ "$ASSEMBLY_NO" == 'm' ];
then
	# Manifest file will contain sequence names
	read -r -e -p "Please provide the manifest file: " MANIFEST
	read -r -e -p "Please give a name for the output directory: " OUTDIR

	cowsay "We are going to perform multiple sanger assembly."
	echo

	# Create the output directory
	rm -Rf $OUTDIR && mkdir -p $OUTDIR $OUTDIR/alignment $OUTDIR/sequences 
	
	# n=0
	# sed 1d will remove first header line from the manifest file
	sed 1d $MANIFEST | while IFS=, read -r  FILENAME FORWARD REVERSE REST
	do
	# Merge the sequences
	merger \
		"$FORWARD" \
		"$REVERSE" \
		-sreverse2 \
		-outfile ./$OUTDIR/alignment/${FILENAME}.aln \
		-outseq ./$OUTDIR/temp.fa
	
	# Rename the fasta header with filename
	sed -i "s/^>.*/>${FILENAME}/" ./$OUTDIR/temp.fa

	# Make the sequences uppercase
	awk 'BEGIN{FS=" "}{if(!/>/){print toupper($0)}else{print $1}}' ./$OUTDIR/temp.fa \
	> ./$OUTDIR/sequences/${FILENAME}.fa

	# Remove temp file
	rm -rf $OUTDIR/temp.fa

	done

	echo
	echo "Merging complete!!"
	# echo  "Total $n sequence were generated"

else
	cowsay "Please insert S or M"

fi







