Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16FF3C1C84
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhGIARb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 20:17:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44886 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhGIARa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 20:17:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 34CB71F41BA9
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
        Nicholas Piggin <npiggin@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v5 08/11] selftests: futex2: Add waitv test
Date:   Thu,  8 Jul 2021 21:13:25 -0300
Message-Id: <20210709001328.329716-9-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709001328.329716-1-andrealmeid@collabora.com>
References: <20210709001328.329716-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create a new file to test the waitv mechanism. Test both private and
shared futexes. Wake the last futex in the array, and check if the
return value from futex_waitv() is the right index.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/futex2_waitv.c | 154 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  17 ++
 5 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex2_waitv.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 3e2d577c0595..22c572de8d10 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -9,3 +9,4 @@ futex_wait_wouldblock
 futex_wait
 futex_requeue
 futex2_wait
+futex2_waitv
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index e4e4aa2e0368..240b53d8cb07 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -19,7 +19,8 @@ TEST_GEN_FILES := \
 	futex_wait_private_mapped_file \
 	futex_wait \
 	futex_requeue \
-	futex2_wait
+	futex2_wait \
+	futex2_waitv
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex2_waitv.c b/tools/testing/selftests/futex/functional/futex2_waitv.c
new file mode 100644
index 000000000000..0f625a0657d5
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex2_waitv.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/******************************************************************************
+ *
+ *   Copyright Collabora Ltd., 2021
+ *
+ * DESCRIPTION
+ *	Test waitv/wake mechanism of futex2, using 32bit sized futexes.
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
+#include "futex2test.h"
+#include "logging.h"
+
+#define TEST_NAME "futex2-wait"
+#define WAKE_WAIT_US 10000
+#define NR_FUTEXES 30
+struct futex_waitv waitv[NR_FUTEXES];
+u_int32_t futexes[NR_FUTEXES] = {0};
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
+	int res;
+
+	/* setting absolute timeout for futex2 */
+	if (gettime64(CLOCK_MONOTONIC, &to64))
+		error("gettime64 failed\n", errno);
+
+	to64.tv_sec++;
+
+	res = futex2_waitv(waitv, NR_FUTEXES, 0, &to64);
+	if (res < 0) {
+		ksft_test_result_fail("futex2_waitv returned: %d %s\n",
+				      errno, strerror(errno));
+	} else if (res != NR_FUTEXES - 1) {
+		ksft_test_result_fail("futex2_waitv returned: %d, expecting %d\n",
+				      res, NR_FUTEXES - 1);
+	}
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	pthread_t waiter;
+	int res, ret = RET_PASS;
+	int c, i;
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
+	ksft_print_msg("%s: Test FUTEX2_WAITV\n",
+		       basename(argv[0]));
+
+	for (i = 0; i < NR_FUTEXES; i++) {
+		waitv[i].uaddr = &futexes[i];
+		waitv[i].flags = FUTEX_32;
+		waitv[i].val = 0;
+	}
+
+	/* Private waitv */
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	res = futex2_wake(waitv[NR_FUTEXES - 1].uaddr, 1, FUTEX_32);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_waitv private returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_waitv private\n");
+	}
+
+	/* Shared waitv */
+	for (i = 0; i < NR_FUTEXES; i++) {
+		int shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+
+		if (shm_id < 0) {
+			perror("shmget");
+			exit(1);
+		}
+
+		unsigned int *shared_data = shmat(shm_id, NULL, 0);
+
+		*shared_data = 0;
+		waitv[i].uaddr = shared_data;
+		waitv[i].flags = FUTEX_32 | FUTEX_SHARED_FLAG;
+		waitv[i].val = 0;
+	}
+
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	res = futex2_wake(waitv[NR_FUTEXES - 1].uaddr, 1, FUTEX_32 | FUTEX_SHARED_FLAG);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_waitv shared returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_waitv shared\n");
+	}
+
+	for (i = 0; i < NR_FUTEXES; i++)
+		shmdt(waitv[i].uaddr);
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index dbe82275617c..6d30a30547da 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -82,3 +82,6 @@ echo
 
 echo
 ./futex2_wait $COLOR
+
+echo
+./futex2_waitv $COLOR
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index e724d56b917e..0ed3b20935be 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -28,6 +28,10 @@
 # define FUTEX_32	2
 #endif
 
+#ifndef FUTEX_SHARED_FLAG
+#define FUTEX_SHARED_FLAG 8
+#endif
+
 /*
  * - Y2038 section for 32-bit applications -
  *
@@ -77,3 +81,16 @@ static inline int futex2_wake(volatile void *uaddr, unsigned int nr, unsigned lo
 {
 	return syscall(__NR_futex_wake, uaddr, nr, flags);
 }
+
+/**
+ * futex2_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int futex2_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
+			      unsigned long flags, struct timespec64 *timo)
+{
+	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo);
+}
-- 
2.32.0

