rule primary_alignment:
    input:
        "results/minimap2/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
    output:
        bam="results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
        bai="results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.bam.bai",
    log:
        "logs/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.log",
    benchmark:
        "logs/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.bmk"
    threads: lambda wc: get_resource("primary", "threads")/2
    resources:
        mem_mb=get_resource("primary", "mem_mb"),
        runtime=get_resource("primary", "runtime"),
        slurm_partition=get_resource("primary", "partition"),
    conda:
        "../envs/samtools.yaml"
    shell:
        """
        samtools view -@ {threads} -F 2308 -b {input} | samtools sort -@ {threads} -o {output.bam} 2> {log}
        samtools index {output.bam}
    """
