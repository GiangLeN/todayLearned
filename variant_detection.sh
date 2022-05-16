#!/bin/bash


for i in E*; do
	trim_galore --paired --length 100 ./${i}/${i}_1.fastq.gz ./${i}/${i}_2.fastq.gz
	dedupe.sh in=./${i}_1_val_1.fq.gz,./${i}_2_val_2.fq.gz out=./${i}/${i}_dedup.fq.gz minidentity=99
	rm ${i}*.gz ${i}*.txt

	## Assuming pairlen is correct
	bbmap.sh ref=./23S_NC_000117.1-2_878039-880902_CT_TRIMMED.txt in=./${i}/${i}_dedup.fq.gz out=./${i}/${i}.bam pairlen=500  bs=bs.sh; sh bs.sh
	picard MarkDuplicates I=./${i}/${i}_sorted.bam O=./${i}/${i}_single.bam REMOVE_DUPLICATES=true M=metric.txt

	#http://clavius.bc.edu/~erik/CSHL-advanced-sequencing/freebayes-tutorial.html
	freebayes -f ./23S_NC_000117.1-2_878039-880902_CT_TRIMMED.txt ./${i}/${i}_single.bam > ./${i}/${i}_variant.vcf
done











