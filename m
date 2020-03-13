Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4F184A9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 16:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgCMPYh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 11:24:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34437 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCMPYh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 11:24:37 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jCmAt-0000Tg-4F; Fri, 13 Mar 2020 15:24:35 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     christian.brauner@ubuntu.com, ard.biesheuvel@linaro.org,
        ardb@kernel.org, arve@android.com, hridya@google.com,
        joel@joelfernandes.org, john.stultz@linaro.org,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        maco@android.com, naresh.kamboju@linaro.org, shuah@kernel.org
Subject: [PATCH v2 1/3] binderfs: port tests to test harness infrastructure
Date:   Fri, 13 Mar 2020 16:24:18 +0100
Message-Id: <20200313152420.138777-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
References: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Makes for nicer output and prepares for additional tests.

Cc: Kees Cook <keescook@chromium.org>:
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Kees Cook <keescook@chromium.org>:
  - Switch to XFAIL() to skip tests.
---
 .../selftests/filesystems/binderfs/Makefile   |  2 ++
 .../filesystems/binderfs/binderfs_test.c      | 31 +++++++++----------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
index 58cb659b56b4..75315d9ba7a9 100644
--- a/tools/testing/selftests/filesystems/binderfs/Makefile
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -3,4 +3,6 @@
 CFLAGS += -I../../../../../usr/include/
 TEST_GEN_PROGS := binderfs_test
 
+binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 8c2ed962e1c7..0cfca65e095a 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -15,7 +15,9 @@
 #include <unistd.h>
 #include <linux/android/binder.h>
 #include <linux/android/binderfs.h>
+
 #include "../../kselftest.h"
+#include "../../kselftest_harness.h"
 
 static ssize_t write_nointr(int fd, const void *buf, size_t count)
 {
@@ -132,7 +134,7 @@ static void rmdir_protect_errno(const char *dir)
 	errno = saved_errno;
 }
 
-static void __do_binderfs_test(void)
+static int __do_binderfs_test(void)
 {
 	int fd, ret, saved_errno;
 	size_t len;
@@ -160,8 +162,7 @@ static void __do_binderfs_test(void)
 					   strerror(errno));
 
 		keep ? : rmdir_protect_errno("/dev/binderfs");
-		ksft_exit_skip(
-			"The Android binderfs filesystem is not available\n");
+		return 1;
 	}
 
 	/* binderfs mount test passed */
@@ -250,26 +251,24 @@ static void __do_binderfs_test(void)
 
 	/* binderfs unmount test passed */
 	ksft_inc_pass_cnt();
+	return 0;
 }
 
-static void binderfs_test_privileged()
+TEST(binderfs_test_privileged)
 {
 	if (geteuid() != 0)
-		ksft_print_msg(
-			"Tests are not run as root. Skipping privileged tests\n");
-	else
-		__do_binderfs_test();
+		XFAIL(return, "Tests are not run as root. Skipping privileged tests");
+
+	if (__do_binderfs_test() == 1)
+		XFAIL(return, "The Android binderfs filesystem is not available");
 }
 
-static void binderfs_test_unprivileged()
+TEST(binderfs_test_unprivileged)
 {
 	change_to_userns();
-	__do_binderfs_test();
-}
 
-int main(int argc, char *argv[])
-{
-	binderfs_test_privileged();
-	binderfs_test_unprivileged();
-	ksft_exit_pass();
+	if (__do_binderfs_test() == 1)
+		XFAIL(return, "The Android binderfs filesystem is not available");
 }
+
+TEST_HARNESS_MAIN

base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
-- 
2.25.1

