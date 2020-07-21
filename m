Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB832287C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgGURrB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 13:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGURrA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 13:47:00 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C841C061794
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 10:47:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h18so9712631qvl.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSgwIt6Xmnq65csieZBPIE7le00gy1RleefALsLtM4I=;
        b=zEwJmhVqE2bAhuFmQJlX3mCSLHWVovSFHx0Q4fLD0PEk5EDpGO0VUCO2JXg95YDfp9
         xL8t/2JnEFJsbT98iDtYg49ZZYEMQNsNfbVKw9rNRRiN8ySRDXEfcdv+tAuBAoGu2rVh
         yDVa3XfV2l5MByer36m6uZZsnz8UMqkDLgKnwCcM7dQ7QyVIuAc2kXjuo9bOtewV+Nk+
         krhNkHqjmR+JZe6uEkZ1s3umNGGhLOFAUSvPMYC7UxwiisQqtJbDP6Czq+wrKKSEp0wH
         2OgGbvK3vrUiwJZFJWzZJWqpFJM56HxxSCZCuRMCL/ox8PK0g+GmpUghSEM0iqcO0ttD
         wIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSgwIt6Xmnq65csieZBPIE7le00gy1RleefALsLtM4I=;
        b=MyNz/Fi07oK8eWdLnVi2nOJyv2IHQ+CIbfaKXbc+Icw81b5Zd/IQSpgUntCB1kh8tg
         FiJTi0bKLFEeJLA6Or42fcbvKiM+TckQg7Lg0/AJ/YmVtvHfM/mQDt66Ng7lo/Bsdd6m
         Cd+D0NJHhCsG9iADMMxw++XOswRlJ+UREeTAnviyNN2egrE0JJvcBZ1LOJL4sUU7MCMH
         cjt7YIh/l8OiZbi9CaevgWceFIQhUvr2TdyMq8SUeMqMX7nP7KhNot6tdU+VEWk6ksOu
         sKdoMWB4qq1rotsEefkBmh7nn3+oL5U0Pag9jQ8Hjd1cc1eB+HBVUSZteXz+5LVeCsYS
         /nUw==
X-Gm-Message-State: AOAM532hNu+AJhH5K5Uz0fE2hRyTUd9O80wLUk0sIJW21jZBoGk2DnXd
        eaTB2oIpOLSCCM7Zl/+3+pcuJg==
X-Google-Smtp-Source: ABdhPJwypcJw5kfuZyhj7RMU5LynsnJ4EioBDJ25IoR9AN6RQ1S4FWzLQSOCrt9/2nH4CdHVjConrg==
X-Received: by 2002:a05:6214:942:: with SMTP id dn2mr27879858qvb.161.1595353619482;
        Tue, 21 Jul 2020 10:46:59 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id n81sm2898255qke.11.2020.07.21.10.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:46:58 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] lib: Convert test_user_copy to KUnit test
Date:   Tue, 21 Jul 2020 14:46:54 -0300
Message-Id: <20200721174654.72132-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the conversion of the runtime tests of test_user_copy fuctions,
from `lib/test_user_copy.c`to KUnit tests.

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
v3:
    * rebased with last kunit branch
    * Please apply this commit from kunit-fixes:
        3f37d14b8a3152441f36b6bc74000996679f0998
      And these from patchwork:
        https://patchwork.kernel.org/patch/11676331/
        https://patchwork.kernel.org/patch/11676335/
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

base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
--
2.26.2

