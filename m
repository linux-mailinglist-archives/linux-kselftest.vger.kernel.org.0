Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252F81400C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 01:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgAQAVw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 19:21:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54618 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgAQAVw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 19:21:52 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1isFOX-0001a1-G3; Fri, 17 Jan 2020 00:21:49 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/5] selftests/cgroup: add tests for cloning into cgroups
Date:   Fri, 17 Jan 2020 01:21:43 +0100
Message-Id: <20200117002143.15559-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117002143.15559-1-christian.brauner@ubuntu.com>
References: <20200117002143.15559-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Expand the cgroup test-suite to include tests for CLONE_INTO_CGROUP.
This adds the following tests:
- CLONE_INTO_CGROUP manages to clone a process directly into a correctly
  delegated cgroup
- CLONE_INTO_CGROUP fails to clone a process into a cgroup that has been
  removed after we've opened an fd to it
- CLONE_INTO_CGROUP fails to clone a process into an invalid domain
  cgroup
- CLONE_INTO_CGROUP adheres to the no internal process constraint
- CLONE_INTO_CGROUP works with the freezer feature

Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
Link: https://lore.kernel.org/r/20191218173516.7875-4-christian.brauner@ubuntu.com

/* v2 */
Link: https://lore.kernel.org/r/20191223061504.28716-4-christian.brauner@ubuntu.com
unchanged

/* v3 */
unchanged
---
 tools/testing/selftests/cgroup/Makefile       |   6 +-
 tools/testing/selftests/cgroup/cgroup_util.c  | 126 ++++++++++++++++++
 tools/testing/selftests/cgroup/cgroup_util.h  |   4 +
 tools/testing/selftests/cgroup/test_core.c    |  64 +++++++++
 .../selftests/clone3/clone3_selftests.h       |  19 ++-
 5 files changed, 214 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 66aafe1f5746..967f268fde74 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -11,6 +11,6 @@ TEST_GEN_PROGS += test_freezer
 
 include ../lib.mk
 
-$(OUTPUT)/test_memcontrol: cgroup_util.c
-$(OUTPUT)/test_core: cgroup_util.c
-$(OUTPUT)/test_freezer: cgroup_util.c
+$(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
+$(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
+$(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 8f7131dcf1ff..8a637ca7d73a 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include "cgroup_util.h"
+#include "../clone3/clone3_selftests.h"
 
 static ssize_t read_text(const char *path, char *buf, size_t max_len)
 {
@@ -331,12 +332,112 @@ int cg_run(const char *cgroup,
 	}
 }
 
+pid_t clone_into_cgroup(int cgroup_fd)
+{
+#ifdef CLONE_ARGS_SIZE_VER2
+	pid_t pid;
+
+	struct clone_args args = {
+		.flags = CLONE_INTO_CGROUP,
+		.exit_signal = SIGCHLD,
+		.cgroup = cgroup_fd,
+	};
+
+	pid = sys_clone3(&args, sizeof(struct clone_args));
+	/*
+	 * Verify that this is a genuine test failure:
+	 * ENOSYS -> clone3() not available
+	 * E2BIG  -> CLONE_INTO_CGROUP not available
+	 */
+	if (pid < 0 && (errno == ENOSYS || errno == E2BIG))
+		goto pretend_enosys;
+
+	return pid;
+
+pretend_enosys:
+#endif
+	errno = ENOSYS;
+	return -ENOSYS;
+}
+
+int clone_reap(pid_t pid, int options)
+{
+	int ret;
+	siginfo_t info = {
+		.si_signo = 0,
+	};
+
+again:
+	ret = waitid(P_PID, pid, &info, options | __WALL | __WNOTHREAD);
+	if (ret < 0) {
+		if (errno == EINTR)
+			goto again;
+		return -1;
+	}
+
+	if (options & WEXITED) {
+		if (WIFEXITED(info.si_status))
+			return WEXITSTATUS(info.si_status);
+	}
+
+	if (options & WSTOPPED) {
+		if (WIFSTOPPED(info.si_status))
+			return WSTOPSIG(info.si_status);
+	}
+
+	if (options & WCONTINUED) {
+		if (WIFCONTINUED(info.si_status))
+			return 0;
+	}
+
+	return -1;
+}
+
+int dirfd_open_opath(const char *dir)
+{
+	return open(dir, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
+}
+
+#define close_prot_errno(fd)                                                   \
+	if (fd >= 0) {                                                         \
+		int _e_ = errno;                                               \
+		close(fd);                                                     \
+		errno = _e_;                                                   \
+	}
+
+static int clone_into_cgroup_run_nowait(const char *cgroup,
+					int (*fn)(const char *cgroup, void *arg),
+					void *arg)
+{
+	int cgroup_fd;
+	pid_t pid;
+
+	cgroup_fd =  dirfd_open_opath(cgroup);
+	if (cgroup_fd < 0)
+		return -1;
+
+	pid = clone_into_cgroup(cgroup_fd);
+	close_prot_errno(cgroup_fd);
+	if (pid == 0)
+		exit(fn(cgroup, arg));
+
+	return pid;
+}
+
 int cg_run_nowait(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
 		  void *arg)
 {
 	int pid;
 
+	pid = clone_into_cgroup_run_nowait(cgroup, fn, arg);
+	if (pid > 0)
+		return pid;
+
+	/* Genuine test failure. */
+	if (pid < 0 && errno != ENOSYS)
+		return -1;
+
 	pid = fork();
 	if (pid == 0) {
 		char buf[64];
@@ -450,3 +551,28 @@ int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)
 
 	return strstr(buf, needle) ? 0 : -1;
 }
+
+int clone_into_cgroup_run_wait(const char *cgroup)
+{
+	int cgroup_fd;
+	pid_t pid;
+
+	cgroup_fd =  dirfd_open_opath(cgroup);
+	if (cgroup_fd < 0)
+		return -1;
+
+	pid = clone_into_cgroup(cgroup_fd);
+	close_prot_errno(cgroup_fd);
+	if (pid < 0)
+		return -1;
+
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+
+	/*
+	 * We don't care whether this fails. We only care whether the initial
+	 * clone succeeded.
+	 */
+	(void)clone_reap(pid, WEXITED);
+	return 0;
+}
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 49c54fbdb229..5a1305dd1f0b 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -50,3 +50,7 @@ extern int cg_wait_for_proc_count(const char *cgroup, int count);
 extern int cg_killall(const char *cgroup);
 extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size);
 extern int proc_read_strstr(int pid, bool thread, const char *item, const char *needle);
+extern pid_t clone_into_cgroup(int cgroup_fd);
+extern int clone_reap(pid_t pid, int options);
+extern int clone_into_cgroup_run_wait(const char *cgroup);
+extern int dirfd_open_opath(const char *dir);
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index c5ca669feb2b..96e016ccafe0 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -25,8 +25,11 @@
 static int test_cgcore_populated(const char *root)
 {
 	int ret = KSFT_FAIL;
+	int err;
 	char *cg_test_a = NULL, *cg_test_b = NULL;
 	char *cg_test_c = NULL, *cg_test_d = NULL;
+	int cgroup_fd = -EBADF;
+	pid_t pid;
 
 	cg_test_a = cg_name(root, "cg_test_a");
 	cg_test_b = cg_name(root, "cg_test_a/cg_test_b");
@@ -78,6 +81,52 @@ static int test_cgcore_populated(const char *root)
 	if (cg_read_strcmp(cg_test_d, "cgroup.events", "populated 0\n"))
 		goto cleanup;
 
+	/* Test that we can directly clone into a new cgroup. */
+	cgroup_fd = dirfd_open_opath(cg_test_d);
+	if (cgroup_fd < 0)
+		goto cleanup;
+
+	pid = clone_into_cgroup(cgroup_fd);
+	if (pid < 0) {
+		if (errno == ENOSYS)
+			goto cleanup_pass;
+		goto cleanup;
+	}
+
+	if (pid == 0) {
+		if (raise(SIGSTOP))
+			exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
+	}
+
+	err = cg_read_strcmp(cg_test_d, "cgroup.events", "populated 1\n");
+
+	(void)clone_reap(pid, WSTOPPED);
+	(void)kill(pid, SIGCONT);
+	(void)clone_reap(pid, WEXITED);
+
+	if (err)
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_test_d, "cgroup.events", "populated 0\n"))
+		goto cleanup;
+
+	/* Remove cgroup. */
+	if (cg_test_d) {
+		cg_destroy(cg_test_d);
+		free(cg_test_d);
+		cg_test_d = NULL;
+	}
+
+	pid = clone_into_cgroup(cgroup_fd);
+	if (pid < 0)
+		goto cleanup_pass;
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+	(void)clone_reap(pid, WEXITED);
+	goto cleanup;
+
+cleanup_pass:
 	ret = KSFT_PASS;
 
 cleanup:
@@ -93,6 +142,8 @@ static int test_cgcore_populated(const char *root)
 	free(cg_test_c);
 	free(cg_test_b);
 	free(cg_test_a);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
 	return ret;
 }
 
@@ -136,6 +187,16 @@ static int test_cgcore_invalid_domain(const char *root)
 	if (errno != EOPNOTSUPP)
 		goto cleanup;
 
+	if (!clone_into_cgroup_run_wait(child))
+		goto cleanup;
+
+	if (errno == ENOSYS)
+		goto cleanup_pass;
+
+	if (errno != EOPNOTSUPP)
+		goto cleanup;
+
+cleanup_pass:
 	ret = KSFT_PASS;
 
 cleanup:
@@ -345,6 +406,9 @@ static int test_cgcore_internal_process_constraint(const char *root)
 	if (!cg_enter_current(parent))
 		goto cleanup;
 
+	if (!clone_into_cgroup_run_wait(parent))
+		goto cleanup;
+
 	ret = KSFT_PASS;
 
 cleanup:
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index a3f2c8ad8bcc..91c1a78ddb39 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -5,12 +5,24 @@
 
 #define _GNU_SOURCE
 #include <sched.h>
+#include <linux/sched.h>
+#include <linux/types.h>
 #include <stdint.h>
 #include <syscall.h>
-#include <linux/types.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
 
 #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
 
+#ifndef CLONE_INTO_CGROUP
+#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#endif
+
+#ifndef CLONE_ARGS_SIZE_VER0
+#define CLONE_ARGS_SIZE_VER0 64
+#endif
+
 #ifndef __NR_clone3
 #define __NR_clone3 -1
 struct clone_args {
@@ -22,10 +34,13 @@ struct clone_args {
 	__aligned_u64 stack;
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
+#define CLONE_ARGS_SIZE_VER1 80
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
+#define CLONE_ARGS_SIZE_VER2 88
+	__aligned_u64 cgroup;
 };
-#endif
+#endif /* __NR_clone3 */
 
 static pid_t sys_clone3(struct clone_args *args, size_t size)
 {
-- 
2.25.0

