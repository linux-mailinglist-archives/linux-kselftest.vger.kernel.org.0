Return-Path: <linux-kselftest+bounces-47320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F3ECB11BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81BA83053EA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E130C342;
	Tue,  9 Dec 2025 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EiiAjoK8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D9309F18
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313563; cv=none; b=Rf8mvIUSTVpnzSvxU6o/uTATGxBo0XQWEipIwfjs4axLRe4pr621XhfH26FOuuSIw4uIwAMgmGzh00Euj2GypWUIXIfgLRS1VgRYY9ToRMGNGGLiWWNOX2z7GL5uA1WtFni7hLvCZE8utT/Lj99ErKkbkReao6hJRn+K8dWqmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313563; c=relaxed/simple;
	bh=41NAhCA/2EGwgWmj+Pj9H/vR82+MtXJvtZjvEDce/A4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOazXxZuePw8UKvqbUSo5jdcxkkKHz5TUfcuNCKsidhAFc8gXMlMSqwsR3Y2T694xHmP4LN9AUlZiziUQBQzBND3LmVMFuXR30p1uDyqaevbczx61yUVghEqG6iRu3Lnd+FkuAt3NRWqRAnaDqNijLc2edxCoaf1qjg5+J/sj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EiiAjoK8; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-4512e9f2f82so7505524b6e.3
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313555; x=1765918355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3Ne4/j3i6bMg+yI7GrAFYYJtGDrr1dKJKFAZAi4YL0=;
        b=EiiAjoK88HLl92t3vFfXgrdA0NDR6vol3rWtLLybpDMsYpDSGD/R2FDXOOfr9+codO
         iL6dP6EzWfJyOz7hmX6FvkCaOUGixmVmD5tzkKBZx7WWUQYVjvWi5f8hIiiWpLBtkvWk
         U2QNQFWAxVQXBUjixFp+PapwkqMK2bZ9Q3/FQX+QAeddmVhKjRJ6SanM3tdonFk4hAJM
         sPaR/v5jcoq/mbdB2D5Ahm3n59yH3lZVFXSR+fFtqyGa/tv8JfXC/F+K+cBt69QOlvCd
         regRlTW+d72TimykQKNuL//h3Mb/mA27vEKhHuUtbyY7b4ViZ9yrW/IcDL82BU/+zFB/
         8KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313555; x=1765918355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3Ne4/j3i6bMg+yI7GrAFYYJtGDrr1dKJKFAZAi4YL0=;
        b=ZPz58oWiIbI/Fwgv04rnF+93iIobjjJRB8AwPglms3Z+hYUr27g28b3ehqp13VT9zU
         IT3Cxden9blVPFblr0K/0ErsmE4wqTsFYF6vGpJrF0Oz21uNgR7yciEsiZbfEfuhKmaV
         Iwk7TreG0j8IyvOa3pDAY97MeF07uQTo29FvoCXu0hu45Q57GkYLdshd82KrAg3d6U+M
         J5FAZ6mQYG+FZWSolON1ROHtX5XzjDxfgTPdR5QDQemS+3WRFbxrpRd0C3bwPpOfL591
         srro2kGV/bCLt7scYCy/OlYj7Yas3AjrZvCIwW2vqRhGcNwtksZndwVvczQRypMdmnEm
         DWEw==
X-Forwarded-Encrypted: i=1; AJvYcCVqqP5psqeLEt+oTpUqw/qje7+JC3IQULMqMCGOjSfqCR9D0wBq4xJfJd3EpzFAtGqBch1xMuKfAyUHmz4xCB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoK0qxVjBNIPNzT2oMy6V1ka8EmIIeCNQUTIh1ZzfBuvKsrgF
	F6Dxk+JY+TfPzQkaNZqTWwZaqPPqOSQJi2EL+Wo0zxtNBZJGSzmu7Z+6xdl1VSp76tJwWCGtOVj
	gy3t7blAwsaMM4VWqxkTtOmdzvg==
X-Google-Smtp-Source: AGHT+IEa/rFR8Fw1AH4pDhUYtNUCf4vwq4EK7bqkjQNV+qFXgux9uP/SUV3Lv9mVRc+RszyAsYKt8sMK0JKXjHWz8Q==
X-Received: from oifn25-n1.prod.google.com ([2002:a05:6808:8859:10b0:450:63b:b0dd])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6d8e:b0:450:760b:cc8d with SMTP id 5614622812f47-4558660f2ecmr115150b6e.29.1765313555166;
 Tue, 09 Dec 2025 12:52:35 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:06 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-10-coltonlewis@google.com>
Subject: [PATCH v5 09/24] perf: arm_pmuv3: Keep out of guest counter partition
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

If the PMU is partitioned, keep the driver out of the guest counter
partition and only use the host counter partition.

Define some functions that determine whether the PMU is partitioned
and construct mutually exclusive bitmaps for testing which partition a
particular counter is in. Note that despite their separate position in
the bitmap, the cycle and instruction counters are always in the guest
partition.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h | 18 +++++++
 arch/arm64/include/asm/kvm_pmu.h | 24 +++++++++
 arch/arm64/kvm/pmu-direct.c      | 86 ++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c         | 41 +++++++++++++--
 4 files changed, 165 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 636b1aab9e8d2..3ea5741d213d8 100644
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
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 63bff75e4f8dd..8887f39c25e60 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -90,6 +90,12 @@ void kvm_vcpu_pmu_resync_el0(void);
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
@@ -222,6 +228,24 @@ static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu, unsigned int id
 
 static inline void kvm_pmu_nested_transition(struct kvm_vcpu *vcpu) {}
 
+static inline bool kvm_pmu_is_partitioned(void *pmu)
+{
+	return false;
+}
+
+static inline u64 kvm_pmu_host_counter_mask(void *pmu)
+{
+	return ~0;
+}
+
+static inline u64 kvm_pmu_guest_counter_mask(void *pmu)
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
index 0d38265b6f290..d5de7fdd059f4 100644
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
@@ -20,3 +23,86 @@ bool kvm_pmu_partition_supported(void)
 	return has_vhe() &&
 		system_supports_pmuv3();
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
+	if (!pmu)
+		return false;
+
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
+ * Return: Bitmask
+ */
+u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu)
+{
+	u8 nr_counters = *host_data_ptr(nr_event_counters);
+
+	if (!kvm_pmu_is_partitioned(pmu))
+		return ARMV8_PMU_CNT_MASK_ALL;
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
index 3e6eb4be4ac43..2bed99ba992d7 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -871,6 +871,9 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 		brbe_enable(cpu_pmu);
 
 	/* Enable all counters */
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		kvm_pmu_host_counters_enable();
+
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
 }
 
@@ -882,6 +885,9 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 		brbe_disable();
 
 	/* Disable all counters */
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		kvm_pmu_host_counters_disable();
+
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
 }
 
@@ -998,6 +1004,7 @@ static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
 static bool armv8pmu_can_use_pmccntr(struct pmu_hw_events *cpuc,
 				     struct perf_event *event)
 {
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
 
@@ -1018,6 +1025,12 @@ static bool armv8pmu_can_use_pmccntr(struct pmu_hw_events *cpuc,
 	if (has_branch_stack(event))
 		return false;
 
+	/*
+	 * If partitioned at all, pmccntr belongs to the guest.
+	 */
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		return false;
+
 	return true;
 }
 
@@ -1044,6 +1057,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * may not know how to handle it.
 	 */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_INST_RETIRED) &&
+	    !kvm_pmu_is_partitioned(cpu_pmu) &&
 	    !armv8pmu_event_get_threshold(&event->attr) &&
 	    test_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask) &&
 	    !armv8pmu_event_want_user_access(event)) {
@@ -1055,7 +1069,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * Otherwise use events counters
 	 */
 	if (armv8pmu_event_is_chained(event))
-		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
+		return armv8pmu_get_chain_idx(cpuc, cpu_pmu);
 	else
 		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
 }
@@ -1167,6 +1181,14 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
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
@@ -1174,6 +1196,9 @@ static void armv8pmu_reset(void *info)
 
 	bitmap_to_arr64(&mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
 
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		mask &= kvm_pmu_host_counter_mask(cpu_pmu);
+
 	/* The counter and interrupt enable registers are unknown at reset. */
 	armv8pmu_disable_counter(mask);
 	armv8pmu_disable_intens(mask);
@@ -1186,11 +1211,19 @@ static void armv8pmu_reset(void *info)
 		brbe_invalidate();
 	}
 
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
2.52.0.239.gd5f0c6e74e-goog


