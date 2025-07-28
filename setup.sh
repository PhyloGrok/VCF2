#!/bin/bash

read -p "Enter your TaxID: " txid
read -p "Enter your filepath: " filepath 
echo $txid
echo $filepath

mkdir -m777 /media/volume/$filepath/
mkdir -m777 /media/volume/$filepath/data
mkdir -m777 /media/volume/$filepath/data/ref_genome
mkdir -m777 /media/volume/$filepath/data/untrimmed_fastq
mkdir -m777 /media/volume/$filepath/data/trimmed_fastq
mkdir -m777 /media/volume/$filepath/results
mkdir -m777 /media/volume/$filepath/results/sam
mkdir -m777 /media/volume/$filepath/results/bam
mkdir -m777 /media/volume/$filepath/results/bcf
mkdir -m777 /media/volume/$filepath/results/vcf


datasets download genome taxon $txid --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename /media/volume/$filepath/data/ref_genome/$txid.zip

cd /media/volume/sdc/S25/data/untrimmed_fastq

prefetch --option-file /home/exouser/Rachel_Hv.txt
fasterq-dump SRR*
