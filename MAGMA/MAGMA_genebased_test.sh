#!/bin/bash
#PBS -N Magma
#PBS -l mem=12gb,walltime=04:00:00,ncpus=1
#PBS -o ~/OUT_ERR/Magma_genebased.o
#PBS -e ~/OUT_ERR/Magma_genebased.e

module load magma/1.08

dir_out_genebased=${dirN}/output/genebased
mkdir -p ${dir_out_genebased}
#############################################
#Gene based test
#############################################
Eur_ref=~/reference_panel/magma/g1000_eur

magma \
    --bfile $Eur_ref \
    --pval ${GWAS_Pval} N=${N} \
    --gene-annot ${dir_out_annot}/${file}.genes.annot \
    --out ${dir_out_genebased}/${file}
