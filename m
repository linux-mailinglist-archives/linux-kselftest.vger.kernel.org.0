Return-Path: <linux-kselftest+bounces-37300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEF8B04B3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 01:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124B51A68207
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA0285C82;
	Mon, 14 Jul 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fz5y7Iia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7A285C86
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533982; cv=none; b=Ovy960SWK3rHQU118UeIZ+NMxiqsq1NmVAYYIZ2tleGC23oGqJyJj3UQQZXzAo/sg3xOVHBJ9XA0UiuC7rRdR+GiINwjlZRtIgdEZF9d+v7f4FrmPHDM+RF0kV8susM6aXUJn3nsK4873lq8z7VUpxdLPKSCRDr3XfjR0xPJXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533982; c=relaxed/simple;
	bh=G/txQZ/BDq9gkt6hp09zgaWZYatSA85P4NtLWq5cQT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=arQaM5hpg+9JKJWkaKjKQ/mV4orfhB4ySpltthgdPvxixl/oXloZ0VQpwWhTNQLIdQ9ASstC8EYfxoChTwHY9HKfAkr2QsxinsDJlLNXLrWfk2MyMEtP1q19zTAMotlQXARxTRhCC1AfYUEEnhpX0YV2RPZutRgz6WbsBp/cybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fz5y7Iia; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-86d1218df67so519138639f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533976; x=1753138776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=am9zpMdbn943xX1i598dJouvcbY5ZVT5eyUs7a9fWoM=;
        b=fz5y7IiaZJjUCnULpI/ROFWdTQHkitQWSHOlcUwdEVUdXFQ5WPyRXTZCYA91GAMCxz
         ijPbEMKBj8e0tfexAdQG1GYhVH6M3tra/J2A//hiIaelCNCBXKl9XJayEgCDp0sumdSU
         WqFtOiLzK+TUs+1bkKAjNLlEQagNmzPK76opCStIMlkBQqFk0w/3VwHrhSPQt0goxvas
         iDG3hww/BWk6ZePSraKIuEVCtI+1MjtI+cE16WaKzuuG6M9P7qf+9U4+nEtPlj10hfXJ
         e3f6vxF42bIsSH2+Kc1WwSaa5Afcggk+Tu+1r9LiPFY1xpb+KeFPlQ1T+nVlbdZZ0Pzb
         2AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533976; x=1753138776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am9zpMdbn943xX1i598dJouvcbY5ZVT5eyUs7a9fWoM=;
        b=OKRA6qVk+8kdUt9deRMgQ5/5BapxG0w9uJacy847JrBc5SSzEnFq/63aSibamiMquq
         VJrgUKHqx6+zASxD9YBGEFravnP4lWXfZqtXbYQckuFKbTuzNJEHL3/QvOEiCtUcntLE
         kU3RdVw0+5sfmoOSB7T9S3E/xNkqT+8c3J24JiaueC4JV5dISlJgqLcpAArjbDFn4550
         okO7J13n29nModB04YtnhZV9KAXcMuvSDAaTIbRfbN5CJ+G14l8ep/UT0ENPIajmKM97
         5xGHnlAy33EyotL0Cu+lvnj/Days4b3YlsP/lNU3FtCDY4FWsN+9sVUgV1PuesDRmQDU
         bedg==
X-Forwarded-Encrypted: i=1; AJvYcCU8uYYIIaM6/oZyuvecEw5vsQVBHaYQdVTHEj8bQy9Lt1W0doYKX5ICdP0mZ00ixbS4sY/7Qj8cRh2P4QUKSAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZR9mQjpFg7ezLAuH/gY8UsRFqs4svvSWpaYyE63xIHGebErc
	Ua5Il+o+PGUxW5P/RzTxmrPRcUki4y/mNTrvDmUfAS/m2tJc1UKxijAiIQtasevdCbWsKh/W7Fn
	8Egs1rQ6WbxxmdMZPANtUX+yRbw==
X-Google-Smtp-Source: AGHT+IE1z+39HIqmM7BKLjtY5wU42naB5FJcsSTxcaG7pf5N9dm7lxvFCjXcuCMwk1bcxRw8i+zH9dMxhRnWzJouvQ==
X-Received: from iobeu7.prod.google.com ([2002:a05:6602:4c87:b0:863:ef1c:406e])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:2dcd:b0:86c:fdb3:2798 with SMTP id ca18e2360f4ac-87978866cf4mr1633168739f.11.1752533976249;
 Mon, 14 Jul 2025 15:59:36 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:59:00 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-7-coltonlewis@google.com>
Subject: [PATCH v4 06/23] perf: arm_pmuv3: Keep out of guest counter partition
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

If the PMU is partitioned, keep the driver out of the guest counter
partition and only use the host counter partition. Partitioning is
defined by the MDCR_EL2.HPMN register field and the maximum value KVM
can use is saved in cpu_pmu->hpmn_max. The range 0..HPMN-1 is
accessible by EL1 and EL0 while HPMN..PMCR.N is reserved for EL2.

Define some functions that take HPMN as an argument and construct
mutually exclusive bitmaps for testing which partition a particular
counter is in. Note that despite their different position in the
bitmap, the cycle and instruction counters are always in the guest
partition.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h | 18 +++++++
 arch/arm64/include/asm/kvm_pmu.h | 24 +++++++++
 arch/arm64/kvm/pmu-direct.c      | 84 ++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c         | 36 ++++++++++++--
 4 files changed, 158 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 49b1f2d7842d..5f6269039f44 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -231,6 +231,24 @@ static inline bool kvm_set_pmuserenr(u64 val)
 }
 
 static inline void kvm_vcpu_pmu_resync_el0(void) {}
+static inline void kvm_pmu_host_counters_enable(void) {}
+static inline void kvm_pmu_host_counters_disable(void) {}
+
+static inline bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
+{
+	return false;
+}
+
+static inline u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
+{
+	return ~0;
+}
+
+static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
+{
+	return ~0;
+}
+
 
 static inline bool has_vhe(void)
 {
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 8a2ed02e157d..6328e90952ba 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -88,6 +88,12 @@ void kvm_vcpu_pmu_resync_el0(void);
 #define kvm_vcpu_has_pmu(vcpu)					\
 	(vcpu_has_feature(vcpu, KVM_ARM_VCPU_PMU_V3))
 
+bool kvm_pmu_is_partitioned(struct arm_pmu *pmu);
+u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu);
+u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
+void kvm_pmu_host_counters_enable(void);
+void kvm_pmu_host_counters_disable(void);
+
 /*
  * Updates the vcpu's view of the pmu events for this cpu.
  * Must be called before every vcpu run after disabling interrupts, to ensure
@@ -220,6 +226,24 @@ static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int id
 
 static inline void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu) {}
 
+static inline bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
+{
+	return false;
+}
+
+static inline u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
+{
+	return ~0;
+}
+
+static inline u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
+{
+	return ~0;
+}
+
+static inline void kvm_pmu_host_counters_enable(void) {}
+static inline void kvm_pmu_host_counters_disable(void) {}
+
 #endif
 
 #endif
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
index 9423d6f65059..22e9b2f9e7b6 100644
--- a/arch/arm64/kvm/pmu-direct.c
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -5,7 +5,10 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/perf/arm_pmu.h>
+#include <linux/perf/arm_pmuv3.h>
 
+#include <asm/arm_pmuv3.h>
 #include <asm/kvm_pmu.h>
 
 /**
@@ -20,3 +23,84 @@ bool kvm_pmu_partition_supported(void)
 {
 	return has_vhe();
 }
+
+/**
+ * kvm_pmu_is_partitioned() - Determine if given PMU is partitioned
+ * @pmu: Pointer to arm_pmu struct
+ *
+ * Determine if given PMU is partitioned by looking at hpmn field. The
+ * PMU is partitioned if this field is less than the number of
+ * counters in the system.
+ *
+ * Return: True if the PMU is partitioned, false otherwise
+ */
+bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
+{
+	return pmu->hpmn_max >= 0 &&
+		pmu->hpmn_max <= *host_data_ptr(nr_event_counters);
+}
+
+/**
+ * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved counters
+ * @pmu: Pointer to arm_pmu struct
+ *
+ * Compute the bitmask that selects the host-reserved counters in the
+ * {PMCNTEN,PMINTEN,PMOVS}{SET,CLR} registers. These are the counters
+ * in HPMN..N
+ *
+ * Assumes pmu is partitioned and hpmn_max is a valid value.
+ *
+ * Return: Bitmask
+ */
+u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
+{
+	u8 nr_counters = *host_data_ptr(nr_event_counters);
+
+	return GENMASK(nr_counters - 1, pmu->hpmn_max);
+}
+
+/**
+ * kvm_pmu_guest_counter_mask() - Compute bitmask of guest-reserved counters
+ *
+ * Compute the bitmask that selects the guest-reserved counters in the
+ * {PMCNTEN,PMINTEN,PMOVS}{SET,CLR} registers. These are the counters
+ * in 0..HPMN and the cycle and instruction counters.
+ *
+ * Assumes pmu is partitioned and hpmn_max is a valid value.
+ *
+ * Return: Bitmask
+ */
+u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu)
+{
+	return ARMV8_PMU_CNT_MASK_ALL & ~kvm_pmu_host_counter_mask(pmu);
+}
+
+/**
+ * kvm_pmu_host_counters_enable() - Enable host-reserved counters
+ *
+ * When partitioned the enable bit for host-reserved counters is
+ * MDCR_EL2.HPME instead of the typical PMCR_EL0.E, which now
+ * exclusively controls the guest-reserved counters. Enable that bit.
+ */
+void kvm_pmu_host_counters_enable(void)
+{
+	u64 mdcr = read_sysreg(mdcr_el2);
+
+	mdcr |= MDCR_EL2_HPME;
+	write_sysreg(mdcr, mdcr_el2);
+}
+
+/**
+ * kvm_pmu_host_counters_disable() - Disable host-reserved counters
+ *
+ * When partitioned the disable bit for host-reserved counters is
+ * MDCR_EL2.HPME instead of the typical PMCR_EL0.E, which now
+ * exclusively controls the guest-reserved counters. Disable that bit.
+ */
+void kvm_pmu_host_counters_disable(void)
+{
+	u64 mdcr = read_sysreg(mdcr_el2);
+
+	mdcr &= ~MDCR_EL2_HPME;
+	write_sysreg(mdcr, mdcr_el2);
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 339d3c2d91a0..bc8a99cf4f88 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -839,12 +839,18 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 	kvm_vcpu_pmu_resync_el0();
 
 	/* Enable all counters */
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		kvm_pmu_host_counters_enable();
+
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
 }
 
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	/* Disable all counters */
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		kvm_pmu_host_counters_disable();
+
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
 }
 
@@ -954,6 +960,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 
 	/* Always prefer to place a cycle counter into the cycle counter. */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) &&
+	    !kvm_pmu_is_partitioned(cpu_pmu) &&
 	    !armv8pmu_event_get_threshold(&event->attr)) {
 		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
 			return ARMV8_PMU_CYCLE_IDX;
@@ -969,6 +976,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * may not know how to handle it.
 	 */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_INST_RETIRED) &&
+	    !kvm_pmu_is_partitioned(cpu_pmu) &&
 	    !armv8pmu_event_get_threshold(&event->attr) &&
 	    test_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask) &&
 	    !armv8pmu_event_want_user_access(event)) {
@@ -980,7 +988,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * Otherwise use events counters
 	 */
 	if (armv8pmu_event_is_chained(event))
-		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
+		return armv8pmu_get_chain_idx(cpuc, cpu_pmu);
 	else
 		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
 }
@@ -1072,6 +1080,14 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
+static void armv8pmu_reset_host_counters(struct arm_pmu *cpu_pmu)
+{
+	int idx;
+
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS)
+		armv8pmu_write_evcntr(idx, 0);
+}
+
 static void armv8pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
@@ -1079,6 +1095,9 @@ static void armv8pmu_reset(void *info)
 
 	bitmap_to_arr64(&mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
 
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		mask &= kvm_pmu_host_counter_mask(cpu_pmu);
+
 	/* The counter and interrupt enable registers are unknown at reset. */
 	armv8pmu_disable_counter(mask);
 	armv8pmu_disable_intens(mask);
@@ -1086,11 +1105,20 @@ static void armv8pmu_reset(void *info)
 	/* Clear the counters we flip at guest entry/exit */
 	kvm_clr_pmu_events(mask);
 
+
+	pmcr = ARMV8_PMU_PMCR_LC;
+
 	/*
-	 * Initialize & Reset PMNC. Request overflow interrupt for
-	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
+	 * Initialize & Reset PMNC. Request overflow interrupt for 64
+	 * bit cycle counter but cheat in armv8pmu_write_counter().
+	 *
+	 * When partitioned, there is no single bit to reset only the
+	 * host counters. so reset them individually.
 	 */
-	pmcr = ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C | ARMV8_PMU_PMCR_LC;
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		armv8pmu_reset_host_counters(cpu_pmu);
+	else
+		pmcr = ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C;
 
 	/* Enable long event counter support where available */
 	if (armv8pmu_has_long_event(cpu_pmu))
-- 
2.50.0.727.gbf7dc18ff4-goog


