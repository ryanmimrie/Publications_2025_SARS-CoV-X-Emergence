# SARS-CoV-X Emergence Modeling
This repository contains data, code, and animated visualisations from Imrie & Bissett et al., (2025) "Post-pandemic changes in population immunity have reduced the likelihood of emergence of zoonotic coronaviruses".

## Contents
- `data`: Contains a) cross-neutralisation data from pseudotype neutralisation assays against the spike proteins of four zoonotic sarbecoviruses; b) parameterisation files for the epidemiological model.
- `models`: Contains Odin and Odin.Dust R scripts for the epidemiological model
- `img`: Contains images and animations used in this repository

## Model Structure
In this extended SEIRS model, separate EIR compartments are given for each combination of host immune group and virus.<br><br>
Compartment names are constructed as Compartment Type + Virus + <sub>Immune Group</sub>. For example, hosts that are infectious ("I") with SARS-CoV-2 ("2"), have recovered from SARS-CoV-X ("RX") and been vaccinated once ("VI") can be found in compartment I2<sub>RX,VI</sub>. Symbols used in compartment names are as follows:
#### Compartment Type
- `S`: naive.
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

<img src="https://github.com/ryanmimrie/Publications-2025-SARS-CoV-X-Emergence/blob/main/img/Model%20Structure.jpg" alt="Model Structure" style="display: block; margin: auto;">

### Animated Model Run
The following is an animation of the model run used for Figure 2A. Here, SARS-CoV-X is parameterised as SARS-CoV, and a 100% uptake preventative vaccination program begins 30 days before the first SARS-CoV-X case. This particular model run is chosen to highlight the co-circulatory dynamics of the model, however SARS-CoV-X emergence is not the most likely outcome under these conditions. The lightness of compartments signify how many individuals are present, and the lightness of arrows represent how active a transition is at each timepoint in the model run. The total number of infections, calculated as the (%) of the population present in the "I" compartments of each virus at a given timepoint, is shown along the bottom of the animation.

