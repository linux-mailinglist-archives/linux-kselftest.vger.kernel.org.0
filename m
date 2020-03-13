Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAE0184A9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 16:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCMPYi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 11:24:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34441 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgCMPYi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 11:24:38 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jCmAu-0000Tg-98; Fri, 13 Mar 2020 15:24:36 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     christian.brauner@ubuntu.com, ard.biesheuvel@linaro.org,
        ardb@kernel.org, arve@android.com, hridya@google.com,
        joel@joelfernandes.org, john.stultz@linaro.org,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        maco@android.com, naresh.kamboju@linaro.org, shuah@kernel.org
Subject: [PATCH v2 2/3] binderfs_test: switch from /dev to a unique per-test mountpoint
Date:   Fri, 13 Mar 2020 16:24:19 +0100
Message-Id: <20200313152420.138777-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313152420.138777-1-christian.brauner@ubuntu.com>
References: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
 <20200313152420.138777-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unprivileged users will be able to create directories in there. The
unprivileged test for /dev wouldn't have worked on most systems.

Cc: Kees Cook <keescook@chromium.org>:
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Kees Cook <keescook@chromium.org>:
  - Switch to unique mountpoint through mkdtemp().
---
 .../filesystems/binderfs/binderfs_test.c      | 47 +++++++++----------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 0cfca65e095a..818eb49f8125 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -139,29 +139,25 @@ static int __do_binderfs_test(void)
 	int fd, ret, saved_errno;
 	size_t len;
 	ssize_t wret;
-	bool keep = false;
 	struct binderfs_device device = { 0 };
 	struct binder_version version = { 0 };
+	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
+		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
 
 	change_to_mountns();
 
-	ret = mkdir("/dev/binderfs", 0755);
-	if (ret < 0) {
-		if (errno != EEXIST)
-			ksft_exit_fail_msg(
-				"%s - Failed to create binderfs mountpoint\n",
-				strerror(errno));
-
-		keep = true;
-	}
+	if (!mkdtemp(binderfs_mntpt))
+		ksft_exit_fail_msg(
+			"%s - Failed to create binderfs mountpoint\n",
+			strerror(errno));
 
-	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
+	ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
 	if (ret < 0) {
 		if (errno != ENODEV)
 			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
 					   strerror(errno));
 
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		rmdir_protect_errno(binderfs_mntpt);
 		return 1;
 	}
 
@@ -170,7 +166,8 @@ static int __do_binderfs_test(void)
 
 	memcpy(device.name, "my-binder", strlen("my-binder"));
 
-	fd = open("/dev/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
+	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
+	fd = open(device_path, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		ksft_exit_fail_msg(
 			"%s - Failed to open binder-control device\n",
@@ -181,7 +178,7 @@ static int __do_binderfs_test(void)
 	close(fd);
 	errno = saved_errno;
 	if (ret < 0) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		rmdir_protect_errno(binderfs_mntpt);
 		ksft_exit_fail_msg(
 			"%s - Failed to allocate new binder device\n",
 			strerror(errno));
@@ -194,9 +191,10 @@ static int __do_binderfs_test(void)
 	/* binder device allocation test passed */
 	ksft_inc_pass_cnt();
 
-	fd = open("/dev/binderfs/my-binder", O_CLOEXEC | O_RDONLY);
+	snprintf(device_path, sizeof(device_path), "%s/my-binder", binderfs_mntpt);
+	fd = open(device_path, O_CLOEXEC | O_RDONLY);
 	if (fd < 0) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		rmdir_protect_errno(binderfs_mntpt);
 		ksft_exit_fail_msg("%s - Failed to open my-binder device\n",
 				   strerror(errno));
 	}
@@ -206,7 +204,7 @@ static int __do_binderfs_test(void)
 	close(fd);
 	errno = saved_errno;
 	if (ret < 0) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		rmdir_protect_errno(binderfs_mntpt);
 		ksft_exit_fail_msg(
 			"%s - Failed to open perform BINDER_VERSION request\n",
 			strerror(errno));
@@ -218,9 +216,9 @@ static int __do_binderfs_test(void)
 	/* binder transaction with binderfs binder device passed */
 	ksft_inc_pass_cnt();
 
-	ret = unlink("/dev/binderfs/my-binder");
+	ret = unlink(device_path);
 	if (ret < 0) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		rmdir_protect_errno(binderfs_mntpt);
 		ksft_exit_fail_msg("%s - Failed to delete binder device\n",
 				   strerror(errno));
 	}
@@ -228,12 +226,13 @@ static int __do_binderfs_test(void)
 	/* binder device removal passed */
 	ksft_inc_pass_cnt();
 
-	ret = unlink("/dev/binderfs/binder-control");
+	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
+	ret = unlink(device_path);
 	if (!ret) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		rmdir_protect_errno(binderfs_mntpt);
 		ksft_exit_fail_msg("Managed to delete binder-control device\n");
 	} else if (errno != EPERM) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		rmdir_protect_errno(binderfs_mntpt);
 		ksft_exit_fail_msg(
 			"%s - Failed to delete binder-control device but exited with unexpected error code\n",
 			strerror(errno));
@@ -243,8 +242,8 @@ static int __do_binderfs_test(void)
 	ksft_inc_xfail_cnt();
 
 on_error:
-	ret = umount2("/dev/binderfs", MNT_DETACH);
-	keep ?: rmdir_protect_errno("/dev/binderfs");
+	ret = umount2(binderfs_mntpt, MNT_DETACH);
+	rmdir_protect_errno(binderfs_mntpt);
 	if (ret < 0)
 		ksft_exit_fail_msg("%s - Failed to unmount binderfs\n",
 				   strerror(errno));
-- 
2.25.1

