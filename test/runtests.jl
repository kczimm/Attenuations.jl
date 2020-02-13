using Attenuations
using Test
import Unitful: cm, g, keV

@testset "Elements - Table 1" begin
    @test Elements.Hydrogen.Z == 1
    @test μᵨ(Elements.Aluminum, 70keV) ≈ 0.2301cm^2/g
    @test μ(Elements.Aluminum, 70keV) ≈ 0.6210399cm^-1
end

@testset "Compounds" begin
    @test μᵨ(Compound("H2O"), 70keV) ≈ 0.1929cm^2/g
end

@testset "Mixtures" begin
    @test μᵨ(Mixture(Dict("H2O"=>0.9,"NaCl"=>0.1)), 70keV) ≈ 0.2015cm^2/g
end

@testset "Materials - Table 2" begin
    @test μᵨ(Materials.water, 70keV) ≈ 0.1929cm^2/g
    @test μ(Materials.water, 70keV) ≈ 0.1929cm^-1
end
