read -p "Enter your TaxID: " txid
read -p "Enter your Project: " 
echo $txid
datasets download genome taxon $txid --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename /media/volume/$txid.zip
