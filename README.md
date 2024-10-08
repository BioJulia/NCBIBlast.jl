# NCBIBlast

[![Build Status](https://github.com/BioJulia/NCBIBlast.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/kescobo/NCBIBlast.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/kescobo/NCBIBlast.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/kescobo/NCBIBlast.jl)

This package is a thin wrapper around the
Basic Local Alignment Search Tool CLI,
better known as BLAST,
developed by the National Center for Biotechnology Information (NCBI).

For now,
this uses `CondaPkg.jl` to install BLAST+.

## Usage

This package provides a thin-wrapper around the [BLAST+ command line tools](https://www.ncbi.nlm.nih.gov/books/NBK569856/):

- `blastn`
- `blastp`
- `tblastn`
- `blastx`
- `makeblastdb`

For each tool is controlled by keyword arguments,
which are generally passed as `-key value`,
unless `value` is `true`, in which case it is passed as `-key`.

For example,
the julia call 

```julia
blastn(; query = "a_file.txt", db="mydb", out="results.txt")
```

Will be sent to the shell as

```sh
$ blastn -query a_file.txt -db mydb -out results.txt
```

For all but `makeblastdb`,
you can also pass a positional argument
that will be piped as `STDIN`,
and the special keyword argument `stdout`
where results will be passed instead of being printed to the screen.
The `stdout` kwarg can be a `String` representing a path,
in which case a file will be created,
or a julia `IO` type, in which case the results will be written to that object.

For example,
to replicate the shell command

```sh
$ blastn -remote -outfmt "6 query subject expect" -db nr < myfile.fastn > output.tsv
```

You can do


```julia
blastn("myfile.fastn"; stdout="output.tsv", remote=true, outfmt="6 query subject expect", db="nr")
```



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

julia> buf = IOBuffer("TTACCTGCCGTGAGTAAATTAAAATTTTATTGACTTAG")
IOBuffer(data=UInt8[...], readable=true, writable=false, seekable=true, append=false, size=38, maxsize=Inf, ptr=1, mark=-1)

julia> blastn(buf; db="test/example_files/dna2.fasta", outfmt="6")
Query_1 Test1   100.000 38      0       0       1       38      82      119     5.64e-18        71.3
Process(`blastn -db test/example_files/dna2.fasta -outfmt 6`, ProcessExited(0))

julia> using CSV, DataFrames

julia> io = IOBuffer();

julia> blastn(buf; stdout=io, db="test/example_files/dna2.fasta", outfmt="6");

julia> seek(io, 0);

julia> CSV.read(io, DataFrame; header=false)
1×12 DataFrame
 Row │ Column1  Column2  Column3  Column4  Column5  Column6  Column7  Column8  Column9  Column10  Column11  Column12
     │ String7  String7  Float64  Int64    Int64    Int64    Int64    Int64    Int64    Int64     Float64   Float64
─────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ Query_1  Test1      100.0       38        0        0        1       38       82       119  5.64e-18      71.3

```


