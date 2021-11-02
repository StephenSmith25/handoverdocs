# Diagrams


# From dependencies to conda environments
From our initial list of mantid dependencies, we can extract our conda depenendices and source approairate versions from conda forge. These dependnecies are consumed in three ways: (1) By our local environment files used to build mantid (2) By the conda-build meta.yaml file used to speicify our build, host and runtime requirements of our mantid package. And lastly, when creating an installer we create a construct.yamlf file, which defines our python dependencies. 
```mermaid
graph TD
    A[Mantid dependencies] -->|Parse requirements| B(Create conda environment files)   

    B -->|mantid-developer.yaml| D[Local conda environment] 
    B -->|meta.yaml| E[Conda build recipe]


    D --> |used by| I[Local build]
    D --> |used by| H[CI build]
    I --> O[Local use]
    I --> |install|P[local install]

    E --> |creates| G[mantid-framework]
    E --> |creates| J[mantid-qt]
    J <--> |uses| G
    J --> |used by| K
    E --> |creates| K[mantid-workbench ]

    G --> MM[conda packages]
    J --> MM[conda packages]
    K --> MM[conda packages]

 

    LL[build scripts] --> E[conda-build]


    P -->|CPack| BB[Standalone installer]
    CC[conda constructor] --> BB
    B -->|construct.yaml| CC
  
```


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

    I <--> |once per day|G
    J <--> |once per release|H
```


# Standalone installer (WIP)
```mermaid
graph TD
    A[Conda build] -->|Parse requirements| B(Conda environment file)   
    B -->|mantid-developer.yaml| D[Conda environment] 
  
```


