# NCBIBlast

[![Build Status](https://github.com/BioJulia/NCBIBlast.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/kescobo/NCBIBlast.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/kescobo/NCBIBlast.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/kescobo/NCBIBlast.jl)

This package is a thin wrapper around the
Basic Local Alignment Search Tool CLI,
better known as BLAST,
developed by the National Center for Biotechnology Information (NCBI).

For now,
this uses `CondaPkg.jl` to install BLAST+.


## Examples


```julia-repl
julia> makeblastdb(; in="test/example_files/dna2.fasta", dbtype="nucl")


Building a new DB, current time: 10/07/2024 16:59:40
New DB name:   /home/kevin/Repos/NCBIBlast.jl/test/example_files/dna2.fasta
New DB title:  test/example_files/dna2.fasta
Sequence type: Nucleotide
Keep MBits: T
Maximum file size: 3000000000B
Adding sequences from FASTA; added 2 sequences in 0.00329995 seconds.


Process(`makeblastdb -in test/example_files/dna2.fasta -dbtype nucl`, ProcessExited(0))

julia> julia> (tmp_path, tmp_io)  = mktemp()
("/tmp/jl_w9A5Xd", IOStream(<fd 26>))

julia> println(tmp_io, ">testseq"); println(tmp_io, "CTGCGTGTTGCCGATATTCTGGAAAGCA");

julia> println(tmp_io, ">testseq2"); println(tmp_io, "CTGCGTGTTGCCGATATTCTGGCGCA");

julia> flush(tmp_io)

julia> blastn(; query=tmp_path, db="test/example_files/dna2.fasta")
BLASTN 2.16.0+


Reference: Zheng Zhang, Scott Schwartz, Lukas Wagner, and Webb
Miller (2000), "A greedy algorithm for aligning DNA sequences", J
Comput Biol 2000; 7(1-2):203-14.



Database: test/example_files/dna2.fasta
           2 sequences; 560 total letters



Query= testseq

Length=28
                                                                      Score     E
Sequences producing significant alignments:                          (Bits)  Value

Test2                                                                 52.8    1e-12


>Test2
Length=280

 Score = 52.8 bits (28),  Expect = 1e-12
 Identities = 28/28 (100%), Gaps = 0/28 (0%)
 Strand=Plus/Plus

Query  1    CTGCGTGTTGCCGATATTCTGGAAAGCA  28
            ||||||||||||||||||||||||||||
Sbjct  108  CTGCGTGTTGCCGATATTCTGGAAAGCA  135



Lambda      K        H
    1.33    0.621     1.12

Gapped
Lambda      K        H
    1.28    0.460    0.850

Effective search space used: 11466


Query= testseq

Length=28
                                                                      Score     E
Sequences producing significant alignments:                          (Bits)  Value

Test2                                                                 52.8    1e-12


>Test2
Length=280

 Score = 52.8 bits (28),  Expect = 1e-12
 Identities = 28/28 (100%), Gaps = 0/28 (0%)
 Strand=Plus/Plus

Query  1    CTGCGTGTTGCCGATATTCTGGAAAGCA  28
            ||||||||||||||||||||||||||||
Sbjct  108  CTGCGTGTTGCCGATATTCTGGAAAGCA  135



Lambda      K        H
    1.33    0.621     1.12

Gapped
Lambda      K        H
    1.28    0.460    0.850

Effective search space used: 11466


  Database: test/example_files/dna2.fasta
    Posted date:  Oct 7, 2024  4:59 PM
  Number of letters in database: 560
  Number of sequences in database:  2



Matrix: blastn matrix 1 -2
Gap Penalties: Existence: 0, Extension: 2.5
```


