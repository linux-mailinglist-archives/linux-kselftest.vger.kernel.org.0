Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B14649C780
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 11:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiAZK1t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 05:27:49 -0500
Received: from foss.arm.com ([217.140.110.172]:57884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232519AbiAZK1k (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 05:27:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAE1C11D4;
        Wed, 26 Jan 2022 02:27:39 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23E173F766;
        Wed, 26 Jan 2022 02:27:38 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Cristian Marussi <cristian.marussi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 2/5] kselftest: Fix vdso_test_time to pass on skips
Date:   Wed, 26 Jan 2022 10:27:20 +0000
Message-Id: <20220126102723.23300-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126102723.23300-1-cristian.marussi@arm.com>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a vDSO symbol is not found, all the testcases in vdso_test_abi usually
report a SKIP, which, in turn, is reported back to Kselftest as a PASS.

Testcase vdso_test_time, instead, reporting a SKIP, causes the whole set of
tests within vdso_test_abi to be considered FAIL when symbol is not found.

Fix it reporting a PASS when vdso_test_time cannot find the vdso symbol.

Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Seen as a failure on both a JUNO and a Dragonboard on both recent and old
kernels/testruns:

root@deb-buster-arm64:~# /opt/ksft/vDSO/vdso_test_abi
[vDSO kselftest] VDSO_VERSION: LINUX_2.6.39
The time is 1637922136.675304
The time is 1637922136.675361000
The resolution is 0 1
clock_id: CLOCK_REALTIME [PASS]
The time is 1927.760604900
The resolution is 0 1
clock_id: CLOCK_BOOTTIME [PASS]
The time is 1637922136.675649700
The resolution is 0 1
clock_id: CLOCK_TAI [PASS]
The time is 1637922136.672000000
The resolution is 0 4000000
clock_id: CLOCK_REALTIME_COARSE [PASS]
The time is 1927.761005600
The resolution is 0 1
clock_id: CLOCK_MONOTONIC [PASS]
The time is 1927.761132780
The resolution is 0 1
clock_id: CLOCK_MONOTONIC_RAW [PASS]
The time is 1927.757093740
The resolution is 0 4000000
clock_id: CLOCK_MONOTONIC_COARSE [PASS]
Could not find __kernel_time              <<< This caused a FAIL as a whole
root@deb-buster-arm64:~# echo $?
1

e.g.: https://lkft.validation.linaro.org/scheduler/job/2192570#L27778
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 3d603f1394af..7dcc66d1cecf 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -90,8 +90,9 @@ static int vdso_test_time(void)
 		(vdso_time_t)vdso_sym(version, name[2]);
 
 	if (!vdso_time) {
+		/* Skip if symbol not found: consider skipped tests as passed */
 		printf("Could not find %s\n", name[2]);
-		return KSFT_SKIP;
+		return KSFT_PASS;
 	}
 
 	long ret = vdso_time(NULL);
-- 
2.17.1

