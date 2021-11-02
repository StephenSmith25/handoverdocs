
  # Conda build (nightly and release)
```mermaid
graph TD
    A[Mantid dependencies] -->|Parse requirements| B(Conda recipes)   

    B --> F[mantid-framework, mantidqt, mantid-workbench] 

    AA[Main branch] --> G
    L --> H
    BB[Release tag] -->  H[conda-feedstock]
    L --> G[mantid recipes]

    F -->L[meta.yaml & build scripts]
    
    G --> |uploads to|I[mantid channel]
    H --> |uploads to|J[conda-forge channel]

```