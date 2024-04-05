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
hisat2  --rg-id=UHR_Rep1 --rg SM:UHR --rg LB:UHR_Rep1_ERCC-Mix1 --rg PL:ILLUMINA --rg PU:CXX1234-ACTGAC.1 -x ../../humanref --dta --rna-strandness RF -1 forward_paired.fq -2 reverse_paired.fq -S alighnment.sam

#samtools
samtools view alighnment.sam -o alighnment.bam
samtools sort alighnment.bam -o alighnment_sorted.bam

#featurecount
featureCounts -p -O -a ../../crch38.gtf -o f_count.txt alighnment_sorted.bam
