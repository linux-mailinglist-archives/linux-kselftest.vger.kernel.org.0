Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4BC36CF64
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 01:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbhD0XQ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 19:16:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36942 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbhD0XQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 19:16:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 589E11F426B6
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
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 07/13] selftests: futex2: Add wake/wait test
Date:   Tue, 27 Apr 2021 20:12:42 -0300
Message-Id: <20210427231248.220501-8-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427231248.220501-1-andrealmeid@collabora.com>
References: <20210427231248.220501-1-andrealmeid@collabora.com>
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
index 0efcd494daab..d61f1df94360 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -6,3 +6,4 @@ futex_wait_private_mapped_file
 futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
+futex2_wait
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 23207829ec75..7142a94a7ac3 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -5,6 +5,7 @@ LDLIBS := -lpthread -lrt
 
 HEADERS := \
 	../include/futextest.h \
+	../include/futex2test.h \
 	../include/atomic.h \
 	../include/logging.h
 TEST_GEN_FILES := \
@@ -14,7 +15,8 @@ TEST_GEN_FILES := \
 	futex_requeue_pi_signal_restart \
 	futex_requeue_pi_mismatched_ops \
 	futex_wait_uninitialized_heap \
-	futex_wait_private_mapped_file
+	futex_wait_private_mapped_file \
+	futex2_wait
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex2_wait.c b/tools/testing/selftests/futex/functional/futex2_wait.c
new file mode 100644
index 000000000000..7f5516369ade
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
+		ksft_test_result_pass("futex2_wake private succeeds\n");
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
+		ksft_test_result_pass("futex2_wake shared (page anon) succeeds\n");
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
+		ksft_test_result_pass("futex2_wake shared (file backed) succeeds\n");
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
index 1acb6ace1680..3730159c865a 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -73,3 +73,6 @@ echo
 echo
 ./futex_wait_uninitialized_heap $COLOR
 ./futex_wait_private_mapped_file $COLOR
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
2.31.1

