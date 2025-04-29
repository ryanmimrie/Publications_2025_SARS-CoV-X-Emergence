# SARS-CoV-X Emergence Modeling
This repository contains data, code, and additional visualisations from Imrie & Bissett et al., (2025) "Post-pandemic changes in population immunity have reduced the likelihood of emergence of zoonotic coronaviruses".

## Contents
- `data`: Contains a) cross-neutralisation data from pseudotype neutralisation assays against the spike proteins of four zoonotic sarbecoviruses; b) parameterisation files for the epidemiological model.
- `models`: Contains Odin and Odin.Dust R scripts for the epidemiological model
- `img`: Contains images and animations used in this repository

## Model Specifications
### Platform Support
![Windows](https://img.shields.io/badge/Windows-blue?logo=microsoftwindows)
![macOS](https://img.shields.io/badge/macOS-black?logo=apple)
![Linux](https://img.shields.io/badge/Linux-grey?logo=linux)

### Dependencies
![R Version](https://img.shields.io/badge/R-4.5.0-blue)
![devtools](https://img.shields.io/badge/devtools-2.4.5-ff69b4)
![tidyverse](https://img.shields.io/badge/tidyverse-2.0.0-blue)
![socialmixr](https://img.shields.io/badge/socialmixr-0.4.0-lightgreen)
![odin](https://img.shields.io/badge/odin-1.5.11-yellow)
![dust](https://img.shields.io/badge/dust-0.15.3-orange)
![odin.dust](https://img.shields.io/badge/odin.dust-0.3.13-red)

### System Requirements
![RAM](https://img.shields.io/badge/minimum%20RAM-8GB-important)

### Installation

To run this project, you need to have R and RStudio installed:

- [Download R](https://cran.r-project.org/)
- [Download RStudio](https://posit.co/download/rstudio-desktop/)

Within RStudio you can install the required packages using the following R commands:

```r
install.packages('devtools')

devtools::install_github('mrc-ide/odin')
devtools::install_github('mrc-ide/dust')
devtools::install_github('mrc-ide/odin.dust')

install.packages('tidyverse')
install.packages('socialmixr')
install.packages('abind')
```

Typical install time on a normal desktop computer: 3-5 minutes.

## Demo
### Instructions
The file `models//Dust_Script.R` contains an example model run of the SARS-CoV-X emergence cocirculation model which can be run manually within an integrated development environment (IDE) such as RStudio. Please ensure that the setwd() command on line 49 correctly point to a directory containing the model and data subdirectories from this repository. The script can then be run by selecting all code with **Ctrl + A** and executing  with **Ctrl + Enter**.

In section 1 of this script, parameters for the population of Scotland and the phenotypes of SARS-CoV-2 are loaded from data files, and functions for age-stratification of SARS-CoV-X phenotypes and the preventative vaccination program are defined.

In section 2 the phenotypes of SARS-CoV-X and the conditions of the prevenative vaccination program are defined in the "scenarios" object. This example defines two exposure scenarios of a SARS-CoV-X virus with a mean incubation period of 3 days; a mean infectious period of 7 days; an R0 of 2; and a natural and vaccine-derived cross-reactivity of 67%. The prevenative vaccination program achieves an uptake of either 0% or 100% and begins 30 days before the first SARS-CoV-X case. Each scenario is then run through the Odin model, with the vaccination program and age-stratified phenotypes calculated using the functions defined in section 1, and the number of emergence events calculated and reported to the console.

For the purposes of this example, the number of runs for each scenario, stored in parameters$model_iterations, has been set to 250.

### Expected Outcome
This demo will print to console a summary of the key parameters of each scenario along with the number of emergence events and the number of trials. As this is a stochastic model, the exact number of emergences will vary between runs, but should be higher (~30) in scenario 1 than in scenario two (~2).

### Expected Runtime
This script will typically take 5-10 minutes to run on modern hardware (~2-5 minutes for the initial Odin compilation and then 3-5 minutes for the 250 trials of two scenarios).

### Incorporation of Different Data
This model may be used to explore different exposure scenarios and virus phenotypes by adjusting the scenarios object on lines 251-258. The characteristics of SARS-CoV-2 and the human population can be altered by changing the values stored in the `data` files.

### Reproducing Manuscript Results
Scripts to reproduce the results of each Figure in the original manuscript can be found in `models/reproduction`. These scripts perform grid searches of parameter space by looping over large versions of the scenario object from the example model, and will take several weeks to run in serial on typical hardware.

## Model Structure
In this extended SEIRS model, separate EIR compartments are given for each combination of host immune group and virus.<br><br>
Compartment names are constructed as Compartment Type + Virus + <sub>Immune Group</sub>. For example, hosts that are infectious ("I") with SARS-CoV-2 ("2"), have recovered from SARS-CoV-X ("RX") and been vaccinated once ("VI") can be found in compartment I2<sub>RX,VI</sub>. Symbols used in compartment names are as follows:
#### Compartment Type
- `S`: susceptible.
- `E`: exposed.
- `I`: infectious.
- `R`: recovered.
#### Virus
- `2`: SARS-CoV-2.
- `X`: SARS-CoV-X.
#### Immune Group
- `U`: unvaccinated
- `VI`: vaccinated (1 dose protective phenotype)
- `VII`: vaccinated (2 dose protective phenotype)

<img src="https://github.com/ryanmimrie/Publications_2025_SARS-CoV-X-Emergence/blob/main/img/Model_Structure.jpg" alt="Model Structure" style="display: block; margin: auto;">

## Additional Visualisations: Temporally-varying Parameters
### SARS-CoV-2 Variant Prevalences
Numerical values from this plot are available in data/SARS2_variant_prevalences.csv.
<img src="https://github.com/ryanmimrie/Publications_2025_SARS-CoV-X-Emergence/blob/main/img/SARS2_Prevalences.jpg" alt="SARS-CoV-2 Prevalences" style="display: block; margin: auto;">

### Vaccination Rates
Numerical values from these plots can be found in the data directory. "First Dose" can be found in data/vaccination_dose1.csv, and "Subsequent Doses" can be calculated by summing values in data/vaccination_dose2.csv and data/vaccination_dose3.csv by day and age group (see Methods & Materials for details).

<img src="https://github.com/ryanmimrie/Publications_2025_SARS-CoV-X-Emergence/blob/main/img/Vaccination_Rates.jpg" alt="Vaccination Rates" style="display: block; margin: auto;">

### Contact Rates
Numerical values for contact matrices can be found in data/contact_matrices.rds. The data in this file represents per-capita contact rates arranged in a 3D array of 16 x 16 contact matrices for each day of the model starting at 2020-02-23 (YYYY-MM-DD).
#### Pre-pandemic (POLYMOD)
<img src="https://github.com/ryanmimrie/Publications_2025_SARS-CoV-X-Emergence/blob/main/img/Contact_Rates_PrePandemic.jpg" alt="Contact Matrices" style="display: block; margin: auto;">

#### 2020-03-29 to 2021-11-28 (COMIX)
<img src="https://github.com/ryanmimrie/Publications_2025_SARS-CoV-X-Emergence/blob/main/img/Contact_Rates_DuringPandemic.jpg" alt="Contact Matrices" style="display: block; margin: auto;">


#### Post-COVID (COMIX follow-up)
<img src="https://github.com/ryanmimrie/Publications_2025_SARS-CoV-X-Emergence/blob/main/img/Contact_Rates_PostPandemic.jpg" alt="Contact Matrices" style="display: block; margin: auto;">

## References
Please refer to Supplementary Table 7 in Imrie & Bissett et al., (2025) for references and credit for all data sources.
