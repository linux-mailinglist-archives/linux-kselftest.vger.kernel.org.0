Return-Path: <linux-kselftest+bounces-35480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BB9AE2527
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF841890D2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EB2254845;
	Fri, 20 Jun 2025 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frohF7Fe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8362475C2
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457933; cv=none; b=nmNyBc9aoJR4yCzrLWiAiHZ5tSXlazYXsKtRXVoPglfEZ3ZFVYNodU/shH4IODnI4xBE6jY31zBXHWS7TtVOdnhFsViu7Rwsks3R+2JujtFOkkIs8cDIjb3YH9/nGxF4ePzTPM5vBjAixTbg8Rt5LLvFFIBEDdjm+fwj6c0eOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457933; c=relaxed/simple;
	bh=zsVUBb1ubvHzGav8+UqWMIjyiqxRosRbYVfDNovbPns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hyyj2bKSv8QGaRB2h5mb5dCEZwQ2II/L2beApjRMjz2n6i8fLxLb+w9cU/aIx54oiTQVoR1YF4A6PVAFwb0lQGeAsQ30hFcMnWI2NG0ZPl6pPJU53X305CI6hvP6TLMHKGlrZ/PuVz+1GN9H9zFFPPdoLdPTfhaJHgPsunPJQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frohF7Fe; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2d9e7fbfedaso2503770fac.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457929; x=1751062729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=srRRaeOIs8QqP+SAheIX06PoynQsP08aWn4E9T2+MS8=;
        b=frohF7Fe/U5KhIy4Oy/SqwZXLawHlPWNYmJ3nk1m/GS0/e35A3r/BXxx8BN/LaFPbM
         H3ASZ+IkUE/SsGi7TUPWLUdrjEuDSi4xBnv89iBEocfDqXjXTyddzElTwLOAKEbBbNEL
         8i6Riv79+w+8sWSxsCa+ofOmtWZvPbiNJobybqRc06ci0uGVkRLFY43tHd8iWzPwlLbz
         h5TMSn3CHfIqr+3GavDYA0XZtzhUTLwox7f+RHLlvSABC2ccBn+dEiKpj3TkXDZ8JL/d
         2sLYp7Y9tVBVtzrm/zHsuIW/rpw/ZmTCA9qepQZYR7h5eYDhYM0qdLaDItEKUTvHVE0O
         RfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457929; x=1751062729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srRRaeOIs8QqP+SAheIX06PoynQsP08aWn4E9T2+MS8=;
        b=K+agiSZilE+yNtNpwOQ2DLtJQB9ssKlVKTHfyxi3lSPQuMhXHtoY4QtvonTJJmtgRE
         y4Yen1wlohATVkdSu9+HyIqZmC3U3BNvC+c7VOcOUefV1/wn5AMu/98upo/9IRCkTV9I
         wlNySYunG9N4YI/kMGFIOflH21/esgXh3LSKq3JjJfaTZZR7hUo/6mMWgwGmmn0ZRO49
         Vi0ntCrpg0atuezBM6R6GgZYYpUNXNgGI4n4OwUbPXwUP/b9WJ2/ucQ9mzntzlDhspMp
         Vrqw9Zkb52L5ChDZrQGqjh5ndH0jATcozm8w70o6WLIreXy8h/CHaOHKvT6zU6TnLESI
         0hxg==
X-Forwarded-Encrypted: i=1; AJvYcCULJrQtFaNOhSr8ipiGAE+r+NczzGnHXhECSy2DOz2wbcDSaH8rXIuDcgI0cV7GDGCEP7gXmmTREhGXFdAy5QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxemMxu9CdHSbaYCcmBXf5P9An8wf05W23AXjRXW+r2L6lRUmK3
	z0rdZnFJrqit+vhFA7Y5NOrtvZ61qCJnZ6xa4HhliDXNPTJ2dfqrQquQ0R0ussUhsnbAR6R0cJJ
	B6S/eYSYXpPzFzU8kKpQpVQ7KEw==
X-Google-Smtp-Source: AGHT+IFglucSmVuhrW+uZlSgSrT5jPMZNpmjjmax2ar+hK7o/sbaqYEVFqi7A3KjzTy6avd238vq7SDc4ZyxUgURTw==
X-Received: from oabxe8.prod.google.com ([2002:a05:6870:ce88:b0:2e9:2323:d48f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:364a:b0:2ea:7101:7dc1 with SMTP id 586e51a60fabf-2eeee65a6f4mr3296802fac.33.1750457928774;
 Fri, 20 Jun 2025 15:18:48 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:12 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-13-coltonlewis@google.com>
Subject: [PATCH v2 11/23] KVM: arm64: Set up FGT for Partitioned PMU
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

In order to gain the best performance benefit from partitioning the
PMU, utilize fine grain traps (FEAT_FGT and FEAT_FGT2) to avoid
trapping common PMU register accesses by the guest to remove that
overhead.

There should be no information leaks between guests as all these
registers are context swapped by a later patch in this series.

Untrapped:
* PMCR_EL0
* PMUSERENR_EL0
* PMSELR_EL0
* PMCCNTR_EL0
* PMINTEN_EL0
* PMEVCNTRn_EL0

Trapped:
* PMOVS_EL0
* PMEVTYPERn_EL0
* PMCCFILTR_EL0
* PMICNTR_EL0
* PMICFILTR_EL0

PMOVS remains trapped so KVM can track overflow IRQs that will need to
be injected into the guest.

PMICNTR remains trapped because KVM is not handling that yet.

PMEVTYPERn remains trapped so KVM can limit which events guests can
count, such as disallowing counting at EL2. PMCCFILTR and PMCIFILTR
are the same.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_pmu.h        | 13 ++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 58 +++++++++++++++++++++++++
 arch/arm64/kvm/pmu-part.c               | 32 ++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 151e5b6793f2..02984cfeb446 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -93,7 +93,20 @@ u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
 void kvm_pmu_host_counters_enable(void);
 void kvm_pmu_host_counters_disable(void);
 
+#if !defined(__KVM_NVHE_HYPERVISOR__)
+bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
+bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu);
 #else
+static inline bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+#endif
 
 /*
  * Updates the vcpu's view of the pmu events for this cpu.
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 825b81749972..47d2db8446df 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -191,6 +191,61 @@ static inline bool cpu_has_amu(void)
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
+	set = HDFGRTR2_EL2_nPMICFILTR_EL0
+		| HDFGRTR2_EL2_nPMICNTR_EL0;
+	clr = 0;
+
+	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGRTR2_EL2, clr, set);
+
+	set = HDFGWTR2_EL2_nPMICFILTR_EL0
+		| HDFGWTR2_EL2_nPMICNTR_EL0;
+	clr = 0;
+
+	update_fgt_traps_cs(hctxt, vcpu, kvm, HDFGWTR2_EL2, clr, set);
+}
+
 static inline void __activate_traps_hfgxtr(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
@@ -210,6 +265,9 @@ static inline void __activate_traps_hfgxtr(struct kvm_vcpu *vcpu)
 	if (cpu_has_amu())
 		update_fgt_traps(hctxt, vcpu, kvm, HAFGRTR_EL2);
 
+	if (kvm_vcpu_pmu_use_fgt(vcpu))
+		__activate_pmu_fgt(vcpu);
+
 	if (!cpus_have_final_cap(ARM64_HAS_FGT2))
 	    return;
 
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 340f8d334efd..269397a1fcbc 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -26,6 +26,38 @@ bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
 	return pmu->hpmn_max <= *host_data_ptr(nr_event_counters);
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
+/**
+ * kvm_vcpu_pmu_use_fgt() - Determine if we can use FGT
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Determine if we can use FGT for direct access to registers. We can
+ * if capabilities permit the number of guest counters requested.
+ *
+ * Return: True if we can use FGT, false otherwise
+ */
+bool kvm_vcpu_pmu_use_fgt(struct kvm_vcpu *vcpu)
+{
+	u8 hpmn = vcpu->kvm->arch.nr_pmu_counters;
+
+	return kvm_vcpu_pmu_is_partitioned(vcpu) &&
+		cpus_have_final_cap(ARM64_HAS_FGT) &&
+		(hpmn != 0 || cpus_have_final_cap(ARM64_HAS_HPMN0));
+}
+
 /**
  * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved counters
  * @pmu: Pointer to arm_pmu struct
-- 
2.50.0.714.g196bf9f422-goog


