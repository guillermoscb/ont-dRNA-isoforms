rule summary_dorado:
    input:
        "{output_path}/results/basecall_dorado/{sampleid}/dorado.bam",
    output:
        "{output_path}/results/summary_dorado/{sampleid}/dorado.txt",
    log:
        "{output_path}/logs/summary_dorado/{sampleid}/dorado.log",
    benchmark:
        "{output_path}/logs/summary_dorado/{sampleid}/dorado.bmk"
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
