## This R script was used to:
## 1) simulate p-values when there is no effect 
## 2) conduct the corresponding z-curve analysis


# Load package
library(zcurve) 


# Execute to load functions to simulate data and count the number of p-values < 0.05
source(here::here("r_scripts","simulations_figure2", "01_functions.R")) 


set.seed(1234) # for reproducibility purposes


## 1) Simulate studies when there is no effect

# Set parameters to run simulation
n <- 139 # group sample size
mean_diff <- 0 # mean difference
sd <- 1 # standard deviation
nsims <- 300 # number of simulations


# Simulation of studies investigating a null effect with 139 participants per group
null_effect <- run_simulation(n = n, mean_diff = mean_diff, sd = sd, nsims = nsims)


## 2) zcurve analysis
zcurve_null_effect <- zcurve(p = null_effect$p_value)
summary(zcurve_null_effect, all = TRUE)


# Number of significant p-values
power_function(null_effect$p_value)


