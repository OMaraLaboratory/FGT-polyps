library(data.table)
library(MRPRESSO)

# Define traits and their specific parameters
trait_configs <- list(
  ECAC = list(
    name = "ECAC",
    expo_file = "~/MR/MR_endo_polyps/input_files/clumped/T_FGTP_UKBB_FINNGEN_R11_EstBB_all_info_h_matched_with_ECAC.txt_no_trouble_SNP_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "~/MR/MR_endo_polyps/input_files/ECAC_B38_noBBJ_all_info_h.txt_matching_clumped",
    rows_to_remove = c(12,15)
  ),
  OCAC = list(
    name = "OCAC",
    expo_file = "~/MR/MR_endo_polyps/input_files/clumped/T_FGTP_matched_to_OCAC.txt_no_trouble_SNP_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "~/MR/MR_endo_polyps/input_files/OCAC_B38_all_info_h_se.txt_matching_clumped",
    rows_to_remove = 8
  ),
  ENDO = list(
    name = "ENDO",
    expo_file = "~/MR/MR_endo_polyps/input_files/clumped/T_FGTP_matched_to_ENDO.txt_no_trouble_SNP_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "~/MR/MR_endo_polyps/input_files/for_MR_rsid_GCST90269970_buildGRCh37.txt_matching_clumped",
    rows_to_remove = c(2,19,22)
  ),
  UF = list(
    name = "UF",
    expo_file = "~/MR/MR_endo_polyps/input_files/clumped/T_FGTP_matched_to_UF.txt_no_trouble_SNP_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "~/MR/MR_endo_polyps/input_files/UF_B38_all_info_h_sp_se.txt_matching_clumped",
    rows_to_remove = c(4,6,7,8,17,19,22,24)
  ),
  CCAC = list(
    name = "CCAC",
    expo_file = "~/MR/MR_endo_polyps/input_files/clumped/T_FGTP_matched_to_CCAC.txt_no_trouble_SNP_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "~/MR/MR_endo_polyps/input_files/CCAC_logOR_SE.txt_matching_clumped",
    rows_to_remove = 8
  ),
  BCAC = list(
    name = "BCAC",
    expo_file = "~/MR/MR_endo_polyps/input_files/clumped/T_FGTPP_matched_to_BCAC.txt_no_trouble_SNP_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "~/MR/MR_endo_polyps/input_files/no_palin_BCAC_MR.txt_matching_clumped",
    rows_to_remove = c(2,8,9,10,17,19,21,24)
  ),
  PCOS = list(
    name = "PCOS",
    expo_file = "~/MR/MR_endo_polyps/input_files/clumped/T_FGTP_matched_to_PCOS.txt_no_trouble_SNP_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "~/MR/MR_endo_polyps/input_files/PCOS_MR_rel_clms.txt_matching_clumped",
    rows_to_remove = NULL,
    # Custom column mappings for PCOS
    expo_cols = NULL,  # Uses default column names for exposure
    outcome_cols = list(  # Custom column names for PCOS outcome
      pval_col = "P",
      beta_col = "EFFECT",
      se_col = "STDERR",
      eaf_col = "EAF"
    ),
    harmonise_action = 2
  ),
  GIP = list(
    name = "GIP",
    expo_file = "~/MR/MR_endo_polyps/input_files/clumped/T_FGTP_matched_to_GIP.txt_no_trouble_SNP_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "~/MR/MR_endo_polyps/input_files/GIP_logOR_se.txt_matching_clumped",
    rows_to_remove = NULL
  ),
  ECAC2018_noUKBB = list(
    name = "ECAC2018_noUKBB",
    expo_file = "~/MR/MR_endo_polyps/input_files/clumped/T_FGTP_matched_to_ECAC2018_noUKBB.txt_no_trouble_SNP_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "~/MR/MR_endo_polyps/input_files/ECAC2018_noUKBB_H_ordered.txt_matching_clumped",
    rows_to_remove = c(12,14)
  )
)


#Output directory
output_dir <- "~/MR/MR_endo_polyps/output/27_SNPs"

# Load TwoSampleMR only when needed
load_twosample_mr <- function() {
  if (!"TwoSampleMR" %in% loadedNamespaces()) {
    cat("Loading TwoSampleMR package...\n")
    library(TwoSampleMR)
  }
}


# Function to perform MR analysis for a single trait
perform_mr_analysis <- function(trait_config) {

  # Load TwoSampleMR at the start of each analysis
  load_twosample_mr()

  trait_name <- trait_config$name
  #trait_name <- "ECAC"
  cat(paste("\n=== Processing", trait_name, "===\n"))

  # Load data
  expo <- fread(trait_config$expo_file, header = TRUE)
  outcome <- fread(trait_config$outcome_file, header = TRUE)
