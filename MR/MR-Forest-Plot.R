#library(TwoSampleMR)
library(data.table)
library(forestplot)
library(ggplot2)
library(dplyr)

# res_FGTP_with_ECAC <- fread("~/MR/FGTP_with_trait/results/res_FGTP_with_ECAC.txt", header = TRUE)
# res_FGTP_with_OCAC <- fread("~/MR/FGTP_with_trait/results/res_FGTP_with_OCAC.txt", header = TRUE)
# res_FGTP_with_ENDO <- fread("~/MR/FGTP_with_trait/results/res_FGTP_with_ENDO.txt", header = TRUE)
# res_FGTP_with_UF <- fread("~/MR/FGTP_with_trait/results/res_FGTP_with_UF.txt", header = TRUE)
# res_FGTP_with_PCOS <- fread("~/MR/FGTP_with_trait/results/res_FGTP_with_PCOS.txt", header = TRUE)
# res_FGTP_with_BCAC <- fread("~/MR/FGTP_with_trait/results/res_FGTP_with_BCAC.txt", header = TRUE)
# res_FGTP_with_CCAC <- fread("~/MR/FGTP_with_trait/results/res_FGTP_with_CCAC.txt", header = TRUE)
# res_FGTP_with_GIP <- fread("~/MR/FGTP_with_trait/results/res_FGTP_with_GIP.txt", header = TRUE)
# res_FGTP_with_ECAC_noUKBB <- fread("~/MR/FGTP_with_trait/results/res_FGTP_with_ECAC_noUKBB.txt", header = TRUE)

#forward
# res_FGTP_with_ECAC <- fread("~/MR/MR_endo_polyps/output/27_SNPs/res_FGTP_with_ECAC.txt", header = TRUE)
# res_FGTP_with_OCAC <- fread("~/MR/MR_endo_polyps/output/27_SNPs/res_FGTP_with_OCAC.txt", header = TRUE)
# res_FGTP_with_ENDO <- fread("~/MR/MR_endo_polyps/output/27_SNPs/res_FGTP_with_ENDO.txt", header = TRUE)
# res_FGTP_with_UF <- fread("~/MR/MR_endo_polyps/output/27_SNPs/res_FGTP_with_UF.txt", header = TRUE)
# res_FGTP_with_PCOS <- fread("~/MR/MR_endo_polyps/output/27_SNPs/res_FGTP_with_PCOS.txt", header = TRUE)
# res_FGTP_with_BCAC <- fread("~/MR/MR_endo_polyps/output/27_SNPs/res_FGTP_with_BCAC.txt", header = TRUE)
# res_FGTP_with_CCAC <- fread("~/MR/MR_endo_polyps/output/27_SNPs/res_FGTP_with_CCAC.txt", header = TRUE)
# #res_FGTP_with_GIP <- fread("~/MR/MR_endo_polyps/output/27_SNPs/res_FGTP_with_GIP.txt", header = TRUE)
# res_FGTP_with_ECAC_noUKBB <- fread("~/MR/MR_endo_polyps/output/27_SNPs/res_FGTP_with_ECAC2018_noUKBB.txt", header = TRUE)


#reverse
res_FGTP_with_ECAC <- fread("~/MR/MR_endo_polyps/output/reverse_27_SNPs/res_FGTP_with_ECAC.txt", header = TRUE)
res_FGTP_with_OCAC <- fread("~/MR/MR_endo_polyps/output/reverse_27_SNPs/res_FGTP_with_OCAC.txt", header = TRUE)
res_FGTP_with_ENDO <- fread("~/MR/MR_endo_polyps/output/reverse_27_SNPs/res_FGTP_with_ENDO.txt", header = TRUE)
res_FGTP_with_UF <- fread("~/MR/MR_endo_polyps/output/reverse_27_SNPs/res_FGTP_with_UF.txt", header = TRUE)
res_FGTP_with_PCOS <- fread("~/MR/MR_endo_polyps/output/reverse_27_SNPs/res_FGTP_with_PCOS.txt", header = TRUE)
res_FGTP_with_BCAC <- fread("~/MR/MR_endo_polyps/output/reverse_27_SNPs/res_FGTP_with_BCAC.txt", header = TRUE)
res_FGTP_with_CCAC <- fread("~/MR/MR_endo_polyps/output/reverse_27_SNPs/res_FGTP_with_CCAC.txt", header = TRUE)
#res_FGTP_with_GIP <- fread("~/MR/MR_endo_polyps/output/reverse_27_SNPs/res_FGTP_with_GIP.txt", header = TRUE)
res_FGTP_with_ECAC_noUKBB <- fread("~/MR/MR_endo_polyps/output/reverse_27_SNPs/res_FGTP_with_ECAC2018_noUKBB.txt", header = TRUE)


#
# #ECAC data frame prep
# res_FGTP_with_ECAC$lower_ci <- res_FGTP_with_ECAC$b - (1.96 * res_FGTP_with_ECAC$se)
# res_FGTP_with_ECAC$upper_ci <- res_FGTP_with_ECAC$b + (1.96 * res_FGTP_with_ECAC$se)
# res_FGTP_with_ECAC$lo <- exp(res_FGTP_with_ECAC$lower_ci)
# res_FGTP_with_ECAC$up <- exp(res_FGTP_with_ECAC$upper_ci)
#
# #OCAC data frame prep
# res_FGTP_with_OCAC$lower_ci <- res_FGTP_with_OCAC$b - (1.96 * res_FGTP_with_OCAC$se)
# res_FGTP_with_OCAC$upper_ci <- res_FGTP_with_OCAC$b + (1.96 * res_FGTP_with_OCAC$se)
# res_FGTP_with_OCAC$lo <- exp(res_FGTP_with_OCAC$lower_ci)
# res_FGTP_with_OCAC$up <- exp(res_FGTP_with_OCAC$upper_ci)
#
# #ENDO data frame prep
# res_FGTP_with_ENDO$lower_ci <- res_FGTP_with_ENDO$b - (1.96 * res_FGTP_with_ENDO$se)
# res_FGTP_with_ENDO$upper_ci <- res_FGTP_with_ENDO$b + (1.96 * res_FGTP_with_ENDO$se)
# res_FGTP_with_ENDO$lo <- exp(res_FGTP_with_ENDO$lower_ci)
# res_FGTP_with_ENDO$up <- exp(res_FGTP_with_ENDO$upper_ci)
#
# #UF data frame prep
# res_FGTP_with_UF$lower_ci <- res_FGTP_with_UF$b - (1.96 * res_FGTP_with_UF$se)
# res_FGTP_with_UF$upper_ci <- res_FGTP_with_UF$b + (1.96 * res_FGTP_with_UF$se)
# res_FGTP_with_UF$lo <- exp(res_FGTP_with_UF$lower_ci)
# res_FGTP_with_UF$up <- exp(res_FGTP_with_UF$upper_ci)
#
# #PCOS data fram prep
# res_FGTP_with_PCOS$lower_ci <- res_FGTP_with_PCOS$b - (1.96 * res_FGTP_with_PCOS$se)
# res_FGTP_with_PCOS$upper_ci <- res_FGTP_with_PCOS$b + (1.96 * res_FGTP_with_PCOS$se)
# res_FGTP_with_PCOS$lo <- exp(res_FGTP_with_PCOS$lower_ci)
# res_FGTP_with_PCOS$up <- exp(res_FGTP_with_PCOS$upper_ci)
#
# #BCAC data frame prep
# res_FGTP_with_BCAC$lower_ci <- res_FGTP_with_BCAC$b - (1.96 * res_FGTP_with_BCAC$se)
# res_FGTP_with_BCAC$upper_ci <- res_FGTP_with_BCAC$b + (1.96 * res_FGTP_with_BCAC$se)
# res_FGTP_with_BCAC$lo <- exp(res_FGTP_with_BCAC$lower_ci)
# res_FGTP_with_BCAC$up <- exp(res_FGTP_with_BCAC$upper_ci)
#
# #CCAC data frame prep
# res_FGTP_with_CCAC$lower_ci <- res_FGTP_with_CCAC$b - (1.96 * res_FGTP_with_CCAC$se)
# res_FGTP_with_CCAC$upper_ci <- res_FGTP_with_CCAC$b + (1.96 * res_FGTP_with_CCAC$se)
# res_FGTP_with_CCAC$lo <- exp(res_FGTP_with_CCAC$lower_ci)
# res_FGTP_with_CCAC$up <- exp(res_FGTP_with_CCAC$upper_ci)
#
# #GIP data frame prep
# res_FGTP_with_GIP$lower_ci <- res_FGTP_with_GIP$b - (1.96 * res_FGTP_with_GIP$se)
# res_FGTP_with_GIP$upper_ci <- res_FGTP_with_GIP$b + (1.96 * res_FGTP_with_GIP$se)
# res_FGTP_with_GIP$lo <- exp(res_FGTP_with_GIP$lower_ci)
# res_FGTP_with_GIP$up <- exp(res_FGTP_with_GIP$upper_ci)
#
# #ECAC noUKBB data frame prep
# res_FGTP_with_ECAC_noUKBB$lower_ci <- res_FGTP_with_ECAC_noUKBB$b - (1.96 * res_FGTP_with_ECAC_noUKBB$se)
# res_FGTP_with_ECAC_noUKBB$upper_ci <- res_FGTP_with_ECAC_noUKBB$b + (1.96 * res_FGTP_with_ECAC_noUKBB$se)
# res_FGTP_with_ECAC_noUKBB$lo <- exp(res_FGTP_with_ECAC_noUKBB$lower_ci)
# res_FGTP_with_ECAC_noUKBB$up <- exp(res_FGTP_with_ECAC_noUKBB$upper_ci)

# png(file = "~/MR/MR_endo_polyps/output/Forest_plot_MR_poster.png", width = 13, height = 4, res = 300)
# forest_data |>
#   forestplot(
#     labeltext = c(identifier, OR_text),
#     mean = OR,
#     lower = lo,
#     upper = up,
#     txt_gp = fpTxtGp(label = gpar(cex = 1.2),
#                      ticks = gpar(cex = 1.2),
#                      xlab = gpar(cex = 1.2)),
#     col = fpColors(box = "royalblue", lines = "darkblue", zero = "red"),
#     zero = 1,
#     boxsize = 0.3,
#     lwd.ci = 1,
#     ci.vertices = TRUE,
#     xticks = c(0.6, 1, 1.8),
#     xlab = "Odds Ratio (95% CI)",
#     title = "Mendelian Randomisation"
#   ) |>
#  fp_add_header(identifier="Trait",OR_text="OR (95% CI)")
#
# dev.off()

#####################################################################
# combined_results |>
#   forestplot(
#     labeltext = c(outcome, method, OR_round),
#     mean = OR,
#     lower = lo,
#     upper = up,
#     txt_gp = fpTxtGp(label = gpar(cex = 0.8),
#                      ticks = gpar(cex = 0.8),
#                      xlab = gpar(cex = 0.8)),
#     col = fpColors(box = "royalblue", lines = "darkblue", zero = "red"),
#     zero = 1,
#     boxsize = 0.2,
#     lwd.ci = 1,
#     ci.vertices = TRUE,
#     xticks = c(0.5, 1, 2, 4),
#     xlab = "Odds Ratio (95% CI)",
#     title = "Forest Plot of MR Results"
#   ) |>
#   fp_add_header(outcome="Outcome",method="Method",OR_round="OR")


# Assuming combined_results is your original data frame
# Create a new column for label text
combined_results <- combined_results %>%
  mutate(outcome_label = ifelse(duplicated(identifier), "", paste0(identifier, ' (', nsnp, ")")),
         method = ifelse(method == "Inverse variance weighted", "IVW", method))

# Create a data frame for empty lines
empty_lines <- data.frame(
  outcome_label = NA,
  method = NA,
  OR = NA,
  lo = NA,
  up = NA,
  OR_round = NA
)

# Combine original results with empty lines after each unique outcome
combined_with_empty <- combined_results %>%
  group_by(outcome) %>%
  do(bind_rows(., empty_lines)) %>%
  ungroup()

# Replace in the inverse variance weighted with IVW
#combined_with_empty$method <- gsub("Inverse variance weighted", "IVW", combined_with_empty$method, ignore.case = TRUE)


png(file = "~/MR/MR_endo_polyps/output/27_SNPs/Forest_plot_MR_all_traits_sample_overlap.png", width = 1900, height = 2600, res = 300)

#forward
# Now use combined_with_empty for the forest plot
combined_with_empty |>
  forestplot(
    labeltext = c(outcome_label, method, OR_round),
    mean = OR,
    lower = lo,
    upper = up,
    txt_gp = fpTxtGp(label = gpar(cex = 0.9),
                     ticks = gpar(cex = 0.8),
                     xlab = gpar(cex = 0.8)),
    col = fpColors(box = "royalblue", lines = "darkblue", zero = "red"),
    zero = 1,
    boxsize = 0.2,
    lwd.ci = 1,
    ci.vertices = TRUE,
    xticks = c(0.5, 1, 1.5, 2, 2.5),
    xlab = "Odds Ratio (95% CI)",
    title = "MR Forest Plot of FGT Polyps (Exposure) vs Multiple Outcomes"
  ) |>
  fp_add_header(outcome_label="Outcome (N SNPs)", method="Method", OR_round="OR")

dev.off()

write.table(combined_results, file = "~/MR/MR_endo_polyps/output/27_SNPs/combined_results_with_sample_overlap_all_traits.txt", sep = "\t", row.names = FALSE, quote = FALSE)

#reverse
png(file = "~/MR/MR_endo_polyps/output/reverse_27_SNPs/Forest_plot_MR_all_traits_sample_overlap_reverse.png", width = 1900, height = 2600, res = 300)

combined_with_empty |>
  forestplot(
    labeltext = c(outcome_label, method, OR_round),
    mean = OR,
    lower = lo,
    upper = up,
    txt_gp = fpTxtGp(label = gpar(cex = 0.9),
                     ticks = gpar(cex = 0.8),
                     xlab = gpar(cex = 0.8)),
    col = fpColors(box = "royalblue", lines = "darkblue", zero = "red"),
    zero = 1,
    boxsize = 0.2,
    lwd.ci = 1,
    ci.vertices = TRUE,
    xticks = c(0.75, 1, 1.5),
    xlab = "Odds Ratio (95% CI)",
    title = "MR Forest Plot of Multiple Exposures vs FGT Polyps (Outcome)"
  ) |>
  fp_add_header(outcome_label="Outcome", method="Method", OR_round="OR")

dev.off()
