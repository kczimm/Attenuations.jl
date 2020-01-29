using Attenuations
using Test
import Unitful: cm, g

@test μᵨ(Compound("H2O"), 70) ≈ 0.1929cm^2/g
