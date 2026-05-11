import os
configfile: "config/config.yaml"

# samples
SAMPLES = config["samples"]                  # list of sample IDs in config
ASSEMBLER = config.get("assembler", "flye")  # "flye" or "hifiasm"

# rules
include: "rules/trim_adapters.smk"
include: "rules/assembly.smk"
include: "rules/polish.smk"
include: "rules/rm_haplotigs.smk"
include: "rules/decontamination.smk"
include: "rules/masking.smk"
include: "rules/annotation.smk"
include: "rules/qc.smk"

# results
rule all:
    input:
        # QC on raw reads
        expand("results/qc/nanoplot/{sample}_raw/NanoStats.txt",  sample=SAMPLES),

        # Trimmed reads
        expand("results/trim_adapters/{sample}_trimmed.fastq.gz", sample=SAMPLES),

        # QC on trimmed reads
        expand("results/qc/nanoplot/{sample}_trimmed/NanoStats.txt", sample=SAMPLES),

        # Assembly (assembler-agnostic final FASTA)
        expand("results/assembly/{assembler}/{sample}_assembly.fasta",
               assembler=ASSEMBLER, sample=SAMPLES),

        # Polished assembly
        expand("results/polish/medaka/{sample}_polished.fasta", sample=SAMPLES),

        # Purged / haplotig-removed assembly
        expand("results/purge_dups/{sample}_purged.fa", sample=SAMPLES),

        # Decontaminated assembly
        expand("results/decontamination/{sample}_dec.fa", sample=SAMPLES),

        # Repeat-masked assembly
        expand("results/masking/{sample}_masked.fa", sample=SAMPLES),

        # Annotation
        expand("results/annotation/{sample}/{sample}.gff3", sample=SAMPLES),

        # MultiQC summary need to add BUSCO
        #"results/qc/multiqc/multiqc_report.html",
