Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2FA71DE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2019 19:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbfGWRjW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jul 2019 13:39:22 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52488 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388608AbfGWRjW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jul 2019 13:39:22 -0400
Received: by mail-pf1-f202.google.com with SMTP id a20so26639081pfn.19
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2019 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Bhkyr65PWig7V2UMGHCo0cxijfHVoKxbUiv9lGXzUM8=;
        b=YQcDzV9Q/v7HZAHl3l9BZTP39zZXT6tb36JYGbXnH4hat3gEA/Idtf5+I6WRzqomuS
         cBOYMbt45BUXXkpn5OJBOSPq9Zr9BNHASbiMuvA4s6LuOvFHEDhSVps3pamd1/YetUh3
         cj4LcYqIa3i8vW9CwlpoJK3v3GJqhzlrzM6HgcKgmXCdubpqfuSLJCWjFOcKil0VTvo9
         h2EerRnxNJaACALbTPuolIhZYoqXuojiIIP3e9gq/2jP4oe8dH/SmCaQK2Qny3ymoZSv
         xJDc2gtyrYAEZ7hoq9QIGdHbkr8uS0/RYWheWMMSMnTZvsOpllLFA3W/EM0LoV1s3VKG
         vWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Bhkyr65PWig7V2UMGHCo0cxijfHVoKxbUiv9lGXzUM8=;
        b=uWU4tPFBmWJr8Q+1qYg44ag84gFrPAHQX+6DgBzlGoZ4M1v1Ust0JML+tLpB8CQm9g
         1DEJwqMJioJyUAKT5Fil/LLgb9dYuDbGYdraQnVi+NzTth88p0I994aH1R2JJBAYQECF
         8EPBwkORRz86oAaw6cEDp2x2yZd5nEIrP7iiZ+cmLHvt1Tq73Jafv5c1c5kVOnQFYAP0
         1DeccP5Me82RDGrMFLgqe20WmW5Fjjl4rp29kkiYXxWLznOz+jS43pwtjQW/F59pq9Kh
         9r/shJL6EZ0dzqgXiJqeL1+sNrNLeebpmeiUGrrm/ACfFO3fjOPY5smZq0IS2yIbUPuv
         zwzQ==
X-Gm-Message-State: APjAAAVTCpGocQS3D2if0Fk/ICPxRo3GjMs6I3Y22cLZ3wbp7alhOC7e
        B6XB8EOwJW7mc0Up3OFwy1g76BXOIu8=
X-Google-Smtp-Source: APXvYqxCEUS0ay+6fyizL+W6c9ubqvMx5B72zDA5GEggCuUSf1pzL7kzFyZyu3VIPP8mD85/TMpJvspZihQ=
X-Received: by 2002:a63:6f41:: with SMTP id k62mr31630681pgc.32.1563903561143;
 Tue, 23 Jul 2019 10:39:21 -0700 (PDT)
Date:   Tue, 23 Jul 2019 10:39:07 -0700
Message-Id: <20190723173907.196488-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 1/1] tests: add pidfd poll tests
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
 .../testing/selftests/pidfd/pidfd_poll_test.c | 137 ++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
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
index 000000000000..f2934aa070ae
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -0,0 +1,137 @@
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
+#define __NR_pidfd_send_signal 424
+#define __NR_pidfd_open 434
+
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+					unsigned int flags)
+{
+	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
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
+	int ret = 1;
+	int pidfd = -1;
+	struct pollfd fds;
+	int iter, nevents;
+	int nr_iterations = 10000;
+
+	fds.events = POLLIN;
+	if (argc > 1) {
+		nr_iterations = atoi(argv[1]);
+		if (!nr_iterations) {
+			ksft_test_result_fail("invalid input parameter %s\n",
+				argv[1]);
+			return ksft_exit_fail();
+		}
+	}
+
+	ksft_print_msg("running pidfd poll test for %d iterations\n",
+		nr_iterations);
+
+	for (iter = 0; iter < nr_iterations; iter++) {
+		int child_pid = fork();
+
+		if (!child_pid) {
+			/* Child process just sleeps for a min */
+			sleep(60);
+			exit(0);
+		}
+
+		/* Parent kills the child and waits for its death */
+		if (child_pid < 0) {
+			if (errno == EAGAIN) {
+				iter--;
+				continue;
+			}
+			ksft_print_msg("%s - failed to fork a child process\n",
+				strerror(errno));
+		}
+		pidfd = sys_pidfd_open(child_pid, 0);
+		if (pidfd < 0) {
+			ksft_print_msg("%s - pidfd_open failed\n",
+				strerror(errno));
+			goto on_error;
+		}
+		/* Setup 3 sec alarm - plenty of time */
+		if (signal(SIGALRM, handle_alarm) == SIG_ERR) {
+			ksft_print_msg("%s - signal failed\n",
+				strerror(errno));
+			goto on_error;
+		}
+		alarm(3);
+		/* Send SIGKILL to the child */
+		if (sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0)) {
+			ksft_print_msg("%s - pidfd_send_signal failed\n",
+				strerror(errno));
+			goto on_error;
+		}
+		/* Wait for the death notification */
+		fds.fd = pidfd;
+		nevents = poll(&fds, 1, -1);
+		if (nevents < 0) {
+			ksft_print_msg("%s - poll failed\n",
+				strerror(errno));
+			goto on_error;
+		}
+		if (nevents != 1) {
+			ksft_print_msg("unexpected poll result: %d\n",
+				nevents);
+			goto on_error;
+		}
+		if (!(fds.revents & POLLIN)) {
+			ksft_print_msg(
+				"unexpected event type received: 0x%x\n",
+				fds.revents);
+			goto on_error;
+		}
+		if (timeout) {
+			ksft_print_msg("death notification wait timeout\n");
+			goto on_error;
+		}
+		close(pidfd);
+	}
+	ret = 0;
+
+on_error:
+	if (pidfd)
+		close(pidfd);
+
+	if (ret) {
+		ksft_test_result_fail("failed after %d retries\n", iter);
+		return ksft_exit_fail();
+	}
+
+	ksft_test_result_pass("pidfd poll test: pass\n");
+	return ksft_exit_pass();
+}
-- 
2.22.0.657.g960e92d24f-goog

