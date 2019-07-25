Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D6174289
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2019 02:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfGYAWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 20:22:12 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:54772 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfGYAWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 20:22:12 -0400
Received: by mail-qk1-f201.google.com with SMTP id b139so40791187qkc.21
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2019 17:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WoT0JdS5sTZ+KaUnVNgLy4vBDqFwtVz5wRG6YSXVjfE=;
        b=pHr9hk3tmUqrRWPEMXKO6EjMvXrKDPcNEhjNrRC2YjzvigkcK3FwehQq/WeVohq8EU
         emUQ8OuW3Op6f/SeAo4w7bzLDNKdHbcVus9x+aZ1D9Z3oPogirZtE1Wmu5IWS40DueWb
         qQ4+b/OOQSTwJCx7qQn1psTxkqN2BSwGX1HAx0V6QRHOWTRENYmgVZGdD//C3VoKwCbB
         y+uz0j5AF6r5CSfyVVMJ6HlLDn6gS4uAzJQOOvwmTvqMnBT3F33ubYITV4ad5g71RGY2
         tzSnZB3FNGhK1k+koyGGsUu0nf4L3aOrUjAUVq/skcverQ6lPxSferUU8oQDEy1PCnGb
         92aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WoT0JdS5sTZ+KaUnVNgLy4vBDqFwtVz5wRG6YSXVjfE=;
        b=D0zZ7X6RTookPv5WzEUkTDuteyJTb8HnhCEdsXe8IAFPB9afR3ZTzJiX6oETriHbeh
         CoVQputmoIpvxAPIFF93/MTpORNrdWT4ZxqHuu/dsU36F5YrEtyiADWXGrb8HLfAMl23
         CAsWeHsNSrTK2T90sS/hJ3jEM49rUnFKrjd52ad+iMWN7ceiHES+Kyj9+ZtTMrnY8ZBD
         JFQmtLSyzL2HLoJFkQ3zXi8POmw9eBFn5WKEq+rxtWIcYnaohxu5hOFoX3OZGIodccDE
         YB8FiYWf2titsrRacu+SjwFnBB+g++f2hvbmFZyQrWjmAgvsKT48Gb5th3VfP9NETSR4
         zlEg==
X-Gm-Message-State: APjAAAVzI8cq+7OtKqUnsvtPVMiKPq+uVI9A9Fqyawuowu3n7lvjD7x5
        nfNaHP2rnmljqeHUmDqWrNkuyQM0Cow=
X-Google-Smtp-Source: APXvYqyCu86gRhosjk95ByhCLv1y0mU+aviBEYQSxF57aMUceutoRPaIQKhDD1lvj8c94MnUFh1nDcQIbco=
X-Received: by 2002:ac8:2971:: with SMTP id z46mr58482727qtz.322.1564014130639;
 Wed, 24 Jul 2019 17:22:10 -0700 (PDT)
Date:   Wed, 24 Jul 2019 17:22:04 -0700
In-Reply-To: <20190725002204.185225-1-surenb@google.com>
Message-Id: <20190725002204.185225-2-surenb@google.com>
Mime-Version: 1.0
References: <20190725002204.185225-1-surenb@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 2/2] tests: add pidfd poll tests
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
 .../testing/selftests/pidfd/pidfd_poll_test.c | 112 ++++++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)
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
index 000000000000..d45c612a0fe5
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -0,0 +1,112 @@
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
+		if (!child_pid) {
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
+	}
+
+	ksft_test_result_pass("pidfd poll test: pass\n");
+	return ksft_exit_pass();
+}
-- 
2.22.0.709.g102302147b-goog

