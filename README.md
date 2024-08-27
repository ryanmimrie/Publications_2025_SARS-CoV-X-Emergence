# Publications-2024-SARSX-Emergence-Modeling
This repository contains data and code used in Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."


## Structure

Compartments may be hovered over for a more detailed description.
```mermaid
erDiagram
    SIR {
        SUSCEPTIBLE ||--o{ INFECTED : "becomes"
        INFECTED ||--o{ RECOVERED : "recovers"
        RECOVERED ||--o{ SUSCEPTIBLE : "loses immunity"
    }

    SIR {
        SUSCEPTIBLE {
            int id
            int count
        }
        INFECTED {
            int id
            int count
        }
        RECOVERED {
            int id
            int count
        }
    }
