# SARS-CoV-X Emergence Modeling
This repository contains data, code, and animated visualisations from Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."

## Model Structure
In this extended SEIR model, each host immune group is given separate EIR compartments for each virus. This allows immune groups to vary not only in their probability of infection, but also their propability of infection-related mortality for each virus.<br><br>
Compartment names are constructed as Compartment Type + Virus + (Immune Group) with the following categories:
#### Compartment Type
- `S`: naive and uninfected..
- `V`: vaccinated and uninfected.
- `E`: exposed (i.e., incubating).
- `I`: infectious.
- `R`: recovered.
#### Virus
- `2`: SARS-CoV-2.
- `X`: SARS-CoV-X.
#### Immune Group
- `S`: unvaccinated
- `V`: vaccinated
- `R2S`: unvaccinated with natural immunity to SARS-CoV-2
- `RXS`: unvaccinated with natural immunity to SARS-CoV-X
- `R2V`: vaccinated with natural immunity to SARS-CoV-2
- `RXV`: vaccinated with natural immunity to SARS-CoV-X

<img src="https://github.com/ryanmimrie/Publications-2024-SARSX-Emergence-Modeling/blob/main/img/Model%20Structure.png" alt="Model Structure" style="display: block; margin: auto;">

## Population Structure
Social and demographic data have been used to represent the population of Scotland over a 10-year modeling period.
