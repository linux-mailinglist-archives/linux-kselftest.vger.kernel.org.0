Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853964672A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378923AbhLCHfd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 02:35:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:9200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378931AbhLCHfc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 02:35:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236740527"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="236740527"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 23:32:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="513607793"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 23:32:06 -0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [RFC PATCH v5 2/2] selftests/x86: add xsave test after process switch
Date:   Fri,  3 Dec 2021 15:32:46 +0800
Message-Id: <170f6221d53798f99cf00f0cd830c970289081d8.1638513720.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1638513720.git.pengfei.xu@intel.com>
References: <cover.1638513720.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It will change FPU, AVX2, AVX512, PKRU xstates before process switch test to
ensure that the entire processing of these xstates works as expected.
In order to ensure the above XSAVE content is not affected after process
switch, this case tests that:
1.  The xstates content of the child process should same as xstates of parent
process.
2.  The xstates content of the child process should not change after
process switch back, even grandchild process cleaned up it's own XMM, YMM and
ZMM xstates.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/xsave_fork_test.c | 127 ++++++++++++++++++
 2 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/xsave_fork_test.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index b51f02bc38c2..5b627ae5e385 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx xsave_signal_handle
+			corrupt_xstate_header amx xsave_signal_handle xsave_fork_test
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/xsave_fork_test.c b/tools/testing/selftests/x86/xsave_fork_test.c
new file mode 100644
index 000000000000..00d1bfcfc6f7
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_fork_test.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * It's for XSAVE fork test.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <x86intrin.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+
+#include "xsave_common.h"
+
+static unsigned char *xsave_buf0, *xsave_buf1, *xsave_buf2;
+static int xsave_size, read_result[2];
+static const char *fork_test = "xsave fork for xsave context switch test";
+
+void set_xstates(void)
+{
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
+
+	populate_xstate_regs();
+}
+
+void clear_avx(void)
+{
+	asm volatile("vzeroall");
+}
+
+/* use fork to create pid and trigger context switch test */
+int test_fork(void)
+{
+	pid_t child;
+	int status, fd[2], result[2];
+	const char *test_xsave_child = "Child xstate was same as parent";
+	const char *test_process_swich = "Xstate after process switch was same";
+
+	/* Use pipe to transfer test result of child process to parent process */
+	if (pipe(fd) < 0)
+		execution_failed("FAIL: create pipe failed\n");
+
+	XSAVE(xsave_buf0, XSAVE_TEST_MASK);
+	child = fork();
+	if (child < 0)
+		execution_failed("fork failed\n");
+	if (child == 0) {
+		XSAVE(xsave_buf1, XSAVE_TEST_MASK);
+		result[0] = compare_xsave_buf(xsave_buf0, xsave_buf1, xsave_size,
+			fork_test, NO_CHANGE);
+		close(fd[0]);
+		if (!write(fd[1], &result, sizeof(result)))
+			execution_failed("FAIL: write fd failed.\n");
+
+		XSAVE(xsave_buf1, XSAVE_TEST_MASK);
+		pid_t grandchild;
+
+		/* fork grandchild will trigger process switching in child */
+		grandchild = fork();
+		if (grandchild == 0) {
+			ksft_print_msg("Grandchild pid:%d clean it's XMM YMM ZMM xstates\n",
+				getpid());
+			clear_avx();
+			return 0;
+		}
+		if (grandchild)
+			waitpid(grandchild, NULL, 0);
+
+		/* After swich back to child process and check xstate */
+		XSAVE(xsave_buf2, XSAVE_TEST_MASK);
+		ksft_print_msg("Child pid:%d check xstate after swtich back\n",
+			getpid());
+		result[1] = compare_xsave_buf(xsave_buf1, xsave_buf2, xsave_size,
+			fork_test, NO_CHANGE);
+		if (!write(fd[1], &result, sizeof(result)))
+			execution_failed("FAIL: write fd failed.\n");
+
+		return 0;
+	}
+
+	if (child) {
+		if (waitpid(child, &status, 0) != child || !WIFEXITED(status))
+			ksft_test_result_fail("Child exit with error, status:0x%x\n",
+				status);
+		else {
+			ksft_print_msg("Parent pid:%d get results\n", getpid());
+			close(fd[1]);
+			if (!read(fd[0], &read_result, sizeof(read_result)))
+				execution_failed("FAIL: read fd failed.\n");
+		}
+	}
+
+	ksft_set_plan(2);
+	check_result(read_result[0], test_xsave_child);
+	check_result(read_result[1], test_process_swich);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	cpu_set_t set;
+
+	xsave_size = get_xsave_size();
+	ksft_print_header();
+
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+
+	set_xstates();
+	test_fork();
+
+	ksft_exit(!ksft_get_fail_cnt());
+}
-- 
2.27.0

