Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66EC25A951
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIBKX0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 06:23:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49502 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBKXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 06:23:23 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDPvE-00069F-Af; Wed, 02 Sep 2020 10:23:20 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 4/4] tests: add waitid() tests for non-blocking pidfds
Date:   Wed,  2 Sep 2020 12:21:30 +0200
Message-Id: <20200902102130.147672-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902102130.147672-1-christian.brauner@ubuntu.com>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Verify that the PIDFD_NONBLOCK flag works with pidfd_open() and that
waitid() with a non-blocking pidfd returns EAGAIN:

	TAP version 13
	1..3
	# Starting 3 tests from 1 test cases.
	#  RUN           global.wait_simple ...
	#            OK  global.wait_simple
	ok 1 global.wait_simple
	#  RUN           global.wait_states ...
	#            OK  global.wait_states
	ok 2 global.wait_states
	#  RUN           global.wait_nonblock ...
	#            OK  global.wait_nonblock
	ok 3 global.wait_nonblock
	# PASSED: 3 / 3 tests passed.
	# Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 tools/testing/selftests/pidfd/pidfd.h      |  4 ++
 tools/testing/selftests/pidfd/pidfd_wait.c | 83 +++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index a2c80914e3dc..01f8d3c0cf2c 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -46,6 +46,10 @@
 #define __NR_pidfd_getfd -1
 #endif
 
+#ifndef PIDFD_NONBLOCK
+#define PIDFD_NONBLOCK O_NONBLOCK
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 075c716f6fb8..cefce4d3d2f6 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -21,6 +21,11 @@
 
 #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
 
+/* Attempt to de-conflict with the selftests tree. */
+#ifndef SKIP
+#define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
+#endif
+
 static pid_t sys_clone3(struct clone_args *args)
 {
 	return syscall(__NR_clone3, args, sizeof(struct clone_args));
@@ -65,7 +70,7 @@ TEST(wait_simple)
 	pidfd = -1;
 
 	pid = sys_clone3(&args);
-	ASSERT_GE(pid, 1);
+	ASSERT_GE(pid, 0);
 
 	if (pid == 0)
 		exit(EXIT_SUCCESS);
@@ -133,4 +138,80 @@ TEST(wait_states)
 	EXPECT_EQ(close(pidfd), 0);
 }
 
+TEST(wait_nonblock)
+{
+	int pidfd, status = 0;
+	unsigned int flags = 0;
+	pid_t parent_tid = -1;
+	struct clone_args args = {
+		.parent_tid = ptr_to_u64(&parent_tid),
+		.flags = CLONE_PARENT_SETTID,
+		.exit_signal = SIGCHLD,
+	};
+	int ret;
+	pid_t pid;
+	siginfo_t info = {
+		.si_signo = 0,
+	};
+
+	/*
+	 * Callers need to see ECHILD with non-blocking pidfds when no child
+	 * processes exists.
+	 */
+	pidfd = sys_pidfd_open(getpid(), PIDFD_NONBLOCK);
+	EXPECT_GE(pidfd, 0) {
+		/* pidfd_open() doesn't support PIDFD_NONBLOCK. */
+		ASSERT_EQ(errno, EINVAL);
+		SKIP(return, "Skipping PIDFD_NONBLOCK test");
+	}
+
+	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	ASSERT_LT(pid, 0);
+	ASSERT_EQ(errno, ECHILD);
+	EXPECT_EQ(close(pidfd), 0);
+
+	pid = sys_clone3(&args);
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		kill(getpid(), SIGSTOP);
+		exit(EXIT_SUCCESS);
+	}
+
+	pidfd = sys_pidfd_open(pid, PIDFD_NONBLOCK);
+	EXPECT_GE(pidfd, 0) {
+		/* pidfd_open() doesn't support PIDFD_NONBLOCK. */
+		ASSERT_EQ(errno, EINVAL);
+		SKIP(return, "Skipping PIDFD_NONBLOCK test");
+	}
+
+	flags = fcntl(pidfd, F_GETFL, 0);
+	ASSERT_GT(flags, 0);
+	ASSERT_GT((flags & O_NONBLOCK), 0);
+
+	/*
+	 * Callers need to see EAGAIN/EWOULDBLOCK with non-blocking pidfd when
+	 * child processes exist but none have exited.
+	 */
+	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	ASSERT_LT(pid, 0);
+	ASSERT_EQ(errno, EAGAIN);
+
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
+	ASSERT_EQ(info.si_signo, SIGCHLD);
+	ASSERT_EQ(info.si_code, CLD_STOPPED);
+	ASSERT_EQ(info.si_pid, parent_tid);
+
+	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
+
+	ASSERT_EQ(fcntl(pidfd, F_SETFL, (flags & ~O_NONBLOCK)), 0);
+
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL), 0);
+	ASSERT_EQ(info.si_signo, SIGCHLD);
+	ASSERT_EQ(info.si_code, CLD_EXITED);
+	ASSERT_EQ(info.si_pid, parent_tid);
+
+	EXPECT_EQ(close(pidfd), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.28.0

