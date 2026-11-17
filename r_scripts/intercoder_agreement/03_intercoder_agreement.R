# Load package
library(here)

# Load function to estimate inter-rater agreement between 3 and 2 coders
source(here("r_scripts", "intercoder_agreement", "02_intercoder_agreement_function.R"))


# Variables for which we report the average inter-rater agreement: the hypothesis
# and statistical-result coding decisions that feed the z-curve analysis
key_variables <- c("support_hypothesis", "type_hypothesis",
                    "statistical_result", "type_effect")

# Inter-rater agreement between 3 coders: Fleiss' kappa
# Calculate Fleiss' kappa by coded variable
agreement_3_coders <- calculate_kappa3_from_excel(here("data/disagreements3.xlsx"))

# Average Fleiss' kappa for the key variables (selected by name, not row position,
# so this does not silently break if `variable_names` is ever reordered)
average_fleiss <- round(mean(agreement_3_coders$fleiss_kappa[agreement_3_coders$variable %in% key_variables]), 2)

# Inter-rater agreement between 2 coders: Cohen's kappa
# Calculate Cohen's kappa by coded variable
agreement_2_coders <- calculate_kappa2_from_excel(here("data/disagreements2.xlsx"))

# Average Cohen's Kappa for the key variables (selected by name, not row position)
average_cohen <- round(mean(agreement_2_coders$cohen_kappa[agreement_2_coders$variable %in% key_variables]), 2)

