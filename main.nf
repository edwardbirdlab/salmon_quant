#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/* Temp while testing */


params.in_folder = ""
params.ref_path = ""
params.project_name = ""

params.fastp_q = '25'

project_name = params.project_name

file_glob = "*_[1,2].fq.gz"


params.thread_max  = '16'

fastqs = Channel.fromFilePairs("${params.in_folder}/${file_glob}")
ref = Channel.fromPath("${params.ref_path}")

include { fastp as fastp } from './modules/fastp.nf'
include { salmon_index as salmon_index } from './modules/salmon_index.nf'
include { salmon_quant as salmon_quant } from './modules/salmon_quant.nf'
include { salmon_merge_t as salmon_merge_t } from './modules/salmon_merge_trans.nf'



workflow {
    take fastqs
    take ref
    fastp(fastqs)
    salmon_index(ref)
    combo_ch = fastp.out.trimmed_fastq.combine(salmon_index.out.index)
    salmon_quant(combo_ch)
    salmon_merge_t(salmon_quant.out.salmon_dir.collect())
}
