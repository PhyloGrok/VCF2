esearch -db sra -query "${2}" | efetch -format docsum | xtract -pattern Runs -ACC @acc  -element "&ACC" > $4/$1/${1}.txt
esearch -db sra -query "${2}" | efetch -format runinfo > $4/$1/assembly/reference/RunInfo.txt
