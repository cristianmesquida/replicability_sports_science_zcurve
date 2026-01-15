## This R script was used to: 
## 1) simulate studies designed with high, medium and low power and investigating a null effect
## 2) simulate studies in the presence of publication bias
## 3) simulate mild optional stopping

# For reproducibility purposes
set.seed(1234) 

## Simulate 300 p-values from studies with high-, medium- and low-power designs 
# to detect a Cohen's ds of 0.3 and and studies investigating a null effect
high_power <- run_simulation(n = 139, mean_diff = 0.3, sd = 1, nsims = 100)
medium_power <- run_simulation(n = 50, mean_diff = 0.3, sd = 1, nsims = 100)
low_power <- run_simulation(n = 13, mean_diff = 0.3, sd = 1, nsims = 100)

# Combine all above studies
no_bias <- c(high_power$p_value, medium_power$p_value, 
             low_power$p_value)

## 2) Publication bias
# Randmonly remove 30% of non-significant p-values
non_significant <- which(no_bias > 0.05)
remove_count <- round(length(non_significant) * 0.30)
remove_indices <- sample(non_significant, remove_count)
p_values_filtered <- no_bias[-remove_indices]

## 3) Severe optional stopping
# Set parameters to simulate optional stopping
N <- 50             # total data points (per condition)
looks <- 50         # set number of looks at the data
nsims <- 1000       # number of simulated studies
alphalevel <- 0.05  # set alpha level

set.seed(1234) # for reproducibility purposes

if(looks > 1){
  look_at_n <- ceiling(seq(N / looks, N, (N - (N / looks)) / (looks - 1)))
}  else {
  look_at_n <- N
}
look_at_n <- look_at_n[look_at_n > 2] # Remove looks at N of 1 or 2
looks<-length(look_at_n) # if looks are removed, update number of looks

matp <- matrix(NA, nrow = nsims, ncol = looks) # Matrix for p-values l tests
p <- numeric(nsims) # Variable to save pvalues

# Loop data generation for each study, then loop to perform a test for each N
for (i in 1:nsims) {
  x <- rnorm(n = N, mean = 0, sd = 1)
  y <- rnorm(n = N, mean = 0, sd = 1)
  for (j in 1:looks) {
    matp[i, j] <- t.test(x[1:look_at_n[j]], y[1:look_at_n[j]],
                         var.equal = TRUE, alternative = "greater")$p.value # perform the t-test, store
  }
  cat("Loop", i, "of", nsims, "\n")
}

# Save Type 1 error rate smallest p at all looks
for (i in 1:nsims) {
  p[i] <- ifelse(length(matp[i,which(matp[i,] < alphalevel)]) == 0,
                 matp[i,looks], matp[i,which(matp[i,] < alphalevel)])
}

# Randomly select significant p-values obtained through optional stopping
phacked <- p[p >= 0.01 & p <= 0.05]
phacked <- sample(phacked, 300 - length(p_values_filtered))

# Combine all simulated p-values
mixed <- c(p_values_filtered, phacked)


