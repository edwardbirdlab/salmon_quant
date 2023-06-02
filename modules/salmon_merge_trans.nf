process salmon_merge_t{
    label 'lowmem'
    container 'ebird013/salmon:1.10.1'
    publishDir "${params.project_name}/salmon_merge_t", mode: 'copy', overwrite: false

    input:
        val(folders)


    output:
        path("./merge.csv"), emit:quantmerge


    script:
    

    """
    salmon quantmerge -o merge.csv --quants ${folders}
    """
}