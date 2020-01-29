function μᵨ(e::Element, energies::AbstractArray{T}) where {T<:Unitful.Energy}
    params = Dict("Method" => "1", "ZNum" => "$(e.Z)")
    getNIST(params, energies)
end

μᵨ(e::Element, energies::AbstractArray{T}) where {T<:Number} =
    μᵨ(e, (energies)keV)

μᵨ(e::Element, energy::T) where {T<:Number} = μᵨ(e, [energy])[1]


function μᵨ(c::Compound, energies::AbstractArray{T}) where {T<:Unitful.Energy}
    params = Dict("Method" => "2", "Formula" => c.formula)
    getNIST(params, energies)
end

μᵨ(c::Compound, energies::AbstractArray{T}) where {T<:Number} =
    μᵨ(c, (energies)keV)

μᵨ(c::Compound, energy::T) where {T<:Number} = μᵨ(c, [energy])[1]

function μᵨ(m::Mixture, energies::AbstractArray{T}) where {T<:Unitful.Energy}
    params = Dict(
        "Method" => "3",
        "Formulae" => join(["$k $v" for (k, v) in m.formulae], '\n'),
    )
    getNIST(params, energies)
end

μᵨ(m::Mixture, energies::AbstractArray{T}) where {T<:Number} =
    μᵨ(m, (energies)keV)

μᵨ(m::Mixture, energy::T) where {T<:Number} = μᵨ(m, [energy])[1]

μᵨ(e; kwargs...) = μᵨ(Mixture(Dict([("$k", v) for (k, v) in kwargs])), e)

μᵨ(m::Material, e) = μᵨ(Mixture(Dict([(elements[k].symbol, v) for (k, v) in m.composition])), e)
