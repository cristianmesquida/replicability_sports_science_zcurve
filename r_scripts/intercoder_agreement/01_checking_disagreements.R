## This script was used to:
## 1) organize the data collected "raw_data.xlsx" from 350 studies
## 2) split "raw_data.xlsx" into two data files (i.e., disagreements2.xlsx and 
##    disagreements3.xlsc) depending on whether studies were double or triple coded


# Load packages
library(readxl)
library(writexl)
library(here)
library(dplyr)

# Read file where all data from 350 studies was recorded
data <- read_xlsx(here("data", "raw_data.xlsx")) 
data <- data[, -ncol(data)] #remove last column


## 1) Rename columns 
colnames(data)[colnames(data) == 'Select coder'] <- 'coder'
colnames(data)[colnames(data) == 'Select the journal'] <- 'journal'

full_data <- as.data.frame(do.call(data.frame, lapply(data, trimws)))


## 2) Checking the number of unique IDs per journal 
grouped_data <- group_by(full_data, journal)
unique_ids_per_journal <- summarize(grouped_data, unique_ids = n_distinct(ID))


## 3) Split "raw_data.xlsx" into two files, namely "disagreements3.xlsx" and 
## "disagreements2.xlsx"

# Rewrite full data set into one file per study 
study_ids <- unique(grouped_data$ID) 
study_ids <- unique(full_data$ID)
study_dataframes <- list()


# Loop through each study
for (study_id in study_ids) {
  study_data <- subset(data, ID == study_id)
  
  # Need to remove duplicate coders (sometimes 4 columns or more) --> no longer needed, we removed them manually 
  duplicated_coders <- duplicated(study_data$coder)
  study_data <- study_data[!duplicated_coders, ]

  transposed_data <- t(study_data)

  study_dataframes[[paste0("Study_", study_id)]] <- as.data.frame(transposed_data)
}

trial_study1 = study_dataframes[[2]] #test output


# Rewrite into one file per variable
# Issues with different number of columns, so splitted data in two dataframes 
list_of_47x2 <- list()
list_of_47x3 <- list()

for (df in study_dataframes) {
  if (ncol(df) == 2) {
    list_of_47x2 <- c(list_of_47x2, list(df))
  } else if (ncol(df) == 3) {
    list_of_47x3 <- c(list_of_47x3, list(df))
  }
}

# First 47x2 dataframes
variable_dataframes2 <- list()
for (row_index in 1:47) { # hard-coded for now, change for number of variables 
  variable_df <- data.frame()
  
  for (df in list_of_47x2) {
    row <- df[row_index, ]
    variable_df <- rbind(variable_df, row)
  }
  
  variable_dataframes2[[row_index]] <- variable_df
}

test_variable <- variable_dataframes2[[3]] #test output


# Also 47x3 dataframes
variable_dataframes3 <- list()
for (row_index in 1:47) { # hard-coded for now, change for number of variables 
  variable_df <- data.frame()
  
  for (df in list_of_47x3) {
    row <- df[row_index, ]
    variable_df <- rbind(variable_df, row)
  }
  
  variable_dataframes3[[row_index]] <- variable_df
}


## 4) Check for disagreements
# Disagreements between 3 coders
for (i in seq_along(variable_dataframes3)) {
  df <- variable_dataframes3[[i]]
  
  # New column to check for disagreements
  df$are_values_equal <- apply(df, 1, function(row) length(unique(row)) == 1)
  
  variable_dataframes3[[i]] <- df
}

test_disagreements <- variable_dataframes3[[3]] #test output

# Store data in a file called "disagreements3.xlsx"
write_xlsx(variable_dataframes3, here("data", "disagreements3.xlsx"))



## Disagreements between 2 coders
for (i in seq_along(variable_dataframes2)) {
  df <- variable_dataframes2[[i]]
  
  # New column to check for disagreements
  df$are_values_equal <- apply(df, 1, function(row) length(unique(row)) == 1)
  
  variable_dataframes2[[i]] <- df
}

test_disagreements2 <- variable_dataframes2[[3]] #test output

# Store data in a file called "disagreements2.xlsx"
write_xlsx(variable_dataframes2, here("data", "disagreements2.xlsx"))

