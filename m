Return-Path: <linux-kselftest+bounces-43186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F08BDE803
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FC2E4F3277
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA4258EC8;
	Wed, 15 Oct 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L40fFDFs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB531C7009;
	Wed, 15 Oct 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531863; cv=none; b=CezEn6Cq9TWXIR1Wqtklzw7BIHJ4tQHSw/1hdf3CQBXvBV5GyVeeRwXhJ5XhadMfIomqJH4ySoiUKuEZmz5uG1wHs4DCHA+VOnM/7C8xmZs5oH5FD4v7SmUxh2g0AO4vi1ehtBSkixey/EMvIgDZIAUMDfpwnOZNf7IXqofnIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531863; c=relaxed/simple;
	bh=BHPKxAbQgnmkQeeqZ3wj2h2jo5Rv84ayX3Lvy0+uHq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=naQ11hAs8/rC5gbsf3szp93I+H0fanaGXh6EZx0t0eQEJdYrZrw0G/Ed9rrR3hQeMsYn1lD9sjxUf77zjFQ2ib1l9kdqFPwoXDhN1Uii0PDqPHY6fYwVVxQjddCDDghZB8Sp+9aKr9FCM1JxzX67JmLCEgORYeQ14/lCxJrtRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L40fFDFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BA9C116D0;
	Wed, 15 Oct 2025 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531863;
	bh=BHPKxAbQgnmkQeeqZ3wj2h2jo5Rv84ayX3Lvy0+uHq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L40fFDFsDy3GruFfEpBtdHeY2kcKY/0d9Q8qtFWsdkp9K5dSHwL6bNcvrU1+cnvoX
	 xuOmZ/Zm7KPRoMfwblv5DTt7BzWyEO/dWm5hzhJ1yn33wTGhuHryfGmiBc8xfBdROB
	 2jqT1LNZxl+rhD67DazJGbA+gcuMLqUKq4Kx5lPyiY4hOgbwWLytZRHagT5Ny1OHWp
	 agLueopnTcanLyKIUIbFxDkInFMu2hESjpFuZZE0Vs8Y0TNqdjc0E30DEMRGIaeAKE
	 zDiW0tCpWZXE3RjHGWMhtkZPbxgcIz79a6X2HA4YkWri11bSWruHXBylESfCU3DlVw
	 aAEYxCGZcx2pg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 13:36:25 +0100
Subject: [PATCH v3 1/2] selftests/fchmodat2: Clean up temporary files and
 directories
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-selftests-fchmodat2-v3-1-f243fd281439@kernel.org>
References: <20251015-selftests-fchmodat2-v3-0-f243fd281439@kernel.org>
In-Reply-To: <20251015-selftests-fchmodat2-v3-0-f243fd281439@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=7319; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BHPKxAbQgnmkQeeqZ3wj2h2jo5Rv84ayX3Lvy0+uHq4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75WStVVuOVL6/sPwVLi//YvQnRRR8DzDCh829
 Fcol/xkyeCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+VkgAKCRAk1otyXVSH
 0O6nB/9g+dj1bh8dZo5U6EV3zBP1j9TsHFVy0yUmu+Pkz7K4GAgBwiY3ZXnspD0RQe3gL8z1Ac7
 Z1aaLcmUG65ceyJh9TNfK6gWt7HvUK1U9IqqwcuQkIRsP4+54hyKmyW9/tOmiNYMD/AVut8DvJM
 cq9PE7tJxNjQleFMRhjn3owNpO5V+VH4crOnDEBqiC5QKvIqG5KyvWNL/eCBRssn4r9xasBh32j
 Cj+OWr2LeW9umCR5VkReKlene560h7E8+JBHxO5yNajmN0WO++8IjJRUxmPEazLyrzr/FLnww78
 xXgGJaO9YK2X/dzmJxxSI9eGRG8Pjxj6Q4hzOwJpJenc4kwv
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
2.47.2


