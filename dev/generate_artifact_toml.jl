using Pkg
Pkg.activate(@__DIR__)

##

using Pkg: BinaryPlatforms
using ArtifactUtils: add_artifact!

blast_version = "2.16.0"
url_common = "https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/$(blast_version)/ncbi-blast-$(blast_version)+-"
platform_url_pairs = [
    BinaryPlatforms.MacOS(:aarch64)  => "$(url_common)aarch64-macosx.tar.gz",
    BinaryPlatforms.MacOS(:x86_64)   => "$(url_common)x64-macosx.tar.gz",
    BinaryPlatforms.Linux(:aarch64)  => "$(url_common)aarch64-linux.tar.gz",
    BinaryPlatforms.Linux(:x86_64)   => "$(url_common)x64-linux.tar.gz",
    BinaryPlatforms.Windows(:x86_64) => "$(url_common)x64-win64.tar.gz"
]

foreach(platform_url_pairs) do (platform, url)
    add_artifact!("Artifacts.toml", "ncbi-blast", url; platform, force=true)
end

##
