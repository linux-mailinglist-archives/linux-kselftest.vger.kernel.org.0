Return-Path: <linux-kselftest+bounces-27546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6138A451F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9552D17DD2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98FD18CC08;
	Wed, 26 Feb 2025 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAIeS7Nm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0612178372;
	Wed, 26 Feb 2025 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532060; cv=none; b=HVHXfS/omylmWSsuU9JyoWv8g15hEEswVZKni5rkZeu396h5xF7JHKBsjCfKy2bOD1pU/eixxzUv/jlDTJJkKdUk+4mMFbkcBIKs3CKMGJ6qqhTdGwq17ir80ifGrpD7UlNmAk5sELOlGpCBml/kq4w1NBtCk0uZOdAvX0Apg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532060; c=relaxed/simple;
	bh=b+YHZn2oe7fZ7lyCIm3gb0IseuEDVm4QkMMYsFhiiT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sl0Ui2ppO0dkZZ47xciOExTGq2Ah0nKi0zZQC4/z9bykQSzKgFkxa7fKeLN0TdpV1G217gL4bAk38At7Y5IqjRWFWlmI9XQvqkXxbFhwbZ27cZRnMkBGNC2Ht1Begm0y6n5YpDFOPJe7M/nihOazhKPnVDpVttOhIf002UqTjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAIeS7Nm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532059; x=1772068059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b+YHZn2oe7fZ7lyCIm3gb0IseuEDVm4QkMMYsFhiiT8=;
  b=FAIeS7Nmu00CgX/H2ETGVZn3E414OxWBlspA4EXa/eb8zlfFZZ3CMW4H
   dSmJFy4xgkuSE7WFH2OBeo4w8uiUvIqgQb+BjiWBO7crduzT5go4SOhF2
   vjeVZKe8asecAcI7c+A1N0aH93piDpuSeOJC563iQEjZRC4hUu2vt4Fcy
   bBdB3OnF3d58bUcO9+/EyWHs8iYca9iUNvzLJEKtLck4OUWHDyXgRzCAf
   qwRy2cVdKH/fPTLbqcjCdDedvVM4UCd68mB9E8SPGRII4b37HZa3OrVi+
   XcHYJEWvdjedlDxsvd91/w0H3sWjK23ynBCUn8Uo/YUMOc4K0ZnlLF10d
   w==;
X-CSE-ConnectionGUID: 9IcWbaYDTPWEvlrCW3NQUg==
X-CSE-MsgGUID: jV8WEgZJTMe410czHx8pxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362208"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362208"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:38 -0800
X-CSE-ConnectionGUID: r1xqzPQjQDKN/mH9hUC9sw==
X-CSE-MsgGUID: eXxteRbpRmWJOiUTaTDVfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467352"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:38 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	shuah@kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH 5/9] selftests/x86/xstate: Refactor ptrace ABI test
Date: Tue, 25 Feb 2025 17:07:25 -0800
Message-ID: <20250226010731.2456-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226010731.2456-1-chang.seok.bae@intel.com>
References: <20250226010731.2456-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the refactor of the context switching test, the ptrace test is
another component reusable for other xstate features. As part of this
restructuring, add a missing check to validate the
user_xstateregs->xstate_fx_sw field in the ABI.

Also, replace err() and fatal_error() with ksft_exit_fail_msg() for
consistency in error handling.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Expected out:
$ amx_64
...
[RUN]   AMX Tile data: inject xstate via ptrace().
[OK]    'xfeatures' in SW reserved area was correctly written
[OK]    xstate was correctly updated.
---
 tools/testing/selftests/x86/amx.c    | 108 +---------------------
 tools/testing/selftests/x86/xstate.c | 129 +++++++++++++++++++++++++++
 tools/testing/selftests/x86/xstate.h |   1 +
 3 files changed, 131 insertions(+), 107 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index b3c51dd25abc..4bafbb72aa1b 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -13,10 +13,8 @@
 #include <sys/auxv.h>
 #include <sys/mman.h>
 #include <sys/shm.h>
-#include <sys/ptrace.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
-#include <sys/uio.h>
 
 #include "helpers.h"
 #include "xstate.h"
@@ -32,8 +30,6 @@
 #define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
 #define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
 
-static uint32_t xbuf_size;
-
 struct xstate_info xtiledata;
 
 /* The helpers for managing XSAVE buffer and tile states: */
@@ -154,13 +150,6 @@ static inline bool load_rand_tiledata(struct xsave_buffer *xbuf)
 	return xrstor_safe(xbuf, XFEATURE_MASK_XTILEDATA);
 }
 
-/* Return XTILEDATA to its initial configuration. */
-static inline void init_xtiledata(void)
-{
-	clear_xstate_header(stashed_xsave);
-	xrstor_safe(stashed_xsave, XFEATURE_MASK_XTILEDATA);
-}
-
 enum expected_result { FAIL_EXPECTED, SUCCESS_EXPECTED };
 
 /* arch_prctl() and sigaltstack() test */
@@ -489,99 +478,6 @@ static void test_fork(void)
 	_exit(0);
 }
 
-/* Ptrace test */
-
-/*
- * Make sure the ptracee has the expanded kernel buffer on the first
- * use. Then, initialize the state before performing the state
- * injection from the ptracer.
- */
-static inline void ptracee_firstuse_tiledata(void)
-{
-	load_rand_tiledata(stashed_xsave);
-	init_xtiledata();
-}
-
-/*
- * Ptracer injects the randomized tile data state. It also reads
- * before and after that, which will execute the kernel's state copy
- * functions. So, the tester is advised to double-check any emitted
- * kernel messages.
- */
-static void ptracer_inject_tiledata(pid_t target)
-{
-	struct xsave_buffer *xbuf;
-	struct iovec iov;
-
-	xbuf = alloc_xbuf();
-	if (!xbuf)
-		fatal_error("unable to allocate XSAVE buffer");
-
-	printf("\tRead the init'ed tiledata via ptrace().\n");
-
-	iov.iov_base = xbuf;
-	iov.iov_len = xbuf_size;
-
-	memset(stashed_xsave, 0, xbuf_size);
-
-	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
-		fatal_error("PTRACE_GETREGSET");
-
-	if (!__compare_tiledata_state(stashed_xsave, xbuf))
-		printf("[OK]\tThe init'ed tiledata was read from ptracee.\n");
-	else
-		printf("[FAIL]\tThe init'ed tiledata was not read from ptracee.\n");
-
-	printf("\tInject tiledata via ptrace().\n");
-
-	load_rand_tiledata(xbuf);
-
-	memcpy(&stashed_xsave->bytes[xtiledata.xbuf_offset],
-	       &xbuf->bytes[xtiledata.xbuf_offset],
-	       xtiledata.size);
-
-	if (ptrace(PTRACE_SETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
-		fatal_error("PTRACE_SETREGSET");
-
-	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
-		fatal_error("PTRACE_GETREGSET");
-
-	if (!__compare_tiledata_state(stashed_xsave, xbuf))
-		printf("[OK]\tTiledata was correctly written to ptracee.\n");
-	else
-		printf("[FAIL]\tTiledata was not correctly written to ptracee.\n");
-}
-
-static void test_ptrace(void)
-{
-	pid_t child;
-	int status;
-
-	child = fork();
-	if (child < 0) {
-		err(1, "fork");
-	} else if (!child) {
-		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
-			err(1, "PTRACE_TRACEME");
-
-		ptracee_firstuse_tiledata();
-
-		raise(SIGTRAP);
-		_exit(0);
-	}
-
-	do {
-		wait(&status);
-	} while (WSTOPSIG(status) != SIGTRAP);
-
-	ptracer_inject_tiledata(child);
-
-	ptrace(PTRACE_DETACH, child, NULL, NULL);
-	wait(&status);
-	if (!WIFEXITED(status) || WEXITSTATUS(status))
-		err(1, "ptrace test");
-}
-
 int main(void)
 {
 	const unsigned int ctxtsw_num_threads = 5, ctxtsw_iterations = 10;
@@ -594,8 +490,6 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	xbuf_size = get_xbuf_size();
-
 	xtiledata = get_xstate_info(XFEATURE_XTILEDATA);
 	if (!xtiledata.size || !xtiledata.xbuf_offset) {
 		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
@@ -614,7 +508,7 @@ int main(void)
 
 	test_context_switch(XFEATURE_XTILEDATA, ctxtsw_num_threads, ctxtsw_iterations);
 
-	test_ptrace();
+	test_ptrace(XFEATURE_XTILEDATA);
 
 	clearhandler(SIGILL);
 	free_stashed_xsave();
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index e5b51e7d13e1..d318b35ba547 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -2,12 +2,25 @@
 
 #define _GNU_SOURCE
 
+#include <elf.h>
 #include <pthread.h>
 #include <stdbool.h>
 
+#include <sys/ptrace.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+
 #include "helpers.h"
 #include "xstate.h"
 
+static inline uint64_t xgetbv(uint32_t index)
+{
+	uint32_t eax, edx;
+
+	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (index));
+	return eax + ((uint64_t)edx << 32);
+}
+
 static struct xstate_info xstate;
 
 struct futex_info {
@@ -27,6 +40,19 @@ static inline void load_rand_xstate(struct xstate_info *xstate, struct xsave_buf
 	xrstor(xbuf, xstate->mask);
 }
 
+static inline void load_init_xstate(struct xstate_info *xstate, struct xsave_buffer *xbuf)
+{
+	clear_xstate_header(xbuf);
+	xrstor(xbuf, xstate->mask);
+}
+
+static inline void copy_xstate(struct xsave_buffer *xbuf_dst, struct xsave_buffer *xbuf_src)
+{
+	memcpy(&xbuf_dst->bytes[xstate.xbuf_offset],
+	       &xbuf_src->bytes[xstate.xbuf_offset],
+	       xstate.size);
+}
+
 static inline bool validate_xstate_same(struct xsave_buffer *xbuf1, struct xsave_buffer *xbuf2)
 {
 	int ret;
@@ -196,3 +222,106 @@ void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t it
 
 	free(finfo);
 }
+
+/*
+ * Ptrace test for the ABI format as described in arch/x86/include/asm/user.h
+ */
+
+/*
+ * Make sure the ptracee has the expanded kernel buffer on the first use.
+ * Then, initialize the state before performing the state injection from
+ * the ptracer. For non-dynamic states, this is benign.
+ */
+static inline void ptracee_touch_xstate(void)
+{
+	struct xsave_buffer *xbuf;
+
+	xbuf = alloc_xbuf();
+
+	load_rand_xstate(&xstate, xbuf);
+	load_init_xstate(&xstate, xbuf);
+
+	free(xbuf);
+}
+
+/*
+ * Ptracer injects the randomized xstate data. It also reads before and
+ * after that, which will execute the kernel's state copy functions.
+ */
+static void ptracer_inject_xstate(pid_t target)
+{
+	uint32_t xbuf_size = get_xbuf_size();
+	struct xsave_buffer *xbuf1, *xbuf2;
+	struct iovec iov;
+
+	/*
+	 * Allocate buffers to keep data while ptracer can write the
+	 * other buffer
+	 */
+	xbuf1 = alloc_xbuf();
+	xbuf2 = alloc_xbuf();
+	if (!xbuf1 || !xbuf2)
+		ksft_exit_fail_msg("unable to allocate XSAVE buffer\n");
+
+	iov.iov_base = xbuf1;
+	iov.iov_len  = xbuf_size;
+
+	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		ksft_exit_fail_msg("PTRACE_GETREGSET failed\n");
+
+	printf("[RUN]\t%s: inject xstate via ptrace().\n", xstate.name);
+
+	load_rand_xstate(&xstate, xbuf1);
+	copy_xstate(xbuf2, xbuf1);
+
+	if (ptrace(PTRACE_SETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		ksft_exit_fail_msg("PTRACE_SETREGSET failed\n");
+
+	if (ptrace(PTRACE_GETREGSET, target, (uint32_t)NT_X86_XSTATE, &iov))
+		ksft_exit_fail_msg("PTRACE_GETREGSET failed\n");
+
+	if (*(uint64_t *)get_fpx_sw_bytes(xbuf1) == xgetbv(0))
+		printf("[OK]\t'xfeatures' in SW reserved area was correctly written\n");
+	else
+		printf("[FAIL]\t'xfeatures' in SW reserved area was not correctly written\n");
+
+	if (validate_xstate_same(xbuf2, xbuf1))
+		printf("[OK]\txstate was correctly updated.\n");
+	else
+		printf("[FAIL]\txstate was not correctly updated.\n");
+
+	free(xbuf1);
+	free(xbuf2);
+}
+
+void test_ptrace(uint32_t feature_num)
+{
+	pid_t child;
+	int status;
+
+	xstate = get_xstate_info(feature_num);
+
+	child = fork();
+	if (child < 0) {
+		ksft_exit_fail_msg("fork() failed\n");
+	} else if (!child) {
+		if (ptrace(PTRACE_TRACEME, 0, NULL, NULL))
+			ksft_exit_fail_msg("PTRACE_TRACEME failed\n");
+
+		ptracee_touch_xstate();
+
+		raise(SIGTRAP);
+		_exit(0);
+	}
+
+	do {
+		wait(&status);
+	} while (WSTOPSIG(status) != SIGTRAP);
+
+	ptracer_inject_xstate(child);
+
+	ptrace(PTRACE_DETACH, child, NULL, NULL);
+	wait(&status);
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		ksft_exit_fail_msg("ptracee exit error\n");
+}
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 5ef66f247eb9..2bf11d3a3ce9 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -190,5 +190,6 @@ static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer
 }
 
 void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations);
+void test_ptrace(uint32_t feature_num);
 
 #endif /* __SELFTESTS_X86_XSTATE_H */
-- 
2.45.2


