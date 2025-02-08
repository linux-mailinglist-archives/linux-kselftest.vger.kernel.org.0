Return-Path: <linux-kselftest+bounces-26072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B5A2D2D0
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 03:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9406B16B5A2
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B141865EB;
	Sat,  8 Feb 2025 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+SrCdeN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261D1465A1
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Feb 2025 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980089; cv=none; b=ur2vsDh29/OZTPwDB4QxhZJvXDu8c33OPT/6diqmGjl5Z8Yonjs0ebLo18Dv1ehtCNg1Eh3KG1QfGey6yTzi2mVXcRmAvFmsxyaym6X7dOXJlRM5abb2x6QqjodTwmq/3Ty2tPXX/3gHIFs5+o/01DUFw4645VdiOx1uuwa5hAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980089; c=relaxed/simple;
	bh=54WFiQgEG9ClLcOWk0cgITWUgNfnRUoa7zzjzbdKVlc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ScZXvH7r5csqc9x8oCEe0LqvA+MSzKU+l3UxpNsvXO3M/UlsgUnx6kYLRNc0dxyPm22GUsyLMMmUtsZYS1Js5yc/3lnib6GxwzP1C096lExLyi+oBJvb6c8vYOf0NguLeYc54aZJWD3JSxRPiEk5uCtFlYv918Hh1jG1jMSzQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+SrCdeN; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3d14a3f812fso15314825ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 18:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738980086; x=1739584886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yqMFoR6hUXpvMlUoVyEoFzEO0LlwQErfofhnNI8M7xE=;
        b=f+SrCdeNhs3ts0/KxzT81uyDQrpe/u6wAH6ojV4h2IQsN61c6FbkzvL3eQFeVf69RL
         FwkSDZclWN06pDEIApnYhSKfprRJcg6eJOhcVPAFepfK9zuZJLTq0Qh7ejcD/tqhMcrI
         PwS0hCPVQhBI7Gm53GUHNQLmKRvhEjb9oV6PLOQmEj8YbrhRM3rlLRlHGOhSYxY4GOrO
         YaUbQwImg2rhk1XEjlfiuo9ifyqOrt+xeLU7R+VSNT1l8EAWJWMcnb7aQipUlJuGcRt5
         YzD/2suv/nenGP1lfpSv7j/8w6tolSeRYjHs0DkLImy/4DV5/YAmOB2jA1Ayclo7KbQi
         ns2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980086; x=1739584886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqMFoR6hUXpvMlUoVyEoFzEO0LlwQErfofhnNI8M7xE=;
        b=BJDscJD3cguBYd1khrBwROdelzcy21NZTHgr5z4asUCP1hkPDArZ2QX2JBiXIrsYDt
         b/dMzCH4d5yUCQFcVTkMc3Ru6RJIyvO+BxRk+WQBjmcIksdzPERsR9k/Ak5z1RMUc1Sv
         NAMCX2c4elA51FNvLBQuulNbCb5rT7P5P40CWFTarillVuYRBw13Bcfd81fCTIHspJbh
         sCfa8RtHllLt7fVPsQ1YGkD4uWeVs+Woyz1rk4QEJGuGB6mmYKg3OcpYJRPbmGeI7j3H
         4IbsxmTNDRM9iUMN/YDjIMBkT/OjZZ1KX685U+5Eu1V6r9fqD+SUy3mb4ZLtsoSN69QB
         BpKg==
X-Forwarded-Encrypted: i=1; AJvYcCXwcdUUJGfZ6E5Hlf+DGXSHOmnh//hR6dzb+lYB9EYtUFz0Y56iF4WMHgLjAPP8pOWx2I+AuJ0SFxSy1zD0aI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5+Oy41JOnwBLF+j9EA6N4bGbuVGlfr2WlKo6UnPRzwXEos6F2
	H+vt4mf6S7ItM/uczTmykuKCojtFdjhVuvn+bbPVA5zGtpgrIG3AT+Gb2DAXGNHgme674PKwx1P
	m0yBUpnQlifk97zHqYDNxYw==
X-Google-Smtp-Source: AGHT+IGBfl5EUai4jUqGE9tVIABBshw6kSoM3m3UwCZuERUqk8K+xoXVDYPbIr/6/gGteryeIz+lvFvusHJBwx3+jg==
X-Received: from ilbed6.prod.google.com ([2002:a05:6e02:4806:b0:3ce:8db7:b87a])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:3785:b0:3d0:4e57:bbd9 with SMTP id e9e14a558f8ab-3d13dd4d375mr42700305ab.10.1738980086030;
 Fri, 07 Feb 2025 18:01:26 -0800 (PST)
Date: Sat,  8 Feb 2025 02:01:10 +0000
In-Reply-To: <20250208020111.2068239-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208020111.2068239-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250208020111.2068239-4-coltonlewis@google.com>
Subject: [RFC PATCH v2 3/4] perf: arm_pmuv3: Keep out of guest counter partition
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

If the PMU is partitioned, keep the driver out of the guest counter
partition and only use the host counter partition. Partitioning is
defined by the MDCR_EL2.HPMN register field and saved in
cpu_pmu->hpmn. The range 0..HPMN-1 is accessible by EL1 and EL0 while
HPMN..PMCR.N is reserved for EL2.

Define some macros that take HPMN as an argument and construct
mutually exclusive bitmaps for testing which partition a particular
counter is in. Note that despite their different position in the
bitmap, the cycle and instruction counters are always in the guest
partition.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c       | 73 +++++++++++++++++++++++++++++-----
 include/linux/perf/arm_pmuv3.h |  8 ++++
 2 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 39109260b161..01468ec9fead 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -754,15 +754,19 @@ static void armv8pmu_disable_event_irq(struct perf_event *event)
 	armv8pmu_disable_intens(BIT(event->hw.idx));
 }
 
-static u64 armv8pmu_getreset_flags(void)
+static u64 armv8pmu_getreset_flags(struct arm_pmu *cpu_pmu)
 {
 	u64 value;
 
 	/* Read */
 	value = read_pmovsclr();
 
+	if (cpu_pmu->partitioned)
+		value &= ARMV8_PMU_HOST_CNT_PART(cpu_pmu->hpmn);
+	else
+		value &= ARMV8_PMU_OVERFLOWED_MASK;
+
 	/* Write to clear flags */
-	value &= ARMV8_PMU_OVERFLOWED_MASK;
 	write_pmovsclr(value);
 
 	return value;
@@ -789,6 +793,18 @@ static void armv8pmu_disable_user_access(void)
 	update_pmuserenr(0);
 }
 
+static bool armv8pmu_is_guest_part(struct arm_pmu *cpu_pmu, u8 idx)
+{
+	return cpu_pmu->partitioned &&
+		(BIT(idx) & ARMV8_PMU_GUEST_CNT_PART(cpu_pmu->hpmn));
+}
+
+static bool armv8pmu_is_host_part(struct arm_pmu *cpu_pmu, u8 idx)
+{
+	return !cpu_pmu->partitioned ||
+		(BIT(idx) & ARMV8_PMU_HOST_CNT_PART(cpu_pmu->hpmn));
+}
+
 static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 {
 	int i;
@@ -797,6 +813,8 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 	if (is_pmuv3p9(cpu_pmu->pmuver)) {
 		u64 mask = 0;
 		for_each_set_bit(i, cpuc->used_mask, ARMPMU_MAX_HWEVENTS) {
+			if (armv8pmu_is_guest_part(cpu_pmu, i))
+				continue;
 			if (armv8pmu_event_has_user_read(cpuc->events[i]))
 				mask |= BIT(i);
 		}
@@ -805,6 +823,8 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 		/* Clear any unused counters to avoid leaking their contents */
 		for_each_andnot_bit(i, cpu_pmu->cntr_mask, cpuc->used_mask,
 				    ARMPMU_MAX_HWEVENTS) {
+			if (armv8pmu_is_guest_part(cpu_pmu, i))
+				continue;
 			if (i == ARMV8_PMU_CYCLE_IDX)
 				write_pmccntr(0);
 			else if (i == ARMV8_PMU_INSTR_IDX)
@@ -850,7 +870,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 		armv8pmu_disable_user_access();
 
 	/* Enable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
+	if (cpu_pmu->partitioned)
+		armv8pmu_mdcr_write(armv8pmu_mdcr_read() | ARMV8_PMU_MDCR_HPME);
+	else
+		armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
 
 	kvm_vcpu_pmu_resync_el0();
 }
@@ -858,7 +881,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	/* Disable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
+	if (cpu_pmu->partitioned)
+		armv8pmu_mdcr_write(armv8pmu_mdcr_read() & ~ARMV8_PMU_MDCR_HPME);
+	else
+		armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
 }
 
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
@@ -872,7 +898,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	/*
 	 * Get and reset the IRQ flags
 	 */
-	pmovsr = armv8pmu_getreset_flags();
+	pmovsr = armv8pmu_getreset_flags(cpu_pmu);
 
 	/*
 	 * Did an overflow occur?
@@ -930,6 +956,8 @@ static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
 	int idx;
 
 	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
+		if (armv8pmu_is_guest_part(cpu_pmu, idx))
+			continue;
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
@@ -946,6 +974,8 @@ static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
 	 * the lower idx must be even.
 	 */
 	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
+		if (armv8pmu_is_guest_part(cpu_pmu, idx))
+			continue;
 		if (!(idx & 0x1))
 			continue;
 		if (!test_and_set_bit(idx, cpuc->used_mask)) {
@@ -968,6 +998,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 
 	/* Always prefer to place a cycle counter into the cycle counter. */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) &&
+	    !cpu_pmu->partitioned &&
 	    !armv8pmu_event_get_threshold(&event->attr)) {
 		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
 			return ARMV8_PMU_CYCLE_IDX;
@@ -983,6 +1014,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * may not know how to handle it.
 	 */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_INST_RETIRED) &&
+	    !cpu_pmu->partitioned &&
 	    !armv8pmu_event_get_threshold(&event->attr) &&
 	    test_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask) &&
 	    !armv8pmu_event_want_user_access(event)) {
@@ -994,7 +1026,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * Otherwise use events counters
 	 */
 	if (armv8pmu_event_is_chained(event))
-		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
+		return armv8pmu_get_chain_idx(cpuc, cpu_pmu);
 	else
 		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
 }
@@ -1086,6 +1118,16 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 	return 0;
 }
 
+static void armv8pmu_reset_host_counters(struct arm_pmu *cpu_pmu)
+{
+	int idx;
+
+	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
+		if (armv8pmu_is_host_part(cpu_pmu, idx))
+			armv8pmu_write_evcntr(idx, 0);
+	}
+}
+
 static void armv8pmu_reset(void *info)
 {
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
@@ -1093,8 +1135,10 @@ static void armv8pmu_reset(void *info)
 
 	bitmap_to_arr64(&mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
 
-	if (cpu_pmu->partitioned)
+	if (cpu_pmu->partitioned) {
 		armv8pmu_partition(cpu_pmu->hpmn);
+		mask &= ARMV8_PMU_HOST_CNT_PART(cpu_pmu->hpmn);
+	}
 
 	/* The counter and interrupt enable registers are unknown at reset. */
 	armv8pmu_disable_counter(mask);
@@ -1103,11 +1147,20 @@ static void armv8pmu_reset(void *info)
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
+	if (cpu_pmu->partitioned)
+		armv8pmu_reset_host_counters(cpu_pmu);
+	else
+		pmcr = ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C;
 
 	/* Enable long event counter support where available */
 	if (armv8pmu_has_long_event(cpu_pmu))
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 115ee39f693a..5f8b143794ce 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -247,6 +247,14 @@
 #define ARMV8_PMU_OVSR_F		ARMV8_PMU_CNT_MASK_F
 /* Mask for writable bits is both P and C fields */
 #define ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_CNT_MASK_ALL
+
+/* Masks for guest and host counter partitions */
+#define ARMV8_PMU_HPMN_CNT_MASK(N)	GENMASK((N) - 1, 0)
+#define ARMV8_PMU_GUEST_CNT_PART(N)	(ARMV8_PMU_HPMN_CNT_MASK(N) | \
+					 ARMV8_PMU_CNT_MASK_C | \
+					 ARMV8_PMU_CNT_MASK_F)
+#define ARMV8_PMU_HOST_CNT_PART(N)	(ARMV8_PMU_CNT_MASK_ALL & \
+					 ~ARMV8_PMU_GUEST_CNT_PART(N))
 /*
  * PMXEVTYPER: Event selection reg
  */
-- 
2.48.1.502.g6dc24dfdaf-goog


