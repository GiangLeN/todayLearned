# Snakemake


## Run on cluster

```
snakemake --snakefile updated_pipe.smk --cluster 'sbatch --cpus-per-task 16 --mem-per-cpu 64 --output=/dev/null -J diagnose_typing' --jobs 100 --latency-wait 90 --use-conda --restart-times 3 -p --keep-going"
```
Specify cpu-per-task and mem-per-cpu, the node will be divided.
--output sends text file slurm-xyz to the void. Might have to turn on for error checking
-J job discription
