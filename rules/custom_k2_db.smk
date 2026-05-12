rule create_custom_k2db:
    input:
        taxa = "data/taxa.txt"
    output:
        kraken_db = "data/kraken_db/*"
    params:
        outdir = "data/kraken_db"
    threads: config["threads"]["kraken2"]
    conda: "/envs/decontamination.yaml"
    log: "logs/kraken2.log"
    shell:
        """
        while read -r taxaname; do
            mkdir -p {params.outdir}/"$taxaname"

            datasets download genome taxon "$taxaname" --reference \
                --dehydrated --filename {params.outdir}/"$taxaname"/"$taxaname".zip --no-progressbar
            unzip -o {params.outdir}/"$taxaname"/"$taxaname".zip -d {params.outdir}/"$taxaname"

            datasets rehydrate --directory {params.outdir}/"$taxaname" --no-progressbar
        done < {input.taxa}

        for fna in {params.outdir}/**/*.fna; do
            [ -f "$fna" ] || continue
            echo "  Adding: $fna"
            kraken2-build --add-to-library "$fna" --db {params.outdir} --threads {threads}
        done

        kraken2-build --download-taxonomy --db {params.outdir} --use-ftp

        kraken2-build --build --db {params.outdir} --threads {threads}

        kraken2-build --clean --db {params.outdir}

        """