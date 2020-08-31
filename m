Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3214C257ABD
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHaNsI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 09:48:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43635 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgHaNra (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 09:47:30 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kCk90-00062w-9A; Mon, 31 Aug 2020 13:46:46 +0000
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
Subject: [PATCH 3/4] tests: port pidfd_wait to kselftest harness
Date:   Mon, 31 Aug 2020 15:45:50 +0200
Message-Id: <20200831134551.1599689-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
References: <20200831134551.1599689-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All of the new pidfd selftests already use the new kselftest harness
infrastructure. It makes for clearer output, makes the code easier to
understand, and makes adding new tests way simpler.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/pidfd/pidfd_wait.c | 213 ++++-----------------
 1 file changed, 39 insertions(+), 174 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
index 7079f8eef792..075c716f6fb8 100644
--- a/tools/testing/selftests/pidfd/pidfd_wait.c
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -17,7 +17,7 @@
 #include <unistd.h>
 
 #include "pidfd.h"
-#include "../kselftest.h"
+#include "../kselftest_harness.h"
 
 #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
 
@@ -32,9 +32,8 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
 	return syscall(__NR_waitid, which, pid, info, options, ru);
 }
 
-static int test_pidfd_wait_simple(void)
+TEST(wait_simple)
 {
-	const char *test_name = "pidfd wait simple";
 	int pidfd = -1, status = 0;
 	pid_t parent_tid = -1;
 	struct clone_args args = {
@@ -50,76 +49,40 @@ static int test_pidfd_wait_simple(void)
 	};
 
 	pidfd = open("/proc/self", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
-	if (pidfd < 0)
-		ksft_exit_fail_msg("%s test: failed to open /proc/self %s\n",
-				   test_name, strerror(errno));
+	ASSERT_GE(pidfd, 0);
 
 	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
-	if (pid == 0)
-		ksft_exit_fail_msg(
-			"%s test: succeeded to wait on invalid pidfd %s\n",
-			test_name, strerror(errno));
-	close(pidfd);
+	ASSERT_NE(pid, 0);
+	EXPECT_EQ(close(pidfd), 0);
 	pidfd = -1;
 
 	pidfd = open("/dev/null", O_RDONLY | O_CLOEXEC);
-	if (pidfd == 0)
-		ksft_exit_fail_msg("%s test: failed to open /dev/null %s\n",
-				   test_name, strerror(errno));
+	ASSERT_GE(pidfd, 0);
 
 	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
-	if (pid == 0)
-		ksft_exit_fail_msg(
-			"%s test: succeeded to wait on invalid pidfd %s\n",
-			test_name, strerror(errno));
-	close(pidfd);
+	ASSERT_NE(pid, 0);
+	EXPECT_EQ(close(pidfd), 0);
 	pidfd = -1;
 
 	pid = sys_clone3(&args);
-	if (pid < 0)
-		ksft_exit_fail_msg("%s test: failed to create new process %s\n",
-				   test_name, strerror(errno));
+	ASSERT_GE(pid, 1);
 
 	if (pid == 0)
 		exit(EXIT_SUCCESS);
 
 	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
-	if (pid < 0)
-		ksft_exit_fail_msg(
-			"%s test: failed to wait on process with pid %d and pidfd %d: %s\n",
-			test_name, parent_tid, pidfd, strerror(errno));
-
-	if (!WIFEXITED(info.si_status) || WEXITSTATUS(info.si_status))
-		ksft_exit_fail_msg(
-			"%s test: unexpected status received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, parent_tid, pidfd, strerror(errno));
-	close(pidfd);
-
-	if (info.si_signo != SIGCHLD)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_signo, parent_tid, pidfd,
-			strerror(errno));
-
-	if (info.si_code != CLD_EXITED)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_code, parent_tid, pidfd,
-			strerror(errno));
-
-	if (info.si_pid != parent_tid)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_pid, parent_tid, pidfd,
-			strerror(errno));
-
-	ksft_test_result_pass("%s test: Passed\n", test_name);
-	return 0;
+	ASSERT_GE(pid, 0);
+	ASSERT_EQ(WIFEXITED(info.si_status), true);
+	ASSERT_EQ(WEXITSTATUS(info.si_status), 0);
+	EXPECT_EQ(close(pidfd), 0);
+
+	ASSERT_EQ(info.si_signo, SIGCHLD);
+	ASSERT_EQ(info.si_code, CLD_EXITED);
+	ASSERT_EQ(info.si_pid, parent_tid);
 }
 
-static int test_pidfd_wait_states(void)
+TEST(wait_states)
 {
-	const char *test_name = "pidfd wait states";
 	int pidfd = -1, status = 0;
 	pid_t parent_tid = -1;
 	struct clone_args args = {
@@ -135,9 +98,7 @@ static int test_pidfd_wait_states(void)
 	};
 
 	pid = sys_clone3(&args);
-	if (pid < 0)
-		ksft_exit_fail_msg("%s test: failed to create new process %s\n",
-				   test_name, strerror(errno));
+	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
 		kill(getpid(), SIGSTOP);
@@ -145,127 +106,31 @@ static int test_pidfd_wait_states(void)
 		exit(EXIT_SUCCESS);
 	}
 
-	ret = sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL);
-	if (ret < 0)
-		ksft_exit_fail_msg(
-			"%s test: failed to wait on WSTOPPED process with pid %d and pidfd %d: %s\n",
-			test_name, parent_tid, pidfd, strerror(errno));
-
-	if (info.si_signo != SIGCHLD)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_signo, parent_tid, pidfd,
-			strerror(errno));
-
-	if (info.si_code != CLD_STOPPED)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_code, parent_tid, pidfd,
-			strerror(errno));
-
-	if (info.si_pid != parent_tid)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_pid, parent_tid, pidfd,
-			strerror(errno));
-
-	ret = sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0);
-	if (ret < 0)
-		ksft_exit_fail_msg(
-			"%s test: failed to send signal to process with pid %d and pidfd %d: %s\n",
-			test_name, parent_tid, pidfd, strerror(errno));
-
-	ret = sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL);
-	if (ret < 0)
-		ksft_exit_fail_msg(
-			"%s test: failed to wait WCONTINUED on process with pid %d and pidfd %d: %s\n",
-			test_name, parent_tid, pidfd, strerror(errno));
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL), 0);
+	ASSERT_EQ(info.si_signo, SIGCHLD);
+	ASSERT_EQ(info.si_code, CLD_STOPPED);
+	ASSERT_EQ(info.si_pid, parent_tid);
 
-	if (info.si_signo != SIGCHLD)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_signo, parent_tid, pidfd,
-			strerror(errno));
+	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0), 0);
 
-	if (info.si_code != CLD_CONTINUED)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_code, parent_tid, pidfd,
-			strerror(errno));
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL), 0);
+	ASSERT_EQ(info.si_signo, SIGCHLD);
+	ASSERT_EQ(info.si_code, CLD_CONTINUED);
+	ASSERT_EQ(info.si_pid, parent_tid);
 
-	if (info.si_pid != parent_tid)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_pid, parent_tid, pidfd,
-			strerror(errno));
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WUNTRACED, NULL), 0);
+	ASSERT_EQ(info.si_signo, SIGCHLD);
+	ASSERT_EQ(info.si_code, CLD_STOPPED);
+	ASSERT_EQ(info.si_pid, parent_tid);
 
-	ret = sys_waitid(P_PIDFD, pidfd, &info, WUNTRACED, NULL);
-	if (ret < 0)
-		ksft_exit_fail_msg(
-			"%s test: failed to wait on WUNTRACED process with pid %d and pidfd %d: %s\n",
-			test_name, parent_tid, pidfd, strerror(errno));
+	ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0), 0);
 
-	if (info.si_signo != SIGCHLD)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_signo, parent_tid, pidfd,
-			strerror(errno));
+	ASSERT_EQ(sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL), 0);
+	ASSERT_EQ(info.si_signo, SIGCHLD);
+	ASSERT_EQ(info.si_code, CLD_KILLED);
+	ASSERT_EQ(info.si_pid, parent_tid);
 
-	if (info.si_code != CLD_STOPPED)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_code, parent_tid, pidfd,
-			strerror(errno));
-
-	if (info.si_pid != parent_tid)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_pid, parent_tid, pidfd,
-			strerror(errno));
-
-	ret = sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
-	if (ret < 0)
-		ksft_exit_fail_msg(
-			"%s test: failed to send SIGKILL to process with pid %d and pidfd %d: %s\n",
-			test_name, parent_tid, pidfd, strerror(errno));
-
-	ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
-	if (ret < 0)
-		ksft_exit_fail_msg(
-			"%s test: failed to wait on WEXITED process with pid %d and pidfd %d: %s\n",
-			test_name, parent_tid, pidfd, strerror(errno));
-
-	if (info.si_signo != SIGCHLD)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_signo, parent_tid, pidfd,
-			strerror(errno));
-
-	if (info.si_code != CLD_KILLED)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_code, parent_tid, pidfd,
-			strerror(errno));
-
-	if (info.si_pid != parent_tid)
-		ksft_exit_fail_msg(
-			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
-			test_name, info.si_pid, parent_tid, pidfd,
-			strerror(errno));
-
-	close(pidfd);
-
-	ksft_test_result_pass("%s test: Passed\n", test_name);
-	return 0;
+	EXPECT_EQ(close(pidfd), 0);
 }
 
-int main(int argc, char **argv)
-{
-	ksft_print_header();
-	ksft_set_plan(2);
-
-	test_pidfd_wait_simple();
-	test_pidfd_wait_states();
-
-	return ksft_exit_pass();
-}
+TEST_HARNESS_MAIN
-- 
2.28.0

