#!/bin/bash

#fastqc
fastqc $1 $2  


#cutadapt
cutadapt     -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA     -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT     -o trimmed.R1.fastq -p trimmed.R2.fastq  $1 $2


#trimming
java -jar ../../Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 trimmed.R1.fastq trimmed.R2.fastq forward_paired.fq forward_unpaired.fq reverse_paired.fq reverse_unpaired.fq  MINLEN:36 SLIDINGWINDOW:4:20
 


#fastqc the trimmed data 
fastqc forward_paired.fq reverse_paired.fq



#alignment
hisat2 --phred33 --rna-strandness RF --known-splicesite-infile ../../splice_sites.txt -x ../../refindex -1 forward_paired.fq -2 reverse_paired.fq > align.sam

#samtools
samtools view align.sam -o align.bam
samtools sort align.bam -o align.sorted.bam

