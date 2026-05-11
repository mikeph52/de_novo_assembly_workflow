rule medaka:
    input:
        fastq = "results/trim_adapters/{sample}_trimmed.fastq.gz",
        fasta  = "results/assembly/flye/{sample}_assembly.fasta",
    output:
        fasta  = "results/polish/medaka/{sample}_polished.fasta", # fix later
    params:
        outdir = "results/{sample}/polish/medaka",
        model  = config["medaka"]["model"],
        extra  = config["medaka"]["extra_args"],
    threads: config["threads"]["medaka"]
    conda:  "../envs/medaka.yaml"
    log:    "logs/medaka.log"
    shell:
        """
        medaka_consensus \
            -i {input.fastq} \
            -d {input.fasta} \
            -o {params.outdir} \
            -t {threads} \
            -m {params.model} \
            {params.extra} \
            2> {log}
        """

        # maybe not
        # probably not