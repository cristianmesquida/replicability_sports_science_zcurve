# Load package
library(here)

# Load function to estimate inter-rater agreement between 3 and 2 coders
source(here("r_scripts", "intercoder_agreement", "02_intercoder_agreement_function.R"))


# Inter-rater agreement between 3 coders: Fleiss' kappa
# Calculate Fleiss' kappa by coded variable
agreement_3_coders <- calculate_kappa3_from_excel(here("data/disagreements3.xlsx"))

# Average Fleiss' kappa
# Calculate average Fleiss' kappa for "support_hypothesis", "type_hypothesis" and
# "statistical_result", "type_effect"
average_fleiss <- round(mean(agreement_3_coders[c(16, 17, 19, 20), 2]), 2)

# Inter-rater agreement between 2 coders: Cohen's kappa
# Calculate Cohen's kappa by coded variable
agreement_2_coders <- calculate_kappa2_from_excel(here("data/disagreements2.xlsx")) 

# Average Cohen's Kappa
# Calculate average Cohen's Kappa for "support_hypothesis", "type_hypothesis",
# "statistical_result" and "type_effect"
average_cohen <- round(mean(agreement_2_coders[c(16, 17, 19, 20), 2]), 2)

