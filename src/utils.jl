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
