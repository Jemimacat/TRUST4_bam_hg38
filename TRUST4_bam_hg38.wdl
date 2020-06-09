version 1.0

task TRUST4bamhg38 {
    input {
      File bam
      String samplename
      Int thread
      Int stage
      Int memory
    }

    command {
        /home/TRUST4/run-trust4 -b ${bam} \
          -f /home/TRUST4/hg38_bcrtcr.fa --ref /home/TRUST4/human_IMGT+C.fa \
          -o ${samplename} \
          -t ${thread} \
          --stage ${stage}
    }

    output {
        File CDR3="${samplename}_cdr3.out"
        File TRUST4final="${samplename}_final.out"
        File TRUST4report="${samplename}_report.tsv"
    }

    runtime {
        docker: "jemimalwh/trust4:0.2.0"
        memory: "${memory} GB"
    }

    meta {
        author: "Wenhui Li"
    }
}

workflow TRUST4workflow {
    input {
        File bam
        String samplename
        Int thread
        Int stage
        Int memory
    }

    call TRUST4bamhg38 { input: bam=bam, samplename=samplename, thread=thread, stage=stage, memory=memory }

    output {
        File out_cdr3 = TRUST4bamhg38.CDR3
        File turst4final = TRUST4bamhg38.TRUST4final
        File trust4report = TRUST4bamhg38.TRUST4report
    }
}