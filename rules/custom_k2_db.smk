rule create_custom_k2db:
    input:
        taxa = "taxa.txt"
    output:
        kraken_db = data