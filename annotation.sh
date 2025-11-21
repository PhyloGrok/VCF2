#!/bin/bash
#RChan
set -euo pipefail
read -rp "Enter your TaxID: " txid 
echo "TaxID: $txid" 

BASE="$HOME/VCF.projects/$txid" 
REFDIR="$BASE/data/ref_genome"
RESULTPATH="$BASE/results" 
RESPATH="$BASE/data/resources"
SNPEFF_PATH="$RESPATH/SnpEff" 

mkdir -m 777 -p "$RESPATH" "$SNPEFF_PATH"

REFPATH=$(find "$REFDIR" -maxdepth 1 -type d -name "GCF*" | head -n 1) 

if [[ -z "${REFPATH:-}" ]]; then
  echo "ERROR: No GCF* directory found in $REFDIR" >&2
  exit 1 
fi 

REFNAME=$(basename "$REFPATH")
echo "Reference folder: $REFPATH"
echo "Reference name: $REFNAME" 

SNPEFFDIR=$(dirname "$(readlink -f "$(which snpEff)")")

cp "$SNPEFFDIR/snpEff.config" "$SNPEFF_PATH/snpEff.config"

echo "${REFNAME}.genome : ${REFNAME}" >>"$SNPEFF_PATH/snpEff.config"

mkdir -p "$SNPEFF_PATH/data/$REFNAME" 

cp "$REFPATH"/GCF_*_genomic.fna "$SNPEFF_PATH/data/$REFNAME/sequences.fa" 
cp "$REFPATH"/genomic.gtf "$SNPEFF_PATH/data/$REFNAME/genes.gtf" 
cp "$REFPATH"/protein.faa "$SNPEFF_PATH/data/$REFNAME/protein.fa" 
cp "$REFPATH"/genomic.gff "$SNPEFF_PATH/data/$REFNAME/genes.gff" 
cp "$REFPATH"/cds_from_genomic.fna "$SNPEFF_PATH/data/$REFNAME/cds.fa" 

snpEff build -Xmx4g -noCheckCds -noCheckProtein -gff3 \
 -c "$SNPEFF_PATH/snpEff.config" -v "$REFNAME" 

echo "snpEff build completed for $REFNAME" 
echo "Config used: $SNPEFF_PATH/snpEff.config" 
echo "Data dir: $SNPEFF_PATH/data/$REFNAME" 
echo "Results dir: $RESULTPATH"
