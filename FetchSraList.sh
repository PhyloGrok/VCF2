#!/bin/bash

echo "Generate a list of filtered SRA runs"

read -p "Enter your TaxID: " txid
#read -p "Enter your filepath (storage_directory/project_directory): " filepath 

echo $txid
#echo $filepath

esearch -db sra -query "Halobacterium salinarum"[orgn] AND ("biomol dna"[Properties] AND "library layout paired"[Properties] AND "platform illumina"[Properties] AND "strategy wgs"[Properties] OR "strategy wga"[Properties] OR "strategy wcs"[Properties] OR "strategy clone"[Properties] OR "strategy finishing"[Properties] OR "strategy validation"[Properties] AND "filetype fastq"[Properties])
"Halobacterium salinarum"[orgn] AND ("biomol dna"[Properties] AND "strategy wgs"[Properties] AND "library layout paired"[Properties] AND "platform illumina"[Properties] AND "strategy wgs"[Properties] OR "strategy wga"[Properties] OR "strategy wcs"[Properties] OR "strategy clone"[Properties] OR "strategy finishing"[Properties] OR "strategy validation"[Properties] AND "filetype fastq"[Properties])


esearch -db sra -query $txid[orgn] | efetch -format docsum | xtract -pattern Runs -ACC @acc  -element "&ACC" > SraList.txt
esearch -db sra -query "$txid" | efetch -format runinfo > RunInfo.txt
