# Publications-2024-SARSX-Emergence-Modeling
This repository contains data and code used in Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."


## Structure

Compartments may be hovered over for a more detailed description.
```mermaid
flowchart LR
    S((S)) --> E((E))
    E((E)) --> I((I))
    I((I)) --> R((R))
    R((R)) --> S((S))
    class S,E,I,R node;
