rule isoform_bambu:
    input:
        mapped_reads="results/minimap2/{sampleid}/{basecaller}-{cmp}-{qscore}.bam",
        reference=config["paths"]["references"]["ref1"],
        annotations=config["paths"]["references"]["ref2"],
    output:
        counts_gene="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/counts_gene.txt",
        counts_transcript="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/counts_transcript.txt",
        CPM_transcript="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/CPM_transcript.txt",
        extended_annotations="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/extended_annotations.gtf",
        fullLengthCounts_transcript="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/fullLengthCounts_transcript.txt",
        uniqueCounts_transcript="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/uniqueCounts_transcript.txt",
        se_novel_transcripts="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/novel_transcripts_filt.gtf",
        se_novel_flen="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/full-length_transcripts_filt.gtf",
    params:
        # Novel Discovery Rate
        NDR=0.1,
        SummExperiment_output="results/isoform_bambu/{sampleid}/summarized_experiment-{basecaller}-{cmp}-{qscore}/",
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
        '../scripts/isoform_calling_bambu.R'
