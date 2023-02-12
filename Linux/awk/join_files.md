# Some AWK examples

## Checking fasta length from different steps


### Generate fasta1 length
`bioawk -c fastx '{ print $name, length($seq) }' < bincontigs.fasta > bincontig.fasta.length`

### Generate fasta2 length
`bioawk -c fastx '{ print $name, length($seq) }' < 01.mock8_squeezemeta.fasta  > flyecontigs.fasta.length`
 
### Join 2 files based on the the same first column
`awk 'NR==FNR {h[$1] = $2; next} {print $1,$2,h[$1]}' bincontig.fasta.length flyecontigs.fasta.length | awk '$3==""' | sort -k2 -nr`

### Join 2 files, fill in missing with text

File 1
```
MMHP_UM_LCK_1000 0132_done 2
MMHP_UM_LCK_1001 0132_done 2
MMHP-UM-LCK-10 0131_done 2
MMHP_UM_LCK_1002 0132_done 2
MMHP_UM_LCK_1003 0132_done 2
```
File2

```
MMHP_UM_LCK_1000 67
MMHP_UM_LCK_1001 85
MMHP_UM_LCK_1002 70
MMHP_UM_LCK_1003 64
MMHP_UM_LCK_1004 77
```
AWK

`awk 'NR == FNR { key[$1] = $2; next } { $4 = ($1 in key) ? key[$1] : "missing" }; 1' file2 file1`

```
MMHP_UM_LCK_1000 0132_done 2 67
MMHP_UM_LCK_1001 0132_done 2 85
MMHP-UM-LCK-10 0131_done 2 missing
MMHP_UM_LCK_1002 0132_done 2 70
MMHP_UM_LCK_1003 0132_done 2 64
MMHP_UM_LCK_1004 0132_done 2 77
```

***First block:*** Note that file2 is read first and its $2 is stored in key, skip to next line with *next*
***Second block:*** Execute for each line in file1 and check with key.
When found place it on the 4th column.
If not fill in the word *missing* 1

The ***1*** at the end tells awk to output each line with any changes made in second block as is

When reverse the files this is the outcome:
`awk 'NR == FNR { key[$1] = $2; next } { $4 = ($1 in key) ? key[$1] : "missing" }; 1' file1 file2`

```
MMHP_UM_LCK_1000 67  0132_done
MMHP_UM_LCK_1001 85  0132_done
MMHP_UM_LCK_1002 70  0132_done
MMHP_UM_LCK_1003 64  0132_done
MMHP_UM_LCK_1004 77  0132_done
```

Change column position
`awk 'NR == FNR { key[$1] = $2; next } { $2 = ($1 in key) ? key[$1] : "missing" }; 1' file2 file1`

```
MMHP_UM_LCK_1000 67 2
MMHP_UM_LCK_1001 85 2
MMHP-UM-LCK-10 missing 2
MMHP_UM_LCK_1002 70 2
MMHP_UM_LCK_1003 64 2
MMHP_UM_LCK_1004 77 2
```

Change desire column
`awk 'NR == FNR { key[$1] = $1; next } { $4 = ($1 in key) ? key[$1] : "missing" }; 1' file2 file1`

```
MMHP_UM_LCK_1000 0132_done 2 MMHP_UM_LCK_1000
MMHP_UM_LCK_1001 0132_done 2 MMHP_UM_LCK_1001
MMHP-UM-LCK-10 0131_done 2 missing
MMHP_UM_LCK_1002 0132_done 2 MMHP_UM_LCK_1002
MMHP_UM_LCK_1003 0132_done 2 MMHP_UM_LCK_1003
MMHP_UM_LCK_1004 0132_done 2 MMHP_UM_LCK_1004
```


