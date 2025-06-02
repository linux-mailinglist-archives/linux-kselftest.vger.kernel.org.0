Return-Path: <linux-kselftest+bounces-34162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6B8ACBBAE
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5975C173F65
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92548231852;
	Mon,  2 Jun 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idBaaChr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7322F384
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892553; cv=none; b=AHVEik/rYToJ3NNk/Xk+QEbeMVgU5vqpzkLDppW9kg9O87vNIxKSozJ4HcXiaAvinu4yQprzh6Xbc5LaWRm3a8wfkXv6VxnQPoRwa7+TOcn3Qv7vLjcbY4AW7GcjSWl5XdkvJNS1wSlMtBTrd54Bld7dh/MVQSScy+ZxPw8cNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892553; c=relaxed/simple;
	bh=Bwq4jBtGO6rJNu1lehBJIit1fChtJKTke3gbuOKUag4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b6T08BRno+qo6zvRJVAPLjwq3wwZ3aJ1e6m+aPIttWXPiF/2+r1vadgcxGuZO9Kw/vzMMkKHwxntO8rhyJ83KHrmYiz25TR0WkPd/+S8OBVhNoNW4yGmtOCfq0B68z+q3Y1nlCJNYYsfBBSYa2WJVWE+AZnziOzn/hu8G9i7/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idBaaChr; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86d122107a9so223385339f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892547; x=1749497347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zoUuW8MUOrKH78JI9d8xFBlkAyF1avhcSa2sdvpTDE=;
        b=idBaaChrNvXPazfDtUN0g1fUwhTDZDuTMIRAb+ONA3kfka+D0mQ+9jERJVWDcSRK3i
         Ik7VDJR3XwG73hUNejmQFDU/H32PEtsX5d2zVWALcCVZLN5mnowmOk90RUoEtOlxl72e
         qLnkGnHzc0B61+a5bpDzkBy8V3etChXKcHKZp0Xu2uZZ/xdfIyTCR76TVjhYt+plJJqT
         UKUevstyeJpNZQM8N2is3fUE7A+On+AXIvslFGaI8gOJgkwaYgKPXTve5V7qDjVsMqJZ
         4JncNTDKDnRbT7AUolKY80Qx9Hnd5oKa7tLp6SMvHyCQxXMJOYaxJQ7jqVIWrCsqp6IN
         UenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892547; x=1749497347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zoUuW8MUOrKH78JI9d8xFBlkAyF1avhcSa2sdvpTDE=;
        b=lv1xGwdS8VUXAhdrXp9AwieIebyCdHuBPaXeZy7UGgYhgYFMAq8oxGTbgUzQTqC8vk
         9Dhp6RyTVoBXTp253Rvl7fayEquHUNVH2S/kF6ZBkQZB6FHFMBppEAozW0yt/g6DkajO
         9sYJYBMzuVDyJHse73V4Oe5wXTJwvA2NmAnrrkVVaZz/s3IBVDNDswk+sbuSqf/rEOoJ
         tZ1D1EgkDbQQwH9jyGmbTrJ2sTzOYrtGiwlbTj4NE9buBdo5mKZzYxpTU0+UMyUTa+r7
         PmuqhHx2UM9JUKkCjeBlNbN4FQH+DInOUcpSjKNRW3ijY5jhqjYmXaXHRTdMgqYirCrD
         /YAA==
X-Forwarded-Encrypted: i=1; AJvYcCXStXuAlOZ7NxplH2zSGouUp2YWVHz8Ins1t30gjJzz8Tz7Pjm+YPdHc/2s0GeiBETSA0TiI8GYfobgwOesVhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxke3o/KotGkuysHEUPZMMmFxnmtjsp19GTGqyDWpMxp8w70B1r
	ae9z5bJJH9VgZg1ICtQGhoMKfvydhVu9766BfY4juKwxVRJTPSv/ug0rtDcG2e/nkdTGK9Pavx/
	Ewai3eSmOeltPfnaYQcYzP2qnDg==
X-Google-Smtp-Source: AGHT+IGwp++K9bYUB9A3dAnUT3ZJdSuEOT5EY3KXma39JRYsyLuBt4tvoJnwGqdqyMUlHwe7mrLxzz2cIxBSsNLN8g==
X-Received: from ilsx9.prod.google.com ([2002:a05:6e02:749:b0:3dd:a3a9:42af])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:184e:b0:3dc:7c5d:6372 with SMTP id e9e14a558f8ab-3dd9c9ae2abmr132483545ab.7.1748892546821;
 Mon, 02 Jun 2025 12:29:06 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:54 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-10-coltonlewis@google.com>
Subject: [PATCH 09/17] KVM: arm64: Set up FGT for Partitioned PMU
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to gain a real performance benefit from partitioning the PMU,
utilize fine grain traps (FEAT_FGT and FEAT_FGT2) to avoid trapping
common PMU register accesses by the guest to remove that overhead.

There should be no information leaks between guests as all these
registers are context switched by a later patch in this series.

Untrapped:
* PMCR_EL0
* PMUSERENR_EL0
* PMSELR_EL0
* PMCCNTR_EL0
* PMINTEN_EL0
* PMEVCNTRn_EL0
* PMICNTR_EL0

Trapped:
* PMOVS_EL0
* PMEVTYPERn_EL0
* PMICFILTR_EL0
* PMCCFILTR_EL0

PMOVS remains trapped so KVM can track overflow IRQs that will need to
be injected into the guest.

PMEVTYPERn remains trapped so KVM can limit which events guests can
count, such as disallowing counting at EL2. PMCCFILTR and PMCIFILTR
are the same

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_host.h       | 11 +++++
 arch/arm64/kvm/debug.c                  |  5 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h | 64 +++++++++++++++++++++++--
 arch/arm64/kvm/pmu-part.c               | 14 ++++++
 4 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3482d7602a5b..4ea045098bfa 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1703,6 +1703,12 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
 			    struct kvm_device_attr *attr);
 int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);
 
+bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
+
+#if defined(__KVM_NVHE_HYPERVISOR__)
+#define kvm_vcpu_pmu_is_partitioned(_) false
+#endif
+
 struct kvm_pmu_events *kvm_get_pmu_events(void);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
@@ -1819,6 +1825,11 @@ static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int id
 
 static inline void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu) {}
 
+static inline bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
 #endif
 
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 41746a498a45..cbe36825e41f 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -42,13 +42,14 @@ static void kvm_arm_setup_mdcr_el2(struct kvm_vcpu *vcpu)
 	 */
 	vcpu->arch.mdcr_el2 = FIELD_PREP(MDCR_EL2_HPMN, hpmn);
 	vcpu->arch.mdcr_el2 |= (MDCR_EL2_HPMD |
-				MDCR_EL2_TPM |
 				MDCR_EL2_TPMS |
 				MDCR_EL2_TTRF |
-				MDCR_EL2_TPMCR |
 				MDCR_EL2_TDRA |
 				MDCR_EL2_TDOSA);
 
+	if (!kvm_vcpu_pmu_is_partitioned(vcpu))
+		vcpu->arch.mdcr_el2 |= MDCR_EL2_TPM | MDCR_EL2_TPMCR;
+
 	/* Is the VM being debugged by userspace? */
 	if (vcpu->guest_debug)
 		/* Route all software debug exceptions to EL2 */
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index d407e716df1b..c3c34a471ace 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -133,6 +133,10 @@ static inline void __activate_traps_fpsimd32(struct kvm_vcpu *vcpu)
 		case HDFGWTR_EL2:					\
 			id = HDFGRTR_GROUP;				\
 			break;						\
+		case HDFGRTR2_EL2:					\
+		case HDFGWTR2_EL2:					\
+			id = HDFGRTR2_GROUP;				\
+			break;						\
 		case HAFGRTR_EL2:					\
 			id = HAFGRTR_GROUP;				\
 			break;						\
@@ -143,10 +147,6 @@ static inline void __activate_traps_fpsimd32(struct kvm_vcpu *vcpu)
 		case HFGITR2_EL2:					\
 			id = HFGITR2_GROUP;				\
 			break;						\
-		case HDFGRTR2_EL2:					\
-		case HDFGWTR2_EL2:					\
-			id = HDFGRTR2_GROUP;				\
-			break;						\
 		default:						\
 			BUILD_BUG_ON(1);				\
 		}							\
@@ -191,6 +191,59 @@ static inline bool cpu_has_amu(void)
                ID_AA64PFR0_EL1_AMU_SHIFT);
 }
 
+/**
+ * __activate_pmu_fgt() - Activate fine grain traps for partitioned PMU
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Clear the most commonly accessed registers for a partitioned
+ * PMU. Trap the rest.
+ */
+static inline void __activate_pmu_fgt(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
+	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
+	u64 set;
+	u64 clr;
+
+	set = HDFGRTR_EL2_PMOVS
+		| HDFGRTR_EL2_PMCCFILTR_EL0
+		| HDFGRTR_EL2_PMEVTYPERn_EL0;
+	clr = HDFGRTR_EL2_PMUSERENR_EL0
+		| HDFGRTR_EL2_PMSELR_EL0
+		| HDFGRTR_EL2_PMINTEN
+		| HDFGRTR_EL2_PMCNTEN
+		| HDFGRTR_EL2_PMCCNTR_EL0
+		| HDFGRTR_EL2_PMEVCNTRn_EL0;
+
+	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGRTR_EL2, clr, set);
+
+	set = HDFGWTR_EL2_PMOVS
+		| HDFGWTR_EL2_PMCCFILTR_EL0
+		| HDFGWTR_EL2_PMEVTYPERn_EL0;
+	clr = HDFGWTR_EL2_PMUSERENR_EL0
+		| HDFGWTR_EL2_PMCR_EL0
+		| HDFGWTR_EL2_PMSELR_EL0
+		| HDFGWTR_EL2_PMINTEN
+		| HDFGWTR_EL2_PMCNTEN
+		| HDFGWTR_EL2_PMCCNTR_EL0
+		| HDFGWTR_EL2_PMEVCNTRn_EL0;
+
+	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGWTR_EL2, clr, set);
+
+	if (!cpus_have_final_cap(ARM64_HAS_FGT2))
+		return;
+
+	set = HDFGRTR2_EL2_nPMICFILTR_EL0;
+	clr = HDFGRTR2_EL2_nPMICNTR_EL0;
+
+	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGRTR2_EL2, clr, set);
+
+	set = HDFGWTR2_EL2_nPMICFILTR_EL0;
+	clr = HDFGWTR2_EL2_nPMICNTR_EL0;
+
+	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGWTR2_EL2, clr, set);
+}
+
 static inline void __activate_traps_hfgxtr(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
@@ -210,6 +263,9 @@ static inline void __activate_traps_hfgxtr(struct kvm_vcpu *vcpu)
 	if (cpu_has_amu())
 		update_fgt_traps(hctxt, vcpu, kvm, HAFGRTR_EL2);
 
+	if (kvm_vcpu_pmu_is_partitioned(vcpu))
+		__activate_pmu_fgt(vcpu);
+
 	if (!cpus_have_final_cap(ARM64_HAS_FGT2))
 	    return;
 
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 33eeaa8faf7f..179a4144cfd0 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -131,6 +131,20 @@ bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
 	return pmu->hpmn < *host_data_ptr(nr_event_counters);
 }
 
+/**
+ * kvm_vcpu_pmu_is_partitioned() - Determine if given VCPU has a partitioned PMU
+ * @vcpu: Pointer to kvm_vcpu struct
+ *
+ * Determine if given VCPU has a partitioned PMU by extracting that
+ * field and passing it to :c:func:`kvm_pmu_is_partitioned`
+ *
+ * Return: True if the VCPU PMU is partitioned, false otherwise
+ */
+bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
+{
+	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu);
+}
+
 /**
  * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved counters
  * @pmu: Pointer to arm_pmu struct
-- 
2.49.0.1204.g71687c7c1d-goog


