Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936FAD607D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 12:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfJNKp6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 06:45:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34519 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbfJNKp6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 06:45:58 -0400
Received: from [212.86.36.32] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iJxrO-0002lB-PW; Mon, 14 Oct 2019 10:45:55 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, libc-alpha@sourceware.org
Cc:     David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v3 2/2] tests: test CLONE_CLEAR_SIGHAND
Date:   Mon, 14 Oct 2019 12:45:38 +0200
Message-Id: <20191014104538.3096-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014104538.3096-1-christian.brauner@ubuntu.com>
References: <20191014104538.3096-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test that CLONE_CLEAR_SIGHAND resets signal handlers to SIG_DFL for the
child process and that CLONE_CLEAR_SIGHAND and CLONE_SIGHAND are
mutually exclusive.

Cc: Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org
Cc: linux-api@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
Link: https://lore.kernel.org/r/20191010133518.5420-2-christian.brauner@ubuntu.com

/* v2 */
Link: https://lore.kernel.org/r/20191011102537.27502-2-christian.brauner@ubuntu.com
- Christian Brauner <christian.brauner@ubuntu.com>:
  - remove unused variable
  - reuse variable in child process instead od declaring a new one
  - move check for mutual exclusivity of CLONE_SIGHAND and
    CLONE3_CLEAR_SIGHAND to top of test before setting up signal
    handlers
  - rename variables

/* v3 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - s/CLONE3_CLEAR_SIGHAND/CLONE_CLEAR_SIGHAND/g
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/clone3/.gitignore     |   1 +
 tools/testing/selftests/clone3/Makefile       |   7 +
 .../selftests/clone3/clone3_clear_sighand.c   | 172 ++++++++++++++++++
 5 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/clone3/.gitignore
 create mode 100644 tools/testing/selftests/clone3/Makefile
 create mode 100644 tools/testing/selftests/clone3/clone3_clear_sighand.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef7fa74..582275d85607 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12828,6 +12828,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
 F:	samples/pidfd/
 F:	tools/testing/selftests/pidfd/
+F:	tools/testing/selftests/clone3/
 K:	(?i)pidfd
 K:	(?i)clone3
 K:	\b(clone_args|kernel_clone_args)\b
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c3feccb99ff5..6bf7aeb47650 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -4,6 +4,7 @@ TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += capabilities
 TARGETS += cgroup
+TARGETS += clone3
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/selftests/clone3/.gitignore
new file mode 100644
index 000000000000..6c9f98097774
--- /dev/null
+++ b/tools/testing/selftests/clone3/.gitignore
@@ -0,0 +1 @@
+clone3_clear_sighand
diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
new file mode 100644
index 000000000000..3ecd56ebc99d
--- /dev/null
+++ b/tools/testing/selftests/clone3/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -g -I../../../../usr/include/
+
+TEST_GEN_PROGS := clone3_clear_sighand
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
new file mode 100644
index 000000000000..0d957be1bdc5
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+
+#ifndef CLONE_CLEAR_SIGHAND
+#define CLONE_CLEAR_SIGHAND 0x100000000ULL
+#endif
+
+#ifndef __NR_clone3
+#define __NR_clone3 -1
+struct clone_args {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+};
+#endif
+
+static pid_t sys_clone3(struct clone_args *args, size_t size)
+{
+	return syscall(__NR_clone3, args, size);
+}
+
+static void test_clone3_supported(void)
+{
+	pid_t pid;
+	struct clone_args args = {};
+
+	if (__NR_clone3 < 0)
+		ksft_exit_skip("clone3() syscall is not supported\n");
+
+	/* Set to something that will always cause EINVAL. */
+	args.exit_signal = -1;
+	pid = sys_clone3(&args, sizeof(args));
+	if (!pid)
+		exit(EXIT_SUCCESS);
+
+	if (pid > 0) {
+		wait(NULL);
+		ksft_exit_fail_msg(
+			"Managed to create child process with invalid exit_signal\n");
+	}
+
+	if (errno == ENOSYS)
+		ksft_exit_skip("clone3() syscall is not supported\n");
+
+	ksft_print_msg("clone3() syscall supported\n");
+}
+
+static void nop_handler(int signo)
+{
+}
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+static void test_clone3_clear_sighand(void)
+{
+	int ret;
+	pid_t pid;
+	struct clone_args args = {};
+	struct sigaction act;
+
+	/*
+	 * Check that CLONE_CLEAR_SIGHAND and CLONE_SIGHAND are mutually
+	 * exclusive.
+	 */
+	args.flags |= CLONE_CLEAR_SIGHAND | CLONE_SIGHAND;
+	args.exit_signal = SIGCHLD;
+	pid = sys_clone3(&args, sizeof(args));
+	if (pid > 0)
+		ksft_exit_fail_msg(
+			"clone3(CLONE_CLEAR_SIGHAND | CLONE_SIGHAND) succeeded\n");
+
+	act.sa_handler = nop_handler;
+	ret = sigemptyset(&act.sa_mask);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s - sigemptyset() failed\n",
+				   strerror(errno));
+
+	act.sa_flags = 0;
+
+	/* Register signal handler for SIGUSR1 */
+	ret = sigaction(SIGUSR1, &act, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s - sigaction(SIGUSR1, &act, NULL) failed\n",
+			strerror(errno));
+
+	/* Register signal handler for SIGUSR2 */
+	ret = sigaction(SIGUSR2, &act, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s - sigaction(SIGUSR2, &act, NULL) failed\n",
+			strerror(errno));
+
+	/* Check that CLONE_CLEAR_SIGHAND works. */
+	args.flags = CLONE_CLEAR_SIGHAND;
+	pid = sys_clone3(&args, sizeof(args));
+	if (pid < 0)
+		ksft_exit_fail_msg("%s - clone3(CLONE_CLEAR_SIGHAND) failed\n",
+				   strerror(errno));
+
+	if (pid == 0) {
+		ret = sigaction(SIGUSR1, NULL, &act);
+		if (ret < 0)
+			exit(EXIT_FAILURE);
+
+		if (act.sa_handler != SIG_DFL)
+			exit(EXIT_FAILURE);
+
+		ret = sigaction(SIGUSR2, NULL, &act);
+		if (ret < 0)
+			exit(EXIT_FAILURE);
+
+		if (act.sa_handler != SIG_DFL)
+			exit(EXIT_FAILURE);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	ret = wait_for_pid(pid);
+	if (ret)
+		ksft_exit_fail_msg(
+			"Failed to clear signal handler for child process\n");
+
+	ksft_test_result_pass("Cleared signal handlers for child process\n");
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	test_clone3_supported();
+	test_clone3_clear_sighand();
+
+	return ksft_exit_pass();
+}
-- 
2.23.0

