#!/bin/bash

set -euo pipefail

echo "-------------------------------------"
echo "|De novo assembly snakemake workflow|"
echo "|         by mikeph52, 2026         |"
echo "-------------------------------------"
echo "          Debloater                  "

echo "Do you want to reset the project?"
echo ""
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo ""
echo " The following changes will happen: "
echo " - Remove directories: data/ logs/ results/ "
echo " - Move setup.sh and reset.sh to parent directory(Currently not working)"
echo ""
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

cd ..

rm -rf data/ logs/ results/ 

PROJECT=$(cat scripts/.setup.env)

cd ..
mv "$PROJECT" de_novo_genome_assembly

echo "Process finished"