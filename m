Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA42D7824
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 16:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbfJOONx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 10:13:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39661 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732546AbfJOONl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 10:13:41 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKNZz-0004YA-8W; Tue, 15 Oct 2019 14:13:39 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Christian Kellner <christian@kellner.me>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/2] test: verify fdinfo for pidfd of reaped process
Date:   Tue, 15 Oct 2019 16:13:32 +0200
Message-Id: <20191015141332.4055-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015141332.4055-1-christian.brauner@ubuntu.com>
References: <20191015141332.4055-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test that the fdinfo field of a pidfd referring to a dead process
correctly shows Pid: -1 and NSpid: -1.

Cc: Christian Kellner <christian@kellner.me>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .../selftests/pidfd/pidfd_fdinfo_test.c       | 59 ++++++++++++++-----
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index 3721be994abd..22558524f71c 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -113,11 +113,15 @@ static struct child clone_newns(int (*fn)(void *), void *args,
 	return ret;
 }
 
+static inline void child_close(struct child *child)
+{
+	close(child->fd);
+}
+
 static inline int child_join(struct child *child, struct error *err)
 {
 	int r;
 
-	(void)close(child->fd);
 	r = wait_for_pid(child->pid);
 	if (r < 0)
 		error_set(err, PIDFD_ERROR, "waitpid failed (ret %d, errno %d)",
@@ -128,6 +132,12 @@ static inline int child_join(struct child *child, struct error *err)
 	return r;
 }
 
+static inline int child_join_close(struct child *child, struct error *err)
+{
+	child_close(child);
+	return child_join(child, err);
+}
+
 static inline void trim_newline(char *str)
 {
 	char *pos = strrchr(str, '\n');
@@ -136,8 +146,8 @@ static inline void trim_newline(char *str)
 		*pos = '\0';
 }
 
-static int verify_fdinfo_nspid(int pidfd, struct error *err,
-			       const char *expect, ...)
+static int verify_fdinfo(int pidfd, struct error *err, const char *prefix,
+			 size_t prefix_len, const char *expect, ...)
 {
 	char buffer[512] = {0, };
 	char path[512] = {0, };
@@ -160,17 +170,20 @@ static int verify_fdinfo_nspid(int pidfd, struct error *err,
 				 pidfd);
 
 	while (getline(&line, &n, f) != -1) {
-		if (strncmp(line, "NSpid:", 6))
+		char *val;
+
+		if (strncmp(line, prefix, prefix_len))
 			continue;
 
 		found = 1;
 
-		r = strcmp(line + 6, buffer);
+		val = line + prefix_len;
+		r = strcmp(val, buffer);
 		if (r != 0) {
 			trim_newline(line);
 			trim_newline(buffer);
-			error_set(err, PIDFD_FAIL, "NSpid: '%s' != '%s'",
-				  line + 6, buffer);
+			error_set(err, PIDFD_FAIL, "%s '%s' != '%s'",
+				  prefix, val, buffer);
 		}
 		break;
 	}
@@ -179,8 +192,8 @@ static int verify_fdinfo_nspid(int pidfd, struct error *err,
 	fclose(f);
 
 	if (found == 0)
-		return error_set(err, PIDFD_FAIL, "NSpid not found for fd %d",
-				 pidfd);
+		return error_set(err, PIDFD_FAIL, "%s not found for fd %d",
+				 prefix, pidfd);
 
 	return PIDFD_PASS;
 }
@@ -213,7 +226,7 @@ static int child_fdinfo_nspid_test(void *args)
 	}
 
 	pidfd = *(int *)args;
-	r = verify_fdinfo_nspid(pidfd, &err, "\t0\n");
+	r = verify_fdinfo(pidfd, &err, "NSpid:", 6, "\t0\n");
 
 	if (r != PIDFD_PASS)
 		ksft_print_msg("NSpid fdinfo check failed: %s\n", err.msg);
@@ -242,24 +255,42 @@ static void test_pidfd_fdinfo_nspid(void)
 	/* The children will have pid 1 in the new pid namespace,
 	 * so the line must be 'NSPid:\t<pid>\t1'.
 	 */
-	verify_fdinfo_nspid(a.fd, &err, "\t%d\t%d\n", a.pid, 1);
-	verify_fdinfo_nspid(b.fd, &err, "\t%d\t%d\n", b.pid, 1);
+	verify_fdinfo(a.fd, &err, "NSpid:", 6, "\t%d\t%d\n", a.pid, 1);
+	verify_fdinfo(b.fd, &err, "NSpid:", 6, "\t%d\t%d\n", b.pid, 1);
 
 	/* wait for the process, check the exit status and set
 	 * 'err' accordingly, if it is not already set.
 	 */
+	child_join_close(&a, &err);
+	child_join_close(&b, &err);
+
+	error_report(&err, test_name);
+}
+
+static void test_pidfd_dead_fdinfo(void)
+{
+	struct child a;
+	struct error err = {0, };
+	const char *test_name = "pidfd check fdinfo for dead process";
+
+	/* Create a new child in a new pid and mount namespace */
+	a = clone_newns(child_fdinfo_nspid_test, NULL, &err);
+	error_check(&err, test_name);
 	child_join(&a, &err);
-	child_join(&b, &err);
 
+	verify_fdinfo(a.fd, &err, "Pid:", 4, "\t-1\n");
+	verify_fdinfo(a.fd, &err, "NSpid:", 6, "\t-1\n");
+	child_close(&a);
 	error_report(&err, test_name);
 }
 
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 
 	test_pidfd_fdinfo_nspid();
+	test_pidfd_dead_fdinfo();
 
 	return ksft_exit_pass();
 }
-- 
2.23.0

