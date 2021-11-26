Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1745EBA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 11:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376946AbhKZKeJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 05:34:09 -0500
Received: from foss.arm.com ([217.140.110.172]:60462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347825AbhKZKcJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 05:32:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83B781042;
        Fri, 26 Nov 2021 02:28:56 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFBED3F5A1;
        Fri, 26 Nov 2021 02:28:55 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, shuah@kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] kselftest: Fix vdso_test_time to pass on skips
Date:   Fri, 26 Nov 2021 10:28:46 +0000
Message-Id: <20211126102846.5550-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a vDSO symbol is not found, all the testcases in vdso_test_abi usually
report a SKIP, which, in turn, is reported back to Kselftest as a PASS.

Testcase vdso_test_time, instead, reporting a SKIP, causes the whole set of
tests within vdso_test_abi to be considered FAIL when symbol is not found.

Fix it reporting a PASS when vdso_test_time cannot find the vdso symbol.

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

