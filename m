Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD4D40D404
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 09:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhIPHsG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 03:48:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:61638 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234826AbhIPHsF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 03:48:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202007577"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="202007577"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 00:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="545422577"
Received: from fedora29.sh.intel.com ([10.239.182.87])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Sep 2021 00:46:42 -0700
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
        Chen Yu C <yu.c.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [RFC PATCH v4 1/2] selftests/xsave: test basic XSAVE architecture functionality
Date:   Thu, 16 Sep 2021 15:45:32 +0800
Message-Id: <992383b22504a9f472d4224dbbf3adbd51c60625.1631776654.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1631776654.git.pengfei.xu@intel.com>
References: <cover.1631776654.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The XSAVE feature set supports the saving and restoring of state components,
and XSAVE feature is used for process context switching. XSAVE state
components include FPU-related x87 state, SSE state, AVX state, etc.

This case tests and verifies the basic functions of XSAVE/XRSTOR in user
space: display and test the content changes of XSAVE; when the xstate in the
same process on the x86 platform is unchanged, the contents of XRSTOR and
XSAVE should be the same. This case is the most basic test of XSAVE function.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
Reported-by: kernel test robot <lkp@intel.com> # compile issues during review
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/xsave/.gitignore      |   2 +
 tools/testing/selftests/xsave/Makefile        |   6 +
 tools/testing/selftests/xsave/xsave_common.h  | 246 ++++++++++++++++++
 .../selftests/xsave/xsave_instruction.c       |  83 ++++++
 5 files changed, 338 insertions(+)
 create mode 100644 tools/testing/selftests/xsave/.gitignore
 create mode 100644 tools/testing/selftests/xsave/Makefile
 create mode 100644 tools/testing/selftests/xsave/xsave_common.h
 create mode 100644 tools/testing/selftests/xsave/xsave_instruction.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c852eb40c4f7..266e2bb982a1 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -75,6 +75,7 @@ TARGETS += user
 TARGETS += vDSO
 TARGETS += vm
 TARGETS += x86
+TARGETS += xsave
 TARGETS += zram
 #Please keep the TARGETS list alphabetically sorted
 # Run "make quicktest=1 run_tests" or
diff --git a/tools/testing/selftests/xsave/.gitignore b/tools/testing/selftests/xsave/.gitignore
new file mode 100644
index 000000000000..00b9970360c4
--- /dev/null
+++ b/tools/testing/selftests/xsave/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+xsave_instruction
diff --git a/tools/testing/selftests/xsave/Makefile b/tools/testing/selftests/xsave/Makefile
new file mode 100644
index 000000000000..dafdb0abdeb3
--- /dev/null
+++ b/tools/testing/selftests/xsave/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS := -g -Wall -mxsave -O2
+
+TEST_GEN_PROGS := xsave_instruction
+
+include ../lib.mk
diff --git a/tools/testing/selftests/xsave/xsave_common.h b/tools/testing/selftests/xsave/xsave_common.h
new file mode 100644
index 000000000000..2d3feae8096c
--- /dev/null
+++ b/tools/testing/selftests/xsave/xsave_common.h
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <x86intrin.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include "../kselftest.h"
+
+#ifdef __i386__
+#define XSAVE _xsave
+#else
+#define XSAVE _xsave64
+#endif
+
+#ifdef __i386__
+#define XRSTOR _xrstor
+#else
+#define XRSTOR _xrstor64
+#endif
+
+#define SAVE_MASK 0xffffffffffffffff
+#define RESULT_PASS 0
+#define RESULT_FAIL 1
+#define RESULT_ERROR 3
+#define CHANGE 10
+#define NO_CHANGE 11
+
+/* Copied from Linux kernel */
+static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				unsigned int *ecx, unsigned int *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+		: "=a" (*eax),
+		  "=b" (*ebx),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (*eax), "2" (*ecx)
+		: "memory");
+}
+
+void execution_failed(char *reason)
+{
+	ksft_test_result_xfail("%s", reason);
+	ksft_exit_fail();
+}
+
+int get_xsave_size(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	eax = 0x0d;
+	ebx = 0;
+	ecx = 0;
+	edx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	return (int)ecx;
+}
+
+void dump_buffer(unsigned char *buf, int size)
+{
+	int i, j;
+
+	printf("xsave size = %d (%03xh)\n", size, size);
+
+	for (i = 0; i < size; i += 16) {
+		printf("%04x: ", i);
+
+		for (j = i; ((j < i + 16) && (j < size)); j++)
+			printf("%02x ", buf[j]);
+		printf("\n");
+	}
+}
+
+void show_part_buf(unsigned char *buf0, unsigned char *buf1, int start,
+		int size)
+{
+	int c;
+
+	printf("%04x: ", start);
+	for (c = start; ((c < start + 16) && (c < size)); c++)
+		printf("%02x ", buf0[c]);
+	printf(" ->  ");
+	for (c = start; ((c < start + 16) && (c < size)); c++)
+		printf("%02x ", buf1[c]);
+	printf("\n");
+}
+
+int show_buf_diff(unsigned char *buf0, unsigned char *buf1, int size)
+{
+	int a, b, result_buf = RESULT_PASS;
+
+	for (a = 0; a < size; a += 16) {
+		/* SDM "XSAVE Area": XSAVE feature set does not use bytes 511:416 */
+		if ((a >= 416) && (a <= 511))
+			continue;
+
+		for (b = a; ((b < a + 16) && (b < size)); b++) {
+			if (buf0[b] != buf1[b]) {
+				show_part_buf(buf0, buf1, a, size);
+				result_buf = RESULT_FAIL;
+				break;
+			}
+		}
+	}
+
+	return result_buf;
+}
+
+int check_xsave_reserved_header(unsigned char *buf0,
+			unsigned char *buf1, int size, const char *test_name)
+{
+	int a, b, result_resv_header = RESULT_PASS;
+
+	/* SDM: Software should ensure that bytes 63:16 of the XSAVE header are 0 */
+	for (a = 528; a < 576 ; a += 16) {
+		for (b = a; ((b < a + 16) && (b < size)); b++) {
+			if ((buf0[b] != 0) || (buf1[b] != 0)) {
+				ksft_print_msg("%s FAIL: buf0[%d]:%d or buf1[%d]:%d not 0\n",
+					test_name, b, buf0[b], b, buf1[b]);
+				show_part_buf(buf0, buf1, a, size);
+				result_resv_header = RESULT_FAIL;
+				break;
+			}
+		}
+	}
+
+	return result_resv_header;
+}
+
+int check_xsave_buf(unsigned char *buf0, unsigned char *buf1,
+	int size, const char *test_name, int change)
+{
+	int result_buf = RESULT_ERROR, result_resv_header = RESULT_ERROR;
+
+	switch (change) {
+	case CHANGE:
+		if (show_buf_diff(buf0, buf1, size))
+			result_buf = RESULT_PASS;
+		else {
+			ksft_print_msg("%s FAIL: xsave content was same\n", test_name);
+			result_buf = RESULT_FAIL;
+		}
+		break;
+	case NO_CHANGE:
+		if (show_buf_diff(buf0, buf1, size)) {
+			ksft_print_msg("%s FAIL: xsave content changed\n", test_name);
+			show_buf_diff(buf0, buf1, size);
+			result_buf = RESULT_FAIL;
+		} else
+			result_buf = RESULT_PASS;
+		break;
+	default:
+		ksft_test_result_error("%s ERROR: invalid change:%d\n", test_name,
+			change);
+		break;
+	}
+
+	result_resv_header = check_xsave_reserved_header(buf0, buf1, size,
+		test_name);
+
+	return (result_buf || result_resv_header);
+}
+
+void check_result(int result, const char *test_name)
+{
+	switch (result) {
+	case RESULT_PASS:
+		ksft_test_result_pass("%s PASS\n", test_name);
+		break;
+	case RESULT_FAIL:
+		ksft_test_result_fail("%s FAIL\n", test_name);
+		break;
+	case RESULT_ERROR:
+		ksft_test_result_fail("%s ERROR\n", test_name);
+		break;
+	default:
+		ksft_test_result_error("%s ERROR: invalid result:%c\n",
+			test_name, result);
+		break;
+	}
+}
+
+void populate_fpu_regs(void)
+{
+	uint32_t ui32;
+	uint64_t ui64;
+
+	ui32 = 1;
+	ui64 = 0xBAB00500FAB7;
+
+	/* Initialize FPU and push different values onto FPU register stack: */
+	asm volatile ("finit");
+	asm volatile ("fldl %0" : : "m" (ui64));
+	asm volatile ("flds %0" : : "m" (ui32));
+	ui64 += 0x93ABE13;
+	asm volatile ("fldl %0" : : "m" (ui64));
+	ui64 += 0x93;
+	asm volatile ("fldl %0" : : "m" (ui64));
+	asm volatile ("flds %0" : : "m" (ui32));
+	asm volatile ("fldl %0" : : "m" (ui64));
+	ui64 -= 0x21;
+	asm volatile ("fldl %0" : : "m" (ui64));
+	asm volatile ("flds %0" : : "m" (ui32));
+	asm volatile ("fldl %0" : : "m" (ui64));
+
+	/* Fill each remaining YMM register with a different value: */
+	asm volatile ("vbroadcastss %0, %%ymm0" : : "m" (ui32));
+	ui32 = 0xFAFBABAF;
+	asm volatile ("vbroadcastss %0, %%ymm1" : : "m" (ui32));
+	ui32 -= 0xA;
+	asm volatile ("vbroadcastss %0, %%ymm2" : : "m" (ui32));
+	ui32 -= 0xB;
+	asm volatile ("vbroadcastss %0, %%ymm3" : : "m" (ui32));
+	ui32 -= 0x3;
+	asm volatile ("vbroadcastss %0, %%ymm4" : : "m" (ui32));
+	ui32 += 0xA;
+	asm volatile ("vbroadcastss %0, %%ymm5" : : "m" (ui32));
+	ui32 -= 0x7;
+	asm volatile ("vbroadcastss %0, %%ymm6" : : "m" (ui32));
+	ui32 -= 0xABABA;
+	asm volatile ("vbroadcastss %0, %%ymm7" : : "m" (ui32));
+
+	#ifndef __i386__
+	ui32 += 0xF7;
+	asm volatile ("vbroadcastss %0, %%ymm8" : : "m" (ui32));
+	ui32 -= 0x7;
+	asm volatile ("vbroadcastss %0, %%ymm9" : : "m" (ui32));
+	ui32 += 0x2;
+	asm volatile ("vbroadcastss %0, %%ymm10" : : "m" (ui32));
+	ui32 += 0xD;
+	asm volatile ("vbroadcastss %0, %%ymm11" : : "m" (ui32));
+	ui32 -= 0x4;
+	asm volatile ("vbroadcastss %0, %%ymm12" : : "m" (ui32));
+	ui32 -= 0xDD;
+	asm volatile ("vbroadcastss %0, %%ymm13" : : "m" (ui32));
+	ui32 -= 0xABD;
+	asm volatile ("vbroadcastss %0, %%ymm14" : : "m" (ui32));
+	ui32 += 0xBEBABF456;
+	asm volatile ("vbroadcastss %0, %%ymm15" : : "m" (ui32));
+	#endif
+}
diff --git a/tools/testing/selftests/xsave/xsave_instruction.c b/tools/testing/selftests/xsave/xsave_instruction.c
new file mode 100644
index 000000000000..2b610101511d
--- /dev/null
+++ b/tools/testing/selftests/xsave/xsave_instruction.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test kernel support for XSAVE-managed features.
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <x86intrin.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "xsave_common.h"
+
+static unsigned char *xsave_buf0, *xsave_buf1;
+
+static void set_ymm0_reg(uint32_t ui32)
+{
+	asm volatile ("vbroadcastss %0, %%ymm0" : : "m" (ui32));
+}
+
+static void dump_xsave_content(int xsave_size)
+{
+	XSAVE(xsave_buf0, SAVE_MASK);
+	dump_buffer(xsave_buf0, xsave_size);
+	ksft_print_msg("Entire contents of XSAVE is as above\n");
+}
+
+static void test_xsave_ymm_change(int xsave_size)
+{
+	const char *test_name = "xsave test after ymm change";
+	uint32_t ui32_set = 0x1234, ui32_change = 0x5678;
+	int result = RESULT_ERROR;
+
+	set_ymm0_reg(ui32_set);
+	XSAVE(xsave_buf0, SAVE_MASK);
+	set_ymm0_reg(ui32_change);
+	XSAVE(xsave_buf1, SAVE_MASK);
+	result = check_xsave_buf(xsave_buf0, xsave_buf1, xsave_size, test_name,
+				CHANGE);
+	check_result(result, test_name);
+}
+
+static void test_xsave_xrstor(int xsave_size)
+{
+	const char *test_name = "xsave after xrstor test";
+	int result = RESULT_ERROR;
+
+	XSAVE(xsave_buf0, SAVE_MASK);
+	XRSTOR(xsave_buf0, SAVE_MASK);
+	XSAVE(xsave_buf1, SAVE_MASK);
+	result = check_xsave_buf(xsave_buf0, xsave_buf1, xsave_size, test_name,
+				NO_CHANGE);
+	check_result(result, test_name);
+}
+
+int main(void)
+{
+	int xsave_size;
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	xsave_size = get_xsave_size();
+	/* SDM XSAVE: misalignment to a 64-byte boundary will result in #GP */
+	xsave_buf0 = aligned_alloc(64, xsave_size);
+	if (!xsave_buf0)
+		execution_failed("aligned_alloc xsave_buf0 failed\n");
+	xsave_buf1 = aligned_alloc(64, xsave_size);
+	if (!xsave_buf1)
+		execution_failed("aligned_alloc xsave_buf1 failed\n");
+
+	populate_fpu_regs();
+	/* Show the entire contents of xsave for issue debug */
+	dump_xsave_content(xsave_size);
+
+	test_xsave_ymm_change(xsave_size);
+	test_xsave_xrstor(xsave_size);
+
+	ksft_exit(!ksft_get_fail_cnt());
+}
-- 
2.20.1

