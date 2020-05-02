using Documenter, Attenuations

makedocs(
    sitename = "Attenuations",
    modules = [Attenuations, Attenuations.Elements, Attenuations.Materials],
    pages = ["Home" => "index.md", "Mechanisms" => "mechanisms.md"],
)
