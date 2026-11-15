#cd ~/GWAS/endo_polyps/UKBB/input

#~/feb2024_pheno_data/ukb677634.tab

#head -1 ~/feb2024_pheno_data/ukb677634.tab | tr '\t' '\n' | grep -n 41270 | cut -d":" -f1 | head -1
#24290

#head -1 ~/feb2024_pheno_data/ukb677634.tab | tr '\t' '\n' | grep -n 41270 | cut -d":" -f1 | tail -1
#24548

cd ~/GWAS/Uterine_fibroids/UKBB

awk 'NR==FNR {a[$2]=$0;next}{ if (FNR == 1) print "FID IID POLYPS UF"; else if ($2 in a) print a[$2],$3}' ~/GWAS/endo_polyps/UKBB/input/FGT_polyps_UKBB_WB.phenotype.merged.women UF_UKBB_WB.phenotype.merged.women > Polyps_and_UF.txt

awk '{if (NR==1 || $3==1) print $0}' Polyps_and_UF.txt > Polyps_cases_and_UF.txt
awk '{if (NR==1 || $3==0) print $0}' Polyps_and_UF.txt > Polyps_controls_and_UF.txt

#total polyps
cut -d " " -f3 ~/GWAS/endo_polyps/UKBB/input/FGT_polyps_UKBB_WB.phenotype.merged.women | sort | uniq -c
# 223662 0
#  13663 1
#      1 ENDO_POLYPS

#proportion of polyps cases with UF
cut -d " " -f4 Polyps_cases_and_UF.txt | sort | uniq -c
#  11003 0
#   2660 1
#      1 UF

#2660/13663*100 = 19.47 %

#proportion of polyps controls with UF
cut -d " " -f4 Polyps_controls_and_UF.txt | sort | uniq -c
# 213611 0
#  10014 1
#      1 UF
#10014/223662*100 = 4.48%


###############################################################
#endometriosis
###############################################################

cd ~/GWAS/endometriosis/UKBB

awk 'NR==FNR {a[$2]=$0;next}{if ($2 in a) print a[$2],$3}' ~/GWAS/endo_polyps/UKBB/input/FGT_polyps_UKBB_WB.phenotype.merged.women endometriosis_UKBB_WB.phenotype.merged.women > Polyps_and_endometriosis.txt

awk '{if (NR==1 || $3==1) print $0}' Polyps_and_endometriosis.txt > Polyps_cases_and_endometriosis.txt
awk '{if (NR==1 || $3==0) print $0}' Polyps_and_endometriosis.txt > Polyps_controls_and_endometriosis.txt

#total number of polyps
cut -d " " -f3 ~/GWAS/endo_polyps/UKBB/input/FGT_polyps_UKBB_WB.phenotype.merged.women | sort | uniq -c
# 223662 0
#  13663 1
#      1 ENDO_POLYPS

#total number of endometriosis cases
cut -d " " -f4 Polyps_cases_and_endometriosis.txt | sort | uniq -c
#  12849 0
#    814 1
#      1 endometriosis

#814/13663*100 = 5.96 %

#total number of endometriosis cases in controls
cut -d " " -f4 Polyps_controls_and_endometriosis.txt | sort | uniq -c
# 219654 0
#   3971 1
#      1 endometriosis

#3971/223662*100 = 1.78%
