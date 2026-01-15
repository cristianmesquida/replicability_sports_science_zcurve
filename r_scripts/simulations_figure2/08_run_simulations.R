## This R script was used to run the scripts created to simulate data under each of the six scenarios

# Load package
library(here)

## Run the following scripts
scripts_to_run <- c(
  here("r_scripts", "simulations_figure2", "02_evidential_value.R"),
  here("r_scripts", "simulations_figure2", "03_null_effect.R"),
  here("r_scripts", "simulations_figure2", "04_publication_bias.R"),
  here("r_scripts", "simulations_figure2", "05_publication_bias_and_null_effect.R"),
  here("r_scripts", "simulations_figure2", "06_mild_optional_stopping.R"),
  here("r_scripts", "simulations_figure2", "07_mixed.R")
)

for (i in scripts_to_run) {
  source(i)
}

# Create a list
scenarios <- list(
  evidential_value = evidential_value$p_value,
  null_effect = null_effect$p_value,
  publication_bias = bias,
  publication_bias_and_null_effect = bias_null_effect,
  mild_optional_stopping = p,
  mixed = mixed
)

# Store simulated data for efficiency
saveRDS(scenarios, here("data", "simulations.RDS"))