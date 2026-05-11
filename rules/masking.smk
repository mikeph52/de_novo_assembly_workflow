rule repeat_masking:
    input:
        fa = "results/decontamination/{sample}_dec.fa",
    output:
        masked_fa = "results/masking/{sample}_masked.fa",
        out       = "results/masking/{sample}_masked.fa.out",
        tbl       = "results/masking/{sample}_masked.fa.tbl",
    params:
        outdir = "results/masking",
        species = config["repeatmasker"].get("species", ""),
        lib = config["repeatmasker"].get("custom_lib", ""),
        extra = config["repeatmasker"].get("extra_args", ""),
    threads: config["threads"]["repeatmasker"]
    conda: "envs/masking.yaml"
    log: "logs/masking/{sample}.log"
    shell:
        """
        if [ -n "{params.lib}" ]; then
            LIB_ARG="-lib {params.lib}"
        else
            LIB_ARG="-species {params.species}"
        fi

        RepeatMasker -xsmall $LIB_ARG -pa {threads} -dir {params.outdir} \
            {params.extra} \
            {input.fa} \
            2> {log}

        mv {params.outdir}/$(basename {input.fa}).masked {output.masked_fa}
        mv {params.outdir}/$(basename {input.fa}).out {output.out}
        mv {params.outdir}/$(basename {input.fa}).tbl {output.tbl}
        """