# Attenuations.jl [![Build Status](https://travis-ci.org/kczimm/Attenuations.jl.svg?branch=master)](https://travis-ci.org/kczimm/Attenuations.jl) [![Coverage Status](https://coveralls.io/repos/github/kczimm/Attenuations.jl/badge.svg?branch=master)](https://coveralls.io/github/kczimm/Attenuations.jl?branch=master)
NIST XCOM x-ray attenuations in Julia.

# Basic Usage
```julia
julia> using Pkg; Pkg.add("https://github.com/kczimm/Attenuations.jl")

julia> using Attenuations

julia> μᵨ(Elements.Hydrogen, 1MeV, PhotoelectricAbsorption)
1.172e-9 cm² g⁻¹

julia> μᵨ(Mixture(Dict("H"=>1)), 1MeV, PhotoelectricAbsorption)
1.172e-9 cm² g⁻¹

julia> μ(Materials.GOS, 40keV, Incoherent)
0.8117040000000001 cm⁻¹

julia> μᵨ(Compound("H2O"), 10keV)
5.33 cm² g⁻¹

julia> energies = 20keV:1keV:160keV
(20:160) keV

julia> μ(Materials.water, energies)
1-dimensional AxisArray{Unitful.Quantity{Float64,𝐋⁻¹,Unitful.FreeUnits{(cm⁻¹,),𝐋⁻¹,nothing}},1,...} with axes:
    :energy, (20:160) keV
And data, a 141-element Array{Unitful.Quantity{Float64,𝐋⁻¹,Unitful.FreeUnits{(cm⁻¹,),𝐋⁻¹,nothing}},1}:
 0.8098 cm⁻¹
 0.7253 cm⁻¹
 0.6557 cm⁻¹
 0.5978 cm⁻¹
 0.5493 cm⁻¹
 0.5082 cm⁻¹
 0.4733 cm⁻¹
 0.4433 cm⁻¹
 0.4175 cm⁻¹
 0.3951 cm⁻¹
           ⋮
 0.1499 cm⁻¹
 0.1496 cm⁻¹
 0.1493 cm⁻¹
  0.149 cm⁻¹
 0.1487 cm⁻¹
 0.1484 cm⁻¹
 0.1481 cm⁻¹
 0.1478 cm⁻¹
 0.1475 cm⁻¹
```
