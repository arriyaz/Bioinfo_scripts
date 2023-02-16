# Download more than one sequence together
epost -db nuccore -input ids.txt -format acc | efetch -format fasta > output.fa



# split squences according to sequence ID
seqkit split --by-id file_name



# change the widtch of fasta file;
# -w, --line-width int
                line width when outputing FASTA format (0 for no wrap) (default 60)
# to make 2 line fasta;
seqkit seq -w 0

# to make multi line fasta with 50nt width
seqkit seq -w 50



# Translate dna to protein
seqkit translate -x --clean file_name

-x : allow translate unknown code to 'X'
--clean	change all STOP codon positions from the '*' character to 'X' (an unknown residue)


# DNA to RNA or RNA to DNA

seqkit seq --dna2rna file_name 		#-p for complement

seqkit seq --rna2dna  



#Print sequence in lowercase
seqkit seq -l



# only print name
seqkit seq -n



# print ID instead of full head
seqkit seq -i




# only print sequences
seqkit seq -s



# print sequences in upper case
seqkit seq -u


# Link to a great resource:
https://www.bioinformatics.org/sms2/index.html
