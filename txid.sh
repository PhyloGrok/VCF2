read -p "Enter your TaxID: " txid
read -p "Enter your filepath: " filepath 
echo $txid
echo $filepath
datasets download genome taxon $txid --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename /media/volume/$filepath/data/ref_genome/$txid.zip
