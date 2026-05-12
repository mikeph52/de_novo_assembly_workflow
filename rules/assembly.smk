rule flye_assembly:
    input:
        fastq = "results/trim_adapters/{sample}_trimmed.fastq.gz"
    output:
        fasta  = "results/assembly/flye/{sample}_assembly.fasta",
        info   = "results/assembly/flye/{sample}_assembly_info.txt",
        graph  = "results/assembly/flye/{sample}_assembly_graph.gfa",
    params:
        outdir = "results/assembly/flye",
        read_type = config["flye"]["read_type"],
        genome_sz = config["genome_size"],
        extra     = config["flye"]["extra_args"],
    threads: config["threads"]["flye"]
    conda: "/envs/assembly.yaml"
    log: "logs/flye.log"
    shell:
        """
        flye \
            {params.read_type} {input.fastq} \
            --genome-size {params.genome_sz} \
            --out-dir {params.outdir} \
            --threads {threads} \
            {params.extra} \
            2> {log}
        """

rule hifiasm_assembly:
    input:
        fastq = "results/trim_adapters/{sample}_trimmed.fastq.gz"
    output:
        fasta  = "results/assembly/hifiasm/{sample}_assembly.fasta",
        info   = "results/assembly/hifiasm/{sample}_assembly_info.txt",
        graph  = "results/assembly/hifiasm/{sample}_assembly_graph.gfa",
    params:
        outdir    = "results/assembly/hifiasm",
        extra     = config["hifiasm"]["extra_args"],
    threads: config["threads"]["hifiasm"]
    conda:  "/envs/assembly.yaml"
    log:    "logs/hifiasm.log"
    shell:
        """
        hifiasm \
            -o {params.outdir}/assembly \
            -t {threads} \
            {params.extra} \
            {input.fastq} \
            2> {log}
        """

