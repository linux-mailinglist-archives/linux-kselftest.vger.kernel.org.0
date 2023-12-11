Return-Path: <linux-kselftest+bounces-1572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4F80D0D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36051C21492
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E24C616;
	Mon, 11 Dec 2023 16:15:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC6EF19AD;
	Mon, 11 Dec 2023 08:15:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C926D16F3;
	Mon, 11 Dec 2023 08:15:53 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 526BF3F766;
	Mon, 11 Dec 2023 08:15:03 -0800 (PST)
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
Subject: [PATCH v7 06/11] arm: pmu: Share user ABI format mechanism with SPE
Date: Mon, 11 Dec 2023 16:13:18 +0000
Message-Id: <20231211161331.1277825-7-james.clark@arm.com>
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

This mechanism makes it much easier to define and read new attributes
so move it to the arm_pmu.h header so that it can be shared. At the same
time update the existing format attributes to use it.

GENMASK has to be changed to GENMASK_ULL because the config fields are
64 bits even on arm32 where this will also be used now.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c     | 21 ++++++++++++++++-----
 drivers/perf/arm_spe_pmu.c   | 22 ----------------------
 include/linux/perf/arm_pmu.h | 22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 16ef8448afc0..84b15c0892d9 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -295,20 +295,31 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
 	.is_visible = armv8pmu_event_attr_is_visible,
 };
 
-PMU_FORMAT_ATTR(event, "config:0-15");
-PMU_FORMAT_ATTR(long, "config1:0");
-PMU_FORMAT_ATTR(rdpmc, "config1:1");
+/* User ABI */
+#define ATTR_CFG_FLD_event_CFG		config
+#define ATTR_CFG_FLD_event_LO		0
+#define ATTR_CFG_FLD_event_HI		15
+#define ATTR_CFG_FLD_long_CFG		config1
+#define ATTR_CFG_FLD_long_LO		0
+#define ATTR_CFG_FLD_long_HI		0
+#define ATTR_CFG_FLD_rdpmc_CFG		config1
+#define ATTR_CFG_FLD_rdpmc_LO		1
+#define ATTR_CFG_FLD_rdpmc_HI		1
+
+GEN_PMU_FORMAT_ATTR(event);
+GEN_PMU_FORMAT_ATTR(long);
+GEN_PMU_FORMAT_ATTR(rdpmc);
 
 static int sysctl_perf_user_access __read_mostly;
 
 static bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
-	return event->attr.config1 & 0x1;
+	return ATTR_CFG_GET_FLD(&event->attr, long);
 }
 
 static bool armv8pmu_event_want_user_access(struct perf_event *event)
 {
-	return event->attr.config1 & 0x2;
+	return ATTR_CFG_GET_FLD(&event->attr, rdpmc);
 }
 
 static struct attribute *armv8_pmuv3_format_attrs[] = {
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d2b0cbf0e0c4..b622d75d8c9e 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -206,28 +206,6 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_inv_event_filter_LO	0
 #define ATTR_CFG_FLD_inv_event_filter_HI	63
 
-/* Why does everything I do descend into this? */
-#define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)				\
-	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
-
-#define _GEN_PMU_FORMAT_ATTR(cfg, lo, hi)				\
-	__GEN_PMU_FORMAT_ATTR(cfg, lo, hi)
-
-#define GEN_PMU_FORMAT_ATTR(name)					\
-	PMU_FORMAT_ATTR(name,						\
-	_GEN_PMU_FORMAT_ATTR(ATTR_CFG_FLD_##name##_CFG,			\
-			     ATTR_CFG_FLD_##name##_LO,			\
-			     ATTR_CFG_FLD_##name##_HI))
-
-#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)				\
-	((((attr)->cfg) >> lo) & GENMASK(hi - lo, 0))
-
-#define ATTR_CFG_GET_FLD(attr, name)					\
-	_ATTR_CFG_GET_FLD(attr,						\
-			  ATTR_CFG_FLD_##name##_CFG,			\
-			  ATTR_CFG_FLD_##name##_LO,			\
-			  ATTR_CFG_FLD_##name##_HI)
-
 GEN_PMU_FORMAT_ATTR(ts_enable);
 GEN_PMU_FORMAT_ATTR(pa_enable);
 GEN_PMU_FORMAT_ATTR(pct_enable);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 143fbc10ecfe..337f01674b38 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -189,4 +189,26 @@ void armpmu_free_irq(int irq, int cpu);
 #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
 #define ARMV8_TRBE_PDEV_NAME "arm,trbe"
 
+/* Why does everything I do descend into this? */
+#define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)				\
+	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
+
+#define _GEN_PMU_FORMAT_ATTR(cfg, lo, hi)				\
+	__GEN_PMU_FORMAT_ATTR(cfg, lo, hi)
+
+#define GEN_PMU_FORMAT_ATTR(name)					\
+	PMU_FORMAT_ATTR(name,						\
+	_GEN_PMU_FORMAT_ATTR(ATTR_CFG_FLD_##name##_CFG,			\
+			     ATTR_CFG_FLD_##name##_LO,			\
+			     ATTR_CFG_FLD_##name##_HI))
+
+#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)				\
+	((((attr)->cfg) >> lo) & GENMASK_ULL(hi - lo, 0))
+
+#define ATTR_CFG_GET_FLD(attr, name)					\
+	_ATTR_CFG_GET_FLD(attr,						\
+			  ATTR_CFG_FLD_##name##_CFG,			\
+			  ATTR_CFG_FLD_##name##_LO,			\
+			  ATTR_CFG_FLD_##name##_HI)
+
 #endif /* __ARM_PMU_H__ */
-- 
2.34.1


