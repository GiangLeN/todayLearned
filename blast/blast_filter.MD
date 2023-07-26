# Convert gfa to fasta
awk '/^S/{print ">"$2;print $3}' sample.gfa > sample.fa

# Create blast database
makeblastdb -in region.fasta  -dbtype nucl

# Align sample to the database
blastn -query .sample.fa -db region.fasta -outfmt 6 -out sample.out -num_threads 15 -evalue 1e-3

# Extract reads longer than 1000 and percentage > 70% extract name 
sort -k1,1 -k11,11g sample.out | sort --merge -u  -k1,1 | awk '$4> 1600 && $3>70' | awk '{print $1}' > contig_names

# extract based on read names
seqkit grep -n -f contig_names sample.fa > rmatched_contigs.fa
