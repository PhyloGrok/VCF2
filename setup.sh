#!/bin/bash

mkdir -m777 /media/volume/sdc/S25
mkdir -m777 /media/volume/sdc/S25/data
mkdir -m777 /media/volume/sdc/S25/data/ref_genome
mkdir -m777 /media/volume/sdc/S25/data/untrimmed_fastq
mkdir -m777 /media/volume/sdc/S25/data/trimmed_fastq
mkdir -m777 /media/volume/sdc/S25/results
mkdir -m777 /media/volume/sdc/S25/results/sam
mkdir -m777 /media/volume/sdc/S25/results/bam
mkdir -m777 /media/volume/sdc/S25/results/bcf
mkdir -m777 /media/volume/sdc/S25/results/vcf

cd /media/volume/sdc/S25/data/untrimmed_fastq

prefetch --option-file /home/exouser/Rachel_Hv.txt
fasterq-dump SRR*
