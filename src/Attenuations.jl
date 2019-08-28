module Attenuations

using HTTP
using PeriodicTable

export μ, μᵨ, Element, Compound, Mixture, Matter

const XCOM_URL = "https://www.physics.nist.gov/cgi-bin/Xcom/data.pl"

include("types.jl")
include("linear.jl")
include("mass.jl")
include("utils.jl")

end # module
