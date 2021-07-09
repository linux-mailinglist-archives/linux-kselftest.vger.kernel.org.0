Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7073C1C7B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 02:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGIARM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 20:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhGIARK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 20:17:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2AC061760;
        Thu,  8 Jul 2021 17:14:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id BBDC01F4186C
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
Subject: [PATCH v5 05/11] selftests: futex2: Add wake/wait test
Date:   Thu,  8 Jul 2021 21:13:22 -0300
Message-Id: <20210709001328.329716-6-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709001328.329716-1-andrealmeid@collabora.com>
References: <20210709001328.329716-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple file to test wake/wait mechanism using futex2 interface.
Test three scenarios: using a common local int variable as private
futex, a shm futex as shared futex and a file-backed shared memory as a
shared futex. This should test all branches of futex_get_key().

Create helper files so more tests can evaluate futex2. While 32bit ABIs
from glibc aren't yet able to use 64 bit sized time variables, add a
temporary workaround that implements the required types and calls the
appropriated syscalls, since futex2 doesn't supports 32 bit sized time.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   4 +-
 .../selftests/futex/functional/futex2_wait.c  | 195 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  79 +++++++
 5 files changed, 281 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex2_wait.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 0e78b49d0f2f..3e2d577c0595 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -8,3 +8,4 @@ futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_wait
 futex_requeue
+futex2_wait
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index bd1fec59e010..e4e4aa2e0368 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -6,6 +6,7 @@ LDLIBS := -lpthread -lrt
 
 HEADERS := \
 	../include/futextest.h \
+	../include/futex2test.h \
 	../include/atomic.h \
 	../include/logging.h
 TEST_GEN_FILES := \
@@ -17,7 +18,8 @@ TEST_GEN_FILES := \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file \
 	futex_wait \
-	futex_requeue
+	futex_requeue \
+	futex2_wait
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex2_wait.c b/tools/testing/selftests/futex/functional/futex2_wait.c
new file mode 100644
index 000000000000..25ac6d0898f5
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex2_wait.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/******************************************************************************
+ *
+ *   Copyright Collabora Ltd., 2021
+ *
+ * DESCRIPTION
+ *	Test wait/wake mechanism of futex2, using 32bit sized futexes.
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
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <string.h>
+#include "futex2test.h"
+#include "logging.h"
+
+#define TEST_NAME "futex2-wait"
+#define timeout_ns  30000000
+#define WAKE_WAIT_US 10000
+#define SHM_PATH "futex2_shm_file"
+
+void *futex;
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
+static void *waiterfn(void *arg)
+{
+	struct timespec64 to64;
+	unsigned int flags = 0;
+
+	if (arg)
+		flags = *((unsigned int *) arg);
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
+	if (futex2_wait(futex, 0, FUTEX_32 | flags, &to64))
+		printf("waiter failed errno %d\n", errno);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int flags = FUTEX_SHARED_FLAG;
+	int res, ret = RET_PASS, fd, c, shm_id;
+	u_int32_t f_private = 0, *shared_data;
+	pthread_t waiter;
+	void *shm;
+
+	futex = &f_private;
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
+	ksft_set_plan(3);
+	ksft_print_msg("%s: Test FUTEX2_WAIT\n", basename(argv[0]));
+
+	/* Testing a private futex */
+	info("Calling private futex2_wait on futex: %p\n", futex);
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling private futex2_wake on futex: %p\n", futex);
+	res = futex2_wake(futex, 1, FUTEX_32);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_wake private returned: %d %s\n",
+				      errno, strerror(errno));
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wake private\n");
+	}
+
+	/* Testing an anon page shared memory */
+	shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+	if (shm_id < 0) {
+		perror("shmget");
+		exit(1);
+	}
+
+	shared_data = shmat(shm_id, NULL, 0);
+
+	*shared_data = 0;
+	futex = shared_data;
+
+	info("Calling (page anon) shared futex2_wait on futex: %p\n", futex);
+	if (pthread_create(&waiter, NULL, waiterfn, &flags))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling (page anon) shared futex2_wake on futex: %p\n", futex);
+	res = futex2_wake(futex, 1, FUTEX_32 | FUTEX_SHARED_FLAG);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_wake shared (page anon) returned: %d %s\n",
+				      errno, strerror(errno));
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wake shared (page anon)\n");
+	}
+
+
+	/* Testing a file backed shared memory */
+	fd = open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	if (ftruncate(fd, sizeof(f_private))) {
+		perror("ftruncate");
+		exit(1);
+	}
+
+	shm = mmap(NULL, sizeof(f_private), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (shm == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	memcpy(shm, &f_private, sizeof(f_private));
+
+	futex = shm;
+
+	info("Calling shared (file backed) futex2_wait on futex: %p\n", futex);
+	if (pthread_create(&waiter, NULL, waiterfn, &flags))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling shared (file backed) futex2_wake on futex: %p\n", futex);
+	res = futex2_wake(shm, 1, FUTEX_32 | FUTEX_SHARED_FLAG);
+	if (res != 1) {
+		ksft_test_result_fail("futex2_wake shared (file backed) returned: %d %s\n",
+				      errno, strerror(errno));
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wake shared (file backed)\n");
+	}
+
+	/* Freeing resources */
+	shmdt(shared_data);
+	munmap(shm, sizeof(f_private));
+	remove(SHM_PATH);
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 11a9d62290f5..dbe82275617c 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -79,3 +79,6 @@ echo
 
 echo
 ./futex_requeue $COLOR
+
+echo
+./futex2_wait $COLOR
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
new file mode 100644
index 000000000000..e724d56b917e
--- /dev/null
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/******************************************************************************
+ *
+ *   Copyright Collabora Ltd., 2021
+ *
+ * DESCRIPTION
+ *	Futex2 library addons for old futex library
+ *
+ * AUTHOR
+ *	André Almeida <andrealmeid@collabora.com>
+ *
+ * HISTORY
+ *      2021-Feb-5: Initial version by André <andrealmeid@collabora.com>
+ *
+ *****************************************************************************/
+#include "futextest.h"
+#include <stdio.h>
+
+#define NSEC_PER_SEC	1000000000L
+
+#ifndef FUTEX_8
+# define FUTEX_8	0
+#endif
+#ifndef FUTEX_16
+# define FUTEX_16	1
+#endif
+#ifndef FUTEX_32
+# define FUTEX_32	2
+#endif
+
+/*
+ * - Y2038 section for 32-bit applications -
+ *
+ * Remove this when glibc is ready for y2038. Then, always compile with
+ * `-DTIME_BITS=64` or `-D__USE_TIME_BITS64`. glibc will provide both
+ * timespec64 and clock_gettime64 so we won't need to define here.
+ */
+#if defined(__i386__) || __TIMESIZE == 32
+# define NR_gettime __NR_clock_gettime64
+#else
+# define NR_gettime __NR_clock_gettime
+#endif
+
+struct timespec64 {
+	long long tv_sec;	/* seconds */
+	long long tv_nsec;	/* nanoseconds */
+};
+
+int gettime64(clock_t clockid, struct timespec64 *tv)
+{
+	return syscall(NR_gettime, clockid, tv);
+}
+/*
+ * - End of Y2038 section -
+ */
+
+/**
+ * futex2_wait - If (*uaddr == val), wait at uaddr until timo
+ * @uaddr: User address to wait on
+ * @val:   Expected value at uaddr, return if is not equal
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int futex2_wait(volatile void *uaddr, unsigned long val,
+			      unsigned long flags, struct timespec64 *timo)
+{
+	return syscall(__NR_futex_wait, uaddr, val, flags, timo);
+}
+
+/**
+ * futex2_wake - Wake a number of waiters at uaddr
+ * @uaddr: Address to wake
+ * @nr:    Number of waiters to wake
+ * @flags: Operation flags
+ */
+static inline int futex2_wake(volatile void *uaddr, unsigned int nr, unsigned long flags)
+{
+	return syscall(__NR_futex_wake, uaddr, nr, flags);
+}
-- 
2.32.0

