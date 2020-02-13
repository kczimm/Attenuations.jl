struct Material end

function μ(e::Element, energies::AbstractArray{<:Number})
    u = μᵨ(e, energies)
	AxisArray((elements[e.Z].density)g/cm^3 * u, u.axes)
end

μ(e::Element, energy::T) where {T<:Number} = μ(e, [energy])[1]

function μ(m::Material, energies::AbstractArray{<:Number})
	u = μᵨ(m, energies)
	AxisArray(m.ρ * u, u.axes)
end

μ(m::Material, energy::T) where {T<:Number} = μ(m, [energy])[1]
