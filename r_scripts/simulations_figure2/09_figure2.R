## This R script used to create Figure 2

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

#-----------------------------------------------------------------------------#

### Create all individual plots that are part of Figure 2

# Create a list with the results of each simulation (scenario)
zcurve_list <- list(zcurve_evidential_value,
                           zcurve_null_effect,
                           zcurve_publication_bias,
                           zcurve_publication_bias_and_null_effect,
                           zcurve_mild_optional_stopping,
                           zcurve_mixed)

# Create a vector with the names of the plots
files <- c(
  "figure2a.png",
  "figure2b.png",
  "figure2c.png",
  "figure2d.png",
  "figure2e.png",
  "figure2f.png"
)

# Use walk2() to itinerate the process of saving each plot as a .png file
walk2(zcurve_list, files, ~ {
  png(here("figures", .y), width = 900, height = 900, res = 200)
  plot(
    .x,
    CI = TRUE,
    annotation = FALSE,
    main = ""
  )
  dev.off()
})


