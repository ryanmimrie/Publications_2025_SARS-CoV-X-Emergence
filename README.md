# SARS-CoV-X Emergence Modeling
This repository contains data and code used in Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."

## Model Structure
In this extended SEIR model, each host immune group (naive, vaccinated, natural, and natural & vaccinated) are given separate EIR compartments for each virus. This allows immune groups to vary both in their probability of infection, and their propability of infection-related mortality for each virus.<br>
Compartment names are constructed as Type + Virus + (Immune Group) with the following categories:
#### Type
- `S`: naive and uninfected..
- `V`: vaccinated and uninfected.
- `E`: exposed (i.e., begun incubation).
- `I`: infectious.
- `R`: recovered.
#### Virus
- `2`: SARS-CoV-2.
- `X`: SARS-CoV-X.
#### Host
- `S`: unvaccinated
- `V`: vaccinated
- `R2S`: unvaccinated and recovered from SARS-CoV-2
- `RXS`: unvaccinated and recovered from SARS-CoV-X
- `R2V`: vaccinated and recovered from SARS-CoV-2
- `RXV`: vaccinated and recovered from SARS-CoV-X

<img src="https://github.com/ryanmimrie/Publications-2024-SARSX-Emergence-Modeling/blob/main/img/Model%20Structure.png" alt="Model Structure" style="display: block; margin: auto;">
