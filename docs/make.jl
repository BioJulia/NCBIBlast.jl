using NCBIBlast
using Documenter

DocMeta.setdocmeta!(NCBIBlast, :DocTestSetup, :(using NCBIBlast); recursive=true)

makedocs(;
    modules=[NCBIBlast],
    authors="Kevin Bonham <kevin@bonham.ch> and contributors",
    sitename="NCBIBlast.jl",
    format=Documenter.HTML(;
        canonical="https://kescobo.github.io/NCBIBlast.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/kescobo/NCBIBlast.jl",
    devbranch="main",
)
