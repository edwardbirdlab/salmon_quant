#!/usr/bin/env nextflow

nextflow.enable.dsl=2

/* Temp while testing */


input_folder_mlh = "/homes/edwardbird/data/MLH"

file_glob = "*_[1,2].fq.gz"

params.project_name = 'W8_VSV_Out'
params.thread_max  = '19'

fastqs = Channel.fromFilePairs("${input_folder}/${file_glob}")

include { fastqc as raw_fqc } from './modules/raw_qc/fastqc.nf'



workflow {
    take fastqs
    raw_fqc(fastqs)
}
