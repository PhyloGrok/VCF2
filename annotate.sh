#!/bin/bash

datasets download genome taxon $3 --reference --include genome,rna,protein,cds,gff3,gtf,gbff,seq-report --filename $4/$1/assembly/${3}.zip
