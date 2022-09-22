Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF97F5E6CC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 22:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiIVUKl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiIVUKk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 16:10:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FECEC559;
        Thu, 22 Sep 2022 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877439; x=1695413439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=x0W/PWlKVH4Kg6RVdCR6J9PqSt//9vhZDuFOnyIkMK4=;
  b=MGYNCtWcwpfvank2u+uIVTkMIU9en41DEO9oIrkOaY1m6JXQoRElyv0J
   6Nmak0Pno7y9shvuVAkRFSEGidllSOunHeOwojnctlBUBgE3/wwpeWxsu
   CBKO3mT3iiGsjupkha4Kzqm3txFidZ7jRaw6Iq25De3GNKZ2ssJBIzWLz
   wB3dhRo0g7NshC97mUvYtN/47ajgQ0HDAx4hincQuAyZY3pJ4UYYDEGjd
   HeAfFspt5xlHjRZpGr0RYysiMQnuKqR4jcSFX9cFv8cJ1TQ/oSdxDCy/B
   tEXWgZ3C7Z/5mtC2/SJ1UxWr1CvlAG7rO+GsBb0ITCoKC4cPeezgk3FCG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="300404294"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="300404294"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597592004"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2022 13:10:37 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, avagin@gmail.com,
        seanjc@google.com, chang.seok.bae@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/4] selftests/x86/mxcsr: Test the MXCSR state write via ptrace
Date:   Thu, 22 Sep 2022 13:00:32 -0700
Message-Id: <20220922200034.23759-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922200034.23759-1-chang.seok.bae@intel.com>
References: <20220922200034.23759-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The ptrace buffer is in the non-compacted format. The MXCSR state should be
written to the target thread when either SSE or AVX component is enabled.

Write an MXCSR value to the target and read back. Then it is validated with
the XRSTOR/XSAVE result on the current.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---

If this is acceptable, I will also follow up to move some of the helper
functions to a .h file from this and other test cases because duplicating
what is shareable should be avoided.
---
 tools/testing/selftests/x86/Makefile |   2 +-
 tools/testing/selftests/x86/mxcsr.c  | 200 +++++++++++++++++++++++++++
 2 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/mxcsr.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0388c4d60af0..621c47960be3 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore sigaltstack
+			syscall_arg_fault fsgsbase_restore sigaltstack mxcsr
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/mxcsr.c b/tools/testing/selftests/x86/mxcsr.c
new file mode 100644
index 000000000000..7c318c48b4be
--- /dev/null
+++ b/tools/testing/selftests/x86/mxcsr.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <elf.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <x86intrin.h>
+
+#include <sys/ptrace.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+
+#include "../kselftest.h" /* For __cpuid_count() */
+
+#define LEGACY_STATE_SIZE	24
+#define MXCSR_SIZE		8
+#define STSTATE_SIZE		8*16
+#define XMM_SIZE		16*16
+#define PADDING_SIZE		96
+#define XSAVE_HDR_SIZE		64
+
+struct xsave_buffer {
+	uint8_t		legacy_state[LEGACY_STATE_SIZE];
+	uint8_t		mxcsr[MXCSR_SIZE];
+	uint8_t		st_state[STSTATE_SIZE];
+	uint8_t		xmm_state[XMM_SIZE];
+	uint8_t		padding[PADDING_SIZE];
+	uint8_t		header[XSAVE_HDR_SIZE];
+	uint8_t		extended[0];
+};
+
+#ifdef __x86_64__
+#define REX_PREFIX	"0x48, "
+#else
+#define REX_PREFIX
+#endif
+
+#define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
+#define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
+
+static inline uint64_t xgetbv(uint32_t index)
+{
+	uint32_t eax, edx;
+
+	asm volatile("xgetbv"
+		     : "=a" (eax), "=d" (edx)
+		     : "c" (index));
+	return eax + ((uint64_t)edx << 32);
+}
+
+static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_lo = rfbm;
+	uint32_t rfbm_hi = rfbm >> 32;
+
+	asm volatile(XSAVE :: "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi) : "memory");
+}
+
+static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_lo = rfbm;
+	uint32_t rfbm_hi = rfbm >> 32;
+
+	asm volatile(XRSTOR :: "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi));
+}
+
+static inline void clear_xstate_header(struct xsave_buffer *xbuf)
+{
+	memset(&xbuf->header, 0, sizeof(xbuf->header));
+}
+
+static inline uint32_t get_mxcsr(struct xsave_buffer *xbuf)
+{
+	return *((uint32_t *)xbuf->mxcsr);
+}
+
+static inline void set_mxcsr(struct xsave_buffer *xbuf, uint32_t val)
+{
+	*((uint32_t *)xbuf->mxcsr) = val;
+}
+
+#define XFEATURE_MASK_SSE		0x2
+#define XFEATURE_MASK_YMM		0x4
+
+#define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
+#define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
+#define CPUID_LEAF_XSTATE		0xd
+#define CPUID_SUBLEAF_XSTATE_USER	0x0
+#define CPUID_SUBLEAF_XSTATE_EXT	0x1
+
+static bool xsave_availability(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	__cpuid_count(1, 0, eax, ebx, ecx, edx);
+	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
+		return false;
+	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
+		return false;
+	return true;
+}
+
+static uint32_t get_xbuf_size(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
+		      eax, ebx, ecx, edx);
+	return ebx;
+}
+
+static void ptrace_get(pid_t pid, struct iovec *iov)
+{
+	memset(iov->iov_base, 0, iov->iov_len);
+
+	if (ptrace(PTRACE_GETREGSET, pid, (uint32_t)NT_X86_XSTATE, iov))
+		err(1, "TRACE_GETREGSET");
+}
+
+static void ptrace_set(pid_t pid, struct iovec *iov)
+{
+	if (ptrace(PTRACE_SETREGSET, pid, (uint32_t)NT_X86_XSTATE, iov))
+		err(1, "TRACE_SETREGSET");
+}
+
+int main(void)
+{
+	struct xsave_buffer *xbuf;
+	uint32_t xbuf_size;
+	struct iovec iov;
+	uint32_t mxcsr;
+	pid_t child;
+	int status;
+
+	if (!xsave_availability())
+		printf("[SKIP]\tSkip as XSAVE not available.\n");
+
+	xbuf_size = get_xbuf_size();
+	if (!xbuf_size)
+		printf("[SKIP]\tSkip as XSAVE not available.\n");
+
+	if (!(xgetbv(0) & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM)))
+		printf("[SKIP]\tSkip as SSE state not available.\n");
+
+	xbuf = aligned_alloc(64, xbuf_size);
+	if (!xbuf)
+		err(1, "aligned_alloc()");
+
+	iov.iov_base = xbuf;
+	iov.iov_len = xbuf_size;
+
+	child = fork();
+	if (child < 0) {
+		err(1, "fork()");
+	} else if (!child) {
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
+			err(1, "PTRACE_TRACEME");
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	wait(&status);
+
+	if (WSTOPSIG(status) != SIGTRAP)
+		err(1, "raise(SIGTRAP)");
+
+	printf("[RUN]\tTest the MXCSR state write via ptrace().\n");
+
+	/* Set a benign value */
+	set_mxcsr(xbuf, 0xabc);
+	/* The MXCSR state should be loaded regardless of XSTATE_BV */
+	clear_xstate_header(xbuf);
+
+	/* Write the MXCSR state both locally and remotely. */
+	xrstor(xbuf, XFEATURE_MASK_SSE);
+	ptrace_set(child, &iov);
+
+	/* Read the MXCSR state back for both */
+	xsave(xbuf, XFEATURE_MASK_SSE);
+	mxcsr = get_mxcsr(xbuf);
+	ptrace_get(child, &iov);
+
+	/* Cross-check with each other */
+	if (mxcsr == get_mxcsr(xbuf))
+		printf("[OK]\tThe written state was read back correctly.\n");
+	else
+		printf("[FAIL]\tThe write (or read) was incorrect.\n");
+
+	ptrace(PTRACE_DETACH, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		err(1, "PTRACE_DETACH");
+
+	free(xbuf);
+}
-- 
2.17.1

