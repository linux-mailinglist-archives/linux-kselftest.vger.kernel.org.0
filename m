Return-Path: <linux-kselftest+bounces-35922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1FAEA7C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10503AB52D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F802F0C73;
	Thu, 26 Jun 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6pkSHax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4A2F2C69
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968361; cv=none; b=GdBWYQXg4WZitmxJhMaIR43bsFRJ0rQzNB16UsSNsr51B6qsbLdJ8QvKZIFP1s2H8gb02plYf3ewf8Y1jQmPgoSAXynR3x6QJZyCjQeo+Q93z9QjvxufhsBeRej6KnafqQIMtZ5SxUTaWHn+d3C4j4sqaktRz3bWlf7qnJtTLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968361; c=relaxed/simple;
	bh=FJaIRJNsEMYWuJ2zLQqRXmEvqCxduDf0sz7RXVyB6W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oRUUA52Kdznu5UJVewBhv0nZuqo45mHEo+E8QSAaOwqCf+hD+Ib2V2mn3gmf43T37LdqIGXQJrOP/DwqEKh9WhUCVwUl2ojDxN1CXjYwEXRqcmgc/SnZq9y+fBmSAui5ENq5aYtRRoyiHvwpEATNCPlMny58kUxadN/D7PoBF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6pkSHax; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so11638535ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jun 2025 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968357; x=1751573157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mMqYoZsK/epKwgd6CyfTf5pEmCnSON7Fq5dKdiRWdhs=;
        b=L6pkSHaxVFARbjGpfGpQvmIaZOKX7wxZKb7zS1FOz2MiDoUoIiZFmb9T+sQ2khBHZ4
         P+ZvzJ8b2Y7fR4ZcV9KBnqZyWipWBeaZINrr7NszHvd9+RDfi/6/uCZIQCI/jF2AUEjE
         bCAGTGc0eChZYLnBC+FK42kq2SSbstanXoSUTj+wDo9d9T/KdaWpooiPsyNfpTiV6KlL
         3LsYcWx93tGopm314PCR6TC4jjdMgqo9DIy0BYDzPHafB1xln7e6aqOZpPDI4UuM2eB6
         8nUl+aI83FLsCkgKtIf80l5yGxakvu4mXMKeAk8Yb+yKEILndWH5zxxTno3TL37cQRcc
         OxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968357; x=1751573157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMqYoZsK/epKwgd6CyfTf5pEmCnSON7Fq5dKdiRWdhs=;
        b=SSHFVV4ygvZJIbU1mFS2cDPGa9D2Z3oAxY/Xt5o2wjWMHNukfVQRc+88DSHMeHnkT6
         A7zSzVyz+Ozn37VBbud44CxqzTxx1KpWmDIEF5lp6yXc8mGrFXZj7TNPIKEN8ItPm+IU
         BrUWh7wtVx23l7HMIz7sScjW+pydxXbb4xlwQKNNDzYSotQCm0pEzmogI6ASNYaHCn8e
         eJUkvWgWLwuyX3cN4q76qvy0L3wopXbKfbWTT+ppTOI5w0vnUErjO/oAPxreIzgZhWBv
         hXog0uwHIWlffeQaeDaQnVfkhOfJfidP0BM4HvwZrTTARMmCDQBpMdAAylVaVKdewfY4
         Y+gw==
X-Forwarded-Encrypted: i=1; AJvYcCVfIm6agBKgZdNb0eNzCnX84CR7pj9ysw6rsPVbZoPhW3NNxJUF164DjV9vNN9/s0mYR76geBPqqJzD7Vq1Rlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8F6Dsepn0MkqlGNlXMbPpXWHpM3QSFszmDP9ns+qbzzBG/2Sx
	4T/7qpE/iNetsXaFuhjTQVEtRQPnHtID5vlL9iCjOlxSPeSuvrt9tlHn2XMfr392CAwSIVuBI0Y
	tavr7xuYstoLGdrVbWOFKQQ3e7A==
X-Google-Smtp-Source: AGHT+IFdNpatVUTOyeMi8epAV2vW9mg5K1vKFnbAchBnxALDFWUZgDhl9ssvMfuP0TtvfkXE9oLZZ6vS3hSy7zgqdA==
X-Received: from ilbee28.prod.google.com ([2002:a05:6e02:491c:b0:3df:31be:c2e5])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a92:cda1:0:b0:3df:2fda:e30b with SMTP id e9e14a558f8ab-3df4accf840mr12363705ab.21.1750968357514;
 Thu, 26 Jun 2025 13:05:57 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:42 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-7-coltonlewis@google.com>
Subject: [PATCH v3 06/22] perf: arm_pmuv3: Introduce method to partition the PMU
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
at EL1 on the host, partitioning is only allowed in VHE mode. Working
on nVHE mode would require a hypercall for every counter access in the
driver because the counters reserved for the host by HPMN are only
accessible to EL2.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h   | 14 ++++++
 arch/arm64/include/asm/arm_pmuv3.h |  5 ++
 arch/arm64/include/asm/kvm_pmu.h   |  6 +++
 arch/arm64/kvm/Makefile            |  2 +-
 arch/arm64/kvm/pmu-part.c          | 23 ++++++++++
 drivers/perf/arm_pmuv3.c           | 74 +++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmu.h       |  1 +
 7 files changed, 122 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kvm/pmu-part.c

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
index 32c003a7b810..e2057365ba73 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -173,6 +173,11 @@ static inline bool pmuv3_implemented(int pmuver)
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
index 86035b311269..3edbaa57bbf2 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -23,7 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o
 
-kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
+kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu-part.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
 kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
new file mode 100644
index 000000000000..f04c580c19c0
--- /dev/null
+++ b/arch/arm64/kvm/pmu-part.c
@@ -0,0 +1,23 @@
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
+	return kvm_supports_guest_pmuv3() &&
+		has_vhe();
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 3db9f4ed17e8..6358de6c9fab 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -35,6 +35,12 @@
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
@@ -500,6 +506,11 @@ static void armv8pmu_pmcr_write(u64 val)
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
@@ -1195,6 +1206,58 @@ struct armv8pmu_probe_info {
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
@@ -1209,10 +1272,10 @@ static void __armv8pmu_probe_pmu(void *info)
 
 	cpu_pmu->pmuver = pmuver;
 	probe->present = true;
+	cpu_pmu->hpmn_max = -1;
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	bitmap_set(cpu_pmu->cntr_mask,
-		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
+	bitmap_set(cpu_pmu->cntr_mask, 0, armv8pmu_pmcr_n_read());
 
 	/* Add the CPU cycles counter */
 	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask);
@@ -1221,6 +1284,13 @@ static void __armv8pmu_probe_pmu(void *info)
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
index fb382bcd4f4b..071cd2d1681c 100644
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


