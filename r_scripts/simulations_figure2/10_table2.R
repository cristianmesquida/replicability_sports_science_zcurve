## This R script used to create Table 2

# Load package
library(here)
library(zcurve)
library(purrr)

# Load data
scenarios <- readRDS("data/simulations.RDS")

# Conduct a z-curve on each simulated scenario
zcurve_list <- map(
  scenarios,
  ~ zcurve(p = .x)
)

# Store each result as an individual object
list2env(
  set_names(
    zcurve_list,
    paste0("zcurve_", names(zcurve_list))
  ),
  envir = .GlobalEnv
)


### Create Table 2

zcurve_list <- list(
  zcurve_evidential_value,
  zcurve_null_effect,
  zcurve_publication_bias,
  zcurve_publication_bias_and_null_effect,
  zcurve_mild_optional_stopping,
  zcurve_mixed
)

# Conduct a z-curve analysis on each simulation 
res_list <- lapply(zcurve_list, function(x) summary(x, all = TRUE))

# Create a function to extract information for each scenario
extract_metrics <- function(zcurve_obj) {
  s <- summary(zcurve_obj, all = TRUE)
  coefs <- s$coefficients
  
  fmt <- function(row) {
    sprintf("%d [%d; %d]", 
            round(row["Estimate"]*100, 0),
            round(row["l.CI"]*100, 0),
            round(row["u.CI"]*100, 0))
  }
  
  data.frame(
    ERR = fmt(coefs["ERR", ]),
    EDR = fmt(coefs["EDR", ]),
    `Soric FDR` = fmt(coefs["Soric FDR", ]),
    stringsAsFactors = FALSE,
    check.names = FALSE
  )
}


# Use the created function
sim_conditions <- c(
  "1",
  "2",
  "3",
  "4",
  "5",
  "6"
)

results_df <- do.call(rbind, lapply(zcurve_list, extract_metrics))
results_df$Scenario <- sim_conditions
results_df <- results_df[, c("Scenario", "ERR", "EDR", "Soric FDR")]

# Manually report ODR values (estimate, lower CI, upper CI) as numeric vectors
odr_values <- list(
  "1" = c(0.82, 0.77, 0.86),
  "2" = c(0.04, 0.02, 0.07),
  "3" = c(0.30, 0.25, 0.36),
  "4" = c(0.33, 0.27, 0.38),
  "5" = c(0.14, 0.10, 0.19),
  "6" = c(0.62, 0.57, 0.68)
)

# Create a format function
format_odr <- function(x) sprintf("%.d [%d; %d]", round(x[1]*100, 0), round(x[2]*100, 0), round(x[3]*100, 0))

# Add ODR column
results_df$ODR <- sapply(results_df$Scenario, function(scn) format_odr(odr_values[[scn]]))

# Rearrange columns if you want ODR first
results_df <- results_df[, c("Scenario", "ODR", "ERR", "EDR", "Soric FDR")]

# Save results
saveRDS(results_df, "data/table2.rds")

