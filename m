Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B93A7136
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jun 2021 23:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhFNVYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Jun 2021 17:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhFNVYQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Jun 2021 17:24:16 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD3CC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jun 2021 14:22:01 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r5-20020a635d050000b0290220f78694c8so7488284pgb.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jun 2021 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4+e7CJegOEHQPIwsGkD1iy6gELinzH02cRuI9LNNpoQ=;
        b=YFMIPFtFSEe/c+1Jkf7vggmuUCNeNv2iqPtrsUG8rw0GOu+vguhnmFhiGznyJztiRa
         YP/S2R8X9be1UGFXFdVUB6QzgVD+8kWAAvpebQQ6qPHj0FN2wSvb4zlqq8uHvL4hnkNQ
         J2AKymRPD700zFO1ocEToD86h7ttsx6vW9+ZoJYEQmMafkrGQUTsryn/BWxPp5PDjI9g
         eSDTnHItOu48O9eDosJCJVF1+hfZyMshzIWW/WpiGTZtvwYXMJVk6wAFo2xEJk5unaLy
         cQ/oMSmSkFQE3KIJyNxuZZ5V1myfJOHgTXMZ8uJxle3VLKBDDoY3sRdJdNkol01jvN/o
         vFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4+e7CJegOEHQPIwsGkD1iy6gELinzH02cRuI9LNNpoQ=;
        b=X8JERERmvqlpELxaX3DlwaWrnFf4As021HxAinWn1YGy52Vjr/sXzweOEca+CWMrsX
         2I3x3g2a6lbJt/g3SfnhRjKtQpRxVBZrO4mdMvNh1TRIgMOjod8AClnrxC8qGaNPr5qz
         ThHIHidN2UdkQfk2JQeUT8KUjxn0UjUSbSpIhZaUa+5C7hGpurma00TtUnnmgmg3oezj
         gILVzov7vuFBFkbc/Q7uMX8VW+C3IwOU5ICFoT37xUGDz/fpxPi1J92bPtMcNmUzcLBa
         c/T5zh/31TrWW3/VbxhnsbEjp2ifFco7RVf76a9XeNSynwNvNY6jCSFGVN4gkl8myu49
         XjNg==
X-Gm-Message-State: AOAM5307R3t5wdQ+t/4sWhBwyfZ1Dg9LmG8/70lpN82KdBeJzyZRNft/
        FceATs0JfrPjhjvIS/PMNd4MW9wQWcj5DAdxtw==
X-Google-Smtp-Source: ABdhPJwdmfrVCpB7evjWLyU06oYHMYobYRrF+ehaPXJewY7pq4KI1Q0+Wu3J5Y117e8U/HVOvocqYp88bwFL9cKYgA==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:90b:e8a:: with SMTP id
 fv10mr1217753pjb.160.1623705721368; Mon, 14 Jun 2021 14:22:01 -0700 (PDT)
Date:   Mon, 14 Jun 2021 21:21:52 +0000
In-Reply-To: <20210614212155.1670777-1-jingzhangos@google.com>
Message-Id: <20210614212155.1670777-3-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210614212155.1670777-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v9 2/5] KVM: stats: Add fd-based API to read binary stats data
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
        Fuad Tabba <tabba@google.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Provides a file descriptor per VM to read VM stats info/data.
Provides a file descriptor per vCPU to read vCPU stats info/data.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com> #arm64
Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/kvm/guest.c    |  38 +++++++++
 arch/mips/kvm/mips.c      |  61 ++++++++++++++
 arch/powerpc/kvm/book3s.c |  64 +++++++++++++++
 arch/powerpc/kvm/booke.c  |  57 ++++++++++++++
 arch/s390/kvm/kvm-s390.c  | 130 ++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c        |  68 ++++++++++++++++
 include/linux/kvm_host.h  | 162 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h  |  46 +++++++++++
 virt/kvm/kvm_main.c       | 143 +++++++++++++++++++++++++++++++++
 9 files changed, 769 insertions(+)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 4962331d01e6..99842e29c2de 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -28,6 +28,44 @@
 
 #include "trace.h"
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS()
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct _kvm_stats_header kvm_vm_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vm_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vm_stats_desc),
+	}
+};
+
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
+struct _kvm_stats_header kvm_vcpu_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vcpu_stats_desc),
+	}
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
 	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index ff205b35719b..67404f0947aa 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -38,6 +38,67 @@
 #define VECTORSPACING 0x100	/* for EI/VI mode */
 #endif
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS()
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct _kvm_stats_header kvm_vm_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vm_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vm_stats_desc),
+	}
+};
+
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
+struct _kvm_stats_header kvm_vcpu_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vcpu_stats_desc),
+	}
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("wait", wait_exits),
 	VCPU_STAT("cache", cache_exits),
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 92cdb4175945..15436484e521 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -38,6 +38,70 @@
 
 /* #define EXIT_DEBUG */
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS(),
+	STATS_DESC_ICOUNTER(VM, num_2M_pages),
+	STATS_DESC_ICOUNTER(VM, num_1G_pages)
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct _kvm_stats_header kvm_vm_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vm_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vm_stats_desc),
+	}
+};
+
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
+struct _kvm_stats_header kvm_vcpu_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vcpu_stats_desc),
+	}
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("exits", sum_exits),
 	VCPU_STAT("mmio", mmio_exits),
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 80d3b39aa7ac..fbc9b7b6af57 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -36,6 +36,63 @@
 
 unsigned long kvmppc_booke_handlers;
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS(),
+	STATS_DESC_ICOUNTER(VM, num_2M_pages),
+	STATS_DESC_ICOUNTER(VM, num_1G_pages)
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct _kvm_stats_header kvm_vm_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vm_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vm_stats_desc),
+	}
+};
+
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
+struct _kvm_stats_header kvm_vcpu_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vcpu_stats_desc),
+	}
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("mmio", mmio_exits),
 	VCPU_STAT("sig", signal_exits),
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e8bc7cd06794..ba50dd775fa8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -58,6 +58,136 @@
 #define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
 			   (KVM_MAX_VCPUS + LOCAL_IRQS))
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS(),
+	STATS_DESC_COUNTER(VM, inject_io),
+	STATS_DESC_COUNTER(VM, inject_float_mchk),
+	STATS_DESC_COUNTER(VM, inject_pfault_done),
+	STATS_DESC_COUNTER(VM, inject_service_signal),
+	STATS_DESC_COUNTER(VM, inject_virtio)
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct _kvm_stats_header kvm_vm_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vm_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vm_stats_desc),
+	}
+};
+
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
+struct _kvm_stats_header kvm_vcpu_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vcpu_stats_desc),
+	}
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("userspace_handled", exit_userspace),
 	VCPU_STAT("exit_null", exit_null),
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 157212157aee..84438573b529 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -223,6 +223,74 @@ EXPORT_SYMBOL_GPL(host_xss);
 u64 __read_mostly supported_xss;
 EXPORT_SYMBOL_GPL(supported_xss);
 
+struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS(),
+	STATS_DESC_COUNTER(VM, mmu_shadow_zapped),
+	STATS_DESC_COUNTER(VM, mmu_pte_write),
+	STATS_DESC_COUNTER(VM, mmu_pde_zapped),
+	STATS_DESC_COUNTER(VM, mmu_flooded),
+	STATS_DESC_COUNTER(VM, mmu_recycled),
+	STATS_DESC_COUNTER(VM, mmu_cache_miss),
+	STATS_DESC_ICOUNTER(VM, mmu_unsync),
+	STATS_DESC_ICOUNTER(VM, lpages),
+	STATS_DESC_ICOUNTER(VM, nx_lpage_splits),
+	STATS_DESC_ICOUNTER(VM, max_mmu_page_hash_collisions)
+};
+static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
+		sizeof(struct kvm_vm_stat) / sizeof(u64));
+
+struct _kvm_stats_header kvm_vm_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vm_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vm_stats_desc),
+	}
+};
+
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
+struct _kvm_stats_header kvm_vcpu_stats_header = {
+	{
+		.name_size = KVM_STATS_NAME_LEN,
+		.count = ARRAY_SIZE(kvm_vcpu_stats_desc),
+		.desc_offset = sizeof(struct _kvm_stats_header),
+		.data_offset = sizeof(struct _kvm_stats_header) +
+			sizeof(kvm_vcpu_stats_desc),
+	}
+};
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("pf_fixed", pf_fixed),
 	VCPU_STAT("pf_guest", pf_guest),
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5a31e0696360..692af9177c9f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1272,6 +1272,17 @@ struct kvm_stats_debugfs_item {
 	int mode;
 };
 
+struct _kvm_stats_header {
+	struct kvm_stats_header header;
+	char id[KVM_STATS_ID_MAXLEN];
+};
+
+#define KVM_STATS_NAME_LEN	48
+struct _kvm_stats_desc {
+	struct kvm_stats_desc desc;
+	char name[KVM_STATS_NAME_LEN];
+};
+
 #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
 	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
 
@@ -1285,8 +1296,159 @@ struct kvm_stats_debugfs_item {
 	{ n, offsetof(struct kvm_vcpu, stat.generic.x),			       \
 	  KVM_STAT_VCPU, ## __VA_ARGS__ }
 
+#define STATS_DESC_COMMON(type, unit, base, exp)			       \
+	.flags = type | unit | base |					       \
+	    BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |		       \
+	    BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |		       \
+	    BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),		       \
+	.exponent = exp,						       \
+	.size = 1
+
+#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp)		       \
+	{								       \
+		{							       \
+			STATS_DESC_COMMON(type, unit, base, exp),	       \
+			.offset = offsetof(struct kvm_vm_stat, generic.stat)   \
+		},							       \
+		.name = #stat,						       \
+	}
+#define VCPU_GENERIC_STATS_DESC(stat, type, unit, base, exp)		       \
+	{								       \
+		{							       \
+			STATS_DESC_COMMON(type, unit, base, exp),	       \
+			.offset = offsetof(struct kvm_vcpu_stat, generic.stat) \
+		},							       \
+		.name = #stat,						       \
+	}
+#define VM_STATS_DESC(stat, type, unit, base, exp)			       \
+	{								       \
+		{							       \
+			STATS_DESC_COMMON(type, unit, base, exp),	       \
+			.offset = offsetof(struct kvm_vm_stat, stat)	       \
+		},							       \
+		.name = #stat,						       \
+	}
+#define VCPU_STATS_DESC(stat, type, unit, base, exp)			       \
+	{								       \
+		{							       \
+			STATS_DESC_COMMON(type, unit, base, exp),	       \
+			.offset = offsetof(struct kvm_vcpu_stat, stat)	       \
+		},							       \
+		.name = #stat,						       \
+	}
+/* SCOPE: VM, VM_GENERIC, VCPU, VCPU_GENERIC */
+#define STATS_DESC(SCOPE, stat, type, unit, base, exp)			       \
+	SCOPE##_STATS_DESC(stat, type, unit, base, exp)
+
+#define STATS_DESC_CUMULATIVE(SCOPE, name, unit, base, exponent)	       \
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_CUMULATIVE,		       \
+		      unit, base, exponent)
+#define STATS_DESC_INSTANT(SCOPE, name, unit, base, exponent)		       \
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_INSTANT, unit, base, exponent)  \
+
+/* Cumulative counter */
+#define STATS_DESC_COUNTER(SCOPE, name)					       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
+		KVM_STATS_BASE_POW10, 0)
+/* Instantaneous counter */
+#define STATS_DESC_ICOUNTER(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
+		KVM_STATS_BASE_POW10, 0)
+
+/* Cumulative clock cycles */
+#define STATS_DESC_CYCLE(SCOPE, name)					       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_CYCLES,	       \
+		KVM_STATS_BASE_POW10, 0)
+/* Instantaneous clock cycles */
+#define STATS_DESC_ICYCLE(SCOPE, name)					       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_CYCLES,		       \
+		KVM_STATS_BASE_POW10, 0)
+
+/* Cumulative memory size in Byte */
+#define STATS_DESC_SIZE_BYTE(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
+		KVM_STATS_BASE_POW2, 0)
+/* Cumulative memory size in KiByte */
+#define STATS_DESC_SIZE_KBYTE(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
+		KVM_STATS_BASE_POW2, 10)
+/* Cumulative memory size in MiByte */
+#define STATS_DESC_SIZE_MBYTE(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
+		KVM_STATS_BASE_POW2, 20)
+/* Cumulative memory size in GiByte */
+#define STATS_DESC_SIZE_GBYTE(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,	       \
+		KVM_STATS_BASE_POW2, 30)
+
+/* Instantaneous memory size in Byte */
+#define STATS_DESC_ISIZE_BYTE(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
+		KVM_STATS_BASE_POW2, 0)
+/* Instantaneous memory size in KiByte */
+#define STATS_DESC_ISIZE_KBYTE(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
+		KVM_STATS_BASE_POW2, 10)
+/* Instantaneous memory size in MiByte */
+#define STATS_DESC_ISIZE_MBYTE(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
+		KVM_STATS_BASE_POW2, 20)
+/* Instantaneous memory size in GiByte */
+#define STATS_DESC_ISIZE_GBYTE(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,		       \
+		KVM_STATS_BASE_POW2, 30)
+
+/* Cumulative time in second */
+#define STATS_DESC_TIME_SEC(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
+		KVM_STATS_BASE_POW10, 0)
+/* Cumulative time in millisecond */
+#define STATS_DESC_TIME_MSEC(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
+		KVM_STATS_BASE_POW10, -3)
+/* Cumulative time in microsecond */
+#define STATS_DESC_TIME_USEC(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
+		KVM_STATS_BASE_POW10, -6)
+/* Cumulative time in nanosecond */
+#define STATS_DESC_TIME_NSEC(SCOPE, name)				       \
+	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,	       \
+		KVM_STATS_BASE_POW10, -9)
+
+/* Instantaneous time in second */
+#define STATS_DESC_ITIME_SEC(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
+		KVM_STATS_BASE_POW10, 0)
+/* Instantaneous time in millisecond */
+#define STATS_DESC_ITIME_MSEC(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
+		KVM_STATS_BASE_POW10, -3)
+/* Instantaneous time in microsecond */
+#define STATS_DESC_ITIME_USEC(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
+		KVM_STATS_BASE_POW10, -6)
+/* Instantaneous time in nanosecond */
+#define STATS_DESC_ITIME_NSEC(SCOPE, name)				       \
+	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,		       \
+		KVM_STATS_BASE_POW10, -9)
+
+#define KVM_GENERIC_VM_STATS()						       \
+	STATS_DESC_COUNTER(VM_GENERIC, remote_tlb_flush)
+
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
+extern struct _kvm_stats_header kvm_vm_stats_header;
+extern struct _kvm_stats_header kvm_vcpu_stats_header;
+extern struct _kvm_stats_desc kvm_vm_stats_desc[];
+extern struct _kvm_stats_desc kvm_vcpu_stats_desc[];
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9febe1412f7a..d6e97b577d01 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1086,6 +1086,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENFORCE_CPUID 199
 #define KVM_CAP_SREGS2 200
 #define KVM_CAP_EXIT_HYPERCALL 201
+#define KVM_CAP_BINARY_STATS_FD 202
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1905,4 +1906,49 @@ struct kvm_dirty_gfn {
 #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
 #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
 
+#define KVM_STATS_ID_MAXLEN		64
+
+struct kvm_stats_header {
+	__u32 name_size;
+	__u32 count;
+	__u32 desc_offset;
+	__u32 data_offset;
+	char id[0];
+};
+
+#define KVM_STATS_TYPE_SHIFT		0
+#define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_INSTANT
+
+#define KVM_STATS_UNIT_SHIFT		4
+#define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_NONE		(0x0 << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_BYTES		(0x1 << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_SECONDS		(0x2 << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_CYCLES		(0x3 << KVM_STATS_UNIT_SHIFT)
+#define KVM_STATS_UNIT_MAX		KVM_STATS_UNIT_CYCLES
+
+#define KVM_STATS_BASE_SHIFT		8
+#define KVM_STATS_BASE_MASK		(0xF << KVM_STATS_BASE_SHIFT)
+#define KVM_STATS_BASE_POW10		(0x0 << KVM_STATS_BASE_SHIFT)
+#define KVM_STATS_BASE_POW2		(0x1 << KVM_STATS_BASE_SHIFT)
+#define KVM_STATS_BASE_MAX		KVM_STATS_BASE_POW2
+
+struct kvm_stats_desc {
+	__u32 flags;
+	__s16 exponent;
+	__u16 size;
+	__u32 offset;
+	__u32 unused;
+	char name[0];
+};
+
+struct kvm_stats_data {
+	__u64 value[0];
+};
+
+#define KVM_GET_STATS_FD  _IO(KVMIO,  0xce)
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cec986487b30..f5bea71ea61c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3497,6 +3497,103 @@ static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
 	return 0;
 }
 
+static ssize_t kvm_stats_read(struct _kvm_stats_header *header,
+		struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
+		char __user *user_buffer, size_t size, loff_t *offset)
+{
+	ssize_t copylen, len, remain = size;
+	size_t size_header, size_desc;
+	loff_t pos = *offset;
+	char __user *dest = user_buffer;
+	void *src;
+
+	size_header = sizeof(*header);
+	size_desc = header->header.count * sizeof(*desc);
+
+	len = size_header + size_desc + size_stats - pos;
+	len = min(len, remain);
+	if (len <= 0)
+		return 0;
+	remain = len;
+
+	/* Copy kvm stats header */
+	copylen = size_header - pos;
+	copylen = min(copylen, remain);
+	if (copylen > 0) {
+		src = (void *)header + pos;
+		if (copy_to_user(dest, src, copylen))
+			return -EFAULT;
+		remain -= copylen;
+		pos += copylen;
+		dest += copylen;
+	}
+	/* Copy kvm stats descriptors */
+	copylen = header->header.desc_offset + size_desc - pos;
+	copylen = min(copylen, remain);
+	if (copylen > 0) {
+		src = (void *)desc + pos - header->header.desc_offset;
+		if (copy_to_user(dest, src, copylen))
+			return -EFAULT;
+		remain -= copylen;
+		pos += copylen;
+		dest += copylen;
+	}
+	/* Copy kvm stats values */
+	copylen = header->header.data_offset + size_stats - pos;
+	copylen = min(copylen, remain);
+	if (copylen > 0) {
+		src = stats + pos - header->header.data_offset;
+		if (copy_to_user(dest, src, copylen))
+			return -EFAULT;
+		remain -= copylen;
+		pos += copylen;
+		dest += copylen;
+	}
+
+	*offset = pos;
+	return len;
+}
+
+static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
+			      size_t size, loff_t *offset)
+{
+	struct kvm_vcpu *vcpu = file->private_data;
+
+	snprintf(&kvm_vcpu_stats_header.id[0], sizeof(kvm_vcpu_stats_header.id),
+			"kvm-%d/vcpu-%d", task_pid_nr(current), vcpu->vcpu_id);
+	return kvm_stats_read(&kvm_vcpu_stats_header,
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
+	return fd;
+}
+
 static long kvm_vcpu_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -3694,6 +3791,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
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
@@ -3952,6 +4053,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #else
 		return 0;
 #endif
+	case KVM_CAP_BINARY_STATS_FD:
+		return 1;
 	default:
 		break;
 	}
@@ -4055,6 +4158,43 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
 	}
 }
 
+static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
+			      size_t size, loff_t *offset)
+{
+	struct kvm *kvm = file->private_data;
+
+	snprintf(&kvm_vm_stats_header.id[0], sizeof(kvm_vm_stats_header.id),
+			"kvm-%d", task_pid_nr(current));
+	return kvm_stats_read(&kvm_vm_stats_header, &kvm_vm_stats_desc[0],
+		&kvm->stat, sizeof(kvm->stat), user_buffer, size, offset);
+}
+
+static const struct file_operations kvm_vm_stats_fops = {
+	.read = kvm_vm_stats_read,
+	.llseek = noop_llseek,
+};
+
+static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
+{
+	int fd;
+	struct file *file;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	file = anon_inode_getfile("kvm-vm-stats",
+			&kvm_vm_stats_fops, kvm, O_RDONLY);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		return PTR_ERR(file);
+	}
+	file->f_mode |= FMODE_PREAD;
+	fd_install(fd, file);
+
+	return fd;
+}
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -4237,6 +4377,9 @@ static long kvm_vm_ioctl(struct file *filp,
 	case KVM_RESET_DIRTY_RINGS:
 		r = kvm_vm_ioctl_reset_dirty_pages(kvm);
 		break;
+	case KVM_GET_STATS_FD:
+		r = kvm_vm_ioctl_get_stats_fd(kvm);
+		break;
 	default:
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
 	}
-- 
2.32.0.272.g935e593368-goog

