Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E583A4253
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFKMt1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 08:49:27 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:50757 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhFKMt1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 08:49:27 -0400
Received: by mail-pj1-f73.google.com with SMTP id s5-20020a17090a7645b029016d923cccbeso5457688pjl.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jun 2021 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=85ilytRLIhEUO5aCekv1RFuFb0316JMy6JkclvbBJ0M=;
        b=gxxfml5+ZTCAsRcT+kkCtBrBNPYNUL5lcg/Z/btp5feVk4z98C1boIoByw4CzEzSOc
         d8eaDCgyrW8Z5bso1a4FALToZ0Ia8aiA5QN152iL3La2+hJxxLOcE8+f6h+ct69cUqbm
         WYMwUPEpt8++fPV1XezRAW0VBvnw2/ob19GvJ9jWZuoPYIm8KtUf8W3hgnhaD9+piOjh
         WfhPgbzGbosWwb1zhd8vE5FqLdoWnu/LA8ThbJPKDyDpLTjwl/xaL9KEg/jUctVgxGK/
         0SHYSPfxWsXidjttBeg5zzkUHcsqPkU58UJT6O+W/7Kdp4l792FB1qoq8W6q5o4qZBXe
         xygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=85ilytRLIhEUO5aCekv1RFuFb0316JMy6JkclvbBJ0M=;
        b=CUoK6PxsJO/yN1cUOHfoFwL6zAS5/ZiciIRpSJiG2BcWG/KbDhrvEq53fQefIzIGtK
         YQWekLb/c8QpZDJcqJrI9gY2FT0LxFYqIZFrB6zMxnPJ32g7OrPbOkUzaivKfc+a+9/v
         DUaiuMr8qbDTYSZJC2EvPih2zlXGkvFG8c0zG/fnuIbwpqEYsuHN1l1eYbmiMRR4I6s/
         bG7nsB2YUkaDzxh64XrBbsIeaIhtkeZtga9s6e9Mqr6KzRU2NIv0Qnz0084AJ+ZVAIbv
         JeISfVPVN+P3zaJ09ymziY82mKCZin63jU6RZVfNdMj4TSSRFReXvLmpnrh+eLxlkj4s
         xEXg==
X-Gm-Message-State: AOAM531zvPn+OD45zOyQc+bMj0CkQmFnk2Omz1y9W9li3QKaLIxuIdPk
        Q6qvjy0T67w65819C4osbfqqkpXJQASGXzXjpg==
X-Google-Smtp-Source: ABdhPJzB+A5H12UISS6r9Us8ZLlLcqT5NMIRt7E7W3jpE+1YQEB5pXIBIo4uIwgKUGfKfReuLkEpzbgK24chDk/rBw==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:902:da91:b029:116:864e:893b with
 SMTP id j17-20020a170902da91b0290116864e893bmr3734967plx.26.1623415589060;
 Fri, 11 Jun 2021 05:46:29 -0700 (PDT)
Date:   Fri, 11 Jun 2021 12:46:21 +0000
In-Reply-To: <20210611124624.1404010-1-jingzhangos@google.com>
Message-Id: <20210611124624.1404010-2-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210611124624.1404010-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v8 1/4] KVM: stats: Separate generic stats from architecture
 specific ones
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Put all generic statistics in a separate structure to ease
statistics handling for the incoming new statistics API.

No functional change intended.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/include/asm/kvm_host.h   |  9 ++-------
 arch/arm64/kvm/guest.c              | 12 ++++++------
 arch/mips/include/asm/kvm_host.h    |  9 ++-------
 arch/mips/kvm/mips.c                | 12 ++++++------
 arch/powerpc/include/asm/kvm_host.h |  9 ++-------
 arch/powerpc/kvm/book3s.c           | 12 ++++++------
 arch/powerpc/kvm/book3s_hv.c        | 12 ++++++------
 arch/powerpc/kvm/book3s_pr.c        |  2 +-
 arch/powerpc/kvm/book3s_pr_papr.c   |  2 +-
 arch/powerpc/kvm/booke.c            | 14 +++++++-------
 arch/s390/include/asm/kvm_host.h    |  9 ++-------
 arch/s390/kvm/kvm-s390.c            | 12 ++++++------
 arch/x86/include/asm/kvm_host.h     |  9 ++-------
 arch/x86/kvm/x86.c                  | 14 +++++++-------
 include/linux/kvm_host.h            |  9 +++++++--
 include/linux/kvm_types.h           | 12 ++++++++++++
 virt/kvm/kvm_main.c                 | 14 +++++++-------
 17 files changed, 82 insertions(+), 90 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d56f365b38a8..5a2c82f63baa 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -556,16 +556,11 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
 }
 
 struct kvm_vm_stat {
-	u64 remote_tlb_flush;
+	struct kvm_vm_stat_generic generic;
 };
 
 struct kvm_vcpu_stat {
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
-	u64 halt_poll_invalid;
-	u64 halt_wakeup;
+	struct kvm_vcpu_stat_generic generic;
 	u64 hvc_exit_stat;
 	u64 wfe_exit_stat;
 	u64 wfi_exit_stat;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 5cb4a1cd5603..4962331d01e6 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -29,18 +29,18 @@
 #include "trace.h"
 
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
+	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
 	VCPU_STAT("hvc_exit_stat", hvc_exit_stat),
 	VCPU_STAT("wfe_exit_stat", wfe_exit_stat),
 	VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
 	VCPU_STAT("mmio_exit_user", mmio_exit_user),
 	VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
 	VCPU_STAT("exits", exits),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
 	{ NULL }
 };
 
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 4245c082095f..696f6b009377 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -109,10 +109,11 @@ static inline bool kvm_is_error_hva(unsigned long addr)
 }
 
 struct kvm_vm_stat {
-	u64 remote_tlb_flush;
+	struct kvm_vm_stat_generic generic;
 };
 
 struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_generic generic;
 	u64 wait_exits;
 	u64 cache_exits;
 	u64 signal_exits;
@@ -142,12 +143,6 @@ struct kvm_vcpu_stat {
 #ifdef CONFIG_CPU_LOONGSON64
 	u64 vz_cpucfg_exits;
 #endif
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
-	u64 halt_poll_invalid;
-	u64 halt_wakeup;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 4d4af97dcc88..ff205b35719b 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -68,12 +68,12 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 #ifdef CONFIG_CPU_LOONGSON64
 	VCPU_STAT("vz_cpucfg", vz_cpucfg_exits),
 #endif
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
+	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
 	{NULL}
 };
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ae3d4af61b66..80cfe4f42894 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -81,12 +81,13 @@ struct kvmppc_book3s_shadow_vcpu;
 struct kvm_nested_guest;
 
 struct kvm_vm_stat {
-	u64 remote_tlb_flush;
+	struct kvm_vm_stat_generic generic;
 	u64 num_2M_pages;
 	u64 num_1G_pages;
 };
 
 struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_generic generic;
 	u64 sum_exits;
 	u64 mmio_exits;
 	u64 signal_exits;
@@ -102,14 +103,8 @@ struct kvm_vcpu_stat {
 	u64 emulated_inst_exits;
 	u64 dec_exits;
 	u64 ext_intr_exits;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
 	u64 halt_wait_ns;
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
 	u64 halt_successful_wait;
-	u64 halt_poll_invalid;
-	u64 halt_wakeup;
 	u64 dbell_exits;
 	u64 gdbell_exits;
 	u64 ld;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 2b691f4d1f26..92cdb4175945 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -47,14 +47,14 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("dec", dec_exits),
 	VCPU_STAT("ext_intr", ext_intr_exits),
 	VCPU_STAT("queue_intr", queue_intr),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
 	VCPU_STAT("halt_wait_ns", halt_wait_ns),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
 	VCPU_STAT("halt_successful_wait", halt_successful_wait),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
+	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
 	VCPU_STAT("pf_storage", pf_storage),
 	VCPU_STAT("sp_storage", sp_storage),
 	VCPU_STAT("pf_instruc", pf_instruc),
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7360350e66ff..b3506c35a46b 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -236,7 +236,7 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 
 	waitp = kvm_arch_vcpu_get_wait(vcpu);
 	if (rcuwait_wake_up(waitp))
-		++vcpu->stat.halt_wakeup;
+		++vcpu->stat.generic.halt_wakeup;
 
 	cpu = READ_ONCE(vcpu->arch.thread_cpu);
 	if (cpu >= 0 && kvmppc_ipi_thread(cpu))
@@ -3925,7 +3925,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	cur = start_poll = ktime_get();
 	if (vc->halt_poll_ns) {
 		ktime_t stop = ktime_add_ns(start_poll, vc->halt_poll_ns);
-		++vc->runner->stat.halt_attempted_poll;
+		++vc->runner->stat.generic.halt_attempted_poll;
 
 		vc->vcore_state = VCORE_POLLING;
 		spin_unlock(&vc->lock);
@@ -3942,7 +3942,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 		vc->vcore_state = VCORE_INACTIVE;
 
 		if (!do_sleep) {
-			++vc->runner->stat.halt_successful_poll;
+			++vc->runner->stat.generic.halt_successful_poll;
 			goto out;
 		}
 	}
@@ -3954,7 +3954,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 		do_sleep = 0;
 		/* If we polled, count this as a successful poll */
 		if (vc->halt_poll_ns)
-			++vc->runner->stat.halt_successful_poll;
+			++vc->runner->stat.generic.halt_successful_poll;
 		goto out;
 	}
 
@@ -3981,13 +3981,13 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 			ktime_to_ns(cur) - ktime_to_ns(start_wait);
 		/* Attribute failed poll time */
 		if (vc->halt_poll_ns)
-			vc->runner->stat.halt_poll_fail_ns +=
+			vc->runner->stat.generic.halt_poll_fail_ns +=
 				ktime_to_ns(start_wait) -
 				ktime_to_ns(start_poll);
 	} else {
 		/* Attribute successful poll time */
 		if (vc->halt_poll_ns)
-			vc->runner->stat.halt_poll_success_ns +=
+			vc->runner->stat.generic.halt_poll_success_ns +=
 				ktime_to_ns(cur) -
 				ktime_to_ns(start_poll);
 	}
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index d7733b07f489..71bcb0140461 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -493,7 +493,7 @@ static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
 		if (!vcpu->arch.pending_exceptions) {
 			kvm_vcpu_block(vcpu);
 			kvm_clear_request(KVM_REQ_UNHALT, vcpu);
-			vcpu->stat.halt_wakeup++;
+			vcpu->stat.generic.halt_wakeup++;
 
 			/* Unset POW bit after we woke up */
 			msr &= ~MSR_POW;
diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
index 031c8015864a..ac14239f3424 100644
--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -378,7 +378,7 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
 		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
 		kvm_vcpu_block(vcpu);
 		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
-		vcpu->stat.halt_wakeup++;
+		vcpu->stat.generic.halt_wakeup++;
 		return EMULATE_DONE;
 	case H_LOGICAL_CI_LOAD:
 		return kvmppc_h_pr_logical_ci_load(vcpu);
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 7d5fe43f85c4..80d3b39aa7ac 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -49,15 +49,15 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("inst_emu", emulated_inst_exits),
 	VCPU_STAT("dec", dec_exits),
 	VCPU_STAT("ext_intr", ext_intr_exits),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
+	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
 	VCPU_STAT("doorbell", dbell_exits),
 	VCPU_STAT("guest doorbell", gdbell_exits),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
-	VM_STAT("remote_tlb_flush", remote_tlb_flush),
+	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
+	VM_STAT_GENERIC("remote_tlb_flush", remote_tlb_flush),
 	{ NULL }
 };
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8925f3969478..9b4473f76e56 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -361,6 +361,7 @@ struct sie_page {
 };
 
 struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_generic generic;
 	u64 exit_userspace;
 	u64 exit_null;
 	u64 exit_external_request;
@@ -370,13 +371,7 @@ struct kvm_vcpu_stat {
 	u64 exit_validity;
 	u64 exit_instruction;
 	u64 exit_pei;
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
-	u64 halt_poll_invalid;
 	u64 halt_no_poll_steal;
-	u64 halt_wakeup;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
 	u64 instruction_lctl;
 	u64 instruction_lctlg;
 	u64 instruction_stctl;
@@ -755,12 +750,12 @@ struct kvm_vcpu_arch {
 };
 
 struct kvm_vm_stat {
+	struct kvm_vm_stat_generic generic;
 	u64 inject_io;
 	u64 inject_float_mchk;
 	u64 inject_pfault_done;
 	u64 inject_service_signal;
 	u64 inject_virtio;
-	u64 remote_tlb_flush;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1296fc10f80c..e8bc7cd06794 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -72,13 +72,13 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("exit_program_interruption", exit_program_interruption),
 	VCPU_STAT("exit_instr_and_program_int", exit_instr_and_program),
 	VCPU_STAT("exit_operation_exception", exit_operation_exception),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
 	VCPU_STAT("halt_no_poll_steal", halt_no_poll_steal),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
+	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
 	VCPU_STAT("instruction_lctlg", instruction_lctlg),
 	VCPU_STAT("instruction_lctl", instruction_lctl),
 	VCPU_STAT("instruction_stctl", instruction_stctl),
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 94a60998926e..c714d5d3131a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1165,6 +1165,7 @@ struct kvm_arch {
 };
 
 struct kvm_vm_stat {
+	struct kvm_vm_stat_generic generic;
 	u64 mmu_shadow_zapped;
 	u64 mmu_pte_write;
 	u64 mmu_pde_zapped;
@@ -1172,13 +1173,13 @@ struct kvm_vm_stat {
 	u64 mmu_recycled;
 	u64 mmu_cache_miss;
 	u64 mmu_unsync;
-	u64 remote_tlb_flush;
 	u64 lpages;
 	u64 nx_lpage_splits;
 	u64 max_mmu_page_hash_collisions;
 };
 
 struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_generic generic;
 	u64 pf_fixed;
 	u64 pf_guest;
 	u64 tlb_flush;
@@ -1192,10 +1193,6 @@ struct kvm_vcpu_stat {
 	u64 nmi_window_exits;
 	u64 l1d_flush;
 	u64 halt_exits;
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
-	u64 halt_poll_invalid;
-	u64 halt_wakeup;
 	u64 request_irq_exits;
 	u64 irq_exits;
 	u64 host_state_reload;
@@ -1206,8 +1203,6 @@ struct kvm_vcpu_stat {
 	u64 irq_injections;
 	u64 nmi_injections;
 	u64 req_event;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
 	u64 nested_run;
 	u64 directed_yield_attempted;
 	u64 directed_yield_successful;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 20c7a100e3bb..df267b6b8cb7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -233,10 +233,10 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("irq_window", irq_window_exits),
 	VCPU_STAT("nmi_window", nmi_window_exits),
 	VCPU_STAT("halt_exits", halt_exits),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
+	VCPU_STAT_GENERIC("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_GENERIC("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_GENERIC("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_GENERIC("halt_wakeup", halt_wakeup),
 	VCPU_STAT("hypercalls", hypercalls),
 	VCPU_STAT("request_irq", request_irq_exits),
 	VCPU_STAT("irq_exits", irq_exits),
@@ -248,8 +248,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("nmi_injections", nmi_injections),
 	VCPU_STAT("req_event", req_event),
 	VCPU_STAT("l1d_flush", l1d_flush),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_GENERIC("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_GENERIC("halt_poll_fail_ns", halt_poll_fail_ns),
 	VCPU_STAT("nested_run", nested_run),
 	VCPU_STAT("directed_yield_attempted", directed_yield_attempted),
 	VCPU_STAT("directed_yield_successful", directed_yield_successful),
@@ -261,7 +261,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VM_STAT("mmu_recycled", mmu_recycled),
 	VM_STAT("mmu_cache_miss", mmu_cache_miss),
 	VM_STAT("mmu_unsync", mmu_unsync),
-	VM_STAT("remote_tlb_flush", remote_tlb_flush),
+	VM_STAT_GENERIC("remote_tlb_flush", remote_tlb_flush),
 	VM_STAT("largepages", lpages, .mode = 0444),
 	VM_STAT("nx_largepages_splitted", nx_lpage_splits, .mode = 0444),
 	VM_STAT("max_mmu_page_hash_collisions", max_mmu_page_hash_collisions),
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 37cbb56ccd09..5a31e0696360 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1275,10 +1275,15 @@ struct kvm_stats_debugfs_item {
 #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
 	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
 
-#define VM_STAT(n, x, ...) 							\
+#define VM_STAT(n, x, ...)						       \
 	{ n, offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__ }
-#define VCPU_STAT(n, x, ...)							\
+#define VCPU_STAT(n, x, ...)						       \
 	{ n, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__ }
+#define VM_STAT_GENERIC(n, x, ...)					       \
+	{ n, offsetof(struct kvm, stat.generic.x), KVM_STAT_VM, ## __VA_ARGS__ }
+#define VCPU_STAT_GENERIC(n, x, ...)					       \
+	{ n, offsetof(struct kvm_vcpu, stat.generic.x),			       \
+	  KVM_STAT_VCPU, ## __VA_ARGS__ }
 
 extern struct kvm_stats_debugfs_item debugfs_entries[];
 extern struct dentry *kvm_debugfs_dir;
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a7580f69dda0..48db778291b7 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -76,5 +76,17 @@ struct kvm_mmu_memory_cache {
 };
 #endif
 
+struct kvm_vm_stat_generic {
+	u64 remote_tlb_flush;
+};
+
+struct kvm_vcpu_stat_generic {
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 halt_poll_success_ns;
+	u64 halt_poll_fail_ns;
+};
 
 #endif /* __KVM_TYPES_H__ */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ed4d1581d502..cec986487b30 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -332,7 +332,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 	 */
 	if (!kvm_arch_flush_remote_tlb(kvm)
 	    || kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
-		++kvm->stat.remote_tlb_flush;
+		++kvm->stat.generic.remote_tlb_flush;
 	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
 }
 EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
@@ -3029,9 +3029,9 @@ static inline void
 update_halt_poll_stats(struct kvm_vcpu *vcpu, u64 poll_ns, bool waited)
 {
 	if (waited)
-		vcpu->stat.halt_poll_fail_ns += poll_ns;
+		vcpu->stat.generic.halt_poll_fail_ns += poll_ns;
 	else
-		vcpu->stat.halt_poll_success_ns += poll_ns;
+		vcpu->stat.generic.halt_poll_success_ns += poll_ns;
 }
 
 /*
@@ -3049,16 +3049,16 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	if (vcpu->halt_poll_ns && !kvm_arch_no_poll(vcpu)) {
 		ktime_t stop = ktime_add_ns(ktime_get(), vcpu->halt_poll_ns);
 
-		++vcpu->stat.halt_attempted_poll;
+		++vcpu->stat.generic.halt_attempted_poll;
 		do {
 			/*
 			 * This sets KVM_REQ_UNHALT if an interrupt
 			 * arrives.
 			 */
 			if (kvm_vcpu_check_block(vcpu) < 0) {
-				++vcpu->stat.halt_successful_poll;
+				++vcpu->stat.generic.halt_successful_poll;
 				if (!vcpu_valid_wakeup(vcpu))
-					++vcpu->stat.halt_poll_invalid;
+					++vcpu->stat.generic.halt_poll_invalid;
 				goto out;
 			}
 			poll_end = cur = ktime_get();
@@ -3115,7 +3115,7 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 	waitp = kvm_arch_vcpu_get_wait(vcpu);
 	if (rcuwait_wake_up(waitp)) {
 		WRITE_ONCE(vcpu->ready, true);
-		++vcpu->stat.halt_wakeup;
+		++vcpu->stat.generic.halt_wakeup;
 		return true;
 	}
 
-- 
2.32.0.272.g935e593368-goog

