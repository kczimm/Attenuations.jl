module Attenuations

using HTTP
using PeriodicTable

export μ, μᵨ, Element, Compound, Mixture, Material

const XCOM_URL = "https://www.physics.nist.gov/cgi-bin/Xcom/data.pl"

include("types.jl")
include("linear.jl")
include("mass.jl")
include("materials.jl")
include("utils.jl")

end # module
