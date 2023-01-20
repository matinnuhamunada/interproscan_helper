rule interproscan:
    input:
        fasta = lambda wildcards: fasta_dict[wildcards.sample]
    output:
        tsv = "/home/matinnu/datadrive/glyco_halo_mining/output/interproscan_per_region/{sample}.faa.tsv",
        json = "/home/matinnu/datadrive/glyco_halo_mining/output/interproscan_per_region/{sample}.faa.json",
    log:
        "workflow/report/logs/{sample}.log",
    wildcard_constraints:
        sample = "|".join(SAMPLE),
    params:
        interpro_sh = config['interproscan']
    threads: 4
    shell:
        """
        {params.interpro_sh} -appl TIGRFAM,PFAM -cpu {threads} -d /home/matinnu/datadrive/glyco_halo_mining/output/interproscan_per_region/ -f TSV,JSON -i {input.fasta} --verbose &>> {log}
        """
