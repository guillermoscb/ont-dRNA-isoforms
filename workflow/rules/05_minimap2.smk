rule minimap2:
    input:
        reads="results/qsfilter/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
        reference=config["paths"]["references"]["genome"],
    output:
        "results/minimap2/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
    params:
        preset = '-a -x splice -uf -k15'
    log:
        "logs/minimap2/{sampleid}/{basecaller}-{cmp}-{qscore}.log",
    benchmark:
        "logs/minimap2/{sampleid}/{basecaller}-{cmp}-{qscore}.bmk"
    threads: get_resource("minimap2", "threads")
    resources:
        mem_mb=get_resource("minimap2", "mem_mb"),
        runtime=get_resource("minimap2", "runtime"),
        slurm_partition=get_resource("minimap2", "partition"),
    conda:
        "../envs/minimap2.yaml"
    shell:
        """
        samtools fastq -T "*" {input.reads} | minimap2 {params.preset} -y -t {threads} {input.reference} - | samtools sort - -o {output} 2> {log}
        samtools index {output}
    """
