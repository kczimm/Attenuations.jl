module Materials

using ..Attenuations: Matter, WithCoherent
using ..Attenuations.Elements: Elements
using Unitful
using Unitful: eV, g, cm
import ..Attenuations: μ, μᵨ

export μ, μᵨ

struct Material{T,S} <: Matter where {T<:Unitful.Energy,S<:Unitful.Density}
    name::String
    Z̸̸A::Float64
    I::T
    ρ::S
    composition::Dict{Int,Float64}
end

makeMixture(c::Dict{Int,Float64}) =
    Dict([(Elements[k].symbol, v) for (k, v) in c])

μᵨ(
   m::Material,
   energies::AbstractArray{<:Unitful.Energy},
   a::Type{<:Attenuation},
) = μᵨ(makeMixture(m.composition), energies, a)

μᵨ(
  m::Material,
  energies::AbstractArray{<:Unitful.Energy},
) = μᵨ(m, energies, WithCoherent)

μ(
  m::Material,
  energies::AbstractArray{<:Unitful.Energy},
  a::Type{<:Attenuation},
) = m.ρ * μᵨ(m, energies, a)

μ(
  m::Material,
  energies::AbstractArray{<:Unitful.Energy},
) = μ(m, energies, WithCoherent)

Base.show(io::IO, m::Material) = print(
    io,
    "$(m.name) Z/A=$(m.Z̸̸A) I=$(m.I) ρ=$(m.ρ)\r\n",
    join(["$k: $v" for (k, v) in m.composition], "\r\n"),
)

tissueplastic = Material(
    "A-150 Tissue-Equivalent Plastic",
    0.54903,
    65.1eV,
    1.127g / cm^3,
    Dict(
        1 => 0.10133,
        6 => 0.775498,
        7 => 0.035057,
        8 => 0.052315,
        9 => 0.017423,
        20 => 0.018377,
    ),
)
adipose = Material(
    "Adipose Tissue (ICRU-44)",
    0.55579,
    64.8eV,
    0.95g / cm^3,
    Dict(
        1 => 0.114,
        6 => 0.598,
        7 => 0.007,
        8 => 0.278,
        11 => 0.001,
        16 => 0.001,
        17 => 0.001,
    ),
)
air = Material(
    "Air, Dry (near sea level)",
    0.49919,
    85.7eV,
    0.001205g / cm^3,
    Dict(6 => 0.000124, 7 => 0.755268, 8 => 0.231781, 18 => 0.012827),
)
alanine = Material(
    "Alanine",
    0.53876,
    71.9eV,
    1.424g / cm^3,
    Dict(1 => 0.079192, 6 => 0.404437, 7 => 0.157213, 8 => 0.359157),
)
boneplastic = Material(
    "B-100 Bone-Equivalent Plastic",
    0.5274,
    85.9eV,
    1.45g / cm^3,
    Dict(
        1 => 0.065473,
        6 => 0.536942,
        7 => 0.0215,
        8 => 0.032084,
        9 => 0.167415,
        20 => 0.176585,
    ),
)
bakelite = Material(
    "Bakelite",
    0.52792,
    72.4eV,
    1.25g / cm^3,
    Dict(1 => 0.057444, 6 => 0.774589, 8 => 0.167968),
)
wholeblood = Material(
    "Blood, Whole (ICRU-44)",
    0.54999,
    75.2eV,
    1.06g / cm^3,
    Dict(
        1 => 0.102,
        6 => 0.11,
        7 => 0.033,
        8 => 0.745,
        11 => 0.001,
        15 => 0.001,
        16 => 0.002,
        17 => 0.003,
        19 => 0.002,
        26 => 0.001,
    ),
)
corticalbone = Material(
    "Bone, Cortical (ICRU-44)",
    0.51478,
    112.0eV,
    1.92g / cm^3,
    Dict(
        1 => 0.034,
        6 => 0.155,
        7 => 0.042,
        8 => 0.435,
        11 => 0.001,
        12 => 0.002,
        15 => 0.103,
        16 => 0.003,
        20 => 0.225,
    ),
)
brain = Material(
    "Brain, Grey/White Matter (ICRU-44)",
    0.55239,
    73.9eV,
    1.04g / cm^3,
    Dict(
        1 => 0.107,
        6 => 0.145,
        7 => 0.022,
        8 => 0.712,
        11 => 0.002,
        15 => 0.004,
        16 => 0.002,
        17 => 0.003,
        19 => 0.003,
    ),
)
breasttissue = Material(
    "Breast Tissue (ICRU-44)",
    0.55196,
    70.3eV,
    1.02g / cm^3,
    Dict(
        1 => 0.106,
        6 => 0.332,
        7 => 0.03,
        8 => 0.527,
        11 => 0.001,
        15 => 0.001,
        16 => 0.002,
        17 => 0.001,
    ),
)
airplastic = Material(
    "C-552 Air-equivalent Plastic",
    0.49969,
    86.8eV,
    1.76g / cm^3,
    Dict(
        1 => 0.024681,
        6 => 0.50161,
        8 => 0.004527,
        9 => 0.465209,
        14 => 0.003973,
    ),
)
CdTe = Material(
    "Cadmium Telluride",
    0.41665,
    539.3eV,
    6.2g / cm^3,
    Dict(48 => 0.468358, 52 => 0.531642),
)
CaF = Material(
    "Calcium Fluoride",
    0.48671,
    166.0eV,
    3.18g / cm^3,
    Dict(9 => 0.486672, 20 => 0.513328),
)
CaSO4 = Material(
    "Calcium Sulfate",
    0.49948,
    152.3eV,
    2.96g / cm^3,
    Dict(8 => 0.875172, 16 => 0.014279, 20 => 0.294385),
)
ammoniumsulfate = Material(
    "15 mmol L-1 Ceric Ammonium Sulfate Solution",
    0.55282,
    76.7eV,
    1.030E+00g / cm^3,
    Dict(1 => 0.107694, 7 => 0.000816, 58 => 0.00204),
)
CsI = Material(
    "Cesium Iodide",
    0.41569,
    553.1eV,
    4.51g / cm^3,
    Dict(53 => 0.488451, 55 => 0.511549),
)
concrete = Material(
    "Concrete, Ordinary",
    0.50932,
    124.5eV,
    2.3g / cm^3,
    Dict(
        1 => 0.0221,
        6 => 0.002484,
        8 => 0.57493,
        11 => 0.015208,
        12 => 0.001266,
        13 => 0.019953,
        14 => 0.304627,
        19 => 0.010045,
        20 => 0.042951,
        26 => 0.006435,
    ),
)
concretebarite = Material(
    "Concrete, Barite (TYPE BA)",
    0.45714,
    248.2eV,
    3.35g / cm^3,
    Dict(
        1 => 0.003585,
        8 => 0.311622,
        12 => 0.001195,
        13 => 0.004183,
        14 => 0.010457,
        16 => 0.107858,
        20 => 0.050194,
        26 => 0.047505,
        56 => 0.4634,
    ),
)
eyelens = Material(
    "Eye Lens (ICRU-44)",
    0.54709,
    74.3eV,
    1.07g / cm^3,
    Dict(
        1 => 0.096,
        6 => 0.195,
        7 => 0.057,
        8 => 0.646,
        11 => 0.001,
        15 => 0.001,
        16 => 0.003,
        17 => 0.001,
    ),
)
ferroussulfate = Material(
    "Ferrous Sulfate Standard Fricke",
    0.55334,
    76.3eV,
    1.024g / cm^3,
    Dict(
        1 => 0.108376,
        8 => 0.878959,
        11 => 2.2e-05,
        16 => 0.012553,
        17 => 3.5e-05,
        26 => 5.5e-05,
    ),
)
GOS = Material(
    "Gadolinium Oxysulfide",
    0.42265,
    493.3eV,
    7.44g / cm^3,
    Dict(8 => 0.084527, 16 => 0.084704, 64 => 0.830769),
)
gafchromicsensor = Material(
    "Gafchromic Sensor",
    0.54384,
    67.2eV,
    1.3g / cm^3,
    Dict(1 => 0.0897, 6 => 0.6058, 7 => 0.1122, 8 => 0.1923),
)
GaAs = Material(
    "Gallium Arsenide",
    0.44246,
    384.9eV,
    5.31g / cm^3,
    Dict(31 => 0.48203, 33 => 0.51797),
)
pyrex = Material(
    "Glass, Borosilicate (Pyrex)",
    0.49707,
    134.0eV,
    2.23g / cm^3,
    Dict(
        5 => 0.040066,
        8 => 0.539559,
        11 => 0.028191,
        13 => 0.011644,
        14 => 0.37722,
        19 => 0.003321,
    ),
)
leadglass = Material(
    "Glass, Lead",
    0.42101,
    526.4eV,
    6.22g / cm^3,
    Dict(
        8 => 0.156453,
        14 => 0.080866,
        22 => 0.008092,
        33 => 0.002651,
        82 => 0.751938,
    ),
)
LiF = Material(
    "Lithium Fluride",
    0.46262,
    94.0eV,
    2.635g / cm^3,
    Dict(3 => 0.267585, 9 => 0.732415),
)
LiB4O7 = Material(
    "Lithium Tetraborate",
    0.48485,
    94.6eV,
    2.44g / cm^3,
    Dict(3 => 0.082081, 5 => 0.255715, 8 => 0.662204),
)
lung = Material(
    "Lung Tissue (ICRU-44)",
    0.55048,
    75.2eV,
    1.05g / cm^3,
    Dict(
        1 => 0.103,
        6 => 0.105,
        7 => 0.031,
        8 => 0.749,
        11 => 0.002,
        15 => 0.002,
        16 => 0.003,
        17 => 0.003,
        19 => 0.002,
    ),
)
MgB4O7 = Material(
    "Magnesium Tetroborate",
    0.49012,
    108.3eV,
    2.53g / cm^3,
    Dict(5 => 0.24087, 8 => 0.623762, 12 => 0.135367),
)
MgI2 = Material(
    "Mercuric Iodide",
    0.40933,
    684.5eV,
    6.36g / cm^3,
    Dict(53 => 0.55856, 80 => 0.44144),
)
muscle = Material(
    "Muscle, Skeletal (ICRU-44)",
    0.55,
    74.6eV,
    1.05g / cm^3,
    Dict(
        1 => 0.102,
        6 => 0.143,
        7 => 0.034,
        8 => 0.71,
        11 => 0.001,
        15 => 0.002,
        16 => 0.003,
        17 => 0.001,
        19 => 0.004,
    ),
)
ovary = Material(
    "Ovary (ICRU-44)",
    0.55149,
    75.0eV,
    1.05g / cm^3,
    Dict(
        1 => 0.105,
        6 => 0.093,
        7 => 0.024,
        8 => 0.768,
        11 => 0.002,
        15 => 0.002,
        16 => 0.002,
        17 => 0.002,
        19 => 0.002,
    ),
)
emulsionkodak = Material(
    "Photographic Emulsion (Kodak Type AA)",
    0.48176,
    179.0eV,
    2.2g / cm^3,
    Dict(
        1 => 0.0305,
        6 => 0.2107,
        7 => 0.0721,
        8 => 0.1632,
        35 => 0.2228,
        47 => 0.3007,
    ),
)
emulsionstandard = Material(
    "Photographic Emulsion (Standard Nuclear)",
    0.45453,
    331.0eV,
    3.815g / cm^3,
    Dict(
        1 => 0.0141,
        6 => 0.072261,
        7 => 0.01932,
        8 => 0.066101,
        16 => 0.00189,
        35 => 0.349104,
        47 => 0.474105,
        53 => 0.00312,
    ),
)
vinyltoluene = Material(
    "Plastic Scintillator, Vinyltoluene",
    0.54141,
    64.7eV,
    1.032g / cm^3,
    Dict(1 => 0.085, 6 => 0.915),
)
polyethylene = Material(
    "Polyethylene",
    0.57033,
    57.4eV,
    0.93g / cm^3,
    Dict(1 => 0.143716, 6 => 0.856284),
)
mylar = Material(
    "Polyethylene Terephthalate, (Mylar)",
    0.52037,
    78.7eV,
    1.38g / cm^3,
    Dict(1 => 0.04196, 6 => 0.625016, 8 => 0.333024),
)
PMMA = Material(
    "Polymethyl Methacrylate",
    0.53937,
    74.0eV,
    1.19g / cm^3,
    Dict(1 => 0.080541, 6 => 0.599846, 8 => 0.319613),
)
polystyrene = Material(
    "Polystyrene",
    0.53768,
    68.7eV,
    1.06g / cm^3,
    Dict(1 => 0.077421, 6 => 0.922579),
)
teflon = Material(
    "Polytetrafluoroethylene, (Teflon)",
    0.47993,
    99.1eV,
    2.25g / cm^3,
    Dict(6 => 0.240183, 9 => 0.759818),
)
PVC = Material(
    "Polyvinyl Chloride",
    0.51201,
    108.2eV,
    1.406g / cm^3,
    Dict(1 => 0.048382, 6 => 0.384361, 17 => 0.567257),
)
nylonfilm = Material(
    "Radiochromic Dye Film, Nylon Base",
    0.54987,
    64.5eV,
    1.08g / cm^3,
    Dict(1 => 0.101996, 6 => 0.654396, 7 => 0.098915, 8 => 0.144693),
)
testis = Material(
    "Testis (ICRU-44)",
    0.552,
    74.7eV,
    1.04g / cm^3,
    Dict(
        1 => 0.106,
        6 => 0.099,
        7 => 0.02,
        8 => 0.766,
        11 => 0.002,
        15 => 0.001,
        16 => 0.002,
        17 => 0.002,
        19 => 0.002,
    ),
)
softtissue = Material(
    "Tissue, Soft (ICRU-44)",
    0.54996,
    74.7eV,
    1.06g / cm^3,
    Dict(
        1 => 0.102,
        6 => 0.143,
        7 => 0.034,
        8 => 0.708,
        11 => 0.002,
        15 => 0.003,
        16 => 0.003,
        17 => 0.002,
        19 => 0.003,
    ),
)
softtissue4 = Material(
    "Tissue, Soft (ICRU Four-Component)",
    0.54975,
    74.9eV,
    1.0g / cm^3,
    Dict(1 => 0.101174, 6 => 0.111, 7 => 0.026, 8 => 0.761826),
)
methane = Material(
    "Tissue-Equivalent Gas, Methane Based",
    0.54992,
    61.2eV,
    0.001064g / cm^3,
    Dict(1 => 0.101873, 6 => 0.456177, 7 => 0.035172, 8 => 0.406778),
)
propane = Material(
    "Tissue-Equivalent Gas, Propane Based",
    0.55027,
    59.5eV,
    0.001826g / cm^3,
    Dict(1 => 0.102676, 6 => 0.568937, 7 => 0.035022, 8 => 0.293365),
)
water = Material(
    "Water, Liquid",
    0.55508,
    75.0eV,
    1.0g / cm^3,
    Dict(1 => 0.111898, 8 => 0.888102),
)

end # module
