# Diagrams


# From dependencies to conda environments
From our initial list of mantid dependencies we can extract our conda depenendices and source approairate versions from conda forge. These dependnecies are consumed in three ways: (1) By our local environment files, used to build mantid (2) By the conda-build meta.yaml file used to speicify our build, host and runtime requirements of our mantid package. And lastly, when creating an installer we create a construct.yamlf file, which defines our python dependencies. 
```mermaid
graph TD
    A[Mantid dependencies] -->|Parse requirements| B(Create conda environment files)   
    B -->|mantid-developer.yaml| D[Local conda environment] 
    B -->|meta.yaml| E[Conda build recipe]

    E --> |creates| G[mantid-framework]
    E --> |creates| J[mantid-qt]
    G --> J
    J --> K

    E --> |creates| K[mantid-workbench ]

    G --> MM[conda packages]
    J --> MM[conda packages]
    K --> MM[conda packages]

    D --> |used by| I[Local build]
    D --> |used by| H[CI build]
    I --> |configure| M[cmake .. --preset=]
    M --> |build| N[ninja]
    N --> O[Local use]
    N --> |create installer|P[ninja install]
    N --> |create installer|Q[ninja install]

    LL[build scripts] --> E[conda-build]


    N --> BB[Installer]
    CC[Constructor] --> BB
    B -->|construct.yaml| CC
  
```

# Conda build (nightly and release)
```mermaid
graph TD
    A[Conda build] -->|Parse requirements| B(Conda environment file)   
    B -->|mantid-developer.yaml| D[Conda environment] 
  
```


# Standalone installer (WIP)
```mermaid
graph TD
    A[Conda build] -->|Parse requirements| B(Conda environment file)   
    B -->|mantid-developer.yaml| D[Conda environment] 
  
```


# Windows debug build?
Apache arrow said something about this.
Its more than likely using vcpkg, we'd just need to direct CMAKE to the vcpkg directory.
There's also conan?

