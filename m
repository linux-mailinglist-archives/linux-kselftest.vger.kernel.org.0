Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9B622479D
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jul 2020 02:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGRAvr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jul 2020 20:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgGRAvq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jul 2020 20:51:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC0BC0619D3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jul 2020 17:51:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z15so3667967qki.10
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jul 2020 17:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4lR3PL+tlav6Sd3AKsZVkdyRuT1gdsNfBg2d9bO4Ybw=;
        b=JKdJdOWoLbE63zmjfhu9UnfMu+KTlFFcste0tnpG53kEQSd+TyAuBDwTYKyLJnj/9Q
         7YdpDHel5BWIE0wV8SMcrbCxBxy5ZNhfOCR3hDbL+nS4U1HQynZZXcM3nDI/HMzWkfHk
         wxFzuoPHjpN7WpTOS2yHO1N/z+f1NnmzUaD7PMXpep9XdiR2e3xeZhgNQ8BBowRxGRi5
         4QGnA2ev/gV/A5QkI4xyIiUeH39t+h78XlqhClCrhMspeR/mJ97nweM27pBNojAoSRC8
         vElpGEzvULRIUidS+/Ckxe8n/AhXzkrHlZZ+VIBqpZrFlcM6KhM4oFFA9Fng02ERJHT8
         EmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4lR3PL+tlav6Sd3AKsZVkdyRuT1gdsNfBg2d9bO4Ybw=;
        b=jSOFKsrlKwtpoxBKVCDWY6GNIC89iORBHbw0trskHz7H6UtrrtNQiQcsqz2MY2vZgV
         XUJFbG9aOHU3ua2XOurdY9rOThbUxV+IFlVynjb8fkj7N29IKkosiX+CO5B535YGaF8R
         pkwW8N1xYXLhiQAYHJIASzuBq3b1ZJUC+aXULZm3MF4yi/gMEXj1yknxSA8irqfHFY1p
         sL89B/6Abc+wpez8+z2paMaGECb+N4oHMBpVgx1wH+o8yxUUjuj5sas7pS+SGktl6hvc
         8C56KF546MThuKMqRkiYLR24tChKw6GvtIDeHrwl5ZUsENj9C57JEe73CG5BS8KB1T7C
         BD4w==
X-Gm-Message-State: AOAM533ntoSG9+FNBVmOQEfFgMSulR49tW8UgtXsfqeStLyizFf0nl35
        WQrdCH3aZdQQQ66bXSgW7QqatQ==
X-Google-Smtp-Source: ABdhPJyL15m0TxuDLsuYT9qyN02p4DwZ4mgfiDhARFqC9WoQENmBgtZ6gZRbT76CZf0OhAjlASlZyw==
X-Received: by 2002:a05:620a:79a:: with SMTP id 26mr11825826qka.169.1595033505432;
        Fri, 17 Jul 2020 17:51:45 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id 79sm11998188qkd.134.2020.07.17.17.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 17:51:44 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] lib: Convert test_user_copy to KUnit test
Date:   Fri, 17 Jul 2020 21:51:41 -0300
Message-Id: <20200718005141.440405-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the conversion of the runtime tests of test_user_copy fuctions,
from `lib/test_user_copy.c` to KUnit tests.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
v2:
    * splitted patch in 3:
        - Allows to install and load modules in root filesystem;
        - Provides an userspace memory context when tests are compiled
          as module;
        - Convert test_user_copy to KUnit test;
    * removed entry for CONFIG_TEST_USER_COPY;
    * replaced pr_warn to KUNIT_EXPECT_FALSE_MSG in test macro to
      decrease the diff;
---
 lib/Kconfig.debug                           | 28 ++++++++------
 lib/Makefile                                |  2 +-
 lib/{test_user_copy.c => user_copy_kunit.c} | 42 +++++++++------------
 3 files changed, 35 insertions(+), 37 deletions(-)
 rename lib/{test_user_copy.c => user_copy_kunit.c} (91%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..f699a3624ae7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2078,18 +2078,6 @@ config TEST_VMALLOC
 
 	  If unsure, say N.
 
-config TEST_USER_COPY
-	tristate "Test user/kernel boundary protections"
-	depends on m
-	help
-	  This builds the "test_user_copy" module that runs sanity checks
-	  on the copy_to/from_user infrastructure, making sure basic
-	  user/kernel boundary testing is working. If it fails to load,
-	  a regression has been detected in the user/kernel memory boundary
-	  protections.
-
-	  If unsure, say N.
-
 config TEST_BPF
 	tristate "Test BPF filter functionality"
 	depends on m && NET
@@ -2154,6 +2142,22 @@ config SYSCTL_KUNIT_TEST
 
 	  If unsure, say N.
 
+config USER_COPY_KUNIT
+	tristate "KUnit Test for user/kernel boundary protections"
+	depends on KUNIT
+	depends on m
+	help
+	  This builds the "user_copy_kunit" module that runs sanity checks
+	  on the copy_to/from_user infrastructure, making sure basic
+	  user/kernel boundary testing is working. If it fails to load,
+	  a regression has been detected in the user/kernel memory boundary
+	  protections.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config LIST_KUNIT_TEST
 	tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..8c145f85accc 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -78,7 +78,6 @@ obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
-obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
@@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_USER_COPY_KUNIT) += user_copy_kunit.o
diff --git a/lib/test_user_copy.c b/lib/user_copy_kunit.c
similarity index 91%
rename from lib/test_user_copy.c
rename to lib/user_copy_kunit.c
index 5ff04d8fe971..a10ddd15b4cd 100644
--- a/lib/test_user_copy.c
+++ b/lib/user_copy_kunit.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <kunit/test.h>
 
 /*
  * Several 32-bit architectures support 64-bit {get,put}_user() calls.
@@ -35,7 +36,7 @@
 ({									\
 	int cond = (condition);						\
 	if (cond)							\
-		pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);	\
+		KUNIT_EXPECT_FALSE_MSG(test, cond, msg, ##__VA_ARGS__);	\
 	cond;								\
 })
 
@@ -44,7 +45,7 @@ static bool is_zeroed(void *from, size_t size)
 	return memchr_inv(from, 0x0, size) == NULL;
 }
 
-static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
+static int test_check_nonzero_user(struct kunit *test, char *kmem, char __user *umem, size_t size)
 {
 	int ret = 0;
 	size_t start, end, i, zero_start, zero_end;
@@ -102,7 +103,7 @@ static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
 	return ret;
 }
 
-static int test_copy_struct_from_user(char *kmem, char __user *umem,
+static int test_copy_struct_from_user(struct kunit *test, char *kmem, char __user *umem,
 				      size_t size)
 {
 	int ret = 0;
@@ -177,7 +178,7 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	return ret;
 }
 
-static int __init test_user_copy_init(void)
+static void user_copy_test(struct kunit *test)
 {
 	int ret = 0;
 	char *kmem;
@@ -192,16 +193,14 @@ static int __init test_user_copy_init(void)
 #endif
 
 	kmem = kmalloc(PAGE_SIZE * 2, GFP_KERNEL);
-	if (!kmem)
-		return -ENOMEM;
+	KUNIT_EXPECT_FALSE_MSG(test, kmem == NULL, "kmalloc failed");
 
 	user_addr = vm_mmap(NULL, 0, PAGE_SIZE * 2,
 			    PROT_READ | PROT_WRITE | PROT_EXEC,
 			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
 	if (user_addr >= (unsigned long)(TASK_SIZE)) {
-		pr_warn("Failed to allocate user memory\n");
 		kfree(kmem);
-		return -ENOMEM;
+		KUNIT_FAIL(test, "Failed to allocate user memory");
 	}
 
 	usermem = (char __user *)user_addr;
@@ -245,9 +244,9 @@ static int __init test_user_copy_init(void)
 #undef test_legit
 
 	/* Test usage of check_nonzero_user(). */
-	ret |= test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
+	ret |= test_check_nonzero_user(test, kmem, usermem, 2 * PAGE_SIZE);
 	/* Test usage of copy_struct_from_user(). */
-	ret |= test_copy_struct_from_user(kmem, usermem, 2 * PAGE_SIZE);
+	ret |= test_copy_struct_from_user(test, kmem, usermem, 2 * PAGE_SIZE);
 
 	/*
 	 * Invalid usage: none of these copies should succeed.
@@ -309,23 +308,18 @@ static int __init test_user_copy_init(void)
 
 	vm_munmap(user_addr, PAGE_SIZE * 2);
 	kfree(kmem);
-
-	if (ret == 0) {
-		pr_info("tests passed.\n");
-		return 0;
-	}
-
-	return -EINVAL;
 }
 
-module_init(test_user_copy_init);
-
-static void __exit test_user_copy_exit(void)
-{
-	pr_info("unloaded.\n");
-}
+static struct kunit_case user_copy_test_cases[] = {
+	KUNIT_CASE(user_copy_test),
+	{}
+};
 
-module_exit(test_user_copy_exit);
+static struct kunit_suite user_copy_test_suite = {
+	.name = "user_copy",
+	.test_cases = user_copy_test_cases,
+};
 
+kunit_test_suites(&user_copy_test_suite);
 MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
 MODULE_LICENSE("GPL");

base-commit: 725aca9585956676687c4cb803e88f770b0df2b2
prerequisite-patch-id: 5e5f9a8a05c5680fda1b04c9ab1b95ce91dc88b2
prerequisite-patch-id: 4d997940f4a9f303424af9bac412de1af861f9d9
prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
prerequisite-patch-id: 5cd745ed9bbb0b36010c5de8adc19bfa86ad8be0
prerequisite-patch-id: 42f17b389ec15baf50dd1c43f6e30b8d2dff7964
-- 
2.26.2

