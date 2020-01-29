function μᵨ(e::Element, energies::AbstractArray{T}) where {T<:Unitful.Energy}
    params = Dict("Method" => "1", "ZNum" => "$(e.Z)")
    getNIST(params, energies)
end

μᵨ(e::Element, energies::AbstractArray{T}) where {T<:Number} =
    μᵨ(e, (energies)keV)

function μᵨ(c::Compound, energies::AbstractArray{T}) where {T<:Unitful.Energy}
    params = Dict("Method" => "2", "Formula" => c.formula)
    getNIST(params, energies)
end

μᵨ(c::Compound, energies::AbstractArray{T}) where {T<:Number} =
    μᵨ(c, (energies)keV)

function μᵨ(m::Mixture, energies::AbstractArray{T}) where {T<:Unitful.Energy}
    params = Dict(
        "Method" => "3",
        "Formulae" => join(["$k $v" for (k, v) in m.formulae], '\n'),
    )
    getNIST(params, energies)
end

μᵨ(m::Mixture, energies::AbstractArray{T}) where {T<:Number} =
    μᵨ(m, (energies)keV)
