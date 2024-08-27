# Publications-2024-SARSX-Emergence-Modeling
This repository contains data and code used in Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."


## Structure

Compartments may be hovered over for a more detailed description.
```mermaid
flowchart LR
    S(S) --> E:2s(E:2s)
    E:2s(E2s) --> I:2s(I:2s)
    I:2s((I2s)) --> R:2s(R:2s)
    R:2s(R2s) --> S(S)
    R:2s(:R2s) --> EXR2s(EX<br>R2s)
