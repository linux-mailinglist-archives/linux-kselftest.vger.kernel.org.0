Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 630E4183104
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Mar 2020 14:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCLNPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 09:15:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38461 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgCLNPq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 09:15:46 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jCNgb-0007TJ-Hf; Thu, 12 Mar 2020 13:15:41 +0000
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
Subject: [PATCH 1/3] binderfs: port tests to test harness infrastructure
Date:   Thu, 12 Mar 2020 14:15:29 +0100
Message-Id: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
References: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Makes for nicer output and prepares for additional tests.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .../selftests/filesystems/binderfs/Makefile      |  2 ++
 .../filesystems/binderfs/binderfs_test.c         | 16 ++++++----------
 2 files changed, 8 insertions(+), 10 deletions(-)

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
index 8c2ed962e1c7..d03ed8eed5eb 100644
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
@@ -252,24 +254,18 @@ static void __do_binderfs_test(void)
 	ksft_inc_pass_cnt();
 }
 
-static void binderfs_test_privileged()
+TEST(binderfs_test_privileged)
 {
 	if (geteuid() != 0)
-		ksft_print_msg(
-			"Tests are not run as root. Skipping privileged tests\n");
+		ksft_print_msg("Tests are not run as root. Skipping privileged tests\n");
 	else
 		__do_binderfs_test();
 }
 
-static void binderfs_test_unprivileged()
+TEST(binderfs_test_unprivileged)
 {
 	change_to_userns();
 	__do_binderfs_test();
 }
 
-int main(int argc, char *argv[])
-{
-	binderfs_test_privileged();
-	binderfs_test_unprivileged();
-	ksft_exit_pass();
-}
+TEST_HARNESS_MAIN

base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
-- 
2.25.1

