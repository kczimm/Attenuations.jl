parseresponse(response) = map(
    x -> parse(Float64, split(x, ' ')[2]),
    split(String(response.body), '\n')[4:end-1],
)

commonparams(energies) = Dict(
    "NumAdd" => "1",
    "Energies" => join(["$(MeV)" for MeV in energies], ';'),
    "OutOpt" => "PIC",
    "with" => "on",
    "Output" => "",
    "character" => "space",
    "WindowXmin" => "0.001",
    "WindowXmax" => "100000",
)

function getNIST(params, energies)
    merge!(
        params,
        commonparams([Float64(uconvert(MeV, e).val) for e in energies]),
    )
    r = HTTP.request(
        "POST",
        XCOM_URL,
        [],
        join(["$k=$v" for (k, v) in params], '&'),
    )
    coefficients = (parseresponse(r)) * cm^2 ./ g
    AxisArray(coefficients, Axis{:energy}(energies))
end
