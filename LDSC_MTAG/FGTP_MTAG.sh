
#!/bin/bash
#PBS -l ncpus=8
#PBS -l mem=64gb
#PBS -l walltime=100:00:00
#PBS -N MTAG_3
#PBS -e ~/MTAG/output/log2.e
#PBS -o ~/MTAG/output/log2.o

echo "MTAG started"

module load python/2.7.10

#results folder
dirI=~/MTAG/output

#trait suffix
trait_suffix=MTAG_FGTP_v_noFGTP

#Results folder
dirN=${dirI}/${trait_suffix}
mkdir -p ${dirN}

#paths to mtag input files traits
if [[ 2 -gt 1 ]]
then
T1=~/MTAG/input/mtag_at_least_two_cohorts_FORMATTED_UKBB_FINNGEN_R11_MGI_EstBB_maf_0.01_info_0.3_hg381_tab_.txt
#OCAC
T2=~/MTAG/input/B38_OCAC_MTAG_clmns_tab.txt
#ECAC
T3=~/MTAG/input/B38_ECAC_nBBJ_clms_h_tab_0.01_0.99_2.txt
#PCOS
T4=~/MTAG/input/PCOS_7_7_17_h_tab.txt
#UF
T5=~/MTAG/input/B38_UF_MTAG_clmns_tab.txt
#ENDO
T6=~/MTAG/input/ENDO_B38_updated_z_3_0.01_0.99_h_tab.txt
#BCAC
T7=~/MTAG/input/BCAC_B38_updated_0.01_0.99_clms_headers_tab.txt
#GIP
T8=~/MTAG/input/GIP_MTAG_noUND_0.01_0.99_h_tab_ndup.txt
fi

#run MTAG
if [[ 2 -gt 1 ]]
then

python /software/mtag/mtag-20190826/mtag.py \
                --sumstats ${T3},${T2},${T5},${T6} \
                --out ${dirN}/${trait_suffix} \
                --cores 8 \
                --n_min 0.0 \



fi
