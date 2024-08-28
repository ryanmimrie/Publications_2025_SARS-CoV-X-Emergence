# SARS-CoV-X Emergence Modeling
This repository contains data, code, and animated visualisations from Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."

## Model Structure
In this extended SEIR model, each host immune group is given separate EIR compartments for each virus. This allows immune groups to vary not only in their probability of infection, but also their propability of infection-related mortality for each virus.<br><br>
Compartment names are constructed as Compartment Type + Virus + (Immune Group). For example, hosts that are infectious ("I") with SARS-CoV-2 ("2") and vaccinated ("V") can be found in compartment I2(V). Symbols used in compartment names are as follows:
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

### Animated Model Run
The following is an animation of a single model run with SARS-CoV-X parameterised as SARS-CoV-1. The lightness of compartments signify how many individuals are present, and the lightness of arrows represent how active a transition is at each timepoint in the model run. The total number of infections, calculated as a (%) of the total population present in the "I" compartments of each virus at a given timepoint, are shown in the right.

## Population Structure
Social and demographic data have been used to provide a dynamic representation of the population of Scotland over a 10-year modeling period.
