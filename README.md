# SARS-CoV-X Emergence Modeling
This repository contains data, code, and additional visualisations from Imrie & Bissett et al., (2025) "Post-pandemic changes in population immunity have reduced the likelihood of emergence of zoonotic coronaviruses".

## Contents
- `data`: Contains a) cross-neutralisation data from pseudotype neutralisation assays against the spike proteins of four zoonotic sarbecoviruses; b) parameterisation files for the epidemiological model.
- `models`: Contains Odin and Odin.Dust R scripts for the epidemiological model
- `img`: Contains images and animations used in this repository

## Model Specifications
### Platform Support
![Windows](https://img.shields.io/badge/platform-Windows-blue?logo=windows)
![macOS](https://img.shields.io/badge/platform-macOS-black?logo=apple)
![Linux](https://img.shields.io/badge/platform-Linux-yellowgreen?logo=linux)

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

Typical install time 3-5 minutes.

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
