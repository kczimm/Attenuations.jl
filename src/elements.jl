module Elements

using AxisArrays
using ..Attenuations: Matter,
                      Attenuation,
                      WithCoherent,
                      bodykey,
                      formatenergies,
                      XCOM
import ..Attenuations: μᵨ
using Unitful
using Unitful: eV, g, cm

export μ, μᵨ, elements

struct Element{T,S} <: Matter where {T<:Unitful.Energy,S<:Unitful.Density}
    Z::Int
    symbol::String
    name::String
    ZAratio::Float64
    I::T
    ρ::S
end

function μᵨ(
    e::Element,
    energies::AbstractArray{<:Unitful.Energy},
    a::Type{<:Attenuation},
)
    body = Dict{String,String}(
        "Method" => "1",
        "ZNum" => "$(e.Z)",
        bodykey(a) => "on",
        "Energies" => formatenergies(energies),
    )

    μᵨ = XCOM(body) * cm^2 ./ g
    AxisArray(μᵨ, Axis{:energy}(energies))
end

μᵨ(e::Element, energies::AbstractArray{<:Unitful.Energy}) =
    μᵨ(e, energies, WithCoherent)

μ(
  e::Element,
  energies::AbstractArray{<:Unitful.Energy},
  a::Type{<:Attenuation},
) = AxisArray(e.ρ * μᵨ(e, energies, a), Axis{:energy}(energies))

μ(e::Element, energies::AbstractArray{<:Unitful.Energy}) =
    μ(e, energies, WithCoherent)

μᵨ(e::Element, energy::T, a::Type{<:Attenuation}) where {T<:Unitful.Energy} =
    μᵨ(e, [energy], a)[1]

μᵨ(e::Element, energy::T) where {T<:Unitful.Energy} =
    μᵨ(e, [energy], WithCoherent)[1]

μ(e::Element, energy::T, a::Type{<:Attenuation}) where {T<:Unitful.Energy} =
    μ(e, [energy], a)[1]

μ(e::Element, energy::T) where {T<:Unitful.Energy} =
    μ(e, [energy], WithCoherent)[1]

Base.show(io::IO, e::Element) = print(
    io,
    "$(e.Z) $(e.symbol) $(e.name) Z/A=$(e.ZAratio) I=$(e.I.val)eV ρ=$(e.ρ.val)g/cm³",
)

Hydrogen = Element(1, "H", "Hydrogen", 0.99212, 19.2eV, 8.375E-05g / cm^3)
Helium = Element(2, "He", "Helium", 0.49968, 41.8eV, 1.663E-04g / cm^3)
Lithium = Element(3, "Li", "Lithium", 0.43221, 40.0eV, 5.340E-01g / cm^3)
Beryllium = Element(4, "Be", "Beryllium", 0.44384, 63.7eV, 1.848E+00g / cm^3)
Boron = Element(5, "B", "Boron", 0.46245, 76.0eV, 2.370E+00g / cm^3)
Carbon = Element(6, "C", "Carbon", 0.49954, 78.0eV, 1.700E+00g / cm^3)
Nitrogen = Element(7, "N", "Nitrogen", 0.49976, 82.0eV, 1.165E-03g / cm^3)
Oxygen = Element(8, "O", "Oxygen", 0.50002, 95.0eV, 1.332E-03g / cm^3)
Fluorine = Element(9, "F", "Fluorine", 0.47372, 115.0eV, 1.580E-03g / cm^3)
Neon = Element(10, "Ne", "Neon", 0.49555, 137.0eV, 8.385E-04g / cm^3)
Sodium = Element(11, "Na", "Sodium", 0.47847, 149.0eV, 9.710E-01g / cm^3)
Magnesium = Element(12, "Mg", "Magnesium", 0.49373, 156.0eV, 1.740E+00g / cm^3)
Aluminum = Element(13, "Al", "Aluminum", 0.48181, 166.0eV, 2.699E+00g / cm^3)
Silicon = Element(14, "Si", "Silicon", 0.49848, 173.0eV, 2.330E+00g / cm^3)
Phosphorus = Element(15, "P", "Phosphorus", 0.48428, 173.0eV, 2.200E+00g / cm^3)
Sulfur = Element(16, "S", "Sulfur", 0.49897, 180.0eV, 2.000E+00g / cm^3)
Chlorine = Element(17, "Cl", "Chlorine", 0.47951, 174.0eV, 2.995E-03g / cm^3)
Argon = Element(18, "Ar", "Argon", 0.45059, 188.0eV, 1.662E-03g / cm^3)
Potassium = Element(19, "K", "Potassium", 0.48595, 190.0eV, 8.620E-01g / cm^3)
Calcium = Element(20, "Ca", "Calcium", 0.49903, 191.0eV, 1.550E+00g / cm^3)
Scandium = Element(21, "Sc", "Scandium", 0.46712, 216.0eV, 2.989E+00g / cm^3)
Titanium = Element(22, "Ti", "Titanium", 0.45948, 233.0eV, 4.540E+00g / cm^3)
Vanadium = Element(23, "V", "Vanadium", 0.45150, 245.0eV, 6.110E+00g / cm^3)
Chromium = Element(24, "Cr", "Chromium", 0.46157, 257.0eV, 7.180E+00g / cm^3)
Manganese = Element(25, "Mn", "Manganese", 0.45506, 272.0eV, 7.440E+00g / cm^3)
Iron = Element(26, "Fe", "Iron", 0.46556, 286.0eV, 7.874E+00g / cm^3)
Cobalt = Element(27, "Co", "Cobalt", 0.45815, 297.0eV, 8.900E+00g / cm^3)
Nickel = Element(28, "Ni", "Nickel", 0.47708, 311.0eV, 8.902E+00g / cm^3)
Copper = Element(29, "Cu", "Copper", 0.45636, 322.0eV, 8.960E+00g / cm^3)
Zinc = Element(30, "Zn", "Zinc", 0.45879, 330.0eV, 7.133E+00g / cm^3)
Gallium = Element(31, "Ga", "Gallium", 0.44462, 334.0eV, 5.904E+00g / cm^3)
Germanium = Element(32, "Ge", "Germanium", 0.44071, 350.0eV, 5.323E+00g / cm^3)
Arsenic = Element(33, "As", "Arsenic", 0.44046, 347.0eV, 5.730E+00g / cm^3)
Selenium = Element(34, "Se", "Selenium", 0.43060, 348.0eV, 4.500E+00g / cm^3)
Bromine = Element(35, "Br", "Bromine", 0.43803, 343.0eV, 7.072E-03g / cm^3)
Krypton = Element(36, "Kr", "Krypton", 0.42959, 352.0eV, 3.478E-03g / cm^3)
Rubidium = Element(37, "Rb", "Rubidium", 0.43291, 363.0eV, 1.532E+00g / cm^3)
Strontium = Element(38, "Sr", "Strontium", 0.43369, 366.0eV, 2.540E+00g / cm^3)
Yttrium = Element(39, "Y", "Yttrium", 0.43867, 379.0eV, 4.469E+00g / cm^3)
Zirconium = Element(40, "Zr", "Zirconium", 0.43848, 393.0eV, 6.506E+00g / cm^3)
Niobium = Element(41, "Nb", "Niobium", 0.44130, 417.0eV, 8.570E+00g / cm^3)
Molybdenum = Element(
    42,
    "Mo",
    "Molybdenum",
    0.43777,
    424.0eV,
    1.022E+01g / cm^3,
)
Technetium = Element(
    43,
    "Tc",
    "Technetium",
    0.43919,
    428.0eV,
    1.150E+01g / cm^3,
)
Ruthenium = Element(44, "Ru", "Ruthenium", 0.43534, 441.0eV, 1.241E+01g / cm^3)
Rhodium = Element(45, "Rh", "Rhodium", 0.43729, 449.0eV, 1.241E+01g / cm^3)
Palladium = Element(46, "Pd", "Palladium", 0.43225, 470.0eV, 1.202E+01g / cm^3)
Silver = Element(47, "Ag", "Silver", 0.43572, 470.0eV, 1.050E+01g / cm^3)
Cadmium = Element(48, "Cd", "Cadmium", 0.42700, 469.0eV, 8.650E+00g / cm^3)
Indium = Element(49, "In", "Indium", 0.42676, 488.0eV, 7.310E+00g / cm^3)
Tin = Element(50, "Sn", "Tin", 0.42120, 488.0eV, 7.310E+00g / cm^3)
Antimony = Element(51, "Sb", "Antimony", 0.41889, 487.0eV, 6.691E+00g / cm^3)
Tellurium = Element(52, "Te", "Tellurium", 0.40752, 485.0eV, 6.240E+00g / cm^3)
Iodine = Element(53, "I", "Iodine", 0.41764, 491.0eV, 4.930E+00g / cm^3)
Xenon = Element(54, "Xe", "Xenon", 0.41130, 482.0eV, 5.485E-03g / cm^3)
Cesium = Element(55, "Cs", "Cesium", 0.41383, 488.0eV, 1.873E+00g / cm^3)
Barium = Element(56, "Ba", "Barium", 0.40779, 491.0eV, 3.500E+00g / cm^3)
Lanthanum = Element(57, "La", "Lanthanum", 0.41035, 501.0eV, 6.154E+00g / cm^3)
Cerium = Element(58, "Ce", "Cerium", 0.41395, 523.0eV, 6.657E+00g / cm^3)
Praseodymium = Element(
    59,
    "Pr",
    "Praseodymium",
    0.41871,
    535.0eV,
    6.710E+00g / cm^3,
)
Neodymium = Element(60, "Nd", "Neodymium", 0.41597, 546.0eV, 6.900E+00g / cm^3)
Promethium = Element(
    61,
    "Pm",
    "Promethium",
    0.42094,
    560.0eV,
    7.220E+00g / cm^3,
)
Samarium = Element(62, "Sm", "Samarium", 0.41234, 574.0eV, 7.460E+00g / cm^3)
Europium = Element(63, "Eu", "Europium", 0.41457, 580.0eV, 5.243E+00g / cm^3)
Gadolinium = Element(
    64,
    "Gd",
    "Gadolinium",
    0.40699,
    591.0eV,
    7.900E+00g / cm^3,
)
Terbium = Element(65, "Tb", "Terbium", 0.40900, 614.0eV, 8.229E+00g / cm^3)
Dysprosium = Element(
    66,
    "Dy",
    "Dysprosium",
    0.40615,
    628.0eV,
    8.550E+00g / cm^3,
)
Holmium = Element(67, "Ho", "Holmium", 0.40623, 650.0eV, 8.795E+00g / cm^3)
Erbium = Element(68, "Er", "Erbium", 0.40655, 658.0eV, 9.066E+00g / cm^3)
Thulium = Element(69, "Tm", "Thulium", 0.40844, 674.0eV, 9.321E+00g / cm^3)
Ytterbium = Element(70, "Yb", "Ytterbium", 0.40453, 684.0eV, 6.730E+00g / cm^3)
Lutetium = Element(71, "Lu", "Lutetium", 0.40579, 694.0eV, 9.840E+00g / cm^3)
Hafnium = Element(72, "Hf", "Hafnium", 0.40338, 705.0eV, 1.331E+01g / cm^3)
Tantalum = Element(73, "Ta", "Tantalum", 0.40343, 718.0eV, 1.665E+01g / cm^3)
Tungsten = Element(74, "W", "Tungsten", 0.40250, 727.0eV, 1.930E+01g / cm^3)
Rhenium = Element(75, "Re", "Rhenium", 0.40278, 736.0eV, 2.102E+01g / cm^3)
Osmium = Element(76, "Os", "Osmium", 0.39958, 746.0eV, 2.257E+01g / cm^3)
Iridium = Element(77, "Ir", "Iridium", 0.40058, 757.0eV, 2.242E+01g / cm^3)
Platinum = Element(78, "Pt", "Platinum", 0.39984, 790.0eV, 2.145E+01g / cm^3)
Gold = Element(79, "Au", "Gold", 0.40108, 790.0eV, 1.932E+01g / cm^3)
Mercury = Element(80, "Hg", "Mercury", 0.39882, 800.0eV, 1.355E+01g / cm^3)
Thallium = Element(81, "Tl", "Thallium", 0.39631, 810.0eV, 1.172E+01g / cm^3)
Lead = Element(82, "Pb", "Lead", 0.39575, 823.0eV, 1.135E+01g / cm^3)
Bismuth = Element(83, "Bi", "Bismuth", 0.39717, 823.0eV, 9.747E+00g / cm^3)
Polonium = Element(84, "Po", "Polonium", 0.40195, 830.0eV, 9.320E+00g / cm^3)
Astatine = Element(85, "At", "Astatine", 0.40479, 825.0eV, 1.000E+01g / cm^3)
Radon = Element(86, "Rn", "Radon", 0.38736, 794.0eV, 9.066E-03g / cm^3)
Francium = Element(87, "Fr", "Francium", 0.39010, 827.0eV, 1.000E+01g / cm^3)
Radium = Element(88, "Ra", "Radium", 0.38934, 826.0eV, 5.000E+00g / cm^3)
Actinium = Element(89, "Ac", "Actinium", 0.39202, 841.0eV, 1.007E+01g / cm^3)
Thorium = Element(90, "Th", "Thorium", 0.38787, 847.0eV, 1.172E+01g / cm^3)
Protactinium = Element(
    91,
    "Pa",
    "Protactinium",
    0.39388,
    878.0eV,
    1.537E+01g / cm^3,
)
Uranium = Element(92, "U", "Uranium", 0.38651, 890.0eV, 1.895E+01g / cm^3)

elements = [
    Hydrogen,
    Helium,
    Lithium,
    Beryllium,
    Boron,
    Carbon,
    Nitrogen,
    Oxygen,
    Fluorine,
    Neon,
    Sodium,
    Magnesium,
    Aluminum,
    Silicon,
    Phosphorus,
    Sulfur,
    Chlorine,
    Argon,
    Potassium,
    Calcium,
    Scandium,
    Titanium,
    Vanadium,
    Chromium,
    Manganese,
    Iron,
    Cobalt,
    Nickel,
    Copper,
    Zinc,
    Gallium,
    Germanium,
    Arsenic,
    Selenium,
    Bromine,
    Krypton,
    Rubidium,
    Strontium,
    Yttrium,
    Zirconium,
    Niobium,
    Molybdenum,
    Technetium,
    Ruthenium,
    Rhodium,
    Palladium,
    Silver,
    Cadmium,
    Indium,
    Tin,
    Antimony,
    Tellurium,
    Iodine,
    Xenon,
    Cesium,
    Barium,
    Lanthanum,
    Cerium,
    Praseodymium,
    Neodymium,
    Promethium,
    Samarium,
    Europium,
    Gadolinium,
    Terbium,
    Dysprosium,
    Holmium,
    Erbium,
    Thulium,
    Ytterbium,
    Lutetium,
    Hafnium,
    Tantalum,
    Tungsten,
    Rhenium,
    Osmium,
    Iridium,
    Platinum,
    Gold,
    Mercury,
    Thallium,
    Lead,
    Bismuth,
    Polonium,
    Astatine,
    Radon,
    Francium,
    Radium,
    Actinium,
    Thorium,
    Protactinium,
    Uranium,
]

end # module
