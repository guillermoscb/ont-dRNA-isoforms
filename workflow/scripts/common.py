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
    for sid in config["samples"]:
        for bc in config["basecallers"]:
            for filt in config["filters"]:
                o.append(f"results/pycoqc/{sid}/{bc}.html")
                o.append(f"results/primary/{sid}/dorado-{filt}.cov")
                o.append(f"results/mosdepth/{sid}/dorado-{filt}.mosdepth.global.dist.txt")
#                o.append(f"results/isoform_bambu/{sid}/summarized_experiment-{bc}-{filt}/fullLengthCounts_transcript.txt")
    o.append(f"results/isoform_bambu/summarized_experiment/fullLengthCounts_transcript.txt")
    return o

