## This script was used to create Figure 1


# Load packages
library(dplyr)
library(ggplot2)
library(here)


# The formula for ODR is as follows: ODR = a*(1-t) + (1-B)*t, 
# where (1-B) = statistical power, a = alpha level, t = proportion of true hypothesis
power <- 100
a <- 0.05 
t <- 0.73
a*(1-t) + power*t # ODR

# If we aim to solve for power, the formula can be rearranged as follows: 
# 1-B = (ODR - a + a*t)/t
ODR <- 0.73 
a <- 0.05 
t <- 1
(ODR - a + a*t)/t # power


## Figure 1

# Set parameters
ODR <- c(0.73, 0.81) # observed discovery rate
a <- 0.05 # alpha level
t <- 1:1000 / 1000  # proportion of true hypotheses from 0.01 to 1.00

# Create a data frame to store the results
results <- expand.grid(ODR = ODR, t = t)
results$power <- (results$ODR -a + a*results$t)/results$t
results$ODR <- as.factor(results$ODR)
results <- results %>% filter(power < 1.5)

# Create Figure 1
figure1 <- ggplot(data = results) +
  geom_line(aes(y = power, x = t, linetype = ODR), size = 1) +
  scale_x_continuous(name="proportion of true hypotheses",
                     limits=c(0.6, 1),
                     breaks = c(seq(0.6, 1, 0.1)),
                     expand = c(0, 0)) +
  scale_y_continuous(name="average statistical power",
                     limits=c(0.6, 1),
                     breaks = c(seq(0.6, 1, 0.1)),
                     expand = c(0, 0)) +
  theme_bw()

print(figure1)

ggsave(here("figures", "figure1.pdf"), width = 10, height = 8, units = "cm")

