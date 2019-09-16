μ(e::Element, keVs::AbstractArray{T,1}) where {T<:Number} = elements[e.Z].density.val * μᵨ(e, keVs)
μ(e::Element, keV::T) where {T<:Number} = μ(e, [keV])[1]

μ(m::Material, keVs::AbstractArray{T,1}) where {T<:Number} = m.ρ .* μᵨ(m.composition, keVs)
μ(m::Material, keV::T) where {T<:Number} = μ(m, [keV])[1]
