#!/bin/bash

for trait in TCGA-UCEC
do

################################################
#merge raw results
################################################

cd ~/TWAS/FUSION/ENDO_polyps/output/${trait}

#for file in *.txt.MHC
#do
#  mv ${file} ${file%????}
#done

for file in chr2_*
do
head -1 ${file} > All_chr_ENDO_${trait}_genes.txt
done

for file in chr*.txt*
do
awk '{if (NR>1) print $0}' ${file} >> All_chr_ENDO_${trait}_genes.txt
done

done

#Uterus Vagina TCGA-UCEC Whole_Blood EBV_TL Ovary sCCA_v8_1 sCCA_v8_2 sCCA_v8_3


#########################################################
#Extracting MHC region
#########################################################

#!/bin/bash

cd ~/TWAS/FUSION/ENDO_polyps/output

#get a list of all MHC genes
for tissue in Uterus Ovary Vagina sCCA_v8_1 sCCA_v8_2 sCCA_v8_3 Whole_Blood EBV_TL TCGA-UCEC; do
    cut -f3 ${tissue}/chr6_ENDO_${tissue}_genes.txt.MHC | sort | uniq >> MHC_genes.txt
done

#remove duplicates
awk '!seen[$1]++' MHC_genes.txt > tmp_MHC_genes.txt && mv tmp_MHC_genes.txt MHC_genes.txt

#remove MHC from TWAS results
awk 'NR==FNR {a[$1];next} {if (!($1 in a) || FNR==1) print $0}' MHC_genes.txt all_genes_and_tissues_fdr_corrected.txt > no_MHC_all_genes_and_tissues_fdr_corrected.txt

awk 'NR==FNR {a[$1];next} {if (!($1 in a) || FNR==1) print $0}' MHC_genes.txt z_score_all_genes_and_tissues_fdr_corrected.txt > no_MHC_z_score_all_genes_and_tissues_fdr_corrected.txt


#########################################################
#Merging all genes
#########################################################


library(data.table)
library(dplyr)

setwd("~/TWAS/FUSION/ENDO_polyps/output")

genes <- data.frame(matrix(nrow = 0, ncol = 0))
genes_tissues <- data.frame(matrix(nrow = 0, ncol = 0))

for(trait in c("Uterus","Ovary","Vagina","sCCA_v8_1","sCCA_v8_2","sCCA_v8_3","Whole_Blood","EBV_TL","TCGA-UCEC")){
  df <- fread(paste0(trait,"/All_chr_ENDO_",trait,"_genes.txt"), header = T)
  df$fdr <- p.adjust(df$TWAS.P, method='fdr')
  df$label = ifelse(df$fdr < 0.05, df$ID, "")
  df <- df[df$label != "", ]
  df$TISSUE <- paste0(trait)
  genes <- rbind(genes, df)
  df <- df[,c("ID","TISSUE","CHR","P0","P1","BEST.GWAS.ID", "BEST.GWAS.Z")]
  genes_tissues <- rbind(genes_tissues, df)
}

#condense all repeated genes to a single row
result <- genes_tissues %>%
  group_by(ID) %>%
  summarise(TISSUE = paste(unique(TISSUE), collapse = ";"),
            CHR = first(CHR),
            P0 = first(P0),
            P1 = first(P1),
            BEST.GWAS.ID = first(BEST.GWAS.ID),
            BEST.GWAS.Z = first(BEST.GWAS.Z))

#flip z scores
result$BEST.GWAS.Z.flipped <- ifelse(result$BEST.GWAS.Z < 0, result$BEST.GWAS.Z*-1, result$BEST.GWAS.Z)

fwrite(result,"z_score_all_genes_and_tissues_fdr_corrected.txt", quote = F, row.names = F, sep = "\t")


#######################################################
#Extracting TWAS z scores, this was done post-hoc, so it might be better to  just incorperate it from the start
#######################################################

#!/bin/bash

cd ~/TWAS/FUSION/ENDO_polyps/output

set -euo pipefail

input="no_TCGA_no_MHC_z_score_all_genes_and_tissues_fdr_corrected.txt.Build.38_GWAS_BP"
output="${input}_with_TWAS_Z.txt"

subtypes=(
    Ovary
    sCCA_v8_1
    sCCA_v8_2
    sCCA_v8_3
    EBV_TL
    Vagina
    Whole_Blood
    Uterus
)

files=()

for subtype in "${subtypes[@]}"; do
    file="${subtype}/All_chr_ENDO_${subtype}_genes_BH_corrected_no_FDR_col.top"
    [[ -f "$file" ]] || { echo "Missing: $file" >&2; exit 1; }
    files+=("$file")
done

awk '
    BEGIN {
        split("Ovary sCCA_v8_1 sCCA_v8_2 sCCA_v8_3 EBV_TL Vagina Whole_Blood Uterus", names, " ")
        n = 8
    }

    # Read each subtype file
    FILENAME != ARGV[ARGC-1] {
        if (FNR > 1) {
            for (i = 1; i <= n; i++) {
                if (FILENAME == ARGV[i]) {
                    z[i, $3] = $19
                    break
                }
            }
        }
        next
    }

    # Original file header
    FNR == 1 {
        for (i = 1; i <= n; i++)
            $0 = $0 OFS names[i] "_twas.z"
        print
        next
    }

    # Append eight TWAS.Z columns
    {
        gene = $1

        for (i = 1; i <= n; i++) {
            value = ((i SUBSEP gene) in z) ? z[i, gene] : "NA"
            $0 = $0 OFS value
        }

        print
    }
' "${files[@]}" "$input" | tr '\t' ' ' > "$output"

echo "Created: $output"


