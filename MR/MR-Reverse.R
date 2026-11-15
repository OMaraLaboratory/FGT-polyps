library(data.table)
library(MRPRESSO)

# Define traits and their specific parameters
trait_configs <- list(
  ECAC = list(
    name = "ECAC",
    expo_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/ECAC_B38_noBBJ_all_info_h.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/FGTP_UKBB_FINNGEN_R11_EstBB_all_info_h_matched_with_ECAC.txt_no_trouble_SNP_matching_clumped",
    rows_to_remove = c(8,9,14)
  ),
  OCAC = list(
    name = "OCAC",
    expo_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/OCAC_B38_all_info_h_se.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/FGTP_matched_to_OCAC.txt_no_trouble_SNP_matching_clumped",
    rows_to_remove = c(2,9,13,14)
  ),
  ENDO = list(
    name = "ENDO",
    expo_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/for_MR_rsid_GCST90269970_buildGRCh37.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/FGTP_matched_to_ENDO.txt_no_trouble_SNP_matching_clumped",
    rows_to_remove = c(9,17,19)
  ),
  UF = list(
    name = "UF",
    expo_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/UF_B38_all_info_h_sp_se.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/FGTP_matched_to_UF.txt_no_trouble_SNP_matching_clumped",
    rows_to_remove = c(1,3,7,12,18,34,38,39,40,52,56,58,60)
  ),
  CCAC = list(
    name = "CCAC",
    expo_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/CCAC_logOR_SE.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/FGTP_matched_to_CCAC.txt_no_trouble_SNP_matching_clumped",
    rows_to_remove = c(4,6,9)
  ),
  BCAC = list(
    name = "BCAC",
    expo_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/no_palin_BCAC_MR.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/FGTPP_matched_to_BCAC.txt_no_trouble_SNP_matching_clumped",
    rows_to_remove = NULL
  ),
  PCOS = list(
    name = "PCOS",
    expo_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/PCOS_MR_rel_clms.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/FGTP_matched_to_PCOS.txt_no_trouble_SNP_matching_clumped",
    rows_to_remove = NULL,
    # Custom column mappings for PCOS
    outcome_cols = NULL,  # Uses default column names for exposure
    expo_cols = list(  # Custom column names for PCOS outcome
      pval_col = "PVAL",
      beta_col = "EFFECT",
      se_col = "STDERR",
      eaf_col = "EAF"
    ),
    harmonise_action = 2
  ),
  GIP = list(
    name = "GIP",
    expo_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/GIP_logOR_se.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/FGTP_matched_to_GIP.txt_no_trouble_SNP_matching_clumped",
    rows_to_remove = NULL
  ),
  ECAC2018_noUKBB = list(
    name = "ECAC_noUKBB",
    expo_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/no_indel_rsid_ECAC2018_noUKBB_strata.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt",
    outcome_file = "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/FGTP_matched_to_ECAC2018_noUKBB.txt_no_trouble_SNP_matching_clumped",
    expo_cols = list(  # Custom column names for PCOS outcome
      pval_col = "PVAL",
      beta_col = "BETA",
      se_col = "SE",
      eaf_col = "MEAN_EAF"),
    rows_to_remove = c(6,7,8,12,14)
  )
)


#Output directory
output_dir <- "/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/output/reverse_27_SNPs"

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
  #expo <- fread("/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/clumped/FGTP_UKBB_FINNGEN_R11_EstBB_all_info_h_matched_with_ECAC.txt_lead_SNPs_r2_0.001_P_5e8_500KB.txt"
  #              ,header = TRUE)
  #outcome <- fread("/working/lab_tracyo/nathanI/MR/Stephs_MR_endo_polyps/Stephs_input_files/ECAC_B38_noUKBB_noBBJ_all_info_h_matched_with_FGTP.txt_matching_clumped"
  #              ,header = TRUE)


  # Add phenotype labels
  expo$phenotype <- "FGTP"
  outcome$phenotype <- trait_name

  # Convert to data.frames
  expo <- as.data.frame(expo)
  outcome <- as.data.frame(outcome)

  # Format exposure data
  # Default column mappings
  default_expo_cols <- list(
    pval_col = "PVAL",
    beta_col = "BETA",
    se_col = "SE",
    snp_col = "SNP",
    phenotype_col = "phenotype",
    effect_allele_col = "A1",
    other_allele_col = "A2",
    eaf_col = "FREQ"
  )

  # Use custom columns if provided, otherwise use defaults
  expo_cols <- if(!is.null(trait_config$expo_cols)) {
    modifyList(default_expo_cols, trait_config$expo_cols)
  } else {
    default_expo_cols
  }

  expo <- do.call(TwoSampleMR::format_data, c(list(expo, type = 'exposure'), expo_cols))

  # Format outcome data
  default_outcome_cols <- list(
    pval_col = "PVAL",
    beta_col = "BETA",
    se_col = "SE",
    snp_col = "SNP",
    phenotype_col = "phenotype",
    effect_allele_col = "A1",
    other_allele_col = "A2",
    eaf_col = "FREQ"
  )

  # Use custom columns if provided, otherwise use defaults
  outcome_cols <- if(!is.null(trait_config$outcome_cols)) {
    modifyList(default_outcome_cols, trait_config$outcome_cols)
  } else {
    default_outcome_cols
  }

  outcome <- do.call(TwoSampleMR::format_data, c(list(outcome, type = 'outcome'), outcome_cols))

  # Harmonise the data
  harmonise_action <- if(!is.null(trait_config$harmonise_action)) {
    trait_config$harmonise_action
  } else {
    2  # default action
  }

  dat <- TwoSampleMR::harmonise_data(exposure_dat = expo,
                                     outcome_dat = outcome,
                                     action = harmonise_action)


  if (trait_config$name != "PCOS") {
    cat("Running MR-PRESSO...\n")
    mr_presso(BetaOutcome = "beta.outcome", BetaExposure = "beta.exposure"
              , SdOutcome = "se.outcome", SdExposure = "se.exposure"
              , OUTLIERtest = TRUE, DISTORTIONtest = TRUE, data = dat
              , NbDistribution = 1000,  SignifThreshold = 0.05)-> dat_MR_Press
    print(dat_MR_Press[["MR-PRESSO results"]][["Outlier Test"]])
  } else {
    cat("Skipping MR-PRESSO for PCOS exposure\n")
    dat_MR_Press <- NULL
  }
  # #run MR Presso
  # mr_presso(BetaOutcome = "beta.outcome", BetaExposure = "beta.exposure"
  #           , SdOutcome = "se.outcome", SdExposure = "se.exposure"
  #           , OUTLIERtest = TRUE, DISTORTIONtest = TRUE, data = dat
  #           , NbDistribution = 1000,  SignifThreshold = 0.05)-> dat_MR_Press
  # # print(trait_name)
  # print(dat_MR_Press[["MR-PRESSO results"]][["Outlier Test"]])
  #
  # Remove specified rows (trait-specific)
  if (!is.null(trait_config$rows_to_remove)) {
    dat3 <- dat[-trait_config$rows_to_remove, ]
  } else {
    dat3 <- dat
  }

  # Save harmonised data
  harmonised_file <- file.path(output_dir, paste0("dat3_FGTP_with_", trait_name, ".txt"))
  fwrite(dat3, harmonised_file, sep = " ", row.names = FALSE, quote = FALSE)

  # Run MR
  cat("Running MR analysis...\n")
  res <- TwoSampleMR::mr(dat3)

  # Test for heterogeneity
  cat("Testing for heterogeneity...\n")
  hetro_dat <- TwoSampleMR::mr_heterogeneity(dat3)

  # Single SNP analysis and funnel plot
  cat("Running single SNP analysis...\n")
  singlesnp_results <- TwoSampleMR::mr_singlesnp(dat3)

  # Create funnel plot
  tryCatch({
    TwoSampleMR::mr_funnel_plot(singlesnp_results)

    # Call modified function if it exists
    if (exists("mr_funnel_plot_with_labels")) {
      mr_funnel_plot_with_labels(singlesnp_results)
    }
  }, error = function(e) {
    cat("Warning: Could not create funnel plot -", e$message, "\n")
  })

  # MR Egger intercept test
  cat("Running MR Egger pleiotropy test...\n")
  egger_test_result <- TwoSampleMR::mr_pleiotropy_test(dat3)
  print(egger_test_result)

  # Save Egger test results
  egger_file <- file.path(output_dir, paste0("egger_test_result_FGTP_with_", trait_name, ".txt"))
  write.table(egger_test_result, egger_file, sep = " ", row.names = FALSE, quote = FALSE)

  # Calculate OR and confidence intervals
  cat("Calculating OR and confidence intervals...\n")

  # Check if we have any results to process
  if (nrow(res) == 0) {
    cat("No MR results available for", trait_name, "- skipping OR calculations\n")
    return(list(
      trait = trait_name,
      mr_results = res,
      heterogeneity = hetro_dat,
      egger_test = egger_test_result,
      leave_one_out = NULL,
      harmonised_data = dat3,
      error = "No SNPs available for analysis"
    ))
  }

  res$lower_ci <- res$b - (1.96 * res$se)
  res$upper_ci <- res$b + (1.96 * res$se)
  res$OR <- exp(res$b)
  res$lo <- exp(res$lower_ci)
  res$up <- exp(res$upper_ci)
  res$p_fdr <- p.adjust(res$pval, method = "fdr")

  # Save MR results
  results_file <- file.path(output_dir, paste0("res_FGTP_with_", trait_name, ".txt"))
  write.table(res, results_file, sep = "\t", row.names = FALSE, quote = FALSE)

  # Leave-one-out analysis
  cat("Running leave-one-out analysis...\n")

  # Only run LOO if we have results
  if (nrow(res) > 0) {
    mr_LOO <- TwoSampleMR::mr_leaveoneout(dat3, parameters = default_parameters())

    # Save LOO results
    loo_file <- file.path(output_dir, paste0("FGTP_with_", trait_name, "_mr_LOO.txt"))
    write.table(mr_LOO, loo_file, sep = " ", row.names = FALSE, quote = FALSE)
  } else {
    cat("Skipping leave-one-out analysis for", trait_name, "- no SNPs available\n")
    mr_LOO <- NULL
  }

  cat(paste("=== Completed", trait_name, "===\n"))

  # Return results for potential further analysis
  return(list(
    trait = trait_name,
    mr_results = res,
    heterogeneity = hetro_dat,
    egger_test = egger_test_result,
    leave_one_out = mr_LOO,
    harmonised_data = dat3
  ))
}

# Run analysis for all traits
all_results <- lapply(trait_configs, perform_mr_analysis)

names(all_results) <- names(trait_configs)

# Create summary of all results
summary_results <- data.frame(
  trait = names(all_results),
  n_snps = sapply(all_results, function(x) nrow(x$harmonised_data)),
  stringsAsFactors = FALSE
)


# Add MR method results to summary
for(i in 1:length(all_results)) {
  trait_name <- names(all_results)[i]
  mr_res <- all_results[[i]]$mr_results


  # Add IVW results to summary if available
  if(trait_name == "PCOS") {
    ivw_result <- mr_res[mr_res$method == "Wald ratio", ]
  } else {
    ivw_result <- mr_res[mr_res$method == "Inverse variance weighted", ]
  }
  if(nrow(ivw_result) > 0) {
    summary_results[i, "IVW_beta"] <- ivw_result$b[1]
    summary_results[i, "IVW_se"] <- ivw_result$se[1]
    summary_results[i, "IVW_pval"] <- ivw_result$pval[1]
    summary_results[i, "IVW_OR"] <- round(exp(ivw_result$b[1]),2)
    summary_results[i, "IVW_CI_lo"] <- round(ivw_result$lo[1],2)
    summary_results[i, "IVW_CI_hi"] <- round(ivw_result$up[1],2)
    summary_results[i, "FDR"] <- ivw_result$p_fdr[1]
  }
}


# Save summary
summary_file <- file.path(output_dir, "MR_analysis_summary.txt")
write.table(summary_results, summary_file, sep = " ", row.names = FALSE, quote = FALSE)

print(summary_results)
