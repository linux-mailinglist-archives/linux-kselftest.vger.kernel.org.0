Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12200645DEE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 16:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLGPtz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 10:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLGPtu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 10:49:50 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972C63BB4
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 07:49:50 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a9so17389328pld.7
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 07:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFN1ukpXKxLmNAYkBULVsoTlaw64wakqQaa318EnS7w=;
        b=mzrL0wC7HJZg6H4fg+hl9vB15griUB7WwlNY9n7bcHzWC9Ln1UlmOfqokZnpGBCCzk
         9g2xDYSY9rsPj1uzjolhlIwWhChYv22zqyPN5DysMI6Cix18qsA7ESpgAGiOxo1KA90p
         JBXL2IWPcZJqXOT434+F0e46/gbeZiuZ3sUlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFN1ukpXKxLmNAYkBULVsoTlaw64wakqQaa318EnS7w=;
        b=FnF/39sSp4HaTtkV6b8AzY6VhXy3BEgfALqHmOVW/Y50vJMYo/Ud151XvNKXGzhWl1
         j9UpkN7wC8/05/pE+wai6RaEq+xZIOiXg8lWFqGtJuM+nTZXEu+eBjiuKcHKXp5T521B
         mod//o9UpV5/XGdHk+0Abmew3Nq1TrqI8xBkMStJ5gochE08lmh1xwQtXebOeQ69nAVg
         OvjWz52h8s9c2Y0Og76875JHhgTrVlSEc1Cw94Hskt1mqncsZNfHtku999M6Wfvp2/P0
         1uUZsCszt6FnJVT1BNfqeKHRZf+4Yh/2On3HKWATrjLoP3oG0MfF/BpimaEHaVHsB0N5
         u9Ew==
X-Gm-Message-State: ANoB5pn5O/2lJQ4wgKDzMO0vfMmUs62PGzuDWpyzvWVOQ2WBhTs2oD2v
        cQB9djGUiFCGIHaqzYXt9Al22Q==
X-Google-Smtp-Source: AA0mqf5K4kmSUPTkS50J0yjzZq+96PrBd/chPBv9Id337EfDtGpUZbG4aCet3uRKBpJrZ7DFluZdmw==
X-Received: by 2002:a17:902:8218:b0:189:9ef4:4b59 with SMTP id x24-20020a170902821800b001899ef44b59mr685624pln.52.1670428189559;
        Wed, 07 Dec 2022 07:49:49 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017f7628cbddsm14920934plh.30.2022.12.07.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:49:48 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org
Subject: [PATCH v6 5/6] selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC
Date:   Wed,  7 Dec 2022 15:49:38 +0000
Message-Id: <20221207154939.2532830-6-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221207154939.2532830-1-jeffxu@google.com>
References: <20221207154939.2532830-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Tests to verify MFD_NOEXEC, MFD_EXEC and vm.memfd_noexec sysctl.

Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 tools/testing/selftests/memfd/fuse_test.c  |   1 +
 tools/testing/selftests/memfd/memfd_test.c | 229 ++++++++++++++++++++-
 2 files changed, 225 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index be675002f918..93798c8c5d54 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -22,6 +22,7 @@
 #include <linux/falloc.h>
 #include <fcntl.h>
 #include <linux/memfd.h>
+#include <linux/types.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 1d7e7b36bbdd..cbf1768fb1b9 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -32,10 +32,19 @@
 #define F_SEAL_EXEC	0x0020
 #endif
 
+#define F_WX_SEALS (F_SEAL_SHRINK | \
+		    F_SEAL_GROW | \
+		    F_SEAL_WRITE | \
+		    F_SEAL_FUTURE_WRITE | \
+		    F_SEAL_EXEC)
 #ifndef MAX_PATH
 #define MAX_PATH 256
 #endif
 
+#ifndef MFD_NOEXEC_SEAL
+#define MFD_NOEXEC_SEAL	0x0008U
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
@@ -86,6 +95,37 @@ static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
 	return fd;
 }
 
+static void sysctl_assert_write(const char *val)
+{
+	int fd = open("/proc/sys/vm/memfd_noexec", O_WRONLY | O_CLOEXEC);
+
+	if (fd < 0) {
+		printf("open sysctl failed\n");
+		abort();
+	}
+
+	if (write(fd, val, strlen(val)) < 0) {
+		printf("write sysctl failed\n");
+		abort();
+	}
+}
+
+static void sysctl_fail_write(const char *val)
+{
+	int fd = open("/proc/sys/vm/memfd_noexec", O_WRONLY | O_CLOEXEC);
+
+	if (fd < 0) {
+		printf("open sysctl failed\n");
+		abort();
+	}
+
+	if (write(fd, val, strlen(val)) >= 0) {
+		printf("write sysctl %s succeeded, but failure expected\n",
+				val);
+		abort();
+	}
+}
+
 static int mfd_assert_reopen_fd(int fd_in)
 {
 	int fd;
@@ -764,6 +804,9 @@ static void test_create(void)
 	mfd_fail_new("", ~0);
 	mfd_fail_new("", 0x80000000U);
 
+	/* verify EXEC and NOEXEC_SEAL can't both be set */
+	mfd_fail_new("", MFD_EXEC | MFD_NOEXEC_SEAL);
+
 	/* verify MFD_CLOEXEC is allowed */
 	fd = mfd_assert_new("", 0, MFD_CLOEXEC);
 	close(fd);
@@ -975,20 +1018,21 @@ static void test_seal_resize(void)
 
 /*
  * Test SEAL_EXEC
- * Test that chmod() cannot change x bits after sealing
+ * Test fd is created with exec and allow sealing.
+ * chmod() cannot change x bits after sealing.
  */
-static void test_seal_exec(void)
+static void test_exec_seal(void)
 {
 	int fd;
 
 	printf("%s SEAL-EXEC\n", memfd_str);
 
+	printf("%s	Apply SEAL_EXEC\n", memfd_str);
 	fd = mfd_assert_new("kern_memfd_seal_exec",
 			    mfd_def_size,
-			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_EXEC);
 
 	mfd_assert_mode(fd, 0777);
-
 	mfd_assert_chmod(fd, 0644);
 
 	mfd_assert_has_seals(fd, 0);
@@ -1002,10 +1046,181 @@ static void test_seal_exec(void)
 	mfd_fail_chmod(fd, 0700);
 	mfd_fail_chmod(fd, 0100);
 	mfd_assert_chmod(fd, 0666);
+	mfd_assert_write(fd);
+	close(fd);
+
+	printf("%s	Apply ALL_SEALS\n", memfd_str);
+	fd = mfd_assert_new("kern_memfd_seal_exec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_EXEC);
+
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_chmod(fd, 0700);
+
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_WX_SEALS);
 
+	mfd_fail_chmod(fd, 0711);
+	mfd_fail_chmod(fd, 0600);
+	mfd_fail_write(fd);
+	close(fd);
+}
+
+/*
+ * Test EXEC_NO_SEAL
+ * Test fd is created with exec and not allow sealing.
+ */
+static void test_exec_no_seal(void)
+{
+	int fd;
+
+	printf("%s EXEC_NO_SEAL\n", memfd_str);
+
+	/* Create with EXEC but without ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_exec_no_sealing",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_EXEC);
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_has_seals(fd, F_SEAL_SEAL);
+	mfd_assert_chmod(fd, 0666);
 	close(fd);
 }
 
+/*
+ * Test memfd_create with MFD_NOEXEC flag
+ */
+static void test_noexec_seal(void)
+{
+	int fd;
+
+	printf("%s NOEXEC_SEAL\n", memfd_str);
+
+	/* Create with NOEXEC and ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_NOEXEC_SEAL);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+
+	/* Create with NOEXEC but without ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+}
+
+static void test_sysctl_child(void)
+{
+	int fd;
+
+	printf("%s sysctl 0\n", memfd_str);
+	sysctl_assert_write("0");
+	fd = mfd_assert_new("kern_memfd_sysctl_0",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_chmod(fd, 0644);
+	close(fd);
+
+	printf("%s sysctl 1\n", memfd_str);
+	sysctl_assert_write("1");
+	fd = mfd_assert_new("kern_memfd_sysctl_1",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	sysctl_fail_write("0");
+	close(fd);
+
+	printf("%s sysctl 2\n", memfd_str);
+	sysctl_assert_write("2");
+	mfd_fail_new("kern_memfd_sysctl_2",
+		MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	sysctl_fail_write("0");
+	sysctl_fail_write("1");
+}
+
+static int newpid_thread_fn(void *arg)
+{
+	test_sysctl_child();
+	return 0;
+}
+
+static void test_sysctl_child2(void)
+{
+	int fd;
+
+	sysctl_fail_write("0");
+	fd = mfd_assert_new("kern_memfd_sysctl_1",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+}
+
+static int newpid_thread_fn2(void *arg)
+{
+	test_sysctl_child2();
+	return 0;
+}
+static pid_t spawn_newpid_thread(unsigned int flags, int (*fn)(void *))
+{
+	uint8_t *stack;
+	pid_t pid;
+
+	stack = malloc(STACK_SIZE);
+	if (!stack) {
+		printf("malloc(STACK_SIZE) failed: %m\n");
+		abort();
+	}
+
+	pid = clone(fn,
+		    stack + STACK_SIZE,
+		    SIGCHLD | flags,
+		    NULL);
+	if (pid < 0) {
+		printf("clone() failed: %m\n");
+		abort();
+	}
+
+	return pid;
+}
+
+static void join_newpid_thread(pid_t pid)
+{
+	waitpid(pid, NULL, 0);
+}
+
+/*
+ * Test sysctl
+ * A very basic sealing test to see whether setting/retrieving seals works.
+ */
+static void test_sysctl(void)
+{
+	int pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn);
+
+	join_newpid_thread(pid);
+
+	printf("%s child ns\n", memfd_str);
+	sysctl_assert_write("1");
+
+	pid = spawn_newpid_thread(CLONE_NEWPID, newpid_thread_fn2);
+	join_newpid_thread(pid);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1179,13 +1394,15 @@ int main(int argc, char **argv)
 
 	test_create();
 	test_basic();
+	test_exec_seal();
+	test_exec_no_seal();
+	test_noexec_seal();
 
 	test_seal_write();
 	test_seal_future_write();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-	test_seal_exec();
 
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
@@ -1201,6 +1418,8 @@ int main(int argc, char **argv)
 	test_share_fork("SHARE-FORK", SHARED_FT_STR);
 	join_idle_thread(pid);
 
+	test_sysctl();
+
 	printf("memfd: DONE\n");
 
 	return 0;
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

