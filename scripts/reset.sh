#!/bin/bash

set -euo pipefail

echo "-------------------------------------"
echo "|De novo assembly snakemake workflow|"
echo "|         by mikeph52, 2026         |"
echo "-------------------------------------"
echo "          Uninstaller                "

echo "Do you want to reset the project?"
echo ""
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo ""
echo " The following changes will happen: "
echo " - Remove directories: data/ logs/ results/ "
echo " - Move setup.sh and reset.sh to parent directory"
echo " - Remove snakemake conda env."
echo ""
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# scripts/ --> parent
cd ..

rm -rf data/ logs/ results/ 

PROJECT=$(cat scripts/.setup.env)
# parent --> prev
cd ..
mv "$PROJECT" de_novo_genome_assembly_workflow

conda env remove -n snakemake

echo "Process finished"