# Checking fasta length from different steps

# Generate fasta1 length
bioawk -c fastx '{ print $name, length($seq) }' < bincontigs.fasta > bincontig.fasta.length

# Generate fasta2 length
bioawk -c fastx '{ print $name, length($seq) }' < 01.mock8_squeezemeta.fasta  > flyecontigs.fasta.length
 
# Join 2 files based on the the same first column
# Missing value is blank ($3)
# Sort by column 2, number
awk 'NR==FNR {h[$1] = $2; next} {print $1,$2,h[$1]}' bincontig.fasta.length flyecontigs.fasta.length | awk '$3==""' | sort -k2 -nr
