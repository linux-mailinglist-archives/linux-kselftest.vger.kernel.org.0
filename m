Return-Path: <linux-kselftest+bounces-47330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 920E2CB11AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 546BB307862C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A7930F539;
	Tue,  9 Dec 2025 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmbybgTv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D46306B09
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313575; cv=none; b=tUweFwTSgJggXILs91aGGP/IKFd6ZV5duzkAfvt/3HS1lA0N98bnjTJyiXaLNhftfsiAji+O4KFF2X6wvL+RiSM60yGOko7fYJnQl58a5WUacH/BZ4OnTiHGMp12yWkz4AjeOGNJL4Fvl4LikbYnjlM/HSWcfQRvYouLbGa9wss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313575; c=relaxed/simple;
	bh=Qz4r177CFGhy0LXqT9yrizG49NOxmJkZrufdw1DdziU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oyl2Spy0g83mvflDekX3CXtonAzg78S10GHoEpoa2mNjcbJPGYvzZSIt+8Xw/oIVx4Lnk/uBsPmbeU4l8bnzIhzoLZEo/K9hoDe/Wvq9fADlhTRZGMjLG4PUTRxdOu3ABAZiSxwcslvwvXxB5Ibm1xmI/WVX1PHY3FpmdFRz2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mmbybgTv; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6574a047ec5so4837040eaf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313563; x=1765918363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/sFeK5VmbytXpjUspgl5j2szwkI07ChP0duwQoez5c=;
        b=mmbybgTvVD6PScFUDRLtCb5IJHnVQO7qapWMYWMg10JmaMQQsQwvbYoLvxzZy3yWv1
         yD7+NhZ4Su9fmNSB4PoOZGhbcxskm1g8VfcitpSibLLYhjF3K7v9X4JncRu76AwWG4Dh
         gRdqwGzE6h0lc1d1vOoGVPixVq3NNeJo6lSjc7XRkU+cBd5gFtXWPjxnaNVGNVmehP+8
         ebNh70J3pXg7t1wlq2rG+FgBVEgyZwAIR6Opb9OGBiMJ/tJ2LDkRK6W0jPsnae/6d4YO
         900it1O3QVoVD/9B91idPZtjI3kv/OCdBQEtzIaYFU0VVCIl8OSYGZZ+Y9BbYFIY666a
         um8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313563; x=1765918363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/sFeK5VmbytXpjUspgl5j2szwkI07ChP0duwQoez5c=;
        b=QT+Xe3SLKK+I6D0J3gl3I59qAmLnHIwHwdn1aPufS28irstShS2UFf6KVi1r52+aPw
         mN+O/1VPC2cY+JvxKzSbumTOkjOD8QNkrkA7wOg+/+b36P1RkaGYsIJ3j5V9AHyK5PAf
         L2UnPtiy7yoxT1IQRYrtbrhd/ZEdTSoCYZNHbDKhZLXK2De0d2nULyyjNa9usB+huaH5
         3Liuia14WKuqCrDX7hVVpIDrhTzHkq2HQlY3GjAcdmAgaumqZriWg/ouI2uApYDdqD2A
         Phd9tV+YO2CbvpB0mYrl/jR1Oz+fwSN+5wcpP/Na/G5suG1kig8rvvtI4xpqTZBZadJT
         RC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9Ll1rqovfjS5NjRnnxrwKHG5Rshn3h/cmFYfovq5WcUOsZnBev+sjYndRb3fuwagmFODWUw47it59ntX/F/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YybyMDzY2zrPSwQJKX4krvE25WcjYCMsTPm9eW2ljT+KY7Mwd2O
	KutokJcNx8WSTzXDpNmY0qDGtq1KZBPkrtosJPpleAHcB83GD6okuNey/SFD4LyIavi+nImaMsB
	LpGH+dcmlVBEVuaSZW7MENMKf8g==
X-Google-Smtp-Source: AGHT+IE/HaqRyprFnQdYwiWTY8frwPnLF0+hPo1GlYvxcyhgVPd88+4NFT3OoEIrs06Xz4mz8hzl498G4Aoi8k4qdw==
X-Received: from ilbbd2.prod.google.com ([2002:a05:6e02:3002:b0:436:f324:48])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:2207:b0:65b:2869:c616 with SMTP id 006d021491bc7-65b2ac078bfmr114176eaf.33.1765313563180;
 Tue, 09 Dec 2025 12:52:43 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:14 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-18-coltonlewis@google.com>
Subject: [PATCH v5 17/24] KVM: arm64: Context swap Partitioned PMU guest registers
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Save and restore newly untrapped registers that can be directly
accessed by the guest when the PMU is partitioned.

* PMEVCNTRn_EL0
* PMCCNTR_EL0
* PMICNTR_EL0
* PMUSERENR_EL0
* PMSELR_EL0
* PMCR_EL0
* PMCNTEN_EL0
* PMINTEN_EL1

If we know we are not using FGT (that is, trapping everything), then
return immediately. Either the PMU is not partitioned, or it is but
all register writes are being written through the VCPU fields to
hardware, so all values are fresh.

Since we are taking over context switching, avoid the writes to
PMSELR_EL0 and PMUSERENR_EL0 that would normally occur in
__{,de}activate_traps_common()

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/kvm_pmu.h        |   4 +
 arch/arm64/kvm/arm.c                    |   2 +
 arch/arm64/kvm/hyp/include/hyp/switch.h |   4 +-
 arch/arm64/kvm/pmu-direct.c             | 112 ++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 8b634112eded2..25a5eb8c623da 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -103,6 +103,8 @@ void kvm_pmu_host_counters_disable(void);
 
 u8 kvm_pmu_guest_num_counters(struct kvm_vcpu *vcpu);
 u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu);
+void kvm_pmu_load(struct kvm_vcpu *vcpu);
+void kvm_pmu_put(struct kvm_vcpu *vcpu);
 
 #if !defined(__KVM_NVHE_HYPERVISOR__)
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu);
@@ -184,6 +186,8 @@ static inline u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
+static inline void kvm_pmu_load(struct kvm_vcpu *vcpu) {}
+static inline void kvm_pmu_put(struct kvm_vcpu *vcpu) {}
 static inline void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu,
 					     u64 select_idx, u64 val) {}
 static inline void kvm_pmu_set_counter_value_user(struct kvm_vcpu *vcpu,
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 43e92f35f56ab..1750df5944f6d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -629,6 +629,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_vcpu_load_vhe(vcpu);
 	kvm_arch_vcpu_load_fp(vcpu);
 	kvm_vcpu_pmu_restore_guest(vcpu);
+	kvm_pmu_load(vcpu);
 	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
 		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
 
@@ -671,6 +672,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_timer_vcpu_put(vcpu);
 	kvm_vgic_put(vcpu);
 	kvm_vcpu_pmu_restore_host(vcpu);
+	kvm_pmu_put(vcpu);
 	if (vcpu_has_nv(vcpu))
 		kvm_vcpu_put_hw_mmu(vcpu);
 	kvm_arm_vmid_clear_active();
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 40bd00df6c58f..bde79ec1a1836 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -311,7 +311,7 @@ static inline void __activate_traps_common(struct kvm_vcpu *vcpu)
 	 * counter, which could make a PMXEVCNTR_EL0 access UNDEF at
 	 * EL1 instead of being trapped to EL2.
 	 */
-	if (system_supports_pmuv3()) {
+	if (system_supports_pmuv3() && !kvm_vcpu_pmu_is_partitioned(vcpu)) {
 		write_sysreg(0, pmselr_el0);
 
 		ctxt_sys_reg(hctxt, PMUSERENR_EL0) = read_sysreg(pmuserenr_el0);
@@ -340,7 +340,7 @@ static inline void __deactivate_traps_common(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
 
 	write_sysreg(0, hstr_el2);
-	if (system_supports_pmuv3()) {
+	if (system_supports_pmuv3() && !kvm_vcpu_pmu_is_partitioned(vcpu)) {
 		write_sysreg(ctxt_sys_reg(hctxt, PMUSERENR_EL0), pmuserenr_el0);
 		vcpu_clear_flag(vcpu, PMUSERENR_ON_CPU);
 	}
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 7fb4fb5c22e2a..71977d24f489a 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -9,6 +9,7 @@
 #include <linux/perf/arm_pmuv3.h>
 
 #include <asm/arm_pmuv3.h>
+#include <asm/kvm_emulate.h>
 #include <asm/kvm_pmu.h>
 
 /**
@@ -219,3 +220,114 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
 
 	return nr_host_cnt_max;
 }
+
+/**
+ * kvm_pmu_load() - Load untrapped PMU registers
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Load all untrapped PMU registers from the VCPU into the PCPU. Mask
+ * to only bits belonging to guest-reserved counters and leave
+ * host-reserved counters alone in bitmask registers.
+ */
+void kvm_pmu_load(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu;
+	u64 mask;
+	u8 i;
+	u64 val;
+
+	/*
+	 * If we aren't using FGT then we are trapping everything
+	 * anyway, so no need to bother with the swap.
+	 */
+	if (!kvm_vcpu_pmu_use_fgt(vcpu))
+		return;
+
+	pmu = vcpu->kvm->arch.arm_pmu;
+
+	for (i = 0; i < pmu->hpmn_max; i++) {
+		val = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
+		write_pmevcntrn(i, val);
+	}
+
+	val = __vcpu_sys_reg(vcpu, PMCCNTR_EL0);
+	write_pmccntr(val);
+
+	val = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+	write_pmuserenr(val);
+
+	val = __vcpu_sys_reg(vcpu, PMSELR_EL0);
+	write_pmselr(val);
+
+	/* Save only the stateful writable bits. */
+	val = __vcpu_sys_reg(vcpu, PMCR_EL0);
+	mask = ARMV8_PMU_PMCR_MASK &
+		~(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C);
+	write_pmcr(val & mask);
+
+	/*
+	 * When handling these:
+	 * 1. Apply only the bits for guest counters (indicated by mask)
+	 * 2. Use the different registers for set and clear
+	 */
+	mask = kvm_pmu_guest_counter_mask(pmu);
+
+	val = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+	write_pmcntenset(val & mask);
+	write_pmcntenclr(~val & mask);
+
+	val = __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
+	write_pmintenset(val & mask);
+	write_pmintenclr(~val & mask);
+}
+
+/**
+ * kvm_pmu_put() - Put untrapped PMU registers
+ * @vcpu: Pointer to struct kvm_vcpu
+ *
+ * Put all untrapped PMU registers from the VCPU into the PCPU. Mask
+ * to only bits belonging to guest-reserved counters and leave
+ * host-reserved counters alone in bitmask registers.
+ */
+void kvm_pmu_put(struct kvm_vcpu *vcpu)
+{
+	struct arm_pmu *pmu;
+	u64 mask;
+	u8 i;
+	u64 val;
+
+	/*
+	 * If we aren't using FGT then we are trapping everything
+	 * anyway, so no need to bother with the swap.
+	 */
+	if (!kvm_vcpu_pmu_use_fgt(vcpu))
+		return;
+
+	pmu = vcpu->kvm->arch.arm_pmu;
+
+	for (i = 0; i < pmu->hpmn_max; i++) {
+		val = read_pmevcntrn(i);
+		__vcpu_assign_sys_reg(vcpu, PMEVCNTR0_EL0 + i, val);
+	}
+
+	val = read_pmccntr();
+	__vcpu_assign_sys_reg(vcpu, PMCCNTR_EL0, val);
+
+	val = read_pmuserenr();
+	__vcpu_assign_sys_reg(vcpu, PMUSERENR_EL0, val);
+
+	val = read_pmselr();
+	__vcpu_assign_sys_reg(vcpu, PMSELR_EL0, val);
+
+	val = read_pmcr();
+	__vcpu_assign_sys_reg(vcpu, PMCR_EL0, val);
+
+	/* Mask these to only save the guest relevant bits. */
+	mask = kvm_pmu_guest_counter_mask(pmu);
+
+	val = read_pmcntenset();
+	__vcpu_assign_sys_reg(vcpu, PMCNTENSET_EL0, val & mask);
+
+	val = read_pmintenset();
+	__vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
+}
-- 
2.52.0.239.gd5f0c6e74e-goog


