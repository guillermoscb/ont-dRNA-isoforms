rule qs_filter:
    input:
        "results/basecall_dorado/{sampleid}/{basecaller}.bam",
    output:
        "results/qsfilter/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
    log:
        "logs/qsfilter/{sampleid}/{basecaller}-{cmp}-{qscore}.log",
    benchmark:
        "logs/qsfilter/{sampleid}/{basecaller}-{cmp}-{qscore}.bmk"
    params:
        cmp=getcmp,
        qscore=lambda wc: wc.qscore.lstrip("0"),
    threads: get_resource("qsfilter", "threads")
    resources:
        mem_mb=get_resource("qsfilter", "mem_mb"),
        runtime=get_resource("qsfilter", "runtime"),
        slurm_partition=get_resource("qsfilter", "partition"),
    conda:
        "../envs/samtools.yaml"
    shell:
        """
        samtools view -e '[qs]{params.cmp}{params.qscore}' {input} > {output} 2> {log}
    """
