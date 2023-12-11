Return-Path: <linux-kselftest+bounces-1575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9809C80D0DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5257F282220
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BE14C61B;
	Mon, 11 Dec 2023 16:15:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A416115;
	Mon, 11 Dec 2023 08:15:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA2EF16F2;
	Mon, 11 Dec 2023 08:16:18 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 367113F738;
	Mon, 11 Dec 2023 08:15:28 -0800 (PST)
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
Subject: [PATCH v7 08/11] KVM: selftests: aarch64: Update tools copy of arm_pmuv3.h
Date: Mon, 11 Dec 2023 16:13:20 +0000
Message-Id: <20231211161331.1277825-9-james.clark@arm.com>
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

Now that ARMV8_PMU_PMCR_N is made with GENMASK, update usages to treat
it as a pre-shifted mask.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/include/perf/arm_pmuv3.h                | 43 +++++++++++--------
 .../kvm/aarch64/vpmu_counter_access.c         |  5 +--
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/include/perf/arm_pmuv3.h b/tools/include/perf/arm_pmuv3.h
index e822d49fb5b8..1e397d55384e 100644
--- a/tools/include/perf/arm_pmuv3.h
+++ b/tools/include/perf/arm_pmuv3.h
@@ -218,45 +218,54 @@
 #define ARMV8_PMU_PMCR_DP	(1 << 5) /* Disable CCNT if non-invasive debug*/
 #define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
 #define ARMV8_PMU_PMCR_LP	(1 << 7) /* Long event counter enable */
-#define ARMV8_PMU_PMCR_N_SHIFT	11  /* Number of counters supported */
-#define ARMV8_PMU_PMCR_N_MASK	0x1f
-#define ARMV8_PMU_PMCR_MASK	0xff    /* Mask for writable bits */
+#define ARMV8_PMU_PMCR_N	GENMASK(15, 11) /* Number of counters supported */
+/* Mask for writable bits */
+#define ARMV8_PMU_PMCR_MASK	(ARMV8_PMU_PMCR_E | ARMV8_PMU_PMCR_P | \
+				 ARMV8_PMU_PMCR_C | ARMV8_PMU_PMCR_D | \
+				 ARMV8_PMU_PMCR_X | ARMV8_PMU_PMCR_DP | \
+				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)
 
 /*
  * PMOVSR: counters overflow flag status reg
  */
-#define ARMV8_PMU_OVSR_MASK		0xffffffff	/* Mask for writable bits */
-#define ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_OVSR_MASK
+#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
+#define ARMV8_PMU_OVSR_C		BIT(31)
+/* Mask for writable bits is both P and C fields */
+#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C)
 
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
-#define ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
+#define ARMV8_PMU_EVTYPE_EVENT	GENMASK(15, 0)	/* Mask for EVENT bits */
+#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
+#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)
 
 /*
  * Event filters for PMUv3
  */
-#define ARMV8_PMU_EXCLUDE_EL1	(1U << 31)
-#define ARMV8_PMU_EXCLUDE_EL0	(1U << 30)
-#define ARMV8_PMU_INCLUDE_EL2	(1U << 27)
+#define ARMV8_PMU_EXCLUDE_EL1		(1U << 31)
+#define ARMV8_PMU_EXCLUDE_EL0		(1U << 30)
+#define ARMV8_PMU_EXCLUDE_NS_EL1	(1U << 29)
+#define ARMV8_PMU_EXCLUDE_NS_EL0	(1U << 28)
+#define ARMV8_PMU_INCLUDE_EL2		(1U << 27)
+#define ARMV8_PMU_EXCLUDE_EL3		(1U << 26)
 
 /*
  * PMUSERENR: user enable reg
  */
-#define ARMV8_PMU_USERENR_MASK	0xf		/* Mask for writable bits */
 #define ARMV8_PMU_USERENR_EN	(1 << 0) /* PMU regs can be accessed at EL0 */
 #define ARMV8_PMU_USERENR_SW	(1 << 1) /* PMSWINC can be written at EL0 */
 #define ARMV8_PMU_USERENR_CR	(1 << 2) /* Cycle counter can be read at EL0 */
 #define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read at EL0 */
+/* Mask for writable bits */
+#define ARMV8_PMU_USERENR_MASK	(ARMV8_PMU_USERENR_EN | ARMV8_PMU_USERENR_SW | \
+				 ARMV8_PMU_USERENR_CR | ARMV8_PMU_USERENR_ER)
 
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
+#define ARMV8_PMU_THWIDTH	GENMASK(23, 20)
 
 /*
  * This code is really good
diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
index 5ea78986e665..9d51b5691349 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
@@ -42,13 +42,12 @@ struct pmreg_sets {
 
 static uint64_t get_pmcr_n(uint64_t pmcr)
 {
-	return (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
+	return FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
 }
 
 static void set_pmcr_n(uint64_t *pmcr, uint64_t pmcr_n)
 {
-	*pmcr = *pmcr & ~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
-	*pmcr |= (pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
+	u64p_replace_bits((__u64 *) pmcr, pmcr_n, ARMV8_PMU_PMCR_N);
 }
 
 static uint64_t get_counters_mask(uint64_t n)
-- 
2.34.1


