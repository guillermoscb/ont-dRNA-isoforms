rule pycoqc:
    input:
        "results/summary_dorado/{sampleid}/dorado.txt",
    output:
        "results/pycoqc/{sampleid}/{basecaller}.html",
    log:
        "logs/pycoqc/{sampleid}/{basecaller}.log",
    benchmark:
        "logs/pycoqc/{sampleid}/{basecaller}.bmk"
    threads: get_resource("pycoqc", "threads")
    conda:
        "../envs/pycoqc.yaml"
    resources:
        mem_mb=get_resource("pycoqc", "mem_mb"),
        runtime=get_resource("pycoqc", "runtime"),
        slurm_partition=get_resource("pycoqc", "partition"),
        slurm_extra=get_resource("pycoqc", "slurm_extra"),
    shell:
        """
       pycoQC -f {input} -o {output} 2>&1 > {log}
    """