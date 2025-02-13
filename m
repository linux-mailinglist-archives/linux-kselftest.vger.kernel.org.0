Return-Path: <linux-kselftest+bounces-26574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204BA34D2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B664F1892115
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6127128E;
	Thu, 13 Feb 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2LAPH5rg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509C2661A2
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469926; cv=none; b=kXIZNDulM2Y52cJdzGGH/hZJV5FAEyKvDwgmFWrE9F0HRaYaRw6z10I9fkxEOnZnQPyPIDqN7o12LTPqdZ9q5R2gPcXG9SSqZWh+pU9OK/UrTkopQFBk5ShzwoVpN4Uyx75KFMyVNiVYwdYMVfEbevwy4K1P9Zzyfm0FxH2B8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469926; c=relaxed/simple;
	bh=84RlBgtnS+vuV+iG35a3aP9MsFf/F5xe9TXE8WhKGd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ry28KGV2xlDVpjUSj84jcAsIHefpICNWWFW2eRejzyuMGEMWVEkc7a66iQTHu/2I84d6FZP0jDKf5B78rqpZ0vPWR6QnUlUWxD8MJS6qol680SIiIzW9VQp/Erh5piZj1tz6sTB0JOIawbIOuMLuMauYLBCHIySOCIa2RmfAlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2LAPH5rg; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so21042865ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739469922; x=1740074722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9KLmBjf90Z0uIASDlFj3XafjAFYWcbGrlTVzUIs7VY=;
        b=2LAPH5rgMpcvAGPmGWeqlIROVXKDaYXqwQUJvZL9NnfUxG+UPhzhBmozbrBn3UHZtx
         AUHA+6+m91QKlZIMuAYbKapmRZLvyFEE+8cRs3JlwfLU82UG4nTvWO8wTizBRx8VIYi7
         jGfBK3yWQnweKxyVIHBEHH7nFdgYAe75Bqo8uLpRlaBfDvGCeGzS791SYvcbjS9/UU3A
         LFA22iYDTuszIQENmA42JDJ7tPHcd/+CvFRmAI+PDdjQiKeVzX0UiBbPu3m3V6b+N3mW
         /n86O3XX5pK5a+HDyxQg+I85VKTH3IrvlsBajjHV828/kDwq/ixJYHiNxksHkfcwjaff
         G9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469922; x=1740074722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9KLmBjf90Z0uIASDlFj3XafjAFYWcbGrlTVzUIs7VY=;
        b=nWaAhsguu6zwMfiwFuIj0CJgS6LVsUKlFWmFj1tSo48jq4kFVM4rQOww6H6oC/MyEH
         b47MwYoM1k3MsgfmoMNg3itD7+zfT9sUgg3RbJFjxo/b2lsXin4DMBAsVWTcb2hxfNmp
         nrksEvhgC3ck1/5/VDU2eOOLciCPjEkI4+EH2gJZ01q5RVazsPYzIHLGUv3/bw3ChLSk
         RjR172KF8gj9wDH2rBpEGlfW+f3Bmi/myZIj5rJGm3blyfyeXxd9rZUGsPoSg936D3eI
         jBIG4W2cTwYSn9o4wLG7LpB2Kblh4OluSzhjtCtn18OeAejoQTs+6Qvr7mE46uYd1QkN
         26XA==
X-Forwarded-Encrypted: i=1; AJvYcCUljw4ntmdAoqZaCJveBHJTuybvUboHWNVTIaniSNb249Yj8oxrIW5LRf/qntFDPOhX+eG1WZNsrcjH1EwODDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvE3Naq7sPB569HtuG84x/SO7LfqnUqUu0oLmzxpmdfsKTETLg
	cW8U2nmI3ORFqPSn/hyjkHIkGepVqWYfoN7yAEW/0GIwdnsZoKe39taAkGwCPfxIai3zZpV1omj
	tDFJNqI2PE4/51NLcuTekXw==
X-Google-Smtp-Source: AGHT+IFOX1vUVdJCj9kRtDkk9NCSOqJOF59p9XSifugpzzzEKLIcvKkGJ/Ch/Cuf3eRpHm0BvV6OvaYxmNmzHBElFQ==
X-Received: from ilbcc4.prod.google.com ([2002:a05:6e02:984:b0:3ce:6c1f:c124])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:b29:b0:3d0:4a82:3f43 with SMTP id e9e14a558f8ab-3d17be03903mr77141805ab.5.1739469922144;
 Thu, 13 Feb 2025 10:05:22 -0800 (PST)
Date: Thu, 13 Feb 2025 18:03:16 +0000
In-Reply-To: <20250213180317.3205285-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213180317.3205285-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213180317.3205285-8-coltonlewis@google.com>
Subject: [RFC PATCH v3 7/8] perf: arm_pmuv3: Keep out of guest counter partition
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
 arch/arm/include/asm/arm_pmuv3.h |  2 +
 arch/arm64/include/asm/kvm_pmu.h |  5 +++
 arch/arm64/kvm/pmu-part.c        | 16 +++++++
 drivers/perf/arm_pmuv3.c         | 73 +++++++++++++++++++++++++++-----
 include/linux/perf/arm_pmuv3.h   |  8 ++++
 5 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 2ec0e5e83fc9..dadd4ddf51af 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -227,6 +227,8 @@ static inline bool kvm_set_pmuserenr(u64 val)
 }
 
 static inline void kvm_vcpu_pmu_resync_el0(void) {}
+static inline void kvm_pmu_host_counters_enable(void) {}
+static inline void kvm_pmu_host_counters_disable(void) {}
 
 /* PMU Version in DFR Register */
 #define ARMV8_PMU_DFR_VER_NI        0
diff --git a/arch/arm64/include/asm/kvm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
index 174b7f376d95..8f25754fde47 100644
--- a/arch/arm64/include/asm/kvm_pmu.h
+++ b/arch/arm64/include/asm/kvm_pmu.h
@@ -25,6 +25,8 @@ void kvm_host_pmu_init(struct arm_pmu *pmu);
 u8 kvm_pmu_get_reserved_counters(void);
 u8 kvm_pmu_hpmn(u8 nr_counters);
 void kvm_pmu_partition(struct arm_pmu *pmu);
+void kvm_pmu_host_counters_enable(void);
+void kvm_pmu_host_counters_disable(void);
 
 #else
 
@@ -37,6 +39,9 @@ static inline bool kvm_set_pmuserenr(u64 val)
 static inline void kvm_vcpu_pmu_resync_el0(void) {}
 static inline void kvm_host_pmu_init(struct arm_pmu *pmu) {}
 
+static inline void kvm_pmu_host_counters_enable(void) {}
+static inline void kvm_pmu_host_counters_disable(void) {}
+
 #endif
 
 #endif
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index e74fecc67e37..51da65c678f9 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -45,3 +45,19 @@ void kvm_pmu_partition(struct arm_pmu *pmu)
 		pmu->partitioned = false;
 	}
 }
+
+void kvm_pmu_host_counters_enable(void)
+{
+	u64 mdcr = read_sysreg(mdcr_el2);
+
+	mdcr |= MDCR_EL2_HPME;
+	write_sysreg(mdcr, mdcr_el2);
+}
+
+void kvm_pmu_host_counters_disable(void)
+{
+	u64 mdcr = read_sysreg(mdcr_el2);
+
+	mdcr &= ~MDCR_EL2_HPME;
+	write_sysreg(mdcr, mdcr_el2);
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 0e360feb3432..442dcff56d5b 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -730,15 +730,19 @@ static void armv8pmu_disable_event_irq(struct perf_event *event)
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
@@ -765,6 +769,18 @@ static void armv8pmu_disable_user_access(void)
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
@@ -773,6 +789,8 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 	if (is_pmuv3p9(cpu_pmu->pmuver)) {
 		u64 mask = 0;
 		for_each_set_bit(i, cpuc->used_mask, ARMPMU_MAX_HWEVENTS) {
+			if (armv8pmu_is_guest_part(cpu_pmu, i))
+				continue;
 			if (armv8pmu_event_has_user_read(cpuc->events[i]))
 				mask |= BIT(i);
 		}
@@ -781,6 +799,8 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
 		/* Clear any unused counters to avoid leaking their contents */
 		for_each_andnot_bit(i, cpu_pmu->cntr_mask, cpuc->used_mask,
 				    ARMPMU_MAX_HWEVENTS) {
+			if (armv8pmu_is_guest_part(cpu_pmu, i))
+				continue;
 			if (i == ARMV8_PMU_CYCLE_IDX)
 				write_pmccntr(0);
 			else if (i == ARMV8_PMU_INSTR_IDX)
@@ -825,8 +845,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 	else
 		armv8pmu_disable_user_access();
 
-	/* Enable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
+	if (cpu_pmu->partitioned)
+		kvm_pmu_host_counters_enable();
+	else
+		armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
 
 	kvm_vcpu_pmu_resync_el0();
 }
@@ -834,7 +856,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	/* Disable all counters */
-	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
+	if (cpu_pmu->partitioned)
+		kvm_pmu_host_counters_disable();
+	else
+		armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
 }
 
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
@@ -848,7 +873,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	/*
 	 * Get and reset the IRQ flags
 	 */
-	pmovsr = armv8pmu_getreset_flags();
+	pmovsr = armv8pmu_getreset_flags(cpu_pmu);
 
 	/*
 	 * Did an overflow occur?
@@ -906,6 +931,8 @@ static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
 	int idx;
 
 	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
+		if (armv8pmu_is_guest_part(cpu_pmu, idx))
+			continue;
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
 	}
@@ -922,6 +949,8 @@ static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
 	 * the lower idx must be even.
 	 */
 	for_each_set_bit(idx, cpu_pmu->cntr_mask, ARMV8_PMU_MAX_GENERAL_COUNTERS) {
+		if (armv8pmu_is_guest_part(cpu_pmu, idx))
+			continue;
 		if (!(idx & 0x1))
 			continue;
 		if (!test_and_set_bit(idx, cpuc->used_mask)) {
@@ -944,6 +973,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 
 	/* Always prefer to place a cycle counter into the cycle counter. */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) &&
+	    !cpu_pmu->partitioned &&
 	    !armv8pmu_event_get_threshold(&event->attr)) {
 		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
 			return ARMV8_PMU_CYCLE_IDX;
@@ -959,6 +989,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * may not know how to handle it.
 	 */
 	if ((evtype == ARMV8_PMUV3_PERFCTR_INST_RETIRED) &&
+	    !cpu_pmu->partitioned &&
 	    !armv8pmu_event_get_threshold(&event->attr) &&
 	    test_bit(ARMV8_PMU_INSTR_IDX, cpu_pmu->cntr_mask) &&
 	    !armv8pmu_event_want_user_access(event)) {
@@ -970,7 +1001,7 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	 * Otherwise use events counters
 	 */
 	if (armv8pmu_event_is_chained(event))
-		return	armv8pmu_get_chain_idx(cpuc, cpu_pmu);
+		return armv8pmu_get_chain_idx(cpuc, cpu_pmu);
 	else
 		return armv8pmu_get_single_idx(cpuc, cpu_pmu);
 }
@@ -1062,6 +1093,16 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
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
@@ -1069,6 +1110,9 @@ static void armv8pmu_reset(void *info)
 
 	bitmap_to_arr64(&mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
 
+	if (cpu_pmu->partitioned)
+		mask &= ARMV8_PMU_HOST_CNT_PART(cpu_pmu->hpmn);
+
 	/* The counter and interrupt enable registers are unknown at reset. */
 	armv8pmu_disable_counter(mask);
 	armv8pmu_disable_intens(mask);
@@ -1076,11 +1120,20 @@ static void armv8pmu_reset(void *info)
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
index c2448477c37f..3a5eac11e54d 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -240,6 +240,14 @@
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
2.48.1.601.g30ceb7b040-goog


