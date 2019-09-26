μᵨ(e::Element, keV::T) where {T<:Number} = μᵨ(e, [keV])[1]

function μᵨ(e::Element, keVs::AbstractArray{T,1}) where {T<:Number}
    body = requestbody(keVs)
    body["Method"] = "1"
    body["ZNum"] = "$(e.Z)"

    r = HTTP.request("POST", XCOM_URL, [], encodebody(body))
    parseresponse(r)
end

μᵨ(c::Compound, keV::T) where {T<:Number} = μᵨ(c, [keV])[1]

function μᵨ(c::Compound, keVs::AbstractArray{T,1}) where {T<:Number}
    body = requestbody(keVs)
    body["Method"] = "2"
    body["Formula"] = c.formula

    r = HTTP.request("POST", XCOM_URL, [], encodebody(body))
    parseresponse(r)
end

μᵨ(m::Mixture, keV::T) where {T<:Number} = μᵨ(m, [keV])[1]

function μᵨ(m::Mixture, keVs::AbstractArray{T,1}) where {T<:Number}
    formulae = join(["$k $v" for (k, v) in m.formulae], '\n')

    body = requestbody(keVs)
    body["Method"] = "3"
    body["Formulae"] = formulae

    r = HTTP.request("POST", XCOM_URL, [], encodebody(body))
    parseresponse(r)
end

μᵨ(m::Material, keV::T) where {T<:Number} = μᵨ(m, [keV])[1]

μᵨ(m::Material, keVs::AbstractArray{T,1}) where {T<:Number} =
    μᵨ(m.composition, keVs)
