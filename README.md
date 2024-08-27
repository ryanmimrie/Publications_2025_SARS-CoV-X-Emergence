# Publications-2024-SARSX-Emergence-Modeling
This repository contains data and code used in Imrie et al., (2024) "Changes in population immunity reduce the likelihood of emergence of novel zoonotic coronaviruses."


## Structure

Compartments may be hovered over for a more detailed description.
```mermaid
flowchart LR
    Sn(SN) --> E2s(E2s)
    E2s(E2s) --> I2s(I2s)
    I2s((I2s)) --> R2s(R2s)
    R2s(R2s) --> Sn(SN)
    Sn(SN) --> EXs(EXs)
    EXs(EXs) --> IXs(IXs)
    IXs((IXs)) --> RXs(RXs)
    RXs(RXs) --> Sn(SN)
    R2s(R2s) --> EXR2s(EXR2s)
    EXR2s(EXR2s) --> IXR2s(IXR2s)
    IXR2s(IXR2s) --> RallS(RallS)

