## This script contains two functions:
## 1) run_simulation() to generate p-values for a two-group design given a sample 
##    size, mean difference and standard deviation.
## 2) power_function() to count the number of p-values below certain significant thresholds


## 1) Function to conduct a single simulation with specified parameters
run_simulation <- function(n, mean_diff, sd, nsims) {
  p_values <- numeric(nsims)
  effect_sizes <- numeric(nsims)

  for (i in 1:nsims) {
    # Generate data for two groups
    group1 <- rnorm(n, mean = mean_diff, sd = sd)
    group2 <- rnorm(n, mean = 0, sd = sd)

    # Perform t-test
    t_test <- t.test(group1, group2, var.equal = TRUE, alternative = "greater")

    # Store p-value
    p_values[i] <- t_test$p.value

    # Calculate effect size (Cohen's ds)
    pooled_sd <- sqrt(((n - 1) * var(group1) + (n - 1) * var(group2)) / (2 * n - 2))
    effect_sizes[i] <- (mean(group1) - mean(group2)) / pooled_sd
  }

  return(data.frame(p_value = p_values, effect_size = effect_sizes))
}


## 2) Function that return the number of p-values smaller than a specific threshold
power_function <- function(p_value) {
  less_than_05 <- sum(p_value < 0.05)
  between_01_and_05 <- sum(p_value > 0.01 & p_value < 0.05)
  less_than_01 <- sum(p_value < 0.01)
  
  return(list(
    "p < 0.01" = less_than_01,
    "0.01 <= p < 0.05" = between_01_and_05,
    "p < 0.05" = less_than_05
  ))
}

