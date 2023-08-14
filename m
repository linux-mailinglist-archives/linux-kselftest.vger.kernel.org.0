Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0077B476
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjHNImY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjHNIl5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:57 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E3A12E;
        Mon, 14 Aug 2023 01:41:55 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RPSYr29qcz9sn2;
        Mon, 14 Aug 2023 10:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1692002512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7cNopV9QtwDfWAl6SLw4jWogCD7aoRQLSKJtTeB2Z4=;
        b=RMj4CUJ8Rvd/ZNQXo32QMV7F9lurzqTpsl02OwCu1jTFQ0n1d0fmf72WxHZ1ua+c7jCd9S
        D1E9rniYp4s34lLn7rTOmuQpmh3X6pRzrzURyHouUZnlH8th5qc4KVaHELYz6gQeWZpln9
        Vgr+Uwo20A0DzCdzDAKx/PsWiZrylfeBS0edlCGMrrdZhKBQMuJCc+nW+saFy+eUxwGf0d
        /C3mvRd8NQMshleiI648XFnhOm+WbbnHPwtFAXk+GOcWLpgSGxvim4H+QKq7B+9A3O8LTY
        AMH1dOh1rk34EaAWtAIFNW6K9gvaZ1cf5MF5xsgbBghS5oC5H3C0dlRfJeTWbA==
From:   Aleksa Sarai <cyphar@cyphar.com>
Date:   Mon, 14 Aug 2023 18:41:01 +1000
Subject: [PATCH v2 5/5] selftests: improve vm.memfd_noexec sysctl tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-memfd-vm-noexec-uapi-fixes-v2-5-7ff9e3e10ba6@cyphar.com>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
In-Reply-To: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13000; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=0sdx3MhmB3vX/NM+/SK9/yhr9yRSi3Geq1KMMGDcLxI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTcfLG2x/3+jGwuzwQtTl/LxLKg180rat3ZkqJalPZ28
 m4xPnS+o5SFQYyLQVZMkWWbn2fopvmLryR/WskGM4eVCWQIAxenAEzk2QFGhs4PXJ+fSNazrA34
 9lOx7d2F0lMb0t2/9PwKXp7O0yOxYwkjwxtGGx9O5lVLjRPsOj1U3HqnnHOabjbXuDJo82yHIOl
 6XgA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds proper tests for the nesting functionality of vm.memfd_noexec
as well as some minor cleanups to spawn_*_thread().

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 339 +++++++++++++++++++++--------
 1 file changed, 254 insertions(+), 85 deletions(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 8b7390ad81d1..3df008677239 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -18,6 +18,7 @@
 #include <sys/syscall.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <ctype.h>
 
 #include "common.h"
 
@@ -43,7 +44,6 @@
  */
 static size_t mfd_def_size = MFD_DEF_SIZE;
 static const char *memfd_str = MEMFD_STR;
-static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *));
 static int newpid_thread_fn2(void *arg);
 static void join_newpid_thread(pid_t pid);
 
@@ -96,12 +96,12 @@ static void sysctl_assert_write(const char *val)
 	int fd = open("/proc/sys/vm/memfd_noexec", O_WRONLY | O_CLOEXEC);
 
 	if (fd < 0) {
-		printf("open sysctl failed\n");
+		printf("open sysctl failed: %m\n");
 		abort();
 	}
 
 	if (write(fd, val, strlen(val)) < 0) {
-		printf("write sysctl failed\n");
+		printf("write sysctl %s failed: %m\n", val);
 		abort();
 	}
 }
@@ -111,7 +111,7 @@ static void sysctl_fail_write(const char *val)
 	int fd = open("/proc/sys/vm/memfd_noexec", O_WRONLY | O_CLOEXEC);
 
 	if (fd < 0) {
-		printf("open sysctl failed\n");
+		printf("open sysctl failed: %m\n");
 		abort();
 	}
 
@@ -122,6 +122,33 @@ static void sysctl_fail_write(const char *val)
 	}
 }
 
+static void sysctl_assert_equal(const char *val)
+{
+	char *p, buf[128] = {};
+	int fd = open("/proc/sys/vm/memfd_noexec", O_RDONLY | O_CLOEXEC);
+
+	if (fd < 0) {
+		printf("open sysctl failed: %m\n");
+		abort();
+	}
+
+	if (read(fd, buf, sizeof(buf)) < 0) {
+		printf("read sysctl failed: %m\n");
+		abort();
+	}
+
+	/* Strip trailing whitespace. */
+	p = buf;
+	while (!isspace(*p))
+		p++;
+	*p = '\0';
+
+	if (strcmp(buf, val) != 0) {
+		printf("unexpected sysctl value: expected %s, got %s\n", val, buf);
+		abort();
+	}
+}
+
 static int mfd_assert_reopen_fd(int fd_in)
 {
 	int fd;
@@ -736,7 +763,7 @@ static int idle_thread_fn(void *arg)
 	return 0;
 }
 
-static pid_t spawn_idle_thread(unsigned int flags)
+static pid_t spawn_thread(unsigned int flags, int (*fn)(void *), void *arg)
 {
 	uint8_t *stack;
 	pid_t pid;
@@ -747,10 +774,7 @@ static pid_t spawn_idle_thread(unsigned int flags)
 		abort();
 	}
 
-	pid = clone(idle_thread_fn,
-		    stack + STACK_SIZE,
-		    SIGCHLD | flags,
-		    NULL);
+	pid = clone(fn, stack + STACK_SIZE, SIGCHLD | flags, arg);
 	if (pid < 0) {
 		printf("clone() failed: %m\n");
 		abort();
@@ -759,6 +783,33 @@ static pid_t spawn_idle_thread(unsigned int flags)
 	return pid;
 }
 
+static void join_thread(pid_t pid)
+{
+	int wstatus;
+
+	if (waitpid(pid, &wstatus, 0) < 0) {
+		printf("newpid thread: waitpid() failed: %m\n");
+		abort();
+	}
+
+	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != 0) {
+		printf("newpid thread: exited with non-zero error code %d\n",
+		       WEXITSTATUS(wstatus));
+		abort();
+	}
+
+	if (WIFSIGNALED(wstatus)) {
+		printf("newpid thread: killed by signal %d\n",
+		       WTERMSIG(wstatus));
+		abort();
+	}
+}
+
+static pid_t spawn_idle_thread(unsigned int flags)
+{
+	return spawn_thread(flags, idle_thread_fn, NULL);
+}
+
 static void join_idle_thread(pid_t pid)
 {
 	kill(pid, SIGTERM);
@@ -1111,42 +1162,69 @@ static void test_noexec_seal(void)
 	close(fd);
 }
 
-static void test_sysctl_child(void)
+static void test_sysctl_sysctl0(void)
 {
 	int fd;
-	int pid;
 
-	printf("%s sysctl 0\n", memfd_str);
-	sysctl_assert_write("0");
-	fd = mfd_assert_new("kern_memfd_sysctl_0",
+	sysctl_assert_equal("0");
+
+	fd = mfd_assert_new("kern_memfd_sysctl_0_dfl",
 			    mfd_def_size,
 			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
-
 	mfd_assert_mode(fd, 0777);
 	mfd_assert_has_seals(fd, 0);
 	mfd_assert_chmod(fd, 0644);
 	close(fd);
+}
 
-	printf("%s sysctl 1\n", memfd_str);
-	sysctl_assert_write("1");
-	fd = mfd_assert_new("kern_memfd_sysctl_1",
+static void test_sysctl_set_sysctl0(void)
+{
+	sysctl_assert_write("0");
+	test_sysctl_sysctl0();
+}
+
+static void test_sysctl_sysctl1(void)
+{
+	int fd;
+
+	sysctl_assert_equal("1");
+
+	fd = mfd_assert_new("kern_memfd_sysctl_1_dfl",
 			    mfd_def_size,
 			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
 
-	printf("%s child ns\n", memfd_str);
-	pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn2);
-	join_newpid_thread(pid);
+	fd = mfd_assert_new("kern_memfd_sysctl_1_exec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_EXEC | MFD_ALLOW_SEALING);
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_chmod(fd, 0644);
+	close(fd);
 
+	fd = mfd_assert_new("kern_memfd_sysctl_1_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC_SEAL | MFD_ALLOW_SEALING);
 	mfd_assert_mode(fd, 0666);
 	mfd_assert_has_seals(fd, F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
-	sysctl_fail_write("0");
 	close(fd);
+}
 
-	printf("%s sysctl 2\n", memfd_str);
-	sysctl_assert_write("2");
-	mfd_fail_new("kern_memfd_sysctl_2_exec",
-		     MFD_EXEC | MFD_CLOEXEC | MFD_ALLOW_SEALING);
+static void test_sysctl_set_sysctl1(void)
+{
+	sysctl_assert_write("1");
+	test_sysctl_sysctl1();
+}
+
+static void test_sysctl_sysctl2(void)
+{
+	int fd;
+
+	sysctl_assert_equal("2");
 
 	fd = mfd_assert_new("kern_memfd_sysctl_2_dfl",
 			    mfd_def_size,
@@ -1156,98 +1234,188 @@ static void test_sysctl_child(void)
 	mfd_fail_chmod(fd, 0777);
 	close(fd);
 
-	fd = mfd_assert_new("kern_memfd_sysctl_2_noexec_seal",
+	mfd_fail_new("kern_memfd_sysctl_2_exec",
+		     MFD_CLOEXEC | MFD_EXEC | MFD_ALLOW_SEALING);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_2_noexec",
 			    mfd_def_size,
-			    MFD_NOEXEC_SEAL | MFD_CLOEXEC | MFD_ALLOW_SEALING);
+			    MFD_CLOEXEC | MFD_NOEXEC_SEAL | MFD_ALLOW_SEALING);
 	mfd_assert_mode(fd, 0666);
 	mfd_assert_has_seals(fd, F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
 	close(fd);
-
-	sysctl_fail_write("0");
-	sysctl_fail_write("1");
 }
 
-static int newpid_thread_fn(void *arg)
+static void test_sysctl_set_sysctl2(void)
 {
-	test_sysctl_child();
-	return 0;
+	sysctl_assert_write("2");
+	test_sysctl_sysctl2();
 }
 
-static void test_sysctl_child2(void)
+static int sysctl_simple_child(void *arg)
 {
 	int fd;
+	int pid;
 
-	sysctl_fail_write("0");
-	fd = mfd_assert_new("kern_memfd_sysctl_1",
-			    mfd_def_size,
-			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	printf("%s sysctl 0\n", memfd_str);
+	test_sysctl_set_sysctl0();
 
-	mfd_assert_mode(fd, 0666);
-	mfd_assert_has_seals(fd, F_SEAL_EXEC);
-	mfd_fail_chmod(fd, 0777);
-	close(fd);
+	printf("%s sysctl 1\n", memfd_str);
+	test_sysctl_set_sysctl1();
+
+	printf("%s sysctl 0\n", memfd_str);
+	test_sysctl_set_sysctl0();
+
+	printf("%s sysctl 2\n", memfd_str);
+	test_sysctl_set_sysctl2();
+
+	printf("%s sysctl 1\n", memfd_str);
+	test_sysctl_set_sysctl1();
+
+	printf("%s sysctl 0\n", memfd_str);
+	test_sysctl_set_sysctl0();
+
+	return 0;
+}
+
+/*
+ * Test sysctl
+ * A very basic test to make sure the core sysctl semantics work.
+ */
+static void test_sysctl_simple(void)
+{
+	int pid = spawn_thread(CLONE_NEWPID, sysctl_simple_child, NULL);
+
+	join_thread(pid);
 }
 
-static int newpid_thread_fn2(void *arg)
+static int sysctl_nested(void *arg)
 {
-	test_sysctl_child2();
+	void (*fn)(void) = arg;
+
+	fn();
 	return 0;
 }
-static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *))
+
+static int sysctl_nested_wait(void *arg)
 {
-	uint8_t *stack;
-	pid_t pid;
+	/* Wait for a SIGCONT. */
+	kill(getpid(), SIGSTOP);
+	return sysctl_nested(arg);
+}
 
-	stack = malloc(STACK_SIZE);
-	if (!stack) {
-		printf("malloc(STACK_SIZE) failed: %m\n");
-		abort();
-	}
+static void test_sysctl_sysctl1_failset(void)
+{
+	sysctl_fail_write("0");
+	test_sysctl_sysctl1();
+}
 
-	pid = clone(fn,
-		    stack + STACK_SIZE,
-		    SIGCHLD | flags,
-		    NULL);
-	if (pid < 0) {
-		printf("clone() failed: %m\n");
-		abort();
-	}
+static void test_sysctl_sysctl2_failset(void)
+{
+	sysctl_fail_write("1");
+	test_sysctl_sysctl2();
 
-	return pid;
+	sysctl_fail_write("0");
+	test_sysctl_sysctl2();
 }
 
-static void join_newpid_thread(pid_t pid)
+static int sysctl_nested_child(void *arg)
 {
-	int wstatus;
+	int fd;
+	int pid;
 
-	if (waitpid(pid, &wstatus, 0) < 0) {
-		printf("newpid thread: waitpid() failed: %m\n");
-		abort();
-	}
+	printf("%s nested sysctl 0\n", memfd_str);
+	sysctl_assert_write("0");
+	/* A further nested pidns works the same. */
+	pid = spawn_thread(CLONE_NEWPID, sysctl_simple_child, NULL);
+	join_thread(pid);
 
-	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != 0) {
-		printf("newpid thread: exited with non-zero error code %d\n",
-		       WEXITSTATUS(wstatus));
-		abort();
-	}
+	printf("%s nested sysctl 1\n", memfd_str);
+	sysctl_assert_write("1");
+	/* Child inherits our setting. */
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested, test_sysctl_sysctl1);
+	join_thread(pid);
+	/* Child cannot raise the setting. */
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested,
+			   test_sysctl_sysctl1_failset);
+	join_thread(pid);
+	/* Child can lower the setting. */
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested,
+			   test_sysctl_set_sysctl2);
+	join_thread(pid);
+	/* Child lowering the setting has no effect on our setting. */
+	test_sysctl_sysctl1();
+
+	printf("%s nested sysctl 2\n", memfd_str);
+	sysctl_assert_write("2");
+	/* Child inherits our setting. */
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested, test_sysctl_sysctl2);
+	join_thread(pid);
+	/* Child cannot raise the setting. */
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested,
+			   test_sysctl_sysctl2_failset);
+	join_thread(pid);
+
+	/* Verify that the rules are actually inherited after fork. */
+	printf("%s nested sysctl 0 -> 1 after fork\n", memfd_str);
+	sysctl_assert_write("0");
 
-	if (WIFSIGNALED(wstatus)) {
-		printf("newpid thread: killed by signal %d\n",
-		       WTERMSIG(wstatus));
-		abort();
-	}
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
+			   test_sysctl_sysctl1_failset);
+	sysctl_assert_write("1");
+	kill(pid, SIGCONT);
+	join_thread(pid);
+
+	printf("%s nested sysctl 0 -> 2 after fork\n", memfd_str);
+	sysctl_assert_write("0");
+
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
+			   test_sysctl_sysctl2_failset);
+	sysctl_assert_write("2");
+	kill(pid, SIGCONT);
+	join_thread(pid);
+
+	/*
+	 * Verify that the current effective setting is saved on fork, meaning
+	 * that the parent lowering the sysctl doesn't affect already-forked
+	 * children.
+	 */
+	printf("%s nested sysctl 2 -> 1 after fork\n", memfd_str);
+	sysctl_assert_write("2");
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
+			   test_sysctl_sysctl2);
+	sysctl_assert_write("1");
+	kill(pid, SIGCONT);
+	join_thread(pid);
+
+	printf("%s nested sysctl 2 -> 0 after fork\n", memfd_str);
+	sysctl_assert_write("2");
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
+			   test_sysctl_sysctl2);
+	sysctl_assert_write("0");
+	kill(pid, SIGCONT);
+	join_thread(pid);
+
+	printf("%s nested sysctl 1 -> 0 after fork\n", memfd_str);
+	sysctl_assert_write("1");
+	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
+			   test_sysctl_sysctl1);
+	sysctl_assert_write("0");
+	kill(pid, SIGCONT);
+	join_thread(pid);
+
+	return 0;
 }
 
 /*
- * Test sysctl
- * A very basic sealing test to see whether setting/retrieving seals works.
+ * Test sysctl with nested pid namespaces
+ * Make sure that the sysctl nesting semantics work correctly.
  */
-static void test_sysctl(void)
+static void test_sysctl_nested(void)
 {
-	int pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn);
+	int pid = spawn_thread(CLONE_NEWPID, sysctl_nested_child, NULL);
 
-	join_newpid_thread(pid);
+	join_thread(pid);
 }
 
 /*
@@ -1433,6 +1601,9 @@ int main(int argc, char **argv)
 	test_seal_grow();
 	test_seal_resize();
 
+	test_sysctl_simple();
+	test_sysctl_nested();
+
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
 	test_share_open("SHARE-OPEN", "");
@@ -1447,8 +1618,6 @@ int main(int argc, char **argv)
 	test_share_fork("SHARE-FORK", SHARED_FT_STR);
 	join_idle_thread(pid);
 
-	test_sysctl();
-
 	printf("memfd: DONE\n");
 
 	return 0;

-- 
2.41.0

