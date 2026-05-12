# NEEDS UPDATE, DO NOT RUN!!!!
import os
configfile: "config/config.yaml"

# samples
SAMPLES = config["samples"]                  # list of sample IDs in config
ASSEMBLER = config.get("assembler", "flye")  # "flye" or "hifiasm"
# NEEDS UPDATE, DO NOT RUN!!!!
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
# NEEDS UPDATE, DO NOT RUN!!!!
rule all:
    input:
        expand("results/qc/nanoplot/{sample}_raw/NanoStats.txt", sample=SAMPLES),

        expand("results/trim_adapters/{sample}_trimmed.fastq.gz", sample=SAMPLES),

        expand("results/qc/nanoplot/{sample}_trimmed/NanoStats.txt", sample=SAMPLES),
        
        expand("results/assembly/{assembler}/{sample}_assembly.fasta", assembler=ASSEMBLER, sample=SAMPLES),

        expand("results/polish/medaka/{sample}_polished.fasta", sample=SAMPLES),

        expand("results/purge_dups/{sample}_purged.fa", sample=SAMPLES),

        expand("results/decontamination/{sample}_dec.fa", sample=SAMPLES),

        expand("results/masking/{sample}_masked.fa", sample=SAMPLES),

        expand("results/annotation/{sample}/{sample}.gff3", sample=SAMPLES),

        # MultiQC summary need to add BUSCO
        #"results/qc/multiqc/multiqc_report.html",
        # NEEDS UPDATE, DO NOT RUN!!!!
# DO NOT RUN!!!!
# DO NOT RUN!!!!
# DO NOT RUN!!!!
# DO NOT RUN!!!!
# DO NOT RUN!!!!
# DO NOT RUN!!!!
# DO NOT RUN!!!!
# DO NOT RUN!!!!
# DO NOT RUN!!!!