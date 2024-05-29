rule isoform_bambu:
    input:
        mapped_reads="results/minimap2/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
        reference=config["paths"]["references"]["ref1"],
        annotations=config["paths"]["references"]["ref2"],
    output:
        SummExperiment_rds="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}.rds",
        SummExperiment_files="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}",
        SummExperiment_plots="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/plots",
        novel_transcripts="results/isoform_bambu/{sampleid}/summarized_experiment-novel_transcripts_filtered-{basecaller}-{cmp}-{qscore}",

    log:
        "logs/isoform_bambu/{sampleid}/{basecaller}-{cmp}-{qscore}.log",
    benchmark:
        "logs/isoform_bambu/{sampleid}/{basecaller}-{cmp}-{qscore}.bmk"
    threads: get_resource("isoform_bambu", "threads")
    resources:
        mem_mb=get_resource("isoform_bambu", "mem_mb"),
        runtime=get_resource("isoform_bambu", "runtime"),
        slurm_partition=get_resource("isoform_bambu", "partition"),
    conda:
        "../envs/bambu.yaml"
    script:
        '../scripts/test_isoform_calling_bambu.R'