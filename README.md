# Publications-2024-SARSX-Emergence-Modeling
This repository contains data and code used in Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."


## Structure

Compartments may be hovered over for a more detailed description.
```mermaid
classDiagram
    Susceptible <|-- R2s
    Susceptible <|-- RXs
    Susceptible <|-- Ralls
    Animal : +naive
    Animal : +unvaccinated
    class R2s{
        +natural immunity: SARS-2
        +unvaccinated
    }
    class RXs{
        +natural immunity: SARS-X
        +unvaccinated
    }
    class Ralls{
        +natural immunity: SARS-2 & SARS-X
        +unvaccinated
    }
