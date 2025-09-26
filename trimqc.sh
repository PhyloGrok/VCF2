#!/bin/bash
## User enters txid
read -p "Enter your TaxID: " txid
#cd /media/volume/sdc/S25/data/untrimmed_fastq/
echo $txid

for infile in ~/VCF.projects/$txid/data/untrimmed_fastq/*_1.fastq
	do
 	base=$(basename ${infile} _1.fastq)
	trimmomatic PE ${infile} ${base}_2.fastq ~/VCF.projects/$txid/data/trimmed_fastq/${base}_1.trim.fastq ~/VCF.projects/$txid/data/trimmed_fastq/${base}_1.untrim.fastq ~/VCF.projects/$txid/data/trimmed_fastq/${base}_2.trim.fastq ~/VCF.projects/$txid/data/trimmed_fastq/${base}_2.untrim.fastq SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15 
	done

#cd /media/volume/sdc/S25/data/trimmed_fastq

fastqc ~/VCF.projects/$txid/data/trimmed_fastq/*.trim.fastq*
