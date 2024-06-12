rule seq_coverage:
    input:
        "{output_path}/results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
    output:
        "{output_path}/results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.cov",
    log:
        "{output_path}/logs/coverage/{sampleid}/{basecaller}-{cmp}-{qscore}.log",
    benchmark:
        "{output_path}/logs/coverage/{sampleid}/{basecaller}-{cmp}-{qscore}.bmk"
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
