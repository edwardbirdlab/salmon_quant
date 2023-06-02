process salmon_index{
    label 'lowmem'
    container 'ebird013/salmon:1.10.1'
    publishDir "${params.project_name}/salmon_index", mode: 'copy', overwrite: false

    input:
        file(ref)


    output:
        path('salmon_ref_index'), emit:index


    script:
    

    """
    salmon index -t $ref -i salmon_ref_index
    """
}