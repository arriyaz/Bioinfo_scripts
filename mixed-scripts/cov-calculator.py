#!/usr/bin/env python

# Thank you Preonath Shuvo.

#Ask for input

readsnumber = int(input('Please insert the number of reads (in bp): '))

length = int(input('What is the length of the Reads (in bp): '))

endtype = int(input('Insert 1 for single-end and 2 for paired-end: '))

genomesize = int(input('What is the genome size (in bp): '))


# code 
coverage = int((length * readsnumber * endtype) / genomesize)

coverage = str(coverage)+"x"

print("\n")

print("The coverage of your data is:", coverage)


print ("Thank you")

