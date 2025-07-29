#!/bin/bash

echo "Generate a list of filtered SRA runs"

read -p "Enter your TaxID: " txid
#read -p "Enter your filepath (storage_directory/project_directory): " filepath 

echo $txid
#echo $filepath

esearch -db sra -query "$txid" | efetch -format docsum | xtract -pattern Runs -ACC @acc  -element "&ACC" > SraList.txt
esearch -db sra -query "$txid" | efetch -format runinfo > RunInfo.txt
