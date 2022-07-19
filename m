Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7558057A945
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiGSVq2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiGSVqD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:46:03 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2B5A61D4D;
        Tue, 19 Jul 2022 14:45:51 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj4NH002586;
        Tue, 19 Jul 2022 23:45:04 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 06/17] selftests/nolibc: implement a few tests for various syscalls
Date:   Tue, 19 Jul 2022 23:44:37 +0200
Message-Id: <20220719214449.2520-7-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220719214449.2520-1-w@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds 63 tests covering about 34 syscalls. Both successes and
failures are tested. Two tests fail when run as unprivileged user
(link_dir which returns EACCESS instead of EPERM, and chroot which
returns EPERM). One test (execve("/")) expects to fail on EACCESS,
but needs to have valid arguments otherwise the kernel will log a
message. And a few tests require /proc to be mounted.

The code is not pretty since all tests are one-liners, sometimes
resulting in long lines, especially when using compount statements to
preset a line, but it's convenient and doesn't obfuscate the code,
which is important to understand what failed.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 110 +++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 49177ea9943c..dc87832912ce 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -388,9 +388,119 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 	case __LINE__: llen += printf("%d %s", test, #name);
 
 
+/* used by some syscall tests below */
+int test_getdents64(const char *dir)
+{
+	char buffer[4096];
+	int fd, ret;
+	int err;
+
+	ret = fd = open(dir, O_RDONLY | O_DIRECTORY, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = getdents64(fd, (void *)buffer, sizeof(buffer));
+	err = errno;
+	close(fd);
+
+	errno = err;
+	return ret;
+}
+
+/* Run syscall tests between IDs <min> and <max>.
+ * Return 0 on success, non-zero on failure.
+ */
+int run_syscall(int min, int max)
+{
+	struct stat stat_buf;
+	int test;
+	int tmp;
+	int ret = 0;
+	void *p1, *p2;
+
+	for (test = min; test >= 0 && test <= max; test++) {
+		int llen = 0; // line length
+
+		/* avoid leaving empty lines below, this will insert holes into
+		 * test numbers.
+		 */
+		switch (test + __LINE__ + 1) {
+		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
+		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
+		CASE_TEST(gettid);            EXPECT_SYSNE(1, gettid(), -1); break;
+		CASE_TEST(getpgid_self);      EXPECT_SYSNE(1, getpgid(0), -1); break;
+		CASE_TEST(getpgid_bad);       EXPECT_SYSER(1, getpgid(-1), -1, ESRCH); break;
+		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
+		CASE_TEST(kill_CONT);         EXPECT_SYSZR(1, kill(getpid(), 0)); break;
+		CASE_TEST(kill_BADPID);       EXPECT_SYSER(1, kill(INT_MAX, 0), -1, ESRCH); break;
+		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(1, (p2 == (void *)-1) || p2 == p1); break;
+		CASE_TEST(brk);               EXPECT_SYSZR(1, brk(sbrk(0))); break;
+		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
+		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
+		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
+		CASE_TEST(chmod_net);         EXPECT_SYSZR(1, chmod("/proc/self/net", 0555)); break;
+		CASE_TEST(chmod_self);        EXPECT_SYSER(1, chmod("/proc/self", 0555), -1, EPERM); break;
+		CASE_TEST(chown_self);        EXPECT_SYSER(1, chown("/proc/self", 0, 0), -1, EPERM); break;
+		CASE_TEST(chroot_root);       EXPECT_SYSZR(1, chroot("/")); break;
+		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
+		CASE_TEST(chroot_exe);        EXPECT_SYSER(1, chroot("/proc/self/exe"), -1, ENOTDIR); break;
+		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
+		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
+		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
+		CASE_TEST(dup_m1);            tmp = dup(-1); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
+		CASE_TEST(dup2_0);            tmp = dup2(0, 100);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
+		CASE_TEST(dup2_m1);           tmp = dup2(-1, 100); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
+		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
+		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
+		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
+		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
+		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
+		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
+		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
+		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
+		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
+		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
+		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
+		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
+		CASE_TEST(link_blah);         EXPECT_SYSER(1, link("/proc/self/blah", "/blah"), -1, ENOENT); break;
+		CASE_TEST(link_dir);          EXPECT_SYSER(1, link("/", "/blah"), -1, EPERM); break;
+		CASE_TEST(link_cross);        EXPECT_SYSER(1, link("/proc/self/net", "/blah"), -1, EXDEV); break;
+		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
+		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
+		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
+		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
+		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
+		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
+		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
+		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
+		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
+		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
+		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
+		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
+		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
+		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
+		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
+		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
+		CASE_TEST(unlink_blah);       EXPECT_SYSER(1, unlink("/proc/self/blah"), -1, ENOENT); break;
+		CASE_TEST(wait_child);        EXPECT_SYSER(1, wait(&tmp), -1, ECHILD); break;
+		CASE_TEST(waitpid_min);       EXPECT_SYSER(1, waitpid(INT_MIN, &tmp, WNOHANG), -1, ESRCH); break;
+		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
+		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
+		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
+		case __LINE__:
+			return ret; /* must be last */
+		/* note: do not set any defaults so as to permit holes above */
+		}
+	}
+	return ret;
+}
+
+
 /* This is the definition of known test names, with their functions */
 static struct test test_names[] = {
 	/* add new tests here */
+	{ .name = "syscall",   .func = run_syscall  },
 	{ 0 }
 };
 
-- 
2.17.5

