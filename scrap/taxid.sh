#!/bin/bash

read -p "Enter your TaxID:" txid

echo $txid 

datasets download genome taxon $txid --reference --include genome,rna,protein,cds,gff3,gbff,seq-report --filename $txid.zip
