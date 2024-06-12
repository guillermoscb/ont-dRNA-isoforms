rule pycoqc:
    input:
        "{output_path}/results/summary_dorado/{sampleid}/dorado.txt",
    output:
        "{output_path}/results/pycoqc/{sampleid}/{basecaller}.html",
    log:
        "{output_path}/logs/pycoqc/{sampleid}/{basecaller}.log",
    benchmark:
        "{output_path}/logs/pycoqc/{sampleid}/{basecaller}.bmk"
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
