process salmon_quant{
    label 'lowmem'
    container 'ebird013/salmon:1.10.1'
    publishDir "${params.project_name}/salmon_quant/", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fastq1), file(fastq2), file(index)


    output:
        path("./${sample_out_f}"), emit:salmon_dir
        tuple val(sample), path("./${sample}_quant.sf"), emit:salmon_quant


    script:
    
    sample_out_f = sample + '_quant_folder'

    """
    salmon quant -i $index -l A -1 ${fastq1} -2 ${fastq2} -p ${params.thread_max} --validateMappings -o ${sample_out_f} –numBootstraps 30
    cp ${sample_out_f}/quant.sf ${sample}_quant.sf
    """
}