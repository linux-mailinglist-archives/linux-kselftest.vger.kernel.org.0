Return-Path: <linux-kselftest+bounces-1567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299980D0BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56EC1C213FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE584C608;
	Mon, 11 Dec 2023 16:14:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 603DD8E;
	Mon, 11 Dec 2023 08:14:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA6DFEC;
	Mon, 11 Dec 2023 08:14:51 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F4CE3F738;
	Mon, 11 Dec 2023 08:14:01 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	suzuki.poulose@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	anshuman.khandual@arm.com
Cc: namhyung@gmail.com,
	James Clark <james.clark@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Zaid Al-Bassam <zalbassam@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 01/11] arm: perf: Remove inlines from arm_pmuv3.c
Date: Mon, 11 Dec 2023 16:13:13 +0000
Message-Id: <20231211161331.1277825-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211161331.1277825-1-james.clark@arm.com>
References: <20231211161331.1277825-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are all static and in one compilation unit so the inline has no
effect on the binary. Except if FTRACE is enabled, then 3 functions
which were already not inlined now get the nops added which allows them
to be traced.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 6ca7be05229c..9184a75435e2 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -300,12 +300,12 @@ PMU_FORMAT_ATTR(rdpmc, "config1:1");
 
 static int sysctl_perf_user_access __read_mostly;
 
-static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
+static bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
 	return event->attr.config1 & 0x1;
 }
 
-static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
+static bool armv8pmu_event_want_user_access(struct perf_event *event)
 {
 	return event->attr.config1 & 0x2;
 }
@@ -397,7 +397,7 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 	return (IS_ENABLED(CONFIG_ARM64) && is_pmuv3p5(cpu_pmu->pmuver));
 }
 
-static inline bool armv8pmu_event_has_user_read(struct perf_event *event)
+static bool armv8pmu_event_has_user_read(struct perf_event *event)
 {
 	return event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT;
 }
@@ -407,7 +407,7 @@ static inline bool armv8pmu_event_has_user_read(struct perf_event *event)
  * except when we have allocated the 64bit cycle counter (for CPU
  * cycles event) or when user space counter access is enabled.
  */
-static inline bool armv8pmu_event_is_chained(struct perf_event *event)
+static bool armv8pmu_event_is_chained(struct perf_event *event)
 {
 	int idx = event->hw.idx;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
@@ -428,36 +428,36 @@ static inline bool armv8pmu_event_is_chained(struct perf_event *event)
 #define	ARMV8_IDX_TO_COUNTER(x)	\
 	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
 
-static inline u64 armv8pmu_pmcr_read(void)
+static u64 armv8pmu_pmcr_read(void)
 {
 	return read_pmcr();
 }
 
-static inline void armv8pmu_pmcr_write(u64 val)
+static void armv8pmu_pmcr_write(u64 val)
 {
 	val &= ARMV8_PMU_PMCR_MASK;
 	isb();
 	write_pmcr(val);
 }
 
-static inline int armv8pmu_has_overflowed(u32 pmovsr)
+static int armv8pmu_has_overflowed(u32 pmovsr)
 {
 	return pmovsr & ARMV8_PMU_OVERFLOWED_MASK;
 }
 
-static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
+static int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
 {
 	return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
 }
 
-static inline u64 armv8pmu_read_evcntr(int idx)
+static u64 armv8pmu_read_evcntr(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
 
 	return read_pmevcntrn(counter);
 }
 
-static inline u64 armv8pmu_read_hw_counter(struct perf_event *event)
+static u64 armv8pmu_read_hw_counter(struct perf_event *event)
 {
 	int idx = event->hw.idx;
 	u64 val = armv8pmu_read_evcntr(idx);
@@ -519,14 +519,14 @@ static u64 armv8pmu_read_counter(struct perf_event *event)
 	return  armv8pmu_unbias_long_counter(event, value);
 }
 
-static inline void armv8pmu_write_evcntr(int idx, u64 value)
+static void armv8pmu_write_evcntr(int idx, u64 value)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
 
 	write_pmevcntrn(counter, value);
 }
 
-static inline void armv8pmu_write_hw_counter(struct perf_event *event,
+static void armv8pmu_write_hw_counter(struct perf_event *event,
 					     u64 value)
 {
 	int idx = event->hw.idx;
@@ -552,7 +552,7 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 		armv8pmu_write_hw_counter(event, value);
 }
 
-static inline void armv8pmu_write_evtype(int idx, u32 val)
+static void armv8pmu_write_evtype(int idx, u32 val)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
 
@@ -560,7 +560,7 @@ static inline void armv8pmu_write_evtype(int idx, u32 val)
 	write_pmevtypern(counter, val);
 }
 
-static inline void armv8pmu_write_event_type(struct perf_event *event)
+static void armv8pmu_write_event_type(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
@@ -594,7 +594,7 @@ static u32 armv8pmu_event_cnten_mask(struct perf_event *event)
 	return mask;
 }
 
-static inline void armv8pmu_enable_counter(u32 mask)
+static void armv8pmu_enable_counter(u32 mask)
 {
 	/*
 	 * Make sure event configuration register writes are visible before we
@@ -604,7 +604,7 @@ static inline void armv8pmu_enable_counter(u32 mask)
 	write_pmcntenset(mask);
 }
 
-static inline void armv8pmu_enable_event_counter(struct perf_event *event)
+static void armv8pmu_enable_event_counter(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
 	u32 mask = armv8pmu_event_cnten_mask(event);
@@ -616,7 +616,7 @@ static inline void armv8pmu_enable_event_counter(struct perf_event *event)
 		armv8pmu_enable_counter(mask);
 }
 
-static inline void armv8pmu_disable_counter(u32 mask)
+static void armv8pmu_disable_counter(u32 mask)
 {
 	write_pmcntenclr(mask);
 	/*
@@ -626,7 +626,7 @@ static inline void armv8pmu_disable_counter(u32 mask)
 	isb();
 }
 
-static inline void armv8pmu_disable_event_counter(struct perf_event *event)
+static void armv8pmu_disable_event_counter(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
 	u32 mask = armv8pmu_event_cnten_mask(event);
@@ -638,18 +638,18 @@ static inline void armv8pmu_disable_event_counter(struct perf_event *event)
 		armv8pmu_disable_counter(mask);
 }
 
-static inline void armv8pmu_enable_intens(u32 mask)
+static void armv8pmu_enable_intens(u32 mask)
 {
 	write_pmintenset(mask);
 }
 
-static inline void armv8pmu_enable_event_irq(struct perf_event *event)
+static void armv8pmu_enable_event_irq(struct perf_event *event)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(event->hw.idx);
 	armv8pmu_enable_intens(BIT(counter));
 }
 
-static inline void armv8pmu_disable_intens(u32 mask)
+static void armv8pmu_disable_intens(u32 mask)
 {
 	write_pmintenclr(mask);
 	isb();
@@ -658,13 +658,13 @@ static inline void armv8pmu_disable_intens(u32 mask)
 	isb();
 }
 
-static inline void armv8pmu_disable_event_irq(struct perf_event *event)
+static void armv8pmu_disable_event_irq(struct perf_event *event)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(event->hw.idx);
 	armv8pmu_disable_intens(BIT(counter));
 }
 
-static inline u32 armv8pmu_getreset_flags(void)
+static u32 armv8pmu_getreset_flags(void)
 {
 	u32 value;
 
-- 
2.34.1


