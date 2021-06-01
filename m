Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15A039660C
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 May 2021 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhEaQzq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 May 2021 12:55:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40274 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhEaQx1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 May 2021 12:53:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 5FBCE1F41FD2
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, dave@stgolabs.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/2] selftests: futex: Add futex compare requeue test
Date:   Mon, 31 May 2021 13:50:36 -0300
Message-Id: <20210531165036.41468-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531165036.41468-1-andrealmeid@collabora.com>
References: <20210531165036.41468-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add testing for futex_cmp_requeue(). The first test just requeue from one
waiter to another one, and wake it. The second performs both wake and
requeue, and we check return values to see if the operation
woke/requeued the expected number of waiters.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../futex/functional/futex_requeue.c          | 136 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_requeue.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index bd24699bacc9..0e78b49d0f2f 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -7,3 +7,4 @@ futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_wait
+futex_requeue
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 20a5b4a1bc87..bd1fec59e010 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -16,7 +16,8 @@ TEST_GEN_FILES := \
 	futex_requeue_pi_mismatched_ops \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file \
-	futex_wait
+	futex_wait \
+	futex_requeue
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
new file mode 100644
index 000000000000..51485be6eb2f
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright Collabora Ltd., 2021
+ *
+ * futex cmp requeue test by André Almeida <andrealmeid@collabora.com>
+ */
+
+#include <pthread.h>
+#include <limits.h>
+#include "logging.h"
+#include "futextest.h"
+
+#define TEST_NAME "futex-requeue"
+#define timeout_ns  30000000
+#define WAKE_WAIT_US 10000
+
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
+	struct timespec to;
+
+	to.tv_sec = 0;
+	to.tv_nsec = timeout_ns;
+
+	if (futex_wait(f1, *f1, &to, 0))
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
+
+	f1 = &_f1;
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
+	ksft_print_msg("%s: Test futex_requeue\n",
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
+	info("Requeuing 1 futex from f1 to f2\n");
+	res = futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
+	if (res != 1) {
+		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	}
+
+
+	info("Waking 1 futex at f2\n");
+	res = futex_wake(&f2, 1, 0);
+	if (res != 1) {
+		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_requeue simple succeeds\n");
+	}
+
+
+	/*
+	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
+	 * At futex_wake, wake INT_MAX (should be exactly 7).
+	 */
+	for (i = 0; i < 10; i++) {
+		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
+	}
+
+	usleep(WAKE_WAIT_US);
+
+	info("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
+	res = futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
+	if (res != 10) {
+		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	}
+
+	info("Waking INT_MAX futexes at f2\n");
+	res = futex_wake(&f2, INT_MAX, 0);
+	if (res != 7) {
+		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_requeue many succeeds\n");
+	}
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index d5e1430bcdca..11a9d62290f5 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -76,3 +76,6 @@ echo
 
 echo
 ./futex_wait $COLOR
+
+echo
+./futex_requeue $COLOR
-- 
2.31.1

