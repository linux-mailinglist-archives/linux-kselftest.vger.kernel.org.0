Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B1E39AB6F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFCUDR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 16:03:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53154 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhFCUDQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 16:03:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 982901F434D2
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
Subject: [PATCH v4 13/15] selftests: futex2: Add futex sizes test
Date:   Thu,  3 Jun 2021 16:59:22 -0300
Message-Id: <20210603195924.361327-14-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603195924.361327-1-andrealmeid@collabora.com>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a selftest for the variable size futex2 API. This initial test
just validates the basic (and correct) case, where both uses the same
size and the value is in the correct range.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/futex2_sizes.c | 146 ++++++++++++++++++
 .../selftests/futex/include/futex2test.h      |   3 +-
 4 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex2_sizes.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index af7557e821da..9e5d9c5a5510 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -9,3 +9,4 @@ futex_wait_wouldblock
 futex2_wait
 futex2_waitv
 futex2_requeue
+futex2_sizes
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index ec0e713f0e42..9b4fb89eeb14 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -18,7 +18,8 @@ TEST_GEN_FILES := \
 	futex_wait_private_mapped_file \
 	futex2_wait \
 	futex2_waitv \
-	futex2_requeue
+	futex2_requeue \
+	futex2_sizes
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex2_sizes.c b/tools/testing/selftests/futex/functional/futex2_sizes.c
new file mode 100644
index 000000000000..ee5fa48bff91
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex2_sizes.c
@@ -0,0 +1,146 @@
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
+#include <string.h>
+#include "futex2test.h"
+#include "logging.h"
+
+#define TEST_NAME "futex2-sizes"
+
+#define futex8  uint8_t
+#define futex16 uint16_t
+#define futex32 uint32_t
+#define futex64 uint64_t
+
+// edge case values, to test sizes
+#define VALUE16 257        // 2^8  + 1
+#define VALUE32 65537      // 2^16 + 1
+#define VALUE64 4294967297 // 2^32 + 1
+
+#define WAKE_WAIT_US 100000
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
+struct futex {
+	unsigned long flags;
+	unsigned long val;
+};
+
+void *waiterfn(void *arg)
+{
+	int ret;
+	unsigned int *flags = (unsigned int *) arg;
+
+	ret = futex2_wait(futex, 0, *flags, NULL);
+	if (ret == ERROR)
+		error("waiter failed %d errno %d\n", ret, errno);
+
+	return NULL;
+}
+
+/*
+ * create a thread to wait, then wake it
+ */
+void test_single_waiter(unsigned int flags, int *ret)
+{
+	pthread_t waiter;
+	int res;
+
+	pthread_create(&waiter, NULL, waiterfn, &flags);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling futex2_wake at addr %p flags %u\n", futex, flags);
+	res = futex2_wake(futex, 1, flags);
+	if (res == 1) {
+		ksft_test_result_pass("futex2_sizes\n");
+	} else {
+		ksft_test_result_fail("futex2_sizes returned: %d %s\n",
+				      errno, strerror(errno));
+		*ret = RET_FAIL;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int res, ret = RET_PASS, fd, c, shm_id;
+	u_int32_t f_private = 0;
+	pthread_t waiter;
+
+	futex8  f8 = 0;
+	futex16 f16 = 0;
+	futex32 f32 = 0;
+	futex64 f64 = 0;
+	unsigned int flags = 0;
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
+	ksft_set_plan(4);
+	ksft_print_msg("%s: Test FUTEX2_SIZES\n", basename(argv[0]));
+
+	info("Calling futex2_wait futex: %p\n", futex);
+	futex = &f8;
+	flags = FUTEX_8;
+	test_single_waiter(flags, &ret);
+
+	futex = &f16;
+	flags = FUTEX_16;
+	test_single_waiter(flags, &ret);
+
+	futex = &f32;
+	flags = FUTEX_32;
+	test_single_waiter(flags, &ret);
+
+	futex = &f64;
+	flags = FUTEX_64;
+	test_single_waiter(flags, &ret);
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index b9879f1e0523..af11fd191112 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -15,6 +15,7 @@
  *****************************************************************************/
 #include "futextest.h"
 #include <stdio.h>
+#include <stdint.h>
 
 #define NSEC_PER_SEC	1000000000L
 
@@ -65,7 +66,7 @@ int gettime64(clock_t clockid, struct timespec64 *tv)
  * @flags: Operation flags
  * @timo:  Optional timeout for operation
  */
-static inline int futex2_wait(volatile void *uaddr, unsigned long val,
+static inline int futex2_wait(volatile void *uaddr, uint64_t val,
 			      unsigned long flags, struct timespec64 *timo)
 {
 	return syscall(__NR_futex_wait, uaddr, val, flags, timo);
-- 
2.31.1

