#PBS -l mem=4gb,walltime=02:00:00,ncpus=2
#PBS -N UKBB_pheno
#PBS -e ~/picking_out_pheno.err
#PBS -o ~/picking_out_pheno.out
#PBS -J 1-6

case $PBS_ARRAY_INDEX in
        1)
                pheno=N840;;
        2)
                pheno=N841;;
        3)
                pheno=N842;;
        4)
                pheno=N843;;
        5)
                pheno=N848;;
        6)
                pheno=N849;;
esac



#all female gen polyps, default data field is 41270 ICD10 main, grepping all N84 - female gen polyps
#download UKBB_pheno.sh from here https://github.com/Ningold30/GWAS.git
bash ~/Scripts/UKBB_phenotyping/UKBB_pheno.sh -p ${pheno} -o ~/UKBB/input -n FGT_polyps args1 args2 args3

