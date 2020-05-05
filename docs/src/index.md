# Attenuations: Mass/Linear X-ray Attenuation Coefficients from NIST
This package is a Julia API to the [NIST XCOM Database](https://www.physics.nist.gov/PhysRefData/Xcom/html/xcom1.html) and the tabular data from the [NIST Standard Reference Database 126](https://www.nist.gov/pml/x-ray-mass-attenuation-coefficients).

```@contents
```

```@setup using
using Attenuations
```

## Installation
```julia
using Pkg
Pkg.add("https://github.com/kczimm/Attenuations.jl")
using Attenuations
```

## Basic Usage
```@repl using
μᵨ(Elements.Hydrogen, 1MeV, PhotoelectricAbsorption)
μᵨ(Mixture(Dict("H"=>1)), 1MeV, PhotoelectricAbsorption)
μ(Materials.GOS, 40keV, Incoherent)
μᵨ(Compound("H2O"), 10keV)

energies = 20keV:1keV:160keV
μ(Materials.water, energies)
```

## XCOM database
The XCOM database can generate mass attenuation coefficients for:
- `Element`
- `Compound`
- `Mixture`

```@docs
Element
Compound
Mixture
```

## Elements
The `Element`s and their properties provided by [NIST (table 1)](https://physics.nist.gov/PhysRefData/XrayMassCoef/tab1.html) are available in the exported `Elements` named tuple. For example,

```@repl using
keys(Elements)
```

## Materials
The [NIST (table 2)](https://physics.nist.gov/PhysRefData/XrayMassCoef/tab2.html) provides materials with their composition and properties which are made available in the exported `Materials` named tuple. For example,

```@repl using
keys(Materials)
```
