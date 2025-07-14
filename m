Return-Path: <linux-kselftest+bounces-37297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96184B04B34
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74D51A65BD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AE7287502;
	Mon, 14 Jul 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpKodP4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49846280328
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533978; cv=none; b=imgBFr4HxbEXg+c8PXoZ8qfz5VYrMlZiblrEfMo7e5XEm5SUbgNZkdCmTXsgnutEDlTEqAoB04HzBjXz49exrXH0YNRbTlH4mkNNULKCZcKbQxmdjRfhdUB1FEra1yYf+fvzCYiuo5XmnQYEZCN4EGxhgsGoPchIPOhoQVcL7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533978; c=relaxed/simple;
	bh=DhNJxwtbMKN1Xjxkk4G2N2kwb2YustWbLKIc6yhbgV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A3hSGp+tD9TN3vlp7aqxsa0LxCVgMzKviFNFuHcwpCZNAzsYec7+hBjJ5wu/RAnZPzvbTz5XSzozGyNIp7QN1gmwXAbIqCYQ85EUUH+u2eXCzkjPvAICFJ9m1t3ZgUcGBXpjI8fZek7gByCzrvoJ34L6vAll2oGGzGUhRkHvpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpKodP4t; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2f75a1bb0easo2222048fac.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752533974; x=1753138774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHPilczBMGoAee/NxsWPBSFL6RDSqf4UCYQezF4YOII=;
        b=zpKodP4tinAhx/VsIb4Kc0Woi5Je7zKRvFbJw7pwes1f9E1OIy4CtMD2bAIuk1wSO+
         ekmZIzFiEzo0zw0+KsbelsZ9vvgaD0XNam6ZR5CURsG/LtdzdbbP5O9WjLlYMa3cgMP5
         pZLflIVxuW/nYNNeL94Qw335iqa5d1gElCRSRtcn6cVxcmqrq7mrGnpjKYrmO1KlCoqe
         O14DRgqC9/yFhgjxS8ENNU6TBdzIYnJO8cbtDZAZu+8KyF8pAmrkflzzjJak2DvZLP2j
         vQYSOP+ppu4vZewJh/f3C3hjvJotk//fkp6bRQdn9wB/JiPgGjZGFfVfEnNuprz7ArDK
         ws5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533974; x=1753138774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHPilczBMGoAee/NxsWPBSFL6RDSqf4UCYQezF4YOII=;
        b=w6+5MCC5CyqeDDlLYPFrvrHix5FB6+sgsvM0qFt7tjh8jpR/Z0VFx61GGzu2bXmcwE
         WzB4Hgsoc5eg/mpzEhn2yzZekQ1gFPJ7TB2/Y2N+iptaBd+zJRaVKIs+rBgV5qN+hNjw
         XdcqPSfCWYmqDVqPe+P+uwuZcNagq5g5jyzroOgAeF8iluzgU9wR1fy7d8SUjGAMP2jy
         c1uJiUpysPL/k7Ii1H9E/YAAyc0wOqEjspoEi5jfJa6EaXWqlqyopgxrPx9nAynO5Czo
         penYmPAQTLHYk+5Xawi8mjiayZYGFTrOFnIEc34P/9SKmwdNZtn+YRvhQ46xgU882IqK
         KlYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAbf1tyk+syOhqpypEnrx5yVc/DyoRoHZCEYlvXPT/7wwz9aeFjKLXAgIwJp8JbFt46xvM/YEMyIZwedBIIco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1NEwRV4Eg0K85/3vhSZ+iq2DQpRVkrujxoYuEOUu2rIpVe90R
	FLfoN+m8+sRKofg2FN5gFnHO5IWIfvlq7JBlJkgZgwPXsvGAEFIzqt/2QIT1CvTBIzVrRWQZT0C
	Rfni2X5bOQqPajLToxKbmEzdVTA==
X-Google-Smtp-Source: AGHT+IEAWWYG/VIKx8r6iZPZ1qTs8MCzlnhG4Qeg0PPUlKt/cLSyfJW7JBrJ/5M/Zp6SVe/k2s23ZgEdNfoQV0rAxQ==
X-Received: from oabna17.prod.google.com ([2002:a05:6870:6c11:b0:2ef:e9aa:27e6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:a987:b0:2e9:365:d0d3 with SMTP id 586e51a60fabf-2ff26a28925mr10157294fac.21.1752533974416;
 Mon, 14 Jul 2025 15:59:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:58:58 +0000
In-Reply-To: <20250714225917.1396543-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714225917.1396543-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714225917.1396543-5-coltonlewis@google.com>
Subject: [PATCH v4 04/23] perf: arm_pmuv3: Introduce method to partition the PMU
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
support a partitioned on nVHE we'd need to explicitly disable guest
counters on every exit and reset HPMN to place all counters in the
first range.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h   | 14 ++++++
 arch/arm64/include/asm/arm_pmuv3.h |  5 ++
 arch/arm64/include/asm/kvm_pmu.h   |  6 +++
 arch/arm64/kvm/Makefile            |  2 +-
 arch/arm64/kvm/pmu-direct.c        | 22 +++++++++
 drivers/perf/arm_pmuv3.c           | 74 +++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmu.h       |  1 +
 7 files changed, 121 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kvm/pmu-direct.c

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 2ec0e5e83fc9..49b1f2d7842d 100644
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
@@ -228,6 +232,11 @@ static inline bool kvm_set_pmuserenr(u64 val)
 
 static inline void kvm_vcpu_pmu_resync_el0(void) {}
 
+static inline bool has_vhe(void)
+{
+	return false;
+}
+
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
 #define ARMV8_PMU_DFR_VER_V3P1      0x4
@@ -242,6 +251,11 @@ static inline bool pmuv3_implemented(int pmuver)
 		 pmuver == ARMV8_PMU_DFR_VER_NI);
 }
 
+static inline bool is_pmuv3p1(int pmuver)
+{
+	return pmuver >= ARMV8_PMU_DFR_VER_V3P1;
+}
+
 static inline bool is_pmuv3p4(int pmuver)
 {
 	return pmuver >= ARMV8_PMU_DFR_VER_V3P4;
diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index cf2b2212e00a..27c4d6d47da3 100644
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
index 6c961e877804..8a2ed02e157d 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -46,6 +46,7 @@ struct arm_pmu_entry {
 };
 
 bool kvm_supports_guest_pmuv3(void);
+bool kvm_pmu_partition_supported(void);
 #define kvm_arm_pmu_irq_initialized(v)	((v)->arch.pmu.irq_num >= VGIC_NR_SGIS)
 u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
 void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
@@ -115,6 +116,11 @@ static inline bool kvm_supports_guest_pmuv3(void)
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
index 86035b311269..7ce842217575 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -23,7 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o
 
-kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
+kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-direct.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
 kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
new file mode 100644
index 000000000000..9423d6f65059
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
+ * Partitioning is only supported in VHE mode (with PMUv3, assumed
+ * since we are in the PMUv3 driver)
+ *
+ * Return: True if partitioning is possible, false otherwise
+ */
+bool kvm_pmu_partition_supported(void)
+{
+	return has_vhe();
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index c2e3672e1228..294ccbdc3816 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -40,6 +40,12 @@
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
 
+static int reserved_host_counters __read_mostly = -1;
+
+module_param(reserved_host_counters, int, 0);
+MODULE_PARM_DESC(reserved_host_counters,
+		 "PMU Partition: -1 = No partition; +N = Reserve N counters for the host");
+
 /*
  * ARMv8 Architectural defined events, not all of these may
  * be supported on any given implementation. Unsupported events will
@@ -505,6 +511,11 @@ static void armv8pmu_pmcr_write(u64 val)
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
@@ -1200,6 +1211,58 @@ struct armv8pmu_probe_info {
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
+	if (!armv8pmu_reservation_is_valid(host_counters))
+		return -EINVAL;
+
+	nr_counters = armv8pmu_pmcr_n_read();
+	hpmn = nr_counters - host_counters;
+
+	pmu->hpmn_max = hpmn;
+
+	bitmap_clear(pmu->cntr_mask, 0, hpmn);
+	bitmap_set(pmu->cntr_mask, hpmn, host_counters);
+	clear_bit(ARMV8_PMU_CYCLE_IDX, pmu->cntr_mask);
+
+	if (pmuv3_has_icntr())
+		clear_bit(ARMV8_PMU_INSTR_IDX, pmu->cntr_mask);
+
+	pr_info("Partitioned PMU with HPMN %u", hpmn);
+
+	return 0;
+}
+
 static void __armv8pmu_probe_pmu(void *info)
 {
 	struct armv8pmu_probe_info *probe = info;
@@ -1214,10 +1277,10 @@ static void __armv8pmu_probe_pmu(void *info)
 
 	cpu_pmu->pmuver = pmuver;
 	probe->present = true;
+	cpu_pmu->hpmn_max = -1;
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	bitmap_set(cpu_pmu->cntr_mask,
-		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
+	bitmap_set(cpu_pmu->cntr_mask, 0, armv8pmu_pmcr_n_read());
 
 	/* Add the CPU cycles counter */
 	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask);
@@ -1226,6 +1289,13 @@ static void __armv8pmu_probe_pmu(void *info)
 	if (pmuv3_has_icntr())
 		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask);
 
+	if (reserved_host_counters >= 0) {
+		if (kvm_pmu_partition_supported())
+			WARN_ON(armv8pmu_partition(cpu_pmu, reserved_host_counters));
+		else
+			pr_err("PMU partition is not supported");
+	}
+
 	pmceid[0] = pmceid_raw[0] = read_pmceid0();
 	pmceid[1] = pmceid_raw[1] = read_pmceid1();
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 6dc5e0cd76ca..2c79dc0f09af 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -122,6 +122,7 @@ struct arm_pmu {
 
 	/* Only to be used by ACPI probing code */
 	unsigned long acpi_cpuid;
+	int		hpmn_max; /* MDCR_EL2.HPMN: counter partition pivot */
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
-- 
2.50.0.727.gbf7dc18ff4-goog


