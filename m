Return-Path: <linux-kselftest+bounces-47318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40181CB114B
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7952D30223C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C830B502;
	Tue,  9 Dec 2025 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boGa2pPi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35E3093A0
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313559; cv=none; b=N1I/rxBx027aUxZBabqSvxLyVfssJfag9FnzfHODxb82C7JkaI9kwCjd1shIO2HG97UNFVUnbk6WU3k2HV8PKw7Sm0wh/isZE3qRRLLIthzRSsg78N1hLi2j4vAOoAl0SGJEI3QQBWB4Qtr/5FF7/VCUYZOc015G10awL6bE4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313559; c=relaxed/simple;
	bh=s4DMz/+Tu3ABN3IwWkCYAvfYICvEYeC2cwgRdRHILBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=toZm2YmUA2ew3AsvdSjVKy1/wUWmycJTSqrAY2zDxuq0fjLd8ehvlMotak0tplpxaRrohVFNEvCGObJv3+jfI7ekcg0OfqIb8GCawDTpnP0DhA+Uq60fjU4qh8mzok+Gr58ft9oJvcWSzkhNM5an81TL7zd9mKyu1HiL0SIKMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=boGa2pPi; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7c6d917f184so5665167a34.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313553; x=1765918353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Biho4eq7PcKZkdHijX/jqQ9/pP3kvOPAP71ESOGpkwg=;
        b=boGa2pPiUyg9Dbp+PbjQN2x+iqUOkk+xYB0y5LDDHPsWg5c8kENSPE3m2veY94Zr+9
         UkG31rSAs2xS5kcBhTnY63y8pqapso/aCYt6OLVWeY1dPlUp/psJ222D88Zs8ZxIj+7D
         t+aRnFuCFEXtnFcvDJizir2gxLhwMGSrmva9F5A0bkLMyHs7rLwqp0xiTBSJrwuwOMeL
         B9LWX3yfMqsQRVtatqOzox9hlkoJr6Giauo5J8WZ70yeGJYCC1S9Ol+xn+vKiGWE88SD
         iKF52i7rDKzqOXFybO4rsFHDtox/dtibuf6TOXTtBtnVLVymgwhrfs7mSzpFf2slSucp
         b++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313553; x=1765918353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Biho4eq7PcKZkdHijX/jqQ9/pP3kvOPAP71ESOGpkwg=;
        b=vzo9u29oqytL6DxBk4+0ns9/Xy593inDh93yO4hRpvKJ0th63PxQCTMOGCQoLbKDUi
         ka9b8gmHkFKU/dBpmG85c3Bzj/ECTyuOIqTWXXgngUwPxFIo+n12e7h4eOPMtQoyity4
         evQc5qOKamioUtG5I9Tqe7wOUTBaxneS2EXNriwpT/0njXBH9OGokkF5zKL6fMs8k06X
         2r0qrYo51M/cNmxKK3eq7DZA7Wouv9y2sDFjNsNkTwTizY1Qpzbn5/N0RLuWcYalef/y
         9nOArqgdlUrXiezsxlODWJlRVr45fj6iU6o7+yXhw83/bIrue+6p0h0oKsSGdHfDUA8T
         2I1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDN/F0HfSHkLga6WJ7TgnGDLzNdlxfgqBMwPBdm5oYoIaQd/KBpN4zQxaITZkrUv97YrjPgc3TYLw41/ZWZNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxiolqLHEzjCB3ZxS2ukPBNHYyDBzP1/avyx+FN0FnQcRqD0p
	3mYc1s4T60vMoELtKgCTQ7aA8pS700GSZH1wDKtBpPMjMOtpn30y2LJjr2WU8Qu5yWFrchq74nh
	32MYrXC8OWZ/KOPlvuRryyod83w==
X-Google-Smtp-Source: AGHT+IFf/qB0CwPTPv5iYUHXY++A0PWp+sPV3KJqa4c1lU2WnLn00JaFUZc1nigPyWTnlRiGdglDaVN896UPUMc8Mg==
X-Received: from otir6.prod.google.com ([2002:a9d:5cc6:0:b0:7c7:6b86:cae6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:681a:b0:7c6:d001:afb2 with SMTP id 46e09a7af769-7cacec4c4bcmr53642a34.35.1765313552927;
 Tue, 09 Dec 2025 12:52:32 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:04 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-8-coltonlewis@google.com>
Subject: [PATCH v5 07/24] perf: arm_pmuv3: Introduce method to partition the PMU
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

For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
counters into two ranges where counters 0..HPMN-1 are accessible by
EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
EL2.

Create module parameter reserved_host_counters to reserve a number of
counters for the host. This number is set at boot because the perf
subsystem assumes the number of counters will not change after the PMU
is probed.

Introduce the function armv8pmu_partition() to modify the PMU driver's
cntr_mask of available counters to exclude the counters being reserved
for the guest and record reserved_guest_counters as the maximum
allowable value for HPMN.

Due to the difficulty this feature would create for the driver running
in nVHE mode, partitioning is only allowed in VHE mode. In order to
support a partitioning on nVHE we'd need to explicitly disable guest
counters on every exit and reset HPMN to place all counters in the
first range.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h   |  4 ++
 arch/arm64/include/asm/arm_pmuv3.h |  5 ++
 arch/arm64/include/asm/kvm_pmu.h   |  8 +++
 arch/arm64/kvm/Makefile            |  2 +-
 arch/arm64/kvm/pmu-direct.c        | 22 +++++++++
 drivers/perf/arm_pmuv3.c           | 78 +++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmu.h       |  1 +
 7 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kvm/pmu-direct.c

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 2ec0e5e83fc98..636b1aab9e8d2 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -221,6 +221,10 @@ static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
 	return false;
 }
 
+static inline bool kvm_pmu_partition_supported(void)
+{
+	return false;
+}
 static inline bool kvm_set_pmuserenr(u64 val)
 {
 	return false;
diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index cf2b2212e00a2..27c4d6d47da31 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -171,6 +171,11 @@ static inline bool pmuv3_implemented(int pmuver)
 		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
 }
 
+static inline bool is_pmuv3p1(int pmuver)
+{
+	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P1;
+}
+
 static inline bool is_pmuv3p4(int pmuver)
 {
 	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 6c961e8778047..63bff75e4f8dd 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -45,7 +45,10 @@ struct arm_pmu_entry {
 	struct arm_pmu *arm_pmu;
 };
 
+extern int armv8pmu_hpmn_max;
+
 bool kvm_supports_guest_pmuv3(void);
+bool kvm_pmu_partition_supported(void);
 #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
@@ -115,6 +118,11 @@ static inline bool kvm_supports_guest_pmuv3(void)
 	return false;
 }
 
+static inline bool kvm_pmu_partition_supported(void)
+{
+	return false;
+}
+
 #define kvm_arm_pmu_irq_initialized(v)	(false)
 static inline u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu,
 					    u64 select_idx)
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 3ebc0570345cc..baf0f296c0e53 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -26,7 +26,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o \
 	 vgic/vgic-v5.o
 
-kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
+kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-direct.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
 kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
new file mode 100644
index 0000000000000..0d38265b6f290
--- /dev/null
+++ b/arch/arm64/kvm/pmu-direct.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Colton Lewis <coltonlewis@google.com>
+ */
+
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_pmu.h>
+
+/**
+ * kvm_pmu_partition_supported() - Determine if partitioning is possible
+ *
+ * Partitioning is only supported in VHE mode with PMUv3
+ *
+ * Return: True if partitioning is possible, false otherwise
+ */
+bool kvm_pmu_partition_supported(void)
+{
+	return has_vhe() &&
+		system_supports_pmuv3();
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 513122388b9da..379d1877a61ba 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -42,6 +42,13 @@
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
 
+static int reserved_host_counters __read_mostly = -1;
+int armv8pmu_hpmn_max = -1;
+
+module_param(reserved_host_counters, int, 0);
+MODULE_PARM_DESC(reserved_host_counters,
+		 "PMU Partition: -1 = No partition; +N = Reserve N counters for the host");
+
 /*
  * ARMv8 Architectural defined events, not all of these may
  * be supported on any given implementation. Unsupported events will
@@ -532,6 +539,11 @@ static void armv8pmu_pmcr_write(u64 val)
 	write_pmcr(val);
 }
 
+static u64 armv8pmu_pmcr_n_read(void)
+{
+	return FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read());
+}
+
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
 	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
@@ -1299,6 +1311,61 @@ struct armv8pmu_probe_info {
 	bool present;
 };
 
+/**
+ * armv8pmu_reservation_is_valid() - Determine if reservation is allowed
+ * @host_counters: Number of host counters to reserve
+ *
+ * Determine if the number of host counters in the argument is an
+ * allowed reservation, 0 to NR_COUNTERS inclusive.
+ *
+ * Return: True if reservation allowed, false otherwise
+ */
+static bool armv8pmu_reservation_is_valid(int host_counters)
+{
+	return host_counters >= 0 &&
+		host_counters <= armv8pmu_pmcr_n_read();
+}
+
+/**
+ * armv8pmu_partition() - Partition the PMU
+ * @pmu: Pointer to pmu being partitioned
+ * @host_counters: Number of host counters to reserve
+ *
+ * Partition the given PMU by taking a number of host counters to
+ * reserve and, if it is a valid reservation, recording the
+ * corresponding HPMN value in the hpmn_max field of the PMU and
+ * clearing the guest-reserved counters from the counter mask.
+ *
+ * Return: 0 on success, -ERROR otherwise
+ */
+static int armv8pmu_partition(struct arm_pmu *pmu, int host_counters)
+{
+	u8 nr_counters;
+	u8 hpmn;
+
+	if (!armv8pmu_reservation_is_valid(host_counters)) {
+		pr_err("PMU partition reservation of %d host counters is not valid", host_counters);
+		return -EINVAL;
+	}
+
+	nr_counters = armv8pmu_pmcr_n_read();
+	hpmn = nr_counters - host_counters;
+
+	pmu->hpmn_max = hpmn;
+	armv8pmu_hpmn_max = hpmn;
+
+	bitmap_clear(pmu->cntr_mask, 0, hpmn);
+	bitmap_set(pmu->cntr_mask, hpmn, host_counters);
+	clear_bit(ARMV8_PMU_CYCLE_IDX, pmu->cntr_mask);
+
+	if (pmuv3_has_icntr())
+		clear_bit(ARMV8_PMU_INSTR_IDX, pmu->cntr_mask);
+
+	pr_info("Partitioned PMU with %d host counters -> %u guest counters", host_counters, hpmn);
+
+	return 0;
+}
+
 static void __armv8pmu_probe_pmu(void *info)
 {
 	struct armv8pmu_probe_info *probe = info;
@@ -1313,10 +1380,10 @@ static void __armv8pmu_probe_pmu(void *info)
 
 	cpu_pmu->pmuver = pmuver;
 	probe->present = true;
+	cpu_pmu->hpmn_max = -1;
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	bitmap_set(cpu_pmu->cntr_mask,
-		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
+	bitmap_set(cpu_pmu->cntr_mask, 0, armv8pmu_pmcr_n_read());
 
 	/* Add the CPU cycles counter */
 	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask);
@@ -1325,6 +1392,13 @@ static void __armv8pmu_probe_pmu(void *info)
 	if (pmuv3_has_icntr())
 		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask);
 
+	if (reserved_host_counters >= 0) {
+		if (kvm_pmu_partition_supported())
+			armv8pmu_partition(cpu_pmu, reserved_host_counters);
+		else
+			pr_err("PMU partition is not supported");
+	}
+
 	pmceid[0] = pmceid_raw[0] = read_pmceid0();
 	pmceid[1] = pmceid_raw[1] = read_pmceid1();
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 93c9a26492fcf..69071e887f98f 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -128,6 +128,7 @@ struct arm_pmu {
 
 	/* Only to be used by ACPI probing code */
 	unsigned long acpi_cpuid;
+	int		hpmn_max; /* MDCR_EL2.HPMN: counter partition pivot */
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
-- 
2.52.0.239.gd5f0c6e74e-goog


