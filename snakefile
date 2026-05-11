#configs
configfile: "config.yaml"

#rules
include: "rules/qc.smk"
include: "rules/assembly.smk"
include: "rules/annotation.smk"
include: "rules/decontamination.smk"
include: "rules/masking.smk"
include: "rules/polish.smk"
include: "rules/rm_haplotigs.smk"
include: "rules/trim_adapters.smk"