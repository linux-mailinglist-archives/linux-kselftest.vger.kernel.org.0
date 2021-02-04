Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF330F7C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 17:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhBDPCj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 10:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbhBDO61 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 09:58:27 -0500
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Feb 2021 06:57:46 PST
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E4FC0613D6
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 06:57:46 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4DWhLW17lHzvjfp; Thu,  4 Feb 2021 15:50:42 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] selftests/vDSO: fix ABI selftest on riscv
Date:   Thu,  4 Feb 2021 15:50:42 +0100
Message-Id: <20210204145042.7345-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Only older versions of the RISC-V GCC toolchain define __riscv__. Check
for __riscv as well, which is used by newer GCC toolchains. Also set
VDSO_32BIT based on __riscv_xlen.

Before (on riscv64):

$ ./vdso_test_abi
[vDSO kselftest] VDSO_VERSION: LINUX_4
Could not find __vdso_gettimeofday
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_REALTIME [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_BOOTTIME [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_TAI [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_REALTIME_COARSE [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_MONOTONIC [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_MONOTONIC_RAW [PASS]
Could not find __vdso_clock_gettime
Could not find __vdso_clock_getres
clock_id: CLOCK_MONOTONIC_COARSE [PASS]
Could not find __vdso_time

After (on riscv32):

$ ./vdso_test_abi
[vDSO kselftest] VDSO_VERSION: LINUX_4.15
The time is 1612449376.015086
The time is 1612449376.18340784
The resolution is 0 1
clock_id: CLOCK_REALTIME [PASS]
The time is 774.842586182
The resolution is 0 1
clock_id: CLOCK_BOOTTIME [PASS]
The time is 1612449376.22536565
The resolution is 0 1
clock_id: CLOCK_TAI [PASS]
The time is 1612449376.20885172
The resolution is 0 4000000
clock_id: CLOCK_REALTIME_COARSE [PASS]
The time is 774.845491269
The resolution is 0 1
clock_id: CLOCK_MONOTONIC [PASS]
The time is 774.849534200
The resolution is 0 1
clock_id: CLOCK_MONOTONIC_RAW [PASS]
The time is 774.842139684
The resolution is 0 4000000
clock_id: CLOCK_MONOTONIC_COARSE [PASS]
Could not find __vdso_time

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/testing/selftests/vDSO/vdso_config.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 6a6fe8d4ff55..6188b16827d1 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -47,10 +47,12 @@
 #elif defined(__x86_64__)
 #define VDSO_VERSION		0
 #define VDSO_NAMES		1
-#elif defined(__riscv__)
+#elif defined(__riscv__) || defined(__riscv)
 #define VDSO_VERSION		5
 #define VDSO_NAMES		1
+#if __riscv_xlen == 32
 #define VDSO_32BIT		1
+#endif
 #else /* nds32 */
 #define VDSO_VERSION		4
 #define VDSO_NAMES		1
-- 
2.30.0

