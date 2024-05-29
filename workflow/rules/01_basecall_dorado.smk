rule basecall_dorado:
    input:
        lambda wc: config["samples"][wc.sampleid]["pod5"],
    output:
        "results/basecall_dorado/{sampleid}/dorado.bam",
    log:
        "logs/basecall_dorado/{sampleid}/dorado.log",
    benchmark:
        "logs/basecall_dorado/{sampleid}/dorado.bmk"
    params:
        bin=config["basecallers"]["dorado"]["bin"],
        model=get_resource("basecall_dorado", "params_model"),
        extra=get_resource("basecall_dorado", "params_extra"),
    threads: 
        get_resource("basecall_dorado", "threads")
    resources:
        mem_mb=get_resource("basecall_dorado", "mem_mb"),
        runtime=get_resource("basecall_dorado", "runtime"),
        slurm_partition=get_resource("basecall_dorado", "partition"),
        slurm_extra=get_resource("basecall_dorado", "slurm_extra"),
    shell:
        """
        {params.bin} basecaller {params.model} {input} {params.extra} > {output} 2> {log}
    """