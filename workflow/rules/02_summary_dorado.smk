rule summary_dorado:
    input:
        "results/basecall_dorado/{sampleid}/dorado.bam",
    output:
        "results/summary_dorado/{sampleid}/dorado.txt",
    log:
        "logs/summary_dorado/{sampleid}/dorado.log",
    benchmark:
        "logs/summary_dorado/{sampleid}/dorado.bmk"
    params:
        bin=config["basecallers"]["dorado"]["bin"],
    threads: get_resource("summary_dorado", "threads")
    resources:
        mem_mb=get_resource("summary_dorado", "mem_mb"),
        runtime=get_resource("summary_dorado", "runtime"),
        slurm_partition=get_resource("summary_dorado", "partition"),
        slurm_extra=get_resource("summary_dorado", "slurm_extra"),
    shell:
        """
        {params.bin} summary {input} >> {output} 2> {log}
    """