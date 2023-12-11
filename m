Return-Path: <linux-kselftest+bounces-1569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8977380D0C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6931C211C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13054C60B;
	Mon, 11 Dec 2023 16:14:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1799010F;
	Mon, 11 Dec 2023 08:14:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AD1C16A3;
	Mon, 11 Dec 2023 08:15:16 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DBC793F738;
	Mon, 11 Dec 2023 08:14:25 -0800 (PST)
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
Subject: [PATCH v7 03/11] arm: perf: Use GENMASK for PMMIR fields
Date: Mon, 11 Dec 2023 16:13:15 +0000
Message-Id: <20231211161331.1277825-4-james.clark@arm.com>
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

This is so that FIELD_GET and FIELD_PREP can be used and that the fields
are in a consistent format to arm64/tools/sysreg

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c       | 8 +++-----
 include/linux/perf/arm_pmuv3.h | 9 +++------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index e424de5dd44f..7b2c1d03464a 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -328,7 +328,7 @@ static ssize_t slots_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
-	u32 slots = cpu_pmu->reg_pmmir & ARMV8_PMU_SLOTS_MASK;
+	u32 slots = FIELD_GET(ARMV8_PMU_SLOTS, cpu_pmu->reg_pmmir);
 
 	return sysfs_emit(page, "0x%08x\n", slots);
 }
@@ -340,8 +340,7 @@ static ssize_t bus_slots_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
-	u32 bus_slots = (cpu_pmu->reg_pmmir >> ARMV8_PMU_BUS_SLOTS_SHIFT)
-			& ARMV8_PMU_BUS_SLOTS_MASK;
+	u32 bus_slots = FIELD_GET(ARMV8_PMU_BUS_SLOTS, cpu_pmu->reg_pmmir);
 
 	return sysfs_emit(page, "0x%08x\n", bus_slots);
 }
@@ -353,8 +352,7 @@ static ssize_t bus_width_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
-	u32 bus_width = (cpu_pmu->reg_pmmir >> ARMV8_PMU_BUS_WIDTH_SHIFT)
-			& ARMV8_PMU_BUS_WIDTH_MASK;
+	u32 bus_width = FIELD_GET(ARMV8_PMU_BUS_WIDTH, cpu_pmu->reg_pmmir);
 	u32 val = 0;
 
 	/* Encoded as Log2(number of bytes), plus one */
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index ed62bd75cec7..1bc7678c10d4 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -250,12 +250,9 @@
 #define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read at EL0 */
 
 /* PMMIR_EL1.SLOTS mask */
-#define ARMV8_PMU_SLOTS_MASK	0xff
-
-#define ARMV8_PMU_BUS_SLOTS_SHIFT 8
-#define ARMV8_PMU_BUS_SLOTS_MASK 0xff
-#define ARMV8_PMU_BUS_WIDTH_SHIFT 16
-#define ARMV8_PMU_BUS_WIDTH_MASK 0xf
+#define ARMV8_PMU_SLOTS		GENMASK(7, 0)
+#define ARMV8_PMU_BUS_SLOTS	GENMASK(15, 8)
+#define ARMV8_PMU_BUS_WIDTH	GENMASK(19, 16)
 
 /*
  * This code is really good
-- 
2.34.1


