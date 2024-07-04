def get_resource(rule, resource):
    try:
        return config["resources"][rule][resource]
    except KeyError:
        return config["resources"]["default"][resource]


def getcmp(wc):
    if wc.cmp == "ge":
        return ">="
    elif wc.cmp == "gt":
        return ">"
    elif wc.cmp == "le":
        return "<="
    elif wc.cmp == "lt":
        return "<"
    else:
        raise ValueError(f"Operator {wc.cmp} not recognised")


def input_main(wc):
    o = []
    prefix_path = config["output_path"]
    for sid in config["samples"]:
        for bc in config["basecallers"]:
            for filt in config["filters"]:
                o.append(f"{prefix_path}/results/pycoqc/{sid}/{bc}.html")
                o.append(f"{prefix_path}/results/primary/{sid}/dorado-{filt}.cov")
                o.append(f"{prefix_path}/results/mosdepth/{sid}/dorado-{filt}.mosdepth.global.dist.txt")
                o.append(f"{prefix_path}/results/isoform_bambu/{sid}/summarized_experiment-{bc}-{filt}/fullLengthCounts_transcript.txt")
    return o

