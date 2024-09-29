configfile: "config.yaml"
samples = config["SAMPLES"]

rule fastqc:
    input:
        expand("Data/{sample}.fastq", sample=samples)
    output:
        html=expand("Data/qc/fastqc/{sample}.html",sample=samples),
        zip=expand("Data/qc/fastqc/{sample}_fastqc.zip",sample=samples)
    # the suffix _fastqc.zip is necessary for multiqc to find the file.
    # If not using multiqc, you are free to choose an arbitrary filename
    params:
        extra = "--quiet"
    log:
        expand("logs/fastqc/{sample}.log", sample=samples)
    threads: 1
    resources:
        mem_mb = 1024
    wrapper:
        "v3.5.3/bio/fastqc"
