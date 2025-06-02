Return-Path: <linux-kselftest+bounces-34166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2D1ACBBB0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984CC188DC7D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9E223507B;
	Mon,  2 Jun 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1YGYPCIO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3723184A
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892557; cv=none; b=dOddK8R25sBaWZVabzTUwyLM5r/9Put28SP6EIeUi3Jv7E6HDElSSIokT99/ZGOQfnsOGvahdIjaGRR1n9WjxJO4XVhgUwD7rzgbcPmZE43LesG/UvMkLHhDECnqLu13RyGY8TRaYkk2nqE0DxDUVWq/YspELtgsZsjRcVFzg4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892557; c=relaxed/simple;
	bh=z8Mgf4Ozoql/C7tjISrHBVxXhjy93k5CpTee2Ovb984=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bif8XICI45DDw+wXiuAx7SRxzuOKdtnhNyb9xem+Scx117Q5wUO2oAoYf2p+jAN46CYLBZHtWlH4+YOCwpYF8xr3MuQ+V1eCUooJ8MWd7R0qR5jKLBm4Q+KEcPN0EB81Y7wPiqtW41YhmTDPr/rnRBM6eZT1LYCIJCtWjKp3wjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1YGYPCIO; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddb4ed2dcbso9578665ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892550; x=1749497350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vPN7IQ4QZrByG0258EKRU9FkVzNdKi6RapVUPx28H4Q=;
        b=1YGYPCIOhwsGFTHW8d5thIo/moKFMEKYh0Qt4m5onn3PDGdFlIdrban9vE9LxJ+TiO
         LGLrxapeE4TIdkXmcaFoe2jdQJHRd6QESecjVqR1LxqRyOW9IfzSSinYExy1PvA2l0hH
         lzgPjCVvMLfYrQCP/Jt/nSSR6Jo+7zZ8tpz/ndT4Icoqjc2kdmUKpRctwuz1n0qB5+Pt
         IpyorGJZqVXjoOhcOQGUGrcD8X4gaQV/QEK7O8pOzroDYsTwtf8P1ZC5dHfn5BtQ+Xho
         Vxv9jR1Cd3vZmP2QbmIT7ennVgasoeVs1CVATCv0ycP7ehFlMilnFP7KFqXBEldhcsNI
         EC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892550; x=1749497350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPN7IQ4QZrByG0258EKRU9FkVzNdKi6RapVUPx28H4Q=;
        b=crMmFvThMKtZ1IiEJ/EzW/pqyI8nDJBjbv+rEZuXlAabsHdVtLOQqv5L30Dc60to8n
         Nce2hIxbAHHyhsIII2FmNEr4G8DzcFyfiZlDR0toao4Wxr4UfFToL9a3hwqAaWBuo6Ig
         TBhmaACDG3CjNae6L1vo6OddEP6L840egMXqj31sckNaQpoCv/Qu9lc5EKAXg1ysK4fL
         6AKSL9VEzXbO1bCqwvwr95LrRXHvZ9bdyGpIATyFCKWROn7msFEqv/jcrFWpimsNXEw9
         PL/sYW+uQxs0nS+Wx7yTCuP6dDNJy0LxWtx+QB2/pXX3s36xG6IZlNM3W9m1F7UvUZ9q
         dDgg==
X-Forwarded-Encrypted: i=1; AJvYcCWruTSfkM5PsvCTU5sJHWwnAhoZr9jVYJr8I/w3VrRIJgv42OQ4IlICmmUNYO/kWnweuDdXYymzFxKBQhlz94M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYwfKUeG/3+ZDCO0005+vZvdyaEPooOglPUXu+G6wLwzNtR7o
	WZdRobJ0upUQgiI94IyboXsBNUxZgShvhFUHoUUr5LuiSeNaRbqbLWvIerhvBVgMyq7J5uZbhfJ
	EZ26nEQu0qc7SJBstFdMj8Vp1hg==
X-Google-Smtp-Source: AGHT+IH86fHCzapUTGFWqzE+3QpTaBJs9I3lg0JaK8lTkophTRu4KMdA3DgBlYLQP0BjLgK/7D8Z4lUFZI+wwSJ2TQ==
X-Received: from ilbbf17.prod.google.com ([2002:a05:6e02:3091:b0:3dc:a282:283e])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:3c04:b0:3d9:36a8:3d98 with SMTP id e9e14a558f8ab-3dd99bd048bmr170872535ab.2.1748892550667;
 Mon, 02 Jun 2025 12:29:10 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:58 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-14-coltonlewis@google.com>
Subject: [PATCH 13/17] KVM: arm64: Context switch Partitioned PMU guest registers
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

Save and restore newly untrapped registers that will be directly
accessed by the guest when the PMU is partitioned.

* PMEVCNTRn_EL0
* PMCCNTR_EL0
* PMICNTR_EL0
* PMUSERENR_EL0
* PMSELR_EL0
* PMCR_EL0
* PMCNTEN_EL0
* PMINTEN_EL1

If the PMU is not partitioned or MDCR_EL2.TPM is set, all PMU
registers are trapped so return immediately.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h |  17 ++++-
 arch/arm64/include/asm/kvm_host.h  |   4 +
 arch/arm64/kvm/arm.c               |   2 +
 arch/arm64/kvm/pmu-part.c          | 117 +++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 5d01ed25c4ef..a00845cffb3f 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -107,6 +107,11 @@ static inline void write_pmcntenset(u64 val)
 	write_sysreg(val, pmcntenset_el0);
 }
 
+static inline u64 read_pmcntenset(void)
+{
+	return read_sysreg(pmcntenset_el0);
+}
+
 static inline void write_pmcntenclr(u64 val)
 {
 	write_sysreg(val, pmcntenclr_el0);
@@ -117,6 +122,11 @@ static inline void write_pmintenset(u64 val)
 	write_sysreg(val, pmintenset_el1);
 }
 
+static inline u64 read_pmintenset(void)
+{
+	return read_sysreg(pmintenset_el1);
+}
+
 static inline void write_pmintenclr(u64 val)
 {
 	write_sysreg(val, pmintenclr_el1);
@@ -162,11 +172,16 @@ static inline u64 read_pmovsclr(void)
 	return read_sysreg(pmovsclr_el0);
 }
 
-static inline void write_pmuserenr(u32 val)
+static inline void write_pmuserenr(u64 val)
 {
 	write_sysreg(val, pmuserenr_el0);
 }
 
+static inline u64 read_pmuserenr(void)
+{
+	return read_sysreg(pmuserenr_el0);
+}
+
 static inline void write_pmuacr(u64 val)
 {
 	write_sysreg_s(val, SYS_PMUACR_EL1);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4ea045098bfa..955359f20161 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -453,9 +453,11 @@ enum vcpu_sysreg {
 	PMEVCNTR0_EL0,	/* Event Counter Register (0-30) */
 	PMEVCNTR30_EL0 = PMEVCNTR0_EL0 + 30,
 	PMCCNTR_EL0,	/* Cycle Counter Register */
+	PMICNTR_EL0,	/* Instruction Counter Register */
 	PMEVTYPER0_EL0,	/* Event Type Register (0-30) */
 	PMEVTYPER30_EL0 = PMEVTYPER0_EL0 + 30,
 	PMCCFILTR_EL0,	/* Cycle Count Filter Register */
+	PMICFILTR_EL0,	/* Insturction Count Filter Register */
 	PMCNTENSET_EL0,	/* Count Enable Set Register */
 	PMINTENSET_EL1,	/* Interrupt Enable Set Register */
 	PMOVSSET_EL0,	/* Overflow Flag Status Set Register */
@@ -1713,6 +1715,8 @@ struct kvm_pmu_events *kvm_get_pmu_events(void);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 bool kvm_pmu_overflow_status(struct kvm_vcpu *vcpu);
+void kvm_pmu_load(struct kvm_vcpu *vcpu);
+void kvm_pmu_put(struct kvm_vcpu *vcpu);
 
 /*
  * Updates the vcpu's view of the pmu events for this cpu.
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3b9c003f2ea6..4a1cc7b72295 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -615,6 +615,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_vcpu_load_vhe(vcpu);
 	kvm_arch_vcpu_load_fp(vcpu);
 	kvm_vcpu_pmu_restore_guest(vcpu);
+	kvm_pmu_load(vcpu);
 	if (kvm_arm_is_pvtime_enabled(&vcpu->arch))
 		kvm_make_request(KVM_REQ_RECORD_STEAL, vcpu);
 
@@ -657,6 +658,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_timer_vcpu_put(vcpu);
 	kvm_vgic_put(vcpu);
 	kvm_vcpu_pmu_restore_host(vcpu);
+	kvm_pmu_put(vcpu);
 	if (vcpu_has_nv(vcpu))
 		kvm_vcpu_put_hw_mmu(vcpu);
 	kvm_arm_vmid_clear_active();
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 179a4144cfd0..40c72caef34e 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -8,6 +8,7 @@
 #include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
 
+#include <asm/kvm_emulate.h>
 #include <asm/kvm_pmu.h>
 #include <asm/arm_pmuv3.h>
 
@@ -202,3 +203,119 @@ void kvm_pmu_host_counters_disable(void)
 	mdcr &= ~MDCR_EL2_HPME;
 	write_sysreg(mdcr, mdcr_el2);
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
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	u64 mask = kvm_pmu_guest_counter_mask(pmu);
+	u8 i;
+	u64 val;
+
+	/*
+	 * If the PMU is not partitioned, don't bother.
+	 *
+	 * If we have MDCR_EL2_TPM, every PMU access is trapped which
+	 * implies we are using the emulated PMU instead of direct
+	 * access.
+	 */
+	if (!kvm_pmu_is_partitioned(pmu) || (vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
+		return;
+
+	for (i = 0; i < pmu->hpmn; i++) {
+		val = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);
+		write_pmevcntrn(i, val);
+	}
+
+	val = __vcpu_sys_reg(vcpu, PMCCNTR_EL0);
+	write_pmccntr(val);
+
+	if (cpus_have_final_cap(ARM64_HAS_PMICNTR)) {
+		val = __vcpu_sys_reg(vcpu, PMICNTR_EL0);
+		write_pmicntr(val);
+	}
+
+	val = __vcpu_sys_reg(vcpu, PMUSERENR_EL0);
+	write_pmuserenr(val);
+
+	val = __vcpu_sys_reg(vcpu, PMSELR_EL0);
+	write_pmselr(val);
+
+	val = __vcpu_sys_reg(vcpu, PMCR_EL0);
+	write_pmcr(val);
+
+	/*
+	 * Loading these registers is tricky because of
+	 * 1. Applying only the bits for guest counters (indicated by mask)
+	 * 2. Setting and clearing are different registers
+	 */
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
+	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
+	u64 mask = kvm_pmu_guest_counter_mask(pmu);
+	u8 i;
+	u64 val;
+
+	/*
+	 * If the PMU is not partitioned, don't bother.
+	 *
+	 * If we have MDCR_EL2_TPM, every PMU access is trapped which
+	 * implies we are using the emulated PMU instead of direct
+	 * access.
+	 */
+	if (!kvm_pmu_is_partitioned(pmu) || (vcpu->arch.mdcr_el2 & MDCR_EL2_TPM))
+		return;
+
+	for (i = 0; i < pmu->hpmn; i++) {
+		val = read_pmevcntrn(i);
+		__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = val;
+	}
+
+	val = read_pmccntr();
+	__vcpu_sys_reg(vcpu, PMCCNTR_EL0) = val;
+
+	if (this_cpu_has_cap(ARM64_HAS_PMICNTR)) {
+		val = read_pmicntr();
+		__vcpu_sys_reg(vcpu, PMICNTR_EL0) = val;
+	}
+
+	val = read_pmuserenr();
+	__vcpu_sys_reg(vcpu, PMUSERENR_EL0) = val;
+
+	val = read_pmselr();
+	__vcpu_sys_reg(vcpu, PMSELR_EL0) = val;
+
+	val = read_pmcr();
+	__vcpu_sys_reg(vcpu, PMCR_EL0) = val;
+
+	/* Mask these to only save the guest relevant bits. */
+	val = read_pmcntenset();
+	__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) = val & mask;
+
+	val = read_pmintenset();
+	__vcpu_sys_reg(vcpu, PMINTENSET_EL1) = val & mask;
+}
-- 
2.49.0.1204.g71687c7c1d-goog


