rule purge_haplotigs:
    input:
        fasta  = "results/assembly/flye/{sample}_assembly.fasta",
        fastq = "results/trim_adapters/{sample}_trimmed.fastq.gz",
    output:
        fa = "results/purge_dups/{sample}_purged.fa"
    params:
        outdir = "results/purge_dups",
        extra  = config["purge_dups"]["extra_args"],
    threads: config["threads"]["purge_dups"]
    conda:  "envs/rm_haplotigs.yaml"
    log:    "logs/purge_dups.log"