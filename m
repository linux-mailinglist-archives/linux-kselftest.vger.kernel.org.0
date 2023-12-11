Return-Path: <linux-kselftest+bounces-1576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2CC80D0E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3041C216E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD044C61B;
	Mon, 11 Dec 2023 16:15:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id AADCFB3;
	Mon, 11 Dec 2023 08:15:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF48A16F3;
	Mon, 11 Dec 2023 08:16:30 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BFE03F738;
	Mon, 11 Dec 2023 08:15:40 -0800 (PST)
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
Subject: [PATCH v7 09/11] arm: pmu: Move error message and -EOPNOTSUPP to individual PMUs
Date: Mon, 11 Dec 2023 16:13:21 +0000
Message-Id: <20231211161331.1277825-10-james.clark@arm.com>
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

-EPERM or -EINVAL always get converted to -EOPNOTSUPP, so replace them.
This will allow __hw_perf_event_init() to return a different code or not
print that particular message for a different error in the next commit.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |  6 ++++--
 drivers/perf/apple_m1_cpu_pmu.c |  6 ++++--
 drivers/perf/arm_pmu.c          | 11 +++++------
 drivers/perf/arm_pmuv3.c        |  6 ++++--
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index eb2190477da1..4e115076d323 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1072,8 +1072,10 @@ static int armv7pmu_set_event_filter(struct hw_perf_event *event,
 {
 	unsigned long config_base = 0;
 
-	if (attr->exclude_idle)
-		return -EPERM;
+	if (attr->exclude_idle) {
+		pr_debug("ARM performance counters do not support mode exclusion\n");
+		return -EOPNOTSUPP;
+	}
 	if (attr->exclude_user)
 		config_base |= ARMV7_EXCLUDE_USER;
 	if (attr->exclude_kernel)
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index cd2de44b61b9..f322e5ca1114 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -524,8 +524,10 @@ static int m1_pmu_set_event_filter(struct hw_perf_event *event,
 {
 	unsigned long config_base = 0;
 
-	if (!attr->exclude_guest)
-		return -EINVAL;
+	if (!attr->exclude_guest) {
+		pr_debug("ARM performance counters do not support mode exclusion\n");
+		return -EOPNOTSUPP;
+	}
 	if (!attr->exclude_kernel)
 		config_base |= M1_PMU_CFG_COUNT_KERNEL;
 	if (!attr->exclude_user)
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index d712a19e47ac..2ce65b440e85 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -445,7 +445,7 @@ __hw_perf_event_init(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
-	int mapping;
+	int mapping, ret;
 
 	hwc->flags = 0;
 	mapping = armpmu->map_event(event);
@@ -470,11 +470,10 @@ __hw_perf_event_init(struct perf_event *event)
 	/*
 	 * Check whether we need to exclude the counter from certain modes.
 	 */
-	if (armpmu->set_event_filter &&
-	    armpmu->set_event_filter(hwc, &event->attr)) {
-		pr_debug("ARM performance counters do not support "
-			 "mode exclusion\n");
-		return -EOPNOTSUPP;
+	if (armpmu->set_event_filter) {
+		ret = armpmu->set_event_filter(hwc, &event->attr);
+		if (ret)
+			return ret;
 	}
 
 	/*
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 84b15c0892d9..d33378a198cc 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -932,8 +932,10 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
 {
 	unsigned long config_base = 0;
 
-	if (attr->exclude_idle)
-		return -EPERM;
+	if (attr->exclude_idle) {
+		pr_debug("ARM performance counters do not support mode exclusion\n");
+		return -EOPNOTSUPP;
+	}
 
 	/*
 	 * If we're running in hyp mode, then we *are* the hypervisor.
-- 
2.34.1


