struct Compound <: Matter
    formula::String
end

function μᵨ(
    c::Compound,
    energies::AbstractArray{<:Unitful.Energy},
    a::Type{<:Attenuation},
)
    body = Dict{String,String}(
        "Method" => "2",
        "Formula" => c.formula,
        bodykey(a) => "on",
        "Energies" => formatenergies(energies),
    )

    μᵨ = XCOM(body) * cm^2 ./ g
    AxisArray(μᵨ, Axis{:energy}(energies))
end

μᵨ(c::Compound, energies::AbstractArray{<:Unitful.Energy}) =
    μᵨ(c, energies, WithCoherent)

μᵨ(c::Compound, energy::T, a::Type{<:Attenuation}) where {T<:Unitful.Energy} =
    μᵨ(c, [energy], a)[1]

μᵨ(c::Compound, energy::T) where {T<:Unitful.Energy} =
    μᵨ(c, [energy], WithCoherent)[1]
