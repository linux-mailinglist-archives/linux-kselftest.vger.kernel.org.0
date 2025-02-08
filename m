Return-Path: <linux-kselftest+bounces-26071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1AA2D2CD
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 03:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632691886353
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 02:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58215852F;
	Sat,  8 Feb 2025 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1deTHxu/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425714A4C6
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Feb 2025 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738980087; cv=none; b=V6/93eTUFwjS2x/BFVLCLOHVSeHGNkGKMXs4U5qhxHtlIg0uDcuNojiYPZgYOPv5i23iSDtK8Txp5iCvPGX0JrDTnyF/pIMQCTFHfTt+ag7JZzl1uezcJBxJnTbCHTO2ZDrmbCRj5co4Q8bk1j6Uwg+Glp9W5jrqK4gggRFQu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738980087; c=relaxed/simple;
	bh=FNdh5Efcv5lefd1CM5agKCbHS8yLaF8B5P56MP3wJ64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=epPcjWmSonOuJiOI7P08JiFj5LK0QohIlBTbUqA8c0/b+iEbCPWvW49+4DFls3JC6Jrrnvq/+a3YzRSMjpLgvGpXhLPF9JpwD3AXqOLDfp9eXveZLEsYueRN1ysASV74M137jgKjkYdnYVvEXtI711BKJoTNMlRX6J+o+XPjiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1deTHxu/; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5f338069a21so1951259eaf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 18:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738980085; x=1739584885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=drjA1Q37gh75rUzVihMmmLfV/T5nGlfKdtiHeyTpBgI=;
        b=1deTHxu/kv6gmeZHVl9O2MVz/u7F4z8Tp9CMyuxuRDRaB8rTW4Hk0VNy+f2V8j+B/R
         IglTQCG36X77M7NlmRJDyGWqwcth1+GJBNS9JpJDiiFoL0KwDCAZ4yFSTowLurs3OPng
         Ph3F7NkhuT30r0EbLhLtW2rBbFKE5CVu/7LvOMBqKMeRTAZBBBUEn7Aq6rDH54Pn07Uz
         qCJVWsbtMW+JYwy1yWa01pjNMbuM5NLqDYyujTW9Ep+C67KdzeQFlu9piNehO/lcbKjw
         RiZqZ0arNcwh/drXdt53Y5/qERx2vuUtHXmrVc+Tq1AJ+17CNa6tyKzCmCB1a0OjTkH/
         4rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738980085; x=1739584885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drjA1Q37gh75rUzVihMmmLfV/T5nGlfKdtiHeyTpBgI=;
        b=sWejuQopuqXjHrqU2+K35XlLemohfkBXqTeDCjOBkunQ/LBQY23G8h0LOXHaBCykoW
         z2NXny3D/ZA+qGxKABrnmwUCqseVXJMsV+1McXBEC4E1EpMg0/ZFjHesgQwB3dOd9Lb4
         FqGyvnCDarCHfcKdvw3Lh9wI171zalkpS3qvHV5EwVmxaEYaeUu5/dTIoOzaFOIwq98z
         Iv64A2hCAFYEMp0BthXODpcgslhyp9mKW9DetFlAaQGc4/KKINU5DR1t/a0wF7Wt0k4G
         i3OMutoglgBeWloKQqS+eQUCtfyhvm32N0eE5DqZrwgIG6hsqMp9iCSPNlzurEsjKaFE
         xgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ykqHNzJKnldzzepqPF67RHZU3yANLy5TiqSv99h0tQNYbRQJgsSfoRuiTdiil28Gw0kWUwsyh5kMdOaa7+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXffjHUGglUY23UfQ3/BXHVJbQZpgQB8jUdZBbTLl5sZ3UDBb
	Z4QUuugmYe5omM4PFRRmO3d5AyW/ppZqJ0LgIpBU8g6M3t9Qfw+HG0LpjQBPWJrWtdBKS9AAN58
	lahIiX+YoX4PYqjva6cPW9Q==
X-Google-Smtp-Source: AGHT+IHAFmwRvuSVnlu6AfcSdI3UbPArVuxlw536HHD4pciDPIBbZMlrBgthheBCrRaWlHc6RbttTF/L4uKfIgHBfw==
X-Received: from oaclu2.prod.google.com ([2002:a05:6871:3142:b0:2aa:1a59:56d1])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:a586:b0:2b8:3e6b:605 with SMTP id 586e51a60fabf-2b83ed8adbcmr3039667fac.20.1738980084900;
 Fri, 07 Feb 2025 18:01:24 -0800 (PST)
Date: Sat,  8 Feb 2025 02:01:09 +0000
In-Reply-To: <20250208020111.2068239-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208020111.2068239-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250208020111.2068239-3-coltonlewis@google.com>
Subject: [RFC PATCH v2 2/4] perf: arm_pmuv3: Introduce module param to
 partition the PMU
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

For PMUv3, the register MDCR_EL2.HPMN partitiones the PMU counters
into two ranges where counters 0..HPMN-1 are accessible by EL1 and, if
allowed, EL0 while counters HPMN..N are only accessible by EL2.

Introduce a module parameter in the PMUv3 driver to set this
register. The name reserved_host_counters reflects the intent to
reserve some counters for the host so the guest may eventually be
allowed direct access to a subset of PMU functionality for increased
performance.

Track HPMN and whether the pmu is partitioned in struct arm_pmu
because KVM will need to know that to handle guests correctly.

While FEAT_HPMN0 does allow HPMN to be set to 0, this patch
specifically disallows that case because it's not useful given the
intention to allow guests access to their own counters.

Due to the difficulty this feature would create for the driver running
at EL1 on the host, partitioning is only allowed in VHE mode. Working
on nVHE mode would require a hypercall for every register access
because the counters reserved for the host by HPMN are now only
accessible to EL2.

The parameter is only configurable at boot time. Making the parameter
configurable on a running system is dangerous due to the difficulty of
knowing for sure no counters are in use anywhere so it is safe to
reporgram HPMN.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/arm_pmuv3.h   | 13 +++++++++
 arch/arm64/include/asm/arm_pmuv3.h | 10 +++++++
 drivers/perf/arm_pmuv3.c           | 46 ++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h       |  2 ++
 include/linux/perf/arm_pmuv3.h     |  7 +++++
 5 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 2ec0e5e83fc9..c5f496450e16 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -11,6 +11,8 @@
 
 #define PMCCNTR			__ACCESS_CP15_64(0, c9)
 
+#define HDCR			__ACCESS_CP15(c1, 4, c1, 1)
+
 #define PMCR			__ACCESS_CP15(c9,  0, c12, 0)
 #define PMCNTENSET		__ACCESS_CP15(c9,  0, c12, 1)
 #define PMCNTENCLR		__ACCESS_CP15(c9,  0, c12, 2)
@@ -214,6 +216,7 @@ static inline void write_pmuserenr(u32 val)
 
 static inline void write_pmuacr(u64 val) {}
 
+static inline bool has_vhe(void) { return false; }
 static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u32 clr) {}
 static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
@@ -277,4 +280,14 @@ static inline u64 read_pmceid1(void)
 	return val;
 }
 
+static inline u32 read_mdcr(void)
+{
+	return read_sysreg(HDCR);
+}
+
+static inline void write_mdcr(u32 val)
+{
+	write_sysreg(val, HDCR);
+}
+
 #endif
diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 8a777dec8d88..fc37e7e81e07 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -188,4 +188,14 @@ static inline bool is_pmuv3p9(int pmuver)
 	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P9;
 }
 
+static inline u64 read_mdcr(void)
+{
+	return read_sysreg(mdcr_el2);
+}
+
+static inline void write_mdcr(u64 val)
+{
+	write_sysreg(val, mdcr_el2);
+}
+
 #endif
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 0e360feb3432..39109260b161 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -325,6 +325,7 @@ GEN_PMU_FORMAT_ATTR(threshold_compare);
 GEN_PMU_FORMAT_ATTR(threshold);
 
 static int sysctl_perf_user_access __read_mostly;
+static u8 reserved_host_counters __read_mostly;
 
 static bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
@@ -500,6 +501,29 @@ static void armv8pmu_pmcr_write(u64 val)
 	write_pmcr(val);
 }
 
+static u64 armv8pmu_mdcr_read(void)
+{
+	return read_mdcr();
+}
+
+static void armv8pmu_mdcr_write(u64 val)
+{
+	write_mdcr(val);
+	isb();
+}
+
+static void armv8pmu_partition(u8 hpmn)
+{
+	u64 mdcr = armv8pmu_mdcr_read();
+
+	mdcr &= ~ARMV8_PMU_MDCR_HPMN;
+	mdcr |= FIELD_PREP(ARMV8_PMU_MDCR_HPMN, hpmn);
+	/* Prevent guest counters counting at EL2 */
+	mdcr |= ARMV8_PMU_MDCR_HPMD;
+
+	armv8pmu_mdcr_write(mdcr);
+}
+
 static int armv8pmu_has_overflowed(u64 pmovsr)
 {
 	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
@@ -1069,6 +1093,9 @@ static void armv8pmu_reset(void *info)
 
 	bitmap_to_arr64(&mask, cpu_pmu->cntr_mask, ARMPMU_MAX_HWEVENTS);
 
+	if (cpu_pmu->partitioned)
+		armv8pmu_partition(cpu_pmu->hpmn);
+
 	/* The counter and interrupt enable registers are unknown at reset. */
 	armv8pmu_disable_counter(mask);
 	armv8pmu_disable_intens(mask);
@@ -1205,6 +1232,7 @@ static void __armv8pmu_probe_pmu(void *info)
 {
 	struct armv8pmu_probe_info *probe = info;
 	struct arm_pmu *cpu_pmu = probe->pmu;
+	u8 pmcr_n;
 	u64 pmceid_raw[2];
 	u32 pmceid[2];
 	int pmuver;
@@ -1215,10 +1243,20 @@ static void __armv8pmu_probe_pmu(void *info)
 
 	cpu_pmu->pmuver = pmuver;
 	probe->present = true;
+	pmcr_n = FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read());
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	bitmap_set(cpu_pmu->cntr_mask,
-		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
+	bitmap_set(cpu_pmu->cntr_mask, 0, pmcr_n);
+
+	if (has_vhe() &&
+	    reserved_host_counters > 0 &&
+	    reserved_host_counters < pmcr_n) {
+		cpu_pmu->hpmn = pmcr_n - reserved_host_counters;
+		cpu_pmu->partitioned = true;
+	} else {
+		cpu_pmu->hpmn = pmcr_n;
+		cpu_pmu->partitioned = false;
+	}
 
 	/* Add the CPU cycles counter */
 	set_bit(ARMV8_PMU_CYCLE_IDX, cpu_pmu->cntr_mask);
@@ -1516,3 +1554,7 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_zero = 1;
 	userpg->cap_user_time_short = 1;
 }
+
+module_param(reserved_host_counters, byte, 0);
+MODULE_PARM_DESC(reserved_host_counters,
+		 "Partition the PMU into host and guest counters");
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 4b5b83677e3f..ad97aabed25a 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -101,6 +101,8 @@ struct arm_pmu {
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
 	DECLARE_BITMAP(cntr_mask, ARMPMU_MAX_HWEVENTS);
+	u8		hpmn; /* MDCR_EL2.HPMN: counter partition pivot */
+	bool	        partitioned;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index c2448477c37f..115ee39f693a 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -223,6 +223,13 @@
 				 ARMV8_PMU_PMCR_X | ARMV8_PMU_PMCR_DP | \
 				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
+/*
+ * Per-CPU MDCR: config reg
+ */
+#define ARMV8_PMU_MDCR_HPMN		GENMASK(4, 0)
+#define ARMV8_PMU_MDCR_HPME		BIT(7)
+#define ARMV8_PMU_MDCR_HPMD		BIT(17)
+
 /*
  * Counter bitmask layouts for overflow, enable, and interrupts
  */
-- 
2.48.1.502.g6dc24dfdaf-goog


