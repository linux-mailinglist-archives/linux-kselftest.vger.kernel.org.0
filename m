Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7843B25A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 14:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhJZM1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 08:27:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:8643 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234552AbhJZM1k (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 08:27:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="228647496"
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="228647496"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 05:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,182,1631602800"; 
   d="scan'208";a="486160726"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.28.105])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2021 05:25:06 -0700
Subject: [PATCH 2/2] selftest/x86/amx: Add context switch test
To:     dave.hansen@intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        chang.seok.bae@intel.com, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 26 Oct 2021 05:25:25 -0700
References: <20211026122523.AFB99C1F@davehans-spike.ostc.intel.com>
In-Reply-To: <20211026122523.AFB99C1F@davehans-spike.ostc.intel.com>
Message-Id: <20211026122525.6EFD5758@davehans-spike.ostc.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


From: Chang S. Bae <chang.seok.bae@intel.com>

XSAVE state is thread-local.  The kernel switches between thread
state at context switch time.  Generally, running a selftest for
a while will naturally expose it to some context switching and
and will test the XSAVE code.

Instead of just hoping that the tests get context-switched at
random times, force context-switches on purpose.  Spawn off a few
userspace threads and force context-switches between them.
Ensure that the kernel correctly context switches each thread's
unique AMX state.

 [ dhansen: bunches of cleanups ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---

 b/tools/testing/selftests/x86/amx.c |  160 +++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 3 deletions(-)

diff -puN tools/testing/selftests/x86/amx.c~amx-selftest-2_3-selftest-x86-amx-Add-context-switch-test tools/testing/selftests/x86/amx.c
--- a/tools/testing/selftests/x86/amx.c~amx-selftest-2_3-selftest-x86-amx-Add-context-switch-test	2021-10-15 13:56:41.453901715 -0700
+++ b/tools/testing/selftests/x86/amx.c	2021-10-15 13:56:41.457901715 -0700
@@ -3,6 +3,7 @@
 #define _GNU_SOURCE
 #include <err.h>
 #include <errno.h>
+#include <pthread.h>
 #include <setjmp.h>
 #include <stdio.h>
 #include <string.h>
@@ -10,8 +11,6 @@
 #include <unistd.h>
 #include <x86intrin.h>
 
-#include <linux/futex.h>
-
 #include <sys/auxv.h>
 #include <sys/mman.h>
 #include <sys/shm.h>
@@ -259,7 +258,6 @@ void sig_print(char *msg)
 
 static volatile bool noperm_signaled;
 static int noperm_errs;
-
 /*
  * Signal handler for when AMX is used but
  * permission has not been obtained.
@@ -674,6 +672,158 @@ static void test_fork(void)
 	_exit(0);
 }
 
+/* Context switching test */
+
+static struct _ctxtswtest_cfg {
+	unsigned int iterations;
+	unsigned int num_threads;
+} ctxtswtest_config;
+
+struct futex_info {
+	pthread_t thread;
+	int nr;
+	pthread_mutex_t mutex;
+	struct futex_info *next;
+};
+
+static void *check_tiledata(void *info)
+{
+	struct futex_info *finfo = (struct futex_info *)info;
+	struct xsave_buffer *xbuf;
+	int i;
+
+	xbuf = alloc_xbuf();
+	if (!xbuf)
+		fatal_error("unable to allocate XSAVE buffer");
+
+	/*
+	 * Load random data into 'xbuf' and then restore
+	 * it to the tile registers themselves.
+	 */
+	load_rand_tiledata(xbuf);
+	for (i = 0; i < ctxtswtest_config.iterations; i++) {
+		pthread_mutex_lock(&finfo->mutex);
+
+		/*
+		 * Ensure the register values have not
+		 * diverged from those recorded in 'xbuf'.
+		 */
+		validate_tiledata_regs_same(xbuf);
+
+		/* Load new, random values into xbuf and registers */
+		load_rand_tiledata(xbuf);
+
+		/*
+		 * The last thread's last unlock will be for
+		 * thread 0's mutex.  However, thread 0 will
+		 * have already exited the loop and the mutex
+		 * will already be unlocked.
+		 *
+		 * Because this is not an ERRORCHECK mutex,
+		 * that inconsistency will be silently ignored.
+		 */
+		pthread_mutex_unlock(&finfo->next->mutex);
+	}
+
+	free(xbuf);
+	/*
+	 * Return this thread's finfo, which is
+	 * a unique value for this thread.
+	 */
+	return finfo;
+}
+
+static int create_threads(int num, struct futex_info *finfo)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		int next_nr;
+
+		finfo[i].nr = i;
+		/*
+		 * Thread 'i' will wait on this mutex to
+		 * be unlocked.  Lock it immediately after
+		 * initialization:
+		 */
+		pthread_mutex_init(&finfo[i].mutex, NULL);
+		pthread_mutex_lock(&finfo[i].mutex);
+
+		next_nr = (i + 1) % num;
+		finfo[i].next = &finfo[next_nr];
+
+		if (pthread_create(&finfo[i].thread, NULL, check_tiledata, &finfo[i]))
+			fatal_error("pthread_create()");
+	}
+	return 0;
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
+		fatal_error("sched_setaffinity to CPU 0");
+}
+
+static void test_context_switch(void)
+{
+	struct futex_info *finfo;
+	int i;
+
+	/* Affinitize to one CPU to force context switches */
+	affinitize_cpu0();
+
+	req_xtiledata_perm();
+
+	printf("[RUN]\tCheck tiledata context switches, %d iterations, %d threads.\n",
+	       ctxtswtest_config.iterations,
+	       ctxtswtest_config.num_threads);
+
+
+	finfo = malloc(sizeof(*finfo) * ctxtswtest_config.num_threads);
+	if (!finfo)
+		fatal_error("malloc()");
+
+	create_threads(ctxtswtest_config.num_threads, finfo);
+
+	/*
+	 * This thread wakes up thread 0
+	 * Thread 0 will wake up 1
+	 * Thread 1 will wake up 2
+	 * ...
+	 * the last thread will wake up 0
+	 *
+	 * ... this will repeat for the configured
+	 * number of iterations.
+	 */
+	pthread_mutex_unlock(&finfo[0].mutex);
+
+	/* Wait for all the threads to finish: */
+	for (i = 0; i < ctxtswtest_config.num_threads; i++) {
+		void *thread_retval;
+		int rc;
+
+		rc = pthread_join(finfo[i].thread, &thread_retval);
+
+		if (rc)
+			fatal_error("pthread_join() failed for thread %d err: %d\n",
+					i, rc);
+
+		if (thread_retval != &finfo[i])
+			fatal_error("unexpected thread retval for thread %d: %p\n",
+					i, thread_retval);
+
+	}
+
+	printf("[OK]\tNo incorrect case was found.\n");
+
+	free(finfo);
+}
+
 int main(void)
 {
 	/* Check hardware availability at first */
@@ -690,6 +840,10 @@ int main(void)
 
 	test_fork();
 
+	ctxtswtest_config.iterations = 10;
+	ctxtswtest_config.num_threads = 5;
+	test_context_switch();
+
 	clearhandler(SIGILL);
 	free_stashed_xsave();
 
_
