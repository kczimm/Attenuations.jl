function μ(e::Element, energies::AbstractArray{<:Number})
    u = μᵨ(e, energies)
    AxisArray(elements[e.Z].density * u, u.axes)
end

μ(e::Element, energy::T) where {T<:Number} = μ(e, [energy])[1]
