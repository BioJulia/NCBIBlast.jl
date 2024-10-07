using NCBIBlast
using Test

@testset "NCBIBlast.jl" begin
    @test blastn(; h=true) isa Base.Process
    @test blastp(; h=true) isa Base.Process
    @test makeblastdb(; h=true) isa Base.Process
end
