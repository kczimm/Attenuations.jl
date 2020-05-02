# Attenuations.jl Documentation
This package is a Julia API to the [NIST XCOM Database](https://www.physics.nist.gov/PhysRefData/Xcom/html/xcom1.html) and the tabular data from the [NIST Standard Reference Database 126](https://www.nist.gov/pml/x-ray-mass-attenuation-coefficients).

```@setup load
using Attenuations
```

## Installation
```julia
using Pkg
Pkg.add("https://github.com/kczimm/Attenuations.jl")
using Attenuations
```

## XCOM database
The XCOM database can generate mass attenuation coefficients for `Element`s, `Compound`s, and `Mixture`s.

### Elements
The `Element`s and their properties provided by [NIST (table 1)](https://physics.nist.gov/PhysRefData/XrayMassCoef/tab1.html) are available in the exported `Elements` module. For example,

```@repl
using Attenuations
Elements.Gold
```

## Materials
The [NIST (table 2)](https://physics.nist.gov/PhysRefData/XrayMassCoef/tab2.html) provides materials with their composition and properties which are made available in the exported `Materials` module. For example,

```@repl load
Materials.water
```

```@repl load

energy = 120keV
μ(Materials.water, energy)
```
