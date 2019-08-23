module Attenuations

using HTTP
using PeriodicTable

const XCOM_URL = "https://www.physics.nist.gov/cgi-bin/Xcom/data.pl"

μ(Z::Int, keVs) = elements[Z].density.val * μᵨ(Z, keVs)

function μᵨ(Z::Int, keVs)
    body = requestbody(keVs)
    body["Method"] = "1"
    body["ZNum"] = "$Z"

    r = HTTP.request("POST", XCOM_URL, [], encodebody(body))
    parseresponse(r)
end

function μᵨ(formula::String, keVs)
    body = requestbody(keVs)
    body["Method"] = "2"
    body["Formula"] = formula

    r = HTTP.request("POST", XCOM_URL, [], encodebody(body))
    parseresponse(r)
end

function μᵨ(mixture, keVs)
    formulae = join(["$k $v" for (k,v) in mixture], '\n')

    body = requestbody(keVs)
    body["Method"] = "3"
    body["Formulae"] = formulae

    r = HTTP.request("POST", XCOM_URL, [], encodebody(body))
    parseresponse(r)
end

parseresponse(response) = map(x->parse(Float64, split(x, ' ')[2]), split(String(response.body), '\n')[4:end - 1])

requestbody(keVs) = Dict("NumAdd" => "1",
    "Energies" => join(["$(keV / 1000)" for keV in keVs], ';'),
    "OutOpt" => "PIC",
    "with" => "on",
    "Output" => "",
    "character" => "space",
    "WindowXmin" => "0.001",
    "WindowXmax" => "100000",
)

encodebody(body) = join(["$k=$v" for (k, v) in body], '&')

end # module
