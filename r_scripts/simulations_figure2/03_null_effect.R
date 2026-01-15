## This R script was used to imulate p-values when there is no effect 

# For reproducibility purposes
set.seed(1234) 

# Set parameters to run simulation
n <- 139       # group sample size
mean_diff <- 0 # mean difference
sd <- 1        # standard deviation
nsims <- 300   # number of simulations

# Simulation of studies investigating a null effect with 139 participants per group
null_effect <- run_simulation(n = n, mean_diff = mean_diff, sd = sd, nsims = nsims)

# Execute to load functions to simulate data and count the number of p-values < 0.05
source(here::here("r_scripts","simulations_figure2", "01_functions.R")) 

# Number of significant p-values
power_function(null_effect$p_value)


