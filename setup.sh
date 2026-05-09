#!/bin/bash

echo "Creating directories: data/ logs/ results/ scripts/..."

mkdir data logs results scripts

echo "Moving setup.sh to scripts/..."

mv setup.sh scripts/

echo "Installing snakemake..."

conda create -n snakemake -c conda-forge -c bioconda snakemake mamba -y

#conda activate snakemake

echo "Process finished"