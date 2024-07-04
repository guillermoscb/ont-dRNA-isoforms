rule isoform_bambu:
    input:
        mapped_reads="{output_path}/results/minimap2/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
        reference=config["paths"]["references"]["ref1"],
        annotations=config["paths"]["references"]["ref2"],
    output:
        counts_gene="{output_path}/results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/counts_gene.txt",
        counts_transcript="{output_path}/results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/counts_transcript.txt",
        CPM_transcript="{output_path}/results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/CPM_transcript.txt",
        extended_annotations="{output_path}/results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/extended_annotations.gtf",
        fullLengthCounts_transcript="{output_path}/results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/fullLengthCounts_transcript.txt",
        uniqueCounts_transcript="{output_path}/results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/uniqueCounts_transcript.txt",
    params:
        # Novel Discovery Rate
        NDR=1,
        SummExperiment_output="{output_path}/results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/",
    log:
        "{output_path}/logs/isoform_bambu/{sampleid}/{basecaller}-{cmp}-{qscore}.log",
    benchmark:
        "{output_path}/logs/isoform_bambu/{sampleid}/{basecaller}-{cmp}-{qscore}.bmk"
    threads: get_resource("isoform_bambu", "threads")
    resources:
        mem_mb=get_resource("isoform_bambu", "mem_mb"),
        runtime=get_resource("isoform_bambu", "runtime"),
        slurm_partition=get_resource("isoform_bambu", "partition"),
    conda:
        "../envs/bambu.yaml"
    script:
        '../scripts/isoform_calling_bambu.R'
