Return-Path: <linux-kselftest+bounces-581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B497F794C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA4BB21AB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D04381D5;
	Fri, 24 Nov 2023 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25BD41733;
	Fri, 24 Nov 2023 08:36:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0253D1BA8;
	Fri, 24 Nov 2023 08:37:03 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BEC63F73F;
	Fri, 24 Nov 2023 08:36:14 -0800 (PST)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v3 22/25] kselftest/arm64: add HWCAP test for FEAT_S1POE
Date: Fri, 24 Nov 2023 16:35:07 +0000
Message-Id: <20231124163510.1835740-23-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124163510.1835740-1-joey.gouly@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that when POE is enabled, the POR_EL0 register is accessible.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 1189e77c8152..9ee7b04f3fbb 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -115,6 +115,12 @@ static void pmull_sigill(void)
 	asm volatile(".inst 0x0ee0e000" : : : );
 }
 
+static void poe_sigill(void)
+{
+	/* mrs x0, POR_EL0 */
+	asm volatile("mrs x0, S3_3_C10_C2_4" : : : "x0");
+}
+
 static void rng_sigill(void)
 {
 	asm volatile("mrs x0, S3_3_C2_C4_0" : : : "x0");
@@ -426,6 +432,14 @@ static const struct hwcap_data {
 		.cpuinfo = "pmull",
 		.sigill_fn = pmull_sigill,
 	},
+	{
+		.name = "POE",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_POE,
+		.cpuinfo = "poe",
+		.sigill_fn = poe_sigill,
+		.sigill_reliable = true,
+	},
 	{
 		.name = "RNG",
 		.at_hwcap = AT_HWCAP2,
-- 
2.25.1


