#!/bin/bash

read -p "Enter your TaxID: " txid
#read -p "Enter your filepath (storage_directory/project_directory): " filepath 
echo $txid

bwa index ~/VCF.project/$txid/data/ref_genome/ncbi_dataset/data/GC*/GC*.fna

for infile in ~/VCF.project/$txid/data/trimmed_fastq/*_1.trim.fastq
	do
	base=$(basename ${infile} _1.trim.fastq)

	bwa mem ~/VCF.project/$txid/data/ref_genome/ncbi_dataset/data/GC*/GC*.fna ~/VCF.project/$txid//data/trimmed_fastq/${base}_1.trim.fastq \
	~/VCF.project/$txid/data/trimmed_fastq/${base}_2.trim.fastq > ~/VCF.project/$txid/results/sam/${base}.aligned.sam

samtools view -S -b ~/VCF.project/$txid/results/sam/${base}.aligned.sam > ~/VCF.project/$txid/results/bam/${base}.aligned.bam

samtools sort -o ~/VCF.project/$txid/results/bam/${base}.aligned.sorted.bam ~/VCF.project/$txid/results/bam/${base}.aligned.bam

samtools flagstat ~/VCF.project/$txid/results/bam/${base}.aligned.sorted.bam 

bcftools mpileup -O b -o ~/VCF.project/$txid/results/bcf/${base}_raw.bcf \
-f ~/VCF.project/$txid/data/ref_genome/ncbi_dataset/data/GC*/GC*.fna ~/VCF.project/$txid/results/bam/${base}.aligned.sorted.bam 

bcftools call --ploidy 1 -m -v -o ~/VCF.project/$txid/results/vcf/${base}_variants.vcf ~/VCF.project/$txid/results/bcf/${base}_raw.bcf 

vcfutils.pl varFilter ~/VCF.project/$txid/results/vcf/${base}_variants.vcf  > ~/VCF.project/$txid/results/${base}_final_variants.vcf
       done
