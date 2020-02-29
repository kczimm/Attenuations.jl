module Attenuations

using AxisArrays
using HTTP
using Unitful

import Unitful: g, cm, keV, MeV

export μ,
    μᵨ,
    keV,
    Elements,
    Compound,
    Mixture,
    Materials,
    PhotoelectricAbsorption,
    Coherent,
    Incoherent,
    InNuclearField,
    InElectronField,
    WithCoherent,
    WithoutCoherent,
    data

function μ end
function μᵨ end

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

abstract type Matter end

data(a::AbstractArray{T}) where {T<:Unitful.AbstractQuantity} =
    [i.val for i in a.data]

include("xcom.jl")

include("compound.jl")
include("mixture.jl")
include("elements.jl")
include("materials.jl")

end # module
