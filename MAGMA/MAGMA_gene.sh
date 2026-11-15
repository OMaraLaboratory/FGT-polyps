
#!/bin/bash
#PBS -N Magma
#PBS -l mem=2gb,walltime=01:00:00,ncpus=1
#PBS -o ~/OUT_ERR/Magma_annot.o
#PBS -e ~/OUT_ERR/Magma_annot.e

module load magma/1.08

gene_loc_38=~/reference_panel/magma/NCBI38.gene.loc
#gene_loc_37=~/reference_panel/magma/NCBI37.3.gene.loc
dir_out_annot=${dirN}/output/annot
mkdir -p ${dir_out_annot}

############################################
#SNP annotation
############################################
if [[ 3 -gt 2 ]]
then
magma --annotate \
      --snp-loc ${GWAS_pos} \
      --gene-loc ${gene_loc_38} \
      --out ${dir_out_annot}/${file}
fi

############################################
#gene-based test
############################################
if [[ 3 -gt 2 ]]
then
qsub -v GWAS_pos=${GWAS_pos},GWAS_Pval=${GWAS_Pval},dirN=${dirN},dir_out_annot=${dir_out_annot},N=${N},file=${file} ~/Scripts/MAGMA/magma_genebased.sh
fi

