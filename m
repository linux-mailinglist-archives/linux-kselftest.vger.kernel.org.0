Return-Path: <linux-kselftest+bounces-37257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079A9B0411D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 16:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BCC3A69BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7FB255F5E;
	Mon, 14 Jul 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIG4NKl/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD8255F33;
	Mon, 14 Jul 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502333; cv=none; b=RfsDDUMT1YkMTjDZUin3cdLCXtBVEbqn0E5eWyeikiIauyWVluXUOIWmk2pBNwLU80bkmu1/rA862+7q4gKIIBGK5EIEdxxM2Kd5h+6GRQgPR0nUnyODmxOihfQKGZg6dQQS+4gBxi/F8D+BSrSedSJm/FoEuiXmH1pMnKqccmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502333; c=relaxed/simple;
	bh=4LCta4AcPLkHFIbPLGXR+o9N2HzgQeovSeXRL839j+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PazZ1KA1On/9D9t2EWimKVtYei+2ynkqLAH5SvfQVlySVZ+/joBl/VPT1QjPaNewQ8JNHzlXYM0AKmurRQNZkqHcV0/8smUIPY7UGATzEBaqEPXc79W8czOa0H84zIThsC0E7xMjign86IpY6QYI3FpisDj7/4DlnKPhzGwaZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIG4NKl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68487C4CEED;
	Mon, 14 Jul 2025 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752502332;
	bh=4LCta4AcPLkHFIbPLGXR+o9N2HzgQeovSeXRL839j+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VIG4NKl/nlGjqld3dthVXd37Cqr8FLwTXtFq0a8+kTp+e+mLjRbXltl6/27YFOSMl
	 w3VOUstiBa5zYx/FbLoMKe+XWWLlfx8C3+hEuL+yySTD+HjIghxDSpxTSrUb+PQx8E
	 O9PxH3QRaYwSDIjc5LW9t5m4JHKLAJNrxCVjmYIQ4zyBiK4aG+Y2mKZxgxNx00TOPp
	 BPspFrAzZu+jPlic6BzeLuhE5yWX6rwbsmUUW3+j06I0fqlb7qCrohcKqW2tPnAPBc
	 QjunBxdrWRKopNk6DqNCKMzTQLbZri5I/MXwvlrod/6PiZ44fmL6h/MhArjQ3gqcmL
	 5uzDS74xlgG9g==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Jul 2025 15:03:35 +0100
Subject: [PATCH 1/2] selftests/fchmodat2: Clean up temporary files and
 directories
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-selftests-fchmodat2-v1-1-b74f3ee0d09c@kernel.org>
References: <20250714-selftests-fchmodat2-v1-0-b74f3ee0d09c@kernel.org>
In-Reply-To: <20250714-selftests-fchmodat2-v1-0-b74f3ee0d09c@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=7319; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4LCta4AcPLkHFIbPLGXR+o9N2HzgQeovSeXRL839j+k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBodRA3xVa8wlKFi2iGOj7QXYD6I6fmA4YDSy9QR
 5BqD8zRbUCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHUQNwAKCRAk1otyXVSH
 0KFCB/43PPT36yxbtn1JltjRV0VnGceR77jnZqzAhleO7YrEXq3c/NfcO00qFc4GvsQmXwFzrzB
 tncWBqynoKQ+JykE64n0SOralEt7WPPPm9m10M+LgN8J2IN3Sa4rKScL33fvloE8HqOmriPbckn
 3wAKfaeQmwEb+bYzhlISkC/k6ukd/Ip3zo3kADCP/9P+UseMWdGNvSTMOlDXAmeo/By/CF8WiIl
 286gwKFAmfLnsCmHYXjMsWy+Ypa+29QQO1gcUWdVz9P7VebNOAGZ4gRyhjtLLS3Dk9jo/AIIp+o
 2QYou+1eY8GLIrZcKuPKxd55MZLN9HxiOQVRaxTolJFCn7+n
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The fchmodat2() test program creates a temporary directory with a file and
a symlink for every test it runs but never cleans these up, resulting in
${TMPDIR} getting left with stale files after every run. Restructure the
program a bit to ensure that we clean these up, this is more invasive than
it might otherwise be due to the extensive use of ksft_exit_fail_msg() in
the program.

As a side effect this also ensures that we report a consistent test name
for the tests and always try both tests even if they are skipped.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 161 ++++++++++++++-------
 1 file changed, 111 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e0319417124d..e977d942c00b 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -9,6 +9,11 @@
 
 #include "../kselftest.h"
 
+struct testdir {
+	char *dirname;
+	int dfd;
+};
+
 int sys_fchmodat2(int dfd, const char *filename, mode_t mode, int flags)
 {
 	int ret = syscall(__NR_fchmodat2, dfd, filename, mode, flags);
@@ -16,9 +21,9 @@ int sys_fchmodat2(int dfd, const char *filename, mode_t mode, int flags)
 	return ret >= 0 ? ret : -errno;
 }
 
-int setup_testdir(void)
+static void setup_testdir(struct testdir *testdir)
 {
-	int dfd, ret;
+	int ret, dfd;
 	char dirname[] = "/tmp/ksft-fchmodat2.XXXXXX";
 
 	/* Make the top-level directory. */
@@ -26,21 +31,48 @@ int setup_testdir(void)
 		ksft_exit_fail_msg("%s: failed to create tmpdir\n", __func__);
 
 	dfd = open(dirname, O_PATH | O_DIRECTORY);
-	if (dfd < 0)
-		ksft_exit_fail_msg("%s: failed to open tmpdir\n", __func__);
+	if (dfd < 0) {
+		ksft_perror("failed to open tmpdir");
+		goto err;
+	}
 
 	ret = openat(dfd, "regfile", O_CREAT | O_WRONLY | O_TRUNC, 0644);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s: failed to create file in tmpdir\n",
-				__func__);
+	if (ret < 0) {
+		ksft_perror("failed to create file in tmpdir");
+		goto err;
+	}
 	close(ret);
 
 	ret = symlinkat("regfile", dfd, "symlink");
-	if (ret < 0)
-		ksft_exit_fail_msg("%s: failed to create symlink in tmpdir\n",
-				__func__);
+	if (ret < 0) {
+		ksft_perror("symlinkat() failed");
+		goto err_regfile;
+	}
+
+	testdir->dirname = strdup(dirname);
+	if (!testdir->dirname) {
+		ksft_perror("Out of memory");
+		goto err_symlink;
+	}
+	testdir->dfd = dfd;
+
+	return;
+
+err_symlink:
+	unlinkat(testdir->dfd, "symlink", 0);
+err_regfile:
+	unlinkat(testdir->dfd, "regfile", 0);
+err:
+	unlink(dirname);
+	ksft_exit_fail();
+}
 
-	return dfd;
+static void cleanup_testdir(struct testdir *testdir)
+{
+	unlinkat(testdir->dfd, "regfile", 0);
+	unlinkat(testdir->dfd, "symlink", 0);
+	rmdir(testdir->dirname);
+	free(testdir->dirname);
 }
 
 int expect_mode(int dfd, const char *filename, mode_t expect_mode)
@@ -48,61 +80,80 @@ int expect_mode(int dfd, const char *filename, mode_t expect_mode)
 	struct stat st;
 	int ret = fstatat(dfd, filename, &st, AT_SYMLINK_NOFOLLOW);
 
-	if (ret)
-		ksft_exit_fail_msg("%s: %s: fstatat failed\n",
-				__func__, filename);
+	if (ret) {
+		ksft_perror("fstatat() failed\n");
+		return 0;
+	}
 
 	return (st.st_mode == expect_mode);
 }
 
 void test_regfile(void)
 {
-	int dfd, ret;
-
-	dfd = setup_testdir();
+	struct testdir testdir;
+	int ret;
 
-	ret = sys_fchmodat2(dfd, "regfile", 0640, 0);
+	setup_testdir(&testdir);
 
-	if (ret < 0)
-		ksft_exit_fail_msg("%s: fchmodat2(noflag) failed\n", __func__);
-
-	if (!expect_mode(dfd, "regfile", 0100640))
-		ksft_exit_fail_msg("%s: wrong file mode bits after fchmodat2\n",
-				__func__);
+	ret = sys_fchmodat2(testdir.dfd, "regfile", 0640, 0);
 
-	ret = sys_fchmodat2(dfd, "regfile", 0600, AT_SYMLINK_NOFOLLOW);
+	if (ret < 0) {
+		ksft_perror("fchmodat2(noflag) failed");
+		goto out;
+	}
 
-	if (ret < 0)
-		ksft_exit_fail_msg("%s: fchmodat2(AT_SYMLINK_NOFOLLOW) failed\n",
+	if (!expect_mode(testdir.dfd, "regfile", 0100640)) {
+		ksft_print_msg("%s: wrong file mode bits after fchmodat2\n",
 				__func__);
-
-	if (!expect_mode(dfd, "regfile", 0100600))
-		ksft_exit_fail_msg("%s: wrong file mode bits after fchmodat2 with nofollow\n",
-				__func__);
-
-	ksft_test_result_pass("fchmodat2(regfile)\n");
+		ret = 1;
+		goto out;
+	}
+
+	ret = sys_fchmodat2(testdir.dfd, "regfile", 0600, AT_SYMLINK_NOFOLLOW);
+
+	if (ret < 0) {
+		ksft_perror("fchmodat2(AT_SYMLINK_NOFOLLOW) failed");
+		goto out;
+	}
+
+	if (!expect_mode(testdir.dfd, "regfile", 0100600)) {
+		ksft_print_msg("%s: wrong file mode bits after fchmodat2 with nofollow\n",
+			       __func__);
+		ret = 1;
+	}
+
+out:
+	ksft_test_result(ret == 0, "fchmodat2(regfile)\n");
+	cleanup_testdir(&testdir);
 }
 
 void test_symlink(void)
 {
-	int dfd, ret;
+	struct testdir testdir;
+	int ret;
 
-	dfd = setup_testdir();
+	setup_testdir(&testdir);
 
-	ret = sys_fchmodat2(dfd, "symlink", 0640, 0);
+	ret = sys_fchmodat2(testdir.dfd, "symlink", 0640, 0);
 
-	if (ret < 0)
-		ksft_exit_fail_msg("%s: fchmodat2(noflag) failed\n", __func__);
+	if (ret < 0) {
+		ksft_perror("fchmodat2(noflag) failed");
+		goto err;
+	}
 
-	if (!expect_mode(dfd, "regfile", 0100640))
-		ksft_exit_fail_msg("%s: wrong file mode bits after fchmodat2\n",
-				__func__);
+	if (!expect_mode(testdir.dfd, "regfile", 0100640)) {
+		ksft_print_msg("%s: wrong file mode bits after fchmodat2\n",
+			       __func__);
+		goto err;
+	}
 
-	if (!expect_mode(dfd, "symlink", 0120777))
-		ksft_exit_fail_msg("%s: wrong symlink mode bits after fchmodat2\n",
-				__func__);
+	if (!expect_mode(testdir.dfd, "symlink", 0120777)) {
+		ksft_print_msg("%s: wrong symlink mode bits after fchmodat2\n",
+			       __func__);
+		goto err;
+	}
 
-	ret = sys_fchmodat2(dfd, "symlink", 0600, AT_SYMLINK_NOFOLLOW);
+	ret = sys_fchmodat2(testdir.dfd, "symlink", 0600, AT_SYMLINK_NOFOLLOW);
 
 	/*
 	 * On certain filesystems (xfs or btrfs), chmod operation fails. So we
@@ -111,18 +162,28 @@ void test_symlink(void)
 	 *
 	 * https://sourceware.org/legacy-ml/libc-alpha/2020-02/msg00467.html
 	 */
-	if (ret == 0 && !expect_mode(dfd, "symlink", 0120600))
-		ksft_exit_fail_msg("%s: wrong symlink mode bits after fchmodat2 with nofollow\n",
+	if (ret == 0 && !expect_mode(testdir.dfd, "symlink", 0120600)) {
+		ksft_print_msg("%s: wrong symlink mode bits after fchmodat2 with nofollow\n",
 				__func__);
+		ret = 1;
+		goto err;
+	}
 
-	if (!expect_mode(dfd, "regfile", 0100640))
-		ksft_exit_fail_msg("%s: wrong file mode bits after fchmodat2 with nofollow\n",
-				__func__);
+	if (!expect_mode(testdir.dfd, "regfile", 0100640)) {
+		ksft_print_msg("%s: wrong file mode bits after fchmodat2 with nofollow\n",
+			       __func__);
+	}
 
 	if (ret != 0)
 		ksft_test_result_skip("fchmodat2(symlink)\n");
 	else
 		ksft_test_result_pass("fchmodat2(symlink)\n");
+	cleanup_testdir(&testdir);
+	return;
+
+err:
+	ksft_test_result_fail("fchmodat2(symlink)\n");
+	cleanup_testdir(&testdir);
 }
 
 #define NUM_TESTS 2

-- 
2.39.5


