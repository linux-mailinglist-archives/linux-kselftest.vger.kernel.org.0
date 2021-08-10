Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC773D6CDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 05:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhG0CzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 22:55:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:58530 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235052AbhG0CzB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 22:55:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="199586984"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="199586984"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 20:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="505307708"
Received: from fedora29.sh.intel.com ([10.239.182.87])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2021 20:35:25 -0700
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        Yu Yu-cheng <yu-cheng.yu@intel.com>,
        Yu Fenghua <fenghua.yu@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>
Subject: [RFC PATCH v1 2/2] selftests/xsave: add xsave test during signal handling
Date:   Tue, 27 Jul 2021 11:34:44 +0800
Message-Id: <803913138a1062f888c3ebe7f632c626b0d64fb9.1627355565.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1627355565.git.pengfei.xu@intel.com>
References: <cover.1627355565.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to ensure that the XSAVE content is not affected by signal handling,
this case tests XSAVE content should not change in nested signal handling,
and XSAVE content should same before and after signal handling.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 tools/testing/selftests/xsave/.gitignore      |   1 +
 tools/testing/selftests/xsave/Makefile        |   2 +-
 .../selftests/xsave/xsave_signal_handle.c     | 184 ++++++++++++++++++
 3 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/xsave/xsave_signal_handle.c

diff --git a/tools/testing/selftests/xsave/.gitignore b/tools/testing/selftests/xsave/.gitignore
index 00b9970360c4..b448d36186f3 100644
--- a/tools/testing/selftests/xsave/.gitignore
+++ b/tools/testing/selftests/xsave/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 xsave_instruction
+xsave_signal_handle
diff --git a/tools/testing/selftests/xsave/Makefile b/tools/testing/selftests/xsave/Makefile
index dafdb0abdeb3..fedae2778297 100644
--- a/tools/testing/selftests/xsave/Makefile
+++ b/tools/testing/selftests/xsave/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS := -g -Wall -mxsave -O2
 
-TEST_GEN_PROGS := xsave_instruction
+TEST_GEN_PROGS := xsave_instruction xsave_signal_handle
 
 include ../lib.mk
diff --git a/tools/testing/selftests/xsave/xsave_signal_handle.c b/tools/testing/selftests/xsave/xsave_signal_handle.c
new file mode 100644
index 000000000000..0afcba3a1bd5
--- /dev/null
+++ b/tools/testing/selftests/xsave/xsave_signal_handle.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * It's for xsave/xrstor during signal handling tests
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <x86intrin.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/wait.h>
+#include <time.h>
+
+#include "../kselftest.h"
+#include "xsave_common.h"
+
+static unsigned char *xsave_buf0, *xsave_buf1, *xsave_buf2, *xsave_buf3;
+static int result[2];
+
+static void change_fpu_content(uint32_t ui32_random, double flt)
+{
+	asm volatile ("fldl %0" : : "m" (flt));
+	asm volatile ("vbroadcastss %0, %%ymm0" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm1" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm2" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm3" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm4" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm5" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm6" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm7" : : "m" (ui32_random));
+	#ifndef __i386__
+	asm volatile ("vbroadcastss %0, %%ymm8" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm9" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm10" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm11" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm12" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm13" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm14" : : "m" (ui32_random));
+	asm volatile ("vbroadcastss %0, %%ymm15" : : "m" (ui32_random));
+	#endif
+}
+
+static void usr1_handler(int signum, siginfo_t *info, void *__ctxp)
+{
+	uint32_t ui32_random;
+	double flt;
+	int xsave_size;
+	const char *test_name = "Child XSAVE should not change in nested signal";
+
+	ui32_random = rand();
+	flt = ui32_random/10000.0;
+	if (signum == SIGUSR1) {
+		ksft_print_msg("SIGUSR1:0x%x changed fld:%f & ymm0-15:0x%x\n",
+			SIGUSR1, flt, ui32_random);
+		change_fpu_content(ui32_random, flt);
+	}
+	xsave_size = get_xsave_size();
+	XSAVE(xsave_buf2, SAVE_MASK);
+	raise(SIGUSR2);
+	XSAVE(xsave_buf3, SAVE_MASK);
+	result[0] = check_xsave_buf(xsave_buf2, xsave_buf2, xsave_size, test_name,
+				NO_CHANGE);
+}
+
+static void usr2_handler(int signum, siginfo_t *info, void *__ctxp)
+{
+	uint32_t ui32_random;
+	double flt;
+
+	ui32_random = rand();
+	flt = ui32_random/10000.0;
+	if (signum == SIGUSR2) {
+		ksft_print_msg("SIGUSR2:0x%x changed fld:%f & ymm0-15:0x%x\n",
+			SIGUSR2, flt, ui32_random);
+		change_fpu_content(ui32_random, flt);
+	}
+}
+
+static void set_signal_handle(void)
+{
+	struct sigaction sigact;
+
+	memset(&sigact, 0, sizeof(sigact));
+	if (sigemptyset(&sigact.sa_mask))
+		execution_failed("FAIL: sigemptyset error\n");
+
+	sigact.sa_flags = SA_SIGINFO;
+
+	sigact.sa_sigaction = usr1_handler;
+	if (sigaction(SIGUSR1, &sigact, NULL))
+		execution_failed("FAIL: SIGUSR1 handling failed\n");
+
+	sigact.sa_sigaction = usr2_handler;
+	if (sigaction(SIGUSR2, &sigact, NULL))
+		execution_failed("FAIL: SIGUSR2 handling failed\n");
+}
+
+static void sig_handle_xsave_test(void)
+{
+	int i, loop_times = 100, xsave_size;
+	const char *sig_test_name0 = "Child XSAVE was same in nested signal test";
+	const char *sig_test_name1 = "Child XSAVE content was same after signal";
+
+	xsave_size = get_xsave_size();
+	/* SDM XSAVE: misalignment to a 64-byte boundary will result in #GP */
+	xsave_buf0 = aligned_alloc(64, xsave_size);
+	if (!xsave_buf0)
+		execution_failed("aligned_alloc xsave_buf0 failed\n");
+	xsave_buf1 = aligned_alloc(64, xsave_size);
+	if (!xsave_buf1)
+		execution_failed("aligned_alloc xsave_buf1 failed\n");
+	xsave_buf2 = aligned_alloc(64, xsave_size);
+	if (!xsave_buf2)
+		execution_failed("aligned_alloc xsave_buf2 failed\n");
+	xsave_buf3 = aligned_alloc(64, xsave_size);
+	if (!xsave_buf3)
+		execution_failed("aligned_alloc xsave_buf3 failed\n");
+
+	srand(time(NULL));
+	result[0] = RESULT_PASS;
+	result[1] = RESULT_PASS;
+
+	XSAVE(xsave_buf0, SAVE_MASK);
+	for (i = 1; i <= loop_times; i++) {
+		raise(SIGUSR1);
+		XSAVE(xsave_buf1, SAVE_MASK);
+		result[1] = check_xsave_buf(xsave_buf0, xsave_buf1, xsave_size,
+						sig_test_name1, NO_CHANGE);
+		if (result[1] != RESULT_PASS)
+			break;
+	}
+
+	check_result(result[0], sig_test_name0);
+	check_result(result[1], sig_test_name1);
+}
+
+static void test_xsave_sig_handle(void)
+{
+	const char *test_name0 = "xsave in child nested signal handling test";
+	const char *test_name1 = "xsave after child signal handling test";
+	pid_t child;
+	int status, fd[2], readbuf[2];
+
+	set_signal_handle();
+
+	/* Use pipe to transfer test result of child process to parent process */
+	if (pipe(fd) < 0)
+		execution_failed("FAIL: create pipe failed\n");
+
+	/* Use child process testing to avoid abnormal blocking the next test */
+	child = fork();
+	if (child < 0)
+		execution_failed("FAIL: create child pid failed\n");
+	else if	(child == 0) {
+		populate_fpu_regs();
+		sig_handle_xsave_test();
+		close(fd[0]);
+		write(fd[1], &result, sizeof(result));
+	} else {
+		if (waitpid(child, &status, 0) != child ||
+			!WIFEXITED(status))
+			execution_failed("FAIL: Child died unexpectedly\n");
+		else {
+			close(fd[1]);
+			read(fd[0], &readbuf, sizeof(readbuf));
+
+			check_result(readbuf[0], test_name0);
+			check_result(readbuf[1], test_name1);
+		}
+	}
+}
+
+int main(void)
+{
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	test_xsave_sig_handle();
+
+	ksft_exit(!ksft_get_fail_cnt());
+}
-- 
2.20.1

