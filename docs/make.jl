using Documenter, Attenuations

makedocs(;
    modules = [Attenuations],
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
    ],
    repo = "https://github.com/kczimm/Attenuations.jl/blob/{commit}{path}#L{line}",
    sitename = "Attenuations.jl",
    assets = String[],
)
deploydocs(repo = "github.com/kczimm/Attenuations.jl")
