module Attenuations

using AxisArrays
using HTTP
using Unitful

import Unitful: g, cm, keV, MeV

export μ,
       μᵨ,
       keV,
       Elements,
       Compound,
       Mixture,
       Materials,
       PhotoelectricAbsorption,
       Coherent,
       Incoherent,
       InNuclearField,
       InElectronField,
       WithCoherent,
       WithoutCoherent,
       data

abstract type Attenuation end
struct PhotoelectricAbsorption <: Attenuation end
abstract type Scattering <: Attenuation end
struct Coherent <: Scattering end
struct Incoherent <: Scattering end
abstract type PairProduction <: Attenuation end
struct InNuclearField <: PairProduction end
struct InElectronField <: PairProduction end
abstract type Total <: Attenuation end
struct WithCoherent <: Total end
struct WithoutCoherent <: Total end

abstract type Matter end

data(a::AbstractArray{T}) where {T<:Unitful.AbstractQuantity} =
    [i.val for i in a.data]

include("xcom.jl")

include("compound.jl")
include("mixture.jl")
include("elements.jl")

import .Elements: μ

include("materials.jl")

end # module
