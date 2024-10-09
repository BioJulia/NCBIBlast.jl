module NCBIBlast

export blastn,
       blastp,
       blastx,
       tblastn,
       tblastx,
       makeblastdb

using CondaPkg

function add_cli_kwargs!(cmd::Vector{String}, kwargs)
    for (key,val) in pairs(kwargs)
        if val isa Bool
            val && push!(cmd, string("-", key))
        else
            push!(cmd, string("-", key))
            if val isa AbstractVector
                append!(cmd, map(string, val))
            else
                push!(cmd, string(val))
            end
        end
    end

    return cmd
end


"""
    blastn([input]; stdout, kwargs...)

Run `blastn` with passed kwargs.
Use `arg=true` to pass flags
(eg `ungapped=true` will pass `-ungapped`).

Optionally, provide an input that will be provided
as `stdin` (a file string, or `IO` type).

To print results to somewhere other than `stdout`,
use eg `stdout="results.txt"`.

## Examples

- `blastn(; query="my_file.fasta", db=some_database, outfmt)`
- `blastn(IOBuffer("GATACA"); db="nr", remote=true)`


```
julia> blastn(; h=true)
USAGE
  blastn [-h] [-help] [-import_search_strategy filename]
    [-export_search_strategy filename] [-task task_name] [-db database_name]
    [-dbsize num_letters] [-gilist filename] [-seqidlist filename]
    [-negative_gilist filename] [-negative_seqidlist filename]
    [-taxids taxids] [-negative_taxids taxids] [-taxidlist filename]
    [-negative_taxidlist filename] [-no_taxid_expansion]
    [-entrez_query entrez_query] [-db_soft_mask filtering_algorithm]
    [-db_hard_mask filtering_algorithm] [-subject subject_input_file]
    [-subject_loc range] [-query input_file] [-out output_file]
    [-evalue evalue] [-word_size int_value] [-gapopen open_penalty]
    [-gapextend extend_penalty] [-perc_identity float_value]
    [-qcov_hsp_perc float_value] [-max_hsps int_value]
    [-xdrop_ungap float_value] [-xdrop_gap float_value]
    [-xdrop_gap_final float_value] [-searchsp int_value] [-penalty penalty]
    [-reward reward] [-no_greedy] [-min_raw_gapped_score int_value]
    [-template_type type] [-template_length int_value] [-dust DUST_options]
    [-filtering_db filtering_database]
    [-window_masker_taxid window_masker_taxid]
    [-window_masker_db window_masker_db] [-soft_masking soft_masking]
    [-ungapped] [-culling_limit int_value] [-best_hit_overhang float_value]
    [-best_hit_score_edge float_value] [-subject_besthit]
    [-window_size int_value] [-off_diagonal_range int_value]
    [-use_index boolean] [-index_name string] [-lcase_masking]
    [-query_loc range] [-strand strand] [-parse_deflines] [-outfmt format]
    [-show_gis] [-num_descriptions int_value] [-num_alignments int_value]
    [-line_length line_length] [-html] [-sorthits sort_hits]
    [-sorthsps sort_hsps] [-max_target_seqs num_sequences]
    [-num_threads int_value] [-mt_mode int_value] [-remote] [-version]

DESCRIPTION
   Nucleotide-Nucleotide BLAST 2.16.0+

Use '-help' to print detailed descriptions of command line arguments
```
"""
function blastn(stdin = nothing; stdout=stdout, kwargs...)
    cmd = ["blastn"]
    add_cli_kwargs!(cmd, kwargs)
    CondaPkg.withenv() do
        run(pipeline(Cmd(cmd); stdout, stdin))
    end
end



"""
blastp([input]; stdout, kwargs...)

Run `blastp` with passed kwargs.
Use `arg=true` to pass flags
(eg `lcase_masking=true` will pass `-lcase_masking`).

Optionally, provide an input that will be provided
as `stdin` (a file string, or `IO` type).

To print results to somewhere other than `stdout`,
use eg `stdout="results.txt"`.


```
julia> blastp(; h=true)
USAGE
  blastp [-h] [-help] [-import_search_strategy filename]
    [-export_search_strategy filename] [-task task_name] [-db database_name]
    [-dbsize num_letters] [-gilist filename] [-seqidlist filename]
    [-negative_gilist filename] [-negative_seqidlist filename]
    [-taxids taxids] [-negative_taxids taxids] [-taxidlist filename]
    [-negative_taxidlist filename] [-no_taxid_expansion] [-ipglist filename]
    [-negative_ipglist filename] [-entrez_query entrez_query]
    [-db_soft_mask filtering_algorithm] [-db_hard_mask filtering_algorithm]
    [-subject subject_input_file] [-subject_loc range] [-query input_file]
    [-out output_file] [-evalue evalue] [-word_size int_value]
    [-gapopen open_penalty] [-gapextend extend_penalty]
    [-qcov_hsp_perc float_value] [-max_hsps int_value]
    [-xdrop_ungap float_value] [-xdrop_gap float_value]
    [-xdrop_gap_final float_value] [-searchsp int_value] [-seg SEG_options]
    [-soft_masking soft_masking] [-matrix matrix_name]
    [-threshold float_value] [-culling_limit int_value]
    [-best_hit_overhang float_value] [-best_hit_score_edge float_value]
    [-subject_besthit] [-window_size int_value] [-lcase_masking]
    [-query_loc range] [-parse_deflines] [-outfmt format] [-show_gis]
    [-num_descriptions int_value] [-num_alignments int_value]
    [-line_length line_length] [-html] [-sorthits sort_hits]
    [-sorthsps sort_hsps] [-max_target_seqs num_sequences]
    [-num_threads int_value] [-mt_mode int_value] [-ungapped] [-remote]
    [-comp_based_stats compo] [-use_sw_tback] [-version]

DESCRIPTION
   Protein-Protein BLAST 2.16.0+
```
"""
function blastp(stdin = nothing; stdout=stdout, kwargs...)
    cmd = ["blastp"]
    add_cli_kwargs!(cmd, kwargs)
    CondaPkg.withenv() do
        run(pipeline(Cmd(cmd); stdout, stdin))
    end
end

"""
    blastx([input]; stdout, kwargs...)

Run `blastx` with passed kwargs.
Use `arg=true` to pass flags
(eg `lcase_masking=true` will pass `-lcase_masking`).


Optionally, provide an input that will be provided
as `stdin` (a file string, or `IO` type).

To print results to somewhere other than `stdout`,
use eg `stdout="results.txt"`.

```
julia> blastx(; h=true)
USAGE
  blastx [-h] [-help] [-import_search_strategy filename]
    [-export_search_strategy filename] [-task task_name] [-db database_name]
    [-dbsize num_letters] [-gilist filename] [-seqidlist filename]
    [-negative_gilist filename] [-negative_seqidlist filename]
    [-taxids taxids] [-negative_taxids taxids] [-taxidlist filename]
    [-negative_taxidlist filename] [-no_taxid_expansion] [-ipglist filename]
    [-negative_ipglist filename] [-entrez_query entrez_query]
    [-db_soft_mask filtering_algorithm] [-db_hard_mask filtering_algorithm]
    [-subject subject_input_file] [-subject_loc range] [-query input_file]
    [-out output_file] [-evalue evalue] [-word_size int_value]
    [-gapopen open_penalty] [-gapextend extend_penalty]
    [-qcov_hsp_perc float_value] [-max_hsps int_value]
    [-xdrop_ungap float_value] [-xdrop_gap float_value]
    [-xdrop_gap_final float_value] [-searchsp int_value]
    [-sum_stats bool_value] [-max_intron_length length] [-seg SEG_options]
    [-soft_masking soft_masking] [-matrix matrix_name]
    [-threshold float_value] [-culling_limit int_value]
    [-best_hit_overhang float_value] [-best_hit_score_edge float_value]
    [-subject_besthit] [-window_size int_value] [-ungapped] [-lcase_masking]
    [-query_loc range] [-strand strand] [-parse_deflines]
    [-query_gencode int_value] [-outfmt format] [-show_gis]
    [-num_descriptions int_value] [-num_alignments int_value]
    [-line_length line_length] [-html] [-sorthits sort_hits]
    [-sorthsps sort_hsps] [-max_target_seqs num_sequences]
    [-num_threads int_value] [-mt_mode int_value] [-remote]
    [-comp_based_stats compo] [-use_sw_tback] [-version]

DESCRIPTION
   Translated Query-Protein Subject BLAST 2.16.0+

Use '-help' to print detailed descriptions of command line arguments
```
"""
function blastx(stdin = nothing; stdout=stdout, kwargs...)
    cmd = ["blastx"]
    add_cli_kwargs!(cmd, kwargs)
    CondaPkg.withenv() do
        run(pipeline(Cmd(cmd); stdin, stdout))
    end
end


"""
    tblastn([input]; stdout, kwargs...)

Run `tblastn` with passed kwargs.
Use `arg=true` to pass flags
(eg `lcase_masking=true` will pass `-lcase_masking`).

Optionally, provide an input that will be provided
as `stdin` (a file string, or `IO` type).

To print results to somewhere other than `stdout`,
use eg `stdout="results.txt"`.


```
julia> tblastn(; h=true)
USAGE
  tblastn [-h] [-help] [-import_search_strategy filename]
    [-export_search_strategy filename] [-task task_name] [-db database_name]
    [-dbsize num_letters] [-gilist filename] [-seqidlist filename]
    [-negative_gilist filename] [-negative_seqidlist filename]
    [-taxids taxids] [-negative_taxids taxids] [-taxidlist filename]
    [-negative_taxidlist filename] [-no_taxid_expansion]
    [-entrez_query entrez_query] [-db_soft_mask filtering_algorithm]
    [-db_hard_mask filtering_algorithm] [-subject subject_input_file]
    [-subject_loc range] [-query input_file] [-out output_file]
    [-evalue evalue] [-word_size int_value] [-gapopen open_penalty]
    [-gapextend extend_penalty] [-qcov_hsp_perc float_value]
    [-max_hsps int_value] [-xdrop_ungap float_value] [-xdrop_gap float_value]
    [-xdrop_gap_final float_value] [-searchsp int_value]
    [-sum_stats bool_value] [-db_gencode int_value] [-ungapped]
    [-max_intron_length length] [-seg SEG_options]
    [-soft_masking soft_masking] [-matrix matrix_name]
    [-threshold float_value] [-culling_limit int_value]
    [-best_hit_overhang float_value] [-best_hit_score_edge float_value]
    [-subject_besthit] [-window_size int_value] [-lcase_masking]
    [-query_loc range] [-parse_deflines] [-outfmt format] [-show_gis]
    [-num_descriptions int_value] [-num_alignments int_value]
    [-line_length line_length] [-html] [-sorthits sort_hits]
    [-sorthsps sort_hsps] [-max_target_seqs num_sequences]
    [-num_threads int_value] [-mt_mode int_value] [-remote]
    [-comp_based_stats compo] [-use_sw_tback] [-in_pssm psi_chkpt_file]
    [-version]

DESCRIPTION
   Protein Query-Translated Subject BLAST 2.16.0+

Use '-help' to print detailed descriptions of command line arguments
```
"""
function tblastn(stdin = nothing; stdout=stdout, kwargs...)
    cmd = ["tblastn"]
    add_cli_kwargs!(cmd, kwargs)
    CondaPkg.withenv() do
        run(pipeline(Cmd(cmd); stdout, stdin))
    end
end

"""
    tblastx([input]; stdout, kwargs...)

Run `tblastx` with passed kwargs.
Use `arg=true` to pass flags
(eg `lcase_masking=true` will pass `-lcase_masking`).

Optionally, provide an input that will be provided
as `stdin` (a file string, or `IO` type).

To print results to somewhere other than `stdout`,
use eg `stdout="results.txt"`.

```julia
julia> tblastx(; h=true)
USAGE
  tblastx [-h] [-help] [-import_search_strategy filename]
    [-export_search_strategy filename] [-db database_name]
    [-dbsize num_letters] [-gilist filename] [-seqidlist filename]
    [-negative_gilist filename] [-negative_seqidlist filename]
    [-taxids taxids] [-negative_taxids taxids] [-taxidlist filename]
    [-negative_taxidlist filename] [-no_taxid_expansion]
    [-entrez_query entrez_query] [-db_soft_mask filtering_algorithm]
    [-db_hard_mask filtering_algorithm] [-subject subject_input_file]
    [-subject_loc range] [-query input_file] [-out output_file]
    [-evalue evalue] [-word_size int_value] [-qcov_hsp_perc float_value]
    [-max_hsps int_value] [-xdrop_ungap float_value] [-searchsp int_value]
    [-sum_stats bool_value] [-max_intron_length length] [-seg SEG_options]
    [-soft_masking soft_masking] [-matrix matrix_name]
    [-threshold float_value] [-culling_limit int_value]
    [-best_hit_overhang float_value] [-best_hit_score_edge float_value]
    [-subject_besthit] [-window_size int_value] [-lcase_masking]
    [-query_loc range] [-strand strand] [-parse_deflines]
    [-query_gencode int_value] [-db_gencode int_value] [-outfmt format]
    [-show_gis] [-num_descriptions int_value] [-num_alignments int_value]
    [-line_length line_length] [-html] [-sorthits sort_hits]
    [-sorthsps sort_hsps] [-max_target_seqs num_sequences]
    [-num_threads int_value] [-remote] [-version]

DESCRIPTION
   Translated Query-Translated Subject BLAST 2.16.0+

Use '-help' to print detailed descriptions of command line arguments
```
"""
function tblastx(stdin = nothing; stdout=stdout, kwargs...)
    cmd = ["tblastx"]
    add_cli_kwargs!(cmd, kwargs)
    CondaPkg.withenv() do
        run(pipeline(Cmd(cmd); stdout, stdin))
    end
end


"""
    makeblastdb(; kwargs...)

Run `makeblastdb` with passed kwargs.
Use `arg=true` to pass flags
(eg `parse_seqids=true` will pass `-parse_seqids`).

```
julia> makeblastdb(; h=true)
USAGE
  makeblastdb [-h] [-help] [-in input_file] [-input_type type]
    -dbtype molecule_type [-title database_title] [-parse_seqids]
    [-hash_index] [-mask_data mask_data_files] [-mask_id mask_algo_ids]
    [-mask_desc mask_algo_descriptions] [-gi_mask]
    [-gi_mask_name gi_based_mask_names] [-out database_name]
    [-blastdb_version version] [-max_file_sz number_of_bytes]
    [-metadata_output_prefix ] [-logfile File_Name] [-taxid TaxID]
    [-taxid_map TaxIDMapFile] [-oid_masks oid_masks] [-version]

DESCRIPTION
   Application to create BLAST databases, version 2.16.0+

Use '-help' to print detailed descriptions of command line arguments
```
"""
function makeblastdb(; kwargs...)
    cmd = ["makeblastdb"]
    add_cli_kwargs!(cmd, kwargs)
    CondaPkg.withenv() do
        run(Cmd(cmd))
    end
end

end
