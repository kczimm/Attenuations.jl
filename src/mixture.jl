struct Mixture <: Matter
    formulae::Dict{String,Float64}
end

function μᵨ(
    m::Mixture,
    energies::AbstractArray{<:Unitful.Energy},
    a::Type{<:Attenuation},
)
    body = Dict{String,String}(
        "Method" => "3",
        "Formulae" => join(["$k $v" for (k, v) in m.formulae], '\n'),
        bodykey(a) => "on",
        "Energies" => formatenergies(energies),
    )

    μᵨ = XCOM(body) * cm^2 ./ g
    AxisArray(μᵨ, Axis{:energy}(energies))
end

μᵨ(m::Mixture, energies::AbstractArray{<:Unitful.Energy}) =
    μᵨ(m, energies, WithCoherent)

μᵨ(m::Mixture, energy::T, a::Type{<:Attenuation}) where {T<:Unitful.Energy} =
    μᵨ(m, [energy], a)[1]

μᵨ(m::Mixture, energy::T) where {T<:Unitful.Energy} =
    μᵨ(m, [energy], WithCoherent)[1]
