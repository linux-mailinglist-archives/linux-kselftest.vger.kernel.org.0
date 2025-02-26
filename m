Return-Path: <linux-kselftest+bounces-27545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27BDA451F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 02:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA5E19C38B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4500F188CAE;
	Wed, 26 Feb 2025 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eq8SIuBh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265415E5AE;
	Wed, 26 Feb 2025 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532060; cv=none; b=b3STnBtwWcchc8lpFsJ6T8q01YFpd0OXcOoKpx+qChZIxwcMBUs+SXkVqpgXHbmA82VbkastWrUpFOUwTU0O4riWdBqUVyCbVmpcBBfhmQanMlkWu2iD5oMoZMsmrVbw4FC2wBU6mGQUIhodxNWLRtMPDDt/UvMJ5Khphq3JJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532060; c=relaxed/simple;
	bh=uAQBR6FPJgFLhph7bR7eMw2n3f7jdelY8wUjhm17dVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slkTjuUHqq54q+qd21/OqTgTW7Et+jw4It1zRqT1n0grrfY8OVvOGG5jGMJFghjeMfUWNeeQkUuwS2e4IsmUCbYO8f/U7ntCiCh+zDY07jkmS8WyGSWHsY+SknvvztvQCGYdkv2L1bEqe90ruGurm2Mj/Nol9RWidCfhMF7MZu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eq8SIuBh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532058; x=1772068058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAQBR6FPJgFLhph7bR7eMw2n3f7jdelY8wUjhm17dVA=;
  b=Eq8SIuBhAkMDE38s/PcK0ZkUoP4n3E2D0wjoqS12wCvCWzBUdZ9qkmSy
   TJMUOadOV1NoQI65fNsHfCNE19cMGKRI7NKeQVt9kIMS61Bcppc4TcBi2
   USzzwptyASHa4sIDSdxo0O8h/wSDXQR908q6j90oGxghyEo/fMVyRDo0X
   e6bsID6J0mSvX7L14+XjesojO9vPbsSP8Yq989AiwHldNKaMltMiV1O2U
   O+kJUHhwMNYZkFx+VJiJPVvb/tPdywr/NkqnTSGRou0W8iKA/sWYJJroR
   wzSgwmQwRP2VniFbOXiNYnBP/u0HHeH6fkg7mhlmuK0lTkacilHxyWVkw
   Q==;
X-CSE-ConnectionGUID: pHVVVUe3RZSkT/WW6GQNoQ==
X-CSE-MsgGUID: Kr35KA6ZSyiF/reoqSzIBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52362197"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52362197"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:07:37 -0800
X-CSE-ConnectionGUID: vM/PrbbyR1+wC12nPd5VIA==
X-CSE-MsgGUID: JonilOeUQpOYXx9H2eT4qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147467348"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.166.169])
  by fmviesa001.fm.intel.com with ESMTP; 25 Feb 2025 17:07:37 -0800
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
Subject: [PATCH 4/9] selftests/x86/xstate: Refactor context switching test
Date: Tue, 25 Feb 2025 17:07:24 -0800
Message-ID: <20250226010731.2456-5-chang.seok.bae@intel.com>
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

The existing context switching and ptrace tests in amx.c are not specific
to dynamic states, making them reusable for general xstate testing.

As a first step, move the context switching test to xstate.c. Refactor
the test code to allow specifying which xstate component being tested.

To decouple the test from dynamic states, remove the permission request
code. In fact, The permission request inside the test wrapper was
redundant.

Additionally, replace fatal_error() with ksft_exit_fail_msg() for
consistency in error handling.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Expected output:
$ amx_64
...
[RUN]   AMX Tile data: check context switches, 10 iterations, 5 threads.
[OK]    No incorrect case was found.
---
 tools/testing/selftests/x86/Makefile |   2 +
 tools/testing/selftests/x86/amx.c    | 166 +---------------------
 tools/testing/selftests/x86/xstate.c | 198 +++++++++++++++++++++++++++
 tools/testing/selftests/x86/xstate.h |   2 +
 4 files changed, 204 insertions(+), 164 deletions(-)
 create mode 100644 tools/testing/selftests/x86/xstate.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d51249f14e2f..f15efdc6aef7 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -132,3 +132,5 @@ $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
 
 $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
+
+$(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index cde22f303905..b3c51dd25abc 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -3,7 +3,6 @@
 #define _GNU_SOURCE
 #include <err.h>
 #include <errno.h>
-#include <pthread.h>
 #include <setjmp.h>
 #include <stdio.h>
 #include <string.h>
@@ -434,14 +433,6 @@ static inline bool __validate_tiledata_regs(struct xsave_buffer *xbuf1)
 	return true;
 }
 
-static inline void validate_tiledata_regs_same(struct xsave_buffer *xbuf)
-{
-	int ret = __validate_tiledata_regs(xbuf);
-
-	if (ret != 0)
-		fatal_error("TILEDATA registers changed");
-}
-
 static inline void validate_tiledata_regs_changed(struct xsave_buffer *xbuf)
 {
 	int ret = __validate_tiledata_regs(xbuf);
@@ -498,158 +489,6 @@ static void test_fork(void)
 	_exit(0);
 }
 
-/* Context switching test */
-
-static struct _ctxtswtest_cfg {
-	unsigned int iterations;
-	unsigned int num_threads;
-} ctxtswtest_config;
-
-struct futex_info {
-	pthread_t thread;
-	int nr;
-	pthread_mutex_t mutex;
-	struct futex_info *next;
-};
-
-static void *check_tiledata(void *info)
-{
-	struct futex_info *finfo = (struct futex_info *)info;
-	struct xsave_buffer *xbuf;
-	int i;
-
-	xbuf = alloc_xbuf();
-	if (!xbuf)
-		fatal_error("unable to allocate XSAVE buffer");
-
-	/*
-	 * Load random data into 'xbuf' and then restore
-	 * it to the tile registers themselves.
-	 */
-	load_rand_tiledata(xbuf);
-	for (i = 0; i < ctxtswtest_config.iterations; i++) {
-		pthread_mutex_lock(&finfo->mutex);
-
-		/*
-		 * Ensure the register values have not
-		 * diverged from those recorded in 'xbuf'.
-		 */
-		validate_tiledata_regs_same(xbuf);
-
-		/* Load new, random values into xbuf and registers */
-		load_rand_tiledata(xbuf);
-
-		/*
-		 * The last thread's last unlock will be for
-		 * thread 0's mutex.  However, thread 0 will
-		 * have already exited the loop and the mutex
-		 * will already be unlocked.
-		 *
-		 * Because this is not an ERRORCHECK mutex,
-		 * that inconsistency will be silently ignored.
-		 */
-		pthread_mutex_unlock(&finfo->next->mutex);
-	}
-
-	free(xbuf);
-	/*
-	 * Return this thread's finfo, which is
-	 * a unique value for this thread.
-	 */
-	return finfo;
-}
-
-static int create_threads(int num, struct futex_info *finfo)
-{
-	int i;
-
-	for (i = 0; i < num; i++) {
-		int next_nr;
-
-		finfo[i].nr = i;
-		/*
-		 * Thread 'i' will wait on this mutex to
-		 * be unlocked.  Lock it immediately after
-		 * initialization:
-		 */
-		pthread_mutex_init(&finfo[i].mutex, NULL);
-		pthread_mutex_lock(&finfo[i].mutex);
-
-		next_nr = (i + 1) % num;
-		finfo[i].next = &finfo[next_nr];
-
-		if (pthread_create(&finfo[i].thread, NULL, check_tiledata, &finfo[i]))
-			fatal_error("pthread_create()");
-	}
-	return 0;
-}
-
-static void affinitize_cpu0(void)
-{
-	cpu_set_t cpuset;
-
-	CPU_ZERO(&cpuset);
-	CPU_SET(0, &cpuset);
-
-	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
-		fatal_error("sched_setaffinity to CPU 0");
-}
-
-static void test_context_switch(void)
-{
-	struct futex_info *finfo;
-	int i;
-
-	/* Affinitize to one CPU to force context switches */
-	affinitize_cpu0();
-
-	req_xtiledata_perm();
-
-	printf("[RUN]\tCheck tiledata context switches, %d iterations, %d threads.\n",
-	       ctxtswtest_config.iterations,
-	       ctxtswtest_config.num_threads);
-
-
-	finfo = malloc(sizeof(*finfo) * ctxtswtest_config.num_threads);
-	if (!finfo)
-		fatal_error("malloc()");
-
-	create_threads(ctxtswtest_config.num_threads, finfo);
-
-	/*
-	 * This thread wakes up thread 0
-	 * Thread 0 will wake up 1
-	 * Thread 1 will wake up 2
-	 * ...
-	 * the last thread will wake up 0
-	 *
-	 * ... this will repeat for the configured
-	 * number of iterations.
-	 */
-	pthread_mutex_unlock(&finfo[0].mutex);
-
-	/* Wait for all the threads to finish: */
-	for (i = 0; i < ctxtswtest_config.num_threads; i++) {
-		void *thread_retval;
-		int rc;
-
-		rc = pthread_join(finfo[i].thread, &thread_retval);
-
-		if (rc)
-			fatal_error("pthread_join() failed for thread %d err: %d\n",
-					i, rc);
-
-		if (thread_retval != &finfo[i])
-			fatal_error("unexpected thread retval for thread %d: %p\n",
-					i, thread_retval);
-
-	}
-
-	printf("[OK]\tNo incorrect case was found.\n");
-
-	free(finfo);
-}
-
 /* Ptrace test */
 
 /*
@@ -745,6 +584,7 @@ static void test_ptrace(void)
 
 int main(void)
 {
+	const unsigned int ctxtsw_num_threads = 5, ctxtsw_iterations = 10;
 	unsigned long features;
 	long rc;
 
@@ -772,9 +612,7 @@ int main(void)
 
 	test_fork();
 
-	ctxtswtest_config.iterations = 10;
-	ctxtswtest_config.num_threads = 5;
-	test_context_switch();
+	test_context_switch(XFEATURE_XTILEDATA, ctxtsw_num_threads, ctxtsw_iterations);
 
 	test_ptrace();
 
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
new file mode 100644
index 000000000000..e5b51e7d13e1
--- /dev/null
+++ b/tools/testing/selftests/x86/xstate.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <pthread.h>
+#include <stdbool.h>
+
+#include "helpers.h"
+#include "xstate.h"
+
+static struct xstate_info xstate;
+
+struct futex_info {
+	unsigned int iterations;
+	struct futex_info *next;
+	pthread_mutex_t mutex;
+	pthread_t thread;
+	bool valid;
+	int nr;
+};
+
+static inline void load_rand_xstate(struct xstate_info *xstate, struct xsave_buffer *xbuf)
+{
+	clear_xstate_header(xbuf);
+	set_xstatebv(xbuf, xstate->mask);
+	set_rand_data(xstate, xbuf);
+	xrstor(xbuf, xstate->mask);
+}
+
+static inline bool validate_xstate_same(struct xsave_buffer *xbuf1, struct xsave_buffer *xbuf2)
+{
+	int ret;
+
+	ret = memcmp(&xbuf1->bytes[xstate.xbuf_offset],
+		     &xbuf2->bytes[xstate.xbuf_offset],
+		     xstate.size);
+	return ret == 0;
+}
+
+static inline bool validate_xregs_same(struct xsave_buffer *xbuf1)
+{
+	struct xsave_buffer *xbuf2;
+	bool ret;
+
+	xbuf2 = alloc_xbuf();
+	if (!xbuf2)
+		ksft_exit_fail_msg("failed to allocate XSAVE buffer\n");
+
+	xsave(xbuf2, xstate.mask);
+	ret = validate_xstate_same(xbuf1, xbuf2);
+
+	free(xbuf2);
+	return ret;
+}
+
+/* Context switching test */
+
+static void *check_xstate(void *info)
+{
+	struct futex_info *finfo = (struct futex_info *)info;
+	struct xsave_buffer *xbuf;
+	int i;
+
+	xbuf = alloc_xbuf();
+	if (!xbuf)
+		ksft_exit_fail_msg("unable to allocate XSAVE buffer\n");
+
+	/*
+	 * Load random data into 'xbuf' and then restore it to the xstate
+	 * registers.
+	 */
+	load_rand_xstate(&xstate, xbuf);
+	finfo->valid = true;
+
+	for (i = 0; i < finfo->iterations; i++) {
+		pthread_mutex_lock(&finfo->mutex);
+
+		/*
+		 * Ensure the register values have not diverged from the
+		 * record. Then reload a new random value.  If it failed
+		 * ever before, skip it.
+		 */
+		if (finfo->valid) {
+			finfo->valid = validate_xregs_same(xbuf);
+			load_rand_xstate(&xstate, xbuf);
+		}
+
+		/*
+		 * The last thread's last unlock will be for thread 0's
+		 * mutex. However, thread 0 will have already exited the
+		 * loop and the mutex will already be unlocked.
+		 *
+		 * Because this is not an ERRORCHECK mutex, that
+		 * inconsistency will be silently ignored.
+		 */
+		pthread_mutex_unlock(&finfo->next->mutex);
+	}
+
+	free(xbuf);
+	return finfo;
+}
+
+static void create_threads(uint32_t num_threads, uint32_t iterations, struct futex_info *finfo)
+{
+	int i;
+
+	for (i = 0; i < num_threads; i++) {
+		int next_nr;
+
+		finfo[i].nr = i;
+		finfo[i].iterations = iterations;
+
+		/*
+		 * Thread 'i' will wait on this mutex to be unlocked.
+		 * Lock it immediately after initialization:
+		 */
+		pthread_mutex_init(&finfo[i].mutex, NULL);
+		pthread_mutex_lock(&finfo[i].mutex);
+
+		next_nr = (i + 1) % num_threads;
+		finfo[i].next = &finfo[next_nr];
+
+		if (pthread_create(&finfo[i].thread, NULL, check_xstate, &finfo[i]))
+			ksft_exit_fail_msg("pthread_create() failed\n");
+	}
+}
+
+static bool checkout_threads(uint32_t num_threads, struct futex_info *finfo)
+{
+	void *thread_retval;
+	bool valid = true;
+	int err, i;
+
+	for (i = 0; i < num_threads; i++) {
+		err = pthread_join(finfo[i].thread, &thread_retval);
+		if (err)
+			ksft_exit_fail_msg("pthread_join() failed for thread %d err: %d\n", i, err);
+
+		if (thread_retval != &finfo[i]) {
+			ksft_exit_fail_msg("unexpected thread retval for thread %d: %p\n",
+					   i, thread_retval);
+		}
+
+		valid &= finfo[i].valid;
+	}
+
+	return valid;
+}
+
+static void affinitize_cpu0(void)
+{
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
+		ksft_exit_fail_msg("sched_setaffinity to CPU 0 failed\n");
+}
+
+void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations)
+{
+	struct futex_info *finfo;
+
+	/* Affinitize to one CPU to force context switches */
+	affinitize_cpu0();
+
+	xstate = get_xstate_info(feature_num);
+
+	printf("[RUN]\t%s: check context switches, %d iterations, %d threads.\n",
+	       xstate.name, iterations, num_threads);
+
+	finfo = malloc(sizeof(*finfo) * num_threads);
+	if (!finfo)
+		ksft_exit_fail_msg("unable allocate memory\n");
+
+	create_threads(num_threads, iterations, finfo);
+
+	/*
+	 * This thread wakes up thread 0
+	 * Thread 0 will wake up 1
+	 * Thread 1 will wake up 2
+	 * ...
+	 * The last thread will wake up 0
+	 *
+	 * This will repeat for the configured
+	 * number of iterations.
+	 */
+	pthread_mutex_unlock(&finfo[0].mutex);
+
+	/* Wait for all the threads to finish: */
+	if (checkout_threads(num_threads, finfo))
+		printf("[OK]\tNo incorrect case was found.\n");
+	else
+		printf("[FAIL]\tFailed with context switching test.\n");
+
+	free(finfo);
+}
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index d3461c438461..5ef66f247eb9 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -189,4 +189,6 @@ static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer
 		*ptr = data;
 }
 
+void test_context_switch(uint32_t feature_num, uint32_t num_threads, uint32_t iterations);
+
 #endif /* __SELFTESTS_X86_XSTATE_H */
-- 
2.45.2


