Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5947B8F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 04:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhLUDWF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 22:22:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:27636 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhLUDWE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 22:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640056924; x=1671592924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRYhchPzlWTtuqateeW1NvpOl2CqeHB7ZFBuD1BvV7Y=;
  b=YArnLxjKRaYmC0AgcIu2zD7pKa1PD5rp8cz5floh8NWaTd0T24BjWR6U
   ynh7vumV/QNhKbKGmidyKU6qTfqc44PKlB5zL1R/449vqCGjWQd+gboNF
   hyT2jcBlyhYMPIC+7smn9FD8T0EdKrTELIoGuIiDcFNYkoLaxrhoIql41
   F/ygLDMvrXBvWEWDivtDTNjjEVk/LKo8urDET5KOk27dJwxdPcAo20cDn
   VQ+e1+i4FcYhPDravGB5xgwwACup2MaLPSteDDC50iMWH2WCSBeuq/2Od
   XZAP6FOQHylztBh+t6Ul9GkbOqhXEcPZYcQPAytr4r0nHyfKpvTHZO1Ku
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240269557"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="240269557"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 19:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="484277890"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2021 19:21:59 -0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH v6 2/2] selftests/x86: add xsave test related to process switching
Date:   Tue, 21 Dec 2021 11:22:50 +0800
Message-Id: <153cbbb0279d99d454b06393c19e541fba44d4cd.1640052713.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1640052713.git.pengfei.xu@intel.com>
References: <cover.1640052713.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It will change FPU, SSE(XMM), AVX2(YMM), AVX512, PKRU xstates before process
switching test to ensure that these xstates have been tested.
In order to ensure that the content of xstates is not affected across process
switching, this case tests that:
1. The xstates content of the child process should be the same as that of the
   parent process.
2. The xstates content of the process should be the same across process
   switching.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 tools/testing/selftests/x86/Makefile          |   3 +-
 tools/testing/selftests/x86/xsave_fork_test.c | 117 ++++++++++++++++++
 2 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/xsave_fork_test.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index a9e452b65ba2..049f8ffb2742 100644
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
 
@@ -106,3 +106,4 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
 $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/xsave_signal_handle_64: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
+$(OUTPUT)/xsave_fork_test_64: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
diff --git a/tools/testing/selftests/x86/xsave_fork_test.c b/tools/testing/selftests/x86/xsave_fork_test.c
new file mode 100644
index 000000000000..507334e25eba
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_fork_test.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * It's used for XSAVE test with process switching.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/syscall.h>
+
+#include "xsave_common.h"
+
+void *aligned_alloc(size_t alignment, size_t size);
+static unsigned char *xsave_buf0, *xsave_buf1, *xsave_buf2;
+static int xsave_size;
+
+void prepare_environment(void)
+{
+	xsave_size = get_xsave_size();
+	printf("XSAVE_TEST_MASK:0x%x, xsave size:0x%x\n",
+		XSAVE_TEST_MASK, xsave_size);
+	check_cpu_capability();
+
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
+}
+
+/* Use fork to create pid and trigger process switch test */
+int test_xsave_fork(void)
+{
+	pid_t child, grandchild;
+	int status, result[2];
+	const char *test_xsave_child = "Child xstate was same as parent";
+	const char *test_process_switch = "Xstate after the process switch didn't change";
+	uint32_t ui32_change = 0xffff0000;
+
+	populate_xstate_regs();
+	xsave(xsave_buf0, XSAVE_TEST_MASK);
+	child = syscall(SYS_fork);
+	if (child < 0)
+		execution_failed("fork failed\n");
+	if (child == 0) {
+		xsave(xsave_buf1, XSAVE_TEST_MASK);
+		result[0] = compare_xsave_buf(xsave_buf0, xsave_buf1, xsave_size,
+			test_xsave_child, NO_CHANGE);
+
+		/*
+		 * If above case is failed and prints some failed reason, in
+		 * order to avoid libc printf change and clean up some xstates,
+		 * populate xstates again for next test
+		 */
+		populate_xstate_regs();
+		xsave(xsave_buf1, XSAVE_TEST_MASK);
+
+		/* fork grandchild will trigger process switching in child */
+		grandchild = syscall(SYS_fork);
+		if (grandchild == 0) {
+			printf("Grandchild pid:%d change it's own xstates\n", getpid());
+			change_xstate(ui32_change);
+			return 0;
+		}
+		if (grandchild) {
+			if (waitpid(grandchild, &status, 0) != grandchild || !WIFEXITED(status))
+				printf("[FAIL]:Grandchild exit with error, status:0x%x\n",
+					status);
+		}
+		/* After switch back to child process and check xstate */
+		xsave(xsave_buf2, XSAVE_TEST_MASK);
+		result[1] = compare_xsave_buf(xsave_buf1, xsave_buf2, xsave_size,
+			test_process_switch, NO_CHANGE);
+		printf("Child pid:%d check xstate after swtich back\n",
+			getpid());
+
+		check_result(result[0], test_xsave_child);
+		check_result(result[1], test_process_switch);
+		printf("Xstate in process switch test pass[%d/%d], err_num:%d\n",
+			pass_num, case_num, err_num);
+
+		return 0;
+	}
+
+	if (child) {
+		if (waitpid(child, &status, 0) != child || !WIFEXITED(status))
+			printf("[FAIL]:Child exit with error, status:0x%x\n",
+				status);
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	cpu_set_t set;
+
+	case_num = 2;
+	CPU_ZERO(&set);
+	CPU_SET(0, &set);
+	sched_setaffinity(getpid(), sizeof(set), &set);
+
+	prepare_environment();
+	test_xsave_fork();
+
+	return 0;
+}
-- 
2.31.1

