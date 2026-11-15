module load python/3.9.13

file1=~/regenie_output/FGT_POLYPS_regenie/FGT_POLYPS_regenie_chr22_ENDO_POLYPS.regenie
title="Female Genital polyps"
out_file=FGT_Polyps


#download combine_and_filter.py from here: https://github.com/Ningold30/combine_filter_GWAS.git
~/Scripts/combine_filter_GWAS/combine_and_filter.py \
 --file_chr_22 "$file1" \
 --regenie \
 --ManQQplot \
 --ManQQplot_title "$title" \
 --num_chrom 23 \
 --clump \
 --munge \
 --output_file "$out_file"_all_chr.txt
