module Attenuations

using AxisArrays
using HTTP
using PeriodicTable
using Unitful

import Unitful: g, cm, keV, MeV

export μ, μᵨ, Element, Compound, Mixture

const XCOM_URL = "https://www.physics.nist.gov/cgi-bin/Xcom/data.pl"

include("types.jl")
include("linear.jl")
include("mass.jl")
include("utils.jl")

end # module
