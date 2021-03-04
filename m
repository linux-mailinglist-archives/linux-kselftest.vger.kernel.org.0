Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE18B32C8E4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Mar 2021 02:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhCDA6A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Mar 2021 19:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453070AbhCDAoZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Mar 2021 19:44:25 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DC9C061764;
        Wed,  3 Mar 2021 16:43:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 0567D1F46043
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
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH v2 08/13] selftests: futex2: Add timeout test
Date:   Wed,  3 Mar 2021 21:42:14 -0300
Message-Id: <20210304004219.134051-9-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304004219.134051-1-andrealmeid@collabora.com>
References: <20210304004219.134051-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adapt existing futex wait timeout file to test the same mechanism for
futex2. futex2 accepts only absolute 64bit timers, but supports both
monotonic and realtime clocks.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_timeout.c     | 58 ++++++++++++++++---
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index ee55e6d389a3..b4dffe9e3b44 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -11,6 +11,7 @@
  *
  * HISTORY
  *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
+ *      2021-Feb-5: Add futex2 test by André <andrealmeid@collabora.com>
  *
  *****************************************************************************/
 
@@ -20,7 +21,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "futextest.h"
+#include "futex2test.h"
 #include "logging.h"
 
 #define TEST_NAME "futex-wait-timeout"
@@ -40,7 +41,8 @@ void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	futex_t f1 = FUTEX_INITIALIZER;
-	struct timespec to;
+	struct timespec to = {.tv_sec = 0, .tv_nsec = timeout_ns};
+	struct timespec64 to64;
 	int res, ret = RET_PASS;
 	int c;
 
@@ -65,22 +67,60 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(3);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
 
-	/* initialize timeout */
-	to.tv_sec = 0;
-	to.tv_nsec = timeout_ns;
-
 	info("Calling futex_wait on f1: %u @ %p\n", f1, &f1);
 	res = futex_wait(&f1, f1, &to, FUTEX_PRIVATE_FLAG);
 	if (!res || errno != ETIMEDOUT) {
-		fail("futex_wait returned %d\n", ret < 0 ? errno : ret);
+		ksft_test_result_fail("futex_wait returned %d\n", ret < 0 ? errno : ret);
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wait timeout succeeds\n");
+	}
+
+	/* setting absolute monotonic timeout for futex2 */
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
+	info("Calling futex2_wait on f1: %u @ %p\n", f1, &f1);
+	res = futex2_wait(&f1, f1, FUTEX_32, &to64);
+	if (!res || errno != ETIMEDOUT) {
+		ksft_test_result_fail("futex2_wait monotonic returned %d\n", ret < 0 ? errno : ret);
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wait monotonic timeout succeeds\n");
+	}
+
+	/* setting absolute realtime timeout for futex2 */
+	if (gettime64(CLOCK_REALTIME, &to64))
+		error("gettime64 failed\n", errno);
+
+	to64.tv_nsec += timeout_ns;
+
+	if (to64.tv_nsec >= 1000000000) {
+		to64.tv_sec++;
+		to64.tv_nsec -= 1000000000;
+	}
+
+	info("Calling futex2_wait on f1: %u @ %p\n", f1, &f1);
+	res = futex2_wait(&f1, f1, FUTEX_32 | FUTEX_CLOCK_REALTIME, &to64);
+	if (!res || errno != ETIMEDOUT) {
+		ksft_test_result_fail("futex2_wait realtime returned %d\n", ret < 0 ? errno : ret);
 		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wait realtime timeout succeeds\n");
 	}
 
-	print_result(TEST_NAME, ret);
+	ksft_print_cnts();
 	return ret;
 }
-- 
2.30.1

