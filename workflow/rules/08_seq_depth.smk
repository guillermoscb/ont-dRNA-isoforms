rule seq_depth:
    input:
        bam="results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
        bai="results/primary/{sampleid}/{basecaller}-{cmp}-{qscore}.bam.bai",
    output:
        "results/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.mosdepth.global.dist.txt",
        "results/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.per-base.bed.gz",
        summary="results/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.mosdepth.summary.txt",
    log:
        "logs/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.log",
    benchmark:
        "logs/mosdepth/{sampleid}/{basecaller}-{cmp}-{qscore}.bmk"
    threads: get_resource("mosdepth", "threads"),
    resources:
        mem_mb=get_resource("mosdepth", "mem_mb"),
        runtime=get_resource("mosdepth", "runtime"),
        slurm_partition=get_resource("mosdepth", "partition"),
    wrapper:
        "v3.1.0/bio/mosdepth"
