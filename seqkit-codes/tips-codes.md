## Download more than one sequence together

```bash
epost -db nuccore -input ids.txt -format acc | efetch -format fasta > output.fa
```


## split squences according to sequence ID
```bash
seqkit split --by-id file_name
```


## change the widtch of fasta file;
`-w, --line-width int`
line width when outputing FASTA format (0 for no wrap) (default 60)
### to make 2 line fasta;
```bash
seqkit seq -w 0
```

### to make multi line fasta with 50nt width
```bash
seqkit seq -w 50
```


## Translate dna to protein
```bash
seqkit translate -x --clean file_name
```

`-x:` allow translate unknown code to 'X'
`--clean:` change all STOP codon positions from the '*' character to 'X' (an unknown residue)


## DNA to RNA or RNA to DNA

```bash
seqkit seq --dna2rna file_name 		#-p for complement

seqkit seq --rna2dna  
```


## Print sequence in lowercase
```bash
seqkit seq -l
```


## only print name
```bash
seqkit seq -n
```


## print ID instead of full head
```bash
seqkit seq -i
```

## only print sequences
```bash
seqkit seq -s
```


## print sequences in upper case
```bash
seqkit seq -u
```

## Link to a great resource:
https://www.bioinformatics.org/sms2/index.html
