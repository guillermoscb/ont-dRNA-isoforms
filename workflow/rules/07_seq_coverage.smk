rule seq_coverage:
    input:
        "results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
    output:
        "results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.cov",
    log:
        "logs/coverage/{sampleid}/{basecaller}-{cmp}-{qscore}.log",
    benchmark:
        "logs/coverage/{sampleid}/{basecaller}-{cmp}-{qscore}.bmk"
    resources:
        mem_mb=get_resource("coverage", "mem_mb"),
        runtime=get_resource("coverage", "runtime"),
        slurm_partition=get_resource("coverage", "partition"),
    conda:
        "../envs/samtools.yaml"
    shell:
        """
        samtools coverage -A -o {output} {input} &> {log}
    """