## ASSEMBLY is the process of turning shorter READS into longer CONTIGS.

- The software that performs the assembly is called the **“assembler.”**

### Challenges of assembly
- Skills and expertises are not defined
- No specific optimized command that fits for all type of **genome**
- Complex options in tools without proper explanation
- Have to go through "Trial and error" process
- Even when assembly appears to work, almost always it will contain several severe and substantial errors.

### “White whale” of assembly
- The white whale of assembly is obtaining **“single linear genome.”**
- The better we understand large-scale genomic variation, the more apparent it becomes that no single reference genome could characterize each member of the same species.

### Genome Graph: A better alternative to single reference genome
- [A great news article on Genome Graph](https://www.statnews.com/2016/10/07/dna-genome-sequencing-new-maps/)
- [Genome graphs and the evolution of genome inference](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5411762/)
![image-2.png](attachment:image-2.png)
![image.png](attachment:image.png)

### Steps of Genome Assembly

The typical genome assembly process is composed of three different stages:
1. **Assembling contigs**: Merging reads into longer contigs.
2. **Scaffolding the contigs**: Spatially orienting contigs relative to one another.
3. **Finishing the genome**: Bridging over the spaces between the spatially oriented contigs and connecting them.

### How to Quantify Assembly Quality
Ideally, we expect assemblies to have:

1. Contiguity. Produce the longest possible contigs.
2. Correctness. Assemble contigs with few/no errors.
3. Completeness. Cover the entire original sequence and minimize missing regions.

> Also called **the 3Cs (CCC)** as shorthand notation.

`Balancing these three requires trade-offs based on the requirement of the problem that is being solved.`

### Types of Assembly Errors You May Get?

**Chaff**: contigs that are comparable to a read size. These are indicative of dead ends in the assembly process.

**Misjoins**: joining two sequences that should not be together.

**Coverage misses**: regions of the genome that are not assembled at all.

**Repeat compression**: a common error that makes consecutive repeats appear as a single sequence. `ZZZ ABC ABC ABC ZZZ` may look like as `ZZZ ABC ZZZ`


## *de novo* genome assembly

> Process of taking a large number of short DNA sequences and putting them back together to create a representation of the original chromosomes from which the DNA originated

- Assume no prior knowledge of the source DNA sequence length, layout or composition.
- In a genome sequencing project, the DNA of the target organism is broken up into millions of small pieces and read on a sequencing machine.
- These “reads” vary from 20 to 1000 nucleotide base pairs (bp) in length.
> Typically for Illumina type short read sequencing, reads of length 36 - 150 bp are produced.
- These reads can be either “single ended” or “paired end.”
- Paired end reads are produced when the fragment size used in the sequencing process is much longer (typically 250 - 500 bp long) and the ends of the fragment are read in towards the middle.

- One from the left hand end of a fragment and one from the right with a known separation distance between them.

> `The known separation distance is actually a distribution with a mean and standard deviation as not all original fragments are of the same length.`

![image.png](attachment:image.png)

- The goal of a sequence assembler is to produce long contiguous pieces of sequence (contigs) from these reads.
- The contigs are sometimes then ordered and oriented in relation to one another to form scaffolds.
- The mechanisms used by assembly software are varied but the most common type for short reads is assembly by ***de Bruijn graph***.
- See [this document](https://www.melbournebioinformatics.org.au/tutorials/tutorials/assembly/assembly-background/#de-novo-assembly-with-velvet-and-the-velvet-optimiser) for an explanation of the de Bruijn graph genome assembler “Velvet.”

## Coverage
The term “coverage” in NGS always describes a relation between sequence reads and a reference (e.g. a whole genome or a locus).

> Often synonymously used with the term **sequencing depth**, which is another different term (or, at least according to some expert).


`That's why it is very important to distinguish between them.`


### Formula to calculate coverage
![image.png](attachment:image.png)

1. **Coverage** (*that we commonly use*): number of reads that align to, or "cover," a known reference. It describes how often, in average, a reference sequence is covered by bases from the reads.
2.  **Percentage of coverage**: E.g. if 90% of a reference is covered by reads (and 10% not) it is a 90% coverage.
3. **Sequencing depth**: total number of usable reads from the sequencing machine (usually used in the unit “number of reads” (in millions). ***Especially used for RNA-seq.***

![image-2.png](attachment:image-2.png)

Figure 1: Distinction between coverage in terms of redundancy (A), percentage of coverage (B) and sequencing depth (C). 1) Sequenced bases is the number of reads x read length

### Coverage Types

There are different possible reference points for the coverage leading to three different coverage types.

Thereby the coverage can refer the --
- whole genome
- one locus (in the genome)
- one (nucleotide-) position

![image.png](attachment:image.png)

![image-2.png](attachment:image-2.png)


## What is a good coverage for an NGS project?

- There is no general guideline for determining the optimal coverage for a sequencing project.
- It highly depends on the type of experiment, the species, the input material, the sequencing platform and other factors.
-  Illumina, for example, provides on their website the possibility to search for publications with similar experiments so you can use these as pointers for your project, and also a Sequencing Coverage Calculator ([link](https://support.illumina.com/downloads/sequencing_coverage_calculator.html))

### Typical coverages for DNA sequencing?
- Genome assembly 50x and above
- Variation calling (resequencing) 20x and above.

#### Link of resource used for this discussion on Coverage
[How to calculate the coverage for a NGS experiment](https://www.ecseq.com/support/ngs/how-to-calculate-the-coverage-for-a-sequencing-experiment#:~:text=The%20term%20%E2%80%9Ccoverage%E2%80%9D%20in%20NGS,a%20total%20read%20number%20(Fig.&text=Coverage%20in%20terms%20of%20redundancy,cover%2C%22%20a%20known%20reference.)

#### A python script to calculate coverage.
`Synopsis: python srciptName.py`


```bash
#!/usr/bin/env python


#Ask for input

readsnumber = int(input('Please insert the number of reads (in bp): '))

length = int(input('What is the length of the Reads (in bp): '))

endtype = int(input('Insert 1 for single-end and 2 for paired-end: '))

genomesize = int(input('What is the genome size (in bp): '))



#code 
coverage = str(int(((length * readsnumber * endtype) / genomesize)))


print("The coverage of your data is: ", coverage + "x")

print ("Thank you")
```

## N50 statistics

- Even though the N50 statistic is the most commonly used measure of the quality of a genome assembly, it might come as a surprise that its meaning is not rigorously defined.
- `As a matter of fact, no definition for N50 that we’ve seen appears to be entirely correct.`

#### A simpler explanation of N50, ( course might not be quite correct), starts by ordering contigs by length.
- Suppose we have 10 different contigs (designated by `XXXXXX` ) and we ordered these by their decreasing sizes:

`
Contig         Length           Sum
XXXXXXXXXX       10              10
XXXXXXXXX         9              19
XXXXXXXX          8              27
XXXXXXX           7              34
XXXXXX            6              40
XXXXX             5              45
XXXX              4              49
XXX               3              52
XX                2              54
X                 1              55
`

- The sum of these lengths starting with the longest is `55`. Half of that is `27.5`.
- Go down on this list and add up the lengths to find the contig where the cumulative length exceeds this half value.
- When we hit contig number `7` we have `10 + 9 + 8 + 7 = 34`, this value is larger than `27.5`
- Our N50 is then `7`

#### Another simple way to state this (following the wording of this [blogpost](http://jermdemo.blogspot.com/2008/11/calculating-n50-from-velvet-output.html)) is that:
> `At least half of the nucleotides in this assembly belong to contigs of size 7bp or longer.`

- **NG50** resembles N50 except the metric relates to the genome size rather than the assembly size.
- **NA50** and **NGA50** are analogous to **N50** and **NG50** where the contigs are replaced by blocks that can be aligned to the reference.

## Counting k-mer with kmergenie
> #### KmerGenie estimates the best k-mer length for genome de novo assembly.

- KmerGenie predictions can be applied to ***single-k*** genome assemblers **(e.g. Velvet, SOAPdenovo 2, ABySS, Minia)**.
- ***Multi-k*** genome assemblers **(e.g. SPAdes, IDBA)** generally perform better with default parameters (using multiple k values), rather than the single best k predicted by KmerGenie

## Genome Assebmbly The protocol in a nutshell:¶
- Obtain sequence read file(s) from sequencing machine(s).
- Look at the reads - get an understanding of what you’ve got and what the quality is like.
- Raw data cleanup/quality trimming if necessary.
- Choose an appropriate assembly parameter set.
- Assemble the data into contigs/scaffolds.
- Examine the output of the assembly and assess assembly quality.

![image.png](attachment:image.png)

Figure: Flowchart of de novo assembly protocol.

# de novo of SARS-CoV-2


```bash
# activating conda environment
conda activate bioriyaz
```

## 1. Data Collection


```bash
mkdir -p all_data/reads_data
```


```bash
# Downloading reads
fastq-dump ERR5494176 --split-files -O all_data/reads_data
```


```bash
# Check data
seqkit stats all_data/reads_data/*
```

### [Optional] If you wish to use some reads (let's say 600000 read) from main data
`seqkit sample -2 -n 600000 all_data/reads_data/ERR5494176_1.fastq  > data/F1.fq
 seqkit sample -2 -n 600000 all_data/reads_data/ERR5494176_2.fastq  > data/F2.fq`


```bash
# Set variable for raw data
READ1=all_data/reads_data/ERR5494176_1.fastq
READ2=all_data/reads_data/ERR5494176_2.fastq
```

## 2. Sequencing quality control

Quality control (abbreviated as QC from now on) is the process of improving data by removing identifiable errors from it.

- Since it is a process that alters the data, we must be **extremely cautious** not to introduce new features into it inadvertently.
- Do note:
> `It is common to expect too much from quality control. Remember that QC cannot turn bad data into useful data and we can never salvage what appears to be a total loss.`

### How do we perform quality control?
QC typically follows this process.

- Evaluate (visualize) data quality.
- Stop and move to the next analysis step if the quality appears to be satisfactory.
- If not, execute one or more data altering steps then go to step 1.

### List of QC tools
- Trimmomatic
- BBDuk
- flexbar
- cutadapt

### Adapter Trimming


```bash
# set variable for trimmed data
QCREAD1=all_data/reads_data/trimmed_1.fq
QCREAD2=all_data/reads_data/trimmed_2.fq

# set variable for unpaired trimmed data
UNP1=all_data/reads_data/unpaired_1.fq
UNP2=all_data/reads_data/unpaired_2.fq
```


```bash
# running trimming code
trimmomatic PE $READ1 $READ2 $QCREAD1 $UNP1 $QCREAD2 $UNP2 SLIDINGWINDOW:4:30 TRAILING:30 ILLUMINACLIP:adapter/adapters.fa:2:30:5
```


```bash
# create directory for all results
mkdir results
```


```bash
mkdir results/fastqc_output
fastqc $READ1 $READ2 $QCREAD1 $QCREAD2 -o results/fastqc_output
```

## 3. Assembly

## Predict kmer size with kmergenie


```bash
# Combine the data
cat $QCREAD1 $QCREAD2 > all_data/reads_data/combined.fq
```


```bash
# create folder for kmergenie outputfiles
mkdir -p results/kmergeniefiles

# Calculate k-mer size by kmergenie
kmergenie all_data/reads_data/combined.fq -o results/kmergeniefiles/outputs

```

#### kmergenie recommended k: 57

## Download Reference genome


```bash
# Make a directory for the reference.
mkdir -p all_data/refs

# Accession number for the SARS-CoV-2
ACC=NC_045512.2

# This is the reference name.
REF=all_data/refs/${ACC}.fa

# Get the reference sequence.
efetch -db=nuccore -format=fasta -id=$ACC | seqret -filter -sid $ACC > $REF
```


```bash
# check the referene
seqkit stat $REF
```

## Assembly minia assembler with default (31) k-mer


```bash
#create a output directory
mkdir -p results/minia31_results

# Assembly with Minia.
minia -in all_data/reads_data/combined.fq -out results/minia31_results/minia31
```


```bash
# check minia31 result
seqkit stat results/minia31_results/minia31.contigs.fa
```

## Running minia with kmer size recommended by kmergenie


```bash
# create a directory for minia second run
mkdir -p results/minia57_results

# Assembly with Minia with kmer size recommended by kmergenie.
minia -in all_data/reads_data/combined.fq -kmer-size 57 -out results/minia57_results/minia57
```


```bash
# check minia57 result
seqkit stat results/minia57_results/minia57.contigs.fa
```

## Assembly with Velvet

### Calculate insert size


```bash
bwa index $REF
bwa mem $REF $READ1 $READ2 | samtools view -F 4 -f 3 -F 16 | datamash mean 9
```

#### Estimated insert size: 224


```bash
#compute subsequences of a given k-mer (31) size
velveth results/velvet57 57 -fastq -separate -shortPaired $READ1 $READ2

#assemble the genome from these precomputed data
velvetg results/velvet57 -exp_cov auto -ins_length 224
```


```bash
#compute subsequences of a given k-mer (31) size
velveth results/velvet135 135 -fastq -separate -shortPaired $READ1 $READ2

#assemble the genome from these precomputed data
velvetg results/velvet135 -exp_cov auto -ins_length 224
```


```bash
#check velvet result
seqkit stat results/velvet135/velvet135.contigs.fa
```

## Assembly with SPAdes assembly


```bash
spades.py -1 $READ1 -2 $READ2 -o results/spades
```


```bash
# check spades result
seqkit stat results/spades/spades.contigs.fa
```

## 4. Comparing results from minia31 vs minia69 vs velvet69 vs spades


```bash
# Setting variable for contigs
MINIA31=results/minia31_results/minia31.contigs.fa
MINIA57=results/minia57_results/minia57.contigs.fa
VELVET57=results/velvet57/velvet57.contigs.fa
VELVET135=results/velvet135/velvet135.contigs.fa
SPADES=results/spades/spades.contigs.fa
```


```bash
mkdir results/quast
```


```bash
quast -R $REF $MINIA31 $MINIA57 $VELVET135 --min-contig 30 -o results/quast
```

## How to improve the assembly process?

>`Keep running your assembler with many different parameters until you get a proper assembly.`

## How do I evaluate the assembly?

Let’s align the assembled contig against the reference sequence.


```bash
# create a folder for alignment
mkdir -p results/alignment_output
```


```bash
# Index reference for the aligner.
bwa index $REF

# reverse complement the contigs
cat $MINIA57 | seqkit seq -p -r > results/minia57_results/sars.fa

# align the assembled contigs against reference sequence

CONTIGS=results/minia57_results/sars.fa

bwa mem $REF $CONTIGS | samtools sort > results/alignment_output/minia57.bam

samtools index results/alignment_output/minia57.bam
```

### Align contigs from spades


```bash
# reverse complement the contigs
cat $SPADES | seqkit seq -p -r > results/spades/sars.spades.fa

SPCONTIG=results/spades/sars.spades.fa

# align the assembled contigs against reference sequence

bwa mem $REF $SPCONTIG | samtools sort > results/alignment_output/spades.bam

samtools index results/alignment_output/spades.bam
```

## View the alignment in IGV

- open IGV and load reference sequence
- then load the mini69.bam file
