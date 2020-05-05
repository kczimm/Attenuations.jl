using Documenter, Attenuations

makedocs(
    sitename = "Attenuations",
    modules = [Attenuations],
    pages = ["Home" => "index.md", "Mechanisms" => "mechanisms.md"],
)
deploydocs(repo = "github.com/kczimm/Attenuations.jl")
