rule seq_depth:
    input:
        bam="{output_path}/results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
        bai="{output_path}/results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.bam.bai",
    output:
        "{output_path}/results/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.mosdepth.global.dist.txt",
        "{output_path}/results/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.per-base.bed.gz",
        summary="{output_path}/results/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.mosdepth.summary.txt",
    log:
        "{output_path}/logs/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.log",
    benchmark:
        "{output_path}/logs/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.bmk"
    threads: get_resource("mosdepth", "threads"),
    resources:
        mem_mb=get_resource("mosdepth", "mem_mb"),
        runtime=get_resource("mosdepth", "runtime"),
        slurm_partition=get_resource("mosdepth", "partition"),
    wrapper:
        "v3.1.0/bio/mosdepth"
