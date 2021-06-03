Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68939AB63
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCUDA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 16:03:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53060 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFCUC6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 16:02:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C50071F43475
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
Subject: [PATCH v4 10/15] selftests: futex2: Add wouldblock test
Date:   Thu,  3 Jun 2021 16:59:19 -0300
Message-Id: <20210603195924.361327-11-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603195924.361327-1-andrealmeid@collabora.com>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adapt existing futex wait wouldblock file to test the same mechanism for
futex2.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_wouldblock.c  | 33 ++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 0ae390ff8164..510a98320248 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -12,6 +12,7 @@
  *
  * HISTORY
  *      2009-Nov-14: Initial version by Gowrishankar <gowrishankar.m@in.ibm.com>
+ *      2021-Feb-5: Add futex2 test by André <andrealmeid@collabora.com>
  *
  *****************************************************************************/
 
@@ -21,7 +22,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "futextest.h"
+#include "futex2test.h"
 #include "logging.h"
 
 #define TEST_NAME "futex-wait-wouldblock"
@@ -39,6 +40,7 @@ void usage(char *prog)
 int main(int argc, char *argv[])
 {
 	struct timespec to = {.tv_sec = 0, .tv_nsec = timeout_ns};
+	struct timespec64 to64;
 	futex_t f1 = FUTEX_INITIALIZER;
 	int res, ret = RET_PASS;
 	int c;
@@ -61,18 +63,41 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
 
 	info("Calling futex_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
 	res = futex_wait(&f1, f1+1, &to, FUTEX_PRIVATE_FLAG);
 	if (!res || errno != EWOULDBLOCK) {
-		fail("futex_wait returned: %d %s\n",
+		ksft_test_result_fail("futex_wait returned: %d %s\n",
 		     res ? errno : res, res ? strerror(errno) : "");
 		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wait wouldblock\n");
 	}
 
-	print_result(TEST_NAME, ret);
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
+	info("Calling futex2_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
+	res = futex2_wait(&f1, f1+1, FUTEX_32, &to64);
+	if (!res || errno != EWOULDBLOCK) {
+		ksft_test_result_fail("futex2_wait returned: %d %s\n",
+		     res ? errno : res, res ? strerror(errno) : "");
+		ret = RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex2_wait wouldblock\n");
+	}
+
+	ksft_print_cnts();
 	return ret;
 }
-- 
2.31.1

