Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3A615CD84
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2020 22:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgBMVs2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Feb 2020 16:48:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37558 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgBMVs1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Feb 2020 16:48:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8BB3229581D
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     kernel@collabora.com, krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, peterz@infradead.org, dvhart@infradead.org,
        mingo@redhat.com, z.figura12@gmail.com, steven@valvesoftware.com,
        pgriffais@valvesoftware.com, steven@liquorix.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 4/4] selftests: futex: Add FUTEX_WAIT_MULTIPLE wake up test
Date:   Thu, 13 Feb 2020 18:45:25 -0300
Message-Id: <20200213214525.183689-5-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213214525.183689-1-andrealmeid@collabora.com>
References: <20200213214525.183689-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Add test for wait at multiple futexes mechanism. Skip the test if it's a
x32 application and the kernel returned the approtiaded error, since this
ABI is not supported for this operation.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Co-developed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes since v2: none
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../futex/functional/futex_wait_multiple.c    | 173 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 4 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_wait_multiple.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index a09f57061902..4660128a545e 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -5,3 +5,4 @@ futex_wait_private_mapped_file
 futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
+futex_wait_multiple
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 30996306cabc..75f9fface11f 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -14,7 +14,8 @@ TEST_GEN_FILES := \
 	futex_requeue_pi_signal_restart \
 	futex_requeue_pi_mismatched_ops \
 	futex_wait_uninitialized_heap \
-	futex_wait_private_mapped_file
+	futex_wait_private_mapped_file \
+	futex_wait_multiple
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex_wait_multiple.c b/tools/testing/selftests/futex/functional/futex_wait_multiple.c
new file mode 100644
index 000000000000..b48422e79f42
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_wait_multiple.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/******************************************************************************
+ *
+ *   Copyright © Collabora, Ltd., 2019
+ *
+ * DESCRIPTION
+ *      Test basic semantics of FUTEX_WAIT_MULTIPLE
+ *
+ * AUTHOR
+ *      Gabriel Krisman Bertazi <krisman@collabora.com>
+ *
+ * HISTORY
+ *      2019-Dec-13: Initial version by Krisman <krisman@collabora.com>
+ *
+ *****************************************************************************/
+
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <pthread.h>
+#include "futextest.h"
+#include "logging.h"
+
+#define TEST_NAME "futex-wait-multiple"
+#define timeout_ns 100000
+#define MAX_COUNT 128
+#define WAKE_WAIT_US 3000000
+
+int ret = RET_PASS;
+char *progname;
+futex_t f[MAX_COUNT] = {0};
+struct futex_wait_block fwb[MAX_COUNT];
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
+void test_count_overflow(void)
+{
+	futex_t f = FUTEX_INITIALIZER;
+	struct futex_wait_block fwb[MAX_COUNT+1];
+	int res, i;
+
+	ksft_print_msg("%s: Test a too big number of futexes\n", progname);
+
+	for (i = 0; i < MAX_COUNT+1; i++) {
+		fwb[i].uaddr = &f;
+		fwb[i].val = f;
+		fwb[i].bitset = 0;
+	}
+
+	res = futex_wait_multiple(fwb, MAX_COUNT+1, NULL, FUTEX_PRIVATE_FLAG);
+
+#ifdef __ILP32__
+	if (res != -1 || errno != ENOSYS) {
+		ksft_test_result_fail("futex_wait_multiple returned %d\n",
+				      res < 0 ? errno : res);
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_skip("futex_wait_multiple not supported at x32\n");
+	}
+#else
+	if (res != -1 || errno != EINVAL) {
+		ksft_test_result_fail("futex_wait_multiple returned %d\n",
+				      res < 0 ? errno : res);
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wait_multiple count overflow succeed\n");
+	}
+
+#endif /* __ILP32__ */
+}
+
+void *waiterfn(void *arg)
+{
+	int res;
+
+	res = futex_wait_multiple(fwb, MAX_COUNT, NULL, FUTEX_PRIVATE_FLAG);
+
+#ifdef __ILP32__
+	if (res != -1 || errno != ENOSYS) {
+		ksft_test_result_fail("futex_wait_multiple returned %d\n",
+				      res < 0 ? errno : res);
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_skip("futex_wait_multiple not supported at x32\n");
+	}
+#else
+	if (res < 0)
+		ksft_print_msg("waiter failed %d\n", res);
+
+	info("futex_wait_multiple: Got hint futex %d was freed\n", res);
+#endif /* __ILP32__ */
+
+	return NULL;
+}
+
+void test_fwb_wakeup(void)
+{
+	int res, i;
+	pthread_t waiter;
+
+	ksft_print_msg("%s: Test wake up in a list of futex\n", progname);
+
+	for (i = 0; i < MAX_COUNT; i++) {
+		fwb[i].uaddr = &f[i];
+		fwb[i].val = f[i];
+		fwb[i].bitset = 0xffffffff;
+	}
+
+	res = pthread_create(&waiter, NULL, waiterfn, NULL);
+	if (res) {
+		ksft_test_result_fail("Creating waiting thread failed");
+		ksft_exit_fail();
+	}
+
+	usleep(WAKE_WAIT_US);
+	res = futex_wake(&(f[MAX_COUNT-1]), 1, FUTEX_PRIVATE_FLAG);
+	if (res != 1) {
+		ksft_test_result_fail("Failed to wake thread res=%d\n", res);
+		ksft_exit_fail();
+	}
+
+	pthread_join(waiter, NULL);
+	ksft_test_result_pass("%s succeed\n", __func__);
+}
+
+int main(int argc, char *argv[])
+{
+	int c;
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
+	progname = basename(argv[0]);
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	test_count_overflow();
+
+#ifdef __ILP32__
+	// if it's a 32x binary, there's no futex to wakeup
+	ksft_test_result_skip("futex_wait_multiple not supported at x32\n");
+#else
+	test_fwb_wakeup();
+#endif /* __ILP32__ */
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 1acb6ace1680..a8be94f28ff7 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -73,3 +73,6 @@ echo
 echo
 ./futex_wait_uninitialized_heap $COLOR
 ./futex_wait_private_mapped_file $COLOR
+
+echo
+./futex_wait_multiple $COLOR
-- 
2.25.0

