workflow TRUST4_workflow {
  File bam
  String samplename
  Int thread
  Int stage
  Int memory
  Int disk

  call TRUST4_bam_hg38
  {input:
    bam=bam,
    samplename=samplename,
    thread=thread,
    stage=stage,
    memory=memory,
    disk=disk
  }

}

task TRUST4_pe_hg38{
  File bam
  String samplename
  Int thread
  Int stage
  Int memory
  Int disk

  command {
    /home/TRUST4/run-trust4 -b ${bam} \
      -f /home/TRUST4/hg38_bcrtcr.fa --ref /home/TRUST4/human_IMGT+C.fa \
      -o ${samplename} \
      -t ${thread} \
      --stage ${stage}
  }

  runtime {
    docker:"jemimalwh/trust4:0.2.0"
    memory:"${memory} GB"
    disks: "local‐disk ${disk} SSD"
  }

  output {
    File CDR3="${samplename}_cdr3.out"
    File TRUST4final="${samplename}_final.out"
    File TRUST4report="${samplename}_report.tsv"
    File toassemble_fq1="${samplename}_toassemble_1.fq"
    File toassemble_fq2="${samplename}_toassemble_2.fq"
  }
}