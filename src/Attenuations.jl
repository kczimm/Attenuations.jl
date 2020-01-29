module Attenuations

using AxisArrays
using HTTP
using PeriodicTable
using Unitful

import Unitful: g, cm, eV, keV, MeV

export μ, μᵨ, Element, Compound, Mixture, Material, data

const XCOM_URL = "https://www.physics.nist.gov/cgi-bin/Xcom/data.pl"

data(a::AbstractArray{T}) where {T<:Unitful.AbstractQuantity} = [i.val for i in a.data]

include("types.jl")
include("linear.jl")
include("mass.jl")
include("materials.jl")
include("utils.jl")

end # module
