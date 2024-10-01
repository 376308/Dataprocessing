configfile: "config.yaml"
samples = config["SAMPLES"]

rule trimmomatic_pe:
    input:
        r1=expand("Data/{sample}_1.fastq", sample=samples),
        r2=expand("Data/{sample}_2.fastq", sample=samples)
    output:
        r1=expand("trimmed/{sample}.1.fastq.gz", sample=samples),
        r2=expand("trimmed/{sample}.2.fastq.gz", sample=samples),
        r1_unpaired=expand("trimmed/{sample}.1.unpaired.fastq.gz", sample=samples),
        r2_unpaired=expand("trimmed/{sample}.2.unpaired.fastq.gz", sample=samples)
    log:
        expand("logs/trimmomatic/{sample}.log", sample=samples)
    params:
        trimmer="TRAILING:3",
        extra="",
        compression_level="-9"
    threads:
        32
    resources:
        mem_mb=1024
    shell:
        """
        trimmomatic PE -threads {threads} {input.r1} {input.r2} \
        {output.r1} {output.r1_unpaired} {output.r2} {output.r2_unpaired} \
        {params.trimmer} {params.extra}
        """