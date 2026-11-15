#!/bin/bash
#PBS -l mem=8GB,ncpus=1,walltime=01:00:00
#PBS -o ~/TWAS/FUSION/ENDO_polyps/output/log/
#PBS -e ~/TWAS/FUSION/ENDO_polyps/output/log/
#PBS -J 1-9

###########################################
#modules
###########################################
module load R

###########################################
#Variables
###########################################

IFS=' ' read -a VARIABLES <<< $(awk -v line=$PBS_ARRAY_INDEX 'NR==line {print $0}' ${HOME}/TWAS/FUSION/ENDO_polyps/scripts/FUSION_Array_INFO.txt)

#weights downloadable from here https://zenodo.org/records/23008178
sumstats=${HOME}/GWAS/endo_polyps/METAL/output/updated/UKBB_full_FinnGen_R11_MGI_estBB/FUSION_TWAS/FUSION_at_least_two_cohorts_FORMATTED_UKBB_FINNGEN_R11_MGI_EstBB_maf_0.01_info_0.3_hg381.txt
ref_ld_chr=${HOME}/TWAS/FUSION/LDREF/1000G.EUR.

name=${VARIABLES[0]}
weights_dir=${VARIABLES[1]}
weights=${VARIABLES[1]}/${VARIABLES[2]}
dir_out=${HOME}/TWAS/FUSION/ENDO_polyps/output

output_dir=${dir_out}/${name}

mkdir -p ${output_dir}

echo "chr" ${chr} " " ${name} " "${VARIABLES[2]}

##############################################
#Run Fusion
##############################################

Rscript ${HOME}/TWAS/FUSION/fusion_twas-master/FUSION.assoc_test.R \
--sumstats ${sumstats} \
--weights ${weights} \
--weights_dir ${weights_dir} \
--ref_ld_chr ${ref_ld_chr} \
--chr ${chr} \
--out ${output_dir}/chr${chr}_ENDO_${name}_genes.txt
