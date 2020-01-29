using Attenuations
using Test
import Unitful: cm, g

@test μᵨ(Element(13), 70) ≈ 0.2301cm^2/g
@test μ(Element(13), 70) ≈ 0.62127cm^-1
@test μᵨ(Compound("H2O"), 70) ≈ 0.1929cm^2/g
@test μᵨ(Mixture(Dict("H2O"=>0.9,"NaCl"=>0.1)), 70) ≈ 0.2015cm^2/g
@test μᵨ(70, H2O=0.9, NaCl=0.1) ≈ 0.2015cm^2/g
