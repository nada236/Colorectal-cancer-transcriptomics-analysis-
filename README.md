# Colorectal-cancer-transcriptomics-analysis-
RNA seq analysis for Colorectal Cancer data under The accession number GSE156451 
1.	Data extraction from NCBI GEO database under the accession number 
2.	Quality check with fastqc 
3.	Adapter trimming with cutadapt
4.	Low quality data trimming with trimmomatic
5.	Re-check the sequence quality with fastqc
6.	Ref genome indexing with splice sites and exons from GTF file
7.	Alignment with hisat2 
8.	Convert Sam to bam and indexing it with samtools
9.	Feature count for healthy and tumor samples 
10.	CSV file preprocessing 
11.	Deseq2 for differential gene expression analysis
