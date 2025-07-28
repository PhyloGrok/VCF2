#!/bin/bash


cd /media/volume/sdc/S25/data/untrimmed_fastq/


for infile in *_1.fastq
	do
 	base=$(basename ${infile} _1.fastq)
	trimmomatic PE ${infile} ${base}_2.fastq /media/volume/sdc/S25/data/trimmed_fastq/${base}_1.trim.fastq /media/volume/sdc/S25/data/trimmed_fastq/${base}_1.untrim.fastq /media/volume/sdc/S25/data/trimmed_fastq/${base}_2.trim.fastq /media/volume/sdc/S25/data/trimmed_fastq/${base}_2.untrim.fastq SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15 
	done

cd /media/volume/sdc/S25/data/trimmed_fastq

fastqc *.trim.fastq*
