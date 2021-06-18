Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40483AC287
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 06:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhFREuo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 00:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhFREuj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 00:50:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAECC0617A8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:29 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id b8-20020a056a000a88b02902e97a71383dso5040347pfl.13
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hvs1rhJuXmvyIZSPMZ49ftNP4+MO7wC4nDYBoVle+mw=;
        b=cml+r3d0hHWvYKYD+yo9B9Cc/s756D1lcThJuHT50BjEWNf1C+sn9M4Zrs2vkNdIfJ
         SMrzj41y/M8vuOmrWSE88iUQoPO4iZTL1Gny5rwf8/a38o4neOxRUQHYQMjyjK7N2+ki
         YceMZPEMzzEcOH+CXIJO265wr2g5NqNJ8VAF76kZ9pETqhBYuInZz5ihrKGgbeoctfkd
         o9LscF0DfCVBnkFeXLm6gDE9ZJ77xXPhwPcsPjnv0h4b2oTwO63T5Zh3Qlv9G4ys+RFU
         N/O8Sof/p7+qV4HgXgDKdU6SpBpESZZN8uPQRpuqTlyIbmvaBOD0UDcRfw1lLbPvvtFX
         gIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hvs1rhJuXmvyIZSPMZ49ftNP4+MO7wC4nDYBoVle+mw=;
        b=IXkJDRoQcBeJbTeP9o5U2DOO7QKBnrQtIP3SBTO7sstpnugR27p5ZMsB16hu/upNci
         jLdz6pLfbw8RSpdgVeilasPRgC5bH8u0usDFw4FX6/a1yMXPDz+jSzXGDIjh5f/RsW/1
         JdAmR8JRvSOkCemsChYZWutQD8DLPn1HzUfoCHEfZq08OPpg3rzc1qkfV91vWZJ4ot40
         9Hl+MSd7TLih0+7+IEl/M8lXCbitG4a3hr9AXd86bHI2waUb7LMn+R3WzzVu31Zbp87K
         38ZvC0assHDWeWHH9K3s2xg1KU8+A4VvaO1wp6Ptg0qMk/NpW5wlI/fff1Pt1FCt+Kf5
         UMvg==
X-Gm-Message-State: AOAM5328RX2KazJ+ccRD9tMEydjfhG/ICpEFifh+sn9f6NF7qppH+1p6
        sqvnEDz0G1dKGG0jk4dMxyvTE2r7j0DXXpAhNA==
X-Google-Smtp-Source: ABdhPJx5hEZzATeZ7LAjdGL72GqR7W4Yp6jOQgBT3tO9NVt5uhLiVM+ZrS7YjsY+GImNCN4E6iZJsRbaF/TtpJQu5w==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:90b:305:: with SMTP id
 ay5mr19860993pjb.0.1623991709416; Thu, 17 Jun 2021 21:48:29 -0700 (PDT)
Date:   Fri, 18 Jun 2021 04:48:16 +0000
In-Reply-To: <20210618044819.3690166-1-jingzhangos@google.com>
Message-Id: <20210618044819.3690166-5-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210618044819.3690166-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v11 4/7] KVM: stats: Support binary stats retrieval for a VCPU
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a VCPU ioctl to get a statistics file descriptor by which a read
functionality is provided for userspace to read out VCPU stats header,
descriptors and data.
Define VCPU statistics descriptors and header for all architectures.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com> #arm64
Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/kvm/guest.c    |  20 +++++++
 arch/mips/kvm/mips.c      |  43 +++++++++++++++
 arch/powerpc/kvm/book3s.c |  44 ++++++++++++++++
 arch/powerpc/kvm/booke.c  |  37 +++++++++++++
 arch/s390/kvm/kvm-s390.c  | 107 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c        |  40 ++++++++++++++
 include/linux/kvm_host.h  |  13 ++++-
 virt/kvm/kvm_main.c       |  57 ++++++++++++++++++--
 8 files changed, 356 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index f456d1defe2b..59cb1cfe5b1e 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -42,6 +42,26 @@ struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
+struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+	KVM_GENERIC_VCPU_STATS(),
+	STATS_DESC_COUNTER(VCPU, hvc_exit_stat),
+	STATS_DESC_COUNTER(VCPU, wfe_exit_stat),
+	STATS_DESC_COUNTER(VCPU, wfi_exit_stat),
+	STATS_DESC_COUNTER(VCPU, mmio_exit_user),
+	STATS_DESC_COUNTER(VCPU, mmio_exit_kernel),
+	STATS_DESC_COUNTER(VCPU, exits)
+};
+static_assert(ARRAY_SIZE(kvm_vcpu_stats_desc) ==
+		sizeof(struct kvm_vcpu_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vcpu_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vcpu_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
 	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a1c6b9c5a4ae..c748fa0d1411 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -52,6 +52,49 @@ struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
+struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+	KVM_GENERIC_VCPU_STATS(),
+	STATS_DESC_COUNTER(VCPU, wait_exits),
+	STATS_DESC_COUNTER(VCPU, cache_exits),
+	STATS_DESC_COUNTER(VCPU, signal_exits),
+	STATS_DESC_COUNTER(VCPU, int_exits),
+	STATS_DESC_COUNTER(VCPU, cop_unusable_exits),
+	STATS_DESC_COUNTER(VCPU, tlbmod_exits),
+	STATS_DESC_COUNTER(VCPU, tlbmiss_ld_exits),
+	STATS_DESC_COUNTER(VCPU, tlbmiss_st_exits),
+	STATS_DESC_COUNTER(VCPU, addrerr_st_exits),
+	STATS_DESC_COUNTER(VCPU, addrerr_ld_exits),
+	STATS_DESC_COUNTER(VCPU, syscall_exits),
+	STATS_DESC_COUNTER(VCPU, resvd_inst_exits),
+	STATS_DESC_COUNTER(VCPU, break_inst_exits),
+	STATS_DESC_COUNTER(VCPU, trap_inst_exits),
+	STATS_DESC_COUNTER(VCPU, msa_fpe_exits),
+	STATS_DESC_COUNTER(VCPU, fpe_exits),
+	STATS_DESC_COUNTER(VCPU, msa_disabled_exits),
+	STATS_DESC_COUNTER(VCPU, flush_dcache_exits),
+	STATS_DESC_COUNTER(VCPU, vz_gpsi_exits),
+	STATS_DESC_COUNTER(VCPU, vz_gsfc_exits),
+	STATS_DESC_COUNTER(VCPU, vz_hc_exits),
+	STATS_DESC_COUNTER(VCPU, vz_grr_exits),
+	STATS_DESC_COUNTER(VCPU, vz_gva_exits),
+	STATS_DESC_COUNTER(VCPU, vz_ghfc_exits),
+	STATS_DESC_COUNTER(VCPU, vz_gpa_exits),
+	STATS_DESC_COUNTER(VCPU, vz_resvd_exits),
+#ifdef CONFIG_CPU_LOONGSON64
+	STATS_DESC_COUNTER(VCPU, vz_cpucfg_exits),
+#endif
+};
+static_assert(ARRAY_SIZE(kvm_vcpu_stats_desc) ==
+		sizeof(struct kvm_vcpu_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vcpu_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vcpu_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("wait", wait_exits),
 	VCPU_STAT("cache", cache_exits),
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index d3dfdddb4f7d..9aa05ac747ca 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -54,6 +54,50 @@ struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
+struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+	KVM_GENERIC_VCPU_STATS(),
+	STATS_DESC_COUNTER(VCPU, sum_exits),
+	STATS_DESC_COUNTER(VCPU, mmio_exits),
+	STATS_DESC_COUNTER(VCPU, signal_exits),
+	STATS_DESC_COUNTER(VCPU, light_exits),
+	STATS_DESC_COUNTER(VCPU, itlb_real_miss_exits),
+	STATS_DESC_COUNTER(VCPU, itlb_virt_miss_exits),
+	STATS_DESC_COUNTER(VCPU, dtlb_real_miss_exits),
+	STATS_DESC_COUNTER(VCPU, dtlb_virt_miss_exits),
+	STATS_DESC_COUNTER(VCPU, syscall_exits),
+	STATS_DESC_COUNTER(VCPU, isi_exits),
+	STATS_DESC_COUNTER(VCPU, dsi_exits),
+	STATS_DESC_COUNTER(VCPU, emulated_inst_exits),
+	STATS_DESC_COUNTER(VCPU, dec_exits),
+	STATS_DESC_COUNTER(VCPU, ext_intr_exits),
+	STATS_DESC_TIME_NSEC(VCPU, halt_wait_ns),
+	STATS_DESC_COUNTER(VCPU, halt_successful_wait),
+	STATS_DESC_COUNTER(VCPU, dbell_exits),
+	STATS_DESC_COUNTER(VCPU, gdbell_exits),
+	STATS_DESC_COUNTER(VCPU, ld),
+	STATS_DESC_COUNTER(VCPU, st),
+	STATS_DESC_COUNTER(VCPU, pf_storage),
+	STATS_DESC_COUNTER(VCPU, pf_instruc),
+	STATS_DESC_COUNTER(VCPU, sp_storage),
+	STATS_DESC_COUNTER(VCPU, sp_instruc),
+	STATS_DESC_COUNTER(VCPU, queue_intr),
+	STATS_DESC_COUNTER(VCPU, ld_slow),
+	STATS_DESC_COUNTER(VCPU, st_slow),
+	STATS_DESC_COUNTER(VCPU, pthru_all),
+	STATS_DESC_COUNTER(VCPU, pthru_host),
+	STATS_DESC_COUNTER(VCPU, pthru_bad_aff)
+};
+static_assert(ARRAY_SIZE(kvm_vcpu_stats_desc) ==
+		sizeof(struct kvm_vcpu_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vcpu_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vcpu_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("exits", sum_exits),
 	VCPU_STAT("mmio", mmio_exits),
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 4e4a58b19487..ef348773e89f 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -52,6 +52,43 @@ struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
+struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+	KVM_GENERIC_VCPU_STATS(),
+	STATS_DESC_COUNTER(VCPU, sum_exits),
+	STATS_DESC_COUNTER(VCPU, mmio_exits),
+	STATS_DESC_COUNTER(VCPU, signal_exits),
+	STATS_DESC_COUNTER(VCPU, light_exits),
+	STATS_DESC_COUNTER(VCPU, itlb_real_miss_exits),
+	STATS_DESC_COUNTER(VCPU, itlb_virt_miss_exits),
+	STATS_DESC_COUNTER(VCPU, dtlb_real_miss_exits),
+	STATS_DESC_COUNTER(VCPU, dtlb_virt_miss_exits),
+	STATS_DESC_COUNTER(VCPU, syscall_exits),
+	STATS_DESC_COUNTER(VCPU, isi_exits),
+	STATS_DESC_COUNTER(VCPU, dsi_exits),
+	STATS_DESC_COUNTER(VCPU, emulated_inst_exits),
+	STATS_DESC_COUNTER(VCPU, dec_exits),
+	STATS_DESC_COUNTER(VCPU, ext_intr_exits),
+	STATS_DESC_TIME_NSEC(VCPU, halt_wait_ns),
+	STATS_DESC_COUNTER(VCPU, halt_successful_wait),
+	STATS_DESC_COUNTER(VCPU, dbell_exits),
+	STATS_DESC_COUNTER(VCPU, gdbell_exits),
+	STATS_DESC_COUNTER(VCPU, ld),
+	STATS_DESC_COUNTER(VCPU, st),
+	STATS_DESC_COUNTER(VCPU, pthru_all),
+	STATS_DESC_COUNTER(VCPU, pthru_host),
+	STATS_DESC_COUNTER(VCPU, pthru_bad_aff)
+};
+static_assert(ARRAY_SIZE(kvm_vcpu_stats_desc) ==
+		sizeof(struct kvm_vcpu_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vcpu_stats_header = {
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+		.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+		.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+			       sizeof(kvm_vcpu_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("mmio", mmio_exits),
 	VCPU_STAT("sig", signal_exits),
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 89c0a2722183..8a9c2b0940cd 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -77,6 +77,113 @@ struct kvm_stats_header kvm_vm_stats_header = {
 		       sizeof(kvm_vm_stats_desc),
 };
 
+struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+	KVM_GENERIC_VCPU_STATS(),
+	STATS_DESC_COUNTER(VCPU, exit_userspace),
+	STATS_DESC_COUNTER(VCPU, exit_null),
+	STATS_DESC_COUNTER(VCPU, exit_external_request),
+	STATS_DESC_COUNTER(VCPU, exit_io_request),
+	STATS_DESC_COUNTER(VCPU, exit_external_interrupt),
+	STATS_DESC_COUNTER(VCPU, exit_stop_request),
+	STATS_DESC_COUNTER(VCPU, exit_validity),
+	STATS_DESC_COUNTER(VCPU, exit_instruction),
+	STATS_DESC_COUNTER(VCPU, exit_pei),
+	STATS_DESC_COUNTER(VCPU, halt_no_poll_steal),
+	STATS_DESC_COUNTER(VCPU, instruction_lctl),
+	STATS_DESC_COUNTER(VCPU, instruction_lctlg),
+	STATS_DESC_COUNTER(VCPU, instruction_stctl),
+	STATS_DESC_COUNTER(VCPU, instruction_stctg),
+	STATS_DESC_COUNTER(VCPU, exit_program_interruption),
+	STATS_DESC_COUNTER(VCPU, exit_instr_and_program),
+	STATS_DESC_COUNTER(VCPU, exit_operation_exception),
+	STATS_DESC_COUNTER(VCPU, deliver_ckc),
+	STATS_DESC_COUNTER(VCPU, deliver_cputm),
+	STATS_DESC_COUNTER(VCPU, deliver_external_call),
+	STATS_DESC_COUNTER(VCPU, deliver_emergency_signal),
+	STATS_DESC_COUNTER(VCPU, deliver_service_signal),
+	STATS_DESC_COUNTER(VCPU, deliver_virtio),
+	STATS_DESC_COUNTER(VCPU, deliver_stop_signal),
+	STATS_DESC_COUNTER(VCPU, deliver_prefix_signal),
+	STATS_DESC_COUNTER(VCPU, deliver_restart_signal),
+	STATS_DESC_COUNTER(VCPU, deliver_program),
+	STATS_DESC_COUNTER(VCPU, deliver_io),
+	STATS_DESC_COUNTER(VCPU, deliver_machine_check),
+	STATS_DESC_COUNTER(VCPU, exit_wait_state),
+	STATS_DESC_COUNTER(VCPU, inject_ckc),
+	STATS_DESC_COUNTER(VCPU, inject_cputm),
+	STATS_DESC_COUNTER(VCPU, inject_external_call),
+	STATS_DESC_COUNTER(VCPU, inject_emergency_signal),
+	STATS_DESC_COUNTER(VCPU, inject_mchk),
+	STATS_DESC_COUNTER(VCPU, inject_pfault_init),
+	STATS_DESC_COUNTER(VCPU, inject_program),
+	STATS_DESC_COUNTER(VCPU, inject_restart),
+	STATS_DESC_COUNTER(VCPU, inject_set_prefix),
+	STATS_DESC_COUNTER(VCPU, inject_stop_signal),
+	STATS_DESC_COUNTER(VCPU, instruction_epsw),
+	STATS_DESC_COUNTER(VCPU, instruction_gs),
+	STATS_DESC_COUNTER(VCPU, instruction_io_other),
+	STATS_DESC_COUNTER(VCPU, instruction_lpsw),
+	STATS_DESC_COUNTER(VCPU, instruction_lpswe),
+	STATS_DESC_COUNTER(VCPU, instruction_pfmf),
+	STATS_DESC_COUNTER(VCPU, instruction_ptff),
+	STATS_DESC_COUNTER(VCPU, instruction_sck),
+	STATS_DESC_COUNTER(VCPU, instruction_sckpf),
+	STATS_DESC_COUNTER(VCPU, instruction_stidp),
+	STATS_DESC_COUNTER(VCPU, instruction_spx),
+	STATS_DESC_COUNTER(VCPU, instruction_stpx),
+	STATS_DESC_COUNTER(VCPU, instruction_stap),
+	STATS_DESC_COUNTER(VCPU, instruction_iske),
+	STATS_DESC_COUNTER(VCPU, instruction_ri),
+	STATS_DESC_COUNTER(VCPU, instruction_rrbe),
+	STATS_DESC_COUNTER(VCPU, instruction_sske),
+	STATS_DESC_COUNTER(VCPU, instruction_ipte_interlock),
+	STATS_DESC_COUNTER(VCPU, instruction_stsi),
+	STATS_DESC_COUNTER(VCPU, instruction_stfl),
+	STATS_DESC_COUNTER(VCPU, instruction_tb),
+	STATS_DESC_COUNTER(VCPU, instruction_tpi),
+	STATS_DESC_COUNTER(VCPU, instruction_tprot),
+	STATS_DESC_COUNTER(VCPU, instruction_tsch),
+	STATS_DESC_COUNTER(VCPU, instruction_sie),
+	STATS_DESC_COUNTER(VCPU, instruction_essa),
+	STATS_DESC_COUNTER(VCPU, instruction_sthyi),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_sense),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_sense_running),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_external_call),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_emergency),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_cond_emergency),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_start),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_stop),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_stop_store_status),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_store_status),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_store_adtl_status),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_arch),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_prefix),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_restart),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_init_cpu_reset),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_cpu_reset),
+	STATS_DESC_COUNTER(VCPU, instruction_sigp_unknown),
+	STATS_DESC_COUNTER(VCPU, diagnose_10),
+	STATS_DESC_COUNTER(VCPU, diagnose_44),
+	STATS_DESC_COUNTER(VCPU, diagnose_9c),
+	STATS_DESC_COUNTER(VCPU, diagnose_9c_ignored),
+	STATS_DESC_COUNTER(VCPU, diagnose_9c_forward),
+	STATS_DESC_COUNTER(VCPU, diagnose_258),
+	STATS_DESC_COUNTER(VCPU, diagnose_308),
+	STATS_DESC_COUNTER(VCPU, diagnose_500),
+	STATS_DESC_COUNTER(VCPU, diagnose_other),
+	STATS_DESC_COUNTER(VCPU, pfault_sync)
+};
+static_assert(ARRAY_SIZE(kvm_vcpu_stats_desc) ==
+		sizeof(struct kvm_vcpu_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vcpu_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vcpu_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("userspace_handled", exit_userspace),
 	VCPU_STAT("exit_null", exit_null),
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a461d9d79865..086a1ebcbfbe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -247,6 +247,46 @@ struct kvm_stats_header kvm_vm_stats_header = {
 			       sizeof(kvm_vm_stats_desc),
 };
 
+struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+	KVM_GENERIC_VCPU_STATS(),
+	STATS_DESC_COUNTER(VCPU, pf_fixed),
+	STATS_DESC_COUNTER(VCPU, pf_guest),
+	STATS_DESC_COUNTER(VCPU, tlb_flush),
+	STATS_DESC_COUNTER(VCPU, invlpg),
+	STATS_DESC_COUNTER(VCPU, exits),
+	STATS_DESC_COUNTER(VCPU, io_exits),
+	STATS_DESC_COUNTER(VCPU, mmio_exits),
+	STATS_DESC_COUNTER(VCPU, signal_exits),
+	STATS_DESC_COUNTER(VCPU, irq_window_exits),
+	STATS_DESC_COUNTER(VCPU, nmi_window_exits),
+	STATS_DESC_COUNTER(VCPU, l1d_flush),
+	STATS_DESC_COUNTER(VCPU, halt_exits),
+	STATS_DESC_COUNTER(VCPU, request_irq_exits),
+	STATS_DESC_COUNTER(VCPU, irq_exits),
+	STATS_DESC_COUNTER(VCPU, host_state_reload),
+	STATS_DESC_COUNTER(VCPU, fpu_reload),
+	STATS_DESC_COUNTER(VCPU, insn_emulation),
+	STATS_DESC_COUNTER(VCPU, insn_emulation_fail),
+	STATS_DESC_COUNTER(VCPU, hypercalls),
+	STATS_DESC_COUNTER(VCPU, irq_injections),
+	STATS_DESC_COUNTER(VCPU, nmi_injections),
+	STATS_DESC_COUNTER(VCPU, req_event),
+	STATS_DESC_COUNTER(VCPU, nested_run),
+	STATS_DESC_COUNTER(VCPU, directed_yield_attempted),
+	STATS_DESC_COUNTER(VCPU, directed_yield_successful),
+	STATS_DESC_ICOUNTER(VCPU, guest_mode)
+};
+static_assert(ARRAY_SIZE(kvm_vcpu_stats_desc) ==
+		sizeof(struct kvm_vcpu_stat) / sizeof(u64));
+
+struct kvm_stats_header kvm_vcpu_stats_header = {
+	.name_size = KVM_STATS_NAME_LEN,
+	.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
+		       sizeof(kvm_vcpu_stats_desc),
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("pf_fixed", pf_fixed),
 	VCPU_STAT("pf_guest", pf_guest),
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c73bc761f96..dd7709fd2f73 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -305,7 +305,6 @@ struct kvm_vcpu {
 	struct pid __rcu *pid;
 	int sigset_active;
 	sigset_t sigset;
-	struct kvm_vcpu_stat stat;
 	unsigned int halt_poll_ns;
 	bool valid_wakeup;
 
@@ -342,7 +341,9 @@ struct kvm_vcpu {
 	bool preempted;
 	bool ready;
 	struct kvm_vcpu_arch arch;
+	struct kvm_vcpu_stat stat;
 	struct kvm_dirty_ring dirty_ring;
+	char stats_id[KVM_STATS_ID_MAXLEN];
 };
 
 /* must be called with irqs disabled */
@@ -1431,6 +1432,14 @@ struct _kvm_stats_desc {
 #define KVM_GENERIC_VM_STATS()						       \
 	STATS_DESC_COUNTER(VM_GENERIC, remote_tlb_flush)
 
+#define KVM_GENERIC_VCPU_STATS()					       \
+	STATS_DESC_COUNTER(VCPU_GENERIC, halt_successful_poll),		       \
+	STATS_DESC_COUNTER(VCPU_GENERIC, halt_attempted_poll),		       \
+	STATS_DESC_COUNTER(VCPU_GENERIC, halt_poll_invalid),		       \
+	STATS_DESC_COUNTER(VCPU_GENERIC, halt_wakeup),			       \
+	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_poll_success_ns),	       \
+	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_poll_fail_ns)
+
 extern struct kvm_stats_debugfs_item debugfs_entries[];
 extern struct dentry *kvm_debugfs_dir;
 ssize_t kvm_stats_read(char *id, struct kvm_stats_header *header,
@@ -1438,6 +1447,8 @@ ssize_t kvm_stats_read(char *id, struct kvm_stats_header *header,
 		char __user *user_buffer, size_t size, loff_t *offset);
 extern struct kvm_stats_header kvm_vm_stats_header;
 extern struct _kvm_stats_desc kvm_vm_stats_desc[];
+extern struct kvm_stats_header kvm_vcpu_stats_header;
+extern struct _kvm_stats_desc kvm_vcpu_stats_desc[];
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf0d487272b9..5f9d566db1c4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3497,6 +3497,48 @@ static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
 	return 0;
 }
 
+static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
+			      size_t size, loff_t *offset)
+{
+	struct kvm_vcpu *vcpu = file->private_data;
+
+	return kvm_stats_read(vcpu->stats_id, &kvm_vcpu_stats_header,
+			&kvm_vcpu_stats_desc[0], &vcpu->stat,
+			sizeof(vcpu->stat), user_buffer, size, offset);
+}
+
+static const struct file_operations kvm_vcpu_stats_fops = {
+	.read = kvm_vcpu_stats_read,
+	.llseek = noop_llseek,
+};
+
+static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
+{
+	int fd;
+	struct file *file;
+	char name[15 + ITOA_MAX_LEN + 1];
+
+	snprintf(name, sizeof(name), "kvm-vcpu-stats:%d", vcpu->vcpu_id);
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	file = anon_inode_getfile(name, &kvm_vcpu_stats_fops, vcpu, O_RDONLY);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		return PTR_ERR(file);
+	}
+	file->f_mode |= FMODE_PREAD;
+	fd_install(fd, file);
+
+	/* Fill the stats id string for the vcpu */
+	snprintf(vcpu->stats_id, sizeof(vcpu->stats_id), "kvm-%d/vcpu-%d",
+					task_pid_nr(current), vcpu->vcpu_id);
+
+	return fd;
+}
+
 static long kvm_vcpu_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -3694,6 +3736,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
 		break;
 	}
+	case KVM_GET_STATS_FD: {
+		r = kvm_vcpu_ioctl_get_stats_fd(vcpu);
+		break;
+	}
 	default:
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 	}
@@ -3952,6 +3998,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #else
 		return 0;
 #endif
+	case KVM_CAP_BINARY_STATS_FD:
+		return 1;
 	default:
 		break;
 	}
@@ -5253,10 +5301,11 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 		vcpu_align = __alignof__(struct kvm_vcpu);
 	kvm_vcpu_cache =
 		kmem_cache_create_usercopy("kvm_vcpu", vcpu_size, vcpu_align,
-					   SLAB_ACCOUNT,
-					   offsetof(struct kvm_vcpu, arch),
-					   sizeof_field(struct kvm_vcpu, arch),
-					   NULL);
+				   SLAB_ACCOUNT,
+				   offsetof(struct kvm_vcpu, arch),
+				   sizeof_field(struct kvm_vcpu, arch)
+				   + sizeof_field(struct kvm_vcpu, stat),
+				   NULL);
 	if (!kvm_vcpu_cache) {
 		r = -ENOMEM;
 		goto out_free_3;
-- 
2.32.0.288.g62a8d224e6-goog

