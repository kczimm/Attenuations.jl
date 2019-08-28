function μᵨ(e::Element, keVs)
    body = requestbody(keVs)
    body["Method"] = "1"
    body["ZNum"] = "$(e.Z)"

    r = HTTP.request("POST", XCOM_URL, [], encodebody(body))
    parseresponse(r)
end

function μᵨ(c::Compound, keVs)
    body = requestbody(keVs)
    body["Method"] = "2"
    body["Formula"] = c.formula

    r = HTTP.request("POST", XCOM_URL, [], encodebody(body))
    parseresponse(r)
end

function μᵨ(m::Mixture, keVs)
    formulae = join(["$k $v" for (k,v) in m.formulae], '\n')

    body = requestbody(keVs)
    body["Method"] = "3"
    body["Formulae"] = formulae

    r = HTTP.request("POST", XCOM_URL, [], encodebody(body))
    parseresponse(r)
end
