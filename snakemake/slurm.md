# Snakemake


## Run on cluster

```
snakemake --snakefile updated_pipe.smk --cluster 'sbatch --cpus-per-task 16 --mem-per-cpu 64 --output=/dev/null -J diagnose_typing' --jobs 100 --latency-wait 90 --use-conda --restart-times 3 -p --keep-going
```
Specify cpu-per-task and mem-per-cpu, the node will be divided.  
eg: if the node has 96, there will be 6 jobs running.  
eg2: If run memory intensive like kraken2, increase the threads to avoid failure due to low memory  4


* ***--output:*** sends text file slurm-xyz to the void. Might have to turn on for error checking  
* ***-J:*** job's name

Test some conda options
