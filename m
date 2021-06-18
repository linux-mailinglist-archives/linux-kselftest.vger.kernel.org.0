Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C013AC29B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 06:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhFREut (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 00:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhFREup (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 00:50:45 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD21C0611C1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:35 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id u7-20020a6345470000b02902211e79e4c1so5197430pgk.18
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u4rs1lW/MMlkNd7vwO1WjQneTR0+rRMMuK3KAaeks0I=;
        b=qyEy7pY6MM1j2PNSEg3tttk/ZWGlfi80Sq0KdtiJqEQA1wATtT6BN+NASJEuNXx6X2
         /JkWTpwhVcBFZK3R4pFNuFjsVGpFc7XLVdYelqd58eIgXLU5a2uMM5qeKGFuwEeW0R1E
         uUOgJ2q9cW3S4FMui0XO8lrUXwJvrrNAtRlo4dGxnGbiksDHSRr+KRKjBysrP68BJ1+8
         /eyyORo1Z9FbG8IbW5VtSrQ8WY6mrngkmt/dufRa8yDIz3aMTr4+2adEXk04tGDKfD/T
         XLt+/OcwBYdeaCS/eO4XZIMCJlNrrniZzKaDdVxupPdgL+wx8/4Nilzzxoyi+gd5Fx0f
         Nagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u4rs1lW/MMlkNd7vwO1WjQneTR0+rRMMuK3KAaeks0I=;
        b=D+aLMBR46zDp2Mw9wvTQ5WXr9N1eF0dMKZ/6i2NxCENrFSI726gzcrXtVX0FASNfDw
         J4DdqZ7R/Zd+8enZpIbnSi5kTUfMJeFETobtMaAxZhIwG5WYN0IYVbYaMlhkZju16CHE
         M5vkdOuTF2BKhs+IRs0t2ZVhgVhjSXnz8lvOdkZHH64ebAnSKGx3f0vcmOBxBL1XlNnX
         tkyENdeLRQA9YsPWTegGDeJvy4gawAM0mpRujAUOock0aCwmHize2w7vu6ECYbpVyEo/
         nDIS0ev9ndKMAeqcXu4Xe6FnfowndvVeVwZBpqUOICn7vihy/i1UTvOu2830TDx7QBjx
         AFrQ==
X-Gm-Message-State: AOAM531pIH7nX9NpXQdOx1cYtYBMG3TicfRfzT7+iMbyTNc8QraAbjkj
        sebzmOzIGgESzwo4iVT6MVPJrapeEjSzdRTcPQ==
X-Google-Smtp-Source: ABdhPJwoaXP3SPbRNv/UuFeLhGTYhEXszL9/clomn+gEpDjhNo83rsLx58jMbr42OTQYpJLkZ74cR0i0/tRIvXb6xQ==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:90b:19cd:: with SMTP id
 nm13mr20543242pjb.226.1623991714976; Thu, 17 Jun 2021 21:48:34 -0700 (PDT)
Date:   Fri, 18 Jun 2021 04:48:19 +0000
In-Reply-To: <20210618044819.3690166-1-jingzhangos@google.com>
Message-Id: <20210618044819.3690166-8-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210618044819.3690166-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v11 7/7] KVM: stats: Remove code duplication for binary and
 debugfs stats
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

To remove code duplication, use the binary stats descriptors for
debugfs interface for KVM stats. Then we only have one stats
definitions for both binary and debugfs interface.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/kvm/guest.c    |  16 ------
 arch/mips/kvm/mips.c      |  39 --------------
 arch/powerpc/kvm/book3s.c |  33 ------------
 arch/powerpc/kvm/booke.c  |  25 ---------
 arch/s390/kvm/kvm-s390.c  | 108 --------------------------------------
 arch/x86/kvm/x86.c        |  49 +----------------
 include/linux/kvm_host.h  |  43 +++++----------
 include/uapi/linux/kvm.h  |   4 +-
 virt/kvm/kvm_main.c       | 104 ++++++++++++++++++++++++++----------
 9 files changed, 94 insertions(+), 327 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 59cb1cfe5b1e..efc76846b5a0 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -62,22 +62,6 @@ struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
-	VCPU_STAT("hvc_exit_stat", hvc_exit_stat),
-	VCPU_STAT("wfe_exit_stat", wfe_exit_stat),
-	VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
-	VCPU_STAT("mmio_exit_user", mmio_exit_user),
-	VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
-	VCPU_STAT("exits", exits),
-	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
-	{ NULL }
-};
-
 static bool core_reg_offset_is_vreg(u64 off)
 {
 	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c748fa0d1411..24782904d9a2 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -95,45 +95,6 @@ struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
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
-	VCPU_STAT("vz_gpsi", vz_gpsi_exits),
-	VCPU_STAT("vz_gsfc", vz_gsfc_exits),
-	VCPU_STAT("vz_hc", vz_hc_exits),
-	VCPU_STAT("vz_grr", vz_grr_exits),
-	VCPU_STAT("vz_gva", vz_gva_exits),
-	VCPU_STAT("vz_ghfc", vz_ghfc_exits),
-	VCPU_STAT("vz_gpa", vz_gpa_exits),
-	VCPU_STAT("vz_resvd", vz_resvd_exits),
-#ifdef CONFIG_CPU_LOONGSON64
-	VCPU_STAT("vz_cpucfg", vz_cpucfg_exits),
-#endif
-	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
-	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
-	{NULL}
-};
-
 bool kvm_trace_guest_mode_change;
 
 int kvm_guest_mode_change_trace_reg(void)
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 9aa05ac747ca..1eaf28ae43a9 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -98,39 +98,6 @@ struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT("exits", sum_exits),
-	VCPU_STAT("mmio", mmio_exits),
-	VCPU_STAT("sig", signal_exits),
-	VCPU_STAT("sysc", syscall_exits),
-	VCPU_STAT("inst_emu", emulated_inst_exits),
-	VCPU_STAT("dec", dec_exits),
-	VCPU_STAT("ext_intr", ext_intr_exits),
-	VCPU_STAT("queue_intr", queue_intr),
-	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
-	VCPU_STAT("halt_wait_ns", halt_wait_ns),
-	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_successful_wait", halt_successful_wait),
-	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
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
-	{ NULL }
-};
-
 static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
 			unsigned long pending_now, unsigned long old_pending)
 {
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ef348773e89f..ef92c4aeb191 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -89,31 +89,6 @@ struct kvm_stats_header kvm_vcpu_stats_header = {
 			       sizeof(kvm_vcpu_stats_desc),
 };
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
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
-	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
-	VCPU_STAT("doorbell", dbell_exits),
-	VCPU_STAT("guest doorbell", gdbell_exits),
-	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
-	VM_STAT_GENERIC("remote_tlb_flush", remote_tlb_flush),
-	{ NULL }
-};
-
 /* TODO: use vcpu_printf() */
 void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8a9c2b0940cd..bc1d42dcf12d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -184,114 +184,6 @@ struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
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
-	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_no_poll_steal", halt_no_poll_steal),
-	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
-	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
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
-	VCPU_STAT("diag_9c_forward", diagnose_9c_forward),
-	VCPU_STAT("instruction_diag_258", diagnose_258),
-	VCPU_STAT("instruction_diag_308", diagnose_308),
-	VCPU_STAT("instruction_diag_500", diagnose_500),
-	VCPU_STAT("instruction_diag_other", diagnose_other),
-	{ NULL }
-};
-
 /* allow nested virtualization in KVM (if enabled by user space) */
 static int nested;
 module_param(nested, int, S_IRUGO);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 086a1ebcbfbe..c1829e014c43 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -234,7 +234,7 @@ struct _kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_ICOUNTER(VM, mmu_unsync),
 	STATS_DESC_ICOUNTER(VM, lpages),
 	STATS_DESC_ICOUNTER(VM, nx_lpage_splits),
-	STATS_DESC_ICOUNTER(VM, max_mmu_page_hash_collisions)
+	STATS_DESC_PCOUNTER(VM, max_mmu_page_hash_collisions)
 };
 static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
 		sizeof(struct kvm_vm_stat) / sizeof(u64));
@@ -287,53 +287,6 @@ struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-struct kvm_stats_debugfs_item debugfs_entries[] = {
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
-	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
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
-	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
-	VCPU_STAT("nested_run", nested_run),
-	VCPU_STAT("directed_yield_attempted", directed_yield_attempted),
-	VCPU_STAT("directed_yield_successful", directed_yield_successful),
-	VCPU_STAT("guest_mode", guest_mode),
-	VM_STAT("mmu_shadow_zapped", mmu_shadow_zapped),
-	VM_STAT("mmu_pte_write", mmu_pte_write),
-	VM_STAT("mmu_pde_zapped", mmu_pde_zapped),
-	VM_STAT("mmu_flooded", mmu_flooded),
-	VM_STAT("mmu_recycled", mmu_recycled),
-	VM_STAT("mmu_cache_miss", mmu_cache_miss),
-	VM_STAT("mmu_unsync", mmu_unsync),
-	VM_STAT_GENERIC("remote_tlb_flush", remote_tlb_flush),
-	VM_STAT("largepages", lpages, .mode = 0444),
-	VM_STAT("nx_largepages_splitted", nx_lpage_splits, .mode = 0444),
-	VM_STAT("max_mmu_page_hash_collisions", max_mmu_page_hash_collisions),
-	{ NULL }
-};
-
 u64 __read_mostly host_xcr0;
 u64 __read_mostly supported_xcr0;
 EXPORT_SYMBOL_GPL(supported_xcr0);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index dd7709fd2f73..4501a40fd19b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1264,14 +1264,8 @@ enum kvm_stat_kind {
 
 struct kvm_stat_data {
 	struct kvm *kvm;
-	struct kvm_stats_debugfs_item *dbgfs_item;
-};
-
-struct kvm_stats_debugfs_item {
-	const char *name;
-	int offset;
+	struct _kvm_stats_desc *desc;
 	enum kvm_stat_kind kind;
-	int mode;
 };
 
 #define KVM_STATS_NAME_LEN	48
@@ -1280,24 +1274,11 @@ struct _kvm_stats_desc {
 	char name[KVM_STATS_NAME_LEN];
 };
 
-#define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
-	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
-
-#define VM_STAT(n, x, ...)						       \
-	{ n, offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__ }
-#define VCPU_STAT(n, x, ...)						       \
-	{ n, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__ }
-#define VM_STAT_GENERIC(n, x, ...)					       \
-	{ n, offsetof(struct kvm, stat.generic.x), KVM_STAT_VM, ## __VA_ARGS__ }
-#define VCPU_STAT_GENERIC(n, x, ...)					       \
-	{ n, offsetof(struct kvm_vcpu, stat.generic.x),			       \
-	  KVM_STAT_VCPU, ## __VA_ARGS__ }
-
 #define STATS_DESC_COMMON(type, unit, base, exp)			       \
 	.flags = type | unit | base |					       \
-	    BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |		       \
-	    BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |		       \
-	    BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),		       \
+		BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |	       \
+		BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |	       \
+		BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),		       \
 	.exponent = exp,						       \
 	.size = 1
 
@@ -1338,19 +1319,24 @@ struct _kvm_stats_desc {
 	SCOPE##_STATS_DESC(stat, type, unit, base, exp)
 
 #define STATS_DESC_CUMULATIVE(SCOPE, name, unit, base, exponent)	       \
-	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_CUMULATIVE,		       \
-		      unit, base, exponent)
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_CUMULATIVE, unit, base, exponent)
 #define STATS_DESC_INSTANT(SCOPE, name, unit, base, exponent)		       \
-	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_INSTANT, unit, base, exponent)  \
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_INSTANT, unit, base, exponent)
+#define STATS_DESC_PEAK(SCOPE, name, unit, base, exponent)		       \
+	STATS_DESC(SCOPE, name, KVM_STATS_TYPE_PEAK, unit, base, exponent)
 
-/* Cumulative counter */
+/* Cumulative read/write counter */
 #define STATS_DESC_COUNTER(SCOPE, name)					       \
 	STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
 		KVM_STATS_BASE_POW10, 0)
-/* Instantaneous counter */
+/* Instantaneous read only counter */
 #define STATS_DESC_ICOUNTER(SCOPE, name)				       \
 	STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
 		KVM_STATS_BASE_POW10, 0)
+/* Instantaneous read/write counter */
+#define STATS_DESC_PCOUNTER(SCOPE, name)				       \
+	STATS_DESC_PEAK(SCOPE, name, KVM_STATS_UNIT_NONE,		       \
+		KVM_STATS_BASE_POW10, 0)
 
 /* Cumulative clock cycles */
 #define STATS_DESC_CYCLE(SCOPE, name)					       \
@@ -1440,7 +1426,6 @@ struct _kvm_stats_desc {
 	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_poll_success_ns),	       \
 	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_poll_fail_ns)
 
-extern struct kvm_stats_debugfs_item debugfs_entries[];
 extern struct dentry *kvm_debugfs_dir;
 ssize_t kvm_stats_read(char *id, struct kvm_stats_header *header,
 		struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index ab73e905105c..26f77909502b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1920,7 +1920,9 @@ struct kvm_stats_header {
 #define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
 #define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
 #define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
-#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_INSTANT
+/* Peak type is used as read/write instant counters */
+#define KVM_STATS_TYPE_PEAK		(0x2 << KVM_STATS_TYPE_SHIFT)
+#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_PEAK
 
 #define KVM_STATS_UNIT_SHIFT		4
 #define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5f9d566db1c4..221ca7f4cc30 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -115,7 +115,6 @@ static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_running_vcpu);
 struct dentry *kvm_debugfs_dir;
 EXPORT_SYMBOL_GPL(kvm_debugfs_dir);
 
-static int kvm_debugfs_num_entries;
 static const struct file_operations stat_fops_per_vm;
 
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
@@ -860,9 +859,24 @@ static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
 	kvfree(slots);
 }
 
+static umode_t kvm_stats_debugfs_mode(struct _kvm_stats_desc *pdesc)
+{
+	switch (pdesc->desc.flags & KVM_STATS_TYPE_MASK) {
+	case KVM_STATS_TYPE_INSTANT:
+		return 0444;
+	case KVM_STATS_TYPE_CUMULATIVE:
+	case KVM_STATS_TYPE_PEAK:
+	default:
+		return 0644;
+	}
+}
+
+
 static void kvm_destroy_vm_debugfs(struct kvm *kvm)
 {
 	int i;
+	int kvm_debugfs_num_entries = kvm_vm_stats_header.count +
+				      kvm_vcpu_stats_header.count;
 
 	if (!kvm->debugfs_dentry)
 		return;
@@ -880,7 +894,10 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
 {
 	char dir_name[ITOA_MAX_LEN * 2];
 	struct kvm_stat_data *stat_data;
-	struct kvm_stats_debugfs_item *p;
+	struct _kvm_stats_desc *pdesc;
+	int i;
+	int kvm_debugfs_num_entries = kvm_vm_stats_header.count +
+				      kvm_vcpu_stats_header.count;
 
 	if (!debugfs_initialized())
 		return 0;
@@ -894,15 +911,32 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, int fd)
 	if (!kvm->debugfs_stat_data)
 		return -ENOMEM;
 
-	for (p = debugfs_entries; p->name; p++) {
+	for (i = 0; i < kvm_vm_stats_header.count; ++i) {
+		pdesc = &kvm_vm_stats_desc[i];
 		stat_data = kzalloc(sizeof(*stat_data), GFP_KERNEL_ACCOUNT);
 		if (!stat_data)
 			return -ENOMEM;
 
 		stat_data->kvm = kvm;
-		stat_data->dbgfs_item = p;
-		kvm->debugfs_stat_data[p - debugfs_entries] = stat_data;
-		debugfs_create_file(p->name, KVM_DBGFS_GET_MODE(p),
+		stat_data->desc = pdesc;
+		stat_data->kind = KVM_STAT_VM;
+		kvm->debugfs_stat_data[i] = stat_data;
+		debugfs_create_file(pdesc->name, kvm_stats_debugfs_mode(pdesc),
+				    kvm->debugfs_dentry, stat_data,
+				    &stat_fops_per_vm);
+	}
+
+	for (i = 0; i < kvm_vcpu_stats_header.count; ++i) {
+		pdesc = &kvm_vcpu_stats_desc[i];
+		stat_data = kzalloc(sizeof(*stat_data), GFP_KERNEL_ACCOUNT);
+		if (!stat_data)
+			return -ENOMEM;
+
+		stat_data->kvm = kvm;
+		stat_data->desc = pdesc;
+		stat_data->kind = KVM_STAT_VCPU;
+		kvm->debugfs_stat_data[i] = stat_data;
+		debugfs_create_file(pdesc->name, kvm_stats_debugfs_mode(pdesc),
 				    kvm->debugfs_dentry, stat_data,
 				    &stat_fops_per_vm);
 	}
@@ -4901,7 +4935,7 @@ static int kvm_debugfs_open(struct inode *inode, struct file *file,
 		return -ENOENT;
 
 	if (simple_attr_open(inode, file, get,
-		    KVM_DBGFS_GET_MODE(stat_data->dbgfs_item) & 0222
+		    kvm_stats_debugfs_mode(stat_data->desc) & 0222
 		    ? set : NULL,
 		    fmt)) {
 		kvm_put_kvm(stat_data->kvm);
@@ -4924,14 +4958,14 @@ static int kvm_debugfs_release(struct inode *inode, struct file *file)
 
 static int kvm_get_stat_per_vm(struct kvm *kvm, size_t offset, u64 *val)
 {
-	*val = *(u64 *)((void *)kvm + offset);
+	*val = *(u64 *)((void *)(&kvm->stat) + offset);
 
 	return 0;
 }
 
 static int kvm_clear_stat_per_vm(struct kvm *kvm, size_t offset)
 {
-	*(u64 *)((void *)kvm + offset) = 0;
+	*(u64 *)((void *)(&kvm->stat) + offset) = 0;
 
 	return 0;
 }
@@ -4944,7 +4978,7 @@ static int kvm_get_stat_per_vcpu(struct kvm *kvm, size_t offset, u64 *val)
 	*val = 0;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
-		*val += *(u64 *)((void *)vcpu + offset);
+		*val += *(u64 *)((void *)(&vcpu->stat) + offset);
 
 	return 0;
 }
@@ -4955,7 +4989,7 @@ static int kvm_clear_stat_per_vcpu(struct kvm *kvm, size_t offset)
 	struct kvm_vcpu *vcpu;
 
 	kvm_for_each_vcpu(i, vcpu, kvm)
-		*(u64 *)((void *)vcpu + offset) = 0;
+		*(u64 *)((void *)(&vcpu->stat) + offset) = 0;
 
 	return 0;
 }
@@ -4965,14 +4999,14 @@ static int kvm_stat_data_get(void *data, u64 *val)
 	int r = -EFAULT;
 	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
 
-	switch (stat_data->dbgfs_item->kind) {
+	switch (stat_data->kind) {
 	case KVM_STAT_VM:
 		r = kvm_get_stat_per_vm(stat_data->kvm,
-					stat_data->dbgfs_item->offset, val);
+					stat_data->desc->desc.offset, val);
 		break;
 	case KVM_STAT_VCPU:
 		r = kvm_get_stat_per_vcpu(stat_data->kvm,
-					  stat_data->dbgfs_item->offset, val);
+					  stat_data->desc->desc.offset, val);
 		break;
 	}
 
@@ -4987,14 +5021,14 @@ static int kvm_stat_data_clear(void *data, u64 val)
 	if (val)
 		return -EINVAL;
 
-	switch (stat_data->dbgfs_item->kind) {
+	switch (stat_data->kind) {
 	case KVM_STAT_VM:
 		r = kvm_clear_stat_per_vm(stat_data->kvm,
-					  stat_data->dbgfs_item->offset);
+					  stat_data->desc->desc.offset);
 		break;
 	case KVM_STAT_VCPU:
 		r = kvm_clear_stat_per_vcpu(stat_data->kvm,
-					    stat_data->dbgfs_item->offset);
+					    stat_data->desc->desc.offset);
 		break;
 	}
 
@@ -5051,6 +5085,7 @@ static int vm_stat_clear(void *_offset, u64 val)
 }
 
 DEFINE_SIMPLE_ATTRIBUTE(vm_stat_fops, vm_stat_get, vm_stat_clear, "%llu\n");
+DEFINE_SIMPLE_ATTRIBUTE(vm_stat_readonly_fops, vm_stat_get, NULL, "%llu\n");
 
 static int vcpu_stat_get(void *_offset, u64 *val)
 {
@@ -5087,11 +5122,7 @@ static int vcpu_stat_clear(void *_offset, u64 val)
 
 DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, vcpu_stat_clear,
 			"%llu\n");
-
-static const struct file_operations *stat_fops[] = {
-	[KVM_STAT_VCPU] = &vcpu_stat_fops,
-	[KVM_STAT_VM]   = &vm_stat_fops,
-};
+DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_readonly_fops, vcpu_stat_get, NULL, "%llu\n");
 
 static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 {
@@ -5145,15 +5176,32 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 
 static void kvm_init_debug(void)
 {
-	struct kvm_stats_debugfs_item *p;
+	const struct file_operations *fops;
+	struct _kvm_stats_desc *pdesc;
+	int i;
 
 	kvm_debugfs_dir = debugfs_create_dir("kvm", NULL);
 
-	kvm_debugfs_num_entries = 0;
-	for (p = debugfs_entries; p->name; ++p, kvm_debugfs_num_entries++) {
-		debugfs_create_file(p->name, KVM_DBGFS_GET_MODE(p),
-				    kvm_debugfs_dir, (void *)(long)p->offset,
-				    stat_fops[p->kind]);
+	for (i = 0; i < kvm_vm_stats_header.count; ++i) {
+		pdesc = &kvm_vm_stats_desc[i];
+		if (kvm_stats_debugfs_mode(pdesc) & 0222)
+			fops = &vm_stat_fops;
+		else
+			fops = &vm_stat_readonly_fops;
+		debugfs_create_file(pdesc->name, kvm_stats_debugfs_mode(pdesc),
+				kvm_debugfs_dir,
+				(void *)(long)pdesc->desc.offset, fops);
+	}
+
+	for (i = 0; i < kvm_vcpu_stats_header.count; ++i) {
+		pdesc = &kvm_vcpu_stats_desc[i];
+		if (kvm_stats_debugfs_mode(pdesc) & 0222)
+			fops = &vcpu_stat_fops;
+		else
+			fops = &vcpu_stat_readonly_fops;
+		debugfs_create_file(pdesc->name, kvm_stats_debugfs_mode(pdesc),
+				kvm_debugfs_dir,
+				(void *)(long)pdesc->desc.offset, fops);
 	}
 }
 
-- 
2.32.0.288.g62a8d224e6-goog

