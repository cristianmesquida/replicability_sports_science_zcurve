# Repository
This repository contains all materials, data, and code required to reproduce the analyses presented in our manuscript, as well as the manuscript itself, written in Quarto.

# Project structure
```
replicability_sports_science_zcurve/
├── preregistration_OSF.pdf # Preregistration document
|
├── manuscript/ 
│   ├── preprint.pdf       # Preprint of the study
│   ├── manuscript.qmd     # Quarto document to fully reproduce the manuscript
|   └── references.bib     # Bib file contianing the references used in the manuscript
|
├── materials/ 
│   ├── supplementary_information.pdf # Formulas to recompute p-values
│   └── coding_form.pdf               # Coding scheme used in two projects
|
├── data/ 
│   ├── raw_data.xlsx                  # Original dataset before resolving disagreements
│   ├── disagreements3.xlsx            # Triple-coded dataset to resolve disagreements
│   ├── disagreements2.xlsx            # Double-coded dataset to resolve disagreements
│   ├── processed_data.xlsx            # Dataset after resolving disagreements
│   ├── consolidated_data_zcurve.xlsx  # Raw data used in this manuscript
│   ├── zcurve_analysis.xlsx           # Dataset with manual modifications for z-curve analysis
|   ├── simulations.RDS                # Contains the data simulated for Figure 2 and Table 2
|   └── table2.RDS                     # Results stored from Table 2
|
├── r_scripts/️
│   ├── power_plot.R                              # Generates Figure 1
│   └── simulations_figure2/                      # Code and results for Figure 2 and Table 2
│       ├── 01_functions.R                        # Functions used by other scripts
│       ├── 02_evidential_value.R                 # Generates data for Figure 2a
│       ├── 03_null_effect.R                      # Generates data for Figure 2b
│       ├── 04_publication_bias.R                 # Generates data for Figure 2c
|       ├── 05_publication_bias_and_null_effect.R # Generates data for Figure 2c
│       ├── 06_mild_optional_stopping.R           # Generates data for Figure 2d
│       ├── 07_mixed.R                            # Generates data for Figure 2e
│       ├── 08_run_simulations.R                  # Run scripts 02-07
|       ├── 09_figure2.R                          # Creates Figure 2
|       ├── 10_table2.R                           # Creates Table 2
|   ├── intercoder_agreement/
│       ├── 01_checking_disagreements.R         # Produces disagreements3.xlsx & disagreements2.xlsx
│       ├── 02_intercoder_agreement_function.R  # Functions to assess intercoder agreement
│       ├── 03_intercoder_agreement.Rmd         # Results of intercoder agreement across variables
│       └── 04_consolidate_data.R               # Merges columns after resolving disagreements
|   ├── zcurve_analysis.Rmd                     # Includes the the number of studies per journal, descriptive statistics regarding how p-values were reported and the z-curve analysis on the 350 independent p-values and creates Figure 3
|   └── zcurve_sensitivity_analysis.Rmd         # Includes the z-curves conduced as sensitivity analyses 
|
└── figures/ 
    ├── figure2.png.             # Contains the 6 z-curve plots created using simulated data
    ├── figure3.png.             # Contains the z-curve plot of the 350 independent p-values
    └── secondary_zcurve.png.    # Contains the z-curve plot of the z-curve analysis conducted as a sensitivity analysis
```
