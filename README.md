This repository contains all materials, data and code to reproduce the analyses presented in our manuscript. It includes the study preregistration, the raw data, R scripts and R Markdown files used to generate the results. Below is an overview of the structure of this repository and a brief description of the files.

Manuscript
The folder manuscript/ contains the following documents:
-	preprint: a PDF document containing the preprint of the study. 
-	preregistration: a PDF document containing the preregistration.

Materials
The folder materials/ contains:
-	supplementary_information: a PDF document with the formulas used to recompute p-values from standardized effect sizes.
-	coding_form: a PDF document with the coding scheme used to code data from sampled studies. This coding scheme was applied in two projects: (1) the reproducibility of a priori power analyses and (2) a z-curve analysis.

Data
The folder raw_data/ contains:
-	raw_data.xlsx contains the original dataset that was double and triple coded. This is the raw data before any steps were taken to resolve disagreements.
-	disgreements3.xlsx: each sheet in this file corresponds to a variable that was triple coded. This dataset was used to compare responses between coders and resolve disagreements.
-	disgreements2.xlsx: each sheet in this file corresponds to a variable that was double coded. This dataset was used to compare responses between coders and resolve disagreements.
-	processed_data contains the dataset after resolving disagreements. This dataset contains data used for both projects: (1) the reproducibility of a priori power analyses and (2) a z-curve analysis.
-	consolidated_data_zcurve.xlsx contains the raw data used in this manuscript.
-	zcurve_analysis.xlsx expands on “consolidated_data_zcurve.xlsx” by containing manually created columns to recompute p-values reported imprecisely (e.g., p < 0.05). This dataset cannot be fully recreated in R due to manual modifications. It is the dataset used for the z-curve analysis.

Code
The folder r_scripts/ contains all analysis scripts that were used to compute all results presented in the manuscript.
-	power_plot.R contains the code to generate Figure 1 in the manuscript.
-	The subfolder process_raw_data contains datasets used in this manuscript.
-	01_checking_disagreements.R produces files “disgreements3.xlsx” and “disgreements2.xlsx”.
-	02_intercoder_agreement_function.R contains the functions used to assess intercoder agreement.
-	03_intercoder_agreement.Rmd an R Markdown document presenting the results of the intercoder agreement across variables.
-	04_consolidate_data.R merges columns from “disgreements3.xlsx” and “disgreements2.xlsx” containing responses after disagreements have been resolved.
-	The subfolder simulations_figure2/ contains the code for simulating all plots presented in Figure 2 of the manuscript, as well as the code used to generate Figure 2 itself and the results of Table 2. This subfolder contains:
-	01_functions.R contains a function used in “02_evidential_value.R”, “03_null _effect.R” and “06_mixed.R”.
-	02_evidential_value.R contains code to generate data for Figure 2a.
-	03_null_effect.R contains code to generate data for Figure 2b.
-	04_publication_bias.R contains code to generate data for Figure 2c.
-	05_mild_optional_stopping.R contains code to generate data for Figure 2d.
-	06_mixed.R contains code to generate data for Figure 2e.
-	07_figure2_and_table2.Rmd: an R Markdown documents containing the code to generate Figure 2 and the results presented in Table 2 of the manuscript.
-	zcurve  _analysis.R: an R Markdown document with the results of the z-curve analysis and the code to generate Figure 3.
