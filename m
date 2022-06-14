Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C97D54B443
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 17:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356244AbiFNPL4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 11:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356176AbiFNPLx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 11:11:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF3E2FE57;
        Tue, 14 Jun 2022 08:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655219511; x=1686755511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YSFZ/vRYS+aaQoNL44TN9VXIeEYFfM5H3kXYlq/cZGM=;
  b=hDyYJ4mPaCMt7TZgQFOms0hnsxuwwy/9sNE2SC77r1hBKwR7/74Gu/JC
   wQrkyTuYU2ggvofMPXII+5UxeH03F62NjiTStUv+SfwInjJiWmfuHtO4x
   YOGSNRyQ9N34Zkjh1lXs/HoXCB6eIFAsENw6aGVFov9KnfdzxwSQIj6G+
   rMnDGi+eM0DTh7ZBDp9IvtBe92TCSIsEXRMbEt+HQPP2GBg59JTJX7g38
   ODpbllZn34D9J/xx5ykw8vCyALN7FWfV3qCqKq670SmGgVX47xt7PhGR7
   yTuBF0RWf/7EmWe5UPza6TSryOqoeB5WfSxa1E1Ps7kUv2DuyNjCzu2xG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261673586"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="261673586"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="673941758"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 08:11:47 -0700
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
        Bae Chang Seok <chang.seok.bae@intel.com>
Subject: [PATCH v9 1/2] selftests/x86/xstate: Add xstate signal handling test for XSAVE feature
Date:   Tue, 14 Jun 2022 23:11:05 +0800
Message-Id: <f750fb183cf13e83cb2a10befacd3707879851ec.1655218544.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1655218544.git.pengfei.xu@intel.com>
References: <cover.1655218544.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The XSAVE feature set supports the saving and restoring of xstate components.

In order to ensure that XSAVE works correctly, add XSAVE most basic signal
handling test for XSAVE architecture functionality, this patch tests "FP,
SSE(XMM), AVX2(YMM), AVX512_OPMASK/AVX512_ZMM_Hi256/AVX512_Hi16_ZMM and PKRU"
xstates with the following:
The contents of these xstates in the process should not change after the
signal handling.

  [ Dave Hansen; Chang S. Bae: bunches of cleanups ]

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 tools/testing/selftests/x86/.gitignore       |   1 +
 tools/testing/selftests/x86/Makefile         |  11 +-
 tools/testing/selftests/x86/xstate.c         | 215 +++++++++++++++
 tools/testing/selftests/x86/xstate.h         | 266 +++++++++++++++++++
 tools/testing/selftests/x86/xstate_helpers.c | 160 +++++++++++
 tools/testing/selftests/x86/xstate_helpers.h |   8 +
 6 files changed, 659 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/x86/xstate.c
 create mode 100644 tools/testing/selftests/x86/xstate.h
 create mode 100644 tools/testing/selftests/x86/xstate_helpers.c
 create mode 100644 tools/testing/selftests/x86/xstate_helpers.h

diff --git a/tools/testing/selftests/x86/.gitignore b/tools/testing/selftests/x86/.gitignore
index 1aaef5bf119a..68951ceefe30 100644
--- a/tools/testing/selftests/x86/.gitignore
+++ b/tools/testing/selftests/x86/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 *_32
 *_64
+*.o
 single_step_syscall
 sysret_ss_attrs
 syscall_nt
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0388c4d60af0..49a6d78e0831 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx
+			corrupt_xstate_header amx xstate
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -69,7 +69,7 @@ all_32: $(BINARIES_32)
 
 all_64: $(BINARIES_64)
 
-EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
+EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64) *.o
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
@@ -109,3 +109,10 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
 # state.
 $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
+
+# xstate_64 is special: it needs xstate_helpers.o to prevent GCC from
+# generating any FP code by mistake and stdlib.h can't be used due to
+# "-mno-sse" parameter, so compile xstate_64 with the code file xstate.c
+# which can use stdlib.h and xstate_helpers.o which cannot use stdlib.h
+xstate_helpers.o: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
+$(OUTPUT)/xstate_64: xstate_helpers.o
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
new file mode 100644
index 000000000000..05dabb4733a0
--- /dev/null
+++ b/tools/testing/selftests/x86/xstate.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * xstate.c - tests XSAVE feature with fork and signal handling.
+ *
+ * The XSAVE feature set supports the saving and restoring of state components.
+ * It tests "FP, SSE(XMM), AVX2(YMM), AVX512_OPMASK/AVX512_ZMM_Hi256/
+ * AVX512_Hi16_ZMM and PKRU parts" xstates with following cases:
+ * 1. The contents of these xstates in the process should not change after the
+ *    signal handling.
+ * 2. The contents of these xstates in the child process should be the same as
+ *    the contents of the xstate in the parent process after the fork syscall.
+ * 3. The contents of xstates in the parent process should not change after
+ *    the context switch.
+ *
+ * The regions and reserved bytes of the components tested for XSAVE feature
+ * are as follows:
+ * x87(FP)/SSE    (0 - 159 bytes)
+ * SSE(XMM part)  (160-415 bytes)
+ * Reserved       (416-511 bytes)
+ * Header_used    (512-527 bytes; XSTATE BV(bitmap vector) mask:512-519 bytes)
+ * Header_reserved(528-575 bytes must be 00)
+ * YMM            (Offset:CPUID.(EAX=0D,ECX=2).EBX Size:CPUID(EAX=0D,ECX=2).EAX)
+ * AVX512_OPMASK  (Offset:CPUID.(EAX=0D,ECX=5).EBX Size:CPUID(EAX=0D,ECX=5).EAX)
+ * ZMM_Hi256      (Offset:CPUID.(EAX=0D,ECX=6).EBX Size:CPUID(EAX=0D,ECX=6).EAX)
+ * Hi16_ZMM       (Offset:CPUID.(EAX=0D,ECX=7).EBX Size:CPUID(EAX=0D,ECX=7).EAX)
+ * PKRU           (Offset:CPUID.(EAX=0D,ECX=9).EBX Size:CPUID(EAX=0D,ECX=9).EAX)
+ */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <cpuid.h>
+#include <malloc.h>
+#include <stdlib.h>
+
+#include "xstate.h"
+#include "xstate_helpers.h"
+#include "../kselftest.h"
+
+#define NUM_TESTS 1
+#define xstate_test_array_init(idx, init_opt, fill_opt)	\
+	do {						\
+		xstate_tests[idx].init = init_opt;	\
+		xstate_tests[idx].fill_xbuf = fill_opt;	\
+	} while (0)
+
+static struct xsave_buffer *valid_xbuf, *compared_xbuf;
+static struct xstate_test xstate_tests[XFEATURE_MAX];
+static uint32_t xstate_size;
+
+static bool xstate_in_test(int xfeature_num)
+{
+	return !!(xstate_info.mask & (1 << xfeature_num));
+}
+
+static struct xsave_buffer *alloc_xbuf(uint32_t buf_size)
+{
+	struct xsave_buffer *xbuf;
+
+	/* XSAVE buffer should be 64B-aligned. */
+	xbuf = aligned_alloc(64, buf_size);
+	if (!xbuf)
+		ksft_exit_fail_msg("aligned_alloc() failed.\n");
+
+	return xbuf;
+}
+
+static void free_xbuf(void)
+{
+	free(valid_xbuf);
+	free(compared_xbuf);
+}
+
+static void allocate_xbuf(void)
+{
+	valid_xbuf = alloc_xbuf(xstate_size);
+	compared_xbuf = alloc_xbuf(xstate_size);
+}
+
+static void show_test_xfeatures(void)
+{
+	uint32_t i;
+	const char *feature_name;
+
+	ksft_print_msg("[NOTE] Test following xstates with mask:%lx.\n",
+		       xstate_info.mask);
+	for (i = 0; i < XFEATURE_MAX; i++) {
+		if (!xstate_in_test(i))
+			continue;
+		feature_name = xfeature_names[i];
+		ksft_print_msg("[NOTE] XSAVE feature num %02d: '%s'.\n", i,
+			       feature_name);
+	}
+}
+
+static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
+{
+	/* XSTATE_BV is at the beginning of xstate header. */
+	*(uint64_t *)(&buffer->header) = bv;
+}
+
+static void compare_buf_result(struct xsave_buffer *valid_buf,
+			       struct xsave_buffer *compare_buf,
+			       const char *case_name)
+{
+	if (memcmp(&valid_buf->bytes[0], &compare_buf->bytes[0], xstate_size))
+		ksft_test_result_fail("The case: %s.\n", case_name);
+	else
+		ksft_test_result_pass("The case: %s.\n", case_name);
+}
+
+static void test_xstate_sig_handle(void)
+{
+	const char *case_name1 = "xstate around process signal handling";
+
+	ksft_print_msg("[RUN] Check xstate around signal handling test.\n");
+
+	if (xstate_sig_handle(valid_xbuf, compared_xbuf, xstate_info.mask,
+	    xstate_size)) {
+		ksft_print_msg("[NOTE] SIGUSR1 handling is done.\n");
+	} else {
+		ksft_test_result_error("%s: Didn't access SIGUSR1 handling.\n",
+				       case_name1);
+		return;
+	}
+
+	compare_buf_result(valid_xbuf, compared_xbuf, case_name1);
+}
+
+static void prepare_xstate_test(void)
+{
+	xstate_test_array_init(XFEATURE_FP, init_legacy_info,
+			       fill_fp_mxcsr_xstate_buf);
+	xstate_test_array_init(XFEATURE_SSE, init_legacy_info,
+			       fill_xmm_xstate_buf);
+	xstate_test_array_init(XFEATURE_YMM, init_ymm_info,
+			       fill_common_xstate_buf);
+	xstate_test_array_init(XFEATURE_OPMASK, init_avx512_info,
+			       fill_common_xstate_buf);
+	xstate_test_array_init(XFEATURE_ZMM_Hi256, init_avx512_info,
+			       fill_common_xstate_buf);
+	xstate_test_array_init(XFEATURE_Hi16_ZMM, init_avx512_info,
+			       fill_common_xstate_buf);
+	xstate_test_array_init(XFEATURE_PKRU, init_pkru_info,
+			       fill_pkru_xstate_buf);
+
+	xstate_tests[XSTATE_CASE_SIG].xstate_case = test_xstate_sig_handle;
+}
+
+static void test_xstate(void)
+{
+	int xfeature_num, case_num;
+
+	xstate_size = get_xstate_size();
+	allocate_xbuf();
+
+	for (xfeature_num = XFEATURE_FP; xfeature_num < XFEATURE_MAX;
+	     xfeature_num++) {
+		if (xstate_tests[xfeature_num].init) {
+			/* Retrieve xstate mask, offset and size information. */
+			if (!xstate_tests[xfeature_num].init(xfeature_num))
+				continue;
+		} else {
+			continue;
+		}
+
+		/* Fill xstate buffer. */
+		if (xfeature_num != XFEATURE_PKRU) {
+			xstate_tests[xfeature_num].fill_xbuf(valid_xbuf,
+				xfeature_num, XSTATE_TESTBYTE);
+		} else {
+			/*
+			 * Bits 0-1 in first byte of PKRU must be 0 for
+			 * RW access to linear address.
+			 */
+			xstate_tests[xfeature_num].fill_xbuf(valid_xbuf,
+				xfeature_num, PKRU_TESTBYTE);
+		}
+	}
+
+	/*
+	 * Fill xstate-component bitmap(512-519 bytes) into xstate header.
+	 * xstate header range is 512-575 bytes.
+	 */
+	set_xstatebv(valid_xbuf, xstate_info.mask);
+
+	show_test_xfeatures();
+
+	/* Test xstate. */
+	for (case_num = XSTATE_CASE_SIG; case_num < XSTATE_CASE_MAX; case_num++)
+		xstate_tests[case_num].xstate_case();
+
+	free_xbuf();
+}
+
+int main(void)
+{
+	ksft_print_header();
+	ksft_set_plan(NUM_TESTS);
+
+	/* Check hardware availability for xsave at first. */
+	check_cpuid_xsave_availability();
+	prepare_xstate_test();
+	test_xstate();
+
+	ksft_exit(ksft_cnt.ksft_pass == ksft_plan);
+}
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
new file mode 100644
index 000000000000..a60429591c49
--- /dev/null
+++ b/tools/testing/selftests/x86/xstate.h
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "../kselftest.h"
+
+#define XSTATE_TESTBYTE		0x8f
+/* Bits 0-1 in first byte of PKRU must be 0 for RW access to linear address. */
+#define PKRU_TESTBYTE		0xfc
+/* FP xstate(0-159 bytes) offset(0) and size(160 bytes) are fixed. */
+#define FP_SIZE			160
+/* XMM xstate(160-415 bytes) offset(160 byte) and size(256 bytes) are fixed. */
+#define XMM_OFFSET		160
+#define XMM_SIZE		256
+/*
+ * xstate 416-511 bytes are reserved, XSAVE header offset 512 bytes
+ * and header size 64 bytes are fixed.
+ */
+#define XSAVE_HDR_OFFSET	512
+#define XSAVE_HDR_SIZE		64
+
+#define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)  /* XSAVE instructions */
+#define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27) /* OSXSAVE flag */
+
+#define CPUID_LEAF7_EBX_AVX2_MASK	(1U << 5) /* AVX2 instructions */
+#define CPUID_LEAF7_EBX_AVX512F_MASK	(1U << 16) /* AVX-512 Foundation */
+
+#define CPUID_LEAF7_ECX_OSPKE_MASK	(1U << 4) /* OS Protection Keys Enable */
+
+#define CPUID_LEAF_XSTATE		0xd
+#define CPUID_SUBLEAF_XSTATE_USER	0x0
+
+/* It's from arch/x86/kernel/fpu/xstate.c. */
+static const char * const xfeature_names[] = {
+	"x87 floating point registers",
+	"SSE registers",
+	"AVX registers",
+	"MPX bounds registers",
+	"MPX CSR",
+	"AVX-512 opmask",
+	"AVX-512 Hi256",
+	"AVX-512 ZMM_Hi256",
+	"Processor Trace (unused)",
+	"Protection Keys User registers",
+	"PASID state",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"AMX Tile config",
+	"AMX Tile data",
+	"unknown xstate feature",
+};
+
+/* List of XSAVE features Linux knows about. */
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
+enum supportability {
+	NOT_SUPPORT,
+	SUPPORT,
+};
+
+enum xstate_case {
+	XSTATE_CASE_SIG,
+	XSTATE_CASE_MAX,
+};
+
+struct xsave_buffer {
+	union {
+		struct {
+			char legacy[XSAVE_HDR_OFFSET];
+			char header[XSAVE_HDR_SIZE];
+			char extended[0];
+		};
+		char bytes[0];
+	};
+};
+
+struct {
+	uint64_t mask;
+	uint32_t size[XFEATURE_MAX];
+	uint32_t offset[XFEATURE_MAX];
+} xstate_info;
+
+struct xstate_test {
+	bool (*init)(int xfeature_num);
+	void (*fill_xbuf)(void *buf, int xfeature_num, uint8_t test_byte);
+	void (*xstate_case)(void);
+};
+
+static void check_cpuid_xsave_availability(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	/*
+	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
+	 * support for the XSAVE feature set, including
+	 * XGETBV.
+	 */
+	__cpuid_count(1, 0, eax, ebx, ecx, edx);
+	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
+		ksft_exit_skip("cpuid: CPU doesn't support xsave.\n");
+
+	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
+		ksft_exit_skip("cpuid: CPU doesn't support OS xsave.\n");
+}
+
+static uint32_t get_xstate_size(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER, eax, ebx,
+		      ecx, edx);
+	/*
+	 * EBX enumerates the size (in bytes) required by the XSAVE
+	 * instruction for an XSAVE area containing all the user state
+	 * components corresponding to bits currently set in XCR0.
+	 */
+	return ebx;
+}
+
+static inline bool cpu_has_avx2(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	/* CPUID.7.0:EBX.AVX2[bit 5]: the support for AVX2 instructions. */
+	__cpuid_count(7, 0, eax, ebx, ecx, edx);
+
+	return !!(ebx & CPUID_LEAF7_EBX_AVX2_MASK);
+}
+
+static inline bool cpu_has_avx512f(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	/* CPUID.7.0:EBX.AVX512F[bit 16]: support for AVX512F instructions. */
+	__cpuid_count(7, 0, eax, ebx, ecx, edx);
+
+	return !!(ebx & CPUID_LEAF7_EBX_AVX512F_MASK);
+}
+
+static inline bool cpu_has_pkru(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	/* CPUID.7.0:ECX.OSPKE[bit 4]: the support for OS set CR4.PKE. */
+	__cpuid_count(7, 0, eax, ebx, ecx, edx);
+	if (!(ecx & CPUID_LEAF7_ECX_OSPKE_MASK))
+		return NOT_SUPPORT;
+
+	return SUPPORT;
+}
+
+/* Retrieve the mask, offset and size of a specific xstate. */
+static void retrieve_xstate_mask_size_offset(uint32_t xfeature_num)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	xstate_info.mask |= 1 << xfeature_num;
+	/*
+	 * The offset and size of xstate FP and SSE are not recorded by CPUID,
+	 * the contents of FP (x87 state) and MXCSR register are mixed in
+	 * bytes 0-511.
+	 */
+	if (xfeature_num == XFEATURE_FP || xfeature_num == XFEATURE_SSE)
+		return;
+
+	__cpuid_count(CPUID_LEAF_XSTATE, xfeature_num, eax, ebx, ecx, edx);
+	/*
+	 * CPUID.(EAX=0xd, ECX=xfeature_num), and output is as follow:
+	 * eax: xfeature num state component size
+	 * ebx: xfeature num state component offset in user buffer
+	 */
+	if (!eax || !ebx)
+		ksft_exit_fail_msg("xfeature id:%d size/offset:%d/%d is 0.\n",
+				   xfeature_num, eax, ebx);
+
+	xstate_info.size[xfeature_num] = eax;
+	xstate_info.offset[xfeature_num] = ebx;
+}
+
+/* Retrieve legacy FP and SSE xstate info. */
+static bool init_legacy_info(int xfeature_num)
+{
+	retrieve_xstate_mask_size_offset(xfeature_num);
+	return true;
+}
+
+static bool init_ymm_info(int xfeature_num)
+{
+	if (cpu_has_avx2()) {
+		retrieve_xstate_mask_size_offset(xfeature_num);
+		return true;
+	}
+	return false;
+}
+
+static bool init_avx512_info(int xfeature_num)
+{
+	if (cpu_has_avx512f()) {
+		retrieve_xstate_mask_size_offset(xfeature_num);
+		return true;
+	}
+	return false;
+}
+
+static bool init_pkru_info(int xfeature_num)
+{
+	if (cpu_has_pkru()) {
+		retrieve_xstate_mask_size_offset(xfeature_num);
+		return true;
+	}
+	return false;
+}
+
+static void fill_xmm_xstate_buf(void *buf, int xfeature_num, uint8_t test_byte)
+{
+	/*
+	 * Fill test byte value into SSE XMM part xstate buffer(160-415 bytes).
+	 * xstate 416-511 bytes are reserved as all 0.
+	 */
+	memset((unsigned char *)buf + XMM_OFFSET, test_byte, XMM_SIZE);
+}
+
+static void fill_common_xstate_buf(void *buf, int xfeature_num,
+				   uint8_t test_byte)
+{
+	memset((unsigned char *)buf + xstate_info.offset[xfeature_num],
+	       test_byte, xstate_info.size[xfeature_num]);
+}
+
+static void fill_pkru_xstate_buf(void *buf, int xfeature_num,
+				 uint8_t test_byte)
+{
+	/*
+	 * Only 0-3 bytes of PKRU xstate are allowed to be written. 4-7
+	 * bytes are reserved as all 0.
+	 */
+	memset((unsigned char *)buf + xstate_info.offset[XFEATURE_PKRU],
+	       test_byte, sizeof(uint32_t));
+}
diff --git a/tools/testing/selftests/x86/xstate_helpers.c b/tools/testing/selftests/x86/xstate_helpers.c
new file mode 100644
index 000000000000..0f88f56f839e
--- /dev/null
+++ b/tools/testing/selftests/x86/xstate_helpers.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * xstate_helpers.c - xstate helpers to prevent GCC from generating any FP code.
+ *
+ * Because xstate like XMM will not be preserved across function calls, it uses
+ * assembly instruction to call a system call of fork or raise signal, and uses
+ * the "inline" keyword in key test functions.
+ * To prevent GCC from generating any FP/SSE(XMM)/AVX/PKRU code, add
+ * "-mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku" compiler arguments. stdlib.h
+ * can not be used in this test file due to GCC bug.
+ * The test functions that prepare the xstate buffers are placed in a separate
+ * xstate.c because they do not require the above requirements.
+ */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <cpuid.h>
+#include <malloc.h>
+
+#include "xstate_helpers.h"
+
+/* err() exits and will not return. */
+#define fatal_error(msg, ...)	err(1, "[FAIL]\t" msg, ##__VA_ARGS__)
+/* FP and SSE are legacy xstates with fixed masks in regions 0-511 bytes. */
+#define MASK_FP_SSE	3
+
+static bool sigusr1_done;
+
+static inline void __xsave(void *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_lo = rfbm;
+	uint32_t rfbm_hi = rfbm >> 32;
+
+	asm volatile("xsave (%%rdi)"
+		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi)
+		     : "memory");
+}
+
+static inline void __xrstor(void *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_lo = rfbm;
+	uint32_t rfbm_hi = rfbm >> 32;
+
+	asm volatile("xrstor (%%rdi)"
+		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi));
+}
+
+inline void fill_fp_mxcsr_xstate_buf(void *buf, int xfeature_num,
+				     uint8_t ui8_fp)
+{
+	/*
+	 * Sets the FPU control, status, tag, instruction pointer, and
+	 * data pointer registers to their default states.
+	 */
+	asm volatile("finit");
+	/* Populate tested bytes onto FP registers stack ST0-7. */
+	asm volatile("fldl %0" : : "m" (ui8_fp));
+	asm volatile("fldl %0" : : "m" (ui8_fp));
+	asm volatile("fldl %0" : : "m" (ui8_fp));
+	asm volatile("fldl %0" : : "m" (ui8_fp));
+	asm volatile("fldl %0" : : "m" (ui8_fp));
+	asm volatile("fldl %0" : : "m" (ui8_fp));
+	asm volatile("fldl %0" : : "m" (ui8_fp));
+	asm volatile("fldl %0" : : "m" (ui8_fp));
+	/* Xsave the x87 FPU and SSE MXCSR(bytes 24-27) xstate into the buf. */
+	__xsave(buf, MASK_FP_SSE);
+}
+
+/*
+ * Because xstate like XMM, YMM registers are not preserved across function
+ * calls, so use inline function with assembly code only for fork syscall.
+ */
+static inline long __fork(void)
+{
+	long ret, nr = SYS_fork;
+
+	asm volatile("syscall"
+		 : "=a" (ret)
+		 : "a" (nr), "b" (nr)
+		 : "rcx", "r11", "memory", "cc");
+
+	return ret;
+}
+
+/*
+ * Because xstate like XMM, YMM registers are not preserved across function
+ * calls, so use inline function with assembly code only to raise signal.
+ */
+static inline long __raise(long pid_num, long sig_num)
+{
+	long ret, nr = SYS_kill;
+
+	asm volatile("movq %0, %%rdi" : : "r"(pid_num) : "%rdi");
+	asm volatile("movq %0, %%rsi" : : "r"(sig_num) : "%rsi");
+	asm volatile("syscall"
+		 : "=a" (ret)
+		 : "a" (nr), "b" (nr)
+		 : "rcx", "r11", "memory", "cc");
+
+	return ret;
+}
+
+static void sigusr1_handler(int signum, siginfo_t *info, void *__ctxp)
+{
+	sigusr1_done = true;
+}
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		fatal_error("sigaction");
+}
+
+static void clearhandler(int sig)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		fatal_error("sigaction");
+}
+
+bool xstate_sig_handle(void *valid_xbuf, void *compared_xbuf, uint64_t mask,
+		       uint32_t xstate_size)
+{
+	pid_t process_pid;
+
+	sigusr1_done = false;
+	memset(compared_xbuf, 0, xstate_size);
+	sethandler(SIGUSR1, sigusr1_handler, 0);
+	process_pid = getpid();
+	/*
+	 * Xrstor the valid buf and call syscall assembly instruction, then
+	 * save the xstate to compared buf after signal handling for comparison.
+	 */
+	__xrstor(valid_xbuf, mask);
+	__raise(process_pid, SIGUSR1);
+	__xsave(compared_xbuf, mask);
+	clearhandler(SIGUSR1);
+
+	return sigusr1_done;
+}
diff --git a/tools/testing/selftests/x86/xstate_helpers.h b/tools/testing/selftests/x86/xstate_helpers.h
new file mode 100644
index 000000000000..1806c0bf484b
--- /dev/null
+++ b/tools/testing/selftests/x86/xstate_helpers.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <stdint.h>
+
+extern void fill_fp_mxcsr_xstate_buf(void *buf, int xfeature_num,
+				     uint8_t ui8_fp);
+extern bool xstate_sig_handle(void *valid_xbuf, void *compared_xbuf,
+			      uint64_t mask, uint32_t xstate_size);
-- 
2.31.1

