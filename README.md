# Publications-2024-SARSX-Emergence-Modeling
This repository contains data and code used in Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."


## Structure

Compartments may be hovered over for a more detailed description.
```mermaid
flowchart LR
    S((S)) --> |Infection rate (beta)| E((E))
    E((E)) --> |Incubation rate (sigma)| I((I))
    I((I)) --> |Recovery rate (gamma)| R((R))
    R((R)) --> |Loss of immunity rate (delta)| S((S))
    
    classDef node fill:#f9f,stroke:#333,stroke-width:2px;
    class S,E,I,R node;
