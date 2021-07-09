Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB253C1C7E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhGIARR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 20:17:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44816 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhGIARQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 20:17:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 5207F1F4198C
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
Subject: [PATCH v5 06/11] selftests: futex2: Add timeout test
Date:   Thu,  8 Jul 2021 21:13:23 -0300
Message-Id: <20210709001328.329716-7-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709001328.329716-1-andrealmeid@collabora.com>
References: <20210709001328.329716-1-andrealmeid@collabora.com>
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
 .../futex/functional/futex_wait_timeout.c     | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 1f8f6daaf1e7..d20f54745c2e 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -17,6 +17,14 @@
 
 #include <pthread.h>
 #include "futextest.h"
+
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include "futex2test.h"
 #include "logging.h"
 
 #define TEST_NAME "futex-wait-timeout"
@@ -92,8 +100,8 @@ static int futex_get_abs_timeout(clockid_t clockid, struct timespec *to,
 int main(int argc, char *argv[])
 {
 	futex_t f1 = FUTEX_INITIALIZER;
+	struct timespec to = {.tv_sec = 0, .tv_nsec = timeout_ns};
 	int res, ret = RET_PASS;
-	struct timespec to;
 	pthread_t thread;
 	int c;
 
@@ -118,7 +126,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(7);
+	ksft_set_plan(9);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
@@ -175,6 +183,18 @@ int main(int argc, char *argv[])
 	res = futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
 	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
 
+	/* setting absolute monotonic timeout for futex2 */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex2_wait(&f1, f1, FUTEX_32, &to);
+	test_timeout(res, &ret, "futex2_wait monotonic", ETIMEDOUT);
+
+	/* setting absolute realtime timeout for futex2 */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex2_wait(&f1, f1, FUTEX_32 | FUTEX_CLOCK_REALTIME, &to);
+	test_timeout(res, &ret, "futex2_wait realtime", ETIMEDOUT);
+
 	ksft_print_cnts();
 	return ret;
 }
-- 
2.32.0

