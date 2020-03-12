Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEA183106
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Mar 2020 14:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgCLNPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 09:15:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38463 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgCLNPr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 09:15:47 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jCNgd-0007TJ-18; Thu, 12 Mar 2020 13:15:43 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>
Cc:     ard.biesheuvel@linaro.org, ardb@kernel.org, john.stultz@linaro.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, naresh.kamboju@linaro.org,
        shuah@kernel.org,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>, hridya@google.com,
        kernel-team@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/3] binderfs_test: switch from /dev to /tmp as mountpoint
Date:   Thu, 12 Mar 2020 14:15:31 +0100
Message-Id: <20200312131531.3615556-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
References: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unprivileged users will be able to create directories in there. The
unprivileged test for /dev wouldn't have worked on most systems.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .../filesystems/binderfs/binderfs_test.c      | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 313ffad15614..d6e61998d20a 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -76,7 +76,7 @@ static void __do_binderfs_test(void)
 
 	change_mountns();
 
-	ret = mkdir("/dev/binderfs", 0755);
+	ret = mkdir("/tmp/binderfs", 0755);
 	if (ret < 0) {
 		if (errno != EEXIST)
 			ksft_exit_fail_msg(
@@ -86,13 +86,13 @@ static void __do_binderfs_test(void)
 		keep = true;
 	}
 
-	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
+	ret = mount(NULL, "/tmp/binderfs", "binder", 0, 0);
 	if (ret < 0) {
 		if (errno != ENODEV)
 			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
 					   strerror(errno));
 
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		keep ? : rmdir_protect_errno("/tmp/binderfs");
 		ksft_exit_skip(
 			"The Android binderfs filesystem is not available\n");
 	}
@@ -102,7 +102,7 @@ static void __do_binderfs_test(void)
 
 	memcpy(device.name, "my-binder", strlen("my-binder"));
 
-	fd = open("/dev/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
+	fd = open("/tmp/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
 		ksft_exit_fail_msg(
 			"%s - Failed to open binder-control device\n",
@@ -113,7 +113,7 @@ static void __do_binderfs_test(void)
 	close(fd);
 	errno = saved_errno;
 	if (ret < 0) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		keep ? : rmdir_protect_errno("/tmp/binderfs");
 		ksft_exit_fail_msg(
 			"%s - Failed to allocate new binder device\n",
 			strerror(errno));
@@ -126,9 +126,9 @@ static void __do_binderfs_test(void)
 	/* binder device allocation test passed */
 	ksft_inc_pass_cnt();
 
-	fd = open("/dev/binderfs/my-binder", O_CLOEXEC | O_RDONLY);
+	fd = open("/tmp/binderfs/my-binder", O_CLOEXEC | O_RDONLY);
 	if (fd < 0) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		keep ? : rmdir_protect_errno("/tmp/binderfs");
 		ksft_exit_fail_msg("%s - Failed to open my-binder device\n",
 				   strerror(errno));
 	}
@@ -138,7 +138,7 @@ static void __do_binderfs_test(void)
 	close(fd);
 	errno = saved_errno;
 	if (ret < 0) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		keep ? : rmdir_protect_errno("/tmp/binderfs");
 		ksft_exit_fail_msg(
 			"%s - Failed to open perform BINDER_VERSION request\n",
 			strerror(errno));
@@ -150,9 +150,9 @@ static void __do_binderfs_test(void)
 	/* binder transaction with binderfs binder device passed */
 	ksft_inc_pass_cnt();
 
-	ret = unlink("/dev/binderfs/my-binder");
+	ret = unlink("/tmp/binderfs/my-binder");
 	if (ret < 0) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		keep ? : rmdir_protect_errno("/tmp/binderfs");
 		ksft_exit_fail_msg("%s - Failed to delete binder device\n",
 				   strerror(errno));
 	}
@@ -160,12 +160,12 @@ static void __do_binderfs_test(void)
 	/* binder device removal passed */
 	ksft_inc_pass_cnt();
 
-	ret = unlink("/dev/binderfs/binder-control");
+	ret = unlink("/tmp/binderfs/binder-control");
 	if (!ret) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		keep ? : rmdir_protect_errno("/tmp/binderfs");
 		ksft_exit_fail_msg("Managed to delete binder-control device\n");
 	} else if (errno != EPERM) {
-		keep ? : rmdir_protect_errno("/dev/binderfs");
+		keep ? : rmdir_protect_errno("/tmp/binderfs");
 		ksft_exit_fail_msg(
 			"%s - Failed to delete binder-control device but exited with unexpected error code\n",
 			strerror(errno));
@@ -175,8 +175,8 @@ static void __do_binderfs_test(void)
 	ksft_inc_xfail_cnt();
 
 on_error:
-	ret = umount2("/dev/binderfs", MNT_DETACH);
-	keep ?: rmdir_protect_errno("/dev/binderfs");
+	ret = umount2("/tmp/binderfs", MNT_DETACH);
+	keep ?: rmdir_protect_errno("/tmp/binderfs");
 	if (ret < 0)
 		ksft_exit_fail_msg("%s - Failed to unmount binderfs\n",
 				   strerror(errno));
-- 
2.25.1

