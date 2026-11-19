# Load packages
library(here)
library(dplyr)

# Load function to estimate inter-rater agreement between 3 and 2 coders
source(here("r_scripts", "intercoder_agreement", "02_intercoder_agreement_function.R"))

# Inter-rater agreement between 3 coders: Fleiss' kappa
# Calculate Fleiss' kappa by coded variable
agreement_3_coders <- calculate_kappa3_from_excel(here("data", "disagreements", "disagreements3.xlsx"))

# Inter-rater agreement between 2 coders: Cohen's kappa
# Calculate Cohen's kappa by coded variable
agreement_2_coders <- calculate_kappa2_from_excel(here("data", "disagreements", "disagreements2.xlsx"))

# Combine both rounds into a single table, one row per coded variable
intercoder_agreement <- full_join(agreement_3_coders, agreement_2_coders, by = "variable")

# Save the full inter-coder agreement table so the manuscript can report it
# without re-running the kappa computations at render time. Which variables
# are the "variables of interest" to average over is decided in the
# manuscript itself, for transparency.
saveRDS(intercoder_agreement, here("output", "intercoder_agreement.rds"))

