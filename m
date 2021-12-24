Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7433947ED6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 09:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbhLXIwc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Dec 2021 03:52:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:47099 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238133AbhLXIwa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Dec 2021 03:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640335950; x=1671871950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XJy8AT6waFR6UygYzvlGp48PuVKhGFf9IupCI7sBshw=;
  b=HARXFrOqYXXur3wpa4gnvGztNjhpqe1JRgfKpp7IOEoZSRH+4fGPGzDu
   Zp+Tvmyt4cvs2/Icw2KreknFAl3REVZqEFIeZHDrt007TBOSTi0GF02GJ
   O99r4FZDHcC3hfXIJaMelnI7dtNmVpe+VPDyYkzVW7VUpksM7T3MveU++
   VN9DgfX5fCxp7GIXiYsp0XKxO1dzCzWeoHkBedBeisKDLf8g6yAPJDVKO
   kYwbX4xFQAhUZM92dWTRkfrKJDECj45vSMkZ+duYFM6feIG0+uPpdt31A
   CgtQMvNHn7qG4VM2SlXTdTvmWLXGCiZRPQ5zslShnvF1RzcTLX2rmQw0N
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="227796970"
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="227796970"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 00:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="509107185"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga007.jf.intel.com with ESMTP; 24 Dec 2021 00:52:26 -0800
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
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: [RFC PATCH v7 1/2] selftests/x86: add xsave test related to nested signal handling
Date:   Fri, 24 Dec 2021 16:53:22 +0800
Message-Id: <cfdde208feb6c21298d86ac0d6cc91576d77b609.1640327326.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1640327326.git.pengfei.xu@intel.com>
References: <cover.1640327326.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to ensure that content of FPU, SSE(XMM), AVX2(YMM), AVX512 opmask and
PKRU xstates in the same process is not affected by signal handling, this case
tests that:
1. In nested signal processing, the signal handling uses each signal's
   own xstates, and the xstates of the signal handling under test should
   not be changed after previous nested signal handling is completed;
2. The xstates content of the process should not change after the entire
   nested signal handling.

Process will change above mentioned xstates before signal handling test to
ensure that these xstates have been tested.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
Reported-by: kernel test robot <lkp@intel.com> # compile issues during review
---
 tools/testing/selftests/x86/Makefile          |   3 +-
 tools/testing/selftests/x86/xsave_common.h    | 397 ++++++++++++++++++
 .../selftests/x86/xsave_signal_handle.c       | 189 +++++++++
 3 files changed, 588 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/xsave_common.h
 create mode 100644 tools/testing/selftests/x86/xsave_signal_handle.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 8a1f62ab3c8e..a9e452b65ba2 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx
+			corrupt_xstate_header amx xsave_signal_handle
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -105,3 +105,4 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
 # state.
 $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
+$(OUTPUT)/xsave_signal_handle_64: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
diff --git a/tools/testing/selftests/x86/xsave_common.h b/tools/testing/selftests/x86/xsave_common.h
new file mode 100644
index 000000000000..ea5843518633
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_common.h
@@ -0,0 +1,397 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <cpuid.h>
+#include <errno.h>
+
+#define RESULT_PASS 0
+#define RESULT_FAIL 1
+#define RESULT_ERROR 3
+#define CHANGE 10
+#define NO_CHANGE 11
+
+/* The following definition is from arch/x86/include/asm/fpu/xstate.h */
+#define XFEATURE_MASK_FP (1 << XFEATURE_FP)
+#define XFEATURE_MASK_SSE (1 << XFEATURE_SSE)
+#define XFEATURE_MASK_YMM (1 << XFEATURE_YMM)
+#define XFEATURE_MASK_OPMASK (1 << XFEATURE_OPMASK)
+#define XFEATURE_MASK_PKRU (1 << XFEATURE_PKRU)
+#define XSAVE_TEST_MASK (XFEATURE_MASK_FP | XFEATURE_MASK_SSE | \
+			XFEATURE_MASK_YMM | XFEATURE_MASK_OPMASK | XFEATURE_MASK_PKRU)
+
+/* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
+#define X86_FEATURE_AVX2		(1U << 5) /* AVX2 instructions */
+#define X86_FEATURE_AVX512F		(1U << 16) /* AVX-512 Foundation */
+
+/* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx) */
+#define X86_FEATURE_PKU        (1U << 3) /* Protection Keys for Userspace */
+#define X86_FEATURE_OSPKE      (1U << 4) /* OS Protection Keys Enable */
+
+#define XSTATE_CPUID           (0xd)
+
+/*
+ * It's from arch/x86/include/asm/fpu/types.h
+ * List of XSAVE features Linux knows about:
+ */
+enum xfeature {
+	XFEATURE_FP,
+	XFEATURE_SSE,
+	/*
+	 * Values above here are "legacy states".
+	 * Those below are "extended states".
+	 */
+	XFEATURE_YMM,
+	XFEATURE_BNDREGS,
+	XFEATURE_BNDCSR,
+	XFEATURE_OPMASK,
+	XFEATURE_ZMM_Hi256,
+	XFEATURE_Hi16_ZMM,
+	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
+	XFEATURE_PKRU,
+	XFEATURE_PASID,
+	XFEATURE_RSRVD_COMP_11,
+	XFEATURE_RSRVD_COMP_12,
+	XFEATURE_RSRVD_COMP_13,
+	XFEATURE_RSRVD_COMP_14,
+	XFEATURE_LBR,
+	XFEATURE_RSRVD_COMP_16,
+	XFEATURE_XTILE_CFG,
+	XFEATURE_XTILE_DATA,
+	XFEATURE_MAX,
+};
+
+static int err_num, case_num, pass_num;
+
+/*
+ * Could not use buildin xsave64 in libc without sse, added the function
+ * to save xstates in buf
+ */
+static void xsave(unsigned char *buf, unsigned long mask)
+{
+	uint32_t hmask = (uint32_t)(mask >> 32);
+	uint32_t lmask = (uint32_t)(mask & 0xffffffff);
+
+	asm volatile ("movl %0, %%edx" : : "r" (hmask));
+	asm volatile ("movl %0, %%eax" : : "r" (lmask));
+	asm volatile ("xsave64 %0" : : "m" (*buf));
+}
+
+/* Check whether cpu has avx2(Advanced Vector Extensions-2) */
+static inline int cpu_has_avx2(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	/* It is a macro-defining function and will not affect xstates */
+	__cpuid_count(7, 0, eax, ebx, ecx, edx);
+
+	return (ebx & X86_FEATURE_AVX2);
+}
+
+/* Check whether cpu has avx512f(Advanced Vector Extensions-512 Foundation) */
+static inline int cpu_has_avx512f(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__cpuid_count(7, 0, eax, ebx, ecx, edx);
+
+	return (ebx & X86_FEATURE_AVX512F);
+}
+
+/* Check whether cpu has PKRU(protection keys for user-mode pages) */
+static inline int cpu_has_pkeys(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__cpuid_count(7, 0, eax, ebx, ecx, edx);
+
+	if (!(ecx & X86_FEATURE_PKU))
+		return 0;
+
+	if (!(ecx & X86_FEATURE_OSPKE))
+		return 0;
+
+	return 1;
+}
+
+int execution_failed(char *reason, ...)
+{
+	printf("FAIL:errno=%d, %s, %s", errno, strerror(errno), reason);
+	err_num++;
+
+	return 1;
+}
+
+int get_xsave_size(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__cpuid_count(0xd, 0, eax, ebx, ecx, edx);
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
+	int a, b, result_buf = NO_CHANGE;
+
+	for (a = 0; a < size; a += 16) {
+		for (b = a; ((b < a + 16) && (b < size)); b++) {
+			if (buf0[b] != buf1[b]) {
+				show_part_buf(buf0, buf1, a, size);
+				result_buf = CHANGE;
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
+				printf("%s FAIL: buf0[%d]:%d or buf1[%d]:%d not 0\n",
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
+int compare_xsave_buf(unsigned char *buf0, unsigned char *buf1,
+	int size, const char *test_name, int change)
+{
+	int result_buf = RESULT_ERROR, result_resv_header = RESULT_ERROR;
+
+	switch (change) {
+	case CHANGE:
+		if (show_buf_diff(buf0, buf1, size) == CHANGE)
+			result_buf = RESULT_PASS;
+		else {
+			printf("%s FAIL: xsave content was same\n", test_name);
+			result_buf = RESULT_FAIL;
+		}
+		break;
+	case NO_CHANGE:
+		if (show_buf_diff(buf0, buf1, size) == CHANGE) {
+			printf("%s FAIL: xsave content changed\n", test_name);
+			show_buf_diff(buf0, buf1, size);
+			result_buf = RESULT_FAIL;
+		} else
+			result_buf = RESULT_PASS;
+		break;
+	default:
+		printf("%s ERROR: invalid change:%d\n", test_name,
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
+		printf("[PASS]:%s\n", test_name);
+		pass_num++;
+		break;
+	case RESULT_FAIL:
+		printf("[FAIL]:%s\n", test_name);
+		break;
+	case RESULT_ERROR:
+		printf("[ERROR]:%s\n", test_name);
+		err_num++;
+		break;
+	default:
+		printf("[ERROR]:%s:invalid result:%c\n",
+			test_name, result);
+		err_num++;
+		break;
+	}
+}
+
+/* Populate YMM with ui32_ymm */
+static void set_avx2_ymm(uint32_t ui32_ymm)
+{
+	if (cpu_has_avx2()) {
+		asm volatile ("vbroadcastss %0, %%ymm0" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm1" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm2" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm3" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm4" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm5" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm6" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm7" : : "m" (ui32_ymm));
+		#ifndef __i386__
+		asm volatile ("vbroadcastss %0, %%ymm8" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm9" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm10" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm11" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm12" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm13" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm14" : : "m" (ui32_ymm));
+		asm volatile ("vbroadcastss %0, %%ymm15" : : "m" (ui32_ymm));
+		#endif
+	}
+}
+
+static void set_pkru_xstate(uint32_t pkey_reg)
+{
+	unsigned int ecx = 0, edx = 0;
+
+	if (cpu_has_pkeys())
+		asm volatile(".byte 0x0f, 0x01, 0xef\n\t"
+		     : : "a" (pkey_reg), "c" (ecx), "d" (edx));
+}
+
+/* Populate avx512 opmask k0 to k7 with ffffffffffffffff */
+static void set_avx512_opmask(void)
+{
+	if (cpu_has_avx512f()) {
+		asm volatile("kxnorq %%k0, %%k0, %%k0;" : : : "rcx");
+		asm volatile("kxnorq %%k1, %%k1, %%k1;" : : : "rcx");
+		asm volatile("kxnorq %%k2, %%k2, %%k2;" : : : "rcx");
+		asm volatile("kxnorq %%k3, %%k3, %%k3;" : : : "rcx");
+		asm volatile("kxnorq %%k4, %%k4, %%k4;" : : : "rcx");
+		asm volatile("kxnorq %%k5, %%k5, %%k5;" : : : "rcx");
+		asm volatile("kxnorq %%k6, %%k6, %%k6;" : : : "rcx");
+		asm volatile("kxnorq %%k7, %%k7, %%k7;" : : : "rcx");
+	}
+}
+
+/* Initialize FPU and push different values onto FPU register stack */
+static void set_fpu_reg(void)
+{
+	uint32_t ui32;
+	uint64_t ui64;
+	float a = 0.12, b = 0.23;
+
+	/*
+	 * Populate like 1, 0xBAB00500FAB7 and so on value onto FP registers stack
+	 * and FP ST0/MM0 to ST7/MM7 xstates
+	 */
+	ui32 = 1;
+	ui64 = 0xBAB00500FAB7;
+
+	asm volatile("finit");
+	asm volatile("fldl %0" : : "m" (ui64));
+	asm volatile("flds %0" : : "m" (ui32));
+	ui64 += 0x93ABE13;
+	asm volatile("fldl %0" : : "m" (ui64));
+	ui64 += 0x93;
+	asm volatile("fldl %0" : : "m" (ui64));
+	asm volatile("flds %0" : : "m" (ui32));
+	asm volatile("fldl %0" : : "m" (ui64));
+	ui64 -= 0x21;
+	asm volatile("fldl %0" : : "m" (ui64));
+	asm volatile("flds %0" : : "m" (ui32));
+	asm volatile("fldl %0" : : "m" (ui64));
+	a = a * b;
+}
+
+/* Change xstates to make xstates different from populate_xstate_regs() */
+void change_xstate(uint32_t ui32)
+{
+	/* Change pkru xstate with 0x00000000ffffff00 */
+	uint32_t pkey_change = 0xffffff00, ecx = 0, edx = 0;
+
+	/* Push value onto FP stack */
+	asm volatile("flds %0" : : "m" (ui32));
+
+	/* change ymm0 to ymm15 with ui32 in 64bit kernel */
+	if (cpu_has_avx2())
+		set_avx2_ymm(ui32);
+
+	/* change avx512 opmask k0 to k7 with ff */
+	if (cpu_has_avx512f()) {
+		asm volatile("kxnorb %%k0, %%k0, %%k0;" : : : "rcx");
+		asm volatile("kxnorb %%k1, %%k1, %%k1;" : : : "rcx");
+		asm volatile("kxnorb %%k2, %%k2, %%k2;" : : : "rcx");
+		asm volatile("kxnorb %%k3, %%k3, %%k3;" : : : "rcx");
+		asm volatile("kxnorb %%k4, %%k4, %%k4;" : : : "rcx");
+		asm volatile("kxnorb %%k5, %%k5, %%k5;" : : : "rcx");
+		asm volatile("kxnorb %%k6, %%k6, %%k6;" : : : "rcx");
+		asm volatile("kxnorb %%k7, %%k7, %%k7;" : : : "rcx");
+	}
+
+	/*  Change PKRU xstate */
+	if (cpu_has_pkeys())
+		asm volatile(".byte 0x0f,0x01,0xef\n\t"
+		     : : "a" (pkey_change), "c" (ecx), "d" (edx));
+}
+
+void check_cpu_capability(void)
+{
+	if (!cpu_has_avx2())
+		printf("[SKIP] No avx2 capability, skip avx2 part xstate.\n");
+
+	if (!cpu_has_avx512f())
+		printf("[SKIP] No avx512f capability, skip avx512f part xstate.\n");
+
+	if (!cpu_has_pkeys())
+		printf("[SKIP] No pkeys capability, skip pkru part xstate.\n");
+}
+
+/* Populate FP,XMM(SSE),YMM(AVX2),AVX512_opmask and PKRU xstates with values */
+void populate_xstate_regs(void)
+{
+	uint32_t ui32_ymm_value = 0x1f2f3f4f, pkey = 0xfffffffc;
+
+	/* Populate FPU register stack and ST0/MM0 to ST7/MM7 xstate with value */
+	set_fpu_reg();
+	/* Populate ymm0-15 with 0x1f2f3f4f */
+	set_avx2_ymm(ui32_ymm_value);
+	/* Populate avx512 opmask k0 to k7 with ffffffffffffffff */
+	set_avx512_opmask();
+	/* Populate PKRU xstate with 0x00000000fffffffc */
+	set_pkru_xstate(pkey);
+}
diff --git a/tools/testing/selftests/x86/xsave_signal_handle.c b/tools/testing/selftests/x86/xsave_signal_handle.c
new file mode 100644
index 000000000000..65b9bdef3a49
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_signal_handle.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * xsave_signal_handle.c - tests XSAVE with signal handling.
+ *
+ * XSAVE feature will save/restore xstate, each process and signal handling on
+ * x86 CPUs has it's own xstates, and the xstates of user process and signal
+ * handling are managed by kernel.
+ * When user process raises a signal, kernel saves xstates of the process
+ * by kernel with xsave/xsaves instruction, and after signal handling, the
+ * xstate of process will be restored by kernel with xrstor/xrstors instruction.
+ * So the xstate of the process should not change after signal handling.
+ * It tests that:
+ * 1. In nested signal processing, the signal handling will use each signal's
+ *    own xstates, and the xstates of the signal handling under test should
+ *    not be changed after previous nested signal handling is completed;
+ * 2. The xstates content of the process should not change after the entire
+ *    nested signal handling.
+ *
+ * Updates:
+ * - Because it tests FP SSE xstate, in order to prevent GCC from generating any
+ *   FP code by mistake, "-mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku"
+ *   compiler parameter was added, it's referred to the parameters for compiling
+ *   the x86 kernel.
+ * - Remove the use of "kselftest.h", because kselftest.h includes <stdlib.h>,
+ *   and "stdlib.h" uses sse instructions in it's libc, and this *XSAVE*
+ *   test needs to be compiled without libc sse instructions(-mno-sse).
+ * - Test code could not use buildin xsave64 in libc without sse, added
+ *   xsave function by instruction way.
+ * - Every key test action does not use libc(like printf) except syscall until
+ *   it's failed or done. If it's failed, then it will print the failed reason.
+ * - Use __cpuid_count() instead of native_cpuid(), becasue __cpuid_count()
+ *   was a macro definition function with one instruction in libc and did not
+ *   change xstate.
+ * - It tests FP, SSE(XMM), YMM, AVX512_opmask, PKRU xstates through signal
+ *   handling action.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+
+#include "xsave_common.h"
+
+void *aligned_alloc(size_t alignment, size_t size);
+static unsigned char *xsave_buf0, *xsave_buf1, *xsave_buf2, *xsave_buf3;
+static int result[2], xsave_size;
+
+static void usr1_handler(int signum, siginfo_t *info, void *__ctxp)
+{
+	uint32_t ui32;
+	const char *usr1_name = "USR1 signal xstates should same after USR2 signal";
+
+	/* Xstate change in signal handling USR1 will not affect process xstates */
+	ui32 = 0x1f2fffff;
+	if (signum == SIGUSR1) {
+		printf("SIGUSR1:0x%x changed fld & ymm0-15:0x%x\n",
+			SIGUSR1, ui32);
+		change_xstate(ui32);
+	}
+	/*
+	 * SIGUSR1 handler has independent xstates, which is not affected by
+	 * the SIGUSR2 handler
+	 */
+	xsave(xsave_buf2, XSAVE_TEST_MASK);
+	kill(getpid(), SIGUSR2);
+	xsave(xsave_buf3, XSAVE_TEST_MASK);
+	result[0] = compare_xsave_buf(xsave_buf2, xsave_buf3, xsave_size, usr1_name,
+		NO_CHANGE);
+}
+
+static void usr2_handler(int signum, siginfo_t *info, void *__ctxp)
+{
+	uint32_t ui32;
+
+	ui32 = 0x3f4fffff;
+	/*
+	 * SIGUSR2 handler has independent xstates, it only changes SIGUSR2 handler
+	 * xstate, and it should not affect SIGUSR1 handler xstate
+	 */
+	if (signum == SIGUSR2) {
+		printf("SIGUSR2:0x%x changed fld & ymm0-15:0x%x\n",
+			SIGUSR2, ui32);
+		change_xstate(ui32);
+	}
+}
+
+static void set_signal_handle(void)
+{
+	struct sigaction sigact;
+
+	memset(&sigact, 0, sizeof(sigact));
+	if (sigemptyset(&sigact.sa_mask))
+		execution_failed("sigemptyset error\n");
+
+	sigact.sa_flags = SA_SIGINFO;
+
+	sigact.sa_sigaction = usr1_handler;
+	if (sigaction(SIGUSR1, &sigact, NULL))
+		execution_failed("SIGUSR1 handling failed\n");
+
+	sigact.sa_sigaction = usr2_handler;
+	if (sigaction(SIGUSR2, &sigact, NULL))
+		execution_failed("SIGUSR2 handling failed\n");
+}
+
+void prepare_environment(void)
+{
+	set_signal_handle();
+	xsave_size = get_xsave_size();
+	printf("XSAVE_TEST_MASK:0x%x, xstate size:0x%x\n",
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
+	xsave_buf3 = aligned_alloc(64, xsave_size);
+	if (!xsave_buf3)
+		execution_failed("aligned_alloc xsave_buf3 failed\n");
+}
+
+static int test_xsave_sig_handle(void)
+{
+	const char *test_name0 = "Signal xstate was same after previous signal handling";
+	const char *test_name1 = "Child xstate was same after signal handling";
+	pid_t child;
+	int status;
+
+	/* Use child process testing to avoid abnormal blocking the next test */
+	child = syscall(SYS_fork);
+	if (child < 0)
+		execution_failed("Create child pid failed\n");
+	else if	(child == 0) {
+		populate_xstate_regs();
+		xsave(xsave_buf0, XSAVE_TEST_MASK);
+		/* Dump buffer to show the tested xstates */
+		dump_buffer(xsave_buf0, xsave_size);
+		/*
+		 * If the above case fails, print reason for failure, and then xstate
+		 * like xmm, ymm would be cleared by vzeroupper in printf(-mnosse), so
+		 * populate xstates for next test case, otherwise, xmm and ymm xstate
+		 * is all 0, there is no guarantee that xmm, ymm will be restored as
+		 * expected.
+		 */
+		populate_xstate_regs();
+		xsave(xsave_buf0, XSAVE_TEST_MASK);
+		kill(getpid(), SIGUSR1);
+		xsave(xsave_buf1, XSAVE_TEST_MASK);
+		result[1] = compare_xsave_buf(xsave_buf0, xsave_buf1, xsave_size,
+			test_name1, NO_CHANGE);
+		check_result(result[0], test_name0);
+		check_result(result[1], test_name1);
+		printf("Xstate in signal hanlding test pass[%d/%d], err_num:%d\n",
+			pass_num, case_num, err_num);
+
+		return 0;
+	}
+
+	if (child) {
+		if (waitpid(child, &status, 0) != child || !WIFEXITED(status))
+			execution_failed("Child quit unexpectedly\n");
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	case_num = 2;
+
+	prepare_environment();
+	test_xsave_sig_handle();
+
+	return 0;
+}
-- 
2.31.1

