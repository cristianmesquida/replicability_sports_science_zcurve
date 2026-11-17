# Repository
This repository contains all materials, data, and code required to reproduce the analyses presented in our manuscript, as well as the manuscript itself, written in Quarto.

# Project structure
```
replicability_sports_science_zcurve/
├── preregistration_OSF.pdf # Preregistration document
├── preprint.pdf            # Preprint of the study
|
├── manuscript/ 
│   ├── zcurve.qmd                          # Quarto document to fully reproduce the manuscript (renders to zcurve.pdf; not committed)
|   ├── zcurve_sensitivity_analysis.qmd     # Quarto document to fully reproduce the sensitivity analyses
│   ├── zcurve_sensitivity_analysis.pdf     # PDF document containing the results of the sensitivity analyses
|   ├── references.bib                      # Bib file containing the references used in the manuscript
|   └── session-info.txt                    # Snapshot of the R session used to render zcurve.qmd
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
│   ├── consolidated_data_zcurve.xlsx  # Decision columns selected for the z-curve analysis
│   ├── zcurve_data.xlsx               # Dataset with manually recomputed p-values & exclusion coding; read by the manuscript
|   ├── simulations.RDS                # Contains the data simulated for Figure 2 and Table 2
|   └── table2.rds                     # Results stored from Table 2
|
├── r_scripts/
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
│       ├── 03_intercoder_agreement.R           # Results of intercoder agreement across variables
│       └── 04_consolidate_data.R               # Merges columns after resolving disagreements
|    
├── figures/ 
|   ├── figure2a.png # Figure 2a: ~80% power
|   ├── figure2b.png # Figure 2b: null effect
|   ├── figure2c.png # Figure 2c: publication bias and ~20% power
|   ├── figure2d.png # Figure 2d: publication bias and null effect
|   ├── figure2e.png # Figure 2e: mild optional stopping
|   └── figure2f.png # Figure 2f: mixed
```

# Reproducing the results

All commands below assume the working directory is the repository root (e.g. open `z_curve_project.Rproj` in RStudio, or run `Rscript` from this folder), since the scripts locate files with the `here` package and relative `"data/..."` paths.

### 0. Install the required R packages

```r
install.packages(c(
  "readxl", "writexl", "dplyr", "here", "zcurve", "ggplot2", "knitr",
  "purrr", "irr", "DescTools", "lpSolve", "kableExtra"
))
```

### 1. Data curation (already done — `data/zcurve_data.xlsx` is the result)

1. `r_scripts/intercoder_agreement/01_checking_disagreements.R` splits `data/raw_data.xlsx` into `data/disagreements2.xlsx` (double-coded studies) and `data/disagreements3.xlsx` (triple-coded studies).
2. `r_scripts/intercoder_agreement/04_consolidate_data.R` extracts the resolved "decision" for each disagreement, producing `data/processed_data.xlsx` and then `data/consolidated_data_zcurve.xlsx`.
3. `data/zcurve_data.xlsx` — the file the manuscript actually reads — is produced from `consolidated_data_zcurve.xlsx` by manually recomputing *p*-values and coding exclusions in Excel (see the "Recomputing *p*-values" and "Study exclusions" sections of `zcurve.qmd`). This step is not scripted, so steps 1-2 only need to be re-run if the underlying coded data changes.

   **Caution:** re-running step 1 regenerates `disagreements2.xlsx`/`disagreements3.xlsx` from `raw_data.xlsx` from scratch. The versions currently committed to this repo include a manual fix (see commit `4aaf9e0`) needed for `02_intercoder_agreement_function.R` to read them correctly; that fix is not reproduced by `01_checking_disagreements.R`, so re-running it will overwrite it and can break `03_intercoder_agreement.R` again. This section of the README was itself written by reading the scripts rather than by re-running steps 1-2, specifically to avoid triggering this.

(`02_intercoder_agreement_function.R` only defines functions, and `03_intercoder_agreement.R` — which computes the Fleiss'/Cohen's kappa values reported in the Methods — is sourced automatically when `zcurve.qmd` renders. Neither needs to be run by hand; run `03_intercoder_agreement.R` directly only to inspect `average_fleiss`/`average_cohen` on their own.)

### 2. Simulations for Figure 2 and Table 2

Run in order from `r_scripts/simulations_figure2/`:

1. `08_run_simulations.R` — runs `02_evidential_value.R` through `07_mixed.R` (each sources `01_functions.R` itself) and saves `data/simulations.RDS`.
2. `09_figure2.R` — fits a z-curve to each of the 6 simulated scenarios and writes `figures/figure2a.png` ... `figure2f.png`.
3. `10_table2.R` — fits a z-curve to each scenario and saves `data/table2.rds`, read by `zcurve.qmd`.

### 3. Render the manuscript

```bash
quarto render manuscript/zcurve.qmd
quarto render manuscript/zcurve_sensitivity_analysis.qmd
```

Both documents read `data/zcurve_data.xlsx` directly. `zcurve.qmd` additionally reads `data/table2.rds` and `figures/figure2a.png`-`figure2f.png` (step 2) and sources `03_intercoder_agreement.R` (step 1) while rendering.

(`zcurve.qmd` computes Figure 1 (`fig-fig1.1`) inline with its own code, so no script needs to be run for it.)
