Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E614342288
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCSQyH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 12:54:07 -0400
Received: from foss.arm.com ([217.140.110.172]:56850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhCSQxv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 12:53:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72AAEED1;
        Fri, 19 Mar 2021 09:53:51 -0700 (PDT)
Received: from e104803-lin.cambridge.arm.com (e104803-lin.cambridge.arm.com [10.1.197.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39D0A3F70D;
        Fri, 19 Mar 2021 09:53:50 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 06/11] kselftest/arm64: mte: Fix MTE feature detection
Date:   Fri, 19 Mar 2021 16:53:29 +0000
Message-Id: <20210319165334.29213-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20210319165334.29213-1-andre.przywara@arm.com>
References: <20210319165334.29213-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To check whether the CPU and kernel support the MTE features we want
to test, we use an (emulated) CPU ID register read. However we only
check against a very particular feature version (0b0010), even though
the ARM ARM promises ID register features to be backwards compatible.

While this could be fixed by using ">=" instead of "==", we should
actually use the explicit HWCAP2_MTE hardware capability, exposed by the
kernel via the ELF auxiliary vectors.

That moves this responsibility to the kernel, and fixes running the
tests on machines with FEAT_MTE3 capability.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 4e887dad762d..aa8a8a6b8b6d 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -291,22 +291,13 @@ int mte_switch_mode(int mte_option, unsigned long incl_mask)
 	return 0;
 }
 
-#define ID_AA64PFR1_MTE_SHIFT		8
-#define ID_AA64PFR1_MTE			2
-
 int mte_default_setup(void)
 {
-	unsigned long hwcaps = getauxval(AT_HWCAP);
+	unsigned long hwcaps2 = getauxval(AT_HWCAP2);
 	unsigned long en = 0;
 	int ret;
 
-	if (!(hwcaps & HWCAP_CPUID)) {
-		ksft_print_msg("FAIL: CPUID registers unavailable\n");
-		return KSFT_FAIL;
-	}
-	/* Read ID_AA64PFR1_EL1 register */
-	asm volatile("mrs %0, id_aa64pfr1_el1" : "=r"(hwcaps) : : "memory");
-	if (((hwcaps >> ID_AA64PFR1_MTE_SHIFT) & MT_TAG_MASK) != ID_AA64PFR1_MTE) {
+	if (!(hwcaps2 & HWCAP2_MTE)) {
 		ksft_print_msg("FAIL: MTE features unavailable\n");
 		return KSFT_SKIP;
 	}
-- 
2.17.5

