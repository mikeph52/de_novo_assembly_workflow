rule decontamination:
    input:
        fa = "results/purge_dups/{sample}_purged.fa"
        db = "data/kraken2/" #not created, just default dir
    output:
        dec_fa = fa = "results/decontamination/{sample}_dec.fa"
    params:
        outdir = "results/decontamination",
        extra = config["kraken2"]["extra_args"]
        confidence = "0.1" # 0.1 for low conf, 0.2-0.5 for better results
    threads: config["threads"]["kraken2"]
    conda: "envs/decontamination.yaml"
    log: "logs/decontamination.log"
    shell:
        """
        kraken2 \
            --db {input.db} \
            --threads {threads} \
            --confidence {params.confidence}\
            --output {params.outdir}/kraken2.output \
            --report {params.outdir}/kraken2.report \
            --unclassified-out {input.fa}
        """