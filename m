Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B858A24DB75
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgHUQk1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Aug 2020 12:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbgHUQUo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Aug 2020 12:20:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3817E23100;
        Fri, 21 Aug 2020 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026797;
        bh=yKqhpIt2E7otdBYwhnTyQ4kLewxec0P6sMq8BMGFrfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnxd7sbxH4bHnSmT6e+1IcfgZMlT2IvNGBFpXxnhygv4r6NAA2ESU/42xzl9ciJb6
         81CmLcFXriPWLd5Zaj43nxgmtiAeGy/u5Wxpd64/+KVkV+7tdTghVNvxpOBlt2I6aH
         ygb7NQS89GHmxLNiV9kIQnImfltxWmFDHcKAMQ10=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 14/26] selftests/powerpc: Purge extra count_pmc() calls of ebb selftests
Date:   Fri, 21 Aug 2020 12:19:25 -0400
Message-Id: <20200821161938.349246-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161938.349246-1-sashal@kernel.org>
References: <20200821161938.349246-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>

[ Upstream commit 3337bf41e0dd70b4064cdf60acdfcdc2d050066c ]

An extra count on ebb_state.stats.pmc_count[PMC_INDEX(pmc)] is being per-
formed when count_pmc() is used to reset PMCs on a few selftests. This
extra pmc_count can occasionally invalidate results, such as the ones from
cycles_test shown hereafter. The ebb_check_count() failed with an above
the upper limit error due to the extra value on ebb_state.stats.pmc_count.

Furthermore, this extra count is also indicated by extra PMC1 trace_log on
the output of the cycle test (as well as on pmc56_overflow_test):

==========
   ...
   [21]: counter = 8
   [22]: register SPRN_MMCR0 = 0x0000000080000080
   [23]: register SPRN_PMC1  = 0x0000000080000004
   [24]: counter = 9
   [25]: register SPRN_MMCR0 = 0x0000000080000080
   [26]: register SPRN_PMC1  = 0x0000000080000004
   [27]: counter = 10
   [28]: register SPRN_MMCR0 = 0x0000000080000080
   [29]: register SPRN_PMC1  = 0x0000000080000004
>> [30]: register SPRN_PMC1  = 0x000000004000051e
PMC1 count (0x280000546) above upper limit 0x2800003e8 (+0x15e)
[FAIL] Test FAILED on line 52
failure: cycles
==========

Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200626164737.21943-1-desnesn@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c     | 2 --
 tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c      | 2 --
 .../selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c    | 2 --
 .../selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c     | 2 --
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c              | 2 --
 .../selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c  | 2 --
 .../selftests/powerpc/pmu/ebb/lost_exception_test.c        | 1 -
 .../testing/selftests/powerpc/pmu/ebb/multi_counter_test.c | 7 -------
 .../selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c       | 2 --
 .../testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c | 2 --
 .../selftests/powerpc/pmu/ebb/pmc56_overflow_test.c        | 2 --
 11 files changed, 26 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c b/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c
index 94110b1dcd3d8..031baa43646fb 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c
@@ -91,8 +91,6 @@ int back_to_back_ebbs(void)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(1, sample_period);
-
 	dump_ebb_state();
 
 	event_close(&event);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c
index 7c57a8d79535d..361e0be9df9ae 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c
@@ -42,8 +42,6 @@ int cycles(void)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(1, sample_period);
-
 	dump_ebb_state();
 
 	event_close(&event);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c
index ecf5ee3283a3e..fe7d0dc2a1a26 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c
@@ -99,8 +99,6 @@ int cycles_with_freeze(void)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(1, sample_period);
-
 	dump_ebb_state();
 
 	printf("EBBs while frozen %d\n", ebbs_while_frozen);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c
index c0faba520b35c..b9b30f974b5ea 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c
@@ -71,8 +71,6 @@ int cycles_with_mmcr2(void)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(1, sample_period);
-
 	dump_ebb_state();
 
 	event_close(&event);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
index 46681fec549b8..2694ae161a84a 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -396,8 +396,6 @@ int ebb_child(union pipe read_pipe, union pipe write_pipe)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(1, sample_period);
-
 	dump_ebb_state();
 
 	event_close(&event);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c
index a991d2ea8d0a1..174e4f4dae6c0 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c
@@ -38,8 +38,6 @@ static int victim_child(union pipe read_pipe, union pipe write_pipe)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(1, sample_period);
-
 	dump_ebb_state();
 
 	FAIL_IF(ebb_state.stats.ebb_count == 0);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
index eb8acb78bc6c1..531083accfcad 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
@@ -75,7 +75,6 @@ static int test_body(void)
 	ebb_freeze_pmcs();
 	ebb_global_disable();
 
-	count_pmc(4, sample_period);
 	mtspr(SPRN_PMC4, 0xdead);
 
 	dump_summary_ebb_state();
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c b/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c
index 6ff8c8ff27d66..035c02273cd49 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c
@@ -70,13 +70,6 @@ int multi_counter(void)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(1, sample_period);
-	count_pmc(2, sample_period);
-	count_pmc(3, sample_period);
-	count_pmc(4, sample_period);
-	count_pmc(5, sample_period);
-	count_pmc(6, sample_period);
-
 	dump_ebb_state();
 
 	for (i = 0; i < 6; i++)
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c b/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c
index 037cb6154f360..3e9d4ac965c85 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c
@@ -61,8 +61,6 @@ static int cycles_child(void)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(1, sample_period);
-
 	dump_summary_ebb_state();
 
 	event_close(&event);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c b/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c
index c5fa64790c22e..d90891fe96a32 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c
@@ -82,8 +82,6 @@ static int test_body(void)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(1, sample_period);
-
 	dump_ebb_state();
 
 	if (mmcr0_mismatch)
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c b/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
index 30e1ac62e8cb4..8ca92b9ee5b01 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
@@ -76,8 +76,6 @@ int pmc56_overflow(void)
 	ebb_global_disable();
 	ebb_freeze_pmcs();
 
-	count_pmc(2, sample_period);
-
 	dump_ebb_state();
 
 	printf("PMC5/6 overflow %d\n", pmc56_overflowed);
-- 
2.25.1

