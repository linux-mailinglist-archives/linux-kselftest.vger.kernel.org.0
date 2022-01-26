Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACEB49C99A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbiAZM0V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 07:26:21 -0500
Received: from foss.arm.com ([217.140.110.172]:36326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241247AbiAZM0U (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 07:26:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C76E0D6E;
        Wed, 26 Jan 2022 04:26:19 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6AA23F793;
        Wed, 26 Jan 2022 04:26:18 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] kselftest: Fix vdso_test_abi return status
Date:   Wed, 26 Jan 2022 12:26:08 +0000
Message-Id: <20220126122608.54061-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126102723.23300-3-cristian.marussi@arm.com>
References: <20220126102723.23300-3-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vdso_test_abi contains a batch of tests that verify the validity of the
vDSO ABI.

When a vDSO symbol is not found the relevant test is skipped reporting
KSFT_SKIP. All the tests return values are then added in a single
variable which is checked to verify failures. This approach can have
side effects which result in reporting the wrong kselftest exit status.

Fix vdso_test_abi verifying the return code of each test separately.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 27 +++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 3d603f1394af..3a4efb91b9b2 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -184,10 +184,12 @@ static inline int vdso_test_clock(clockid_t clock_id)
 	return ret0;
 }
 
+#define VDSO_TESTS_MAX	9
+
 int main(int argc, char **argv)
 {
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
-	int ret;
+	int ret[VDSO_TESTS_MAX] = {0};
 
 	if (!sysinfo_ehdr) {
 		printf("AT_SYSINFO_EHDR is not present!\n");
@@ -201,44 +203,45 @@ int main(int argc, char **argv)
 
 	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
 
-	ret = vdso_test_gettimeofday();
+	ret[0] = vdso_test_gettimeofday();
 
 #if _POSIX_TIMERS > 0
 
 #ifdef CLOCK_REALTIME
-	ret += vdso_test_clock(CLOCK_REALTIME);
+	ret[1] = vdso_test_clock(CLOCK_REALTIME);
 #endif
 
 #ifdef CLOCK_BOOTTIME
-	ret += vdso_test_clock(CLOCK_BOOTTIME);
+	ret[2] = vdso_test_clock(CLOCK_BOOTTIME);
 #endif
 
 #ifdef CLOCK_TAI
-	ret += vdso_test_clock(CLOCK_TAI);
+	ret[3] = vdso_test_clock(CLOCK_TAI);
 #endif
 
 #ifdef CLOCK_REALTIME_COARSE
-	ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
+	ret[4] = vdso_test_clock(CLOCK_REALTIME_COARSE);
 #endif
 
 #ifdef CLOCK_MONOTONIC
-	ret += vdso_test_clock(CLOCK_MONOTONIC);
+	ret[5] = vdso_test_clock(CLOCK_MONOTONIC);
 #endif
 
 #ifdef CLOCK_MONOTONIC_RAW
-	ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
+	ret[6] = vdso_test_clock(CLOCK_MONOTONIC_RAW);
 #endif
 
 #ifdef CLOCK_MONOTONIC_COARSE
-	ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
+	ret[7] = vdso_test_clock(CLOCK_MONOTONIC_COARSE);
 #endif
 
 #endif
 
-	ret += vdso_test_time();
+	ret[8] = vdso_test_time();
 
-	if (ret > 0)
-		return KSFT_FAIL;
+	for (int i = 0; i < VDSO_TESTS_MAX; i++)
+		if (ret[i] == KSFT_FAIL)
+			return KSFT_FAIL;
 
 	return KSFT_PASS;
 }
-- 
2.34.1

