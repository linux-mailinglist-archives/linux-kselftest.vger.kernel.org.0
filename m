Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D549E333266
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 01:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhCJAbQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Mar 2021 19:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhCJAan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Mar 2021 19:30:43 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97690C061760
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Mar 2021 16:30:43 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id m3so11661922ioy.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Mar 2021 16:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w4HWO7BOc3rd93ENppTFarD1eUekczKbOeXBNH9YdnE=;
        b=ehzWMPESd1qEKYF5eIXAG8PO252zJXS5nxBQ6cL/dgn9nfrMa9XztHs6xQqzzmZRw1
         /vmJRDYFspuSWYNONt84tXe5Gu+XWSVpDS5/o/G8289D8bznR36qNIukjdSFnR236v6F
         lDW/d7rA405/eDJ1BDISM/F9ADuZhJCFV1zXwIKusXv5B03qHthdli8Qh8dqfE5iPUgH
         yf5v22t4HjFjfXnEYc8htmJBikGzI8CaWUSpNy0ECW/4vcqBKw8OO7hmsGF9RQIDx64m
         AUoIkz2MzIRG1fX85vhR9PCuMa+7RriKV/y9qtBeP8FIOHqqyYJTe7ySReBhXJalb+S6
         pgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w4HWO7BOc3rd93ENppTFarD1eUekczKbOeXBNH9YdnE=;
        b=rJ6wc6LFYzn5P7br2IXR3NYyiDtoGScgl5DNCdelrZ5vgM2FiHmib4qiVomqG9nIFQ
         6OggIP22v1yqeYPcWm7GFSs9Vr+9jfB2bWFOASx0oA2CfuUvk0AqWyXianWFtSg5hfYc
         YPbAryRnfXbWpZTH6Oc+hAO+ENybHuaDxnzK4XiP+AwVXs5qrLlav+DLkhl3igso5Rb2
         +shioVHFDvAU5UTph6Zwm5YIBvd+kUefswqCXEnp3KxqCLgAYd9jvq3F9NcHyFuG2HtT
         dCP2GwljEFJ+WUzi7GUYcboWcnA7zyzBnrsnMj2nNBfOFJLSOiNkKRWK4YnebL7sZP1P
         iDcA==
X-Gm-Message-State: AOAM530oVH2I8ta+DCPszAOfbMakEtGwltaTiK3RpW81KldQLT+7yG7j
        zZmSwLYg9lianXSSh+wpteLUmgtqp8qMJlsVkg==
X-Google-Smtp-Source: ABdhPJyRIDsfQsiUcP3akPSY+zemsgHPSz3ZV8SsEBVLSILX/2HwE0zgNRlxmwAlt7ilcx04LhvjxO/9BTJT4PSeEg==
X-Received: from jingzhangos.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:513])
 (user=jingzhangos job=sendgmr) by 2002:a5d:8c8f:: with SMTP id
 g15mr603463ion.162.1615336243044; Tue, 09 Mar 2021 16:30:43 -0800 (PST)
Date:   Wed, 10 Mar 2021 00:30:21 +0000
In-Reply-To: <20210310003024.2026253-1-jingzhangos@google.com>
Message-Id: <20210310003024.2026253-2-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210310003024.2026253-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [RFC PATCH 1/4] KVM: stats: Separate statistics name strings from
 debugfs code
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Prepare the statistics name strings for supporting binary format
aggregated statistics data retrieval.

No functional change intended.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/kvm/guest.c    |  47 ++++--
 arch/mips/kvm/mips.c      | 114 ++++++++++----
 arch/powerpc/kvm/book3s.c | 107 +++++++++----
 arch/powerpc/kvm/booke.c  |  84 +++++++---
 arch/s390/kvm/kvm-s390.c  | 320 ++++++++++++++++++++++++++------------
 arch/x86/kvm/x86.c        | 127 ++++++++++-----
 include/linux/kvm_host.h  |  31 +++-
 7 files changed, 589 insertions(+), 241 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 9bbd30e62799..fb3aafe76b52 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -28,19 +28,42 @@
 
 #include "trace.h"
 
+const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"remote_tlb_flush",
+};
+static_assert(sizeof(kvm_vm_stat_strings) ==
+		VM_STAT_COUNT * KVM_STATS_NAME_LEN);
+
+const char kvm_vcpu_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"halt_successful_poll",
+	"halt_attempted_poll",
+	"halt_poll_success_ns",
+	"halt_poll_fail_ns",
+	"halt_poll_invalid",
+	"halt_wakeup",
+	"hvc_exit_stat",
+	"wfe_exit_stat",
+	"wfi_exit_stat",
+	"mmio_exit_user",
+	"mmio_exit_kernel",
+	"exits",
+};
+static_assert(sizeof(kvm_vcpu_stat_strings) ==
+		VCPU_STAT_COUNT * KVM_STATS_NAME_LEN);
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("hvc_exit_stat", hvc_exit_stat),
-	VCPU_STAT("wfe_exit_stat", wfe_exit_stat),
-	VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
-	VCPU_STAT("mmio_exit_user", mmio_exit_user),
-	VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
-	VCPU_STAT("exits", exits),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT(halt_successful_poll),
+	VCPU_STAT(halt_attempted_poll),
+	VCPU_STAT(halt_poll_invalid),
+	VCPU_STAT(halt_wakeup),
+	VCPU_STAT(hvc_exit_stat),
+	VCPU_STAT(wfe_exit_stat),
+	VCPU_STAT(wfi_exit_stat),
+	VCPU_STAT(mmio_exit_user),
+	VCPU_STAT(mmio_exit_kernel),
+	VCPU_STAT(exits),
+	VCPU_STAT(halt_poll_success_ns),
+	VCPU_STAT(halt_poll_fail_ns),
 	{ NULL }
 };
 
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 3d6a7f5827b1..8b9cbd9d6205 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -39,44 +39,92 @@
 #define VECTORSPACING 0x100	/* for EI/VI mode */
 #endif
 
+const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"remote_tlb_flush",
+};
+static_assert(sizeof(kvm_vm_stat_strings) ==
+		VM_STAT_COUNT * KVM_STATS_NAME_LEN);
+
+const char kvm_vcpu_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"wait",
+	"cache",
+	"signal",
+	"interrupt",
+	"cop_unusable",
+	"tlbmod",
+	"tlbmiss_ld",
+	"tlbmiss_st",
+	"addrerr_st",
+	"addrerr_ld",
+	"syscall",
+	"resvd_inst",
+	"break_inst",
+	"trap_inst",
+	"msa_fpe",
+	"fpe",
+	"msa_disabled",
+	"flush_dcache",
+#ifdef CONFIG_KVM_MIPS_VZ
+	"vz_gpsi",
+	"vz_gsfc",
+	"vz_hc",
+	"vz_grr",
+	"vz_gva",
+	"vz_ghfc",
+	"vz_gpa",
+	"vz_resvd",
+#ifdef CONFIG_CPU_LOONGSON64
+	"vz_cpucfg",
+#endif
+#endif
+	"halt_successful_poll",
+	"halt_attempted_poll",
+	"halt_poll_success_ns",
+	"halt_poll_fail_ns",
+	"halt_poll_invalid",
+	"halt_wakeup",
+};
+static_assert(sizeof(kvm_vcpu_stat_strings) ==
+		VCPU_STAT_COUNT * KVM_STATS_NAME_LEN);
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT("wait", wait_exits),
-	VCPU_STAT("cache", cache_exits),
-	VCPU_STAT("signal", signal_exits),
-	VCPU_STAT("interrupt", int_exits),
-	VCPU_STAT("cop_unusable", cop_unusable_exits),
-	VCPU_STAT("tlbmod", tlbmod_exits),
-	VCPU_STAT("tlbmiss_ld", tlbmiss_ld_exits),
-	VCPU_STAT("tlbmiss_st", tlbmiss_st_exits),
-	VCPU_STAT("addrerr_st", addrerr_st_exits),
-	VCPU_STAT("addrerr_ld", addrerr_ld_exits),
-	VCPU_STAT("syscall", syscall_exits),
-	VCPU_STAT("resvd_inst", resvd_inst_exits),
-	VCPU_STAT("break_inst", break_inst_exits),
-	VCPU_STAT("trap_inst", trap_inst_exits),
-	VCPU_STAT("msa_fpe", msa_fpe_exits),
-	VCPU_STAT("fpe", fpe_exits),
-	VCPU_STAT("msa_disabled", msa_disabled_exits),
-	VCPU_STAT("flush_dcache", flush_dcache_exits),
+	VCPU_STAT(wait_exits),
+	VCPU_STAT(cache_exits),
+	VCPU_STAT(signal_exits),
+	VCPU_STAT(int_exits),
+	VCPU_STAT(cop_unusable_exits),
+	VCPU_STAT(tlbmod_exits),
+	VCPU_STAT(tlbmiss_ld_exits),
+	VCPU_STAT(tlbmiss_st_exits),
+	VCPU_STAT(addrerr_st_exits),
+	VCPU_STAT(addrerr_ld_exits),
+	VCPU_STAT(syscall_exits),
+	VCPU_STAT(resvd_inst_exits),
+	VCPU_STAT(break_inst_exits),
+	VCPU_STAT(trap_inst_exits),
+	VCPU_STAT(msa_fpe_exits),
+	VCPU_STAT(fpe_exits),
+	VCPU_STAT(msa_disabled_exits),
+	VCPU_STAT(flush_dcache_exits),
 #ifdef CONFIG_KVM_MIPS_VZ
-	VCPU_STAT("vz_gpsi", vz_gpsi_exits),
-	VCPU_STAT("vz_gsfc", vz_gsfc_exits),
-	VCPU_STAT("vz_hc", vz_hc_exits),
-	VCPU_STAT("vz_grr", vz_grr_exits),
-	VCPU_STAT("vz_gva", vz_gva_exits),
-	VCPU_STAT("vz_ghfc", vz_ghfc_exits),
-	VCPU_STAT("vz_gpa", vz_gpa_exits),
-	VCPU_STAT("vz_resvd", vz_resvd_exits),
+	VCPU_STAT(vz_gpsi_exits),
+	VCPU_STAT(vz_gsfc_exits),
+	VCPU_STAT(vz_hc_exits),
+	VCPU_STAT(vz_grr_exits),
+	VCPU_STAT(vz_gva_exits),
+	VCPU_STAT(vz_ghfc_exits),
+	VCPU_STAT(vz_gpa_exits),
+	VCPU_STAT(vz_resvd_exits),
 #ifdef CONFIG_CPU_LOONGSON64
-	VCPU_STAT("vz_cpucfg", vz_cpucfg_exits),
+	VCPU_STAT(vz_cpucfg_exits),
 #endif
 #endif
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT(halt_successful_poll),
+	VCPU_STAT(halt_attempted_poll),
+	VCPU_STAT(halt_poll_invalid),
+	VCPU_STAT(halt_wakeup),
+	VCPU_STAT(halt_poll_success_ns),
+	VCPU_STAT(halt_poll_fail_ns),
 	{NULL}
 };
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 44bf567b6589..22dd5a804468 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -36,38 +36,87 @@
 #include "book3s.h"
 #include "trace.h"
 
+const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"remote_tlb_flush",
+	"largepages_2M",
+	"largepages_1G",
+};
+static_assert(sizeof(kvm_vm_stat_strings) ==
+		VM_STAT_COUNT * KVM_STATS_NAME_LEN);
+
+const char kvm_vcpu_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"exits",
+	"mmio",
+	"sig",
+	"light",
+	"itlb_real_miss",
+	"itlb_virt_miss",
+	"dtlb_real_miss",
+	"dtlb_virt_miss",
+	"sysc",
+	"isi",
+	"dsi",
+	"inst_emu",
+	"dec",
+	"ext_intr",
+	"halt_poll_success_ns",
+	"halt_poll_fail_ns",
+	"halt_wait_ns",
+	"halt_successful_poll",
+	"halt_attempted_poll",
+	"halt_successful_wait",
+	"halt_poll_invalid",
+	"halt_wakeup",
+	"dbell",
+	"gdbell",
+	"ld",
+	"st",
+	"pf_storage",
+	"pf_instruc",
+	"sp_storage",
+	"sp_instruc",
+	"queue_intr",
+	"ld_slow",
+	"st_slow",
+	"pthru_all",
+	"pthru_host",
+	"pthru_bad_aff",
+};
+static_assert(sizeof(kvm_vcpu_stat_strings) ==
+		VCPU_STAT_COUNT * KVM_STATS_NAME_LEN);
+
 /* #define EXIT_DEBUG */
 
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT("exits", sum_exits),
-	VCPU_STAT("mmio", mmio_exits),
-	VCPU_STAT("sig", signal_exits),
-	VCPU_STAT("sysc", syscall_exits),
-	VCPU_STAT("inst_emu", emulated_inst_exits),
-	VCPU_STAT("dec", dec_exits),
-	VCPU_STAT("ext_intr", ext_intr_exits),
-	VCPU_STAT("queue_intr", queue_intr),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
-	VCPU_STAT("halt_wait_ns", halt_wait_ns),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_successful_wait", halt_successful_wait),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("pf_storage", pf_storage),
-	VCPU_STAT("sp_storage", sp_storage),
-	VCPU_STAT("pf_instruc", pf_instruc),
-	VCPU_STAT("sp_instruc", sp_instruc),
-	VCPU_STAT("ld", ld),
-	VCPU_STAT("ld_slow", ld_slow),
-	VCPU_STAT("st", st),
-	VCPU_STAT("st_slow", st_slow),
-	VCPU_STAT("pthru_all", pthru_all),
-	VCPU_STAT("pthru_host", pthru_host),
-	VCPU_STAT("pthru_bad_aff", pthru_bad_aff),
-	VM_STAT("largepages_2M", num_2M_pages, .mode = 0444),
-	VM_STAT("largepages_1G", num_1G_pages, .mode = 0444),
+	VCPU_STAT(sum_exits),
+	VCPU_STAT(mmio_exits),
+	VCPU_STAT(signal_exits),
+	VCPU_STAT(syscall_exits),
+	VCPU_STAT(emulated_inst_exits),
+	VCPU_STAT(dec_exits),
+	VCPU_STAT(ext_intr_exits),
+	VCPU_STAT(queue_intr),
+	VCPU_STAT(halt_poll_success_ns),
+	VCPU_STAT(halt_poll_fail_ns),
+	VCPU_STAT(halt_wait_ns),
+	VCPU_STAT(halt_successful_poll),
+	VCPU_STAT(halt_attempted_poll),
+	VCPU_STAT(halt_successful_wait),
+	VCPU_STAT(halt_poll_invalid),
+	VCPU_STAT(halt_wakeup),
+	VCPU_STAT(pf_storage),
+	VCPU_STAT(sp_storage),
+	VCPU_STAT(pf_instruc),
+	VCPU_STAT(sp_instruc),
+	VCPU_STAT(ld),
+	VCPU_STAT(ld_slow),
+	VCPU_STAT(st),
+	VCPU_STAT(st_slow),
+	VCPU_STAT(pthru_all),
+	VCPU_STAT(pthru_host),
+	VCPU_STAT(pthru_bad_aff),
+	VM_STAT(num_2M_pages, .mode = 0444),
+	VM_STAT(num_1G_pages, .mode = 0444),
 	{ NULL }
 };
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index f38ae3e54b37..faa830f8178b 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -35,28 +35,70 @@
 
 unsigned long kvmppc_booke_handlers;
 
+const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"remote_tlb_flush",
+	"largepages_2M",
+	"largepages_1G",
+};
+static_assert(sizeof(kvm_vm_stat_strings) ==
+		VM_STAT_COUNT * KVM_STATS_NAME_LEN);
+
+const char kvm_vcpu_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"exits",
+	"mmio",
+	"sig",
+	"light",
+	"itlb_real_miss",
+	"itlb_virt_miss",
+	"dtlb_real_miss",
+	"dtlb_virt_miss",
+	"sysc",
+	"isi",
+	"dsi",
+	"inst_emu",
+	"dec",
+	"ext_intr",
+	"halt_poll_success_ns",
+	"halt_poll_fail_ns",
+	"halt_wait_ns",
+	"halt_successful_poll",
+	"halt_attempted_poll",
+	"halt_successful_wait",
+	"halt_poll_invalid",
+	"halt_wakeup",
+	"dbell",
+	"gdbell",
+	"ld",
+	"st",
+	"pthru_all",
+	"pthru_host",
+	"pthru_bad_aff",
+};
+static_assert(sizeof(kvm_vcpu_stat_strings) ==
+		VCPU_STAT_COUNT * KVM_STATS_NAME_LEN);
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT("mmio", mmio_exits),
-	VCPU_STAT("sig", signal_exits),
-	VCPU_STAT("itlb_r", itlb_real_miss_exits),
-	VCPU_STAT("itlb_v", itlb_virt_miss_exits),
-	VCPU_STAT("dtlb_r", dtlb_real_miss_exits),
-	VCPU_STAT("dtlb_v", dtlb_virt_miss_exits),
-	VCPU_STAT("sysc", syscall_exits),
-	VCPU_STAT("isi", isi_exits),
-	VCPU_STAT("dsi", dsi_exits),
-	VCPU_STAT("inst_emu", emulated_inst_exits),
-	VCPU_STAT("dec", dec_exits),
-	VCPU_STAT("ext_intr", ext_intr_exits),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("doorbell", dbell_exits),
-	VCPU_STAT("guest doorbell", gdbell_exits),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
-	VM_STAT("remote_tlb_flush", remote_tlb_flush),
+	VCPU_STAT(mmio_exits),
+	VCPU_STAT(signal_exits),
+	VCPU_STAT(itlb_real_miss_exits),
+	VCPU_STAT(itlb_virt_miss_exits),
+	VCPU_STAT(dtlb_real_miss_exits),
+	VCPU_STAT(dtlb_virt_miss_exits),
+	VCPU_STAT(syscall_exits),
+	VCPU_STAT(isi_exits),
+	VCPU_STAT(dsi_exits),
+	VCPU_STAT(emulated_inst_exits),
+	VCPU_STAT(dec_exits),
+	VCPU_STAT(ext_intr_exits),
+	VCPU_STAT(halt_successful_poll),
+	VCPU_STAT(halt_attempted_poll),
+	VCPU_STAT(halt_poll_invalid),
+	VCPU_STAT(halt_wakeup),
+	VCPU_STAT(dbell_exits),
+	VCPU_STAT(gdbell_exits),
+	VCPU_STAT(halt_poll_success_ns),
+	VCPU_STAT(halt_poll_fail_ns),
+	VM_STAT(remote_tlb_flush),
 	{ NULL }
 };
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index dbafd057ca6a..cefec8c1e87a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -57,110 +57,224 @@
 #define VCPU_IRQS_MAX_BUF (sizeof(struct kvm_s390_irq) * \
 			   (KVM_MAX_VCPUS + LOCAL_IRQS))
 
+const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"inject_io",
+	"inject_float_mchk",
+	"inject_pfault_done",
+	"inject_service_signal",
+	"inject_virtio",
+	"remote_tlb_flush",
+};
+static_assert(sizeof(kvm_vm_stat_strings) ==
+		VM_STAT_COUNT * KVM_STATS_NAME_LEN);
+
+const char kvm_vcpu_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"userspace_handled",
+	"exit_null",
+	"exit_external_request",
+	"exit_io_request",
+	"exit_external_interrupt",
+	"exit_stop_request",
+	"exit_validity",
+	"exit_instruction",
+	"exit_pei",
+	"halt_successful_poll",
+	"halt_attempted_poll",
+	"halt_poll_invalid",
+	"halt_no_poll_steal",
+	"halt_wakeup",
+	"halt_poll_success_ns",
+	"halt_poll_fail_ns",
+	"instruction_lctlg",
+	"instruction_lctl",
+	"instruction_stctl",
+	"instruction_stctg",
+	"exit_program_interruption",
+	"exit_instr_and_program_int",
+	"exit_operation_exception",
+	"deliver_ckc",
+	"deliver_cputm",
+	"deliver_external_call",
+	"deliver_emergency_signal",
+	"deliver_service_signal",
+	"deliver_virtio",
+	"deliver_stop_signal",
+	"deliver_prefix_signal",
+	"deliver_restart_signal",
+	"deliver_program",
+	"deliver_io",
+	"deliver_machine_check",
+	"exit_wait_state",
+	"inject_ckc",
+	"inject_cputm",
+	"inject_external_call",
+	"inject_emergency_signal",
+	"inject_mchk",
+	"inject_pfault_init",
+	"inject_program",
+	"inject_restart",
+	"inject_set_prefix",
+	"inject_stop_signal",
+	"instruction_epsw",
+	"instruction_gs",
+	"instruction_io_other",
+	"instruction_lpsw",
+	"instruction_lpswe",
+	"instruction_pfmf",
+	"instruction_ptff",
+	"instruction_sck",
+	"instruction_sckpf",
+	"instruction_stidp",
+	"instruction_spx",
+	"instruction_stpx",
+	"instruction_stap",
+	"instruction_iske",
+	"instruction_ri",
+	"instruction_rrbe",
+	"instruction_sske",
+	"instruction_ipte_interlock",
+	"instruction_stsi",
+	"instruction_stfl",
+	"instruction_tb",
+	"instruction_tpi",
+	"instruction_tprot",
+	"instruction_tsch",
+	"instruction_sie",
+	"instruction_essa",
+	"instruction_sthyi",
+	"instruction_sigp_sense",
+	"instruction_sigp_sense_running",
+	"instruction_sigp_external_call",
+	"instruction_sigp_emergency",
+	"instruction_sigp_cond_emergency",
+	"instruction_sigp_start",
+	"instruction_sigp_stop",
+	"instruction_sigp_stop_store_status",
+	"instruction_sigp_store_status",
+	"instruction_sigp_store_adtl_status",
+	"instruction_sigp_set_arch",
+	"instruction_sigp_set_prefix",
+	"instruction_sigp_restart",
+	"instruction_sigp_init_cpu_reset",
+	"instruction_sigp_cpu_reset",
+	"instruction_sigp_unknown",
+	"instruction_diag_10",
+	"instruction_diag_44",
+	"instruction_diag_9c",
+	"diag_9c_ignored",
+	"instruction_diag_258",
+	"instruction_diag_308",
+	"instruction_diag_500",
+	"instruction_diag_other",
+	"pfault_sync",
+};
+static_assert(sizeof(kvm_vcpu_stat_strings) ==
+		VCPU_STAT_COUNT * KVM_STATS_NAME_LEN);
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT("userspace_handled", exit_userspace),
-	VCPU_STAT("exit_null", exit_null),
-	VCPU_STAT("pfault_sync", pfault_sync),
-	VCPU_STAT("exit_validity", exit_validity),
-	VCPU_STAT("exit_stop_request", exit_stop_request),
-	VCPU_STAT("exit_external_request", exit_external_request),
-	VCPU_STAT("exit_io_request", exit_io_request),
-	VCPU_STAT("exit_external_interrupt", exit_external_interrupt),
-	VCPU_STAT("exit_instruction", exit_instruction),
-	VCPU_STAT("exit_pei", exit_pei),
-	VCPU_STAT("exit_program_interruption", exit_program_interruption),
-	VCPU_STAT("exit_instr_and_program_int", exit_instr_and_program),
-	VCPU_STAT("exit_operation_exception", exit_operation_exception),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_no_poll_steal", halt_no_poll_steal),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
-	VCPU_STAT("instruction_lctlg", instruction_lctlg),
-	VCPU_STAT("instruction_lctl", instruction_lctl),
-	VCPU_STAT("instruction_stctl", instruction_stctl),
-	VCPU_STAT("instruction_stctg", instruction_stctg),
-	VCPU_STAT("deliver_ckc", deliver_ckc),
-	VCPU_STAT("deliver_cputm", deliver_cputm),
-	VCPU_STAT("deliver_emergency_signal", deliver_emergency_signal),
-	VCPU_STAT("deliver_external_call", deliver_external_call),
-	VCPU_STAT("deliver_service_signal", deliver_service_signal),
-	VCPU_STAT("deliver_virtio", deliver_virtio),
-	VCPU_STAT("deliver_stop_signal", deliver_stop_signal),
-	VCPU_STAT("deliver_prefix_signal", deliver_prefix_signal),
-	VCPU_STAT("deliver_restart_signal", deliver_restart_signal),
-	VCPU_STAT("deliver_program", deliver_program),
-	VCPU_STAT("deliver_io", deliver_io),
-	VCPU_STAT("deliver_machine_check", deliver_machine_check),
-	VCPU_STAT("exit_wait_state", exit_wait_state),
-	VCPU_STAT("inject_ckc", inject_ckc),
-	VCPU_STAT("inject_cputm", inject_cputm),
-	VCPU_STAT("inject_external_call", inject_external_call),
-	VM_STAT("inject_float_mchk", inject_float_mchk),
-	VCPU_STAT("inject_emergency_signal", inject_emergency_signal),
-	VM_STAT("inject_io", inject_io),
-	VCPU_STAT("inject_mchk", inject_mchk),
-	VM_STAT("inject_pfault_done", inject_pfault_done),
-	VCPU_STAT("inject_program", inject_program),
-	VCPU_STAT("inject_restart", inject_restart),
-	VM_STAT("inject_service_signal", inject_service_signal),
-	VCPU_STAT("inject_set_prefix", inject_set_prefix),
-	VCPU_STAT("inject_stop_signal", inject_stop_signal),
-	VCPU_STAT("inject_pfault_init", inject_pfault_init),
-	VM_STAT("inject_virtio", inject_virtio),
-	VCPU_STAT("instruction_epsw", instruction_epsw),
-	VCPU_STAT("instruction_gs", instruction_gs),
-	VCPU_STAT("instruction_io_other", instruction_io_other),
-	VCPU_STAT("instruction_lpsw", instruction_lpsw),
-	VCPU_STAT("instruction_lpswe", instruction_lpswe),
-	VCPU_STAT("instruction_pfmf", instruction_pfmf),
-	VCPU_STAT("instruction_ptff", instruction_ptff),
-	VCPU_STAT("instruction_stidp", instruction_stidp),
-	VCPU_STAT("instruction_sck", instruction_sck),
-	VCPU_STAT("instruction_sckpf", instruction_sckpf),
-	VCPU_STAT("instruction_spx", instruction_spx),
-	VCPU_STAT("instruction_stpx", instruction_stpx),
-	VCPU_STAT("instruction_stap", instruction_stap),
-	VCPU_STAT("instruction_iske", instruction_iske),
-	VCPU_STAT("instruction_ri", instruction_ri),
-	VCPU_STAT("instruction_rrbe", instruction_rrbe),
-	VCPU_STAT("instruction_sske", instruction_sske),
-	VCPU_STAT("instruction_ipte_interlock", instruction_ipte_interlock),
-	VCPU_STAT("instruction_essa", instruction_essa),
-	VCPU_STAT("instruction_stsi", instruction_stsi),
-	VCPU_STAT("instruction_stfl", instruction_stfl),
-	VCPU_STAT("instruction_tb", instruction_tb),
-	VCPU_STAT("instruction_tpi", instruction_tpi),
-	VCPU_STAT("instruction_tprot", instruction_tprot),
-	VCPU_STAT("instruction_tsch", instruction_tsch),
-	VCPU_STAT("instruction_sthyi", instruction_sthyi),
-	VCPU_STAT("instruction_sie", instruction_sie),
-	VCPU_STAT("instruction_sigp_sense", instruction_sigp_sense),
-	VCPU_STAT("instruction_sigp_sense_running", instruction_sigp_sense_running),
-	VCPU_STAT("instruction_sigp_external_call", instruction_sigp_external_call),
-	VCPU_STAT("instruction_sigp_emergency", instruction_sigp_emergency),
-	VCPU_STAT("instruction_sigp_cond_emergency", instruction_sigp_cond_emergency),
-	VCPU_STAT("instruction_sigp_start", instruction_sigp_start),
-	VCPU_STAT("instruction_sigp_stop", instruction_sigp_stop),
-	VCPU_STAT("instruction_sigp_stop_store_status", instruction_sigp_stop_store_status),
-	VCPU_STAT("instruction_sigp_store_status", instruction_sigp_store_status),
-	VCPU_STAT("instruction_sigp_store_adtl_status", instruction_sigp_store_adtl_status),
-	VCPU_STAT("instruction_sigp_set_arch", instruction_sigp_arch),
-	VCPU_STAT("instruction_sigp_set_prefix", instruction_sigp_prefix),
-	VCPU_STAT("instruction_sigp_restart", instruction_sigp_restart),
-	VCPU_STAT("instruction_sigp_cpu_reset", instruction_sigp_cpu_reset),
-	VCPU_STAT("instruction_sigp_init_cpu_reset", instruction_sigp_init_cpu_reset),
-	VCPU_STAT("instruction_sigp_unknown", instruction_sigp_unknown),
-	VCPU_STAT("instruction_diag_10", diagnose_10),
-	VCPU_STAT("instruction_diag_44", diagnose_44),
-	VCPU_STAT("instruction_diag_9c", diagnose_9c),
-	VCPU_STAT("diag_9c_ignored", diagnose_9c_ignored),
-	VCPU_STAT("instruction_diag_258", diagnose_258),
-	VCPU_STAT("instruction_diag_308", diagnose_308),
-	VCPU_STAT("instruction_diag_500", diagnose_500),
-	VCPU_STAT("instruction_diag_other", diagnose_other),
+	VCPU_STAT(exit_userspace),
+	VCPU_STAT(exit_null),
+	VCPU_STAT(pfault_sync),
+	VCPU_STAT(exit_validity),
+	VCPU_STAT(exit_stop_request),
+	VCPU_STAT(exit_external_request),
+	VCPU_STAT(exit_io_request),
+	VCPU_STAT(exit_external_interrupt),
+	VCPU_STAT(exit_instruction),
+	VCPU_STAT(exit_pei),
+	VCPU_STAT(exit_program_interruption),
+	VCPU_STAT(exit_instr_and_program),
+	VCPU_STAT(exit_operation_exception),
+	VCPU_STAT(halt_successful_poll),
+	VCPU_STAT(halt_attempted_poll),
+	VCPU_STAT(halt_poll_invalid),
+	VCPU_STAT(halt_no_poll_steal),
+	VCPU_STAT(halt_wakeup),
+	VCPU_STAT(halt_poll_success_ns),
+	VCPU_STAT(halt_poll_fail_ns),
+	VCPU_STAT(instruction_lctlg),
+	VCPU_STAT(instruction_lctl),
+	VCPU_STAT(instruction_stctl),
+	VCPU_STAT(instruction_stctg),
+	VCPU_STAT(deliver_ckc),
+	VCPU_STAT(deliver_cputm),
+	VCPU_STAT(deliver_emergency_signal),
+	VCPU_STAT(deliver_external_call),
+	VCPU_STAT(deliver_service_signal),
+	VCPU_STAT(deliver_virtio),
+	VCPU_STAT(deliver_stop_signal),
+	VCPU_STAT(deliver_prefix_signal),
+	VCPU_STAT(deliver_restart_signal),
+	VCPU_STAT(deliver_program),
+	VCPU_STAT(deliver_io),
+	VCPU_STAT(deliver_machine_check),
+	VCPU_STAT(exit_wait_state),
+	VCPU_STAT(inject_ckc),
+	VCPU_STAT(inject_cputm),
+	VCPU_STAT(inject_external_call),
+	VM_STAT(inject_float_mchk),
+	VCPU_STAT(inject_emergency_signal),
+	VM_STAT(inject_io),
+	VCPU_STAT(inject_mchk),
+	VM_STAT(inject_pfault_done),
+	VCPU_STAT(inject_program),
+	VCPU_STAT(inject_restart),
+	VM_STAT(inject_service_signal),
+	VCPU_STAT(inject_set_prefix),
+	VCPU_STAT(inject_stop_signal),
+	VCPU_STAT(inject_pfault_init),
+	VM_STAT(inject_virtio),
+	VCPU_STAT(instruction_epsw),
+	VCPU_STAT(instruction_gs),
+	VCPU_STAT(instruction_io_other),
+	VCPU_STAT(instruction_lpsw),
+	VCPU_STAT(instruction_lpswe),
+	VCPU_STAT(instruction_pfmf),
+	VCPU_STAT(instruction_ptff),
+	VCPU_STAT(instruction_stidp),
+	VCPU_STAT(instruction_sck),
+	VCPU_STAT(instruction_sckpf),
+	VCPU_STAT(instruction_spx),
+	VCPU_STAT(instruction_stpx),
+	VCPU_STAT(instruction_stap),
+	VCPU_STAT(instruction_iske),
+	VCPU_STAT(instruction_ri),
+	VCPU_STAT(instruction_rrbe),
+	VCPU_STAT(instruction_sske),
+	VCPU_STAT(instruction_ipte_interlock),
+	VCPU_STAT(instruction_essa),
+	VCPU_STAT(instruction_stsi),
+	VCPU_STAT(instruction_stfl),
+	VCPU_STAT(instruction_tb),
+	VCPU_STAT(instruction_tpi),
+	VCPU_STAT(instruction_tprot),
+	VCPU_STAT(instruction_tsch),
+	VCPU_STAT(instruction_sthyi),
+	VCPU_STAT(instruction_sie),
+	VCPU_STAT(instruction_sigp_sense),
+	VCPU_STAT(instruction_sigp_sense_running),
+	VCPU_STAT(instruction_sigp_external_call),
+	VCPU_STAT(instruction_sigp_emergency),
+	VCPU_STAT(instruction_sigp_cond_emergency),
+	VCPU_STAT(instruction_sigp_start),
+	VCPU_STAT(instruction_sigp_stop),
+	VCPU_STAT(instruction_sigp_stop_store_status),
+	VCPU_STAT(instruction_sigp_store_status),
+	VCPU_STAT(instruction_sigp_store_adtl_status),
+	VCPU_STAT(instruction_sigp_arch),
+	VCPU_STAT(instruction_sigp_prefix),
+	VCPU_STAT(instruction_sigp_restart),
+	VCPU_STAT(instruction_sigp_cpu_reset),
+	VCPU_STAT(instruction_sigp_init_cpu_reset),
+	VCPU_STAT(instruction_sigp_unknown),
+	VCPU_STAT(diagnose_10),
+	VCPU_STAT(diagnose_44),
+	VCPU_STAT(diagnose_9c),
+	VCPU_STAT(diagnose_9c_ignored),
+	VCPU_STAT(diagnose_258),
+	VCPU_STAT(diagnose_308),
+	VCPU_STAT(diagnose_500),
+	VCPU_STAT(diagnose_other),
 	{ NULL }
 };
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 46b0e52671bb..e0b02a29c760 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -216,46 +216,95 @@ EXPORT_SYMBOL_GPL(host_xss);
 u64 __read_mostly supported_xss;
 EXPORT_SYMBOL_GPL(supported_xss);
 
+const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"mmu_shadow_zapped",
+	"mmu_pte_write",
+	"mmu_pde_zapped",
+	"mmu_flooded",
+	"mmu_recycled",
+	"mmu_cache_miss",
+	"mmu_unsync",
+	"remote_tlb_flush",
+	"largepages",
+	"nx_largepages_splitted",
+	"max_mmu_page_hash_collisions",
+};
+static_assert(sizeof(kvm_vm_stat_strings) ==
+		VM_STAT_COUNT * KVM_STATS_NAME_LEN);
+
+const char kvm_vcpu_stat_strings[][KVM_STATS_NAME_LEN] = {
+	"pf_fixed",
+	"pf_guest",
+	"tlb_flush",
+	"invlpg",
+	"exits",
+	"io_exits",
+	"mmio_exits",
+	"signal_exits",
+	"irq_window",
+	"nmi_window",
+	"l1d_flush",
+	"halt_exits",
+	"halt_successful_poll",
+	"halt_attempted_poll",
+	"halt_poll_invalid",
+	"halt_wakeup",
+	"request_irq",
+	"irq_exits",
+	"host_state_reload",
+	"fpu_reload",
+	"insn_emulation",
+	"insn_emulation_fail",
+	"hypercalls",
+	"irq_injections",
+	"nmi_injections",
+	"req_event",
+	"halt_poll_success_ns",
+	"halt_poll_fail_ns",
+};
+static_assert(sizeof(kvm_vcpu_stat_strings) ==
+		VCPU_STAT_COUNT * KVM_STATS_NAME_LEN);
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT("pf_fixed", pf_fixed),
-	VCPU_STAT("pf_guest", pf_guest),
-	VCPU_STAT("tlb_flush", tlb_flush),
-	VCPU_STAT("invlpg", invlpg),
-	VCPU_STAT("exits", exits),
-	VCPU_STAT("io_exits", io_exits),
-	VCPU_STAT("mmio_exits", mmio_exits),
-	VCPU_STAT("signal_exits", signal_exits),
-	VCPU_STAT("irq_window", irq_window_exits),
-	VCPU_STAT("nmi_window", nmi_window_exits),
-	VCPU_STAT("halt_exits", halt_exits),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("hypercalls", hypercalls),
-	VCPU_STAT("request_irq", request_irq_exits),
-	VCPU_STAT("irq_exits", irq_exits),
-	VCPU_STAT("host_state_reload", host_state_reload),
-	VCPU_STAT("fpu_reload", fpu_reload),
-	VCPU_STAT("insn_emulation", insn_emulation),
-	VCPU_STAT("insn_emulation_fail", insn_emulation_fail),
-	VCPU_STAT("irq_injections", irq_injections),
-	VCPU_STAT("nmi_injections", nmi_injections),
-	VCPU_STAT("req_event", req_event),
-	VCPU_STAT("l1d_flush", l1d_flush),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
-	VM_STAT("mmu_shadow_zapped", mmu_shadow_zapped),
-	VM_STAT("mmu_pte_write", mmu_pte_write),
-	VM_STAT("mmu_pde_zapped", mmu_pde_zapped),
-	VM_STAT("mmu_flooded", mmu_flooded),
-	VM_STAT("mmu_recycled", mmu_recycled),
-	VM_STAT("mmu_cache_miss", mmu_cache_miss),
-	VM_STAT("mmu_unsync", mmu_unsync),
-	VM_STAT("remote_tlb_flush", remote_tlb_flush),
-	VM_STAT("largepages", lpages, .mode = 0444),
-	VM_STAT("nx_largepages_splitted", nx_lpage_splits, .mode = 0444),
-	VM_STAT("max_mmu_page_hash_collisions", max_mmu_page_hash_collisions),
+	VCPU_STAT(pf_fixed),
+	VCPU_STAT(pf_guest),
+	VCPU_STAT(tlb_flush),
+	VCPU_STAT(invlpg),
+	VCPU_STAT(exits),
+	VCPU_STAT(io_exits),
+	VCPU_STAT(mmio_exits),
+	VCPU_STAT(signal_exits),
+	VCPU_STAT(irq_window_exits),
+	VCPU_STAT(nmi_window_exits),
+	VCPU_STAT(halt_exits),
+	VCPU_STAT(halt_successful_poll),
+	VCPU_STAT(halt_attempted_poll),
+	VCPU_STAT(halt_poll_invalid),
+	VCPU_STAT(halt_wakeup),
+	VCPU_STAT(hypercalls),
+	VCPU_STAT(request_irq_exits),
+	VCPU_STAT(irq_exits),
+	VCPU_STAT(host_state_reload),
+	VCPU_STAT(fpu_reload),
+	VCPU_STAT(insn_emulation),
+	VCPU_STAT(insn_emulation_fail),
+	VCPU_STAT(irq_injections),
+	VCPU_STAT(nmi_injections),
+	VCPU_STAT(req_event),
+	VCPU_STAT(l1d_flush),
+	VCPU_STAT(halt_poll_success_ns),
+	VCPU_STAT(halt_poll_fail_ns),
+	VM_STAT(mmu_shadow_zapped),
+	VM_STAT(mmu_pte_write),
+	VM_STAT(mmu_pde_zapped),
+	VM_STAT(mmu_flooded),
+	VM_STAT(mmu_recycled),
+	VM_STAT(mmu_cache_miss),
+	VM_STAT(mmu_unsync),
+	VM_STAT(remote_tlb_flush),
+	VM_STAT(lpages, .mode = 0444),
+	VM_STAT(nx_lpage_splits, .mode = 0444),
+	VM_STAT(max_mmu_page_hash_collisions),
 	{ NULL }
 };
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1b65e7204344..1ea297458306 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1162,6 +1162,18 @@ static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
 	return kvm_is_error_hva(hva);
 }
 
+#define VM_STAT_COUNT		(sizeof(struct kvm_vm_stat)/sizeof(ulong))
+#define VCPU_STAT_COUNT		(sizeof(struct kvm_vcpu_stat)/sizeof(u64))
+#define KVM_STATS_NAME_LEN	32
+
+/* Make sure it is synced with fields in struct kvm_vm_stat. */
+extern const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN];
+/* Make sure it is synced with fields in struct kvm_vcpu_stat. */
+extern const char kvm_vcpu_stat_strings[][KVM_STATS_NAME_LEN];
+
+#define VM_STAT_NAME(id)        (kvm_vm_stat_strings[id])
+#define VCPU_STAT_NAME(id)      (kvm_vcpu_stat_strings[id])
+
 enum kvm_stat_kind {
 	KVM_STAT_VM,
 	KVM_STAT_VCPU,
@@ -1182,10 +1194,21 @@ struct kvm_stats_debugfs_item {
 #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
 	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
 
-#define VM_STAT(n, x, ...) 							\
-	{ n, offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__ }
-#define VCPU_STAT(n, x, ...)							\
-	{ n, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__ }
+#define VM_STAT(x, ...)                                                        \
+	{                                                                      \
+		VM_STAT_NAME(offsetof(struct kvm_vm_stat, x)/sizeof(ulong)),   \
+		offsetof(struct kvm, stat.x),                                  \
+		KVM_STAT_VM,                                                   \
+		## __VA_ARGS__                                                 \
+	}
+
+#define VCPU_STAT(x, ...)                                                      \
+	{                                                                      \
+		VCPU_STAT_NAME(offsetof(struct kvm_vcpu_stat, x)/sizeof(u64)), \
+		offsetof(struct kvm_vcpu, stat.x),                             \
+		KVM_STAT_VCPU,                                                 \
+		## __VA_ARGS__                                                 \
+	}
 
 extern struct kvm_stats_debugfs_item debugfs_entries[];
 extern struct dentry *kvm_debugfs_dir;
-- 
2.30.1.766.gb4fecdf3b7-goog

