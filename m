Return-Path: <linux-kselftest+bounces-1577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5D80D0E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B691C21788
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BC94C622;
	Mon, 11 Dec 2023 16:16:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0078511F;
	Mon, 11 Dec 2023 08:15:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F97F16F2;
	Mon, 11 Dec 2023 08:16:43 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC74C3F738;
	Mon, 11 Dec 2023 08:15:52 -0800 (PST)
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
Subject: [PATCH v7 10/11] arm64: perf: Add support for event counting threshold
Date: Mon, 11 Dec 2023 16:13:22 +0000
Message-Id: <20231211161331.1277825-11-james.clark@arm.com>
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

FEAT_PMUv3_TH (Armv8.8) permits a PMU counter to increment only on
events whose count meets a specified threshold condition. For example if
PMEVTYPERn.TC (Threshold Control) is set to 0b101 (Greater than or
equal, count), and the threshold is set to 2, then the PMU counter will
now only increment by 1 when an event would have previously incremented
the PMU counter by 2 or more on a single processor cycle.

Three new Perf event config fields, 'threshold', 'threshold_compare' and
'threshold_count' have been added to control the feature.
threshold_compare maps to the upper two bits of PMEVTYPERn.TC and
threshold_count maps to the first bit of TC. These separate attributes
have been picked rather than enumerating all the possible combinations
of the TC field as in the Arm ARM. The attributes would be used on a
Perf command line like this:

  $ perf stat -e stall_slot/threshold=2,threshold_compare=2/

A new capability for reading out the maximum supported threshold value
has also been added:

  $ cat /sys/bus/event_source/devices/armv8_pmuv3/caps/threshold_max

  0x000000ff

If a threshold higher than threshold_max is provided, then an error is
generated. If FEAT_PMUv3_TH isn't implemented or a 32 bit kernel is
running, then threshold_max reads zero, and attempting to set a
threshold value will also result in an error.

The threshold is per PMU counter, and there are potentially different
threshold_max values per PMU type on heterogeneous systems.

Bits higher than 32 now need to be written into PMEVTYPER, so
armv8pmu_write_evtype() has to be updated to take an unsigned long value
rather than u32 which gives the correct behavior on both aarch32 and 64.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c       | 79 +++++++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmuv3.h |  1 +
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index d33378a198cc..0bd6565eb401 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -305,10 +305,22 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 #define ATTR_CFG_FLD_rdpmc_CFG		config1
 #define ATTR_CFG_FLD_rdpmc_LO		1
 #define ATTR_CFG_FLD_rdpmc_HI		1
+#define ATTR_CFG_FLD_threshold_count_CFG	config1 /* PMEVTYPER.TC[0] */
+#define ATTR_CFG_FLD_threshold_count_LO		2
+#define ATTR_CFG_FLD_threshold_count_HI		2
+#define ATTR_CFG_FLD_threshold_compare_CFG	config1 /* PMEVTYPER.TC[2:1] */
+#define ATTR_CFG_FLD_threshold_compare_LO	3
+#define ATTR_CFG_FLD_threshold_compare_HI	4
+#define ATTR_CFG_FLD_threshold_CFG		config1 /* PMEVTYPER.TH */
+#define ATTR_CFG_FLD_threshold_LO		5
+#define ATTR_CFG_FLD_threshold_HI		16
 
 GEN_PMU_FORMAT_ATTR(event);
 GEN_PMU_FORMAT_ATTR(long);
 GEN_PMU_FORMAT_ATTR(rdpmc);
+GEN_PMU_FORMAT_ATTR(threshold_count);
+GEN_PMU_FORMAT_ATTR(threshold_compare);
+GEN_PMU_FORMAT_ATTR(threshold);
 
 static int sysctl_perf_user_access __read_mostly;
 
@@ -322,10 +334,27 @@ static bool armv8pmu_event_want_user_access(struct perf_event *event)
 	return ATTR_CFG_GET_FLD(&event->attr, rdpmc);
 }
 
+static u8 armv8pmu_event_threshold_control(struct perf_event_attr *attr)
+{
+	u8 th_compare = ATTR_CFG_GET_FLD(attr, threshold_compare);
+	u8 th_count = ATTR_CFG_GET_FLD(attr, threshold_count);
+
+	/*
+	 * The count bit is always the bottom bit of the full control field, and
+	 * the comparison is the upper two bits, but it's not explicitly
+	 * labelled in the Arm ARM. For the Perf interface we split it into two
+	 * fields, so reconstruct it here.
+	 */
+	return (th_compare << 1) | th_count;
+}
+
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
 	&format_attr_long.attr,
 	&format_attr_rdpmc.attr,
+	&format_attr_threshold.attr,
+	&format_attr_threshold_compare.attr,
+	&format_attr_threshold_count.attr,
 	NULL,
 };
 
@@ -375,10 +404,38 @@ static ssize_t bus_width_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(bus_width);
 
+static u32 threshold_max(struct arm_pmu *cpu_pmu)
+{
+	/*
+	 * PMMIR.THWIDTH is readable and non-zero on aarch32, but it would be
+	 * impossible to write the threshold in the upper 32 bits of PMEVTYPER.
+	 */
+	if (IS_ENABLED(CONFIG_ARM))
+		return 0;
+
+	/*
+	 * The largest value that can be written to PMEVTYPER<n>_EL0.TH is
+	 * (2 ^ PMMIR.THWIDTH) - 1.
+	 */
+	return (1 << FIELD_GET(ARMV8_PMU_THWIDTH, cpu_pmu->reg_pmmir)) - 1;
+}
+
+static ssize_t threshold_max_show(struct device *dev,
+				  struct device_attribute *attr, char *page)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
+
+	return sysfs_emit(page, "0x%08x\n", threshold_max(cpu_pmu));
+}
+
+static DEVICE_ATTR_RO(threshold_max);
+
 static struct attribute *armv8_pmuv3_caps_attrs[] = {
 	&dev_attr_slots.attr,
 	&dev_attr_bus_slots.attr,
 	&dev_attr_bus_width.attr,
+	&dev_attr_threshold_max.attr,
 	NULL,
 };
 
@@ -562,7 +619,7 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 		armv8pmu_write_hw_counter(event, value);
 }
 
-static void armv8pmu_write_evtype(int idx, u32 val)
+static void armv8pmu_write_evtype(int idx, unsigned long val)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
 	unsigned long mask = ARMV8_PMU_EVTYPE_EVENT |
@@ -931,6 +988,10 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 				     struct perf_event_attr *attr)
 {
 	unsigned long config_base = 0;
+	struct perf_event *perf_event = container_of(attr, struct perf_event,
+						     attr);
+	struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
+	u32 th;
 
 	if (attr->exclude_idle) {
 		pr_debug("ARM performance counters do not support mode exclusion\n");
@@ -964,6 +1025,22 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 	if (attr->exclude_user)
 		config_base |= ARMV8_PMU_EXCLUDE_EL0;
 
+	/*
+	 * If FEAT_PMUv3_TH isn't implemented, then THWIDTH (threshold_max) will
+	 * be 0 and will also trigger this check, preventing it from being used.
+	 */
+	th = ATTR_CFG_GET_FLD(attr, threshold);
+	if (th > threshold_max(cpu_pmu)) {
+		pr_debug("PMU event threshold exceeds max value\n");
+		return -EINVAL;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64) && th) {
+		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TH, th);
+		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TC,
+					  armv8pmu_event_threshold_control(attr));
+	}
+
 	/*
 	 * Install the filter into config_base as this is used to
 	 * construct the event type.
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 91957b3468e9..0f4d62ef3a9a 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -262,6 +262,7 @@
 #define ARMV8_PMU_SLOTS		GENMASK(7, 0)
 #define ARMV8_PMU_BUS_SLOTS	GENMASK(15, 8)
 #define ARMV8_PMU_BUS_WIDTH	GENMASK(19, 16)
+#define ARMV8_PMU_THWIDTH	GENMASK(23, 20)
 
 /*
  * This code is really good
-- 
2.34.1


