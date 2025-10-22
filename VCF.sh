#!/bin/bash
read -p "Enter your TaxID:" txid
echo $txid


bwa index ~/VCF.projects/$txid/data/ref_genome/ncbi_dataset/data/GC*/GC*.fna

for infile in ~/VCF.projects/$txid/data/trimmed_fastq/*_1.trim.fastq
	do
	base=$(basename ${infile} _1.trim.fastq)
	echo ${base}
	bwa mem ~/VCF.projects/$txid/data/ref_genome/ncbi_dataset/data/GC*/GC*.fna \
	~/VCF.projects/$txid/data/trimmed_fastq/${base}_1.trim.fastq \
	~/VCF.projects/$txid/data/trimmed_fastq/${base}_2.trim.fastq > ~/VCF.projects/$txid/results/sam/${base}.aligned.sam

	samtools view -S -b ~/VCF.projects/$txid/results/sam/${base}.aligned.sam > ~/VCF.projects/$txid/results/bam/${base}.aligned.bam

	samtools sort -o ~/VCF.projects/$txid/results/bam/${base}.aligned.sorted.bam ~/VCF.projects/$txid/results/bam/${base}.aligned.bam

	samtools flagstat ~/VCF.projects/$txid/results/bam/${base}.aligned.sorted.bam

	bcftools mpileup -O b -o ~/VCF.projects/$txid/results/bcf/${base}_raw.bcf \
	-f ~/VCF.projects/$txid/data/ref_genome/ncbi_dataset/data/GC*/GC*.fna ~/VCF.projects/$txid/results/bam/${base}.aligned.sorted.bam

	bcftools call --ploidy 1 -m -v -o ~/VCF.projects/$txid/results/vcf/${base}_variants.vcf ~/VCF.projects/$txid/results/bcf/${base}_raw.bcf

	vcfutils.pl varFilter ~/VCF.projects/$txid/results/vcf/${base}_variants.vcf > ~/VCF.projects/$txid/results/vcf/${base}_final_variants.vcf
	done
