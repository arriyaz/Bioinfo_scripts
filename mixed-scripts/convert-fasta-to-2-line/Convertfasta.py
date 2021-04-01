from Bio import SeqIO
import os
import re
import argparse

def multi2linefasta(indir,outdir,filelist):
    for items in filelist:
        mfasta = outdir +"/"+re.sub('\..*','',items)+'_twoline.fasta'
        ifile = open(indir+'/'+items,'rU')
        with open(mfasta, 'w') as ofile:
            for record in SeqIO.parse(ifile, "fasta"):
                sequence = str(record.seq)
                ofile.write('>'+record.id+'\n'+sequence+'\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Convert multiple files of multi-line fasta into two-line fasta format')
    parser.add_argument('-i',type=str,dest='ind',required=True,help="Input directory where all the fasta files are present")
    parser.add_argument('-o',type=str,dest='outd',required=True,help="Ouput directory")
    parser.add_argument('-f',type=str,dest='ffiles',required=True,help="Comma seperated fasta file names without spaces")
    args = parser.parse_args()
    print (args)
    filelist = args.ffiles.split(',')
    if not os.path.exists(args.outd):
        os.makedirs(args.outd)
    multi2linefasta(args.ind,args.outd,filelist)
