Return-Path: <linux-kselftest+bounces-34161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB3ACBBA5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 21:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED0016EBCB
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C42309B3;
	Mon,  2 Jun 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/tv9cTJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93722DA19
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892550; cv=none; b=ttnuVbGHYIpHv3KFpZ5waBHmh/0CBXNmXXADfnHUb1+flS4gMLkilNblBHPf3Ia9XO2f96Jf7Fp1SltKA6jVNX7T42hzKFEukMXODNGcxhJFELy1cJyAIulEgsCbAulAGgee+/R7mmITvE7OBWFfX78IJaBRRyXbopbJczusiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892550; c=relaxed/simple;
	bh=Kvx3uAqjJggLi1DATHITYErcbyIy/uA3bAn8jDjgGIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiiYrWdIsDLfhndu92iJDMWtSM1S+4mhg6Sq9KlMEkYLbF6yQirXIuDtUYB2W26xyFDVk4NTtTUELo/phzLRvgKTGYiSqJrzyIc6DdVpMJHi2es5/QrrUVpXDdUZI9Z2lQYpXXKwj1y6//b39pdND0EBae5fYNVDEg+SqAy36ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/tv9cTJ; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3dd89b3a644so62355435ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892545; x=1749497345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXuWSM2GCZ9T+i75KiasrPAv9lcjtTJZ6XXd+zYRNlg=;
        b=K/tv9cTJ6LEH+2NRbzc2tz4fYx9ECT0CRFez1+Fe4dWowB+PKAW2JKpb46whl2icGB
         /NT113kY7jjpkOlu3W7MmijtukTR/X4Llb7ifToQmZ12GeH9fqiK06EghmXKfIe0YoiI
         NIZpMo4MeWwcsvaSBcalQI3LxFLzSb3n/C+A4Ay75xrhomsQF32GXB3Ga7Y9KTPP6omm
         0kY3pFBJ+8w9u+jiqEvxlCiKQuYyfILuMibd/zYvbUbsIy3qgCnjH67m24BljADPsRqQ
         EpROFFC/06prLiH7GYA/HumifoQLtRrYUeZiD9C/M0sGj+POPpfcZxdgjdF10OECyc23
         jmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892545; x=1749497345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXuWSM2GCZ9T+i75KiasrPAv9lcjtTJZ6XXd+zYRNlg=;
        b=lmrCg9HsuDILc94Afb8wNSR6ZPsJDiH4udQar0zMYj9WKyO7xN4MGq7SlNhcKkeKvJ
         QYnetdo+bNyy4FEtb1bUDGa27NsFyM7WtkNW3Jz+sq68lKtMYbsM2Wssff/4+KZ++owr
         0Ri/zNE4dl+PXjrAatpfWX7UUoWPbcZsYm90JnGyX9tyP2eFJKPVzc0pQPR0ChquSnFD
         oLU0VnGZAfCFg+UelIz7BDgAr7EDUUZA29Z2HKsuQDhXahFOfY0da4TGxz+a0T4+6JXO
         dut606d/oW/P3Qx+PUmW5gnJh/3GThNfGLanN0vJ5nbt28f9lW/e4eEQM7KrQH3yPphx
         hZIg==
X-Forwarded-Encrypted: i=1; AJvYcCVvO+Z3aE2k9S94p74uoGJ7fKfjcsRAk53xNNYA7mw/JF3x2Xw4CdjYQpGepVcxKraV3a51yiUXRmLWfm7/8yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01hrXtR/vGwZ0eZyTLhwy3Z/pj03JdWSy+LAiukCv9ixoqjiB
	T9tcuOGD+buP2o756IZ9vVMI7NSodWcsVwDBxPALteAOs6Lf9pkkT1/T3NyzlHm02pY2/tIF2Dg
	QLUC/+jDsC2ZWtGYTiTip6rlHMA==
X-Google-Smtp-Source: AGHT+IHFmiRfGhHEuAQ8BSv3MIMbdR2lvVdsHAXbv8PPs+QRUvPwpjEs+PRrAmKCsaAFW76c2vibn0+6tinsiTYuug==
X-Received: from ilbbl7.prod.google.com ([2002:a05:6e02:32c7:b0:3dc:7303:c8cf])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:16cf:b0:3dc:9b89:6a3b with SMTP id e9e14a558f8ab-3ddb6854e4fmr9879575ab.8.1748892545634;
 Mon, 02 Jun 2025 12:29:05 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:53 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-9-coltonlewis@google.com>
Subject: [PATCH 08/17] perf: arm_pmuv3: Keep out of guest counter partition
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

If the PMU is partitioned, keep the driver out of the guest counter
partition and only use the host counter partition. Partitioning is
defined by the MDCR_EL2.HPMN register field and saved in
cpu_pmu->hpmn. The range 0..HPMN-1 is accessible by EL1 and EL0 while
HPMN..PMCR.N is reserved for EL2.

Define some functions that take HPMN as an argument and construct
mutually exclusive bitmaps for testing which partition a particular
counter is in. Note that despite their different position in the
bitmap, the cycle and instruction counters are always in the guest
partition.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h | 18 ++++++++
 arch/arm64/include/asm/kvm_pmu.h | 23 ++++++++++
 arch/arm64/kvm/pmu-part.c        | 73 ++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c         | 36 ++++++++++++++--
 4 files changed, 146 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 2ec0e5e83fc9..1687b4031ec2 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -227,6 +227,24 @@ static inline bool kvm_set_pmuserenr(u64 val)
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
index 83b81e7829bf..4098d4ad03d9 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -25,6 +25,11 @@ void kvm_host_pmu_init(struct arm_pmu *pmu);
 bool kvm_pmu_partition_supported(void);
 u8 kvm_pmu_hpmn(u8 host_counters);
 int kvm_pmu_partition(struct arm_pmu *pmu, u8 host_counters);
+bool kvm_pmu_is_partitioned(struct arm_pmu *pmu);
+u64 kvm_pmu_host_counter_mask(struct arm_pmu *pmu);
+u64 kvm_pmu_guest_counter_mask(struct arm_pmu *pmu);
+void kvm_pmu_host_counters_enable(void);
+void kvm_pmu_host_counters_disable(void);
 
 #else
 
@@ -52,6 +57,24 @@ static inline int kvm_pmu_partition(struct arm_pmu *pmu)
 	return -EPERM;
 }
 
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
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 7252a58f085c..33eeaa8faf7f 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -115,3 +115,76 @@ int kvm_pmu_partition(struct arm_pmu *pmu, u8 host_counters)
 
 	return 0;
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
+	return pmu->hpmn < *host_data_ptr(nr_event_counters);
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
+	return GENMASK(nr_counters - 1, pmu->hpmn);
+}
+
+/** kvm_pmu_guest_counter_mask() - Compute bitmask of guest-reserved counters
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
+/** kvm_pmu_host_counters_enable() - Enable host-reserved counters
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
+/** kvm_pmu_host_counters_disable() - Disable host-reserved counters
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
index bbcbc8e0c62a..f447a0f10e2b 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -823,12 +823,18 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
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
 
@@ -939,6 +945,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 
 	/* Always prefer to place a cycle counter into the cycle counter. */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) &&
+	    !kvm_pmu_is_partitioned(cpu_pmu) &&
 	    !armv8pmu_event_get_threshold(&event->attr)) {
 		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
 			return ARMV8_PMU_CYCLE_IDX;
@@ -954,6 +961,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * may not know how to handle it.
 	 */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_INST_RETIRED) &&
+	    !kvm_pmu_is_partitioned(cpu_pmu) &&
 	    !armv8pmu_event_get_threshold(&event->attr) &&
 	    test_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask) &&
 	    !armv8pmu_event_want_user_access(event)) {
@@ -965,7 +973,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * Otherwise use events counters
 	 */
 	if (armv8pmu_event_is_chained(event))
-		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
+		return armv8pmu_get_chain_idx(cpuc, cpu_pmu);
 	else
 		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
 }
@@ -1057,6 +1065,14 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
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
@@ -1064,6 +1080,9 @@ static void armv8pmu_reset(void *info)
 
 	bitmap_to_arr64(&mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
 
+	if (kvm_pmu_is_partitioned(cpu_pmu))
+		mask &= kvm_pmu_host_counter_mask(cpu_pmu);
+
 	/* The counter and interrupt enable registers are unknown at reset. */
 	armv8pmu_disable_counter(mask);
 	armv8pmu_disable_intens(mask);
@@ -1071,11 +1090,20 @@ static void armv8pmu_reset(void *info)
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
2.49.0.1204.g71687c7c1d-goog


