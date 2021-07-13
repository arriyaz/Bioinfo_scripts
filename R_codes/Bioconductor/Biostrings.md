
## Manipulating Biostring
***

### Take first 21 bases from `zikaVirus` object

```R
# Unlist the set, select the first 21 letters, and assign to dna_seq
dna_seq <- subseq(unlist(zikaVirus), end = 21)
dna_seq
```
In the above code, `unlist()` command will unlist the zikaVirus object that means it will convert the list of bases into vector. Then `subseq()` command with `end = 21`
option will take first 21 letters (bases) from that vector.

### Transcribe dna_seq into an RNAString object and print it
```R
rna_seq <- RNAString(dna_seq) 
rna_seq
```

### Translate rna_seq into an AAString (amino acid) object and print it
```R
aa_seq <- translate(rna_seq)
aa_seq
```
### Transcribe and translate dna_seq into an AAString object in one step and print it
It is a shortcut to convert DNA to amino acid sequences.
```R
aa_seq  <- translate(dna_seq)
aa_seq
```
