parseresponse(response) = map(
    x -> parse(Float64, split(x, ' ')[2]),
    split(String(response.body), '\n')[4:end-1],
)

bodykey(::Type{PhotoelectricAbsorption}) = "photoelectric"
bodykey(::Type{Coherent}) = "coherent"
bodykey(::Type{Incoherent}) = "incoherent"
bodykey(::Type{InNuclearField}) = "nuclear"
bodykey(::Type{InElectronField}) = "electron"
bodykey(::Type{WithCoherent}) = "with"
bodykey(::Type{WithoutCoherent}) = "without"

formatenergies(energies::AbstractArray{<:Unitful.Energy}) =
    join(["$(Float64(uconvert(MeV, e).val))" for e in energies], ';')

const basebody = Dict{String,String}(
    "NumAdd" => "1",
    "OutOpt" => "PIC",
    "Output" => "",
    "character" => "space",
    "WindowXmin" => "0.001",
    "WindowXmax" => "100000",
)

const XCOM_URL = "https://www.physics.nist.gov/cgi-bin/Xcom/data.pl"

function XCOM(body)
    merge!(body, basebody)
    r = HTTP.request(
        "POST",
        XCOM_URL,
        [],
        join(["$k=$v" for (k, v) in body], '&'),
    )
    parseresponse(r)
end
