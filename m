Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78447321D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfGXOsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 10:48:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33158 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfGXOsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 10:48:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so12121637pgj.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2019 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RegEjd24fa0lKrqQTZKDeVdxQIecr5qsEykVp127hyg=;
        b=eZm9v1kADJRR3b9PRi6MScfetcUJoTn+y9jo0gSRSpTIzDAzpQAgOunD17tTC98tqP
         1l998+km/ba3faaMH6Ae9ZM4rwGChKNjNBru+Jb10AHdKgxf7G3/kA9RXLZ69tsf7bin
         8NqmHhHBSyruOv7R9DIV5WwMBpMEPzPplmFM1eUif7YOmiwQz9Ac1J4rd1evOow+d2+N
         vfQx1xNw4tJKOhLSAO66aSaGWOeFblN2zKgepyJJBkaYAufVTsaqzHbFchaoJXrOLfPm
         RWVbcS0yksleo+Etyuz8aES39/HvUq5R9EG126rIF9GeLzD2dTiXQdXMBu6uganQHX3n
         qCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RegEjd24fa0lKrqQTZKDeVdxQIecr5qsEykVp127hyg=;
        b=k8+m+GaWIv6THyV5Kk/yihbqKwfkuNCcWb7FEzne1uIbmOvH3zUqrcfrB0MXVQDBq3
         dDgByjaau3tCcbnDSBiusc+y+clFP5EyzSALW98zNKFpaHuAd2Qj/Z7vsE4LcZtLGOCC
         Zog3HWGqF8M4KfSPRTH1RsuNJIdfsZPf3TaBMpOWNprGjGCKkb1OrmhDfsgOLv8tQIUJ
         cPT2xEjHBnF39a0+JVRwiPYzeIJaM/tnwbfA2ragTlGmNkqIkcrCOtMHnOZanluACreP
         twNJbHcZhUdSWGH/zDqxjFb2ApoyGMHu4A15baeb0ofVY6QK/ABDcijY0DI5PJwbFhzK
         ZJxQ==
X-Gm-Message-State: APjAAAXmP5b93CcdBa6ajTQsyb6/d/yOdQewa8bgVdLsQvxL5eKXqw6W
        bA1JzoAZhg2CNEkRWC8QLe4=
X-Google-Smtp-Source: APXvYqy658wMqfm1Z4iL53fOCDFmzETGRgIHQujh8zv72dV8L+zJXwfWHf+ZJNio075mFB67zNUBmw==
X-Received: by 2002:a65:6102:: with SMTP id z2mr81045739pgu.391.1563979688845;
        Wed, 24 Jul 2019 07:48:08 -0700 (PDT)
Received: from localhost.localdomain ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id g6sm41125644pgh.64.2019.07.24.07.47.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:48:08 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 5/5] pidfd: add pidfd_wait tests
Date:   Wed, 24 Jul 2019 16:46:51 +0200
Message-Id: <20190724144651.28272-6-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724144651.28272-1-christian@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests for pidfd_wait() and CLONE_WAIT_PID:
- test that pidfd_wait() syscall is supported
- test that pidfd_wait() does not accept unknown flags
- test that pidfd_wait() can wait on a pidfd
- test that pidfd_wait() can wait on a pidfd and return struct rusage
- test that pidfd_wait() can wait on a pidfd and return siginfo_t
- test that pidfd_wait() works with WEXITED
- test that pidfd_wait() works with WSTOPPED
- test that pidfd_wait() works with WUNTRACED
- test that pidfd_wait() works with WCONTINUED
- test that pidfd_wait() works with WNOWAIT
- test that pidfd_wait() works with WNOHANG
- test that CLONE_WAIT_PID does not appear in waitid(P_ALL) requests
- test that CLONE_WAIT_PID does not appear in waitid(P_PGID) requests
- test that CLONE_WAIT_PID does not appear in wait4(-1) requests
- test that CLONE_WAIT_PID does not appear in wait4(0) requests
- test that CLONE_WAIT_PID does appear in waitid(P_PID) requests
- test that CLONE_WAIT_PID does appear in wait4(pid) requests

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/pidfd/pidfd.h      |  25 ++
 tools/testing/selftests/pidfd/pidfd_test.c |  14 -
 tools/testing/selftests/pidfd/pidfd_wait.c | 398 +++++++++++++++++++++
 3 files changed, 423 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_wait.c

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 8452e910463f..d56bca179b9e 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,6 +16,26 @@
 
 #include "../kselftest.h"
 
+#ifndef CLONE_PIDFD
+#define CLONE_PIDFD 0x00001000
+#endif
+
+#ifndef CLONE_WAIT_PID
+#define CLONE_WAIT_PID 0x200000000ULL
+#endif
+
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open -1
+#endif
+
+#ifndef __NR_pidfd_send_signal
+#define __NR_pidfd_send_signal -1
+#endif
+
+#ifndef __NR_clone3
+#define __NR_clone3 -1
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
@@ -53,5 +73,10 @@ int wait_for_pid(pid_t pid)
 	return WEXITSTATUS(status);
 }
 
+static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+					unsigned int flags)
+{
+	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
 
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 7eaa8a3de262..42e3eb494d72 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -21,20 +21,12 @@
 #include "pidfd.h"
 #include "../kselftest.h"
 
-#ifndef __NR_pidfd_send_signal
-#define __NR_pidfd_send_signal -1
-#endif
-
 #define str(s) _str(s)
 #define _str(s) #s
 #define CHILD_THREAD_MIN_WAIT 3 /* seconds */
 
 #define MAX_EVENTS 5
 
-#ifndef CLONE_PIDFD
-#define CLONE_PIDFD 0x00001000
-#endif
-
 static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 {
 	size_t stack_size = 1024;
@@ -47,12 +39,6 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
-					unsigned int flags)
-{
-	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
-}
-
 static int signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
new file mode 100644
index 000000000000..fcbd10098067
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -0,0 +1,398 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+
+#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
+
+static pid_t sys_clone3(struct clone_args *args)
+{
+	return syscall(__NR_clone3, args, sizeof(struct clone_args));
+}
+
+static pid_t sys_pidfd_wait(int pidfd, int *wstatus, siginfo_t *info,
+			    struct rusage *ru, unsigned int states,
+			    unsigned int flags)
+{
+	return syscall(__NR_pidfd_wait, pidfd, wstatus, info, ru, states, flags);
+}
+
+static int test_pidfd_wait_syscall_support(void)
+{
+	int ret;
+	const char *test_name = "pidfd_wait check for support";
+
+	ret = sys_pidfd_wait(-EBADF, NULL, NULL, NULL, WEXITED, 0);
+	if (ret < 0 && errno == ENOSYS)
+		ksft_exit_skip("%s test: pidfd_wait() syscall not supported\n",
+			       test_name);
+
+	ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
+}
+
+static int test_pidfd_wait_simple(void)
+{
+	const char *test_name = "pidfd_wait simple";
+	int pidfd = -1, status = 0;
+	pid_t parent_tid = -1;
+	struct clone_args args = {
+		.parent_tid = ptr_to_u64(&parent_tid),
+		.pidfd = ptr_to_u64(&pidfd),
+		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
+		.exit_signal = SIGCHLD,
+	};
+	pid_t pid;
+
+	pid = sys_clone3(&args);
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: failed to create new process %s",
+				   test_name, strerror(errno));
+
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+
+	pid = sys_pidfd_wait(pidfd, NULL, NULL, NULL, -1, 0);
+	if (pid > 0)
+		ksft_exit_fail_msg(
+			"%s test: succeeded to wait on process with invalid flags passed",
+			test_name);
+
+	pid = sys_pidfd_wait(pidfd, NULL, NULL, NULL, 0, -1);
+	if (pid > 0)
+		ksft_exit_fail_msg(
+			"%s test: succeeded to wait on process with invalid flags passed",
+			test_name);
+
+	pid = sys_pidfd_wait(pidfd, NULL, NULL, NULL, 0, 0);
+	if (pid > 0)
+		ksft_exit_fail_msg(
+			"%s test: succeeded to wait on process with invalid flags passed",
+			test_name);
+
+	pid = sys_pidfd_wait(pidfd, NULL, NULL, NULL, WEXITED, 0);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+	close(pidfd);
+
+	pidfd = -1;
+	parent_tid = -1;
+	pid = sys_clone3(&args);
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: failed to create new process %s",
+				   test_name, strerror(errno));
+
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+
+	pid = sys_pidfd_wait(pidfd, &status, NULL, NULL, WEXITED, 0);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		ksft_exit_fail_msg(
+			"%s test: unexpected status received after waiting on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+	close(pidfd);
+
+	pidfd = -1;
+	parent_tid = -1;
+	pid = sys_clone3(&args);
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: failed to create new process %s",
+				   test_name, strerror(errno));
+
+	if (pid == 0)
+		exit(EXIT_FAILURE);
+
+	pid = sys_pidfd_wait(pidfd, &status, NULL, NULL, WEXITED, 0);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	if (!WIFEXITED(status) || !WEXITSTATUS(status))
+		ksft_exit_fail_msg(
+			"%s test: unexpected status received after waiting on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+	close(pidfd);
+
+	ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
+}
+
+static int test_pidfd_wait_rusage(void)
+{
+	const char *test_name = "pidfd_wait rusage";
+	int pidfd = -1, status = 0;
+	pid_t parent_tid = -1;
+	struct clone_args args = {
+		.parent_tid = ptr_to_u64(&parent_tid),
+		.pidfd = ptr_to_u64(&pidfd),
+		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
+		.exit_signal = SIGCHLD,
+	};
+	pid_t pid;
+	struct rusage rusage = { 0 };
+
+	pid = sys_clone3(&args);
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: failed to create new process %s",
+				   test_name, strerror(errno));
+
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+
+	pid = sys_pidfd_wait(pidfd, &status, NULL, &rusage, WEXITED, 0);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		ksft_exit_fail_msg(
+			"%s test: unexpected status received after waiting on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+	close(pidfd);
+
+	ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
+}
+
+static int test_pidfd_wait_siginfo(void)
+{
+	const char *test_name = "pidfd_wait siginfo";
+	int pidfd = -1, status = 0;
+	pid_t parent_tid = -1;
+	struct clone_args args = {
+		.parent_tid = ptr_to_u64(&parent_tid),
+		.pidfd = ptr_to_u64(&pidfd),
+		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
+		.exit_signal = SIGCHLD,
+	};
+	pid_t pid;
+	siginfo_t info = {
+		.si_signo = 0,
+	};
+
+	pid = sys_clone3(&args);
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: failed to create new process %s",
+				   test_name, strerror(errno));
+
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+
+	pid = sys_pidfd_wait(pidfd, &status, &info, NULL, WEXITED, 0);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		ksft_exit_fail_msg(
+			"%s test: unexpected status received after waiting on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+	close(pidfd);
+
+	if (info.si_signo != SIGCHLD)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s",
+			test_name, info.si_signo, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_code != CLD_EXITED)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s",
+			test_name, info.si_code, parent_tid, pidfd,
+			strerror(errno));
+
+	ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
+}
+
+static int test_pidfd_wait_states(void)
+{
+	const char *test_name = "pidfd_wait states";
+	int pidfd = -1, status = 0;
+	pid_t parent_tid = -1;
+	struct clone_args args = {
+		.parent_tid = ptr_to_u64(&parent_tid),
+		.pidfd = ptr_to_u64(&pidfd),
+		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
+		.exit_signal = SIGCHLD,
+	};
+	int ret;
+	pid_t pid;
+	siginfo_t info = {
+		.si_signo = 0,
+	};
+
+	pid = sys_clone3(&args);
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: failed to create new process %s",
+				   test_name, strerror(errno));
+
+	if (pid == 0) {
+		kill(getpid(), SIGSTOP);
+		kill(getpid(), SIGSTOP);
+		exit(EXIT_SUCCESS);
+	}
+
+	pid = sys_pidfd_wait(pidfd, &status, &info, NULL, WSTOPPED, 0);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	ret = sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	pid = sys_pidfd_wait(pidfd, &status, &info, NULL, WCONTINUED, 0);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	pid = sys_pidfd_wait(pidfd, &status, &info, NULL, WUNTRACED, 0);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	ret = sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	pid = sys_pidfd_wait(pidfd, &status, &info, NULL, WEXITED, 0);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	close(pidfd);
+
+	ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
+}
+
+static int test_clone_wait_pid(void)
+{
+	const char *test_name = "CLONE_WAIT_PID";
+	int pidfd = -1, status = 0;
+	pid_t parent_tid = -1;
+	struct clone_args args = {
+		.parent_tid = ptr_to_u64(&parent_tid),
+		.pidfd = ptr_to_u64(&pidfd),
+		.flags = CLONE_PARENT_SETTID | CLONE_WAIT_PID,
+		.exit_signal = SIGCHLD,
+	};
+	int ret;
+	pid_t pid, rpid;
+
+	pid = sys_clone3(&args);
+	if (pid > 0)
+		ksft_exit_fail_msg(
+			"%s test: managed to create new process with CLONE_WAIT_PID but without CLONE_PIDFD",
+			test_name);
+
+	args.flags |= CLONE_PIDFD;
+	pid = sys_clone3(&args);
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: failed to create new process %s",
+				   test_name, strerror(errno));
+
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+
+	ret = syscall(__NR_waitid, P_ALL, -1, NULL, WEXITED, NULL);
+	if (ret == 0)
+		ksft_exit_fail_msg(
+			"%s test: managed to wait on process created with CLONE_PIDFD | CLONE_WAIT_PID with pid %d and pidfd %d through waitid(P_ALL) request",
+			test_name, parent_tid, pidfd);
+
+	ret = syscall(__NR_waitid, P_PGID, getpgid(0), NULL, WEXITED, NULL);
+	if (ret == 0)
+		ksft_exit_fail_msg(
+			"%s test: managed to wait on process created with CLONE_PIDFD | CLONE_WAIT_PID with pid %d and pidfd %d through waitid(P_PGID) request",
+			test_name, parent_tid, pidfd);
+
+	rpid = syscall(__NR_wait4, -1, NULL, 0, NULL);
+	if (rpid > 0)
+		ksft_exit_fail_msg(
+			"%s test: managed to wait on process created with CLONE_PIDFD | CLONE_WAIT_PID with pid %d and pidfd %d through wait4(-1) request",
+			test_name, parent_tid, pidfd);
+
+	rpid = syscall(__NR_wait4, 0, NULL, 0, NULL);
+	if (rpid > 0)
+		ksft_exit_fail_msg(
+			"%s test: managed to wait on process created with CLONE_PIDFD | CLONE_WAIT_PID with pid %d and pidfd %d through wait4(0) request",
+			test_name, parent_tid, pidfd);
+
+	ret = syscall(__NR_waitid, P_PID, pid, NULL, WEXITED | WNOWAIT | WNOHANG, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process created with CLONE_PIDFD | CLONE_WAIT_PID with pid %d and pidfd %d through waitid(P_PID) request: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	rpid = sys_pidfd_wait(pidfd, NULL, NULL, NULL, WEXITED, WNOWAIT | WNOHANG);
+	if (rpid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	rpid = syscall(__NR_wait4, pid, &status, 0, NULL);
+	if (rpid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process created with CLONE_PIDFD | CLONE_WAIT_PID with pid %d and pidfd %d through wait4(%d) request: %s",
+			test_name, parent_tid, pidfd, parent_tid, strerror(errno));
+
+	if (!WIFEXITED(status) || WEXITSTATUS(status))
+		ksft_exit_fail_msg(
+			"%s test: unexpected status received after waiting on process with pid %d and pidfd %d: %s",
+			test_name, parent_tid, pidfd, strerror(errno));
+	close(pidfd);
+
+	ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(6);
+
+	test_pidfd_wait_syscall_support();
+	test_pidfd_wait_simple();
+	test_pidfd_wait_rusage();
+	test_pidfd_wait_siginfo();
+	test_pidfd_wait_states();
+	test_clone_wait_pid();
+
+	return ksft_exit_pass();
+}
-- 
2.22.0

