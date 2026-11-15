###############################################
#Qsub
###############################################


#!/bin/bash
#PBS -l ncpus=1
#PBS -l mem=100mb
#PBS -l walltime=1:00:00
#PBS -N regenie
#PBS -e ~/FGT_REGENIE.e
#PBS -o ~/FGT_REGENIE.o

mem=14gb
ncpus=8
walltime=200:00:00

mem2=10gb
ncpus2=8
walltime2=100:00:00

dir_main=${HOME}

#trait
#trait=ENDO_POLYPS
trait=FGT_POLYPS

trait_suffix=${trait}_regenie

#phenotype
#phenoFile=${dir_main}/input/endo_polyps_UKBB_WB.phenotype.merged.women
phenoFile=${dir_main}/input/FGT_polyps_UKBB_WB.phenotype.merged.women

#covariates
#covariates=${dir_main}/input/endo_polyps_UKBB_WB.covariates.merged.women
covariates=${dir_main}/input/FGT_polyps_UKBB_WB.covariates.merged.women

dir=${dir_main}/output/regenie_output/${trait_suffix}
pbs_path=${dir}/log
mkdir -p ${pbs_path}

plinkgrmfile=${HOME}/allchr1_22

qsub -N "`echo ${trait_suffix}`" -v trait=${trait},trait_suffix=${trait_suffix},dir=${dir},pbs_path=${pbs_path},phenoFile=${phenoFile},covariates=${covariates},plinkgrmfile=${plinkgrmfile},ncpus2=${ncpus2},walltime2=${walltime2},mem2=${mem2},ncpus=${ncpus},walltime=${walltime},mem=${mem} -e ${pbs_path}/${trait_suffix}.pbs.err -o ${pbs_path}/${trait_suffix}.pbs.out -l ncpus=${ncpus},walltime=${walltime},mem=${mem} ${HOME}/womens_UKBB_REGENIE_STEP1.sh

################################################################
#Step one, save as a seperate script
################################################################

#!/bin/bash

if [[ 0 -gt 1 ]]
then

#module load regenie/20200803
module load regenie/2.2.4

regenie \
  --step 1 \
  --bed ${plinkgrmfile} \
  --covarFile ${covariates} \
  --covarColList age,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,BINARY_geno_array \
  --phenoFile ${phenoFile} \
  --bsize 1000 \
  --threads 8 \
  --bt \
  --out ${dir}/${trait_suffix}

fi

if [[ 0 -gt 1 ]]
then

for chr in {1..22}
do

   bgenFile=${HOME}/ukb_imp_chr${chr}_v3.bgen
   bgenFileIndex=${HOME}/ukb_imp_chr${chr}_v3.bgen.bgi
   #sampleFile=${HOME}/ukb25331_imp_chr${chr}_v2_s487395.sample
   sampleFile=${HOME}/ukb25331_imp_chr${chr}_v2_s487395.sample
   output_name="${trait_suffix}_$(basename $bgenFile .bgen)"
   qsub_name=${trait:0:6}
   qsub -N "`echo ${qsub_name}_c${chr}`" -v bgenFile=${bgenFile},bgenFileIndex=${bgenFileIndex},chr=${chr},phenoFile=${phenoFile},covariates=${covariates},dir=${dir},sampleFile=${sampleFile},trait_suffix=${trait_suffix},output_name=${output_name},ncpus=${ncpus},walltime=${walltime},mem=${mem} -e ${pbs_path}/${output_name}.pbs.err -o ${pbs_path}/${output_name}.pbs.out -l ncpus=${ncpus2},walltime=${walltime2},mem=${mem2} ${HOME}/womens_UKBB_REGENIE_STEP2.sh;
done

fi

#x chrom
if [[ 2 -gt 1 ]]
then

chr=X
   bgenFile=${HOME}/ukb_imp_chr${chr}_v3.bgen
   bgenFileIndex=${HOME}/ukb_imp_chr${chr}_v3.bgen.bgi
   #sampleFile=${HOME}/ukb25331_imp_chr${chr}_v2_s487395.sample
   sampleFile=${HOME}/ukb25331_imp_chr${chr}_v3_s486743.sample
   output_name="${trait_suffix}_$(basename $bgenFile .bgen)"
   qsub_name=${trait:0:6}
   qsub -N "`echo ${qsub_name}_c${chr}`" -v bgenFile=${bgenFile},bgenFileIndex=${bgenFileIndex},chr=${chr},phenoFile=${phenoFile},covariates=${covariates},dir=${dir},sampleFile=${sampleFile},trait_suffix=${trait_suffix},output_name=${output_name},ncpus=${ncpus},walltime=${walltime},mem=${mem} -e ${pbs_path}/${output_name}.pbs.err -o ${pbs_path}/${output_name}.pbs.out -l ncpus=${ncpus2},walltime=${walltime2},mem=${mem2} ${HOME}/womens_UKBB_REGENIE_STEP2.sh;

fi

##########################################################################
#Step 2, save as seperate script
##########################################################################
#!/bin/bash

module load regenie/2.2.4

regenie \
  --step 2 \
  --bgen ${bgenFile} \
  --sample ${sampleFile} \
  --phenoFile ${phenoFile} \
  --covarFile ${covariates} \
  --covarColList age,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,BINARY_geno_array \
  --bsize 1000 \
  --bt \
  --firth --approx \
  --pThresh 0.05 \
  --threads 8 \
  --pred ${dir}/${trait_suffix}_pred.list \
  --out ${dir}/${trait_suffix}_chr${chr}








