## This R script was used to:
## 1) simulate p-values in the presence of publication bias when there is a true effect
## 2) conduct the corresponding zcurve analysis


# Load packages
library(zcurve) 

# For reproducibility purposes
set.seed(1111) 


## 1) Simulate studies in the presence of publication bias

nsims <- 440 # number of simulated experiments
n <- 15 # set group sample size

# Create a data frame to store results from the simulation
data <- data.frame(pvalues = NA, es = NA)


for (i in 1:nsims){
  x <- rnorm(n = n, mean = 0.3, sd = 1)
  y <- rnorm(n = n, mean = 0, sd = 1)
  p <- t.test(x, y, alternative = "greater", var.equal = TRUE)$p.value
  pooled_sd <- sqrt(((n - 1) * var(x) + (n - 1) * var(y)) / (2 * n - 2))
  es <- (mean(x) - mean(y)) / pooled_sd
  data[i, 1] <- p
  data[i, 2] <- es
}

# We remove 40% of non-significant p-values
non_significant <- which(data$pvalues > 0.05)
remove_count <- round(length(non_significant) * 0.40)
remove_indices <- sample(non_significant, remove_count)
p_values_filtered <- data$pvalues[-remove_indices]

## 2) z-curve analysis
zcurve_publication_bias <- zcurve(p = p_values_filtered)
summary(zcurve_publication_bias, all = TRUE)

