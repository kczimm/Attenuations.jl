module Attenuations

using AxisArrays
using HTTP
using Unitful

import Unitful: g, cm, eV, keV, MeV
export eV, keV, MeV

export μ,
    μᵨ,
    Element,
    Compound,
    Mixture,
    Elements,
    Materials,
    PhotoelectricAbsorption,
    Coherent,
    Incoherent,
    InNuclearField,
    InElectronField,
    WithCoherent,
    WithoutCoherent,
    val

abstract type Attenuation end

"""
PhotoelectricAbsorption is one of the principal forms of interaction of x-ray
and gamma photons with matter. A low energy photon interacts with an electron
in the atom and removes it from its shell.

https://en.wikipedia.org/wiki/Photoelectric_effect
https://radiopaedia.org/articles/photoelectric-effect
"""
struct PhotoelectricAbsorption <: Attenuation end


abstract type Scattering <: Attenuation end
"""
Coherent scattering (also known as unmodified, Rayleigh, classical or elastic
scattering) is one of three forms of photon interaction which occurs when the
energy of the x-ray or gamma photon is small in relation to the ionization
energy of the atom. It therefore occurs with low energy radiation.

Upon interacting with the attenuating medium, the photon does not have enough
energy to liberate the electron from its bound state (i.e. the photon energy is
well below the binding energy of the electron) so no energy transfer occurs.
There is no energy deposition and thus no dose resulting from coherent
scattering. The only change is a change of direction (scatter) of the photon,
hence 'unmodified' scatter. Coherent scattering is not a major interaction
process encountered in radiography at the energies normally used.

Coherent scattering varies with the atomic number of the absorber (Z) and
incident photon energy (E) by Z/E².

https://radiopaedia.org/articles/coherent-scattering
"""
struct Coherent <: Scattering end

"""
Incoherent scatter (Compton effect or Compton scatter) is one of principle forms
of photon interaction. It is the main cause of scattered radiation in a
material. It occurs due to the interaction of the photon (x-ray or gamma) with
free electrons (unattached to atoms) or loosely bound valence shell
(outer shell) electrons. The resultant incident photon is scattered
(changes direction) and imparts energy to the electron (recoil electron). The
scattered photon will have a different wavelength (observed phenomenon) and thus
a different energy (E=hc/λ). Energy and momentum are conserved in this process.
The Compton effect is a partial absorption process and as the original photon
has lost energy, known as Compton shift (i.e. a shift of wavelength/frequency).
The wavelength change of the scattered photon can be determined by
0.024*(1- cosθ), where θ is scattered photon angle. Thus, the energy of the
scattered photon decreases with increasing scattered photon angle.

https://en.wikipedia.org/wiki/Compton_scattering
https://radiopaedia.org/articles/compton-effect?lang=us
"""
struct Incoherent <: Scattering end

abstract type PairProduction <: Attenuation end
struct InNuclearField <: PairProduction end
struct InElectronField <: PairProduction end
abstract type Total <: Attenuation end
struct WithCoherent <: Total end
struct WithoutCoherent <: Total end

const DefaultAttenuation = WithCoherent

abstract type Matter end

"""
    Element

An element of the periodic table.
"""
struct Element{T,S} <: Matter where {T<:Unitful.Energy,S<:Unitful.Density}
    Z::Int
    symbol::String
    name::String
    ZAratio::Float64
    I::T
    ρ::S
end
Base.show(io::IO, e::Element) = print(
    io,
    "$(e.Z) $(e.symbol) $(e.name) Z/A=$(e.ZAratio) I=$(e.I.val)eV ρ=$(e.ρ.val)g/cm³",
)

"""
    Compound
"""
struct Compound <: Matter
    formula::String
end

"""
    Mixture
"""
struct Mixture{T} <: Matter where {T<:AbstractFloat}
    formulae::Dict{String,T}
end

struct Material{T,S} <: Matter where {T<:Unitful.Energy,S<:Unitful.Density}
    name::String
    ZAratio::Float64
    I::T
    ρ::S
    composition::Dict{Int,Float64}
end
Base.show(io::IO, m::Material) = print(
    io,
    "$(m.name) Z/A=$(m.ZAratio) I=$(m.I) ρ=$(m.ρ)\r\n",
    join(["$k: $v" for (k, v) in m.composition], "\r\n"),
)

val(a::AbstractArray{T}) where {T<:Unitful.AbstractQuantity} =
[i.val for i in a.data]

val(a::T) where {T<:Unitful.AbstractQuantity} = a.val

"""
    μᵨ(
        material::Union{Matter, Element, Compound, Mixture, Material},
        energies::AbstractArray{<:Unitful.Energy},
        a::Type{A} = DefaultAttenuation,
    )

Calculate the mass attenuation coefficient for a given material.

The behavior of this function depends on the type of the first argument:

- `Matter`: the `energies` array is transformed into a single energy value.
- `Element`: The function uses the atomic number of the element (`e.Z`) to create a request body for the XCOM service, and returns the mass attenuation coefficient in cm²/g for the given energies.
- `Compound`: Similar to `Element`, but uses the compound's formula instead of the atomic number.
- `Mixture`: The function creates a request body with a string representation of the mixture's formulae and uses the XCOM service to calculate the mass attenuation coefficient for the given energies.
- `Material`: The function converts the material's composition into a `Mixture` and then proceeds as in the `Mixture` case.

The `a` argument determines the type of attenuation to apply and defaults to `DefaultAttenuation`.
"""
μᵨ(
    m::Matter,
    energy::T,
    a::Type{A} = DefaultAttenuation,
) where {T<:Unitful.Energy,A<:Attenuation} = μᵨ(m, [energy], a)[1]

function μᵨ(
    e::Element,
    energies::AbstractArray{<:Unitful.Energy},
    a::Type{<:Attenuation} = DefaultAttenuation,
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

function μᵨ(
    c::Compound,
    energies::AbstractArray{<:Unitful.Energy},
    a::Type{<:Attenuation} = DefaultAttenuation,
)
    body = Dict{String,String}(
        "Method" => "2",
        "Formula" => c.formula,
        bodykey(a) => "on",
        "Energies" => formatenergies(energies),
    )

    μᵨ = XCOM(body) * cm^2 ./ g
    AxisArray(μᵨ, Axis{:energy}(energies))
end

function μᵨ(
    m::Mixture,
    energies::AbstractArray{<:Unitful.Energy},
    a::Type{<:Attenuation},
)
    body = Dict{String,String}(
        "Method" => "3",
        "Formulae" => join(["$k $v" for (k, v) in m.formulae], '\n'),
        bodykey(a) => "on",
        "Energies" => formatenergies(energies),
    )

    μᵨ = XCOM(body) * cm^2 ./ g
    AxisArray(μᵨ, Axis{:energy}(energies))
end

μᵨ(
    m::Material,
    energies::AbstractArray{<:Unitful.Energy},
    a::Type{<:Attenuation} = DefaultAttenuation,
) = μᵨ(
    Mixture(Dict([(Elements[k].symbol, v) for (k, v) in m.composition])),
    energies,
    a,
)

"""
    μ(
        material::Union{Element, Material, Matter},
        energies::Union{AbstractArray{<:Unitful.Energy}, T},
        a::Type{<:Attenuation} = DefaultAttenuation,
    )

Calculate the linear attenuation coefficient for a given material.

The behavior of this function depends on the type of the first argument:

- `Element`: The function multiplies the density of the element (`e.ρ`) with the mass attenuation coefficient (`μᵨ`) for the given energies and returns the result.
- `Material`: The function multiplies the density of the material (`m.ρ`) with the mass attenuation coefficient (`μᵨ`) for the given energies and returns the result.
- `Matter`: If a single energy value is given instead of an array, the function converts it into a single-element array and calculates the linear attenuation coefficient for that energy.

The `a` argument determines the type of attenuation to apply and defaults to `DefaultAttenuation`.
"""
μ(
    e::Element,
    energies::AbstractArray{<:Unitful.Energy},
    a::Type{<:Attenuation} = DefaultAttenuation,
) = AxisArray(e.ρ * μᵨ(e, energies, a), Axis{:energy}(energies))

μ(
    m::Material,
    energies::AbstractArray{<:Unitful.Energy},
    a::Type{<:Attenuation} = DefaultAttenuation,
) = AxisArray(m.ρ * μᵨ(m, energies, a), Axis{:energy}(energies))

μ(
    m::Matter,
    energy::T,
    a::Type{A} = DefaultAttenuation,
) where {T<:Unitful.Energy,A<:Attenuation} = μ(m, [energy], a)[1]

include("xcom.jl")

include("elements.jl")
include("materials.jl")

end # module
