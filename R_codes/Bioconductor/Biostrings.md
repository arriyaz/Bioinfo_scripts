
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

