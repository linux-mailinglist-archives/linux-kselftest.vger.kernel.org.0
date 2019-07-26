Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC676EEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2019 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfGZQWe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jul 2019 12:22:34 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37103 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfGZQWe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jul 2019 12:22:34 -0400
Received: by mail-pl1-f201.google.com with SMTP id n4so28201601plp.4
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2019 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lPOpgqHnscdwzLGtC0H1Ixwb+B+NAOxyqgNtT/tbhC8=;
        b=F4aIvxS/xG+ArYWWgs9p5OW3h6Ysy911syFIR4ahzJKxhX5vtAkkF7lgL9AVuhNuKA
         vGsqO0mxxT0UwIisuM9tG/GSMfBO5M0qB1OOOP1rIhIB13JcZcpU402EpxPrgSt2w9Po
         0nhzft0hVquavaHsMph5/v8pUDeXegkxdSX0/bo4wrOmpVq/+EgcrXDvYqw6DrfRg3d3
         8tzRhZ/eWISrO4py4GGx1YwBnPyqzsGSdAU7n6/eG6uEGT22aYQ4Wxxw8/FebDyE3Fxp
         Bnx+OSteztSCR/JMHtQVvrUb784u7YobfmhceKH3H3E0iWJAN5gx1tHqMrbgKM5SlxGG
         ytAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lPOpgqHnscdwzLGtC0H1Ixwb+B+NAOxyqgNtT/tbhC8=;
        b=qzniOYkDeaEPNeu2rRFg7hlibfUIoNTSDu7qlgaKyXGcFE0l/8x99tSjz2rNNgTpBL
         X8+l4D0ZV8dcm3LRFLNLnPFZjCHTSZsfp/YatIFqfgZJvqoM44TeOUZOLyJ97hjltmI8
         /4F1wlTHAdrAHacXsI9PxdDnPqwIc1HO9TNvza1PRdIIz1fmJWniSgOJpz/fUKSYljLu
         sDDMXU+JXaXspjO0GST4aNQQyOA6hburYZumwuhXy2c35mkRKSkZdMBfSVPWGtK4Wa7f
         pGQeatj2CsU4mKpSe1bQD5BUD8yGDKtE+RhzUEIHNZolyjsNzKccqLT+pZvBUYJuWDOr
         yM0A==
X-Gm-Message-State: APjAAAUZUw9tuBsDMeTIDd5R4MAOrmAcbfwGCQWKF3vZ6vtemTpgKNxN
        v3U7+guX3XK2U3x4674g/6n93/pNmN4=
X-Google-Smtp-Source: APXvYqweliflgWhX3WB84ijGbSSbRjjNArh+t7qP7CvGNxSJEHL3aYOnPpXzOC/3A0B1KYVKh6Bw5Pien4k=
X-Received: by 2002:a63:e213:: with SMTP id q19mr90893338pgh.180.1564158153637;
 Fri, 26 Jul 2019 09:22:33 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:22:26 -0700
In-Reply-To: <20190726162226.252750-1-surenb@google.com>
Message-Id: <20190726162226.252750-2-surenb@google.com>
Mime-Version: 1.0
References: <20190726162226.252750-1-surenb@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v3 2/2] tests: add pidfd poll tests
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     christian@brauner.io, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, dancol@google.com,
        tglx@linutronix.de, jannh@google.com, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds testing for polling on pidfd of a process being killed. Test runs
10000 iterations by default to stress test pidfd polling functionality.
It accepts an optional command-line parameter to override the number or
iterations to run.
Specifically, it tests for:
- pidfd_open on a child process succeeds
- pidfd_send_signal on a child process succeeds
- polling on pidfd succeeds and returns exactly one event
- returned event is POLLIN
- event is received within 3 secs of the process being killed

10000 iterations was chosen because of the race condition being tested
which is not consistently reproducible but usually is revealed after less
than 2000 iterations.
Reveals race fixed by commit b191d6491be6 ("pidfd: fix a poll race when setting exit_state")

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 .../testing/selftests/pidfd/pidfd_poll_test.c | 117 ++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_poll_test.c

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index 16d84d117bc0..a67896347d34 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -1,2 +1,3 @@
 pidfd_open_test
+pidfd_poll_test
 pidfd_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 720b2d884b3c..ed58b7108d18 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g -I../../../../usr/include/ -lpthread
 
-TEST_GEN_PROGS := pidfd_test pidfd_open_test
+TEST_GEN_PROGS := pidfd_test pidfd_open_test pidfd_poll_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
new file mode 100644
index 000000000000..f1b62b91e53e
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+
+static bool timeout;
+
+static void handle_alarm(int sig)
+{
+	timeout = true;
+}
+
+int main(int argc, char **argv)
+{
+	struct pollfd fds;
+	int iter, nevents;
+	int nr_iterations = 10000;
+
+	fds.events = POLLIN;
+
+	if (argc > 2)
+		ksft_exit_fail_msg("Unexpected command line argument\n");
+
+	if (argc == 2) {
+		nr_iterations = atoi(argv[1]);
+		if (nr_iterations <= 0)
+			ksft_exit_fail_msg("invalid input parameter %s\n",
+					argv[1]);
+	}
+
+	ksft_print_msg("running pidfd poll test for %d iterations\n",
+		nr_iterations);
+
+	for (iter = 0; iter < nr_iterations; iter++) {
+		int pidfd;
+		int child_pid = fork();
+
+		if (child_pid < 0) {
+			if (errno == EAGAIN) {
+				iter--;
+				continue;
+			}
+			ksft_exit_fail_msg(
+				"%s - failed to fork a child process\n",
+				strerror(errno));
+		}
+
+		if (child_pid == 0) {
+			/* Child process just sleeps for a min and exits */
+			sleep(60);
+			exit(EXIT_SUCCESS);
+		}
+
+		/* Parent kills the child and waits for its death */
+		pidfd = sys_pidfd_open(child_pid, 0);
+		if (pidfd < 0)
+			ksft_exit_fail_msg("%s - pidfd_open failed\n",
+					strerror(errno));
+
+		/* Setup 3 sec alarm - plenty of time */
+		if (signal(SIGALRM, handle_alarm) == SIG_ERR)
+			ksft_exit_fail_msg("%s - signal failed\n",
+					strerror(errno));
+		alarm(3);
+
+		/* Send SIGKILL to the child */
+		if (sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0))
+			ksft_exit_fail_msg("%s - pidfd_send_signal failed\n",
+					strerror(errno));
+
+		/* Wait for the death notification */
+		fds.fd = pidfd;
+		nevents = poll(&fds, 1, -1);
+
+		/* Check for error conditions */
+		if (nevents < 0)
+			ksft_exit_fail_msg("%s - poll failed\n",
+					strerror(errno));
+
+		if (nevents != 1)
+			ksft_exit_fail_msg("unexpected poll result: %d\n",
+					nevents);
+
+		if (!(fds.revents & POLLIN))
+			ksft_exit_fail_msg(
+				"unexpected event type received: 0x%x\n",
+				fds.revents);
+
+		if (timeout)
+			ksft_exit_fail_msg(
+				"death notification wait timeout\n");
+
+		close(pidfd);
+		// Wait for child to prevent zombies
+		if (waitpid(child_pid, NULL, 0) < 0)
+			ksft_exit_fail_msg("%s - waitpid failed\n",
+					strerror(errno));
+
+	}
+
+	ksft_test_result_pass("pidfd poll test: pass\n");
+	return ksft_exit_pass();
+}
-- 
2.22.0.709.g102302147b-goog

