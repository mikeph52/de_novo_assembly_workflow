rule flye_assembly:
    input:
        reads = "results/{sample}/trimmed/reads_filtered.fastq.gz"
    output:
        fasta  = "results/{sample}/assembly/flye/assembly.fasta",
        info   = "results/{sample}/assembly/flye/assembly_info.txt",
        graph  = "results/{sample}/assembly/flye/assembly_graph.gfa",
    params:
        outdir    = "results/{sample}/assembly/flye",
        read_type = config["flye"]["read_type"],
        genome_sz = config["genome_size"],
        extra     = config["flye"]["extra_args"],
    threads: config["threads"]["flye"]
    conda:  "../envs/flye.yaml"
    log:    "logs/{sample}/flye.log"
    benchmark: "benchmarks/{sample}/flye.tsv"
    shell:
        """
        flye \
            {params.read_type} {input.reads} \
            --genome-size {params.genome_sz} \
            --out-dir {params.outdir} \
            --threads {threads} \
            {params.extra} \
            2> {log}
        """
