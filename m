Return-Path: <linux-kselftest+bounces-27548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE4CA451F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDA03B1714
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFDF19066B;
	Wed, 26 Feb 2025 01:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2ooicsm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10218BC1D;
	Wed, 26 Feb 2025 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532062; cv=none; b=hxSPtChjmiZuCJPrhtd8n8wmURldn7Pqr0vKHCnJP8//dIfQNZZVyEuqqM0IMqoqgS25uyGBVTA83MrXDk6feldWF8UTfIfdHzResOCtuhRjs/TwmJDWTWykAA8kD1M7sKv7/+xD6mmnTuThaHPTCaZqsYUFJwVROdASN0DnRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532062; c=relaxed/simple;
	bh=9YBDXFEcVpn+YUGYCCd7rdMdPLUA7BlZD2eLYNIaDkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnqzwnHdLkSg9s+8Tr71FBkEhTqx0T8cXqScLL/FGpwZSd/2Gr+zo0C6J/p3/Go80FNU7JCK4q14qVH09pRzsRZmJDLQrmPJcKQz0wQ1a3QbvPCnWcWhQL1YEPrfKrrCouv9jS4Wk+HVjB0os/esojhzFZQBM0qbEpeMuloXpKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2ooicsm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532061; x=1772068061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9YBDXFEcVpn+YUGYCCd7rdMdPLUA7BlZD2eLYNIaDkQ=;
  b=O2ooicsmsfqYkhyhDsV1wL7j0wk+B5HOdJ04rWOFPRsTsiAnImj+Ztme
   y0gch69EcbsajmTi02ODhgRGTTeYLja4ShKUECn25glNdvD/C6bSeqsh5
   ynPPiVVe0BuMg1wN1GPKaknjSIkOXWnW+nLIZBLmcY2XpwKtr/RpH5/3W
   SufSC6z/mfFciqZkaJVVqK0r9cyrZEldrcKY+2pQeg0IOKAtmYr34667e
   a1d/1R36sGHe6Y1o/bfXZ1LIpzNlq9H4O5sWDF9tLDldFEl6VBE3QjwjP
   L2FQuiAN6IdtSVaXLXA0r+94wmOmbgfud6adleRBM/CJWxvIoq+zlqjLd
   A==;
X-CSE-ConnectionGUID: W0rrWYqQTM6D7bPF3THZvg==
X-CSE-MsgGUID: zcuBhHk8S/mzVP5MjOJldQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362221"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362221"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:40 -0800
X-CSE-ConnectionGUID: AS2vZx5xQgWBW6OOyybA5A==
X-CSE-MsgGUID: z6RgEkpcTgu0EYobbzMi4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467359"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:40 -0800
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
Subject: [PATCH 7/9] selftests/x86/xstate: Consolidate test invocations into a single entry
Date: Tue, 25 Feb 2025 17:07:27 -0800
Message-ID: <20250226010731.2456-8-chang.seok.bae@intel.com>
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

Currently, each of the three xstate tests runs as a separate invocation,
requiring the xstate number to be passed and state information to be
reconstructed repeatedly. This approach arose from their individual and
isolated development, but now it makes sense to unify them.

Introduce a wrapper function that first verifies feature availability
from the kernel and constructs the necessary state information once. The
wrapper then sequentially invokes all tests to ensure consistent
execution.

Update the AMX test to use this unified invocation.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 tools/testing/selftests/x86/amx.c    | 11 ++++----
 tools/testing/selftests/x86/xstate.c | 38 ++++++++++++++++++++--------
 tools/testing/selftests/x86/xstate.h |  5 ++--
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 9cb691d67ef4..40769c16de1b 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -480,7 +480,6 @@ static void test_fork(void)
 
 int main(void)
 {
-	const unsigned int ctxtsw_num_threads = 5, ctxtsw_iterations = 10;
 	unsigned long features;
 	long rc;
 
@@ -506,11 +505,11 @@ int main(void)
 
 	test_fork();
 
-	test_context_switch(XFEATURE_XTILEDATA, ctxtsw_num_threads, ctxtsw_iterations);
-
-	test_ptrace(XFEATURE_XTILEDATA);
-
-	test_signal(XFEATURE_XTILEDATA);
+	/*
+	 * Perform generic xstate tests for context switching, ptrace,
+	 * and signal.
+	 */
+	test_xstate(XFEATURE_XTILEDATA);
 
 	clearhandler(SIGILL);
 	free_stashed_xsave();
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index b5600f492632..fd8451e55f3f 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -6,7 +6,9 @@
 #include <pthread.h>
 #include <stdbool.h>
 
+#include <asm/prctl.h>
 #include <sys/ptrace.h>
+#include <sys/syscall.h>
 #include <sys/uio.h>
 #include <sys/wait.h>
 
@@ -189,15 +191,13 @@ static void affinitize_cpu0(void)
 		ksft_exit_fail_msg("sched_setaffinity to CPU 0 failed\n");
 }
 
-void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations)
+static void test_context_switch(uint32_t num_threads, uint32_t iterations)
 {
 	struct futex_info *finfo;
 
 	/* Affinitize to one CPU to force context switches */
 	affinitize_cpu0();
 
-	xstate = get_xstate_info(feature_num);
-
 	printf("[RUN]\t%s: check context switches, %d iterations, %d threads.\n",
 	       xstate.name, iterations, num_threads);
 
@@ -299,13 +299,11 @@ static void ptracer_inject_xstate(pid_t target)
 	free(xbuf2);
 }
 
-void test_ptrace(uint32_t feature_num)
+static void test_ptrace(void)
 {
 	pid_t child;
 	int status;
 
-	xstate = get_xstate_info(feature_num);
-
 	child = fork();
 	if (child < 0) {
 		ksft_exit_fail_msg("fork() failed\n");
@@ -392,17 +390,14 @@ static void validate_sigfpstate(int sig, siginfo_t *si, void *ctx_void)
 	copy_xstate(stashed_xbuf, xbuf);
 }
 
-void test_signal(uint32_t feature_num)
+static void test_signal(void)
 {
 	bool valid_xstate;
 
-	xstate = get_xstate_info(feature_num);
-
 	/*
 	 * The signal handler will access this to verify xstate context
 	 * preservation.
 	 */
-
 	stashed_xbuf = alloc_xbuf();
 	if (!stashed_xbuf)
 		ksft_exit_fail_msg("unable to allocate XSAVE buffer\n");
@@ -433,3 +428,26 @@ void test_signal(uint32_t feature_num)
 	clearhandler(SIGUSR1);
 	free(stashed_xbuf);
 }
+
+void test_xstate(uint32_t feature_num)
+{
+	const unsigned int ctxtsw_num_threads = 5, ctxtsw_iterations = 10;
+	unsigned long features;
+	long rc;
+
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+	if (rc || !(features & (1 << feature_num))) {
+		ksft_print_msg("The kernel does not support feature number: %u\n", feature_num);
+		return;
+	}
+
+	xstate = get_xstate_info(feature_num);
+	if (!xstate.size || !xstate.xbuf_offset) {
+		ksft_exit_fail_msg("invalid state size/offset (%d/%d)\n",
+				   xstate.size, xstate.xbuf_offset);
+	}
+
+	test_context_switch(ctxtsw_num_threads, ctxtsw_iterations);
+	test_ptrace();
+	test_signal();
+}
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 4d0ffe9609f8..42af36ec852f 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -189,8 +189,7 @@ static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer
 		*ptr = data;
 }
 
-void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations);
-void test_ptrace(uint32_t feature_num);
-void test_signal(uint32_t feature_num);
+/* Testing kernel's context switching and ABI support for the xstate. */
+void test_xstate(uint32_t feature_num);
 
 #endif /* __SELFTESTS_X86_XSTATE_H */
-- 
2.45.2


