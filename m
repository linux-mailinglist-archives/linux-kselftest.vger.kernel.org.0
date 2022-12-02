Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11563FDB0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 02:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiLBBgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 20:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiLBBf5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 20:35:57 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAF8D2DA9
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 17:35:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so3798693pjd.5
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Dec 2022 17:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrXepEeYywGqVUdZb7DsSkS1BSG0nj/I+2TGo2i1GsE=;
        b=ET3SZVF6bG+e9NAyPMySizMeHdK7bDazDLHa+DJwt7OfFCvZoKLkYjJ1++bg4MGNSz
         op0u1zsArx1E5iKMk3mQRfMyojlSDrB8eQZdqxqyDGG7uUXbNSKydA8piwvPl7byt9qh
         v738vyBrGEHQ7b+koLma5OvFEMAlpoXIuKqjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrXepEeYywGqVUdZb7DsSkS1BSG0nj/I+2TGo2i1GsE=;
        b=2p26qMjxLSx73T8Rw7XO/c+nYQ6nE41VgrBNJ2C8LBxIejdDvjGpU6eYSuNvEuwPLu
         wIhikHwub+riILHN2TI+pmw7a/hdVG766XMKbggvk/sDzH0TLmDLWan78irLFkbOLku9
         mvLUfVsRj6KEkLgoXUBvmGLBPIgwW5YGy9aNljINu5zPHTdUYYywdqrtfXGXb7IZ0uBq
         lZ2HJXhvxDkxzwObZwPHdjOz5u2/zPRv938CRYSMdfERWwgAkVNAMLecx749ESCeCkPj
         UMvC25jZ2nXlnNbhHZjwQRyu7Z3EHO4CTccIhRrUmH5JR/9y+xUGPJMheqM9tgzfIPDb
         7Eew==
X-Gm-Message-State: ANoB5pnMSRNX3UB1k7pKJki+efRKHPrMXDGxVYrAjLt3QDHDWoxn/D5b
        HFfC0ZKmWPxymaVm/qPfvIhs7w==
X-Google-Smtp-Source: AA0mqf5VPjWOTcYSKKAlrgnsC4kcOqgsiCeRnXZxCNQpyexlJ1nAEZYs97684BcgFfTf/8zPslP8hA==
X-Received: by 2002:a17:902:6904:b0:188:fd9b:479d with SMTP id j4-20020a170902690400b00188fd9b479dmr53964157plk.93.1669944953701;
        Thu, 01 Dec 2022 17:35:53 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id s13-20020a65690d000000b00477fb27eaddsm3074241pgq.63.2022.12.01.17.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:35:53 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3] selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC
Date:   Fri,  2 Dec 2022 01:34:02 +0000
Message-Id: <20221202013404.163143-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221202013404.163143-1-jeffxu@google.com>
References: <20221202013404.163143-1-jeffxu@google.com>
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

From: Jeff Xu <jeffxu@chromium.org>

Tests to verify MFD_NOEXEC, MFD_EXEC and vm.memfd_noexec sysctl.

Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/memfd/fuse_test.c  |   1 +
 tools/testing/selftests/memfd/memfd_test.c | 161 ++++++++++++++++++++-
 2 files changed, 157 insertions(+), 5 deletions(-)

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
index 1d7e7b36bbdd..775c9e6c061e 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -36,6 +36,10 @@
 #define MAX_PATH 256
 #endif
 
+#ifndef MFD_NOEXEC_SEAL
+#define MFD_NOEXEC_SEAL	0x0008U
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
@@ -86,6 +90,21 @@ static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
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
 static int mfd_assert_reopen_fd(int fd_in)
 {
 	int fd;
@@ -764,6 +783,9 @@ static void test_create(void)
 	mfd_fail_new("", ~0);
 	mfd_fail_new("", 0x80000000U);
 
+	/* verify EXEC and NOEXEC_SEAL can't both be set */
+	mfd_fail_new("", MFD_EXEC | MFD_NOEXEC_SEAL);
+
 	/* verify MFD_CLOEXEC is allowed */
 	fd = mfd_assert_new("", 0, MFD_CLOEXEC);
 	close(fd);
@@ -975,9 +997,10 @@ static void test_seal_resize(void)
 
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
 
@@ -985,10 +1008,9 @@ static void test_seal_exec(void)
 
 	fd = mfd_assert_new("kern_memfd_seal_exec",
 			    mfd_def_size,
-			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_EXEC);
 
 	mfd_assert_mode(fd, 0777);
-
 	mfd_assert_chmod(fd, 0644);
 
 	mfd_assert_has_seals(fd, 0);
@@ -1006,6 +1028,131 @@ static void test_seal_exec(void)
 	close(fd);
 }
 
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
+	close(fd);
+}
+
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
+	int fd, pid, ret;
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
+	close(fd);
+
+	printf("%s sysctl 2\n", memfd_str);
+	sysctl_assert_write("2");
+	mfd_fail_new("kern_memfd_sysctl_2",
+		MFD_CLOEXEC | MFD_ALLOW_SEALING);
+}
+
+static int newpid_thread_fn(void *arg)
+{
+	test_sysctl_child();
+	return 0;
+}
+
+static pid_t spawn_newpid_thread(unsigned int flags)
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
+	pid = clone(newpid_thread_fn,
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
+	int pid = spawn_newpid_thread(CLONE_NEWPID);
+
+	join_newpid_thread(pid);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1179,13 +1326,15 @@ int main(int argc, char **argv)
 
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
@@ -1201,6 +1350,8 @@ int main(int argc, char **argv)
 	test_share_fork("SHARE-FORK", SHARED_FT_STR);
 	join_idle_thread(pid);
 
+	test_sysctl();
+
 	printf("memfd: DONE\n");
 
 	return 0;
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

