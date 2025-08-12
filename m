Return-Path: <linux-kselftest+bounces-38771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7BCB226DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99499563A19
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747CE18DB02;
	Tue, 12 Aug 2025 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7FMKKpq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F81684B4;
	Tue, 12 Aug 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001825; cv=none; b=TU9TJCej/kfSUe7K1p43TZqjLz7ESaMiQnlbBTbH2Utn5iegLVwrzrbK+tQMoRbQBOr60+Ce6l729cu8XFdvyu4GI9/yHYQhiMzG8xKBD2KmcAli4iAnr9te04/ATbOxEv5zfKVc3sYU2JtbBgAbLrNAyERPQyYCLdiXyzLMhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001825; c=relaxed/simple;
	bh=4LCta4AcPLkHFIbPLGXR+o9N2HzgQeovSeXRL839j+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHkqH5wr/s5WRXx2SzNk87GEx2MMc0r6dxvaF7OTUlfBRXcMO0MRrgO1FRXt083ujMLjiiDd7NoogFnTiXSIi/+5oEvPZc3KIOm7In7Z9KJGoVgjVTOwLJXF7DiXMgCK91qle+oDqpQ8GhXPNleH9VARg3UMFc2YgAFtoAsbsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7FMKKpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40083C4CEF4;
	Tue, 12 Aug 2025 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755001824;
	bh=4LCta4AcPLkHFIbPLGXR+o9N2HzgQeovSeXRL839j+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a7FMKKpqUtPufZZbAmKDdgwGLQBcbHSTQVZWOJmDc+gc1EIcPmINUvVaMD0VqefJ+
	 kF4KjU5OIMTUFmEy426WSzfIJ1EtV6hoBMxJkR655CKK/LZZIQRHTzVgPFzZqna1H/
	 miy9PonvgIAsUBLfLT/eg782qqlpE0bNN/azWK5GLpkweA+BcV5lC2KIupBJpqY0io
	 DZhrZArVASsk77FDi3imPhyOSZM7YuJB/70+km7k6rO87MJc9NCxw/B5JMSUOSwcQ9
	 gfOCJFMmPC7ZHleIgeK/snVstbsUGQ/w55UlpKZIty6Y+fiZ6MFjPk7exnDxrH2Qgg
	 h6M50P0NxILBw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Aug 2025 13:00:49 +0100
Subject: [PATCH v2 1/2] selftests/fchmodat2: Clean up temporary files and
 directories
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-selftests-fchmodat2-v2-1-f2d5380e94c3@kernel.org>
References: <20250812-selftests-fchmodat2-v2-0-f2d5380e94c3@kernel.org>
In-Reply-To: <20250812-selftests-fchmodat2-v2-0-f2d5380e94c3@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=7319; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4LCta4AcPLkHFIbPLGXR+o9N2HzgQeovSeXRL839j+k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBomzPaV7fUUFZlbFhX1/MDijNZKEzW+5YEenZ5+
 s8TA6RIKOCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaJsz2gAKCRAk1otyXVSH
 0IJ6B/9v7r+WkyCnjmTzLhlpXMnS/93eTue/8dvDeAaTQZ4DYGPzvE4r6mjKH8Ix7mBN2vNDhvk
 pFP22lF1aqEwvQ9bD7u3CFE3CfhZWIQRDik9LO02JOWVErCtFpA4E0fD3Qy8QLuBjiR46MQSalK
 cJCND1xITaWSd7FMALr20/Z03SOgaRGDeZj6ueVSxaBUyORZ191KaaJY54711rJ8H7DIn+jqXHG
 8SZGUa+KGGQWlUEN5jODSa1zDuMN6Rb+iqCOSZIdiPel6TGTNGmaom7r6oSsl4e1TTVLrrITz8r
 fngcyBhfuOIh7v/DCrNl9exUOyZatUXcwCyu0vD+TG9mrJDd
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


