module Attenuations

using AxisArrays
using HTTP
using Unitful

import Unitful: g, cm, eV, keV, MeV

export μ, μᵨ, Element, Compound, Mixture, Material, data

const XCOM_URL = "https://www.physics.nist.gov/cgi-bin/Xcom/data.pl"

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


data(a::AbstractArray{T}) where {T<:Unitful.AbstractQuantity} = [i.val for i in a.data]

include("types.jl")
include("linear.jl")
include("mass.jl")
include("utils.jl")

include("elements.jl")
include("materials.jl")

end # module
