import os


rule isoform_bambu:
    input:
        mapped_reads=expand("results/minimap2/{sampleid}/{basecaller}-{cmp_qscore}.bam",
                           sampleid=config["samples"],
                           basecaller=config["basecallers"],
                           cmp_qscore=config["filters"]),
        reference=config["paths"]["references"]["genome"],
        annotations=config["paths"]["references"]["annotation"],
    output:
        counts_gene="results/isoform_bambu/summarized_experiment/counts_gene.txt",
        counts_transcript="results/isoform_bambu/summarized_experiment/counts_transcript.txt",
        CPM_transcript="results/isoform_bambu/summarized_experiment/CPM_transcript.txt",
        extended_annotations="results/isoform_bambu/summarized_experiment/extended_annotations.gtf",
        fullLengthCounts_transcript="results/isoform_bambu/summarized_experiment/fullLengthCounts_transcript.txt",
        uniqueCounts_transcript="results/isoform_bambu/summarized_experiment/uniqueCounts_transcript.txt",
        ndr_table="results/isoform_bambu/summarized_experiment/transcript_NDR.txt",
    params:
        # Novel Discovery Rate
        NDR=config["bambu"]["NDR"],
        SummExperiment_output="results/isoform_bambu/summarized_experiment/",
    log:
        "logs/isoform_bambu/summarized_experiment.log",
    benchmark:
        "logs/isoform_bambu/summarized_experiment.bmk"
    threads: get_resource("isoform_bambu", "threads")
    resources:
        mem_mb=get_resource("isoform_bambu", "mem_mb"),
        runtime=get_resource("isoform_bambu", "runtime"),
        slurm_partition=get_resource("isoform_bambu", "partition"),
    conda:
        "../envs/bambu.yaml"
    script:
        '../scripts/isoform_calling_bambu.R'
