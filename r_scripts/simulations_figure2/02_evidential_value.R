## This R script was used to:
## 1) simulate p-values from studies designed with high power (~80%) to detect 
##    a true effect (Cohen's ds = 0.3)
## 2) conduct the corresponding z-curve analysis


# Load packages
library(zcurve) 

# Load to simulate data and count the number of p-values < 0.05
source(here::here("r_scripts","simulations_figure2", "01_functions.R")) 

# For reproducibility purposes
set.seed(1100) 


## 1) Simulate studies

# Set parameters to run simulation
n <- 139 #  group sample size
mean_diff <- 0.3 # mean difference
sd <- 1 # standard deviation
nsims <- 300 # number of simulations


# Simulation of studies investigating a true effect of 0.3 with 139 participants per group
evidential_value <- run_simulation(n = n, mean_diff = mean_diff, sd = sd, nsims = nsims)


## 2) zcurve analysis
zcurve_evidential_value <- zcurve(p = evidential_value$p_value)
summary(zcurve_evidential_value, all = TRUE)


# Number of significant p-values
power_function(evidential_value$p_value)


