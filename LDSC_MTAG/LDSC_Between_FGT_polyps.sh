#################################################################
# between_FGT_polyps_munge.sh
#################################################################

#!/bin/bash
#PBS -l mem=2gb
#PBS -l walltime=02:00:00,ncpus=1
#PBS -N munge
#PBS -e ~/OUT_ERR/munge.err
#PBS -o ~/OUT_ERR/munge.out

module load ldsc/20190815

#file1=LDSC_finngen_R11_N14_POLYPFEMGEN.txt
#dirR=~/GWAS/endo_polyps/FinnGen/input/R11

#file1=LDSC_METAL_A1_effect_MAF_0.01_INFO_0.3_N84_additive.txt
#dirR=~/GWAS/endo_polyps/EstBiobank

#dirR=~/GWAS/endo_polyps/MGI/input
#file1=LDSC_23_METAL_MGI_A1_effect_build_38_Freeze3.X622_MAF_0.01.txt

#dirR=~/GWAS/cervical/Raskin
#file1=LDSC_GCST90011816_buildGRCh37.tsv

#dirR=~/MTAG/endo_polyps/input
#file1=LDSC_MTAG_FGTP_v5.1_trait_1.txt

dirR=~/GWAS/cervical/Koel_23/sent_by_trin
file1=LDSC_Koel_et_al_2023_cervical_cancer_EUR.txt

munge_sumstats.py --sumstats ${dirR}/${file1} --out ${dirR}/${file1}.munge --merge-alleles ~/scriptsL/LD_score/w_hm3.snplist

#################################################################
# between_FGT_polyps_rg.sh
#################################################################

#!/bin/bash
#PBS -l mem=2gb
#PBS -l walltime=02:00:00,ncpus=1
#PBS -N LDSC_rg
#PBS -e ~/OUT_ERR/LDSC_rg.e
#PBS -o ~/OUT_ERR/LDSC_rg.o



module load ldsc/20190815

dirFGTP=~/LDSC/input/endo_polyps
fileFGTP=LDSC_at_least_two_cohorts_FORMATTED_UKBB_FINNGEN_R11_MGI_EstBB_maf_0.01_info_0.3_hg381.txt

dirUKBB=~/GWAS/endo_polyps/UKBB/output/regenie_output/FGT_POLYPS_regenie/LDSC
fileUKBB=FGT_Polyps_all_chr.txt_INFO_0.3_MAF_0.01.txt.LDSC

dirFingen=~/GWAS/endo_polyps/FinnGen/input/R11
fileFingen=LDSC_finngen_R11_N14_POLYPFEMGEN.txt

dirESTBB=~/GWAS/endo_polyps/EstBiobank
fileESTBB=LDSC_METAL_A1_effect_MAF_0.01_INFO_0.3_N84_additive.txt

dirMGI=~/GWAS/endo_polyps/MGI/input
fileMGI=LDSC_23_METAL_MGI_A1_effect_build_38_Freeze3.X622_MAF_0.01.txt

dirMVP=~/METAL/EP
fileMVP=MVP.sumstats.gz

dirAoU=~/GWAS/endo_polyps/AllofUs/FGT_Polyps
fileAoU=LDSC_Pval_RSID_no_indels_MAF_0.01_all_chr_FGT_polyps.txt

AoUMVPdir=~/METAL/EP
AoUMVPfile=META.sumstats.gz

outdir=~/LDSC/FGT_polyps/output

#ldsc.py \
#  --rg ${dirUKBB}/${fileUKBB}.munge.sumstats.gz,${dirFingen}/${fileFingen}.munge.sumstats.gz,${dirESTBB}/${fileESTBB}.munge.sumstats.gz,${dirMGI}/${fileMGI}.munge.sumstats.gz,${dirFGTP}/${fileFGTP}.munge.sumstats.gz,${dirAoU}/${fileAoU}.munge.sumstats.gz,${dirMVP}/${fileMVP},${AoUMVPdir}/${AoUMVPfile} \
#  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
#  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
#  --samp-prev 0.06,0.14,0.12,0.05,0.04,0.03,0.03,0.03 \
#  --pop-prev 0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2 \
#  --out ${outdir}/FGTP_all

  #ldsc.py \
 # --rg ${dirFingen}/${fileFingen}.munge.sumstats.gz,${dirESTBB}/${fileESTBB}.munge.sumstats.gz,${dirMGI}/${fileMGI}.munge.sumstats.gz,${dirFGTP}/${fileFGTP}.munge.sumstats.gz,${dirAoU}/${fileAoU}.munge.sumstats.gz,${dirMVP}/${fileMVP},${AoUMVPdir}/${AoUMVPfile} \
 # --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
 # --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
 # --samp-prev 0.14,0.12,0.05,0.04,0.03,0.03,0.03 \
 # --pop-prev 0.2,0.2,0.2,0.2,0.2,0.2,0.2 \
 # --out ${outdir}/FGTP_1

  ldsc.py \
  --rg ${dirESTBB}/${fileESTBB}.munge.sumstats.gz,${dirMGI}/${fileMGI}.munge.sumstats.gz,${dirFGTP}/${fileFGTP}.munge.sumstats.gz,${dirAoU}/${fileAoU}.munge.sumstats.gz,${dirMVP}/${fileMVP},${AoUMVPdir}/${AoUMVPfile} \
  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
  --samp-prev 0.12,0.05,0.04,0.03,0.03,0.03 \
  --pop-prev 0.2,0.2,0.2,0.2,0.2,0.2 \
  --out ${outdir}/FGTP_2

#  ldsc.py \
#  --rg ${dirMGI}/${fileMGI}.munge.sumstats.gz,${dirFGTP}/${fileFGTP}.munge.sumstats.gz,${dirAoU}/${fileAoU}.munge.sumstats.gz,${dirMVP}/${fileMVP},${AoUMVPdir}/${AoUMVPfile} \
#  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
#  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
#  --samp-prev 0.05,0.04,0.03,0.03,0.03 \
#  --pop-prev 0.2,0.2,0.2,0.2,0.2 \
#  --out ${outdir}/FGTP_3

 # ldsc.py \
 # --rg ${dirFGTP}/${fileFGTP}.munge.sumstats.gz,${dirAoU}/${fileAoU}.munge.sumstats.gz,${dirMVP}/${fileMVP},${AoUMVPdir}/${AoUMVPfile} \
 # --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
 # --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
 # --samp-prev 0.04,0.03,0.03,0.03 \
 # --pop-prev 0.2,0.2,0.2,0.2 \
 # --out ${outdir}/FGTP_4


 # ldsc.py \
 # --rg ${dirAoU}/${fileAoU}.munge.sumstats.gz,${dirMVP}/${fileMVP},${AoUMVPdir}/${AoUMVPfile} \
 # --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
 # --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
 # --samp-prev 0.03,0.03,0.03 \
 # --pop-prev 0.2,0.2,0.2 \
 # --out ${outdir}/FGTP_5


#   ldsc.py \
#  --rg ${dirMVP}/${fileMVP},${AoUMVPdir}/${AoUMVPfile} \
#  --ref-ld-chr ~/LDSC/eur_w_ld_chr/ \
#  --w-ld-chr ~/LDSC/eur_w_ld_chr/ \
#  --samp-prev 0.03,0.03 \
#  --pop-prev 0.2,0.2 \
#  --out ${outdir}/FGTP_6

#################################################################
# extracting_rg_se_pval.sh
#################################################################

#!/bin/bash

#name to give the master file where the results will be saved
out_file=all_FGT_GWAS_summ.txt
#directory you want the files to be saved in
dirN=~/LDSC/FGT_polyps/output


grep p2 ${dirN}/FGTP_all.log > ${dirN}/${out_file}

for file in ${dirN}/FGTP_*.log
do
grep -A10 p2 ${file} | head -n -3 | grep -v p2 >> ${dirN}/${out_file}
done


Meta_FGTP="~/LDSC/input/endo_polyps/LDSC_at_least_two_cohorts_FORMATTED_UKBB_FINNGEN_R11_MGI_EstBB_maf_0.01_info_0.3_hg381.txt.munge.sumstats.gz"

UKBB=~/GWAS/endo_polyps/UKBB/output/regenie_output/FGT_POLYPS_regenie/LDSC/FGT_Polyps_all_chr.txt_INFO_0.3_MAF_0.01.txt.LDSC.munge.sumstats.gz

Finngen=~/GWAS/endo_polyps/FinnGen/input/R11/LDSC_finngen_R11_N14_POLYPFEMGEN.txt.munge.sumstats.gz

ESTBB=~/GWAS/endo_polyps/EstBiobank/LDSC_METAL_A1_effect_MAF_0.01_INFO_0.3_N84_additive.txt.munge.sumstats.gz

MGI=~/GWAS/endo_polyps/MGI/input/LDSC_23_METAL_MGI_A1_effect_build_38_Freeze3.X622_MAF_0.01.txt.munge.sumstats.gz

MVP=~/METAL/EP/MVP.sumstats.gz

AoU=~/GWAS/endo_polyps/AllofUs/FGT_Polyps/LDSC_Pval_RSID_no_indels_MAF_0.01_all_chr_FGT_polyps.txt.munge.sumstats.gz

AoUMVP=~/METAL/EP/META.sumstats.gz


sed -i "s:$Meta_FGTP:Meta_FGTP:g" ${dirN}/${out_file}
sed -i "s:$UKBB:UKBB:g" ${dirN}/${out_file}
sed -i "s:$Finngen:Finngen:g" ${dirN}/${out_file}
sed -i "s:$ESTBB:ESTBB:g" ${dirN}/${out_file}
sed -i "s:$MGI:MGI:g" ${dirN}/${out_file}
sed -i "s:$MVP:MVP:g" ${dirN}/${out_file}
sed -i "s:$AoU:AoU:g" ${dirN}/${out_file}
sed -i "s:$AoUMVP:AoUMVP:g" ${dirN}/${out_file}

sed -i -E 's/ +/ /g' ${dirN}/${out_file}

#remove MGI as they are all NAs
grep -v MGI ${dirN}/${out_file} > ${dirN}/tmp_${out_file} && mv ${dirN}/tmp_${out_file} ${dirN}/${out_file}
grep -v MVP ${dirN}/${out_file} > ${dirN}/tmp_${out_file} && mv ${dirN}/tmp_${out_file} ${dirN}/${out_file}


#################################################################
# plotting_heatmap.R
#################################################################

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

df <- fread('~/LDSC/FGT_polyps/output/all_FGT_GWAS_summ.txt', header = T, stringsAsFactors = F)

#order columns
#trait_order <- c("FGTP","OCAC","ECAC","PCOS","UF","ENDO","BCAC","CCAC", "GIP")
#trait_order2 <- c("FGTP", "OCAC","ECAC","PCOS","UF","ENDO","BCAC","CCAC","GIP")
trait_order <- c("UKBB","Finngen","ESTBB","Meta_FGTP","AoU")
trait_order2 <- c("UKBB","Finngen","ESTBB","Meta_FGTP","AoU")
df$p1 <- factor(df$p1, levels = trait_order)
df$p2 <- factor(df$p2, levels = trait_order2)
df <- df[order(df$p1, df$p2),]


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


#svg(filename = "Corr_plot_LAVA_LDSC_all_traits.svg",
#    width = 9, height = 6)
#par(mfrow = c(1,1))

tiff(filename = "~/LDSC/FGT_polyps/output/Corr_plot_LDSC_all_GWAS.tiff",
     width = 8, height = 6, units = "in",
     res = 300, compression = "lzw")
pdf("~/LDSC/FGT_polyps/output/Corr_plot_LDSC_all_GWAS.pdf",
     width = 8, height = 6)
png("~/LDSC/FGT_polyps/output/Corr_plot_LDSC_all_GWAS.png",width = 8, height = 6, units = "in",res = 480)

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

#text("rg", side = 4, line = 1, cex = 1, las = 1)

#close the device
dev.off()
