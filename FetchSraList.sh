#!/bin/bash

echo "Generate a list of filtered SRA runs"

read -p "Enter your TaxID: " txid
#read -p "Enter your filepath (storage_directory/project_directory): " filepath 

echo $txid
#echo $filepath

esearch -db sra -query ""txid$txid"[Orgn] AND "genomic"[Source] AND "paired"[Layout] AND "illumina"[Platform] AND "wgs"[Strategy] AND filetype "fastq"[Filter] AND strategy "genome"[Filter]" | efetch -format docsum | xtract -pattern Runs -ACC @acc -element "&ACC" > SraList.txt
