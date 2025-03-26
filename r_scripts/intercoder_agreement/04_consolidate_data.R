## This script was used to:
## 1) extract the "decision" column from "disagreements3.xlsx" and 
##    "disagreements2.xlsx" to create a data frame with 44 columns (one per each 
##     variable coded) and 350 rows (one row per study) and store it as 
##     "processed_data.xlsx"; and
## 2) Read "processed_data.xlsx", select the variables of interest for the
##    "z-curve" paper and store them in "consolidated_data_zcurve"

# Load packages
library(dplyr)
library(readxl)
library(here)
library(writexl)

## disagreements3 (double coded studies)
file_path <- "data/disagreements3.xlsx"

# File path
sheets <- excel_sheets(file_path)

# Select sheets 3 to 47
sheets_to_extract <- sheets[3:47]

# Initialize an empty list to store columns
decision_columns <- list()

# Loop through selected sheets and extract "decision" column
for (sheet in sheets_to_extract) {
  df <- read_excel(file_path, sheet = sheet)
  
  # Standardize column names
  colnames(df) <- tolower(colnames(df)) 
  
  if ("decision" %in% colnames(df)) {
    col_data <- df$decision  # Extract decision column
    
    # Ensure exactly 47 rows (fill with NA if needed)
    if (length(col_data) < 47) {
      col_data <- c(col_data, rep(NA, 47 - length(col_data)))
    } else {
      col_data <- col_data[1:47]  # Trim if more than 47 rows
    }
    
    decision_columns[[sheet]] <- col_data
  } else {
    decision_columns[[sheet]] <- rep(NA, 47)  # Fill entire column with NA if missing
  }
}

final_disagreements3 <- as.data.frame(decision_columns)


####---------------------------------------------------------------------------

## disagreements2 (triple coded studies)
file_path <- "data/disagreements2.xlsx"  


# Get all sheet names
sheets <- excel_sheets(file_path)

# Select sheets 3 to 47
sheets_to_extract <- sheets[3:47]

# Initialize an empty list to store columns
decision_columns <- list()

# Loop through selected sheets and extract "decision" column
for (sheet in sheets_to_extract) {
  df <- read_excel(file_path, sheet = sheet)
  
  # Standardize column names
  colnames(df) <- tolower(colnames(df)) 
  
  if ("decision" %in% colnames(df)) {
    col_data <- df$decision  # Extract decision column
    
    # Ensure exactly 303 rows (fill with NA if needed)
    if (length(col_data) < 303) {
      col_data <- c(col_data, rep(NA, 303 - length(col_data)))
    } else {
      col_data <- col_data[1:303]  # Trim if more than 47 rows
    }
    
    decision_columns[[sheet]] <- col_data
  } else {
    decision_columns[[sheet]] <- rep(NA, 303)  # Fill entire column with NA if missing
  }
}

final_disagreements2 <- as.data.frame(decision_columns)


# Merge both data frames 
processed_data <- rbind(final_disagreements3, final_disagreements2)    

# Change column names

colnames(processed_data) <- c("journal", 
                              "study_title", 
                              "power_analysis",
                              "any_power_statement", 
                              "a_priori_power_statement", 
                              "specified_dv_power", 
                              "dv_power", 
                              "dv_match", 
                              "power_sample", 
                              "type_es", 
                              "type_standardised_es", 
                              "type_cohen", 
                              "type_hedge", 
                              "magnitude_es", 
                              "es_justification", 
                              "sample_previous_study", 
                              "intended_power", 
                              "software", 
                              "statistical_test_power", 
                              "effect_power", 
                              "alpha_level", 
                              "statistical_test_study", 
                              "match_statistical_test", 
                              "hypothesis_statement", 
                              "type_hypothesis", 
                              "dv_hypothesis", 
                              "support_hypothesis",
                              "study_sample", 
                              "statistical_result", 
                              "comments", 
                              "type_effect", 
                              "df_t_test", 
                              "t_statistic", 
                              "p_t_test", 
                              "type_es_t_test", 
                              "ci_es_t_test", 
                              "df1_f_test", 
                              "df2_f_test", 
                              "f_ratio", 
                              "type_es_f_test", 
                              "ci_es_f_test",
                              "p_f_test",
                              "preregistration", 
                              "public_data_repository", 
                              "link_data_repository")


# Save newly created data set as "processed_data.xlsx"
write_xlsx(processed_data, here("data", "processed_data.xlsx"))


## 2) Create a file for "zcurve analysis" paper
read_xlsx(here("data","processed_data.xlsx")) %>% 
  select(journal, 
         study_title, 
         a_priori_power_statement, 
         hypothesis_statement, 
         type_hypothesis, 
         support_hypothesis,
         type_effect,
         statistical_result) %>% 
  write_xlsx(here("data", "consolidated_data_zcurve.xlsx"))

