Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738BB36C754
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Apr 2021 15:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbhD0Nyb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhD0Ny2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 09:54:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C48C061756;
        Tue, 27 Apr 2021 06:53:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 5BA351F424AB
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/2] selftests: futex: Expand timeout test
Date:   Tue, 27 Apr 2021 10:53:28 -0300
Message-Id: <20210427135328.11013-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427135328.11013-1-andrealmeid@collabora.com>
References: <20210427135328.11013-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Improve futex timeout testing by checking all the operations that
supports timeout and their available modes.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_timeout.c     | 126 +++++++++++++++---
 1 file changed, 110 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index ee55e6d389a3..1f8f6daaf1e7 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -11,21 +11,18 @@
  *
  * HISTORY
  *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
+ *      2021-Apr-26: More test cases by André Almeida <andrealmeid@collabora.com>
  *
  *****************************************************************************/
 
-#include <errno.h>
-#include <getopt.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
+#include <pthread.h>
 #include "futextest.h"
 #include "logging.h"
 
 #define TEST_NAME "futex-wait-timeout"
 
 static long timeout_ns = 100000;	/* 100us default timeout */
+static futex_t futex_pi;
 
 void usage(char *prog)
 {
@@ -37,11 +34,67 @@ void usage(char *prog)
 	       VQUIET, VCRITICAL, VINFO);
 }
 
+/*
+ * Get a PI lock and hold it forever, so the main thread lock_pi will block
+ * and we can test the timeout
+ */
+void *get_pi_lock(void *arg)
+{
+	int ret;
+	volatile futex_t lock = 0;
+
+	ret = futex_lock_pi(&futex_pi, NULL, 0, 0);
+	if (ret != 0)
+		error("futex_lock_pi failed\n", ret);
+
+	/* Blocks forever */
+	ret = futex_wait(&lock, 0, NULL, 0);
+	error("futex_wait failed\n", ret);
+
+	return NULL;
+}
+
+/*
+ * Check if the function returned the expected error
+ */
+static void test_timeout(int res, int *ret, char *test_name, int err)
+{
+	if (!res || errno != err) {
+		ksft_test_result_fail("%s returned %d\n", test_name,
+				      res < 0 ? errno : res);
+		*ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("%s succeeds\n", test_name);
+	}
+}
+
+/*
+ * Calculate absolute timeout and correct overflow
+ */
+static int futex_get_abs_timeout(clockid_t clockid, struct timespec *to,
+				 long timeout_ns)
+{
+	if (clock_gettime(clockid, to)) {
+		error("clock_gettime failed\n", errno);
+		return errno;
+	}
+
+	to->tv_nsec += timeout_ns;
+
+	if (to->tv_nsec >= 1000000000) {
+		to->tv_sec++;
+		to->tv_nsec -= 1000000000;
+	}
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	futex_t f1 = FUTEX_INITIALIZER;
-	struct timespec to;
 	int res, ret = RET_PASS;
+	struct timespec to;
+	pthread_t thread;
 	int c;
 
 	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
@@ -65,22 +118,63 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(7);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
 
-	/* initialize timeout */
+	pthread_create(&thread, NULL, get_pi_lock, NULL);
+
+	/* initialize relative timeout */
 	to.tv_sec = 0;
 	to.tv_nsec = timeout_ns;
 
-	info("Calling futex_wait on f1: %u @ %p\n", f1, &f1);
-	res = futex_wait(&f1, f1, &to, FUTEX_PRIVATE_FLAG);
-	if (!res || errno != ETIMEDOUT) {
-		fail("futex_wait returned %d\n", ret < 0 ? errno : ret);
-		ret = RET_FAIL;
-	}
+	res = futex_wait(&f1, f1, &to, 0);
+	test_timeout(res, &ret, "futex_wait relative", ETIMEDOUT);
+
+	/* FUTEX_WAIT_BITSET with CLOCK_REALTIME */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_wait_bitset(&f1, f1, &to, 1, FUTEX_CLOCK_REALTIME);
+	test_timeout(res, &ret, "futex_wait_bitset realtime", ETIMEDOUT);
+
+	/* FUTEX_WAIT_BITSET with CLOCK_MONOTONIC */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_wait_bitset(&f1, f1, &to, 1, 0);
+	test_timeout(res, &ret, "futex_wait_bitset monotonic", ETIMEDOUT);
+
+	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_REALTIME */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, FUTEX_CLOCK_REALTIME);
+	test_timeout(res, &ret, "futex_wait_requeue_pi realtime", ETIMEDOUT);
+
+	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_MONOTONIC */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, 0);
+	test_timeout(res, &ret, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
+
+	/*
+	 * FUTEX_LOCK_PI with CLOCK_REALTIME
+	 * Due to historical reasons, FUTEX_LOCK_PI supports only realtime
+	 * clock, but requires the caller to not set CLOCK_REALTIME flag.
+	 *
+	 * If you call FUTEX_LOCK_PI with a monotonic clock, it'll be
+	 * interpreted as a realtime clock, and (unless you mess your machine's
+	 * time or your time machine) the monotonic clock value is always
+	 * smaller than realtime and the syscall will timeout immediately.
+	 */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_lock_pi(&futex_pi, &to, 0, 0);
+	test_timeout(res, &ret, "futex_lock_pi realtime", ETIMEDOUT);
+
+	/* Test operations that don't support FUTEX_CLOCK_REALTIME */
+	res = futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
+	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
 
-	print_result(TEST_NAME, ret);
+	ksft_print_cnts();
 	return ret;
 }
-- 
2.31.1

