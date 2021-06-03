Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585BF39AB6C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 22:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhFCUDN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 16:03:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53130 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhFCUDK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 16:03:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id B06681F434C8
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v4 12/15] selftests: futex2: Add requeue test
Date:   Thu,  3 Jun 2021 16:59:21 -0300
Message-Id: <20210603195924.361327-13-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603195924.361327-1-andrealmeid@collabora.com>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add testing for futex_requeue(). The first test just requeue from one
waiter to another one, and wake it. The second performs both wake and
requeue, and we check return values to see if the operation
woke/requeued the expected number of waiters.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../futex/functional/futex2_requeue.c         | 164 ++++++++++++++++++
 .../selftests/futex/include/futex2test.h      |  16 ++
 4 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex2_requeue.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index d0b8f637b786..af7557e821da 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -8,3 +8,4 @@ futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex2_wait
 futex2_waitv
+futex2_requeue
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index b857b9450507..ec0e713f0e42 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -17,7 +17,8 @@ TEST_GEN_FILES := \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file \
 	futex2_wait \
-	futex2_waitv
+	futex2_waitv \
+	futex2_requeue
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex2_requeue.c b/tools/testing/selftests/futex/functional/futex2_requeue.c
new file mode 100644
index 000000000000..5b3d0775af99
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex2_requeue.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/******************************************************************************
+ *
+ *   Copyright Collabora Ltd., 2021
+ *
+ * DESCRIPTION
+ *	Test requeue mechanism of futex2, using 32bit sized futexes.
+ *
+ * AUTHOR
+ *	André Almeida <andrealmeid@collabora.com>
+ *
+ * HISTORY
+ *      2021-Feb-5: Initial version by André <andrealmeid@collabora.com>
+ *
+ *****************************************************************************/
+
+#include <errno.h>
+#include <error.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <pthread.h>
+#include <sys/shm.h>
+#include <limits.h>
+#include "futex2test.h"
+#include "logging.h"
+
+#define TEST_NAME "futex2-wait"
+#define timeout_ns  30000000
+#define WAKE_WAIT_US 10000
+volatile futex_t *f1;
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -c	Use color\n");
+	printf("  -h	Display this help message\n");
+	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+}
+
+void *waiterfn(void *arg)
+{
+	struct timespec64 to64;
+
+	/* setting absolute timeout for futex2 */
+	if (gettime64(CLOCK_MONOTONIC, &to64))
+		error("gettime64 failed\n", errno);
+
+	to64.tv_nsec += timeout_ns;
+
+	if (to64.tv_nsec >= 1000000000) {
+		to64.tv_sec++;
+		to64.tv_nsec -= 1000000000;
+	}
+
+	if (futex2_wait(f1, *f1, FUTEX_32, &to64))
+		printf("waiter failed errno %d\n", errno);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	pthread_t waiter[10];
+	int res, ret = RET_PASS;
+	int c, i;
+	volatile futex_t _f1 = 0;
+	volatile futex_t f2 = 0;
+	struct futex_requeue r1, r2;
+
+	f1 = &_f1;
+
+	r1.flags = FUTEX_32;
+	r2.flags = FUTEX_32;
+
+	r1.uaddr = f1;
+	r2.uaddr = &f2;
+
+	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
+		switch (c) {
+		case 'c':
+			log_color(1);
+			break;
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'v':
+			log_verbosity(atoi(optarg));
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	ksft_print_header();
+	ksft_set_plan(2);
+	ksft_print_msg("%s: Test FUTEX2_REQUEUE\n",
+		       basename(argv[0]));
+
+	/*
+	 * Requeue a waiter from f1 to f2, and wake f2.
+	 */
+	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	res = futex2_requeue(&r1, &r2, 0, 1, 0, 0);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_requeue private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	}
+
+
+	info("Calling private futex2_wake on f2: %u @ %p with val=%u\n", f2, &f2, f2);
+	res = futex2_wake(&f2, 1, FUTEX_32);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_requeue private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_requeue simple\n");
+	}
+
+
+	/*
+	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
+	 * At futex_wake, wake INT_MAX (should be exaclty 7).
+	 */
+	for (i = 0; i < 10; i++) {
+		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
+	}
+
+	usleep(WAKE_WAIT_US);
+
+	res = futex2_requeue(&r1, &r2, 3, 7, 0, 0);
+	if (res != 10) {
+		ksft_test_result_fail("futex2_requeue private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	}
+
+	res = futex2_wake(&f2, INT_MAX, FUTEX_32);
+	if (res != 7) {
+		ksft_test_result_fail("futex2_requeue private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_requeue\n");
+	}
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index 0ed3b20935be..b9879f1e0523 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -94,3 +94,19 @@ static inline int futex2_waitv(volatile struct futex_waitv *waiters, unsigned lo
 {
 	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo);
 }
+
+/**
+ * futex2_requeue - Wake futexes at uaddr1 and requeue from uaddr1 to uaddr2
+ * @uaddr1:     Original address to wake and requeue from
+ * @uaddr2:     Address to requeue to
+ * @nr_wake:    Number of futexes to wake at uaddr1 before requeuing
+ * @nr_requeue: Number of futexes to requeue from uaddr1 to uaddr2
+ * @cmpval:     If (uaddr1->uaddr != cmpval), return immediatally
+ * @flgas:      Operation flags
+ */
+static inline int futex2_requeue(struct futex_requeue *uaddr1, struct futex_requeue *uaddr2,
+				 unsigned int nr_wake, unsigned int nr_requeue,
+				 unsigned int cmpval, unsigned long flags)
+{
+	return syscall(__NR_futex_requeue, uaddr1, uaddr2, nr_wake, nr_requeue, cmpval, flags);
+}
-- 
2.31.1

