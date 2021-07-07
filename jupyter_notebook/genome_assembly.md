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

    Please insert the number of reads (in bp): 1000000
    What is the length of the Reads (in bp): 101
    Insert 1 for single-end and 2 for paired-end: 2
    What is the genome size (in bp): 300000
    The coverage of your data is:  673x
    Thank you


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

    (bioriyaz) 



## 1. Data Collection


```bash
mkdir -p all_data/reads_data
```


```bash
# Downloading reads
fastq-dump ERR5494176 --split-files -O all_data/reads_data
```

    (bioriyaz) Read 1083438 spots for ERR5494176
    Written 1083438 spots for ERR5494176
    (bioriyaz) 




```bash
# Check data
seqkit stats all_data/reads_data/*
```

    (bioriyaz) file                                    format  type   num_seqs      sum_len  min_len  avg_len  max_len
    all_data/reads_data/ERR5494176_1.fastq  FASTQ   DNA   1,083,438  146,517,622       35    135.2      151
    all_data/reads_data/ERR5494176_2.fastq  FASTQ   DNA   1,083,438  146,590,675       35    135.3      151
    all_data/reads_data/combined.fq         FASTQ   DNA   1,723,468  168,340,761        1     97.7      151
    all_data/reads_data/trimmed_1.fq        FASTQ   DNA     861,734   90,793,066        1    105.4      151
    all_data/reads_data/trimmed_2.fq        FASTQ   DNA     861,734   77,547,695        1       90      151
    (bioriyaz) 



### [Optional] If you wish to use some reads (let's say 600000 read) from main data
`seqkit sample -2 -n 600000 all_data/reads_data/ERR5494176_1.fastq  > data/F1.fq
 seqkit sample -2 -n 600000 all_data/reads_data/ERR5494176_2.fastq  > data/F2.fq`


```bash
# Set variable for raw data
READ1=all_data/reads_data/ERR5494176_1.fastq
READ2=all_data/reads_data/ERR5494176_2.fastq
```

    (bioriyaz) (bioriyaz) (bioriyaz) 



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

    (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) 




```bash
# running trimming code
trimmomatic PE $READ1 $READ2 $QCREAD1 $UNP1 $QCREAD2 $UNP2 SLIDINGWINDOW:4:30 TRAILING:30 ILLUMINACLIP:adapter/adapters.fa:2:30:5
```

    (bioriyaz) TrimmomaticPE: Started with arguments:
     all_data/reads_data/ERR5494176_1.fastq all_data/reads_data/ERR5494176_2.fastq all_data/reads_data/trimmed_1.fq all_data/reads_data/trimmed_2.fq SLIDINGWINDOW:4:30 TRAILING:30 ILLUMINACLIP:adapter/adapters.fa:2:30:5
    Multiple cores found: Using 4 threads
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTCCCGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GACGCTGCCGACGATCTTACGCGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACACTGATATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCTATACATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCACTCAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGGCTACATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGTCCGCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CTGAGCGGGCTGGCAAGGCAGACCGATCTCGTATGCCGTCTTCTGCTTG'
    Using Medium Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGC'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTGACCAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATTAAAAAA'
    Using Medium Clipping Sequence: 'TCGTATGCCGTCTTCTGCTTGT'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGCCAATATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCACGATATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGTAGAGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGGTAGCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTCGAAGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCAC'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTTAGGCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCAGATCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCTTGTAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGAGTGGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACATTCCTTTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACATCACGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCACCGGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACGCTCATGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTCGGCAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACGTGGCCTTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACGTAGAGGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACGTTTCGGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACAAGAGGCAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGTACGTAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACCGAGGCTGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCCGTCCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACGAGTGGATATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACACTGATATATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGTCGGACTGTAGAACTCTGAAC'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACGTCCGCACATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTGAAA'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACGCGTAGTAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACGGAGCTACATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACACTCGCTAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACATCTCAGGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCTAGCTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTCATTCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACACTGAGCGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCAGGCGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACTAGCGCTCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACATGCGCAGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACTACGCTGCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACCGGAGCCTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCTCAGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGTGAAAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACTCGACGTCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACTGCAGCTAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACATGAGCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACCGATCAGTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACCCTAAGACATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GACGCTGCCGACGAATAGCCTTGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'GACGCTGCCGACGATCGCATAAGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'GACGCTGCCGACGATAAGGCTCGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGTTTCGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACACAGTGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACAGTTCCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CTGTCTCTTATACACATCTCCGAGCCCACGAGAC'
    Using Long Clipping Sequence: 'CTGTCTCTTATACACATCTCTGAGCGGGCTGGCAAGGC'
    Using Long Clipping Sequence: 'CTGATGGCGCGAGGGAGGCGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'GACGCTGCCGACGATCTTACGCGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'GACGCTGCCGACGAACTCTAGGGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'GACGCTGCCGACGACTTAATAGGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'CTGTCTCTTATACACATCTCTGATGGCGCGAGGGAGGC'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACAAGAGGCAATCTCGTATGCCGTCTTCTGCTTG'
    Using Medium Clipping Sequence: 'CCACGGGAACGTGGTGGAATTC'
    Using Long Clipping Sequence: 'CTGTCTCTTATACACATCTGACGCTGCCGACGA'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACCGAGGCTGATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACGTAGAGGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GACGCTGCCGACGACGGAGAGAGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACTTAGGCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GACGCTGCCGACGAATTAGACGGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCCAACAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GACGCTGCCGACGACTAGTCGAGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'GACGCTGCCGACGAAGCTAGAAGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTACAGCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACACTTGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACATGTCAGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACGATCAGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACCCGTCCCGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACTGACCAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACGTGAAACGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACACAGTGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACGCCAATATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCAACTAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACCAGATCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACAGGCAGAAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACCGTACTAGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACTAAGGCGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACTAGCTTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACGGCTACATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACCTTGTAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACAGTCAACAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACAGTTCCGTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GACGCTGCCGACGATATGCAGTGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'AGATCGGAAGAGCACACGTCTGAAC'
    Using Long Clipping Sequence: 'GACGCTGCCGACGACTCCTTACGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'GACGCTGCCGACGAAGGCTTAGGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTAATCGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GACGCTGCCGACGATACTCCTTGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACCTCTCTACATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACTAGGCATGATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACCGTACTAGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACGGACTCCTATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACTAAGGCGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACTCCTGAGCATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACTCCTGAGCATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACAGGCAGAAATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACTAGGCATGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCAAAAGATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACGGACTCCTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACCAGAGAGGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GACGCTGCCGACGAATAGAGAGGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Skipping duplicate Clipping Sequence: 'CCGAGCCCACGAGACCTCTCTACATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCATTTTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'CCGAGCCCACGAGACGCTACGCTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GACGCTGCCGACGAAGAGGATAGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'AGATCGGAAGAGCGTCGTGTAGGGA'
    Using Long Clipping Sequence: 'AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCTCAAGCAGAAGACGGCATACGAGCTCTTCCGATCT'
    Using Long Clipping Sequence: 'TCGGACTGTAGAACTCTGAACGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'AGATCGGAAGAGCACACGTCTGAACTCCAGTCACATCACGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCGGAATATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCATGGCATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGACGACATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACACTTGAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACAGTCAAATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCGATGTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACATTCCTATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGTGGCCATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'GACGCTGCCGACGATACTCCTTGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Skipping duplicate Clipping Sequence: 'GACGCTGCCGACGAAGGCTTAGGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Skipping duplicate Clipping Sequence: 'GACGCTGCCGACGACTCCTTACGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Skipping duplicate Clipping Sequence: 'GACGCTGCCGACGATATGCAGTGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACATGTCAATCTCGTATGCCGTCTTCTGCTTG'
    Skipping duplicate Clipping Sequence: 'GACGCTGCCGACGAAGAGGATAGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'GACGCTGCCGACGATCTACTCTGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'GACGCTGCCGACGAGCGATCTAGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Skipping duplicate Clipping Sequence: 'GACGCTGCCGACGAATAGAGAGGTGTAGATCTCGGTGGTCGCCGTATCATT'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACCGTACGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTAGCTTATCTCGTATGCCGTCTTCTGCTTG'
    Using Medium Clipping Sequence: 'CCTTGGCACCCGAGAATTCCA'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACTATAATATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACGATCAGATCTCGTATGCCGTCTTCTGCTTG'
    Using Long Clipping Sequence: 'GATCGGAAGAGCACACGTCTGAACTCCAGTCACATCACGATCTCGTATGCCGTCTTCTGCTTG'
    ILLUMINACLIP: Using 0 prefix pairs, 138 forward/reverse sequences, 0 forward only sequences, 0 reverse only sequences
    Quality encoding detected as phred33
    Input Read Pairs: 1083438 Both Surviving: 1082574 (99.92%) Forward Only Surviving: 421 (0.04%) Reverse Only Surviving: 443 (0.04%) Dropped: 0 (0.00%)
    TrimmomaticPE: Completed successfully
    (bioriyaz) 




```bash
# create directory for all results
mkdir results
```

    (bioriyaz) mkdir: cannot create directory ‘results’: File exists
    (bioriyaz) 




```bash
mkdir results/fastqc_output
fastqc $READ1 $READ2 $QCREAD1 $QCREAD2 -o results/fastqc_output
```

    (bioriyaz) Started analysis of ERR5494176_1.fastq
    Approx 5% complete for ERR5494176_1.fastq
    Approx 10% complete for ERR5494176_1.fastq
    Approx 15% complete for ERR5494176_1.fastq
    Approx 20% complete for ERR5494176_1.fastq
    Approx 25% complete for ERR5494176_1.fastq
    Approx 30% complete for ERR5494176_1.fastq
    Approx 35% complete for ERR5494176_1.fastq
    Approx 40% complete for ERR5494176_1.fastq
    Approx 45% complete for ERR5494176_1.fastq
    Approx 50% complete for ERR5494176_1.fastq
    Approx 55% complete for ERR5494176_1.fastq
    Approx 60% complete for ERR5494176_1.fastq
    Approx 65% complete for ERR5494176_1.fastq
    Approx 70% complete for ERR5494176_1.fastq
    Approx 75% complete for ERR5494176_1.fastq
    Approx 80% complete for ERR5494176_1.fastq
    Approx 85% complete for ERR5494176_1.fastq
    Approx 90% complete for ERR5494176_1.fastq
    Approx 95% complete for ERR5494176_1.fastq
    Analysis complete for ERR5494176_1.fastq
    Started analysis of ERR5494176_2.fastq
    Approx 5% complete for ERR5494176_2.fastq
    Approx 10% complete for ERR5494176_2.fastq
    Approx 15% complete for ERR5494176_2.fastq
    Approx 20% complete for ERR5494176_2.fastq
    Approx 25% complete for ERR5494176_2.fastq
    Approx 30% complete for ERR5494176_2.fastq
    Approx 35% complete for ERR5494176_2.fastq
    Approx 40% complete for ERR5494176_2.fastq
    Approx 45% complete for ERR5494176_2.fastq
    Approx 50% complete for ERR5494176_2.fastq
    Approx 55% complete for ERR5494176_2.fastq
    Approx 60% complete for ERR5494176_2.fastq
    Approx 65% complete for ERR5494176_2.fastq
    Approx 70% complete for ERR5494176_2.fastq
    Approx 75% complete for ERR5494176_2.fastq
    Approx 80% complete for ERR5494176_2.fastq
    Approx 85% complete for ERR5494176_2.fastq
    Approx 90% complete for ERR5494176_2.fastq
    Approx 95% complete for ERR5494176_2.fastq
    Analysis complete for ERR5494176_2.fastq
    Started analysis of trimmed_1.fq
    Approx 5% complete for trimmed_1.fq
    Approx 10% complete for trimmed_1.fq
    Approx 15% complete for trimmed_1.fq
    Approx 20% complete for trimmed_1.fq
    Approx 25% complete for trimmed_1.fq
    Approx 30% complete for trimmed_1.fq
    Approx 35% complete for trimmed_1.fq
    Approx 40% complete for trimmed_1.fq
    Approx 45% complete for trimmed_1.fq
    Approx 50% complete for trimmed_1.fq
    Approx 55% complete for trimmed_1.fq
    Approx 60% complete for trimmed_1.fq
    Approx 65% complete for trimmed_1.fq
    Approx 70% complete for trimmed_1.fq
    Approx 75% complete for trimmed_1.fq
    Approx 80% complete for trimmed_1.fq
    Approx 85% complete for trimmed_1.fq
    Approx 90% complete for trimmed_1.fq
    Approx 95% complete for trimmed_1.fq
    Analysis complete for trimmed_1.fq
    Started analysis of trimmed_2.fq
    Analysis complete for trimmed_2.fq
    (bioriyaz) 



## 3. Assembly

## Predict kmer size with kmergenie


```bash
# Combine the data
cat $QCREAD1 $QCREAD2 > all_data/reads_data/combined.fq
```

    (bioriyaz) (bioriyaz) 




```bash
# create folder for kmergenie outputfiles
mkdir -p results/kmergeniefiles

# Calculate k-mer size by kmergenie
kmergenie all_data/reads_data/combined.fq -o results/kmergeniefiles/outputs

```

    (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) running histogram estimation
    Setting maximum kmer length to: 151 bp
    computing histograms (from k=21 to k=121): 31 41 21 61 51 71 101 91 81 111 121 
    ntCard wall-clock time over all k values: 67 seconds 
    fitting model to histograms to estimate best k
    estimation of the best k so far: 61
    refining estimation around [55; 67], with a step of 2
    running histogram estimation
    Setting maximum kmer length to: 151 bp
    computing histograms (from k=57 to k=67): 61 59 57 63 65 67 
    ntCard wall-clock time over all k values: 33 seconds 
    fitting model to histograms to estimate best k
    table of predicted num. of genomic k-mers: results/kmergeniefiles/outputs.dat
    recommended coverage cut-off for best k: 22
    best k: 57
    (bioriyaz) 



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

    (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) 




```bash
# check the referene
seqkit stat $REF
```

    (bioriyaz) file                          format  type  num_seqs  sum_len  min_len  avg_len  max_len
    all_data/refs/NC_045512.2.fa  FASTA   DNA          1   29,903   29,903   29,903   29,903
    (bioriyaz) 



## Assembly minia assembler with default (31) k-mer


```bash
#create a output directory
mkdir -p results/minia31_results

# Assembly with Minia.
minia -in all_data/reads_data/combined.fq -out results/minia31_results/minia31
```

    (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) setting storage type to hdf5
    [Approximating frequencies of minimizers ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 100.0 %   mem: [  29,   29,   29] MB 
    [DSK: Collecting stats on combined       ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu:  99.0 %   mem: [  47,   47,   47] MB 
    [DSK: nb solid kmers: 851094             ]  100  %   elapsed:   0 min 26 sec   remaining:   0 min 0  sec   cpu: 247.8 %   mem: [ 118,  658,  699] MB 
    bcalm_algo params, prefix:results/minia31_results/minia31.unitigs.fa k:31 a:2 minsize:10 threads:4 mintype:1
    DSK used 1 passes and 4 partitions
    prior to queues allocation                      17:45:29     memory [current, maxRSS]: [ 105,  699] MB 
    Starting BCALM2                                 17:45:29     memory [current, maxRSS]: [ 105,  699] MB 
    [Iterating DSK partitions                ]  100  %   elapsed:   0 min 5  sec   remaining:   0 min 0  sec
    Number of sequences in glue: 236961
    Number of pre-tips removed : 0
    Buckets compaction and gluing           : 4.6 secs
    Within that, 
                                     creating buckets from superbuckets: 1.4 secs
                          bucket compaction (wall-clock during threads): 3.2 secs
    
                    within all bucket compaction threads,
                           adding nodes to subgraphs: 3.5 secs
             subgraphs constructions and compactions: 4.0 secs
                      compacted nodes redistribution: 3.9 secs
    Sum of CPU times for bucket compactions: 12.9 secs
    BCALM total wallclock (excl kmer counting): 4.9 secs
    Maximum number of kmers in a subgraph: 505
    Performance of compaction step:
    
                     Wallclock time spent in parallel section : 3.2 secs
                 Best theoretical speedup in parallel section : 132.5x
    Best theor. speedup in parallel section using 1 threads : 1.0x
                 Sum of longest bucket compaction for each sb : 0.2 secs
                           Sum of best scheduling for each sb : 11.7 secs
    Done with all compactions                       17:45:34     memory [current, maxRSS]: [ 185,  699] MB 
    bglue_algo params, prefix:results/minia31_results/minia31.unitigs.fa k:31 threads:4
    Starting bglue with 4 threads                   17:45:34     memory [current, maxRSS]: [ 185,  699] MB 
    number of sequences to be glued: 236961         17:45:34     memory [current, maxRSS]: [ 185,  699] MB 
    101850 marked kmers, 167490 unmarked kmers        17:45:34     memory [current, maxRSS]: [ 189,  699] MB 
    created vector of hashes, size approx 0 MB)        17:45:34     memory [current, maxRSS]: [ 189,  699] MB 
    pass 1/3, 50925 unique hashes written to disk, size 0 MB        17:45:34     memory [current, maxRSS]: [ 189,  699] MB 
    102202 marked kmers, 167490 unmarked kmers        17:45:35     memory [current, maxRSS]: [ 189,  699] MB 
    created vector of hashes, size approx 0 MB)        17:45:35     memory [current, maxRSS]: [ 189,  699] MB 
    pass 2/3, 51101 unique hashes written to disk, size 0 MB        17:45:35     memory [current, maxRSS]: [ 189,  699] MB 
    102380 marked kmers, 167490 unmarked kmers        17:45:35     memory [current, maxRSS]: [ 189,  699] MB 
    created vector of hashes, size approx 0 MB)        17:45:35     memory [current, maxRSS]: [ 189,  699] MB 
    pass 3/3, 51190 unique hashes written to disk, size 0 MB        17:45:35     memory [current, maxRSS]: [ 189,  699] MB 
    loaded all unique UF elements (153216) into a single vector of size 1 MB        17:45:35     memory [current, maxRSS]: [ 189,  699] MB 
    [Building BooPHF]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec
    Bitarray          727552  bits (100.00 %)   (array + ranks )
    final hash             0  bits (0.00 %) (nb in final hash 0)
    UF MPHF constructed (0 MB)                      17:45:35     memory [current, maxRSS]: [ 189,  699] MB 
    UF constructed                                  17:45:36     memory [current, maxRSS]: [ 189,  699] MB 
    freed original UF (1 MB)                        17:45:36     memory [current, maxRSS]: [ 189,  699] MB 
    loaded 32-bit UF (0 MB)                         17:45:36     memory [current, maxRSS]: [ 189,  699] MB 
    Allowed 95 MB memory for buffers                17:45:36     memory [current, maxRSS]: [ 190,  699] MB 
    Disk partitioning of glue                       17:45:36     memory [current, maxRSS]: [ 190,  699] MB 
    Done disk partitioning of glue                  17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Top 10 glue partitions by size:
    Glue partition 545 has 164 sequences 
    Glue partition 1280 has 164 sequences 
    Glue partition 1007 has 162 sequences 
    Glue partition 1217 has 161 sequences 
    Glue partition 1100 has 160 sequences 
    Glue partition 162 has 157 sequences 
    Glue partition 1057 has 156 sequences 
    Glue partition 249 has 156 sequences 
    Glue partition 1457 has 156 sequences 
    Glue partition 975 has 156 sequences 
    Glueing partitions                              17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 0 (size: 0 MB)                 17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 20 (size: 0 MB)                17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 40 (size: 0 MB)                17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 60 (size: 0 MB)                17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 80 (size: 0 MB)                17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 100 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 120 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 140 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 160 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 180 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 200 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 220 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 240 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 260 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 280 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 300 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 320 (size: 0 MB)               17:45:38     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 340 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 360 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 380 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 400 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 420 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 440 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 460 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 480 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 500 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 520 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 540 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 560 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 580 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 600 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 620 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 640 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 660 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 680 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 700 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 720 (size: 0 MB)               17:45:39     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 740 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 760 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 780 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 800 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 820 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 840 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 860 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 880 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 900 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 920 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 940 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 960 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 980 (size: 0 MB)               17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1000 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1020 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1040 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1060 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1080 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1100 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1120 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1140 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1160 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1180 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1200 (size: 0 MB)              17:45:40     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1220 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1240 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1260 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1280 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1300 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1320 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1340 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1360 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1380 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1400 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1420 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1440 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1460 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1480 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1500 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1520 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1540 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1560 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1580 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1600 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1620 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1640 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1660 (size: 0 MB)              17:45:41     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1680 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1700 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1720 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1740 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1760 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1780 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1800 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1820 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1840 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1860 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1880 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1900 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1920 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1940 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1960 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Gluing partition 1980 (size: 0 MB)              17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    end                                             17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    Finding links between unitigs                   17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 0                                   17:45:42     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (15607kmers/36958extremities)            17:45:43     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 1                                   17:45:43     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (15648kmers/35484extremities)            17:45:43     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 2                                   17:45:43     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (3067kmers/7252extremities)              17:45:43     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 3                                   17:45:43     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (8505kmers/19566extremities)             17:45:44     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 4                                   17:45:44     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (11931kmers/28223extremities)            17:45:44     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 5                                   17:45:44     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (10365kmers/23928extremities)            17:45:44     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 6                                   17:45:45     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (3267kmers/7968extremities)              17:45:45     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 7                                   17:45:45     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (3600kmers/8111extremities)              17:45:45     memory [current, maxRSS]: [ 191,  699] MB 
    gathering links from disk                       17:45:45     memory [current, maxRSS]: [ 191,  699] MB 
    Done finding links between unitigs              17:45:46     memory [current, maxRSS]: [ 191,  699] MB 
    [removing tips,    pass  1               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 195.2 %   mem: [ 191,  191,  699] MB 
    [removing tips,    pass  2               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 200.0 %   mem: [ 191,  191,  699] MB 
    [removing tips,    pass  3               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 186.7 %   mem: [ 191,  191,  699] MB 
    [removing tips,    pass  4               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 200.0 %   mem: [ 191,  191,  699] MB 
    [removing tips,    pass  5               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 177.8 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass  1               ]  100  %   elapsed:   0 min 6  sec   remaining:   0 min 0  sec   cpu: 189.0 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass  2               ]  100  %   elapsed:   0 min 4  sec   remaining:   0 min 0  sec   cpu: 157.4 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass  3               ]  100  %   elapsed:   0 min 3  sec   remaining:   0 min 0  sec   cpu: 136.9 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass  4               ]  100  %   elapsed:   0 min 3  sec   remaining:   0 min 0  sec   cpu: 110.2 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass  5               ]  100  %   elapsed:   0 min 2  sec   remaining:   0 min 0  sec   cpu: 143.5 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass  6               ]  100  %   elapsed:   0 min 2  sec   remaining:   0 min 0  sec   cpu: 165.1 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass  7               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 191.9 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass  8               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 178.0 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass  9               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 151.1 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 10               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 144.4 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 11               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 178.9 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 12               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 177.7 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 13               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 192.0 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 14               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 184.6 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 15               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 176.4 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 16               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 185.4 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 17               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 185.7 %   mem: [ 191,  191,  699] MB 
    [removing ec,      pass  1               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 165.6 %   mem: [ 191,  191,  699] MB 
    [removing ec,      pass  2               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 166.7 %   mem: [ 191,  191,  699] MB 
    [removing ec,      pass  3               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 154.5 %   mem: [ 191,  191,  699] MB 
    [removing tips,    pass  6               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 181.8 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 18               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 175.0 %   mem: [ 191,  191,  699] MB 
    [removing ec,      pass  4               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 125.0 %   mem: [ 191,  191,  699] MB 
    [removing tips,    pass  7               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 142.9 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 19               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 181.0 %   mem: [ 191,  191,  699] MB 
    [removing ec,      pass  5               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 187.5 %   mem: [ 191,  191,  699] MB 
    [removing tips,    pass  8               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 163.6 %   mem: [ 191,  191,  699] MB 
    [removing bulges,  pass 20               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 150.0 %   mem: [ 191,  191,  699] MB 
    [removing ec,      pass  6               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 150.0 %   mem: [ 191,  191,  699] MB 
    [Minia : assembly                        ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 100.0 %   mem: [ 191,  191,  699] MB 
    Finding links between unitigs                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 0                                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (30kmers/85extremities)                  17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 1                                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (36kmers/108extremities)                 17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 2                                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (5kmers/15extremities)                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 3                                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (17kmers/46extremities)                  17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 4                                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (32kmers/88extremities)                  17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 5                                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (24kmers/63extremities)                  17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 6                                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (10kmers/27extremities)                  17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 1 pass 7                                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    step 2 (8kmers/22extremities)                   17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    gathering links from disk                       17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
    Done finding links between unitigs              17:46:24     memory [current, maxRSS]: [ 191,  699] MB 
        -in                                      : all_data/reads_data/combined.fq
        -out                                     : results/minia31_results/minia31
        -traversal                               : contig
        -fasta-line                              : 0
        -tip-len-topo-kmult                      : 2.500000
        -tip-len-rctc-kmult                      : 10.000000
        -tip-rctc-cutoff                         : 2.000000
        -bulge-len-kmult                         : 3.000000
        -bulge-len-kadd                          : 100
        -bulge-altpath-kadd                      : 50
        -bulge-altpath-covmult                   : 1.100000
        -ec-len-kmult                            : 9.000000
        -ec-rctc-cutoff                          : 4.000000
        -kmer-size                               : 31
        -abundance-min                           : 2
        -abundance-max                           : 2147483647
        -abundance-min-threshold                 : 2
        -histo-max                               : 10000
        -solidity-kind                           : sum
        -max-memory                              : 5000
        -max-disk                                : 0
        -out-dir                                 : .
        -out-tmp                                 : .
        -out-compress                            : 0
        -storage-type                            : hdf5
        -histo2D                                 : 0
        -histo                                   : 0
        -minimizer-type                          : 1
        -minimizer-size                          : 10
        -repartition-type                        : 1
        -bloom                                   : neighbor
        -debloom                                 : cascading
        -debloom-impl                            : minimizer
        -branching-nodes                         : stored
        -topology-stats                          : 0
        -nb-cores                                : 4
        -edge-km                                 : 0
        -verbose                                 : 1
        -integer-precision                       : 0
        -nb-glue-partitions                      : 0
        -storage-type                            : 1
        -verbose                                 : 1
        -verbose                                 : 1
        -verbose                                 : 1
        stats                                   
            traversal                                : contig
            nb_solid_kmers                           : 851094
            nb_contigs                               : 227
            nb_small_contigs_discarded               : 4995
            nt_assembled                             : 38066
            max_length                               : 5330
            graph simpification stats               
                tips removed                             : 31471 + 980 + 72 + 26 + 6 + 797 + 37 + 12
                bulges removed                           : 5923 + 2837 + 1693 + 1173 + 731 + 472 + 306 + 191 + 128 + 94 + 56 + 40 + 25 + 19 + 13 + 13 + 12 + 6 + 5 + 0
                EC removed                               : 3102 + 136 + 5 + 2 + 7 + 3
            assembly traversal stats                
        time                                     : 82.764
            assembly                                 : 37.329
            graph construction                       : 45.435
    (bioriyaz) 




```bash
# check minia31 result
seqkit stat results/minia31_results/minia31.contigs.fa
```

    (bioriyaz) file                                        format  type  num_seqs  sum_len  min_len  avg_len  max_len
    results/minia31_results/minia31.contigs.fa  FASTA   DNA         54   31,250       31    578.7   10,249
    (bioriyaz) 



## Running minia with kmer size recommended by kmergenie


```bash
# create a directory for minia second run
mkdir -p results/minia57_results

# Assembly with Minia with kmer size recommended by kmergenie.
minia -in all_data/reads_data/combined.fq -kmer-size 57 -out results/minia57_results/minia57
```

    (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) setting storage type to hdf5
    [Approximating frequencies of minimizers ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 102.6 %   mem: [  37,   37,   37] MB 
    [DSK: Collecting stats on combined       ]  100  %   elapsed:   0 min 2  sec   remaining:   0 min 0  sec   cpu:  95.5 %   mem: [  55,   55,   55] MB 
    [DSK: nb solid kmers: 937750             ]  100  %   elapsed:   0 min 44 sec   remaining:   0 min 0  sec   cpu: 193.6 %   mem: [ 137,  913,  952] MB 
    bcalm_algo params, prefix:results/minia57_results/minia57.unitigs.fa k:57 a:2 minsize:10 threads:4 mintype:1
    DSK used 1 passes and 4 partitions
    prior to queues allocation                      17:48:10     memory [current, maxRSS]: [ 132,  952] MB 
    Starting BCALM2                                 17:48:10     memory [current, maxRSS]: [ 132,  952] MB 
    [Iterating DSK partitions                ]  100  %   elapsed:   0 min 7  sec   remaining:   0 min 0  sec
    Number of sequences in glue: 181225
    Number of pre-tips removed : 0
    Buckets compaction and gluing           : 7.0 secs
    Within that, 
                                     creating buckets from superbuckets: 1.7 secs
                          bucket compaction (wall-clock during threads): 5.3 secs
    
                    within all bucket compaction threads,
                           adding nodes to subgraphs: 7.7 secs
             subgraphs constructions and compactions: 8.1 secs
                      compacted nodes redistribution: 4.5 secs
    Sum of CPU times for bucket compactions: 22.0 secs
    BCALM total wallclock (excl kmer counting): 7.3 secs
    Maximum number of kmers in a subgraph: 775
    Performance of compaction step:
    
                     Wallclock time spent in parallel section : 5.3 secs
                 Best theoretical speedup in parallel section : 266.9x
    Best theor. speedup in parallel section using 1 threads : 1.0x
                 Sum of longest bucket compaction for each sb : 0.1 secs
                           Sum of best scheduling for each sb : 20.6 secs
    Done with all compactions                       17:48:17     memory [current, maxRSS]: [ 217,  952] MB 
    bglue_algo params, prefix:results/minia57_results/minia57.unitigs.fa k:57 threads:4
    Starting bglue with 4 threads                   17:48:17     memory [current, maxRSS]: [ 217,  952] MB 
    number of sequences to be glued: 181225         17:48:17     memory [current, maxRSS]: [ 217,  952] MB 
    75640 marked kmers, 136394 unmarked kmers        17:48:17     memory [current, maxRSS]: [ 217,  952] MB 
    created vector of hashes, size approx 0 MB)        17:48:17     memory [current, maxRSS]: [ 217,  952] MB 
    pass 1/3, 37820 unique hashes written to disk, size 0 MB        17:48:17     memory [current, maxRSS]: [ 217,  952] MB 
    75206 marked kmers, 136394 unmarked kmers        17:48:18     memory [current, maxRSS]: [ 219,  952] MB 
    created vector of hashes, size approx 0 MB)        17:48:18     memory [current, maxRSS]: [ 219,  952] MB 
    pass 2/3, 37603 unique hashes written to disk, size 0 MB        17:48:18     memory [current, maxRSS]: [ 219,  952] MB 
    75210 marked kmers, 136394 unmarked kmers        17:48:18     memory [current, maxRSS]: [ 221,  952] MB 
    created vector of hashes, size approx 0 MB)        17:48:18     memory [current, maxRSS]: [ 221,  952] MB 
    pass 3/3, 37605 unique hashes written to disk, size 0 MB        17:48:18     memory [current, maxRSS]: [ 221,  952] MB 
    loaded all unique UF elements (113028) into a single vector of size 0 MB        17:48:18     memory [current, maxRSS]: [ 221,  952] MB 
    [Building BooPHF]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec
    Bitarray          538304  bits (100.00 %)   (array + ranks )
    final hash             0  bits (0.00 %) (nb in final hash 0)
    UF MPHF constructed (0 MB)                      17:48:18     memory [current, maxRSS]: [ 221,  952] MB 
    UF constructed                                  17:48:18     memory [current, maxRSS]: [ 222,  952] MB 
    freed original UF (0 MB)                        17:48:18     memory [current, maxRSS]: [ 222,  952] MB 
    loaded 32-bit UF (0 MB)                         17:48:18     memory [current, maxRSS]: [ 222,  952] MB 
    Allowed 95 MB memory for buffers                17:48:18     memory [current, maxRSS]: [ 222,  952] MB 
    Disk partitioning of glue                       17:48:18     memory [current, maxRSS]: [ 222,  952] MB 
    Done disk partitioning of glue                  17:48:19     memory [current, maxRSS]: [ 222,  952] MB 
    Top 10 glue partitions by size:
    Glue partition 1508 has 164 sequences 
    Glue partition 1967 has 147 sequences 
    Glue partition 845 has 146 sequences 
    Glue partition 254 has 141 sequences 
    Glue partition 864 has 140 sequences 
    Glue partition 447 has 139 sequences 
    Glue partition 1877 has 137 sequences 
    Glue partition 72 has 136 sequences 
    Glue partition 312 has 136 sequences 
    Glue partition 578 has 134 sequences 
    Glueing partitions                              17:48:19     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 0 (size: 0 MB)                 17:48:19     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 20 (size: 0 MB)                17:48:19     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 40 (size: 0 MB)                17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 60 (size: 0 MB)                17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 80 (size: 0 MB)                17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 100 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 120 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 140 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 160 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 180 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 200 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 220 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 240 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 260 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 280 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 300 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 320 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 340 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 360 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 380 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 400 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 420 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 440 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 460 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 480 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 500 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 520 (size: 0 MB)               17:48:20     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 540 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 560 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 580 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 600 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 620 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 640 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 660 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 680 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 700 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 720 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 740 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 760 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 780 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 800 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 820 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 840 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 860 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 880 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 900 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 920 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 940 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 960 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 980 (size: 0 MB)               17:48:21     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1000 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1020 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1040 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1060 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1080 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1100 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1120 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1140 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1160 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1180 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1200 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1220 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1240 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1260 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1280 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1300 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1320 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1340 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1360 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1380 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1400 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1420 (size: 0 MB)              17:48:22     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1440 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1460 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1480 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1500 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1520 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1540 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1560 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1580 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1600 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1620 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1640 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1660 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1680 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1700 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1720 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1740 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1760 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1780 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1800 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1820 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1840 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1860 (size: 0 MB)              17:48:23     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1880 (size: 0 MB)              17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1900 (size: 0 MB)              17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1920 (size: 0 MB)              17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1940 (size: 0 MB)              17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1960 (size: 0 MB)              17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    Gluing partition 1980 (size: 0 MB)              17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    end                                             17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    Finding links between unitigs                   17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 0                                   17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (15238kmers/30656extremities)            17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 1                                   17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (15521kmers/29708extremities)            17:48:24     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 2                                   17:48:25     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (2948kmers/5836extremities)              17:48:25     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 3                                   17:48:25     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (8248kmers/15931extremities)             17:48:25     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 4                                   17:48:25     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (11571kmers/22866extremities)            17:48:25     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 5                                   17:48:26     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (9559kmers/18724extremities)             17:48:26     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 6                                   17:48:26     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (3105kmers/6329extremities)              17:48:26     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 7                                   17:48:26     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (3336kmers/6344extremities)              17:48:26     memory [current, maxRSS]: [ 222,  952] MB 
    gathering links from disk                       17:48:26     memory [current, maxRSS]: [ 222,  952] MB 
    Done finding links between unitigs              17:48:27     memory [current, maxRSS]: [ 222,  952] MB 
    [removing tips,    pass  1               ]  99.9 %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 194.9 %   mem: [ 222,  222,  952] MB 
    [removing tips,    pass  2               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 152.9 %   mem: [ 222,  222,  952] MB 
    [removing tips,    pass  3               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 156.2 %   mem: [ 222,  222,  952] MB 
    [removing tips,    pass  4               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 153.3 %   mem: [ 222,  222,  952] MB 
    [removing tips,    pass  5               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 171.4 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass  1               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 253.4 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass  2               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 265.8 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass  3               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 271.9 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass  4               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 256.2 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass  5               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 241.9 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass  6               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 255.6 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass  7               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 255.9 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass  8               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 229.7 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass  9               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 245.5 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 10               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 157.1 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 11               ]  100  %   elapsed:   0 min 1  sec   remaining:   0 min 0  sec   cpu: 160.0 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 12               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 202.4 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 13               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 222.2 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 14               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 185.7 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 15               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 185.7 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 16               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 197.4 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 17               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 185.4 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 18               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 236.7 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 19               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 225.0 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 20               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 221.2 %   mem: [ 222,  222,  952] MB 
    [removing ec,      pass  1               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 184.6 %   mem: [ 222,  222,  952] MB 
    [removing ec,      pass  2               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 225.0 %   mem: [ 222,  222,  952] MB 
    [removing ec,      pass  3               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 200.0 %   mem: [ 222,  222,  952] MB 
    [removing tips,    pass  6               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 200.0 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 21               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 218.2 %   mem: [ 222,  222,  952] MB 
    [removing ec,      pass  4               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 125.0 %   mem: [ 222,  222,  952] MB 
    [removing tips,    pass  7               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 176.9 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 22               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 233.3 %   mem: [ 222,  222,  952] MB 
    [removing ec,      pass  5               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 142.9 %   mem: [ 222,  222,  952] MB 
    [removing tips,    pass  8               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 176.9 %   mem: [ 222,  222,  952] MB 
    [removing bulges,  pass 23               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 164.3 %   mem: [ 222,  222,  952] MB 
    [removing ec,      pass  6               ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 137.5 %   mem: [ 222,  222,  952] MB 
    [Minia : assembly                        ]  100  %   elapsed:   0 min 0  sec   remaining:   0 min 0  sec   cpu: 108.3 %   mem: [ 222,  222,  952] MB 
    Finding links between unitigs                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 0                                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (4kmers/8extremities)                    17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 1                                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (10kmers/26extremities)                  17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 2                                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (1kmers/1extremities)                    17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 3                                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (0kmers/0extremities)                    17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 4                                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (6kmers/16extremities)                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 5                                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (3kmers/7extremities)                    17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 6                                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (1kmers/3extremities)                    17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 1 pass 7                                   17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    step 2 (1kmers/3extremities)                    17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    gathering links from disk                       17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
    Done finding links between unitigs              17:48:40     memory [current, maxRSS]: [ 222,  952] MB 
        -in                                      : all_data/reads_data/combined.fq
        -kmer-size                               : 57
        -out                                     : results/minia57_results/minia57
        -traversal                               : contig
        -fasta-line                              : 0
        -tip-len-topo-kmult                      : 2.500000
        -tip-len-rctc-kmult                      : 10.000000
        -tip-rctc-cutoff                         : 2.000000
        -bulge-len-kmult                         : 3.000000
        -bulge-len-kadd                          : 100
        -bulge-altpath-kadd                      : 50
        -bulge-altpath-covmult                   : 1.100000
        -ec-len-kmult                            : 9.000000
        -ec-rctc-cutoff                          : 4.000000
        -abundance-min                           : 2
        -abundance-max                           : 2147483647
        -abundance-min-threshold                 : 2
        -histo-max                               : 10000
        -solidity-kind                           : sum
        -max-memory                              : 5000
        -max-disk                                : 0
        -out-dir                                 : .
        -out-tmp                                 : .
        -out-compress                            : 0
        -storage-type                            : hdf5
        -histo2D                                 : 0
        -histo                                   : 0
        -minimizer-type                          : 1
        -minimizer-size                          : 10
        -repartition-type                        : 1
        -bloom                                   : neighbor
        -debloom                                 : cascading
        -debloom-impl                            : minimizer
        -branching-nodes                         : stored
        -topology-stats                          : 0
        -nb-cores                                : 4
        -edge-km                                 : 0
        -verbose                                 : 1
        -integer-precision                       : 0
        -nb-glue-partitions                      : 0
        -storage-type                            : 1
        -verbose                                 : 1
        -verbose                                 : 1
        -verbose                                 : 1
        stats                                   
            traversal                                : contig
            nb_solid_kmers                           : 937750
            nb_contigs                               : 32
            nb_small_contigs_discarded               : 6791
            nt_assembled                             : 31577
            max_length                               : 10503
            graph simpification stats               
                tips removed                             : 32311 + 1014 + 53 + 23 + 4 + 155 + 4 + 3
                bulges removed                           : 2416 + 1137 + 568 + 284 + 140 + 86 + 53 + 38 + 27 + 19 + 12 + 18 + 16 + 20 + 19 + 15 + 20 + 13 + 13 + 6 + 2 + 0 + 1
                EC removed                               : 606 + 31 + 0 + 0 + 2 + 1
            assembly traversal stats                
        time                                     : 78.136
            assembly                                 : 12.800
            graph construction                       : 65.336
    (bioriyaz) 




```bash
# check minia57 result
seqkit stat results/minia57_results/minia57.contigs.fa
```

    (bioriyaz) file                                        format  type  num_seqs  sum_len  min_len  avg_len  max_len
    results/minia57_results/minia57.contigs.fa  FASTA   DNA         32   31,577       57    986.8   10,503
    (bioriyaz) 



## Assembly with Velvet

### Calculate insert size


```bash
bwa index $REF
bwa mem $REF $READ1 $READ2 | samtools view -F 4 -f 3 -F 16 | datamash mean 9
```

    [bwa_index] Pack FASTA... 0.00 sec
    [bwa_index] Construct BWT for the packed sequence...
    [bwa_index] 0.01 seconds elapse.
    [bwa_index] Update BWT... 0.00 sec
    [bwa_index] Pack forward-only FASTA... 0.00 sec
    [bwa_index] Construct SA from BWT and Occ... 0.01 sec
    [main] Version: 0.7.17-r1188
    [main] CMD: bwa index all_data/refs/NC_045512.2.fa
    [main] Real time: 0.045 sec; CPU: 0.023 sec
    (bioriyaz) [M::bwa_idx_load_from_disk] read 0 ALT contigs
    [M::process] read 72388 sequences (10000007 bp)...
    [M::process] read 74106 sequences (10000000 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (27, 35598, 95, 31)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (97, 129, 232)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 502)
    [M::mem_pestat] mean and std.dev: (142.79, 78.12)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 637)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (144, 208, 266)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 510)
    [M::mem_pestat] mean and std.dev: (206.81, 85.07)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 632)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (341, 485, 923)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2087)
    [M::mem_pestat] mean and std.dev: (583.52, 365.58)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2669)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (78, 138, 203)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 453)
    [M::mem_pestat] mean and std.dev: (142.43, 78.58)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 578)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 72388 reads in 5.848 CPU sec, 5.785 real sec
    [M::process] read 74240 sequences (10000245 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (34, 36326, 103, 37)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (82, 128, 184)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 388)
    [M::mem_pestat] mean and std.dev: (128.52, 74.40)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 490)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (134, 202, 264)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 524)
    [M::mem_pestat] mean and std.dev: (200.93, 87.89)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 654)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (324, 509, 964)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2244)
    [M::mem_pestat] mean and std.dev: (586.11, 338.38)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2884)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (95, 130, 185)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 365)
    [M::mem_pestat] mean and std.dev: (130.29, 53.01)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 455)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74106 reads in 5.862 CPU sec, 5.815 real sec
    [M::process] read 74132 sequences (10000044 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (26, 36404, 98, 37)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (140, 242, 521)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1283)
    [M::mem_pestat] mean and std.dev: (286.52, 262.67)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1664)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (132, 202, 264)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 528)
    [M::mem_pestat] mean and std.dev: (200.46, 88.06)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 660)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (309, 446, 841)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1905)
    [M::mem_pestat] mean and std.dev: (541.69, 377.36)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2437)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (71, 151, 356)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 926)
    [M::mem_pestat] mean and std.dev: (210.94, 215.50)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1211)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74240 reads in 5.890 CPU sec, 5.950 real sec
    [M::process] read 74098 sequences (10000006 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (14, 36390, 92, 29)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (96, 219, 401)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1011)
    [M::mem_pestat] mean and std.dev: (242.77, 197.40)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1316)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (132, 199, 259)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 513)
    [M::mem_pestat] mean and std.dev: (197.55, 85.06)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 640)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (313, 439, 918)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2128)
    [M::mem_pestat] mean and std.dev: (572.82, 390.23)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2733)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (162, 258, 471)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1089)
    [M::mem_pestat] mean and std.dev: (250.40, 139.79)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1398)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74132 reads in 6.053 CPU sec, 5.899 real sec
    [M::process] read 74528 sequences (10000088 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (23, 36210, 92, 34)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (99, 165, 248)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 546)
    [M::mem_pestat] mean and std.dev: (147.80, 70.10)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 695)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (131, 199, 260)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 518)
    [M::mem_pestat] mean and std.dev: (197.75, 86.20)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 647)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (331, 565, 861)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1921)
    [M::mem_pestat] mean and std.dev: (608.15, 383.04)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2451)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (89, 151, 281)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 665)
    [M::mem_pestat] mean and std.dev: (133.89, 73.35)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 857)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74098 reads in 6.320 CPU sec, 6.234 real sec
    [M::process] read 74486 sequences (10000251 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (31, 36067, 94, 27)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (102, 139, 195)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 381)
    [M::mem_pestat] mean and std.dev: (140.17, 59.74)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 474)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (129, 200, 261)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 525)
    [M::mem_pestat] mean and std.dev: (197.50, 87.97)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 657)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (299, 530, 908)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2126)
    [M::mem_pestat] mean and std.dev: (618.58, 469.83)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2735)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (101, 143, 215)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 443)
    [M::mem_pestat] mean and std.dev: (147.54, 69.98)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 557)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74528 reads in 6.464 CPU sec, 6.279 real sec
    [M::process] read 74464 sequences (10000232 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (23, 36433, 76, 24)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (79, 184, 387)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1003)
    [M::mem_pestat] mean and std.dev: (181.60, 152.62)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1311)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (131, 199, 260)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 518)
    [M::mem_pestat] mean and std.dev: (197.45, 86.78)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 647)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (305, 463, 789)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1757)
    [M::mem_pestat] mean and std.dev: (534.86, 328.96)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2241)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (85, 131, 153)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 289)
    [M::mem_pestat] mean and std.dev: (99.26, 41.06)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 357)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74486 reads in 6.136 CPU sec, 6.073 real sec
    [M::process] read 74290 sequences (10000278 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (22, 36479, 91, 22)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (131, 178, 515)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1283)
    [M::mem_pestat] mean and std.dev: (248.90, 192.48)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1667)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (131, 198, 260)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 518)
    [M::mem_pestat] mean and std.dev: (197.04, 86.19)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 647)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (250, 458, 812)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1936)
    [M::mem_pestat] mean and std.dev: (522.79, 324.01)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2498)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (45, 107, 217)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 561)
    [M::mem_pestat] mean and std.dev: (141.90, 119.34)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 733)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74464 reads in 6.004 CPU sec, 5.938 real sec
    [M::process] read 74156 sequences (10000296 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (25, 36363, 106, 27)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (95, 135, 305)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 725)
    [M::mem_pestat] mean and std.dev: (164.45, 146.02)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 935)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (132, 200, 262)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 522)
    [M::mem_pestat] mean and std.dev: (199.32, 87.43)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 652)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (338, 582, 869)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1931)
    [M::mem_pestat] mean and std.dev: (605.58, 349.52)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2462)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (114, 156, 219)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 429)
    [M::mem_pestat] mean and std.dev: (154.17, 73.82)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 534)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74290 reads in 6.253 CPU sec, 6.143 real sec
    [M::process] read 72548 sequences (10000112 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (14, 36338, 118, 22)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (119, 172, 234)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 464)
    [M::mem_pestat] mean and std.dev: (160.25, 74.74)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 579)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (134, 202, 264)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 524)
    [M::mem_pestat] mean and std.dev: (200.47, 87.74)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 654)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (322, 572, 839)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1873)
    [M::mem_pestat] mean and std.dev: (571.81, 354.22)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2390)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (101, 184, 317)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 749)
    [M::mem_pestat] mean and std.dev: (174.11, 109.81)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 965)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74156 reads in 5.988 CPU sec, 5.812 real sec
    [M::process] read 73592 sequences (10000288 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (20, 35716, 95, 14)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (99, 140, 470)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1212)
    [M::mem_pestat] mean and std.dev: (189.82, 183.35)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1583)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (142, 206, 266)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 514)
    [M::mem_pestat] mean and std.dev: (205.71, 84.91)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 638)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (309, 507, 879)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2019)
    [M::mem_pestat] mean and std.dev: (598.53, 419.97)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2589)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (91, 110, 141)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 241)
    [M::mem_pestat] mean and std.dev: (110.29, 41.96)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 291)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 72548 reads in 5.908 CPU sec, 5.869 real sec
    [M::process] read 74340 sequences (10000213 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (17, 36024, 92, 21)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (91, 125, 208)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 442)
    [M::mem_pestat] mean and std.dev: (140.33, 94.63)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 559)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (137, 203, 263)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 515)
    [M::mem_pestat] mean and std.dev: (201.06, 85.10)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 641)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (323, 587, 886)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2012)
    [M::mem_pestat] mean and std.dev: (587.89, 359.68)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2575)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (123, 156, 211)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 387)
    [M::mem_pestat] mean and std.dev: (148.05, 60.57)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 475)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 73592 reads in 6.178 CPU sec, 6.093 real sec
    [M::process] read 74276 sequences (10000282 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (23, 36100, 90, 19)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (133, 153, 283)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 583)
    [M::mem_pestat] mean and std.dev: (196.29, 120.65)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 733)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (130, 199, 261)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 523)
    [M::mem_pestat] mean and std.dev: (197.85, 87.45)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 654)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (319, 450, 767)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1663)
    [M::mem_pestat] mean and std.dev: (507.56, 301.60)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2111)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (125, 159, 322)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 716)
    [M::mem_pestat] mean and std.dev: (166.56, 98.52)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 913)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74340 reads in 6.518 CPU sec, 6.338 real sec
    [M::process] read 73364 sequences (10000012 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (16, 36358, 82, 31)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (89, 150, 282)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 668)
    [M::mem_pestat] mean and std.dev: (150.50, 96.61)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 861)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (132, 200, 261)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 519)
    [M::mem_pestat] mean and std.dev: (198.56, 87.00)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 648)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (282, 462, 780)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1776)
    [M::mem_pestat] mean and std.dev: (543.81, 393.78)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2274)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (92, 146, 288)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 680)
    [M::mem_pestat] mean and std.dev: (154.77, 129.37)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 876)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74276 reads in 6.227 CPU sec, 6.077 real sec
    [M::process] read 74464 sequences (10000236 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (16, 36070, 97, 26)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (107, 150, 714)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1928)
    [M::mem_pestat] mean and std.dev: (305.53, 313.18)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2535)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (136, 202, 261)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 511)
    [M::mem_pestat] mean and std.dev: (200.28, 84.01)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 636)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (301, 540, 939)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2215)
    [M::mem_pestat] mean and std.dev: (602.15, 396.63)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2853)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (103, 158, 351)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 847)
    [M::mem_pestat] mean and std.dev: (220.08, 189.57)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1095)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 73364 reads in 6.206 CPU sec, 6.117 real sec
    [M::process] read 74136 sequences (10000125 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (24, 36606, 63, 35)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (99, 197, 493)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1281)
    [M::mem_pestat] mean and std.dev: (216.19, 163.60)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1675)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (130, 197, 256)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 508)
    [M::mem_pestat] mean and std.dev: (194.97, 84.34)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 634)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (283, 514, 844)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1966)
    [M::mem_pestat] mean and std.dev: (573.60, 412.97)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2527)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (110, 158, 316)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 728)
    [M::mem_pestat] mean and std.dev: (216.62, 167.45)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 934)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74464 reads in 6.068 CPU sec, 5.965 real sec
    [M::process] read 72204 sequences (10000050 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (26, 36380, 93, 35)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (107, 172, 305)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 701)
    [M::mem_pestat] mean and std.dev: (207.04, 138.59)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 899)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (134, 202, 263)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 521)
    [M::mem_pestat] mean and std.dev: (200.37, 87.75)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 650)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (345, 489, 888)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1974)
    [M::mem_pestat] mean and std.dev: (578.40, 344.13)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2517)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (75, 126, 265)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 645)
    [M::mem_pestat] mean and std.dev: (174.00, 138.04)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 835)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74136 reads in 6.022 CPU sec, 5.851 real sec
    [M::process] read 74244 sequences (10000052 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (20, 35556, 77, 39)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (83, 107, 216)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 482)
    [M::mem_pestat] mean and std.dev: (108.12, 49.47)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 615)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (145, 208, 267)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 511)
    [M::mem_pestat] mean and std.dev: (207.34, 84.02)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 633)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (314, 553, 782)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1718)
    [M::mem_pestat] mean and std.dev: (546.54, 297.54)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2186)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (103, 165, 377)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 925)
    [M::mem_pestat] mean and std.dev: (227.17, 194.54)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1199)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 72204 reads in 6.121 CPU sec, 5.984 real sec
    [M::process] read 74634 sequences (10000068 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (16, 36456, 100, 26)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (101, 167, 233)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 497)
    [M::mem_pestat] mean and std.dev: (135.85, 56.41)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 629)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (132, 198, 260)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 516)
    [M::mem_pestat] mean and std.dev: (197.40, 85.74)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 644)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (297, 487, 854)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1968)
    [M::mem_pestat] mean and std.dev: (528.84, 349.77)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2525)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (116, 171, 238)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 482)
    [M::mem_pestat] mean and std.dev: (152.38, 53.69)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 604)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74244 reads in 5.994 CPU sec, 5.852 real sec
    [M::process] read 74206 sequences (10000146 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (19, 36617, 73, 28)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (91, 134, 463)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1207)
    [M::mem_pestat] mean and std.dev: (188.53, 161.70)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1579)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (129, 196, 256)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 510)
    [M::mem_pestat] mean and std.dev: (194.55, 85.22)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 637)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (351, 660, 933)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2097)
    [M::mem_pestat] mean and std.dev: (686.63, 423.30)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2679)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (114, 195, 342)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 798)
    [M::mem_pestat] mean and std.dev: (202.54, 153.96)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1026)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74634 reads in 6.075 CPU sec, 5.929 real sec
    [M::process] read 74168 sequences (10000151 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (18, 36386, 86, 22)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (96, 144, 493)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1287)
    [M::mem_pestat] mean and std.dev: (219.69, 191.87)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1684)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (132, 199, 260)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 516)
    [M::mem_pestat] mean and std.dev: (197.75, 85.78)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 644)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (263, 489, 842)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2000)
    [M::mem_pestat] mean and std.dev: (535.41, 345.31)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2579)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (55, 116, 171)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 403)
    [M::mem_pestat] mean and std.dev: (104.37, 59.49)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 519)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74206 reads in 6.180 CPU sec, 6.128 real sec
    [M::process] read 72528 sequences (10000206 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (12, 36348, 106, 30)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (84, 126, 174)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 354)
    [M::mem_pestat] mean and std.dev: (119.25, 54.65)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 444)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (131, 197, 259)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 515)
    [M::mem_pestat] mean and std.dev: (197.08, 85.64)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 643)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (309, 474, 943)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2211)
    [M::mem_pestat] mean and std.dev: (558.10, 341.17)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2845)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (106, 158, 230)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 478)
    [M::mem_pestat] mean and std.dev: (135.62, 73.84)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 602)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74168 reads in 6.064 CPU sec, 5.924 real sec
    [M::process] read 73188 sequences (10000226 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (25, 35675, 108, 32)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (127, 150, 592)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1522)
    [M::mem_pestat] mean and std.dev: (241.27, 245.12)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1987)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (142, 206, 266)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 514)
    [M::mem_pestat] mean and std.dev: (205.61, 84.55)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 638)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (347, 631, 952)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2162)
    [M::mem_pestat] mean and std.dev: (611.71, 363.71)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2767)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (87, 139, 207)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 447)
    [M::mem_pestat] mean and std.dev: (130.89, 58.59)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 567)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 72528 reads in 5.888 CPU sec, 5.749 real sec
    [M::process] read 73968 sequences (10000181 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (27, 35930, 88, 30)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (88, 144, 242)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 550)
    [M::mem_pestat] mean and std.dev: (162.92, 107.15)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 704)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (140, 206, 265)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 515)
    [M::mem_pestat] mean and std.dev: (204.13, 86.12)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 640)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (301, 433, 641)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1321)
    [M::mem_pestat] mean and std.dev: (457.79, 255.67)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1661)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (85, 146, 208)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 454)
    [M::mem_pestat] mean and std.dev: (132.56, 57.88)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 577)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 73188 reads in 5.862 CPU sec, 5.773 real sec
    [M::process] read 74182 sequences (10000271 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (21, 36280, 81, 31)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (103, 120, 264)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 586)
    [M::mem_pestat] mean and std.dev: (149.00, 85.87)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 747)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (135, 202, 262)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 516)
    [M::mem_pestat] mean and std.dev: (200.07, 86.19)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 643)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (333, 482, 735)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1539)
    [M::mem_pestat] mean and std.dev: (494.77, 253.23)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1941)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (127, 173, 285)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 601)
    [M::mem_pestat] mean and std.dev: (183.07, 106.56)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 759)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 73968 reads in 5.951 CPU sec, 5.745 real sec
    [M::process] read 73352 sequences (10000203 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (20, 36382, 95, 42)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (94, 109, 259)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 589)
    [M::mem_pestat] mean and std.dev: (162.89, 127.73)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 754)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (133, 202, 262)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 520)
    [M::mem_pestat] mean and std.dev: (198.97, 86.25)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 649)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (280, 420, 817)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1891)
    [M::mem_pestat] mean and std.dev: (548.92, 385.33)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2428)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (114, 150, 273)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 591)
    [M::mem_pestat] mean and std.dev: (163.51, 93.36)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 750)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74182 reads in 5.941 CPU sec, 5.808 real sec
    [M::process] read 74608 sequences (10000125 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (13, 36147, 66, 22)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (133, 164, 347)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 775)
    [M::mem_pestat] mean and std.dev: (210.08, 141.58)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 989)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (137, 201, 260)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 506)
    [M::mem_pestat] mean and std.dev: (199.79, 83.21)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 629)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (289, 602, 1003)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2431)
    [M::mem_pestat] mean and std.dev: (616.29, 397.34)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 3145)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (84, 109, 168)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 336)
    [M::mem_pestat] mean and std.dev: (132.09, 60.69)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 420)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 73352 reads in 5.907 CPU sec, 5.777 real sec
    [M::process] read 74800 sequences (10000104 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (34, 36569, 104, 29)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (88, 146, 218)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 478)
    [M::mem_pestat] mean and std.dev: (136.40, 76.14)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 608)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (130, 200, 261)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 523)
    [M::mem_pestat] mean and std.dev: (197.24, 86.72)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 654)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (266, 434, 774)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1790)
    [M::mem_pestat] mean and std.dev: (499.12, 309.41)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2298)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (104, 190, 513)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1331)
    [M::mem_pestat] mean and std.dev: (246.15, 173.88)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1740)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74608 reads in 5.897 CPU sec, 5.691 real sec
    [M::process] read 23186 sequences (3103799 bp)...
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (23, 36655, 56, 39)
    [M::mem_pestat] analyzing insert size distribution for orientation FF...
    [M::mem_pestat] (25, 50, 75) percentile: (117, 172, 559)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1443)
    [M::mem_pestat] mean and std.dev: (315.50, 303.84)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1885)
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (128, 196, 257)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 515)
    [M::mem_pestat] mean and std.dev: (194.45, 85.62)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 644)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (354, 617, 863)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 1881)
    [M::mem_pestat] mean and std.dev: (588.09, 330.54)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 2390)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (108, 149, 393)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 963)
    [M::mem_pestat] mean and std.dev: (225.78, 214.44)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 1248)
    [M::mem_pestat] skip orientation FF
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 74800 reads in 5.945 CPU sec, 5.905 real sec
    [M::mem_pestat] # candidate unique pairs for (FF, FR, RF, RR): (7, 11384, 24, 14)
    [M::mem_pestat] skip orientation FF as there are not enough pairs
    [M::mem_pestat] analyzing insert size distribution for orientation FR...
    [M::mem_pestat] (25, 50, 75) percentile: (129, 197, 260)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 522)
    [M::mem_pestat] mean and std.dev: (196.58, 87.06)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 653)
    [M::mem_pestat] analyzing insert size distribution for orientation RF...
    [M::mem_pestat] (25, 50, 75) percentile: (288, 735, 1103)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 2733)
    [M::mem_pestat] mean and std.dev: (537.76, 365.28)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 3548)
    [M::mem_pestat] analyzing insert size distribution for orientation RR...
    [M::mem_pestat] (25, 50, 75) percentile: (108, 193, 212)
    [M::mem_pestat] low and high boundaries for computing mean and std.dev: (1, 420)
    [M::mem_pestat] mean and std.dev: (177.57, 84.57)
    [M::mem_pestat] low and high boundaries for proper pairs: (1, 524)
    [M::mem_pestat] skip orientation RF
    [M::mem_pestat] skip orientation RR
    [M::mem_process_seqs] Processed 23186 reads in 1.951 CPU sec, 1.984 real sec
    [main] Version: 0.7.17-r1188
    [main] CMD: bwa mem all_data/refs/NC_045512.2.fa all_data/reads_data/ERR5494176_1.fastq all_data/reads_data/ERR5494176_2.fastq
    [main] Real time: 174.815 sec; CPU: 177.946 sec
    223.93635526269
    (bioriyaz) 



#### Estimated insert size: 224


```bash
#compute subsequences of a given k-mer (31) size
velveth results/velvet57 57 -fastq -separate -shortPaired $READ1 $READ2

#assemble the genome from these precomputed data
velvetg results/velvet57 -exp_cov auto -ins_length 224
```

    (bioriyaz) [0.000000] Reading FastQ file all_data/reads_data/ERR5494176_1.fastq;
    [0.000055] Reading FastQ file all_data/reads_data/ERR5494176_2.fastq;
    [15.941387] 2166876 sequences found in total in the paired sequence files
    [15.941406] Done
    [16.031719] Reading read set file results/velvet57/Sequences;
    [17.126221] 2166876 sequences found
    [22.084923] Done
    [22.084963] 2166876 sequences in total.
    [22.085054] Writing into roadmap file results/velvet57/Roadmaps...
    [28.402002] Inputting sequences...
    [28.403356] Inputting sequence 0 / 2166876
    [65.163348] Inputting sequence 2000000 / 2166876
    [72.929892] Inputting sequence 1000000 / 2166876
    [79.275620]  === Sequences loaded in 50.873643 s
    [79.275696] Done inputting sequences
    [79.275707] Destroying splay table
    [79.344171] Splay table destroyed
    (bioriyaz) (bioriyaz) (bioriyaz) [0.000001] Reading roadmap file results/velvet57/Roadmaps
    [8.536537] 2166876 roadmaps read
    [8.539423] Creating insertion markers
    [9.124882] Ordering insertion markers
    [11.939317] Counting preNodes
    [12.405338] 365441 preNodes counted, creating them now
    [20.425763] Sequence 1000000 / 2166876
    [28.419213] Sequence 2000000 / 2166876
    [29.636253] Adjusting marker info...
    [30.199262] Connecting preNodes
    [42.773260] Connecting 2000000 / 2166876
    [46.138039] Connecting 1000000 / 2166876
    [49.737181] Cleaning up memory
    [49.752956] Done creating preGraph
    [49.752982] Concatenation...
    [50.030722] Renumbering preNodes
    [50.030748] Initial preNode count 365441
    [50.093280] Destroyed 164286 preNodes
    [50.093305] Concatenation over!
    [50.093314] Clipping short tips off preGraph
    [50.201304] Concatenation...
    [50.284149] Renumbering preNodes
    [50.284182] Initial preNode count 201155
    [50.330357] Destroyed 73823 preNodes
    [50.330393] Concatenation over!
    [50.330398] 56005 tips cut off
    [50.330408] 127332 nodes left
    [50.330513] Writing into pregraph file results/velvet57/PreGraph...
    [51.424086] Reading read set file results/velvet57/Sequences;
    [52.183969] 2166876 sequences found
    [55.865865] Done
    [61.501044] Reading pre-graph file results/velvet57/PreGraph
    [61.505762] Graph has 127332 nodes and 2166876 sequences
    [62.143478] Scanning pre-graph file results/velvet57/PreGraph for k-mers
    [62.584156] 2875459 kmers found
    [63.350071] Sorting kmer occurence table ... 
    [66.032348] Sorting done.
    [66.032375] Computing acceleration table... 
    [66.095940] Computing offsets... 
    [66.156079] Ghost Threading through reads 0 / 2166876
    [99.203578] Ghost Threading through reads 2000000 / 2166876
    [107.787573] Ghost Threading through reads 1000000 / 2166876
    [114.951475]  === Ghost-Threaded in 48.802968 s
    [114.951518] Threading through reads 0 / 2166876
    [163.096346] Threading through reads 2000000 / 2166876
    [174.926471] Threading through reads 1000000 / 2166876
    [187.599228]  === Threaded in 72.647729 s
    [214.966235] Correcting graph with cutoff 0.200000
    [214.972153] Determining eligible starting points
    [215.197632] Done listing starting nodes
    [215.197656] Initializing todo lists
    [215.244323] Done with initilization
    [215.244349] Activating arc lookup table
    [215.336259] Done activating arc lookup table
    [217.139237] 10000 / 127332 nodes visited
    [219.955732] 20000 / 127332 nodes visited
    [222.683702] 30000 / 127332 nodes visited
    [225.606314] 40000 / 127332 nodes visited
    [228.798360] 50000 / 127332 nodes visited
    [230.826489] 60000 / 127332 nodes visited
    [234.112290] 70000 / 127332 nodes visited
    [237.986543] 80000 / 127332 nodes visited
    [241.529703] 90000 / 127332 nodes visited
    [246.110095] 100000 / 127332 nodes visited
    [249.560982] 110000 / 127332 nodes visited
    [252.252599] 120000 / 127332 nodes visited
    [254.088146] 130000 / 127332 nodes visited
    [255.049967] 140000 / 127332 nodes visited
    [255.066800] Concatenation...
    [255.081571] Renumbering nodes
    [255.081600] Initial node count 127332
    [255.086211] Removed 64708 null nodes
    [255.086246] Concatenation over!
    [255.086250] Clipping short tips off graph, drastic
    [255.164625] Concatenation...
    [255.427532] Renumbering nodes
    [255.427569] Initial node count 62624
    [255.435289] Removed 18138 null nodes
    [255.435336] Concatenation over!
    [255.435343] 44486 nodes left
    [255.436732] Writing into graph file results/velvet57/Graph2...
    [293.394294] Measuring median coverage depth...
    [293.430715] Median coverage depth = 1.771930
    [293.431122] Removing contigs with coverage < 0.885965...
    [293.434920] Concatenation...
    [293.444892] Renumbering nodes
    [293.444912] Initial node count 44486
    [293.445122] Removed 0 null nodes
    [293.445135] Concatenation over!
    [293.448992] Concatenation...
    [293.459076] Renumbering nodes
    [293.459099] Initial node count 44486
    [293.459325] Removed 0 null nodes
    [293.459335] Concatenation over!
    [293.459341] Clipping short tips off graph, drastic
    [293.461801] Concatenation...
    [293.471421] Renumbering nodes
    [293.471449] Initial node count 44486
    [293.471672] Removed 0 null nodes
    [293.471687] Concatenation over!
    [293.471695] 44486 nodes left
    [293.471704] Read coherency...
    [293.474459] Identifying unique nodes
    [293.477151] Done, 5221 unique nodes counted
    [293.477179] Trimming read tips
    [293.482090] Renumbering nodes
    [293.482113] Initial node count 44486
    [293.482339] Removed 0 null nodes
    [293.482353] Confronted to 0 multiple hits and 0 null over 0
    [293.482361] Read coherency over!
    [293.501410] Starting pebble resolution...
    [293.518906] Computing read to node mapping array sizes
    [294.568368] Computing read to node mappings
    [302.628216] Estimating library insert lengths...
    [302.643842] Done
    [302.643939] Computing direct node to node mappings
    [302.667135] Scaffolding node -20000
    [302.667493] Scaffolding node -40000
    [302.692902] Scaffolding node 30000
    [302.745717] Scaffolding node -10000
    [302.756619] Scaffolding node -30000
    [302.804624] Scaffolding node 40000
    [302.820901] Scaffolding node 0
    [302.836911] Scaffolding node 10000
    [302.880698] Scaffolding node 20000
    [302.915993]  === Nodes Scaffolded in 0.272045 s
    [303.035863] Preparing to correct graph with cutoff 0.200000
    [303.767062] Cleaning memory
    [303.767088] Deactivating local correction settings
    [303.768377] Pebble done.
    [303.768398] Starting pebble resolution...
    [303.784343] Computing read to node mapping array sizes
    [304.736019] Computing read to node mappings
    [311.047488] Estimating library insert lengths...
    [311.067245] Done
    [311.067377] Computing direct node to node mappings
    [311.096311] Scaffolding node -20000
    [311.111576] Scaffolding node -40000
    [311.137828] Scaffolding node 30000
    [311.166405] Scaffolding node -30000
    [311.168400] Scaffolding node -10000
    [311.217905] Scaffolding node 10000
    [311.241233] Scaffolding node 40000
    [311.250713] Scaffolding node 0
    [311.271942] Scaffolding node 20000
    [311.318303]  === Nodes Scaffolded in 0.250913 s
    [311.441840] Preparing to correct graph with cutoff 0.200000
    [312.170634] Cleaning memory
    [312.170658] Deactivating local correction settings
    [312.172099] Pebble done.
    [312.172119] Concatenation...
    [312.180189] Renumbering nodes
    [312.180212] Initial node count 44486
    [312.180457] Removed 0 null nodes
    [312.182064] Concatenation over!
    [312.182084] Removing reference contigs with coverage < 0.885965...
    [312.186289] Concatenation...
    [312.195975] Renumbering nodes
    [312.196006] Initial node count 44486
    [312.196219] Removed 0 null nodes
    [312.197821] Concatenation over!
    [312.212567] Writing contigs into results/velvet57/contigs.fa...
    [312.253774] Writing into stats file results/velvet57/stats.txt...
    [313.094366] Writing into graph file results/velvet57/LastGraph...
    [348.010410] Estimated Coverage = 1.771930
    [348.010425] Estimated Coverage cutoff = 0.885965
    Final graph has 44486 nodes and n50 of 50, max 189, total 841573, using 9812/2166876 reads
    (bioriyaz) 




```bash
#compute subsequences of a given k-mer (31) size
velveth results/velvet135 135 -fastq -separate -shortPaired $READ1 $READ2

#assemble the genome from these precomputed data
velvetg results/velvet135 -exp_cov auto -ins_length 224
```

    (bioriyaz) [0.000000] Reading FastQ file all_data/reads_data/ERR5494176_1.fastq;
    [0.000054] Reading FastQ file all_data/reads_data/ERR5494176_2.fastq;
    [16.027191] 2166876 sequences found in total in the paired sequence files
    [16.027216] Done
    [16.161592] Reading read set file results/velvet135/Sequences;
    [17.163387] 2166876 sequences found
    [22.076017] Done
    [22.076046] 2166876 sequences in total.
    [22.076157] Writing into roadmap file results/velvet135/Roadmaps...
    [28.454723] Inputting sequences...
    [28.467960] Inputting sequence 0 / 2166876
    [44.917390] Inputting sequence 2000000 / 2166876
    [47.564736] Inputting sequence 1000000 / 2166876
    [51.576080]  === Sequences loaded in 23.121372 s
    [51.579741] Done inputting sequences
    [51.579769] Destroying splay table
    [51.621912] Splay table destroyed
    (bioriyaz) (bioriyaz) (bioriyaz) [0.000000] Reading roadmap file results/velvet135/Roadmaps
    [6.439975] 2166876 roadmaps read
    [6.442556] Creating insertion markers
    [6.858262] Ordering insertion markers
    [8.227047] Counting preNodes
    [8.536548] 155092 preNodes counted, creating them now
    [17.182465] Sequence 1000000 / 2166876
    [25.738958] Sequence 2000000 / 2166876
    [27.109036] Adjusting marker info...
    [27.427007] Connecting preNodes
    [29.388550] Connecting 2000000 / 2166876
    [30.094386] Connecting 1000000 / 2166876
    [30.360626] Cleaning up memory
    [30.373059] Done creating preGraph
    [30.373091] Concatenation...
    [30.505630] Renumbering preNodes
    [30.505653] Initial preNode count 155092
    [30.526701] Destroyed 80260 preNodes
    [30.526739] Concatenation over!
    [30.526744] Clipping short tips off preGraph
    [30.587029] Concatenation...
    [30.602522] Renumbering preNodes
    [30.602557] Initial preNode count 74832
    [30.611358] Destroyed 73521 preNodes
    [30.611389] Concatenation over!
    [30.611394] 56734 tips cut off
    [30.611406] 1311 nodes left
    [30.611505] Writing into pregraph file results/velvet135/PreGraph...
    [30.645013] Reading read set file results/velvet135/Sequences;
    [31.529724] 2166876 sequences found
    [35.858781] Done
    [41.882523] Reading pre-graph file results/velvet135/PreGraph
    [41.882611] Graph has 1311 nodes and 2166876 sequences
    [41.896418] Scanning pre-graph file results/velvet135/PreGraph for k-mers
    [41.916054] 44635 kmers found
    [41.938843] Sorting kmer occurence table ... 
    [41.971564] Sorting done.
    [41.971601] Computing acceleration table... 
    [41.982921] Computing offsets... 
    [41.997912] Ghost Threading through reads 0 / 2166876
    [46.944877] Ghost Threading through reads 2000000 / 2166876
    [47.669835] Ghost Threading through reads 1000000 / 2166876
    [49.271933]  === Ghost-Threaded in 7.287977 s
    [49.274727] Threading through reads 0 / 2166876
    [54.854594] Threading through reads 2000000 / 2166876
    [56.053239] Threading through reads 1000000 / 2166876
    [57.208649]  === Threaded in 7.936693 s
    [57.570621] Correcting graph with cutoff 0.200000
    [57.570737] Determining eligible starting points
    [57.572403] Done listing starting nodes
    [57.572430] Initializing todo lists
    [57.572685] Done with initilization
    [57.572694] Activating arc lookup table
    [57.572839] Done activating arc lookup table
    [57.574184] Concatenation...
    [57.574284] Renumbering nodes
    [57.574296] Initial node count 1311
    [57.574315] Removed 0 null nodes
    [57.574323] Concatenation over!
    [57.574331] Clipping short tips off graph, drastic
    [57.575714] Concatenation...
    [57.637319] Renumbering nodes
    [57.637347] Initial node count 1311
    [57.637379] Removed 1213 null nodes
    [57.637388] Concatenation over!
    [57.637394] 98 nodes left
    [57.637519] Writing into graph file results/velvet135/Graph2...
    [58.193206] Measuring median coverage depth...
    [58.193255] Median coverage depth = 681.939227
    [58.193305] Removing contigs with coverage < 340.969613...
    [58.194105] Concatenation...
    [58.258591] Renumbering nodes
    [58.258627] Initial node count 98
    [58.258636] Removed 80 null nodes
    [58.258645] Concatenation over!
    [58.258651] Concatenation...
    [58.258657] Renumbering nodes
    [58.258666] Initial node count 18
    [58.258671] Removed 0 null nodes
    [58.258675] Concatenation over!
    [58.258680] Clipping short tips off graph, drastic
    [58.258687] Concatenation...
    [58.258692] Renumbering nodes
    [58.258696] Initial node count 18
    [58.258700] Removed 0 null nodes
    [58.258704] Concatenation over!
    [58.258708] 18 nodes left
    [58.258712] Read coherency...
    [58.258716] Identifying unique nodes
    [58.258721] Done, 16 unique nodes counted
    [58.258725] Trimming read tips
    [58.258731] Renumbering nodes
    [58.258734] Initial node count 18
    [58.258739] Removed 0 null nodes
    [58.258743] Confronted to 0 multiple hits and 0 null over 0
    [58.258748] Read coherency over!
    [58.298791] Starting pebble resolution...
    [58.323965] Computing read to node mapping array sizes
    [58.427004] Computing read to node mappings
    [58.553613] Estimating library insert lengths...
    [58.593328] Done
    [58.593354] Computing direct node to node mappings
    [58.750693] Scaffolding node 0
    [58.763087]  === Nodes Scaffolded in 0.169718 s
    [58.783928] Preparing to correct graph with cutoff 0.200000
    [58.785694] Cleaning memory
    [58.785727] Deactivating local correction settings
    [58.785763] Pebble done.
    [58.785769] Starting pebble resolution...
    [58.803590] Computing read to node mapping array sizes
    [58.873363] Computing read to node mappings
    [58.940424] Estimating library insert lengths...
    [58.969184] Done
    [58.969222] Computing direct node to node mappings
    [59.091478] Scaffolding node 0
    [59.091771]  === Nodes Scaffolded in 0.122519 s
    [59.115739] Preparing to correct graph with cutoff 0.200000
    [59.115958] Cleaning memory
    [59.116117] Deactivating local correction settings
    [59.116149] Pebble done.
    [59.116165] Concatenation...
    [59.116182] Renumbering nodes
    [59.116197] Initial node count 18
    [59.116213] Removed 2 null nodes
    [59.116227] Concatenation over!
    [59.116242] Removing reference contigs with coverage < 340.969613...
    [59.117969] Concatenation...
    [59.117990] Renumbering nodes
    [59.118008] Initial node count 16
    [59.118025] Removed 0 null nodes
    [59.118045] Concatenation over!
    [59.147940] Writing contigs into results/velvet135/contigs.fa...
    [59.739877] Writing into stats file results/velvet135/stats.txt...
    [59.747465] Writing into graph file results/velvet135/LastGraph...
    [60.419861] Estimated Coverage = 681.939227
    [60.419886] Estimated Coverage cutoff = 340.969613
    Final graph has 16 nodes and n50 of 2407, max 5938, total 21306, using 1051556/2166876 reads
    (bioriyaz) 




```bash
#check velvet result
seqkit stat results/velvet135/velvet135.contigs.fa
```

    (bioriyaz) file                                    format  type  num_seqs  sum_len  min_len  avg_len  max_len
    results/velvet135/velvet135.contigs.fa  FASTA   DNA         15   23,315      279  1,554.3    6,072
    (bioriyaz) 



## Assembly with SPAdes assembly


```bash
spades.py -1 $READ1 -2 $READ2 -o results/spades
```

    Command line: /home/arriyaz/miniconda3/envs/bioriyaz/bin/spades.py	-1	/home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_1.fastq	-2	/home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_2.fastq	-o	/home/arriyaz/Desktop/genome_assembly/results/spades	
    
    System information:
      SPAdes version: 3.13.0
      Python version: 3.6.10
      OS: Linux-5.4.0-70-generic-x86_64-with-debian-bullseye-sid
    
    Output dir: /home/arriyaz/Desktop/genome_assembly/results/spades
    Mode: read error correction and assembling
    Debug mode is turned OFF
    
    Dataset parameters:
      Multi-cell mode (you should set '--sc' flag if input data was obtained with MDA (single-cell) technology or --meta flag if processing metagenomic dataset)
      Reads:
        Library number: 1, library type: paired-end
          orientation: fr
          left reads: ['/home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_1.fastq']
          right reads: ['/home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_2.fastq']
          interlaced reads: not specified
          single reads: not specified
          merged reads: not specified
    Read error correction parameters:
      Iterations: 1
      PHRED offset will be auto-detected
      Corrected reads will be compressed
    Assembly parameters:
      k: automatic selection based on read length
      Repeat resolution is enabled
      Mismatch careful mode is turned OFF
      MismatchCorrector will be SKIPPED
      Coverage cutoff is turned OFF
    Other parameters:
      Dir for temp files: /home/arriyaz/Desktop/genome_assembly/results/spades/tmp
      Threads: 16
      Memory limit (in Gb): 7
    
    
    ======= SPAdes pipeline started. Log can be found here: /home/arriyaz/Desktop/genome_assembly/results/spades/spades.log
    
    
    ===== Read error correction started. 
    
    
    == Running read error correction tool: /home/arriyaz/miniconda3/envs/bioriyaz/share/spades-3.13.0-0/bin/spades-hammer /home/arriyaz/Desktop/genome_assembly/results/spades/corrected/configs/config.info
    
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  75)   Starting BayesHammer, built from refs/heads/spades_3.13.0, git revision 8ea46659e9b2aca35444a808db550ac333006f8b
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  76)   Loading config from /home/arriyaz/Desktop/genome_assembly/results/spades/corrected/configs/config.info
      0:00:00.002     4M / 4M    INFO    General                 (main.cpp                  :  78)   Maximum # of threads to use (adjusted due to OMP capabilities): 4
      0:00:00.002     4M / 4M    INFO    General                 (memory_limit.cpp          :  49)   Memory limit set to 7 Gb
      0:00:00.002     4M / 4M    INFO    General                 (main.cpp                  :  86)   Trying to determine PHRED offset
      0:00:00.004     4M / 4M    INFO    General                 (main.cpp                  :  92)   Determined value is 33
      0:00:00.004     4M / 4M    INFO    General                 (hammer_tools.cpp          :  36)   Hamming graph threshold tau=1, k=21, subkmer positions = [ 0 10 ]
      0:00:00.004     4M / 4M    INFO    General                 (main.cpp                  : 113)   Size of aux. kmer data 24 bytes
         === ITERATION 0 begins ===
      0:00:00.005     4M / 4M    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:00:00.005     4M / 4M    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 64 files using 4 threads. This might take a while.
      0:00:00.005     4M / 4M    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:00:00.005     4M / 4M    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.583008 Gb
      0:00:00.005     4M / 4M    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 1048576
      0:00:00.005     3G / 3G    INFO   K-mer Splitting          (kmer_data.cpp             :  97)   Processing /home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_1.fastq
      0:00:20.948     3G / 3G    INFO   K-mer Splitting          (kmer_data.cpp             : 107)   Processed 797088 reads
      0:00:27.485     3G / 3G    INFO   K-mer Splitting          (kmer_data.cpp             : 107)   Processed 1083438 reads
      0:00:27.486     3G / 3G    INFO   K-mer Splitting          (kmer_data.cpp             :  97)   Processing /home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_2.fastq
      0:00:46.555     3G / 3G    INFO   K-mer Splitting          (kmer_data.cpp             : 107)   Processed 1879217 reads
      0:00:54.251     3G / 3G    INFO   K-mer Splitting          (kmer_data.cpp             : 107)   Processed 2166876 reads
      0:00:54.251     3G / 3G    INFO   K-mer Splitting          (kmer_data.cpp             : 112)   Total 2166876 reads processed
      0:00:54.415    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:00:55.227    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 9096458 kmers in total.
      0:00:55.227    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:00:55.367    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:00:57.139    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 150)   Merging final buckets.
      0:00:59.236    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 4226360 bytes occupied (3.71693 bits per kmer).
      0:00:59.237    16M / 3G    INFO   K-mer Counting           (kmer_data.cpp             : 356)   Arranging kmers in hash map order
      0:01:00.423   160M / 3G    INFO    General                 (main.cpp                  : 148)   Clustering Hamming graph.
      0:01:45.271   160M / 3G    INFO    General                 (main.cpp                  : 155)   Extracting clusters
      0:01:48.801   160M / 3G    INFO    General                 (main.cpp                  : 167)   Clustering done. Total clusters: 3650652
      0:01:48.806    88M / 3G    INFO   K-mer Counting           (kmer_data.cpp             : 376)   Collecting K-mer information, this takes a while.
      0:01:48.908   300M / 3G    INFO   K-mer Counting           (kmer_data.cpp             : 382)   Processing /home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_1.fastq
      0:03:55.792   300M / 3G    INFO   K-mer Counting           (kmer_data.cpp             : 382)   Processing /home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_2.fastq
      0:06:03.725   300M / 3G    INFO   K-mer Counting           (kmer_data.cpp             : 389)   Collection done, postprocessing.
      0:06:03.852   300M / 3G    INFO   K-mer Counting           (kmer_data.cpp             : 403)   There are 9096458 kmers in total. Among them 6426700 (70.6506%) are singletons.
      0:06:03.852   300M / 3G    INFO    General                 (main.cpp                  : 173)   Subclustering Hamming graph
      0:06:53.315   300M / 3G    INFO   Hamming Subclustering    (kmer_cluster.cpp          : 649)   Subclustering done. Total 133 non-read kmers were generated.
      0:06:53.315   300M / 3G    INFO   Hamming Subclustering    (kmer_cluster.cpp          : 650)   Subclustering statistics:
      0:06:53.315   300M / 3G    INFO   Hamming Subclustering    (kmer_cluster.cpp          : 651)     Total singleton hamming clusters: 3460482. Among them 150434 (4.3472%) are good
      0:06:53.315   300M / 3G    INFO   Hamming Subclustering    (kmer_cluster.cpp          : 652)     Total singleton subclusters: 3592. Among them 3544 (98.6637%) are good
      0:06:53.315   300M / 3G    INFO   Hamming Subclustering    (kmer_cluster.cpp          : 653)     Total non-singleton subcluster centers: 236876. Among them 131734 (55.6131%) are good
      0:06:53.315   300M / 3G    INFO   Hamming Subclustering    (kmer_cluster.cpp          : 654)     Average size of non-trivial subcluster: 23.795 kmers
      0:06:53.315   300M / 3G    INFO   Hamming Subclustering    (kmer_cluster.cpp          : 655)     Average number of sub-clusters per non-singleton cluster: 1.26449
      0:06:53.315   300M / 3G    INFO   Hamming Subclustering    (kmer_cluster.cpp          : 656)     Total solid k-mers: 285712
      0:06:53.315   300M / 3G    INFO   Hamming Subclustering    (kmer_cluster.cpp          : 657)     Substitution probabilities: [4,4]((0.9324,0.019065,0.0155349,0.0330005),(0.0435591,0.916091,0.0283464,0.0120037),(0.0114911,0.027686,0.916133,0.0446899),(0.0322596,0.0152505,0.0185568,0.933933))
      0:06:53.324   300M / 3G    INFO    General                 (main.cpp                  : 178)   Finished clustering.
      0:06:53.325   300M / 3G    INFO    General                 (main.cpp                  : 197)   Starting solid k-mers expansion in 4 threads.
      0:07:49.722   300M / 3G    INFO    General                 (main.cpp                  : 218)   Solid k-mers iteration 0 produced 420187 new k-mers.
      0:08:42.524   300M / 3G    INFO    General                 (main.cpp                  : 218)   Solid k-mers iteration 1 produced 104919 new k-mers.
      0:09:36.161   300M / 3G    INFO    General                 (main.cpp                  : 218)   Solid k-mers iteration 2 produced 2580 new k-mers.
      0:10:28.928   300M / 3G    INFO    General                 (main.cpp                  : 218)   Solid k-mers iteration 3 produced 82 new k-mers.
      0:11:22.180   300M / 3G    INFO    General                 (main.cpp                  : 218)   Solid k-mers iteration 4 produced 0 new k-mers.
      0:11:22.180   300M / 3G    INFO    General                 (main.cpp                  : 222)   Solid k-mers finalized
      0:11:22.180   300M / 3G    INFO    General                 (hammer_tools.cpp          : 220)   Starting read correction in 4 threads.
      0:11:22.180   300M / 3G    INFO    General                 (hammer_tools.cpp          : 233)   Correcting pair of reads: /home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_1.fastq and /home/arriyaz/Desktop/genome_assembly/all_data/reads_data/ERR5494176_2.fastq
      0:11:25.277   652M / 3G    INFO    General                 (hammer_tools.cpp          : 168)   Prepared batch 0 of 400000 reads.
      0:12:09.880   696M / 3G    INFO    General                 (hammer_tools.cpp          : 175)   Processed batch 0
      0:12:10.860   696M / 3G    INFO    General                 (hammer_tools.cpp          : 185)   Written batch 0
      0:12:12.756   808M / 3G    INFO    General                 (hammer_tools.cpp          : 168)   Prepared batch 1 of 400000 reads.
      0:13:05.032   804M / 3G    INFO    General                 (hammer_tools.cpp          : 175)   Processed batch 1
      0:13:06.164   804M / 3G    INFO    General                 (hammer_tools.cpp          : 185)   Written batch 1
      0:13:07.491   828M / 3G    INFO    General                 (hammer_tools.cpp          : 168)   Prepared batch 2 of 283438 reads.
      0:13:35.803   828M / 3G    INFO    General                 (hammer_tools.cpp          : 175)   Processed batch 2
      0:13:37.597   828M / 3G    INFO    General                 (hammer_tools.cpp          : 185)   Written batch 2
      0:13:37.900   300M / 3G    INFO    General                 (hammer_tools.cpp          : 274)   Correction done. Changed 454674 bases in 186640 reads.
      0:13:37.900   300M / 3G    INFO    General                 (hammer_tools.cpp          : 275)   Failed to correct 22 bases out of 292909700.
      0:13:37.926    16M / 3G    INFO    General                 (main.cpp                  : 255)   Saving corrected dataset description to /home/arriyaz/Desktop/genome_assembly/results/spades/corrected/corrected.yaml
      0:13:37.926    16M / 3G    INFO    General                 (main.cpp                  : 262)   All done. Exiting.
    
    == Compressing corrected reads (with pigz)
    
    == Dataset description file was created: /home/arriyaz/Desktop/genome_assembly/results/spades/corrected/corrected.yaml
    
    
    ===== Read error correction finished. 
    
    
    ===== Assembling started.
    
    
    == Running assembler: K21
    
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  74)   Loaded config from /home/arriyaz/Desktop/genome_assembly/results/spades/K21/configs/config.info
      0:00:00.003     4M / 4M    INFO    General                 (memory_limit.cpp          :  49)   Memory limit set to 7 Gb
      0:00:00.004     4M / 4M    INFO    General                 (main.cpp                  :  87)   Starting SPAdes, built from refs/heads/spades_3.13.0, git revision 8ea46659e9b2aca35444a808db550ac333006f8b
      0:00:00.006     4M / 4M    INFO    General                 (main.cpp                  :  88)   Maximum k-mer length: 128
      0:00:00.006     4M / 4M    INFO    General                 (main.cpp                  :  89)   Assembling dataset (/home/arriyaz/Desktop/genome_assembly/results/spades/dataset.info) with K=21
      0:00:00.006     4M / 4M    INFO    General                 (main.cpp                  :  90)   Maximum # of threads to use (adjusted due to OMP capabilities): 4
      0:00:00.006     4M / 4M    INFO    General                 (launch.hpp                :  51)   SPAdes started
      0:00:00.006     4M / 4M    INFO    General                 (launch.hpp                :  58)   Starting from stage: construction
      0:00:00.006     4M / 4M    INFO    General                 (launch.hpp                :  65)   Two-step RR enabled: 0
      0:00:00.016     4M / 4M    INFO   StageManager             (stage.cpp                 : 132)   STAGE == de Bruijn graph construction
      0:00:00.018     4M / 4M    INFO    General                 (read_converter.hpp        :  77)   Converting reads to binary format for library #0 (takes a while)
      0:00:00.018     4M / 4M    INFO    General                 (read_converter.hpp        :  78)   Converting paired reads
      0:00:01.065    80M / 84M   INFO    General                 (binary_converter.hpp      :  93)   16384 reads processed
      0:00:01.826    92M / 92M   INFO    General                 (binary_converter.hpp      :  93)   32768 reads processed
      0:00:02.548   120M / 120M  INFO    General                 (binary_converter.hpp      :  93)   65536 reads processed
      0:00:03.266   172M / 172M  INFO    General                 (binary_converter.hpp      :  93)   131072 reads processed
      0:00:04.696   284M / 284M  INFO    General                 (binary_converter.hpp      :  93)   262144 reads processed
      0:00:07.661   504M / 504M  INFO    General                 (binary_converter.hpp      :  93)   524288 reads processed
      0:00:16.599   848M / 848M  INFO    General                 (binary_converter.hpp      :  93)   1048576 reads processed
      0:00:18.014   192M / 848M  INFO    General                 (binary_converter.hpp      : 117)   1078626 reads written
      0:00:18.134     4M / 848M  INFO    General                 (read_converter.hpp        :  87)   Converting single reads
      0:00:18.300   132M / 848M  INFO    General                 (binary_converter.hpp      : 117)   1853 reads written
      0:00:18.309     4M / 848M  INFO    General                 (read_converter.hpp        :  95)   Converting merged reads
      0:00:18.461   132M / 848M  INFO    General                 (binary_converter.hpp      : 117)   0 reads written
      0:00:18.471     4M / 848M  INFO    General                 (construction.cpp          : 111)   Max read length 151
      0:00:18.471     4M / 848M  INFO    General                 (construction.cpp          : 117)   Average read length 135.523
      0:00:18.471     4M / 848M  INFO    General                 (stage.cpp                 : 101)   PROCEDURE == k+1-mer counting
      0:00:18.472     4M / 848M  INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 16 files using 4 threads. This might take a while.
      0:00:18.473     4M / 848M  INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:00:18.473     4M / 848M  INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.583008 Gb
      0:00:18.473     4M / 848M  INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 4194304
      0:00:42.332     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 289)   Processed 4318210 reads
      0:00:42.332     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 295)   Adding contigs from previous K
      0:00:42.510    16M / 2G    INFO    General                 (kmer_splitters.hpp        : 308)   Used 4318210 reads
      0:00:42.510    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:00:42.620    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 2013408 kmers in total.
      0:00:42.620    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:00:42.661    16M / 2G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Extension index construction
      0:00:42.661    16M / 2G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:00:42.661    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 64 files using 4 threads. This might take a while.
      0:00:42.661    16M / 2G    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:00:42.661    16M / 2G    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.582031 Gb
      0:00:42.661    16M / 2G    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 1048576
      0:00:43.527     3G / 3G    INFO    General                 (kmer_splitters.hpp        : 380)   Processed 2013408 kmers
      0:00:43.527     3G / 3G    INFO    General                 (kmer_splitters.hpp        : 385)   Used 2013408 kmers.
      0:00:43.535    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:00:43.658    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 1953182 kmers in total.
      0:00:43.658    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:00:43.704    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:00:44.263    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 150)   Merging final buckets.
      0:00:44.326    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 914088 bytes occupied (3.744 bits per kmer).
      0:00:44.331    16M / 3G    INFO   DeBruijnExtensionIndexBu (kmer_extension_index_build:  99)   Building k-mer extensions from k+1-mers
      0:00:45.147    16M / 3G    INFO   DeBruijnExtensionIndexBu (kmer_extension_index_build: 103)   Building k-mer extensions from k+1-mers finished.
      0:00:45.147    16M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Early tip clipping
      0:00:45.147    16M / 3G    INFO    General                 (construction.cpp          : 253)   Early tip clipper length bound set as (RL - K)
      0:00:45.147    16M / 3G    INFO   Early tip clipping       (early_simplification.hpp  : 181)   Early tip clipping
      0:00:47.079    16M / 3G    INFO   Early tip clipping       (early_simplification.hpp  : 184)   640127 22-mers were removed by early tip clipper
      0:00:47.079    16M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Condensing graph
      0:00:47.093    16M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 355)   Extracting unbranching paths
      0:00:48.076    24M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 374)   Extracting unbranching paths finished. 147015 sequences extracted
      0:00:48.550    24M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 310)   Collecting perfect loops
      0:00:48.809    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 343)   Collecting perfect loops finished. 1 loops collected
      0:00:49.062    48M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Filling coverage indices (PHM)
      0:00:49.062    48M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:00:49.062    48M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:00:49.521    60M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 935704 bytes occupied (3.71789 bits per kmer).
      0:00:49.528    68M / 3G    INFO    General                 (construction.cpp          : 388)   Collecting k-mer coverage information from reads, this takes a while.
      0:01:27.895    68M / 3G    INFO    General                 (construction.cpp          : 508)   Filling coverage and flanking coverage from PHM
      0:01:28.427    68M / 3G    INFO    General                 (construction.cpp          : 464)   Processed 294004 edges
      0:01:28.451    52M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == EC Threshold Finding
      0:01:28.463    56M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 181)   Kmer coverage valley at: 52
      0:01:28.463    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 201)   K-mer histogram maximum: 53
      0:01:28.463    52M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 218)   Too many erroneous kmers, the estimates might be unreliable
      0:01:28.463    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 237)   Estimated median coverage: 53. Coverage mad: 24.135
      0:01:28.464    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 259)   Fitting coverage model
      0:01:28.585    56M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 2
      0:01:28.919    56M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 4
      0:01:29.773    56M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 8
      0:01:31.388    56M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 16
      0:01:35.365    48M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 309)   Fitted mean coverage: 10.6612. Fitted coverage std. dev: 5.78813
      0:01:35.365    48M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 327)   Valley value was estimated improperly, reset to 1
      0:01:35.368    48M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 334)   Probability of erroneous kmer at valley: 1
      0:01:35.368    48M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 1
      0:01:35.368    48M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 375)   Estimated genome size (ignoring repeats): 1983498
      0:01:35.368    44M / 3G    INFO    General                 (genomic_info_filler.cpp   : 114)   Failed to estimate mean coverage
      0:01:35.368    44M / 3G    INFO    General                 (genomic_info_filler.cpp   : 127)   EC coverage threshold value was calculated as 1
      0:01:35.368    44M / 3G    INFO    General                 (genomic_info_filler.cpp   : 128)   Trusted kmer low bound: 0
      0:01:35.368    44M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Raw Simplification
      0:01:35.372    44M / 3G    INFO    General                 (simplification.cpp        : 128)   PROCEDURE == InitialCleaning
      0:01:35.373    44M / 3G    INFO    General                 (simplification.cpp        :  68)   Most init cleaning disabled since detected mean 0 was less than activation coverage 10
      0:01:35.373    44M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Self conjugate edge remover
      0:01:35.422    44M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Self conjugate edge remover triggered 0 times
      0:01:35.423    44M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Simplification
      0:01:35.423    44M / 3G    INFO    General                 (simplification.cpp        : 357)   Graph simplification started
      0:01:35.423    44M / 3G    INFO    General                 (graph_simplification.hpp  : 634)   Creating parallel br instance
      0:01:35.423    44M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 1
      0:01:35.424    44M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:35.516    44M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 2215 times
      0:01:35.516    44M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.276    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 10538 times
      0:01:53.276    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:53.434    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:53.434    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 2
      0:01:53.434    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:53.484    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 76 times
      0:01:53.484    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.493    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 3 times
      0:01:53.494    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:53.495    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:53.495    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 3
      0:01:53.496    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:53.497    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:53.497    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.498    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:53.498    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:53.499    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:53.499    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 4
      0:01:53.499    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:53.499    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:53.499    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.499    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:53.499    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:53.499    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:53.499    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 5
      0:01:53.499    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:53.499    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:53.500    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.500    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:53.500    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:53.500    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:53.500    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 6
      0:01:53.500    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:53.500    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:53.500    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.500    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:53.506    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 7
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:53.506    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 8
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:53.506    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 9
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:53.506    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:53.507    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:53.507    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 10
      0:01:53.507    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:53.507    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:53.507    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:53.507    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:53.507    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:54.214    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 19556 times
      0:01:54.214    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 11
      0:01:54.214    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:54.253    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 615 times
      0:01:54.253    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:01.139    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 5721 times
      0:02:01.139    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:01.167    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:01.168    48M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 12
      0:02:01.168    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:01.180    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 10 times
      0:02:01.180    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 1 times
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:01.188    48M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 13
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:01.188    48M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Simplification Cleanup
      0:02:01.188    48M / 3G    INFO    General                 (simplification.cpp        : 196)   PROCEDURE == Post simplification
      0:02:01.188    48M / 3G    INFO    General                 (graph_simplification.hpp  : 453)   Disconnection of relatively low covered edges disabled
      0:02:01.188    48M / 3G    INFO    General                 (graph_simplification.hpp  : 489)   Complex tip clipping disabled
      0:02:01.188    48M / 3G    INFO    General                 (graph_simplification.hpp  : 634)   Creating parallel br instance
      0:02:01.188    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:01.214    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:01.214    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:03.802    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 7 times
      0:02:03.802    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:03.823    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:03.823    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:06.748    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 1 times
      0:02:06.748    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:06.748    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:06.748    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:06.748    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:06.748    48M / 3G    INFO    General                 (simplification.cpp        : 330)   Disrupting self-conjugate edges
      0:02:06.826    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Removing isolated edges
      0:02:06.844    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Removing isolated edges triggered 91 times
      0:02:06.844    48M / 3G    INFO    General                 (simplification.cpp        : 470)   Counting average coverage
      0:02:06.874    48M / 3G    INFO    General                 (simplification.cpp        : 476)   Average coverage = 451.846
      0:02:06.874    48M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Contig Output
      0:02:06.875    48M / 3G    INFO    General                 (contig_output_stage.cpp   :  40)   Writing GFA to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/assembly_graph_with_scaffolds.gfa
      0:02:07.087    48M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/before_rr.fasta
      0:02:07.496    48M / 3G    INFO    General                 (contig_output_stage.cpp   :  51)   Outputting FastG graph to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/assembly_graph.fastg
      0:02:08.349    48M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/simplified_contigs.fasta
      0:02:08.757    48M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/final_contigs.fasta
      0:02:09.212    48M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Contig Output
      0:02:09.212    48M / 3G    INFO    General                 (contig_output_stage.cpp   :  40)   Writing GFA to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/assembly_graph_with_scaffolds.gfa
      0:02:09.514    48M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/before_rr.fasta
      0:02:09.950    48M / 3G    INFO    General                 (contig_output_stage.cpp   :  51)   Outputting FastG graph to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/assembly_graph.fastg
      0:02:10.888    48M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/simplified_contigs.fasta
      0:02:11.300    48M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K21/final_contigs.fasta
      0:02:11.703    48M / 3G    INFO    General                 (launch.hpp                : 149)   SPAdes finished
      0:02:11.825    16M / 3G    INFO    General                 (main.cpp                  : 109)   Assembling time: 0 hours 2 minutes 11 seconds
    Max read length detected as 151
    Default k-mer sizes were set to [21, 33, 55, 77] because estimated read length (151) is equal to or greater than 150
    
    == Running assembler: K33
    
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  74)   Loaded config from /home/arriyaz/Desktop/genome_assembly/results/spades/K33/configs/config.info
      0:00:00.000     4M / 4M    INFO    General                 (memory_limit.cpp          :  49)   Memory limit set to 7 Gb
      0:00:00.001     4M / 4M    INFO    General                 (main.cpp                  :  87)   Starting SPAdes, built from refs/heads/spades_3.13.0, git revision 8ea46659e9b2aca35444a808db550ac333006f8b
      0:00:00.001     4M / 4M    INFO    General                 (main.cpp                  :  88)   Maximum k-mer length: 128
      0:00:00.001     4M / 4M    INFO    General                 (main.cpp                  :  89)   Assembling dataset (/home/arriyaz/Desktop/genome_assembly/results/spades/dataset.info) with K=33
      0:00:00.002     4M / 4M    INFO    General                 (main.cpp                  :  90)   Maximum # of threads to use (adjusted due to OMP capabilities): 4
      0:00:00.002     4M / 4M    INFO    General                 (launch.hpp                :  51)   SPAdes started
      0:00:00.002     4M / 4M    INFO    General                 (launch.hpp                :  58)   Starting from stage: construction
      0:00:00.002     4M / 4M    INFO    General                 (launch.hpp                :  65)   Two-step RR enabled: 0
      0:00:00.003     4M / 4M    INFO   StageManager             (stage.cpp                 : 132)   STAGE == de Bruijn graph construction
      0:00:00.003     4M / 4M    INFO    General                 (read_converter.hpp        :  59)   Binary reads detected
      0:00:00.004     4M / 4M    INFO    General                 (construction.cpp          : 111)   Max read length 151
      0:00:00.004     4M / 4M    INFO    General                 (construction.cpp          : 117)   Average read length 135.523
      0:00:00.004     4M / 4M    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == k+1-mer counting
      0:00:00.005     4M / 4M    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 16 files using 4 threads. This might take a while.
      0:00:00.005     4M / 4M    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:00:00.005     4M / 4M    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.583008 Gb
      0:00:00.005     4M / 4M    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 2097152
      0:00:13.376     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 289)   Processed 2485661 reads
      0:00:23.618     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 289)   Processed 4318210 reads
      0:00:23.618     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 295)   Adding contigs from previous K
      0:00:24.175    16M / 2G    INFO    General                 (kmer_splitters.hpp        : 308)   Used 4318210 reads
      0:00:24.175    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:00:24.437    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 2663087 kmers in total.
      0:00:24.437    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:00:24.516    16M / 2G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Extension index construction
      0:00:24.516    16M / 2G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:00:24.516    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 64 files using 4 threads. This might take a while.
      0:00:24.516    16M / 2G    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:00:24.516    16M / 2G    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.582031 Gb
      0:00:24.516    16M / 2G    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 524288
      0:00:25.828     3G / 3G    INFO    General                 (kmer_splitters.hpp        : 380)   Processed 2663087 kmers
      0:00:25.828     3G / 3G    INFO    General                 (kmer_splitters.hpp        : 385)   Used 2663087 kmers.
      0:00:25.844    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:00:26.099    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 2612792 kmers in total.
      0:00:26.099    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:00:26.191    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:00:26.788    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 150)   Merging final buckets.
      0:00:30.689    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 1219968 bytes occupied (3.73537 bits per kmer).
      0:00:30.694    16M / 3G    INFO   DeBruijnExtensionIndexBu (kmer_extension_index_build:  99)   Building k-mer extensions from k+1-mers
      0:00:31.985    16M / 3G    INFO   DeBruijnExtensionIndexBu (kmer_extension_index_build: 103)   Building k-mer extensions from k+1-mers finished.
      0:00:31.986    16M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Early tip clipping
      0:00:31.986    16M / 3G    INFO    General                 (construction.cpp          : 253)   Early tip clipper length bound set as (RL - K)
      0:00:31.986    16M / 3G    INFO   Early tip clipping       (early_simplification.hpp  : 181)   Early tip clipping
      0:00:34.633    20M / 3G    INFO   Early tip clipping       (early_simplification.hpp  : 184)   1021834 34-mers were removed by early tip clipper
      0:00:34.633    20M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Condensing graph
      0:00:34.664    20M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 355)   Extracting unbranching paths
      0:00:36.035    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 374)   Extracting unbranching paths finished. 136114 sequences extracted
      0:00:36.639    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 310)   Collecting perfect loops
      0:00:36.978    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 343)   Collecting perfect loops finished. 1 loops collected
      0:00:37.258    56M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Filling coverage indices (PHM)
      0:00:37.258    56M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:00:37.258    56M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:00:37.852    56M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 1236864 bytes occupied (3.71558 bits per kmer).
      0:00:37.867    68M / 3G    INFO    General                 (construction.cpp          : 388)   Collecting k-mer coverage information from reads, this takes a while.
      0:01:13.989    68M / 3G    INFO    General                 (construction.cpp          : 508)   Filling coverage and flanking coverage from PHM
      0:01:14.642    68M / 3G    INFO    General                 (construction.cpp          : 464)   Processed 272214 edges
      0:01:14.667    52M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == EC Threshold Finding
      0:01:14.674    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 181)   Kmer coverage valley at: 40
      0:01:14.675    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 201)   K-mer histogram maximum: 42
      0:01:14.675    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 237)   Estimated median coverage: 43. Coverage mad: 2.9652
      0:01:14.675    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 259)   Fitting coverage model
      0:01:14.784    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 2
      0:01:15.086    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 4
      0:01:16.094    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 8
      0:01:17.940    52M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 16
      0:01:22.236    48M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 32
      0:01:27.107    48M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 309)   Fitted mean coverage: 6.69723. Fitted coverage std. dev: 2.03779
      0:01:27.107    48M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 327)   Valley value was estimated improperly, reset to 2
      0:01:27.109    48M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 334)   Probability of erroneous kmer at valley: 1
      0:01:27.109    48M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 2
      0:01:27.109    48M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 375)   Estimated genome size (ignoring repeats): 788250
      0:01:27.109    48M / 3G    INFO    General                 (genomic_info_filler.cpp   : 114)   Failed to estimate mean coverage
      0:01:27.109    48M / 3G    INFO    General                 (genomic_info_filler.cpp   : 127)   EC coverage threshold value was calculated as 2
      0:01:27.109    48M / 3G    INFO    General                 (genomic_info_filler.cpp   : 128)   Trusted kmer low bound: 0
      0:01:27.109    48M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Raw Simplification
      0:01:27.109    48M / 3G    INFO    General                 (simplification.cpp        : 128)   PROCEDURE == InitialCleaning
      0:01:27.109    48M / 3G    INFO    General                 (simplification.cpp        :  68)   Most init cleaning disabled since detected mean 0 was less than activation coverage 10
      0:01:27.109    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Self conjugate edge remover
      0:01:27.149    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Self conjugate edge remover triggered 3 times
      0:01:27.150    48M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Simplification
      0:01:27.150    48M / 3G    INFO    General                 (simplification.cpp        : 357)   Graph simplification started
      0:01:27.150    48M / 3G    INFO    General                 (graph_simplification.hpp  : 634)   Creating parallel br instance
      0:01:27.150    48M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 1
      0:01:27.150    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:27.255    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 4116 times
      0:01:27.255    48M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:33.294    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 6902 times
      0:01:33.294    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:33.373    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 37 times
      0:01:33.373    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 2
      0:01:33.373    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:33.391    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 82 times
      0:01:33.391    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:33.478    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 8 times
      0:01:33.478    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:33.478    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:33.478    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 3
      0:01:33.478    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:33.478    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 1 times
      0:01:33.478    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:33.478    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:33.478    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:33.479    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 9 times
      0:01:33.479    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 4
      0:01:33.479    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:33.479    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 5 times
      0:01:33.479    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:33.490    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 2 times
      0:01:33.490    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:33.493    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 57 times
      0:01:33.493    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 5
      0:01:33.493    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:33.494    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 31 times
      0:01:33.494    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:33.585    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 9 times
      0:01:33.586    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:34.176    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 16536 times
      0:01:34.176    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 6
      0:01:34.176    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:34.208    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 607 times
      0:01:34.208    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:37.200    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 5487 times
      0:01:37.200    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:37.272    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 2729 times
      0:01:37.272    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 7
      0:01:37.272    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:37.281    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 44 times
      0:01:37.281    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:37.847    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 975 times
      0:01:37.847    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:37.881    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 1131 times
      0:01:37.881    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 8
      0:01:37.881    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:37.886    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 30 times
      0:01:37.886    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:38.078    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 491 times
      0:01:38.078    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:38.102    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 803 times
      0:01:38.102    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 9
      0:01:38.102    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:38.106    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 16 times
      0:01:38.106    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:38.241    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 382 times
      0:01:38.241    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:38.262    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 704 times
      0:01:38.262    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 10
      0:01:38.262    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:38.264    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 7 times
      0:01:38.264    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:38.395    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 363 times
      0:01:38.395    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:38.468    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 2761 times
      0:01:38.468    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 11
      0:01:38.468    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:38.480    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 35 times
      0:01:38.480    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:39.071    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 2136 times
      0:01:39.071    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:39.083    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:39.084    52M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 12
      0:01:39.084    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:39.088    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:39.089    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:39.089    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:39.089    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:39.089    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:39.089    52M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Simplification Cleanup
      0:01:39.089    52M / 3G    INFO    General                 (simplification.cpp        : 196)   PROCEDURE == Post simplification
      0:01:39.089    52M / 3G    INFO    General                 (graph_simplification.hpp  : 453)   Disconnection of relatively low covered edges disabled
      0:01:39.090    52M / 3G    INFO    General                 (graph_simplification.hpp  : 489)   Complex tip clipping disabled
      0:01:39.090    52M / 3G    INFO    General                 (graph_simplification.hpp  : 634)   Creating parallel br instance
      0:01:39.090    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:39.104    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:39.104    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:39.250    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:39.250    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:39.262    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:39.262    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:39.402    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:39.402    52M / 3G    INFO    General                 (simplification.cpp        : 330)   Disrupting self-conjugate edges
      0:01:39.429    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Removing isolated edges
      0:01:39.438    52M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Removing isolated edges triggered 781 times
      0:01:39.438    52M / 3G    INFO    General                 (simplification.cpp        : 470)   Counting average coverage
      0:01:39.449    52M / 3G    INFO    General                 (simplification.cpp        : 476)   Average coverage = 776.372
      0:01:39.449    52M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Contig Output
      0:01:39.449    52M / 3G    INFO    General                 (contig_output_stage.cpp   :  40)   Writing GFA to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/assembly_graph_with_scaffolds.gfa
      0:01:39.541    52M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/before_rr.fasta
      0:01:39.702    52M / 3G    INFO    General                 (contig_output_stage.cpp   :  51)   Outputting FastG graph to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/assembly_graph.fastg
      0:01:40.039    52M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/simplified_contigs.fasta
      0:01:40.200    52M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/final_contigs.fasta
      0:01:40.375    52M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Contig Output
      0:01:40.375    52M / 3G    INFO    General                 (contig_output_stage.cpp   :  40)   Writing GFA to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/assembly_graph_with_scaffolds.gfa
      0:01:40.491    52M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/before_rr.fasta
      0:01:40.671    52M / 3G    INFO    General                 (contig_output_stage.cpp   :  51)   Outputting FastG graph to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/assembly_graph.fastg
      0:01:41.013    52M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/simplified_contigs.fasta
      0:01:41.183    52M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K33/final_contigs.fasta
      0:01:41.357    52M / 3G    INFO    General                 (launch.hpp                : 149)   SPAdes finished
      0:01:41.439    16M / 3G    INFO    General                 (main.cpp                  : 109)   Assembling time: 0 hours 1 minutes 41 seconds
    
    == Running assembler: K55
    
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  74)   Loaded config from /home/arriyaz/Desktop/genome_assembly/results/spades/K55/configs/config.info
      0:00:00.000     4M / 4M    INFO    General                 (memory_limit.cpp          :  49)   Memory limit set to 7 Gb
      0:00:00.001     4M / 4M    INFO    General                 (main.cpp                  :  87)   Starting SPAdes, built from refs/heads/spades_3.13.0, git revision 8ea46659e9b2aca35444a808db550ac333006f8b
      0:00:00.001     4M / 4M    INFO    General                 (main.cpp                  :  88)   Maximum k-mer length: 128
      0:00:00.001     4M / 4M    INFO    General                 (main.cpp                  :  89)   Assembling dataset (/home/arriyaz/Desktop/genome_assembly/results/spades/dataset.info) with K=55
      0:00:00.001     4M / 4M    INFO    General                 (main.cpp                  :  90)   Maximum # of threads to use (adjusted due to OMP capabilities): 4
      0:00:00.001     4M / 4M    INFO    General                 (launch.hpp                :  51)   SPAdes started
      0:00:00.001     4M / 4M    INFO    General                 (launch.hpp                :  58)   Starting from stage: construction
      0:00:00.002     4M / 4M    INFO    General                 (launch.hpp                :  65)   Two-step RR enabled: 0
      0:00:00.002     4M / 4M    INFO    General                 (launch.hpp                :  76)   Will need read mapping, kmer mapper will be attached
      0:00:00.002     4M / 4M    INFO   StageManager             (stage.cpp                 : 132)   STAGE == de Bruijn graph construction
      0:00:00.003     4M / 4M    INFO    General                 (read_converter.hpp        :  59)   Binary reads detected
      0:00:00.003     4M / 4M    INFO    General                 (construction.cpp          : 111)   Max read length 151
      0:00:00.004     4M / 4M    INFO    General                 (construction.cpp          : 117)   Average read length 135.523
      0:00:00.004     4M / 4M    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == k+1-mer counting
      0:00:00.004     4M / 4M    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 16 files using 4 threads. This might take a while.
      0:00:00.005     4M / 4M    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:00:00.005     4M / 4M    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.583008 Gb
      0:00:00.005     4M / 4M    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 2097152
      0:00:20.056     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 289)   Processed 3111276 reads
      0:00:28.343     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 289)   Processed 4318210 reads
      0:00:28.343     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 295)   Adding contigs from previous K
      0:00:28.613    16M / 2G    INFO    General                 (kmer_splitters.hpp        : 308)   Used 4318210 reads
      0:00:28.613    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:00:28.856    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 3586466 kmers in total.
      0:00:28.856    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:00:28.923    16M / 2G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Extension index construction
      0:00:28.923    16M / 2G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:00:28.923    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 64 files using 4 threads. This might take a while.
      0:00:28.923    16M / 2G    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:00:28.923    16M / 2G    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.582031 Gb
      0:00:28.923    16M / 2G    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 524288
      0:00:30.168     3G / 3G    INFO    General                 (kmer_splitters.hpp        : 380)   Processed 3586466 kmers
      0:00:30.168     3G / 3G    INFO    General                 (kmer_splitters.hpp        : 385)   Used 3586466 kmers.
      0:00:30.181    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:00:30.409    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 3554313 kmers in total.
      0:00:30.417    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:00:30.523    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:00:31.018    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 150)   Merging final buckets.
      0:00:31.294    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 1656352 bytes occupied (3.72809 bits per kmer).
      0:00:31.312    20M / 3G    INFO   DeBruijnExtensionIndexBu (kmer_extension_index_build:  99)   Building k-mer extensions from k+1-mers
      0:00:34.568    20M / 3G    INFO   DeBruijnExtensionIndexBu (kmer_extension_index_build: 103)   Building k-mer extensions from k+1-mers finished.
      0:00:34.569    20M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Condensing graph
      0:00:34.612    20M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 355)   Extracting unbranching paths
      0:00:38.098    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 374)   Extracting unbranching paths finished. 212715 sequences extracted
      0:00:39.023    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 310)   Collecting perfect loops
      0:00:39.361    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 343)   Collecting perfect loops finished. 0 loops collected
      0:00:39.673    76M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Filling coverage indices (PHM)
      0:00:39.673    76M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:00:39.673    76M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:00:40.850    84M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 1665128 bytes occupied (3.71425 bits per kmer).
      0:00:40.877   100M / 3G    INFO    General                 (construction.cpp          : 388)   Collecting k-mer coverage information from reads, this takes a while.
      0:01:22.526   100M / 3G    INFO    General                 (construction.cpp          : 508)   Filling coverage and flanking coverage from PHM
      0:01:23.601   100M / 3G    INFO    General                 (construction.cpp          : 464)   Processed 425421 edges
      0:01:23.634    76M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == EC Threshold Finding
      0:01:23.638    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 181)   Kmer coverage valley at: 42
      0:01:23.638    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 201)   K-mer histogram maximum: 46
      0:01:23.638    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 237)   Estimated median coverage: 47. Coverage mad: 4.4478
      0:01:23.638    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 259)   Fitting coverage model
      0:01:23.752    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 2
      0:01:23.987    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 4
      0:01:24.843    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 8
      0:01:28.936    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 16
      0:01:34.156    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 32
      0:01:42.519    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 309)   Fitted mean coverage: 3.85793. Fitted coverage std. dev: 0.648178
      0:01:42.519    76M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 327)   Valley value was estimated improperly, reset to 1
      0:01:42.521    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 334)   Probability of erroneous kmer at valley: 1
      0:01:42.521    76M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 1
      0:01:42.521    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 375)   Estimated genome size (ignoring repeats): 3555473
      0:01:42.521    72M / 3G    INFO    General                 (genomic_info_filler.cpp   : 114)   Failed to estimate mean coverage
      0:01:42.521    72M / 3G    INFO    General                 (genomic_info_filler.cpp   : 127)   EC coverage threshold value was calculated as 1
      0:01:42.521    72M / 3G    INFO    General                 (genomic_info_filler.cpp   : 128)   Trusted kmer low bound: 0
      0:01:42.521    72M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Gap Closer
      0:01:42.521    72M / 3G    INFO    General                 (graph_pack.hpp            : 101)   Index refill
      0:01:42.521    72M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:01:42.521    72M / 3G    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 64 files using 4 threads. This might take a while.
      0:01:42.521    72M / 3G    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:01:42.521    72M / 3G    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.577474 Gb
      0:01:42.521    72M / 3G    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 524288
      0:01:43.090     3G / 3G    INFO    General                 (edge_index_builders.hpp   :  77)   Processed 425421 edges
      0:01:43.090     3G / 3G    INFO    General                 (edge_index_builders.hpp   :  82)   Used 425421 sequences.
      0:01:43.099    72M / 3G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:01:43.278    72M / 3G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 3586466 kmers in total.
      0:01:43.278    72M / 3G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:01:43.359    72M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:01:43.860    76M / 3G    INFO    General                 (kmer_index_builder.hpp    : 150)   Merging final buckets.
      0:01:44.089    76M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 1671520 bytes occupied (3.72851 bits per kmer).
      0:01:44.154   160M / 3G    INFO    General                 (edge_index_builders.hpp   : 107)   Collecting edge information from graph, this takes a while.
      0:01:44.905   160M / 3G    INFO    General                 (edge_index.hpp            :  92)   Index refilled
      0:01:44.906   160M / 3G    INFO    General                 (gap_closer.cpp            : 159)   Preparing shift maps
      0:01:45.129   172M / 3G    INFO    General                 (gap_closer.cpp            : 119)   Processing paired reads (takes a while)
      0:02:23.621   180M / 3G    INFO    General                 (gap_closer.cpp            : 138)   Used 1078626 paired reads
      0:02:23.621   180M / 3G    INFO    General                 (gap_closer.cpp            : 140)   Merging paired indices
      0:02:23.683   164M / 3G    INFO   GapCloser                (gap_closer.cpp            : 346)   Closing short gaps
      0:02:24.326   164M / 3G    INFO   GapCloser                (gap_closer.cpp            : 380)   Closing short gaps complete: filled 11 gaps after checking 345 candidates
      0:02:24.349   164M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Raw Simplification
      0:02:24.358    76M / 3G    INFO    General                 (simplification.cpp        : 128)   PROCEDURE == InitialCleaning
      0:02:24.358    76M / 3G    INFO    General                 (simplification.cpp        :  68)   Most init cleaning disabled since detected mean 0 was less than activation coverage 10
      0:02:24.358    76M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Self conjugate edge remover
      0:02:24.423    76M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Self conjugate edge remover triggered 0 times
      0:02:24.423    76M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Simplification
      0:02:24.423    76M / 3G    INFO    General                 (simplification.cpp        : 357)   Graph simplification started
      0:02:24.423    76M / 3G    INFO    General                 (graph_simplification.hpp  : 634)   Creating parallel br instance
      0:02:24.423    76M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 1
      0:02:24.423    76M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:25.402    76M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 64726 times
      0:02:25.402    76M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.903   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 5177 times
      0:02:29.903   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:29.961   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:29.961   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 2
      0:02:29.961   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:29.977   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 31 times
      0:02:29.977   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.979   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 1 times
      0:02:29.979   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:29.980   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 3
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:29.980   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 4
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:29.980   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 5
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:29.980   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 6
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:29.980   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 1 times
      0:02:29.981   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 7
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 1 times
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:29.981   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 8
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 2 times
      0:02:29.981   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 9
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:29.981   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.982   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 1 times
      0:02:29.982   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:29.982   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 2 times
      0:02:29.983   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 10
      0:02:29.983   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:29.983   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:29.983   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:29.983   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:29.983   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:30.585   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 12775 times
      0:02:30.585   104M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 11
      0:02:30.585   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:30.653   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 1110 times
      0:02:30.653   104M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:35.864   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 4960 times
      0:02:35.864   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:35.898   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:35.898   120M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 12
      0:02:35.898   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:35.908   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 21 times
      0:02:35.908   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:35.911   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 2 times
      0:02:35.911   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:35.911   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:35.912   120M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 13
      0:02:35.912   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:35.912   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:35.912   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:35.913   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:35.913   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:35.913   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:35.913   120M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Gap Closer
      0:02:35.914   120M / 3G    INFO    General                 (graph_pack.hpp            : 101)   Index refill
      0:02:35.914   120M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:02:35.914   120M / 3G    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 64 files using 4 threads. This might take a while.
      0:02:35.915   120M / 3G    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:02:35.915   120M / 3G    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.573568 Gb
      0:02:35.915   120M / 3G    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 524288
      0:02:36.215     3G / 3G    INFO    General                 (edge_index_builders.hpp   :  77)   Processed 86603 edges
      0:02:36.215     3G / 3G    INFO    General                 (edge_index_builders.hpp   :  82)   Used 86603 sequences.
      0:02:36.221   120M / 3G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:02:36.335   120M / 3G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 1112644 kmers in total.
      0:02:36.335   120M / 3G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:02:36.379   120M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:02:36.617   120M / 3G    INFO    General                 (kmer_index_builder.hpp    : 150)   Merging final buckets.
      0:02:36.711   120M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 524600 bytes occupied (3.77192 bits per kmer).
      0:02:36.749   148M / 3G    INFO    General                 (edge_index_builders.hpp   : 107)   Collecting edge information from graph, this takes a while.
      0:02:37.007   148M / 3G    INFO    General                 (edge_index.hpp            :  92)   Index refilled
      0:02:37.007   148M / 3G    INFO    General                 (gap_closer.cpp            : 159)   Preparing shift maps
      0:02:37.069   152M / 3G    INFO    General                 (gap_closer.cpp            : 119)   Processing paired reads (takes a while)
      0:03:05.545   152M / 3G    INFO    General                 (gap_closer.cpp            : 138)   Used 1078626 paired reads
      0:03:05.545   152M / 3G    INFO    General                 (gap_closer.cpp            : 140)   Merging paired indices
      0:03:05.551   148M / 3G    INFO   GapCloser                (gap_closer.cpp            : 346)   Closing short gaps
      0:03:05.676   148M / 3G    INFO   GapCloser                (gap_closer.cpp            : 380)   Closing short gaps complete: filled 0 gaps after checking 117 candidates
      0:03:05.686   148M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Simplification Cleanup
      0:03:05.686   148M / 3G    INFO    General                 (simplification.cpp        : 196)   PROCEDURE == Post simplification
      0:03:05.686   148M / 3G    INFO    General                 (graph_simplification.hpp  : 453)   Disconnection of relatively low covered edges disabled
      0:03:05.686   148M / 3G    INFO    General                 (graph_simplification.hpp  : 489)   Complex tip clipping disabled
      0:03:05.686   148M / 3G    INFO    General                 (graph_simplification.hpp  : 634)   Creating parallel br instance
      0:03:05.686   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:03:05.733   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:03:05.734   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:03:06.149   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 2 times
      0:03:06.149   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:03:06.184   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:03:06.184   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:03:06.602   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:03:06.602   148M / 3G    INFO    General                 (simplification.cpp        : 330)   Disrupting self-conjugate edges
      0:03:06.677   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Removing isolated edges
      0:03:07.168   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Removing isolated edges triggered 4744 times
      0:03:07.168   148M / 3G    INFO    General                 (simplification.cpp        : 470)   Counting average coverage
      0:03:07.193   148M / 3G    INFO    General                 (simplification.cpp        : 476)   Average coverage = 245.147
      0:03:07.193   148M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Contig Output
      0:03:07.193   148M / 3G    INFO    General                 (contig_output_stage.cpp   :  40)   Writing GFA to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/assembly_graph_with_scaffolds.gfa
      0:03:07.423   148M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/before_rr.fasta
      0:03:07.808   148M / 3G    INFO    General                 (contig_output_stage.cpp   :  51)   Outputting FastG graph to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/assembly_graph.fastg
      0:03:08.693   148M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/simplified_contigs.fasta
      0:03:09.070   148M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/final_contigs.fasta
      0:03:09.456   148M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Contig Output
      0:03:09.456   148M / 3G    INFO    General                 (contig_output_stage.cpp   :  40)   Writing GFA to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/assembly_graph_with_scaffolds.gfa
      0:03:09.680   148M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/before_rr.fasta
      0:03:10.066   148M / 3G    INFO    General                 (contig_output_stage.cpp   :  51)   Outputting FastG graph to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/assembly_graph.fastg
      0:03:10.962   148M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/simplified_contigs.fasta
      0:03:11.360   148M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K55/final_contigs.fasta
      0:03:11.773   148M / 3G    INFO    General                 (launch.hpp                : 149)   SPAdes finished
      0:03:12.424    16M / 3G    INFO    General                 (main.cpp                  : 109)   Assembling time: 0 hours 3 minutes 12 seconds
    
    == Running assembler: K77
    
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  74)   Loaded config from /home/arriyaz/Desktop/genome_assembly/results/spades/K77/configs/config.info
      0:00:00.000     4M / 4M    INFO    General                 (memory_limit.cpp          :  49)   Memory limit set to 7 Gb
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  87)   Starting SPAdes, built from refs/heads/spades_3.13.0, git revision 8ea46659e9b2aca35444a808db550ac333006f8b
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  88)   Maximum k-mer length: 128
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  89)   Assembling dataset (/home/arriyaz/Desktop/genome_assembly/results/spades/dataset.info) with K=77
      0:00:00.000     4M / 4M    INFO    General                 (main.cpp                  :  90)   Maximum # of threads to use (adjusted due to OMP capabilities): 4
      0:00:00.000     4M / 4M    INFO    General                 (launch.hpp                :  51)   SPAdes started
      0:00:00.000     4M / 4M    INFO    General                 (launch.hpp                :  58)   Starting from stage: construction
      0:00:00.000     4M / 4M    INFO    General                 (launch.hpp                :  65)   Two-step RR enabled: 0
      0:00:00.000     4M / 4M    INFO    General                 (launch.hpp                :  76)   Will need read mapping, kmer mapper will be attached
      0:00:00.000     4M / 4M    INFO   StageManager             (stage.cpp                 : 132)   STAGE == de Bruijn graph construction
      0:00:00.000     4M / 4M    INFO    General                 (read_converter.hpp        :  59)   Binary reads detected
      0:00:00.001     4M / 4M    INFO    General                 (construction.cpp          : 111)   Max read length 151
      0:00:00.001     4M / 4M    INFO    General                 (construction.cpp          : 117)   Average read length 135.523
      0:00:00.001     4M / 4M    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == k+1-mer counting
      0:00:00.001     4M / 4M    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 16 files using 4 threads. This might take a while.
      0:00:00.001     4M / 4M    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:00:00.001     4M / 4M    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.583008 Gb
      0:00:00.001     4M / 4M    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 1398101
      0:00:13.540     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 289)   Processed 2835686 reads
      0:00:19.660     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 289)   Processed 4318210 reads
      0:00:19.660     2G / 2G    INFO    General                 (kmer_splitters.hpp        : 295)   Adding contigs from previous K
      0:00:20.349    16M / 2G    INFO    General                 (kmer_splitters.hpp        : 308)   Used 4318210 reads
      0:00:20.349    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:00:20.813    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 3981845 kmers in total.
      0:00:20.813    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:00:21.030    16M / 2G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Extension index construction
      0:00:21.030    16M / 2G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:00:21.030    16M / 2G    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 64 files using 4 threads. This might take a while.
      0:00:21.030    16M / 2G    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:00:21.030    16M / 2G    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.582031 Gb
      0:00:21.030    16M / 2G    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 349525
      0:00:23.252     3G / 3G    INFO    General                 (kmer_splitters.hpp        : 380)   Processed 3981845 kmers
      0:00:23.252     3G / 3G    INFO    General                 (kmer_splitters.hpp        : 385)   Used 3981845 kmers.
      0:00:23.286    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:00:23.719    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 3977553 kmers in total.
      0:00:23.719    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:00:23.881    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:00:24.705    16M / 3G    INFO    General                 (kmer_index_builder.hpp    : 150)   Merging final buckets.
      0:00:25.059    16M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 1852744 bytes occupied (3.7264 bits per kmer).
      0:00:25.066    20M / 3G    INFO   DeBruijnExtensionIndexBu (kmer_extension_index_build:  99)   Building k-mer extensions from k+1-mers
      0:00:26.783    20M / 3G    INFO   DeBruijnExtensionIndexBu (kmer_extension_index_build: 103)   Building k-mer extensions from k+1-mers finished.
      0:00:26.783    20M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Condensing graph
      0:00:26.818    20M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 355)   Extracting unbranching paths
      0:00:29.620    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 374)   Extracting unbranching paths finished. 188644 sequences extracted
      0:00:31.194    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 310)   Collecting perfect loops
      0:00:31.737    28M / 3G    INFO   UnbranchingPathExtractor (debruijn_graph_constructor: 343)   Collecting perfect loops finished. 0 loops collected
      0:00:32.204    80M / 3G    INFO    General                 (stage.cpp                 : 101)   PROCEDURE == Filling coverage indices (PHM)
      0:00:32.204    80M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:00:32.204    80M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:00:33.186    80M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 1848456 bytes occupied (3.71377 bits per kmer).
      0:00:33.202    96M / 3G    INFO    General                 (construction.cpp          : 388)   Collecting k-mer coverage information from reads, this takes a while.
      0:00:58.021    96M / 3G    INFO    General                 (construction.cpp          : 508)   Filling coverage and flanking coverage from PHM
      0:00:59.818    96M / 3G    INFO    General                 (construction.cpp          : 464)   Processed 377280 edges
      0:00:59.868    76M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == EC Threshold Finding
      0:00:59.871    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 181)   Kmer coverage valley at: 40
      0:00:59.871    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 201)   K-mer histogram maximum: 43
      0:00:59.871    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 237)   Estimated median coverage: 44. Coverage mad: 4.4478
      0:00:59.871    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 259)   Fitting coverage model
      0:00:59.988    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 2
      0:01:00.341    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 4
      0:01:01.428    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 8
      0:01:03.333    76M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 16
      0:01:07.673    72M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 295)   ... iteration 32
      0:01:13.455    72M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 309)   Fitted mean coverage: 3.78154. Fitted coverage std. dev: 0.59046
      0:01:13.455    72M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 327)   Valley value was estimated improperly, reset to 1
      0:01:13.457    72M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 334)   Probability of erroneous kmer at valley: 1
      0:01:13.457    72M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 1
      0:01:13.457    72M / 3G    INFO    General                 (kmer_coverage_model.cpp   : 375)   Estimated genome size (ignoring repeats): 3941252
      0:01:13.457    72M / 3G    INFO    General                 (genomic_info_filler.cpp   : 114)   Failed to estimate mean coverage
      0:01:13.457    72M / 3G    INFO    General                 (genomic_info_filler.cpp   : 127)   EC coverage threshold value was calculated as 1
      0:01:13.457    72M / 3G    INFO    General                 (genomic_info_filler.cpp   : 128)   Trusted kmer low bound: 0
      0:01:13.457    72M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Gap Closer
      0:01:13.457    72M / 3G    INFO    General                 (graph_pack.hpp            : 101)   Index refill
      0:01:13.457    72M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:01:13.457    72M / 3G    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 64 files using 4 threads. This might take a while.
      0:01:13.457    72M / 3G    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:01:13.457    72M / 3G    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.577474 Gb
      0:01:13.457    72M / 3G    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 349525
      0:01:14.451     3G / 3G    INFO    General                 (edge_index_builders.hpp   :  77)   Processed 377280 edges
      0:01:14.451     3G / 3G    INFO    General                 (edge_index_builders.hpp   :  82)   Used 377280 sequences.
      0:01:14.467    72M / 3G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:01:14.802    72M / 3G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 3981845 kmers in total.
      0:01:14.802    72M / 3G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:01:15.031    72M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:01:15.879    76M / 3G    INFO    General                 (kmer_index_builder.hpp    : 150)   Merging final buckets.
      0:01:16.230    76M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 1854736 bytes occupied (3.72639 bits per kmer).
      0:01:16.299   168M / 3G    INFO    General                 (edge_index_builders.hpp   : 107)   Collecting edge information from graph, this takes a while.
      0:01:17.369   168M / 3G    INFO    General                 (edge_index.hpp            :  92)   Index refilled
      0:01:17.369   168M / 3G    INFO    General                 (gap_closer.cpp            : 159)   Preparing shift maps
      0:01:17.628   184M / 3G    INFO    General                 (gap_closer.cpp            : 119)   Processing paired reads (takes a while)
      0:01:49.934   184M / 3G    INFO    General                 (gap_closer.cpp            : 138)   Used 1078626 paired reads
      0:01:49.934   184M / 3G    INFO    General                 (gap_closer.cpp            : 140)   Merging paired indices
      0:01:50.026   168M / 3G    INFO   GapCloser                (gap_closer.cpp            : 346)   Closing short gaps
      0:01:50.624   168M / 3G    INFO   GapCloser                (gap_closer.cpp            : 380)   Closing short gaps complete: filled 49 gaps after checking 1130 candidates
      0:01:50.660   168M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Raw Simplification
      0:01:50.671    76M / 3G    INFO    General                 (simplification.cpp        : 128)   PROCEDURE == InitialCleaning
      0:01:50.671    76M / 3G    INFO    General                 (simplification.cpp        :  68)   Most init cleaning disabled since detected mean 0 was less than activation coverage 10
      0:01:50.671    76M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Self conjugate edge remover
      0:01:50.761    76M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Self conjugate edge remover triggered 2 times
      0:01:50.761    76M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Simplification
      0:01:50.761    76M / 3G    INFO    General                 (simplification.cpp        : 357)   Graph simplification started
      0:01:50.761    76M / 3G    INFO    General                 (graph_simplification.hpp  : 634)   Creating parallel br instance
      0:01:50.761    76M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 1
      0:01:50.761    76M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:51.959    80M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 74058 times
      0:01:51.959    80M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.279   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 4131 times
      0:01:57.279   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.328   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 5 times
      0:01:57.328   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 2
      0:01:57.328   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.341   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 62 times
      0:01:57.341   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.360   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 8 times
      0:01:57.360   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.360   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:57.361   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 3
      0:01:57.361   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.361   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:57.362   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.362   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:57.362   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.363   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:57.363   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 4
      0:01:57.363   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.364   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:57.364   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.364   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:57.364   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.365   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:57.365   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 5
      0:01:57.365   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.365   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:57.366   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.366   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:57.366   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.366   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:01:57.367   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 6
      0:01:57.367   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.367   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:57.367   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.368   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:57.368   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.368   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 1 times
      0:01:57.368   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 7
      0:01:57.369   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.369   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:01:57.369   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.370   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:57.370   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.370   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 5 times
      0:01:57.371   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 8
      0:01:57.371   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.371   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 2 times
      0:01:57.371   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.372   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:01:57.372   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.375   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 32 times
      0:01:57.375   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 9
      0:01:57.376   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.376   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 8 times
      0:01:57.377   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.410   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 17 times
      0:01:57.411   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.413   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 38 times
      0:01:57.414   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 10
      0:01:57.414   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.415   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 14 times
      0:01:57.416   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:01:57.454   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 16 times
      0:01:57.455   120M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:01:57.793   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 4682 times
      0:01:57.793   116M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 11
      0:01:57.793   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:01:57.884   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 1658 times
      0:01:57.884   116M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:01.442   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 2988 times
      0:02:01.442   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:01.456   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:01.456   148M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 12
      0:02:01.456   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:01.463   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 40 times
      0:02:01.463   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:01.467   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 3 times
      0:02:01.467   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:01.467   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:01.467   148M / 3G    INFO    General                 (simplification.cpp        : 362)   PROCEDURE == Simplification cycle, iteration 13
      0:02:01.467   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:01.467   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:01.467   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:01.467   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:01.468   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Low coverage edge remover
      0:02:01.468   148M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Low coverage edge remover triggered 0 times
      0:02:01.468   148M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Gap Closer
      0:02:01.468   148M / 3G    INFO    General                 (graph_pack.hpp            : 101)   Index refill
      0:02:01.468   148M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 301)   Building kmer index
      0:02:01.468   148M / 3G    INFO    General                 (kmer_index_builder.hpp    : 117)   Splitting kmer instances into 64 files using 4 threads. This might take a while.
      0:02:01.468   148M / 3G    INFO    General                 (file_limit.hpp            :  32)   Open file limit set to 4096
      0:02:01.468   148M / 3G    INFO    General                 (kmer_splitters.hpp        :  89)   Memory available for splitting buffers: 0.571289 Gb
      0:02:01.468   148M / 3G    INFO    General                 (kmer_splitters.hpp        :  97)   Using cell size of 349525
      0:02:01.833     3G / 3G    INFO    General                 (edge_index_builders.hpp   :  77)   Processed 55528 edges
      0:02:01.833     3G / 3G    INFO    General                 (edge_index_builders.hpp   :  82)   Used 55528 sequences.
      0:02:01.841   144M / 3G    INFO    General                 (kmer_index_builder.hpp    : 120)   Starting k-mer counting.
      0:02:01.971   144M / 3G    INFO    General                 (kmer_index_builder.hpp    : 127)   K-mer counting done. There are 1260198 kmers in total.
      0:02:01.971   144M / 3G    INFO    General                 (kmer_index_builder.hpp    : 133)   Merging temporary buckets.
      0:02:02.042   144M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 314)   Building perfect hash indices
      0:02:02.317   148M / 3G    INFO    General                 (kmer_index_builder.hpp    : 150)   Merging final buckets.
      0:02:02.484   148M / 3G    INFO   K-mer Index Building     (kmer_index_builder.hpp    : 336)   Index built. Total 592968 bytes occupied (3.76428 bits per kmer).
      0:02:02.546   180M / 3G    INFO    General                 (edge_index_builders.hpp   : 107)   Collecting edge information from graph, this takes a while.
      0:02:02.827   180M / 3G    INFO    General                 (edge_index.hpp            :  92)   Index refilled
      0:02:02.827   180M / 3G    INFO    General                 (gap_closer.cpp            : 159)   Preparing shift maps
      0:02:02.897   184M / 3G    INFO    General                 (gap_closer.cpp            : 119)   Processing paired reads (takes a while)
      0:02:21.663   184M / 3G    INFO    General                 (gap_closer.cpp            : 138)   Used 1078626 paired reads
      0:02:21.663   184M / 3G    INFO    General                 (gap_closer.cpp            : 140)   Merging paired indices
      0:02:21.682   180M / 3G    INFO   GapCloser                (gap_closer.cpp            : 346)   Closing short gaps
      0:02:21.773   180M / 3G    INFO   GapCloser                (gap_closer.cpp            : 380)   Closing short gaps complete: filled 0 gaps after checking 245 candidates
      0:02:21.786   180M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Simplification Cleanup
      0:02:21.786   180M / 3G    INFO    General                 (simplification.cpp        : 196)   PROCEDURE == Post simplification
      0:02:21.786   180M / 3G    INFO    General                 (graph_simplification.hpp  : 453)   Disconnection of relatively low covered edges disabled
      0:02:21.786   180M / 3G    INFO    General                 (graph_simplification.hpp  : 489)   Complex tip clipping disabled
      0:02:21.786   180M / 3G    INFO    General                 (graph_simplification.hpp  : 634)   Creating parallel br instance
      0:02:21.786   180M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:21.810   180M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 1 times
      0:02:21.810   180M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:22.027   180M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 3 times
      0:02:22.027   180M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Tip clipper
      0:02:22.052   180M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Tip clipper triggered 0 times
      0:02:22.052   180M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Bulge remover
      0:02:22.213   180M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Bulge remover triggered 0 times
      0:02:22.213   180M / 3G    INFO    General                 (simplification.cpp        : 330)   Disrupting self-conjugate edges
      0:02:22.266   180M / 3G    INFO   Simplification           (parallel_processing.hpp   : 165)   Running Removing isolated edges
      0:02:23.366   176M / 3G    INFO   Simplification           (parallel_processing.hpp   : 167)   Removing isolated edges triggered 12649 times
      0:02:23.366   176M / 3G    INFO    General                 (simplification.cpp        : 470)   Counting average coverage
      0:02:23.377   176M / 3G    INFO    General                 (simplification.cpp        : 476)   Average coverage = 320.92
      0:02:23.377   176M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Mismatch Correction
      0:02:23.377   176M / 3G    INFO    General                 (graph_pack.hpp            : 109)   Normalizing k-mer map. Total 1108132 kmers to process
      0:02:24.535   176M / 3G    INFO    General                 (graph_pack.hpp            : 111)   Normalizing done
      0:02:56.889   324M / 3G    INFO    General                 (mismatch_shall_not_pass.hp: 189)   Finished collecting potential mismatches positions
      0:02:57.204   204M / 3G    INFO    General                 (mismatch_shall_not_pass.hp: 290)   All edges processed
      0:02:57.289   176M / 3G    INFO    General                 (mismatch_correction.cpp   :  27)   Corrected 0 nucleotides
      0:02:57.289   176M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Contig Output
      0:02:57.289   176M / 3G    INFO    General                 (contig_output_stage.cpp   :  40)   Writing GFA to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/assembly_graph_with_scaffolds.gfa
      0:02:57.377   176M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/before_rr.fasta
      0:02:57.532   176M / 3G    INFO    General                 (contig_output_stage.cpp   :  51)   Outputting FastG graph to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/assembly_graph.fastg
      0:02:57.866   176M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/simplified_contigs.fasta
      0:02:58.023   176M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/intermediate_contigs.fasta
      0:02:58.197   176M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Paired Information Counting
      0:02:58.316   180M / 3G    INFO    General                 (graph_pack.hpp            : 109)   Normalizing k-mer map. Total 1108132 kmers to process
      0:02:58.316   180M / 3G    INFO    General                 (graph_pack.hpp            : 111)   Normalizing done
      0:02:58.328   180M / 3G    INFO    General                 (pair_info_count.cpp       : 320)   Min edge length for estimation: 69
      0:02:58.328   180M / 3G    INFO    General                 (pair_info_count.cpp       : 331)   Estimating insert size for library #0
      0:02:58.328   180M / 3G    INFO    General                 (pair_info_count.cpp       : 190)   Estimating insert size (takes a while)
      0:02:58.405   260M / 3G    INFO    General                 (pair_info_count.cpp       :  39)   Selecting usual mapper
      0:03:15.521   260M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 200000 reads
      0:03:15.652   260M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 400000 reads
      0:03:15.830   260M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 600000 reads
      0:03:16.320   260M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 800000 reads
      0:03:22.278   260M / 3G    INFO    General                 (sequence_mapper_notifier.h:  98)   Total 1078626 reads processed
      0:03:24.436   260M / 3G    INFO    General                 (pair_info_count.cpp       : 209)   Edge pairs: 67108864 (rough upper limit)
      0:03:24.436   260M / 3G    INFO    General                 (pair_info_count.cpp       : 213)   7156 paired reads (0.663437% of all) aligned to long edges
      0:03:24.445   180M / 3G    INFO    General                 (pair_info_count.cpp       : 354)     Insert size = 110.458, deviation = 24.9164, left quantile = 82, right quantile = 146, read length = 151
      0:03:24.445   180M / 3G    WARN    General                 (pair_info_count.cpp       : 358)   Estimated mean insert size 110.458 is very small compared to read length 151
      0:03:24.594   372M / 3G    INFO    General                 (pair_info_count.cpp       : 371)   Filtering data for library #0
      0:03:24.595   372M / 3G    INFO    General                 (pair_info_count.cpp       :  39)   Selecting usual mapper
      0:04:32.069   372M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 200000 reads
      0:04:32.664   372M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 400000 reads
      0:04:32.749   372M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 600000 reads
      0:04:32.824   372M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 800000 reads
      0:04:56.851   372M / 3G    INFO    General                 (sequence_mapper_notifier.h:  98)   Total 1078626 reads processed
      0:04:56.851   372M / 3G    INFO    General                 (pair_info_count.cpp       : 383)   Mapping library #0
      0:04:56.851   372M / 3G    INFO    General                 (pair_info_count.cpp       : 385)   Mapping paired reads (takes a while)
      0:04:56.851   372M / 3G    INFO    General                 (pair_info_count.cpp       : 289)   Left insert size quantile 82, right insert size quantile 146, filtering threshold 2, rounding threshold 0
      0:04:56.864   384M / 3G    INFO    General                 (pair_info_count.cpp       :  39)   Selecting usual mapper
      0:07:15.640   936M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 200000 reads
      0:07:17.333   940M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 400000 reads
      0:07:17.741   940M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 600000 reads
      0:07:17.872   940M / 3G    INFO    General                 (sequence_mapper_notifier.h:  80)   Processed 800000 reads
      0:08:09.959   984M / 3G    INFO    General                 (sequence_mapper_notifier.h:  98)   Total 1078626 reads processed
      0:08:09.990   780M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Distance Estimation
      0:08:09.990   780M / 3G    INFO    General                 (distance_estimation.cpp   : 173)   Processing library #0
      0:08:09.990   780M / 3G    INFO    General                 (distance_estimation.cpp   : 149)   Weight Filter Done
      0:08:09.990   780M / 3G    INFO   DistanceEstimator        (distance_estimation.hpp   : 116)   Using SIMPLE distance estimator
      0:08:11.601   792M / 3G    INFO    General                 (distance_estimation.cpp   :  34)   Filtering info
      0:08:11.601   792M / 3G    INFO    General                 (pair_info_filters.hpp     : 242)   Start filtering; index size: 253808
      0:08:11.784   800M / 3G    INFO    General                 (pair_info_filters.hpp     : 263)   Done filtering
      0:08:11.785   792M / 3G    INFO    General                 (distance_estimation.cpp   : 156)   Refining clustered pair information
      0:08:11.890   792M / 3G    INFO    General                 (distance_estimation.cpp   : 158)   The refining of clustered pair information has been finished
      0:08:11.890   792M / 3G    INFO    General                 (distance_estimation.cpp   : 160)   Improving paired information
      0:08:13.064   800M / 3G    INFO   PairInfoImprover         (pair_info_improver.hpp    : 103)   Paired info stats: missing = 6309; contradictional = 0
      0:08:14.275   800M / 3G    INFO   PairInfoImprover         (pair_info_improver.hpp    : 103)   Paired info stats: missing = 536; contradictional = 0
      0:08:14.275   800M / 3G    INFO    General                 (distance_estimation.cpp   : 103)   Filling scaffolding index
      0:08:14.275   800M / 3G    INFO   DistanceEstimator        (distance_estimation.hpp   : 116)   Using SMOOTHING distance estimator
      0:08:33.912   828M / 3G    INFO    General                 (distance_estimation.cpp   :  34)   Filtering info
      0:08:33.912   828M / 3G    INFO    General                 (pair_info_filters.hpp     : 242)   Start filtering; index size: 558699
      0:08:34.225   860M / 3G    INFO    General                 (pair_info_filters.hpp     : 263)   Done filtering
      0:08:34.226   828M / 3G    INFO    General                 (distance_estimation.cpp   : 182)   Clearing raw paired index
      0:08:35.017   240M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Repeat Resolving
      0:08:35.017   240M / 3G    INFO    General                 (repeat_resolving.cpp      :  69)   Using Path-Extend repeat resolving
      0:08:35.017   240M / 3G    INFO    General                 (launcher.cpp              : 477)   ExSPAnder repeat resolving tool started
      0:08:35.128   280M / 3G    INFO    General                 (launcher.cpp              : 392)   Creating main extenders, unique edge length = 2000
      0:08:35.128   280M / 3G    INFO    General                 (extenders_logic.cpp       : 275)   Estimated coverage of library #0 is 320.92
      0:08:35.132   284M / 3G    INFO    General                 (extenders_logic.cpp       : 275)   Estimated coverage of library #0 is 320.92
      0:08:35.151   284M / 3G    INFO    General                 (extenders_logic.cpp       : 472)   Using 1 paired-end library
      0:08:35.151   284M / 3G    INFO    General                 (extenders_logic.cpp       : 473)   Using 1 paired-end scaffolding library
      0:08:35.151   284M / 3G    INFO    General                 (extenders_logic.cpp       : 474)   Using 0 single read libraries
      0:08:35.151   284M / 3G    INFO    General                 (launcher.cpp              : 420)   Total number of extenders is 3
      0:08:35.151   284M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 0 paths from 15105 (0%)
      0:08:35.317   284M / 3G    INFO    General                 (path_extender.hpp         : 883)   Processed 128 paths from 15105 (0%)
      0:08:35.331   284M / 3G    INFO    General                 (path_extender.hpp         : 883)   Processed 256 paths from 15105 (1%)
      0:08:35.358   288M / 3G    INFO    General                 (path_extender.hpp         : 883)   Processed 512 paths from 15105 (3%)
      0:08:35.415   292M / 3G    INFO    General                 (path_extender.hpp         : 883)   Processed 1024 paths from 15105 (6%)
      0:08:35.480   296M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 1511 paths from 15105 (10%)
      0:08:36.092   300M / 3G    INFO    General                 (path_extender.hpp         : 883)   Processed 2048 paths from 15105 (13%)
      0:08:36.286   308M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 3022 paths from 15105 (20%)
      0:08:36.734   320M / 3G    INFO    General                 (path_extender.hpp         : 883)   Processed 4096 paths from 15105 (27%)
      0:08:36.830   324M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 4533 paths from 15105 (30%)
      0:08:37.465   340M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 6044 paths from 15105 (40%)
      0:08:39.805   352M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 7555 paths from 15105 (50%)
      0:08:41.196   356M / 3G    INFO    General                 (path_extender.hpp         : 883)   Processed 8192 paths from 15105 (54%)
      0:08:42.047   364M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 9066 paths from 15105 (60%)
      0:08:42.401   368M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 10577 paths from 15105 (70%)
      0:08:42.557   372M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 12088 paths from 15105 (80%)
      0:08:42.735   380M / 3G    INFO    General                 (path_extender.hpp         : 885)   Processed 13599 paths from 15105 (90%)
      0:08:42.770   384M / 3G    INFO    General                 (launcher.cpp              : 234)   Finalizing paths
      0:08:42.770   384M / 3G    INFO    General                 (launcher.cpp              : 236)   Deduplicating paths
      0:08:42.858   380M / 3G    INFO    General                 (launcher.cpp              : 240)   Paths deduplicated
      0:08:42.858   380M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 295)   Removing overlaps
      0:08:42.859   380M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 298)   Sorting paths
      0:08:42.876   380M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 305)   Marking overlaps
      0:08:42.876   380M / 3G    INFO   OverlapRemover           (pe_resolver.hpp           : 130)   Marking start/end overlaps
      0:08:42.975   380M / 3G    INFO   OverlapRemover           (pe_resolver.hpp           : 133)   Marking remaining overlaps
      0:08:43.065   380M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 308)   Splitting paths
      0:08:43.077   380M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 313)   Deduplicating paths
      0:08:43.093   380M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 315)   Overlaps removed
      0:08:43.127   380M / 3G    INFO    General                 (launcher.cpp              : 257)   Paths finalized
      0:08:43.128   380M / 3G    INFO    General                 (launcher.cpp              : 427)   Closing gaps in paths
      0:08:43.206   384M / 3G    INFO    General                 (launcher.cpp              : 455)   Gap closing completed
      0:08:43.232   384M / 3G    INFO    General                 (launcher.cpp              : 286)   Traversing tandem repeats
      0:08:43.388   388M / 3G    INFO    General                 (launcher.cpp              : 296)   Traversed 0 loops
      0:08:43.388   388M / 3G    INFO    General                 (launcher.cpp              : 234)   Finalizing paths
      0:08:43.388   388M / 3G    INFO    General                 (launcher.cpp              : 236)   Deduplicating paths
      0:08:43.400   384M / 3G    INFO    General                 (launcher.cpp              : 240)   Paths deduplicated
      0:08:43.400   384M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 295)   Removing overlaps
      0:08:43.400   384M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 298)   Sorting paths
      0:08:43.416   384M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 305)   Marking overlaps
      0:08:43.416   384M / 3G    INFO   OverlapRemover           (pe_resolver.hpp           : 130)   Marking start/end overlaps
      0:08:43.468   384M / 3G    INFO   OverlapRemover           (pe_resolver.hpp           : 133)   Marking remaining overlaps
      0:08:43.508   384M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 308)   Splitting paths
      0:08:43.509   384M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 313)   Deduplicating paths
      0:08:43.519   384M / 3G    INFO   PEResolver               (pe_resolver.hpp           : 315)   Overlaps removed
      0:08:43.549   384M / 3G    INFO    General                 (launcher.cpp              : 257)   Paths finalized
      0:08:43.608   388M / 3G    INFO    General                 (launcher.cpp              : 529)   ExSPAnder repeat resolving tool finished
      0:08:43.765   304M / 3G    INFO   StageManager             (stage.cpp                 : 132)   STAGE == Contig Output
      0:08:43.765   304M / 3G    INFO    General                 (contig_output_stage.cpp   :  40)   Writing GFA to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/assembly_graph_with_scaffolds.gfa
      0:08:43.856   300M / 3G    INFO    General                 (contig_output.hpp         :  22)   Outputting contigs to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/before_rr.fasta
      0:08:44.014   300M / 3G    INFO    General                 (contig_output_stage.cpp   :  51)   Outputting FastG graph to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/assembly_graph.fastg
      0:08:44.327   308M / 3G    INFO    General                 (contig_output_stage.cpp   :  20)   Outputting FastG paths to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/final_contigs.paths
      0:08:44.457   304M / 3G    INFO    General                 (contig_output_stage.cpp   :  20)   Outputting FastG paths to /home/arriyaz/Desktop/genome_assembly/results/spades//K77/scaffolds.paths
      0:08:44.556   304M / 3G    INFO    General                 (launch.hpp                : 149)   SPAdes finished
      0:08:45.214    16M / 3G    INFO    General                 (main.cpp                  : 109)   Assembling time: 0 hours 8 minutes 45 seconds
    
    ===== Assembling finished. Used k-mer sizes: 21, 33, 55, 77 
    
     * Corrected reads are in /home/arriyaz/Desktop/genome_assembly/results/spades/corrected/
     * Assembled contigs are in /home/arriyaz/Desktop/genome_assembly/results/spades/contigs.fasta
     * Assembled scaffolds are in /home/arriyaz/Desktop/genome_assembly/results/spades/scaffolds.fasta
     * Assembly graph is in /home/arriyaz/Desktop/genome_assembly/results/spades/assembly_graph.fastg
     * Assembly graph in GFA format is in /home/arriyaz/Desktop/genome_assembly/results/spades/assembly_graph_with_scaffolds.gfa
     * Paths in the assembly graph corresponding to the contigs are in /home/arriyaz/Desktop/genome_assembly/results/spades/contigs.paths
     * Paths in the assembly graph corresponding to the scaffolds are in /home/arriyaz/Desktop/genome_assembly/results/spades/scaffolds.paths
    
    ======= SPAdes pipeline finished WITH WARNINGS!
    
    === Error correction and assembling warnings:
     * 0:01:28.463    52M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 218)   Too many erroneous kmers, the estimates might be unreliable
     * 0:01:35.365    48M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 327)   Valley value was estimated improperly, reset to 1
     * 0:01:35.368    48M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 1
     * 0:01:27.107    48M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 327)   Valley value was estimated improperly, reset to 2
     * 0:01:27.109    48M / 3G    WARN    General                 (kmer_coverage_model.cpp   : 366)   Failed to determine erroneous kmer threshold. Threshold set to: 2
     * 0:03:24.445   180M / 3G    WARN    General                 (pair_info_count.cpp       : 358)   Estimated mean insert size 110.458 is very small compared to read length 151
    ======= Warnings saved to /home/arriyaz/Desktop/genome_assembly/results/spades/warnings.log
    
    SPAdes log can be found here: /home/arriyaz/Desktop/genome_assembly/results/spades/spades.log
    
    Thank you for using SPAdes!
    (bioriyaz) 




```bash
# check spades result
seqkit stat results/spades/spades.contigs.fa
```

    (bioriyaz) file                              format  type  num_seqs    sum_len  min_len  avg_len  max_len
    results/spades/spades.contigs.fa  FASTA   DNA     10,265  1,183,446       78    115.3    1,302
    (bioriyaz) 



## 4. Comparing results from minia31 vs minia69 vs velvet69 vs spades


```bash
# Setting variable for contigs
MINIA31=results/minia31_results/minia31.contigs.fa
MINIA57=results/minia57_results/minia57.contigs.fa
VELVET57=results/velvet57/velvet57.contigs.fa
VELVET135=results/velvet135/velvet135.contigs.fa
SPADES=results/spades/spades.contigs.fa
```

    (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) 




```bash
mkdir results/quast
```

    (bioriyaz) 




```bash
quast -R $REF $MINIA31 $MINIA57 $VELVET135 --min-contig 30 -o results/quast
```

    /home/arriyaz/miniconda3/envs/bioriyaz/bin/quast -R all_data/refs/NC_045512.2.fa results/minia31_results/minia31.contigs.fa results/minia57_results/minia57.contigs.fa results/velvet135/velvet135.contigs.fa --min-contig 30 -o results/quast
    
    Version: 5.0.2
    
    System information:
      OS: Linux-5.4.0-70-generic-x86_64-with-debian-bullseye-sid (linux_64)
      Python version: 3.6.10
      CPUs number: 4
    
    Started: 2021-04-15 23:10:40
    
    Logging to /home/arriyaz/Desktop/genome_assembly/results/quast/quast.log
    NOTICE: Output directory already exists and looks like a QUAST output dir. Existing results can be reused (e.g. previously generated alignments)!
    NOTICE: Maximum number of threads is set to 1 (use --threads option to set it manually)
    
    CWD: /home/arriyaz/Desktop/genome_assembly
    Main parameters: 
      MODE: default, threads: 1, minimum contig length: 30, minimum alignment length: 65, \
      ambiguity: one, threshold for extensive misassembly size: 1000
    
    Reference:
      /home/arriyaz/Desktop/genome_assembly/all_data/refs/NC_045512.2.fa ==> NC_045512.2
    
    Contigs:
      Pre-processing...
      1  results/minia31_results/minia31.contigs.fa ==> minia31.contigs
      2  results/minia57_results/minia57.contigs.fa ==> minia57.contigs
      3  results/velvet135/velvet135.contigs.fa ==> velvet135.contigs
    
    2021-04-15 23:10:41
    Running Basic statistics processor...
      Reference genome:
        NC_045512.2.fa, length = 29903, num fragments = 1, GC % = 37.97
      Contig files: 
        1  minia31.contigs
        2  minia57.contigs
        3  velvet135.contigs
      Calculating N50 and L50...
        1  minia31.contigs, N50 = 2347, L50 = 6, Total length = 38066, GC % = 39.29, # N's per 100 kbp =  0.00
        2  minia57.contigs, N50 = 6530, L50 = 2, Total length = 31577, GC % = 38.64, # N's per 100 kbp =  0.00
        3  velvet135.contigs, N50 = 2541, L50 = 3, Total length = 23315, GC % = 37.87, # N's per 100 kbp =  0.00
      Drawing Nx plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/basic_stats/Nx_plot.pdf
      Drawing NGx plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/basic_stats/NGx_plot.pdf
      Drawing cumulative plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/basic_stats/cumulative_plot.pdf
      Drawing GC content plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/basic_stats/GC_content_plot.pdf
      Drawing minia31.contigs GC content plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/basic_stats/minia31.contigs_GC_content_plot.pdf
      Drawing minia57.contigs GC content plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/basic_stats/minia57.contigs_GC_content_plot.pdf
      Drawing velvet135.contigs GC content plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/basic_stats/velvet135.contigs_GC_content_plot.pdf
      Drawing Coverage histogram (bin size: 164x)...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/basic_stats/coverage_histogram.pdf
      Drawing velvet135.contigs coverage histogram (bin size: 164x)...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/basic_stats/velvet135-contigs_coverage_histogram.pdf
    Done.
    
    2021-04-15 23:10:49
    Running Contig analyzer...
      1  minia31.contigs
      1  Logging to files /home/arriyaz/Desktop/genome_assembly/results/quast/contigs_reports/contigs_report_minia31-contigs.stdout and contigs_report_minia31-contigs.stderr...
      1  Using existing alignments... 
      1  Analysis is finished.
      2  minia57.contigs
      2  Logging to files /home/arriyaz/Desktop/genome_assembly/results/quast/contigs_reports/contigs_report_minia57-contigs.stdout and contigs_report_minia57-contigs.stderr...
      2  Using existing alignments... 
      2  Analysis is finished.
      3  velvet135.contigs
      3  Logging to files /home/arriyaz/Desktop/genome_assembly/results/quast/contigs_reports/contigs_report_velvet135-contigs.stdout and contigs_report_velvet135-contigs.stderr...
      3  Using existing alignments... 
      3  Analysis is finished.
      Creating total report...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/contigs_reports/misassemblies_report.txt, misassemblies_report.tsv, and misassemblies_report.tex
      Transposed version of total report...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/contigs_reports/transposed_report_misassemblies.txt, transposed_report_misassemblies.tsv, and transposed_report_misassemblies.tex
      Creating total report...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/contigs_reports/unaligned_report.txt, unaligned_report.tsv, and unaligned_report.tex
      Drawing misassemblies by types plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/contigs_reports/misassemblies_plot.pdf
      Drawing misassemblies FRCurve plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/contigs_reports/misassemblies_frcurve_plot.pdf
    Done.
    
    2021-04-15 23:10:51
    Running NA-NGA calculation...
      1  minia31.contigs, Largest alignment = 5330, NA50 = 2347, NGA50 = 2557, LA50 = 6, LGA50 = 5
      2  minia57.contigs, Largest alignment = 10503, NA50 = 6529, NGA50 = 6529, LA50 = 2, LGA50 = 2
      3  velvet135.contigs, Largest alignment = 6072, NA50 = 2541, NGA50 = 1755, LA50 = 3, LGA50 = 5
      Drawing cumulative plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/aligned_stats/cumulative_plot.pdf
      Drawing NAx plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/aligned_stats/NAx_plot.pdf
      Drawing NGAx plot...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/aligned_stats/NGAx_plot.pdf
    Done.
    
    2021-04-15 23:10:53
    Running Genome analyzer...
      NOTICE: No file with genomic features were provided. Use the --features option if you want to specify it.
    
      NOTICE: No file with operons were provided. Use the -O option if you want to specify it.
      1  minia31.contigs
      1  Analysis is finished.
      2  minia57.contigs
      2  Analysis is finished.
      3  velvet135.contigs
      3  Analysis is finished.
      Drawing Genome fraction, % histogram...
        saved to /home/arriyaz/Desktop/genome_assembly/results/quast/genome_stats/genome_fraction_histogram.pdf
    Done.
    
    NOTICE: Genes are not predicted by default. Use --gene-finding or --glimmer option to enable it.
    
    2021-04-15 23:10:54
    Creating large visual summaries...
    This may take a while: press Ctrl-C to skip this step..
      1 of 2: Creating Icarus viewers...
      2 of 2: Creating PDF with all tables and plots...
    Done
    
    2021-04-15 23:11:07
    RESULTS:
      Text versions of total report are saved to /home/arriyaz/Desktop/genome_assembly/results/quast/report.txt, report.tsv, and report.tex
      Text versions of transposed total report are saved to /home/arriyaz/Desktop/genome_assembly/results/quast/transposed_report.txt, transposed_report.tsv, and transposed_report.tex
      HTML version (interactive tables and plots) is saved to /home/arriyaz/Desktop/genome_assembly/results/quast/report.html
      PDF version (tables and plots) is saved to /home/arriyaz/Desktop/genome_assembly/results/quast/report.pdf
      Icarus (contig browser) is saved to /home/arriyaz/Desktop/genome_assembly/results/quast/icarus.html
      Log is saved to /home/arriyaz/Desktop/genome_assembly/results/quast/quast.log
    
    Finished: 2021-04-15 23:11:07
    Elapsed time: 0:00:27.472112
    NOTICEs: 5; WARNINGs: 0; non-fatal ERRORs: 0
    
    Thank you for using QUAST!
    (bioriyaz) 



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

    (bioriyaz) [bwa_index] Pack FASTA... 0.00 sec
    [bwa_index] Construct BWT for the packed sequence...
    [bwa_index] 0.01 seconds elapse.
    [bwa_index] Update BWT... 0.00 sec
    [bwa_index] Pack forward-only FASTA... 0.00 sec
    [bwa_index] Construct SA from BWT and Occ... 0.01 sec
    [main] Version: 0.7.17-r1188
    [main] CMD: bwa index all_data/refs/NC_045512.2.fa
    [main] Real time: 0.029 sec; CPU: 0.018 sec
    (bioriyaz) (bioriyaz) (bioriyaz) [33m[WARN][0m flag -t (--seq-type) (DNA/RNA) is recommended for computing complement sequences
    (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) [M::bwa_idx_load_from_disk] read 0 ALT contigs
    [M::process] read 32 sequences (31577 bp)...
    [M::mem_process_seqs] Processed 32 reads in 0.031 CPU sec, 0.036 real sec
    [main] Version: 0.7.17-r1188
    [main] CMD: bwa mem all_data/refs/NC_045512.2.fa results/minia57_results/sars.fa
    [main] Real time: 0.037 sec; CPU: 0.035 sec
    (bioriyaz) (bioriyaz) (bioriyaz) 



### Align contigs from spades


```bash
# reverse complement the contigs
cat $SPADES | seqkit seq -p -r > results/spades/sars.spades.fa

SPCONTIG=results/spades/sars.spades.fa

# align the assembled contigs against reference sequence

bwa mem $REF $SPCONTIG | samtools sort > results/alignment_output/spades.bam

samtools index results/alignment_output/spades.bam
```

    (bioriyaz) [33m[WARN][0m flag -t (--seq-type) (DNA/RNA) is recommended for computing complement sequences
    (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) (bioriyaz) [M::bwa_idx_load_from_disk] read 0 ALT contigs
    [M::process] read 39 sequences (35097 bp)...
    [M::mem_process_seqs] Processed 39 reads in 0.023 CPU sec, 0.023 real sec
    [main] Version: 0.7.17-r1188
    [main] CMD: bwa mem all_data/refs/NC_045512.2.fa results/spades/sars.spades.fa
    [main] Real time: 0.024 sec; CPU: 0.026 sec
    (bioriyaz) (bioriyaz) (bioriyaz) 



## View the alignment in IGV

- open IGV and load reference sequence
- then load the mini69.bam file
