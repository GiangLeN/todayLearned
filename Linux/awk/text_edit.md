
## Change line to 2 columns

Example:
`
for i in {1..10}; do echo line$i; done
`

```
line1
line2
line3
line4
line5
line6
line7
line8
line9
line10
```

### Merge second line 

Turn line to 2 columns

`for i in {1..10}; do echo line$i; done | awk '{ printf "%s ", $0; getline; print $0; next } 1'`

```
line1 line2
line3 line4
line5 line6
line7 line8
line9 line10
```

Statement ***printf "%s ", $0*** prints the line without a newline character followed by a space.
The ***getline*** function reads the next line of input into the current line, effectively merging the two lines.

### Odd line

`for i in {1..9}; do echo line$i; done | awk '{ printf "%s ", $0; getline; print $0; next } 1'`

The last value is repeated

```
line1 line2
line3 line4
line5 line6
line7 line8
line9 line9
```
## Line with values

`for i in {1..10}; do echo line $i; done | awk '{ printf "%s ", $0; getline; print $0; next } 1'`

```
line 1 line 2
line 3 line 4
line 5 line 6
line 7 line 8
line 9 line 10
```

`for i in {1..10}; do echo line $i; done | awk '{ printf "%s ", $1; getline; print $0; next } 1'`

```
line line 2
line line 4
line line 6
line line 8
line line 10
```

This only print the $1 from first line to join with the full second line.
Similarly effect for the newly merged line.

` for i in {1..10}; do echo line $i; done | awk '{ printf "%s ", $0; getline; print $1; next } 1'`

```
line 1 line
line 3 line
line 5 line
line 7 line
line 9 line
```

