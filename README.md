# Attenuations.jl [![Build Status](https://travis-ci.org/kczimm/Attenuations.jl.svg?branch=master)](https://travis-ci.org/kczimm/Attenuations.jl) [![Coverage Status](https://coveralls.io/repos/github/kczimm/Attenuations.jl/badge.svg?branch=master)](https://coveralls.io/github/kczimm/Attenuations.jl?branch=master)
NIST XCOM x-ray attenuations in Julia.

# Usage
```julia
julia> using Attenuations
julia> energies = 20keV:1keV:140keV;
julia> μ_H2O = μ(Materials.water, energies)
1-dimensional AxisArray{Unitful.Quantity{Float64,𝐋^-1,Unitful.FreeUnits{(cm^-1,),𝐋^-1,nothing}},1,...} wi
th axes:
    :energy, (20:140) keV
And data, a 121-element Array{Unitful.Quantity{Float64,𝐋^-1,Unitful.FreeUnits{(cm^-1,),𝐋^-1,nothing}},1}:
 0.8098 cm^-1
 0.7253 cm^-1
 0.6557 cm^-1
 0.5978 cm^-1
            ⋮
 0.1545 cm^-1
 0.1542 cm^-1
 0.1538 cm^-1

 julia> μ_Al = μ(Elements.Aluminum, energies)
1-dimensional AxisArray{Unitful.Quantity{Float64,𝐋^-1,Unitful.FreeUnits{(cm^-1,),𝐋^-1,nothing}},1,...} with axes:
    :energy, (20:140) keV
And data, a 121-element Array{Unitful.Quantity{Float64,𝐋^-1,Unitful.FreeUnits{(cm^-1,),𝐋^-1,nothing}},1}:
            9.289958 cm^-1
            8.078107 cm^-1
            7.079477 cm^-1
            6.245486 cm^-1
                         ⋮
           0.3862269 cm^-1
 0.38514729999999997 cm^-1
 0.38379779999999997 cm^-1

 julia> μᵨ_CdTe = μᵨ(Materials.CdTe, energies)
 1-dimensional AxisArray{Unitful.Quantity{Float64,𝐋^2*𝐌^-1,Unitful.FreeUnits{(g^-1, cm^2),𝐋^2*𝐌^-1,nothing}},1,...} with axes:
     :energy, (20:140) keV
 And data, a 121-element Array{Unitful.Quantity{Float64,𝐋^2*𝐌^-1,Unitful.FreeUnits{(g^-1, cm^2),𝐋^2*𝐌^-1,nothing}},1}:
   21.44 cm^2 g^-1
   18.78 cm^2 g^-1
   16.56 cm^2 g^-1
   14.69 cm^2 g^-1
                 ⋮
  0.7404 cm^2 g^-1
  0.7276 cm^2 g^-1
  0.7152 cm^2 g^-1
```
