Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1AF396608
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 May 2021 18:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhEaQzU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 May 2021 12:55:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40262 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhEaQxT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 May 2021 12:53:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9B9071F41FCD
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, dave@stgolabs.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/2] selftests: futex: Add futex wait test
Date:   Mon, 31 May 2021 13:50:35 -0300
Message-Id: <20210531165036.41468-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531165036.41468-1-andrealmeid@collabora.com>
References: <20210531165036.41468-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are three different strategies to uniquely identify a futex in the
kernel:
 - Private futexes: uses the pointer to mm_struct and the page address
 - Shared futexes: checks if the page containing the address is a PageAnon:
   - If it is, uses the same data as a private futexes
   - If it isn't, uses an inode sequence number from struct inode and
      the page's index

Create a selftest to check those three paths and basic wait/wake
mechanism.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/futex_wait.c   | 171 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 4 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_wait.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 0efcd494daab..bd24699bacc9 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -6,3 +6,4 @@ futex_wait_private_mapped_file
 futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
+futex_wait
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 1d2b3b2a5b86..20a5b4a1bc87 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -15,7 +15,8 @@ TEST_GEN_FILES := \
 	futex_requeue_pi_signal_restart \
 	futex_requeue_pi_mismatched_ops \
 	futex_wait_uninitialized_heap \
-	futex_wait_private_mapped_file
+	futex_wait_private_mapped_file \
+	futex_wait
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
new file mode 100644
index 000000000000..685140d9b93d
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright Collabora Ltd., 2021
+ *
+ * futex cmp requeue test by André Almeida <andrealmeid@collabora.com>
+ */
+
+#include <pthread.h>
+#include <sys/shm.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include "logging.h"
+#include "futextest.h"
+
+#define TEST_NAME "futex-wait"
+#define timeout_ns  30000000
+#define WAKE_WAIT_US 10000
+#define SHM_PATH "futex_shm_file"
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
+	struct timespec to;
+	unsigned int flags = 0;
+
+	if (arg)
+		flags = *((unsigned int *) arg);
+
+	to.tv_sec = 0;
+	to.tv_nsec = timeout_ns;
+
+	if (futex_wait(futex, 0, &to, flags))
+		printf("waiter failed errno %d\n", errno);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	int res, ret = RET_PASS, fd, c, shm_id;
+	u_int32_t f_private = 0, *shared_data;
+	unsigned int flags = FUTEX_PRIVATE_FLAG;
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
+	ksft_print_msg("%s: Test futex_wait\n", basename(argv[0]));
+
+	/* Testing a private futex */
+	info("Calling private futex_wait on futex: %p\n", futex);
+	if (pthread_create(&waiter, NULL, waiterfn, (void *) &flags))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling private futex_wake on futex: %p\n", futex);
+	res = futex_wake(futex, 1, FUTEX_PRIVATE_FLAG);
+	if (res != 1) {
+		ksft_test_result_fail("futex_wake private returned: %d %s\n",
+				      errno, strerror(errno));
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wake private succeeds\n");
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
+	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
+	res = futex_wake(futex, 1, 0);
+	if (res != 1) {
+		ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
+				      errno, strerror(errno));
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
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
+	info("Calling shared (file backed) futex_wait on futex: %p\n", futex);
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling shared (file backed) futex_wake on futex: %p\n", futex);
+	res = futex_wake(shm, 1, 0);
+	if (res != 1) {
+		ksft_test_result_fail("futex_wake shared (file backed) returned: %d %s\n",
+				      errno, strerror(errno));
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wake shared (file backed) succeeds\n");
+	}
+
+	/* Freeing resources */
+	shmdt(shared_data);
+	munmap(shm, sizeof(f_private));
+	remove(SHM_PATH);
+	close(fd);
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 1acb6ace1680..d5e1430bcdca 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -73,3 +73,6 @@ echo
 echo
 ./futex_wait_uninitialized_heap $COLOR
 ./futex_wait_private_mapped_file $COLOR
+
+echo
+./futex_wait $COLOR
-- 
2.31.1

