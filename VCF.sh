#!/bin/bash

bwa index /media/volume/sdb/S25/data/ref_genome/GCA_004799605.1_ASM479960v1_genomic.fna

for infile in /media/volume/sdb/S25/data/trimmed_fastq/*_1.trim.fastq
	do
base=$(basename ${infile} _1.trim.fastq)

bwa mem /media/volume/sdb/S25/data/ref_genome/GCA_004799605.1_ASM479960v1_genomic.fna /media/volume/sdb/S25/data/trimmed_fastq/${base}_1.trim.fastq \
/media/volume/sdb/S25/data/trimmed_fastq/${base}_2.trim.fastq > /media/volume/sdb/S25/results/sam/${base}.aligned.sam

samtools view -S -b /media/volume/sdb/S25/results/sam/${base}.aligned.sam > /media/volume/sdb/S25/results/bam/${base}.aligned.bam

samtools sort -o /media/volume/sdb/S25/results/bam/${base}.aligned.sorted.bam /media/volume/sdb/S25/results/bam/${base}.aligned.bam

samtools flagstat /media/volume/sdb/S25/results/bam/${base}.aligned.sorted.bam 

bcftools mpileup -O b -o /media/volume/sdb/S25/results/bcf/${base}_raw.bcf \
-f /media/volume/sdb/S25/data/ref_genome/GCA_004799605.1_ASM479960v1_genomic.fna /media/volume/sdb/S25/results/bam/${base}.aligned.sorted.bam 

bcftools call --ploidy 1 -m -v -o /media/volume/sdb/S25/results/vcf/${base}_variants.vcf /media/volume/sdb/S25/results/bcf/${base}_raw.bcf 

vcfutils.pl varFilter /media/volume/sdb/S25/results/vcf/${base}_variants.vcf  > /media/volume/sdb/S25/results/vcf/${base}_final_variants.vcf
       done
