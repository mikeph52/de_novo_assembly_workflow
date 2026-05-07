#!/bin/bash

echo "Creating directories: data/ logs/ results/ scripts/..."

mkdir data logs results scripts

echo "Moving setup.sh to scripts/..."

mv setup.sh scripts/

echo "Process finished"