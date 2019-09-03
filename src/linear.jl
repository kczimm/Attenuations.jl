μ(e::Element, keVs) = elements[e.Z].density.val * μᵨ(e, keVs)

μ(m::Material, keVs) = m.ρ .* μᵨ(m.composition, keVs)
