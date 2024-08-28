# SARS-CoV-X Emergence Modeling
This repository contains data and code used in Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."


## Model Structure
In this extended SEIR model, each host immune group — naive, vaccinated, recovered, and recovered + vaccinated — are given their own unique EIR compartments for each virus. This allows immune groups to vary both in their probability of infection, and their propability of infection-related mortality. For E and I compartments, the infecting virus is  
<img src="https://github.com/ryanmimrie/Publications-2024-SARSX-Emergence-Modeling/blob/main/img/Model%20Structure.png" alt="Model Structure" style="display: block; margin: auto;">
