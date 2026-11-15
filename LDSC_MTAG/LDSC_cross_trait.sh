################################################################################
# cross-trait_rg.sh
################################################################################
#!/bin/bash
#PBS -l mem=10gb
#PBS -l walltime=10:00:00,ncpus=2
#PBS -N LDSC_rg
#PBS -e ~/LDSC/OUT_ERR/LDSC_rg.e
#PBS -o ~/LDSC/OUT_ERR/LDSC_rg.o


module load ldsc/20190815

dirFGTP=~/LDSC/input/endo_polyps
dirOCAC=~/LDSC/input/OCAC
dirECAC=~/LDSC/input/endo_canc
dirPCOS=~/LDSC/input/PCOS
#dirUF=~/LDSC/uter_fib
dirUF=~/GWAS/Uterine_fibroids/Sliz
dirENDO=~/LDSC/input/ENDO
dirBCAC=~/LDSC/input/brea_canc
#dirCCAC=~/LDSC/input/cervical
dirCCAC=~/GWAS/cervical/Koel_23/sent_by_trin

dirGIP=~/LDSC/input/GI_polyps
dirECACnoUKBB=~/LDSC/input/ECAC_2018_noUKBB
dirObesity=~/publication/obesity_ec/genomicSEM/commonfactor
dirBMI=~/GWAS/BMI/Loic_Yengo_GIANT_UKBB/
#output dir
dirMTAG=~/MTAG/endo_polyps/input
dirR=~/LDSC/FGT_polyps/output_cross_trait/with_Triins_CC_GWAS

fileFGTP=LDSC_at_least_two_cohorts_FORMATTED_UKBB_FINNGEN_R11_MGI_EstBB_maf_0.01_info_0.3_hg381.txt
fileOCAC=OCAC_rel_clms_3.txt
fileECAC=ECAC_noBBJ_LDSC_7_h_s.txt
filePCOS=PCOS_rel_colmns.txt
#fileUF=uter_fib_rel_colmns.txt
fileUF=LDSC_GCST90239856_buildGRCh38.tsv
fileENDO=ENDO_rel_colmns_nd.txt
fileBCAC=BCAC_overall_GWAS_summary_10.txt
#fileCCAC=cerv_canc_clmns_4.txt
fileCCAC=LDSC_Koel_et_al_2023_cervical_cancer_EUR.txt
fileGIP=GI_polyps_head_tab_rd.txt
fileECACnoUKBB=ECAC_noUKBB_h_clms_n_2.txt
#fileObesity=Female_Obesity.sumstats.gz
fileBMI=clean_MTAG_loic_BMI_7_mill_SNPs_MAF_0.01.txt
fileMTAG=LDSC_MTAG_FGTP_v5.1_trait_1.txt

#####################################
#Binary
#####################################


#
#sample-prev
#pop-prev

if [[ 2 -gt 1 ]]
then
ldsc.py \
  --rg ${dirFGTP}/${fileFGTP}.munge.sumstats.gz,${dirECAC}/${fileECAC}.munge.sumstats.gz,${dirOCAC}/${fileOCAC}.munge.sumstats.gz,${dirCCAC}/${fileCCAC}.munge.sumstats.gz,${dirENDO}/${fileENDO}.munge.sumstats.gz,${dirUF}/${fileUF}.munge.sumstats.gz,${dirPCOS}/${filePCOS}.munge.sumstats.gz,${dirBCAC}/${fileBCAC}.munge.sumstats.gz,${dirGIP}/${fileGIP}.munge.sumstats.gz,${dirBMI}/${fileBMI}.munge.sumstats.gz \
  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --samp-prev 0.09,0.085,0.38,0.015,0.079,0.12,0.09,0.53,0.23,nan \
  --pop-prev 0.2,0.0034,0.001,0.0015,0.01,0.2,0.1,0.05,0.25,nan \
  --out ${dirR}/LDSC_ECAC_OCAC_ENDO_UF_PCOS_CCAC_FGTP_BCAC_GIP_BMI

fi


if [[ 2 -gt 1 ]]
then
ldsc.py \
  --rg ${dirECAC}/${fileECAC}.munge.sumstats.gz,${dirOCAC}/${fileOCAC}.munge.sumstats.gz,${dirCCAC}/${fileCCAC}.munge.sumstats.gz,${dirENDO}/${fileENDO}.munge.sumstats.gz,${dirUF}/${fileUF}.munge.sumstats.gz,${dirPCOS}/${filePCOS}.munge.sumstats.gz \
  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --samp-prev 0.085,0.38,0.015,0.079,0.12,0.09 \
  --pop-prev 0.0034,0.001,0.0015,0.01,0.2,0.1 \
  --out ${dirR}/LDSC_ECAC_OCAC_ENDO_UF_PCOS_CCAC

fi


if [[ 2 -gt 1 ]]
then
ldsc.py \
  --rg ${dirOCAC}/${fileOCAC}.munge.sumstats.gz,${dirCCAC}/${fileCCAC}.munge.sumstats.gz,${dirENDO}/${fileENDO}.munge.sumstats.gz,${dirUF}/${fileUF}.munge.sumstats.gz,${dirPCOS}/${filePCOS}.munge.sumstats.gz \
  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --samp-prev 0.38,0.015,0.079,0.12,0.09 \
  --pop-prev 0.001,0.0015,0.01,0.2,0.1 \
  --out ${dirR}/LDSC_OCAC_ENDO_UF_PCOS_CCAC

fi


if [[ 2 -gt 1 ]]
then
ldsc.py \
  --rg ${dirCCAC}/${fileCCAC}.munge.sumstats.gz,${dirENDO}/${fileENDO}.munge.sumstats.gz,${dirUF}/${fileUF}.munge.sumstats.gz,${dirPCOS}/${filePCOS}.munge.sumstats.gz \
  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --samp-prev 0.015,0.079,0.12,0.09 \
  --pop-prev 0.0015,0.01,0.2,0.1 \
  --out ${dirR}/LDSC_ENDO_UF_PCOS_CCAC

fi


if [[ 2 -gt 1 ]]
then
ldsc.py \
  --rg ${dirENDO}/${fileENDO}.munge.sumstats.gz,${dirUF}/${fileUF}.munge.sumstats.gz,${dirPCOS}/${filePCOS}.munge.sumstats.gz \
  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --samp-prev 0.079,0.12,0.09 \
  --pop-prev 0.01,0.2,0.1 \
  --out ${dirR}/LDSC_ENDO_UF_PCOS

fi

if [[ 2 -gt 1 ]]
then
ldsc.py \
  --rg ${dirUF}/${fileUF}.munge.sumstats.gz,${dirPCOS}/${filePCOS}.munge.sumstats.gz \
  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --samp-prev 0.12,0.09 \
  --pop-prev 0.2,0.1 \
  --out ${dirR}/LDSC_UF_PCOS

fi


#############################################################
#run analysis again including MTAG results
#############################################################


if [[ 2 -gt 1 ]]
then
ldsc.py \
  --rg ${dirMTAG}/${fileMTAG}.munge.sumstats.gz,${dirFGTP}/${fileFGTP}.munge.sumstats.gz,${dirECAC}/${fileECAC}.munge.sumstats.gz,${dirOCAC}/${fileOCAC}.munge.sumstats.gz,${dirCCAC}/${fileCCAC}.munge.sumstats.gz,${dirENDO}/${fileENDO}.munge.sumstats.gz,${dirUF}/${fileUF}.munge.sumstats.gz,${dirPCOS}/${filePCOS}.munge.sumstats.gz \
  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --samp-prev 0.1,0.09,0.085,0.38,0.015,0.079,0.12,0.09 \
  --pop-prev 0.2,0.2,0.0034,0.001,0.0015,0.01,0.2,0.1 \
  --out ${dirR}/LDSC_MTAG_ECAC_OCAC_ENDO_UF_PCOS_CCAC_FGTP

fi

################################################################################
# extracting_rg_se_pval_cross_triat.sh
################################################################################
#!/bin/bash

#name to give the master file where the results will be saved
out_file=all_traits_summ.txt
#directory you want the files to be saved in
dirN=~/LDSC/FGT_polyps/output_cross_trait/with_Triins_CC_GWAS


grep p2 ${dirN}/LDSC_ECAC_OCAC_ENDO_UF_PCOS_CCAC_FGTP_BCAC_GIP_BMI.log > ${dirN}/${out_file}

for file in ${dirN}/*.log
do
grep -A15 p2 ${file} | head -n -3 | grep -v p2 >> ${dirN}/${out_file}
done

FGTP=~/LDSC/input/endo_polyps/LDSC_at_least_two_cohorts_FORMATTED_UKBB_FINNGEN_R11_MGI_EstBB_maf_0.01_info_0.3_hg381.txt.munge.sumstats.gz
OC=~/LDSC/input/OCAC/OCAC_rel_clms_3.txt.munge.sumstats.gz
EC=~/LDSC/input/endo_canc/ECAC_noBBJ_LDSC_7_h_s.txt.munge.sumstats.gz
#CC=~/LDSC/input/cervical/cerv_canc_clmns_4.txt.munge.sumstats.gz
CC=~/GWAS/cervical/Koel_23/sent_by_trin/LDSC_Koel_et_al_2023_cervical_cancer_EUR.txt.munge.sumstats.gz
ENDMTRS=~/LDSC/input/ENDO/ENDO_rel_colmns_nd.txt.munge.sumstats.gz
UF=~/GWAS/Uterine_fibroids/Sliz/LDSC_GCST90239856_buildGRCh38.tsv.munge.sumstats.gz
PCOS=~/LDSC/input/PCOS/PCOS_rel_colmns.txt.munge.sumstats.gz
BC=~/LDSC/input/brea_canc/BCAC_overall_GWAS_summary_10.txt.munge.sumstats.gz
GIP=~/LDSC/input/GI_polyps/GI_polyps_head_tab_rd.txt.munge.sumstats.gz
BMI=~/GWAS/BMI/Loic_Yengo_GIANT_UKBB//clean_MTAG_loic_BMI_7_mill_SNPs_MAF_0.01.txt.munge.sumstats.gz
MTAG=~/MTAG/endo_polyps/input/LDSC_MTAG_FGTP_v5.1_trait_1.txt.munge.sumstats.gz



sed -i "s:$FGTP:FGTP:g" ${dirN}/${out_file}
sed -i "s:$OC:OC:g" ${dirN}/${out_file}
sed -i "s:$EC:EC:g" ${dirN}/${out_file}
sed -i "s:$CC:CC:g" ${dirN}/${out_file}
sed -i "s:$ENDMTRS:ENDMTRS:g" ${dirN}/${out_file}
sed -i "s:$UF:UF:g" ${dirN}/${out_file}
sed -i "s:$PCOS:PCOS:g" ${dirN}/${out_file}
sed -i "s:$BC:BC:g" ${dirN}/${out_file}
sed -i "s:$GIP:GIP:g" ${dirN}/${out_file}
sed -i "s:$BMI:BMI:g" ${dirN}/${out_file}
sed -i "s:$MTAG:MTAG:g" ${dirN}/${out_file}

sed -i -E 's/ +/ /g' ${dirN}/${out_file}

#remove MGI as they are all NAs
#grep -v MGI ${dirN}/${out_file} > ${dirN}/tmp_${out_file} && mv ${dirN}/tmp_${out_file} ${dirN}/${out_file}
grep -v BMI ${dirN}/${out_file} > ${dirN}/for_ploting_${out_file}
grep -v BC ${dirN}/for_ploting_${out_file} > ${dirN}/tmp_for_ploting_${out_file} && mv ${dirN}/tmp_for_ploting_${out_file} ${dirN}/for_ploting_${out_file}
grep -v GIP ${dirN}/for_ploting_${out_file} > ${dirN}/tmp_for_ploting_${out_file} && mv ${dirN}/tmp_for_ploting_${out_file} ${dirN}/for_ploting_${out_file}

################################################################################
# generating_CIs_FGTP.R
################################################################################
library(data.table)

#df <- fread('~/LDSC/FGT_polyps/output_cross_trait/with_Triins_CC_GWAS/FGTP_only_summ.txt', header = T, stringsAsFactors = F)

df <- fread('~/LDSC/FGT_polyps/output_cross_trait/with_Triins_CC_GWAS/all_traits_summ.txt', header = T, stringsAsFactors = F)

df$lower_ci <- df$rg - 1.96 * df$se
df$upper_ci <- df$rg + 1.96 * df$se

df_reduced <- df[, c("p1", "p2", "rg","lower_ci","upper_ci","p","h2_liab","h2_liab_se")]

colnames(df_reduced) <- c("Trait.1", "Trait.2", "rg","95.CI.low","95.CI.high","P","h2.liab","h2.liab.se")


#save table
fwrite(df_reduced, "~/LDSC/FGT_polyps/output_cross_trait/with_Triins_CC_GWAS/FGTP_only_summ_reduced_cols_CIs.txt"
       , quote = FALSE, sep = " ", row.names = FALSE)

################################################################################
# plotting_heatmap_cross_traits.R
################################################################################
library(data.table)
library(corrplot)

ldsc_matrices <- function(df, stats){
  library(reshape2)
  traits <- unique(c(df$p1, df$p2))
  df$p_fdr <- p.adjust(df$p, method = 'fdr')
  matrices <- lapply(stats, function(x){
    mat <- dcast(df, p1 ~ p2, value.var = x)
    rownames(mat) <- mat$p1
    mat[,1] <- 0
    colnames(mat)[1] <- rownames(mat)[1]
    mat[length(traits),] <- 0
    rownames(mat)[length(traits)] <- colnames(mat)[length(traits)]
    mat <- mat[traits,traits] #same order of traits as short format (ensures perfect upper triangle matrix)
    diag(mat) <- 1
    mat[lower.tri(mat)] <- t(mat)[lower.tri(mat)]
    mat <- as.matrix(mat)
  })
  names(matrices) <- stats
  matrices
}

df <- fread('~/LDSC/FGT_polyps/output_cross_trait/with_Triins_CC_GWAS/for_ploting_all_traits_summ.txt', header = T, stringsAsFactors = F)

#order columns
#trait_order <- c("FGTP","OCAC","ECAC","PCOS","UF","ENDO","BCAC","CCAC", "GIP")
#trait_order2 <- c("FGTP", "OCAC","ECAC","PCOS","UF","ENDO","BCAC","CCAC","GIP")
#trait_order <- c("UKBB","Finngen","ESTBB","Meta_FGTP","AoU","MVP","AoUMVP")
#trait_order2 <- c("UKBB","Finngen","ESTBB","Meta_FGTP","AoU","MVP","AoUMVP")

trait_order <- c("FGTP","EC","OC","CC","ENDMTRS","UF")
trait_order2 <- c("EC","OC","CC","ENDMTRS","UF","PCOS")


df$p1 <- factor(df$p1, levels = trait_order)
df$p2 <- factor(df$p2, levels = trait_order2)
df <- df[order(df$p1, df$p2),]

df <- na.omit(df)

#use these two lines if you have traitx vs traitx in data frame
#df$row_id <- paste(df$p1, df$p2, sep="_")
#df <- df[df$p1 != df$p2, ]

df_mat <- ldsc_matrices(df, stats = c("rg","se", "p"))

#df_mat <- ldsc_matrices(df, stats = c("INTERCEPT"))

#test <- ldsc_matrices(df, stats = c("rg","se","p","p_fdr","gcov_int","gcov_int_se"))
#plot



col <- colorRampPalette(c("#4477AA","#77AADD","#FFFFFF","#EE9988","#BB4444"))

#set the working directory to where you want to save the plots
#setwd('~/plots')

#set specifications of tiff
#tiff(filename = "Corr_plot_LAVA_LDSC_all_traits.tiff",
#     width = 8, height = 6, units = "in",
#     res = 300, compression = "lzw")
#plot

#svg(filename = "Corr_plot_LAVA_LDSC_all_traits.svg",
#    width = 9, height = 6)
#par(mfrow = c(1,1))

tiff(filename = "~/LDSC/FGT_polyps/output_cross_trait/Corr_plot_LDSC_gynea_traits.tiff",
     width = 8, height = 6, units = "in",
     res = 300, compression = "lzw")

png("~/LDSC/FGT_polyps/output_cross_trait/with_Triins_CC_GWAS/Corr_plot_LDSC_gynea_traits.png",width = 8, height = 6, units = "in",res = 480)

df_mat[["rg"]] <- pmin(pmax(df_mat[["rg"]], -1), 1)
corrplot(df_mat[["rg"]],
         method = "color", col = col(200),
         type = "upper",
         addCoef.col = "black",
         order = 'original',
         p.mat = df_mat[["p"]],
         insig = "label_sig",
         pch = "\n*", #This uses a blank space instead of x
         sig.level = c(.05),
         pch.cex = 3,
         pch.col = "black",
         number.cex = 1,
         diag = FALSE,
         tl.col = "black",
         cl.cex = 1,
         outline = TRUE,
         tl.srt = 45,
         cl.lim = c(-1.5, 1.5))


dev.off()
