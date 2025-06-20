Return-Path: <linux-kselftest+bounces-35476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4BAE2513
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3DF7B1297
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 22:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE26024DD1C;
	Fri, 20 Jun 2025 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="befor7Je"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A42475C2
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457929; cv=none; b=PHDSIDWkHT9ay67gVVfx3uKby+rh2JUhK+eyzOyXw+CIx//CeIgg5gp3EuYH5juYkOfaxL9EBNOaXryvO/qu7Sx1N0NWZT95L72ecPhh0JZTipwiMjvRS+W2HMV3lvxjIMuA+RiauIajS35RKliozVJQwm8tUKuVWa66T8svC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457929; c=relaxed/simple;
	bh=9GgWD1MN9AupT6yYClwdM+lZgz+6vMs8VB/PG0zJWr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fHY77n4inwlcGgqOB6Ro7eMsV1APZpA34HB9SBURIPtTxy4/ZWqgobgBxIrtXXouIWaqjudZQQRjdrLBTZvFrccM/RD1QzrzsO53Ax/Sd+GIvqEYWTapN6ao8O3v6HcIpuDkOH1y+1C6yJfM8NSWw7SB5hvCJnSMt6OyHIWGLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=befor7Je; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddc5137992so27490625ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750457924; x=1751062724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CI3k8EjFmwTOYcPqsV3PhQ8+RSg8JDcAcfT+x1n6dsQ=;
        b=befor7JeIMa03LhxJj8M3qtGKcEusulZiZqdoKphiJPDxhEAAwNa39RA3tTR4wwkRC
         QqQppu6MhhZZilTvzIuvMvSXNLZ3QOmi7yJlmwTU03eiqDevogq6oteFFybsAGUPPQPO
         jOsInvQU0T1c/v8uZqKcjztaWP6b+Anhic7Fz/LVxCq5HPROyeAKXABqhSfY4Bey9eVg
         yQ7X43NuK2ylYGxHxUeLEVHGB+mwNafU+egYxLviQqi2KtsS9H5wrT6Gw+iX9W5aPVLI
         hX9pLrV7FsbX6jtgLkHQEp4AIWnYn9gZ4WsvkXTkhNRM6aay2q+924HF6yi47F1ZaY0v
         wK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457924; x=1751062724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CI3k8EjFmwTOYcPqsV3PhQ8+RSg8JDcAcfT+x1n6dsQ=;
        b=gISH+A4aWT/DYHLUGk8mbtiV52dEbYuv6JsFsxc2M4/Yb846/DvoAkbWSG0uhZsA0U
         Wy6n3Ss2MbLYCBslHjJETEfALJXnnROel+bZBompddkBfmHpEDS5DIKBwlBaP5QaWvwb
         fIVykClGOsHY8IkUfqd/EiWJliygT01dw9PozohvzbxFacA1aSJSjmRW9lPri/drEeTW
         Drv5vJCmQsi4PVYFno6n5u058usgLXx2N1uuXXhF4JgfWt3DPE8HhjZ1X4bSXQhlHBni
         EFe7Dt63U4J46nJsxvSIyVwXgVHhFKy110OW1Jmh3mBE9pzbVVJTDZQo+YLU2OZqu7Ne
         5unA==
X-Forwarded-Encrypted: i=1; AJvYcCU4gN+H3aas9Mv1G81hqs1uzpZp+R903ZLkrkb9sUDDGKSm+aX5KLJXj1NaGrEKqQPZ6/cp/aG83ZO6PLq6ITY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXEKDFt3/fBDXY2GekxInO1yYbHnIX/MhXCGFQ95AKv5gcazTH
	OBbFto+Au4pziYT4mmmgDPxZFwY1miZM4kSiDfB1udGnR3tw5phjLje8015/6h28n1yDze1B0FD
	zb9beXeIAvPUpsye+Gqy0VxWKcQ==
X-Google-Smtp-Source: AGHT+IGRzFrNkTKRncgvh4xo99Bcu003VZXHoGW3TcBgBpmaK0gzPhj85w0EWM+POhiHIrJPWFM8l3F3ufOL+8v7Xw==
X-Received: from ilbcp2.prod.google.com ([2002:a05:6e02:3982:b0:3dd:c6fb:13fb])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:351f:b0:3dd:f948:8539 with SMTP id e9e14a558f8ab-3de38c1c186mr52207735ab.2.1750457924241;
 Fri, 20 Jun 2025 15:18:44 -0700 (PDT)
Date: Fri, 20 Jun 2025 22:13:08 +0000
In-Reply-To: <20250620221326.1261128-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250620221326.1261128-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250620221326.1261128-9-coltonlewis@google.com>
Subject: [PATCH v2 07/23] perf: pmuv3: Introduce method to partition the PMU
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

For PMUv3, the register field MDCR_EL2.HPMN partitiones the PMU
counters into two ranges where counters 0..HPMN-1 are accessible by
EL1 and, if allowed, EL0 while counters HPMN..N are only accessible by
EL2.

Create module parameters partition_pmu and reserved_guest_counters to
reserve a number of counters for the guest. These numbers are set at
boot because the perf subsystem assumes the number of counters will
not change after the PMU is probed.

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
 arch/arm/include/asm/arm_pmuv3.h   | 10 ++++
 arch/arm64/include/asm/arm_pmuv3.h |  5 ++
 drivers/perf/arm_pmuv3.c           | 95 +++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmu.h       |  1 +
 4 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 2ec0e5e83fc9..9dc43242538c 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -228,6 +228,11 @@ static inline bool kvm_set_pmuserenr(u64 val)
 
 static inline void kvm_vcpu_pmu_resync_el0(void) {}
 
+static inline bool has_vhe(void)
+{
+	return false;
+}
+
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
 #define ARMV8_PMU_DFR_VER_V3P1      0x4
@@ -242,6 +247,11 @@ static inline bool pmuv3_implemented(int pmuver)
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
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 3db9f4ed17e8..26230cd4175c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -35,6 +35,17 @@
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_ACCESS		0xEC
 #define ARMV8_THUNDER_PERFCTR_L1I_CACHE_PREF_MISS		0xED
 
+static bool partition_pmu __read_mostly;
+static u8 reserved_guest_counters __read_mostly;
+
+module_param(partition_pmu, bool, 0);
+MODULE_PARM_DESC(partition_pmu,
+		 "Partition the PMU into host and guest VM counters [y/n]");
+
+module_param(reserved_guest_counters, byte, 0);
+MODULE_PARM_DESC(reserved_guest_counters,
+		 "How many counters to reserve for guest VMs [0-$NR_COUNTERS]");
+
 /*
  * ARMv8 Architectural defined events, not all of these may
  * be supported on any given implementation. Unsupported events will
@@ -500,6 +511,11 @@ static void armv8pmu_pmcr_write(u64 val)
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
@@ -1195,6 +1211,74 @@ struct armv8pmu_probe_info {
 	bool present;
 };
 
+/**
+ * armv8pmu_reservation_is_valid() - Determine if reservation is allowed
+ * @guest_counters: Number of host counters to reserve
+ *
+ * Determine if the number of host counters in the argument is
+ * allowed. It is allowed if it will produce a valid value for
+ * register field MDCR_EL2.HPMN.
+ *
+ * Return: True if reservation allowed, false otherwise
+ */
+static bool armv8pmu_reservation_is_valid(u8 guest_counters)
+{
+	return guest_counters <= armv8pmu_pmcr_n_read();
+}
+
+/**
+ * armv8pmu_partition_supported() - Determine if partitioning is possible
+ *
+ * Partitioning is only supported in VHE mode (with PMUv3, assumed
+ * since we are in the PMUv3 driver)
+ *
+ * Return: True if partitioning is possible, false otherwise
+ */
+static bool armv8pmu_partition_supported(void)
+{
+	return has_vhe();
+}
+
+/**
+ * armv8pmu_partition() - Partition the PMU
+ * @pmu: Pointer to pmu being partitioned
+ * @guest_counters: Number of host counters to reserve
+ *
+ * Partition the given PMU by taking a number of host counters to
+ * reserve and, if it is a valid reservation, recording the
+ * corresponding HPMN value in the hpmn field of the PMU and clearing
+ * the guest-reserved counters from the counter mask.
+ *
+ * Passing 0 for @guest_counters has the effect of disabling partitioning.
+ *
+ * Return: 0 on success, -ERROR otherwise
+ */
+static int armv8pmu_partition(struct arm_pmu *pmu, u8 guest_counters)
+{
+	u8 nr_counters;
+	u8 hpmn;
+
+	if (!armv8pmu_reservation_is_valid(guest_counters))
+		return -EINVAL;
+
+	nr_counters = armv8pmu_pmcr_n_read();
+	hpmn = guest_counters;
+
+	pmu->hpmn_max = hpmn;
+
+	/* Inform host driver of available counters */
+	bitmap_clear(pmu->cntr_mask, 0, hpmn);
+	bitmap_set(pmu->cntr_mask, hpmn, nr_counters - hpmn);
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
@@ -1209,10 +1293,10 @@ static void __armv8pmu_probe_pmu(void *info)
 
 	cpu_pmu->pmuver = pmuver;
 	probe->present = true;
+	cpu_pmu->hpmn_max = -1;
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	bitmap_set(cpu_pmu->cntr_mask,
-		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
+	bitmap_set(cpu_pmu->cntr_mask, 0, armv8pmu_pmcr_n_read());
 
 	/* Add the CPU cycles counter */
 	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask);
@@ -1221,6 +1305,13 @@ static void __armv8pmu_probe_pmu(void *info)
 	if (pmuv3_has_icntr())
 		set_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask);
 
+	if (partition_pmu) {
+		if (armv8pmu_partition_supported())
+			WARN_ON(armv8pmu_partition(cpu_pmu, reserved_guest_counters));
+		else
+			pr_err("PMU partition is not supported");
+	}
+
 	pmceid[0] = pmceid_raw[0] = read_pmceid0();
 	pmceid[1] = pmceid_raw[1] = read_pmceid1();
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 1de206b09616..95f2b800e63d 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -130,6 +130,7 @@ struct arm_pmu {
 
 	/* Only to be used by ACPI probing code */
 	unsigned long acpi_cpuid;
+	u8		hpmn_max; /* MDCR_EL2.HPMN: counter partition pivot */
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
-- 
2.50.0.714.g196bf9f422-goog


