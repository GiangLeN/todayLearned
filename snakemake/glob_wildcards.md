# Glob_wildcards

Its possible to use Snakemake to search for patterns.

Some examples:

```
# Extract sample names
SAMPLE = glob_wildcards("{sample}.fastq.gz")
```


Multiple terms

```
(TERM1, TERM2,) = glob_wildcards("{term1}/{term2}.txt")
#or
TERM1, TERM2 = glob_wildcards("{term1}/{term2}.txt")
```

It is possible to use one term for both wildcards

TERMS = glob_wildcards("{term1}/{term2}.txt")

When print both terms will show.
Can view specific term with

```
print(TERMS[0])
print(TERMS[1])
```

