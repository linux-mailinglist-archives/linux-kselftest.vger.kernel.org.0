Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9E15CD80
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2020 22:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgBMVsT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Feb 2020 16:48:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37534 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgBMVsT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Feb 2020 16:48:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 50D4C29581C
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     kernel@collabora.com, krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, peterz@infradead.org, dvhart@infradead.org,
        mingo@redhat.com, z.figura12@gmail.com, steven@valvesoftware.com,
        pgriffais@valvesoftware.com, steven@liquorix.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 2/4] selftests: futex: Add FUTEX_WAIT_MULTIPLE timeout test
Date:   Thu, 13 Feb 2020 18:45:23 -0300
Message-Id: <20200213214525.183689-3-andrealmeid@collabora.com>
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

Add test for timeout when waiting for multiple futexes. Skip the test if
it's a x32 application and the kernel returned the approtiaded error,
since this ABI is not supported for this operation.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Co-developed-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes since v2: none
---
 .../futex/functional/futex_wait_timeout.c     | 38 ++++++++++++++++++-
 .../selftests/futex/include/futextest.h       | 22 +++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index ee55e6d389a3..2a63e1c2cfb6 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -11,6 +11,7 @@
  *
  * HISTORY
  *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
+ *      2019-Dec-13: Add WAIT_MULTIPLE test by Krisman <krisman@collabora.com>
  *
  *****************************************************************************/
 
@@ -41,6 +42,8 @@ int main(int argc, char *argv[])
 {
 	futex_t f1 = FUTEX_INITIALIZER;
 	struct timespec to;
+	time_t secs;
+	struct futex_wait_block fwb = {&f1, f1, 0};
 	int res, ret = RET_PASS;
 	int c;
 
@@ -65,7 +68,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
@@ -79,8 +82,39 @@ int main(int argc, char *argv[])
 	if (!res || errno != ETIMEDOUT) {
 		fail("futex_wait returned %d\n", ret < 0 ? errno : ret);
 		ret = RET_FAIL;
+	} else
+		ksft_test_result_pass("futex_wait timeout succeeds\n");
+
+	info("Calling futex_wait_multiple on f1: %u @ %p\n", f1, &f1);
+
+	/* Setup absolute time */
+	ret = clock_gettime(CLOCK_REALTIME, &to);
+	secs = (to.tv_nsec + timeout_ns) / 1000000000;
+	to.tv_nsec = ((int64_t)to.tv_nsec + timeout_ns) % 1000000000;
+	to.tv_sec += secs;
+	info("to.tv_sec  = %ld\n", to.tv_sec);
+	info("to.tv_nsec = %ld\n", to.tv_nsec);
+
+	res = futex_wait_multiple(&fwb, 1, &to,
+				  FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME);
+
+#ifdef __ILP32__
+	if (res == -1 && errno == ENOSYS) {
+		ksft_test_result_skip("futex_wait_multiple not supported at x32\n");
+	} else {
+		ksft_test_result_fail("futex_wait_multiple returned %d\n",
+				      res < 0 ? errno : res);
+		ret = RET_FAIL;
 	}
+#else
+	if (!res || errno != ETIMEDOUT) {
+		ksft_test_result_fail("futex_wait_multiple returned %d\n",
+				      res < 0 ? errno : res);
+		ret = RET_FAIL;
+	} else
+		ksft_test_result_pass("futex_wait_multiple timeout succeeds\n");
+#endif /* __ILP32__ */
 
-	print_result(TEST_NAME, ret);
+	ksft_print_cnts();
 	return ret;
 }
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..bb103bef4557 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -38,6 +38,14 @@ typedef volatile u_int32_t futex_t;
 #ifndef FUTEX_CMP_REQUEUE_PI
 #define FUTEX_CMP_REQUEUE_PI		12
 #endif
+#ifndef FUTEX_WAIT_MULTIPLE
+#define FUTEX_WAIT_MULTIPLE		13
+struct futex_wait_block {
+	futex_t *uaddr;
+	futex_t val;
+	__u32 bitset;
+};
+#endif
 #ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
 #define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
@@ -80,6 +88,20 @@ futex_wait(futex_t *uaddr, futex_t val, struct timespec *timeout, int opflags)
 	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
 }
 
+/**
+ * futex_wait_multiple() - block on several futexes with optional timeout
+ * @fwb:	wait block user space address
+ * @count:	number of entities at fwb
+ * @timeout:	absolute timeout
+ */
+static inline int
+futex_wait_multiple(struct futex_wait_block *fwb, int count,
+		    struct timespec *timeout, int opflags)
+{
+	return futex(fwb, FUTEX_WAIT_MULTIPLE, count, timeout, NULL, 0,
+		     opflags);
+}
+
 /**
  * futex_wake() - wake one or more tasks blocked on uaddr
  * @nr_wake:	wake up to this many tasks
-- 
2.25.0

