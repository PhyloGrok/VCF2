#!/bin/bash

#cp /home/exouser/NexteraPE-PE.fa /media/volume/sdb/S25/untrimmed_fastq/

cd /media/volume/sdb/S25/data/untrimmed_fastq/

for infile in *_1.fastq
	do
 	base=$(basename ${infile} _1.fastq)
	trimmomatic PE ${infile} ${base}_2.fastq /media/volume/sdb/S25/data/trimmed_fastq/${base}_1.trim.fastq \
	/media/volume/sdb/S25/data/trimmed_fastq/${base}_1.untrim.fastq /media/volume/sdb/S25/data/trimmed_fastq/${base}_2.trim.fastq \
	/media/volume/sdb/S25/data/trimmed_fastq/${base}_2.untrim.fastq \
	SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15 
	done

#fastqc /media/volume/sdb/S25/data/trimmed_fastq/*.trim.fastq
