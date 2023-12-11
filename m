Return-Path: <linux-kselftest+bounces-1570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE180D0CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFB71F21880
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0A4C60C;
	Mon, 11 Dec 2023 16:14:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FCED114;
	Mon, 11 Dec 2023 08:14:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEFDE169E;
	Mon, 11 Dec 2023 08:15:28 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DAC43F738;
	Mon, 11 Dec 2023 08:14:38 -0800 (PST)
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
Subject: [PATCH v7 04/11] arm: perf: Convert remaining fields to use GENMASK
Date: Mon, 11 Dec 2023 16:13:16 +0000
Message-Id: <20231211161331.1277825-5-james.clark@arm.com>
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

Convert the remaining fields to use either GENMASK or be built from
other fields. These all already started at bit 0 so don't need a code
change for the lack of _SHIFT.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c       |  2 +-
 include/linux/perf/arm_pmuv3.h | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 7b2c1d03464a..fbdf3cab8e66 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -671,7 +671,7 @@ static u32 armv8pmu_getreset_flags(void)
 	value = read_pmovsclr();
 
 	/* Write to clear flags */
-	value &= ARMV8_PMU_OVSR_MASK;
+	value &= ARMV8_PMU_OVERFLOWED_MASK;
 	write_pmovsclr(value);
 
 	return value;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 1bc7678c10d4..daa63542242d 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -216,19 +216,25 @@
 #define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
 #define ARMV8_PMU_PMCR_LP	(1 << 7) /* Long event counter enable */
 #define ARMV8_PMU_PMCR_N	GENMASK(15, 11) /* Number of counters supported */
-#define ARMV8_PMU_PMCR_MASK	0xff    /* Mask for writable bits */
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
 #define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
-#define ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
+#define ARMV8_PMU_EVTYPE_EVENT	GENMASK(15, 0)	/* Mask for EVENT bits */
 
 /*
  * Event filters for PMUv3
@@ -243,11 +249,13 @@
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
 #define ARMV8_PMU_SLOTS		GENMASK(7, 0)
-- 
2.34.1


