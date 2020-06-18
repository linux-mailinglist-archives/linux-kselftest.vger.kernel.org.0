Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671921FF42A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgFROGZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgFROGW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 10:06:22 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BA2C0613ED
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 07:06:20 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id er17so2790970qvb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lVMlOdIyNxLzGMiXNj2N9UYux15sD/EtwgLiUczR68=;
        b=SWNQqCthtE9g0sq3+vBFx/xnVnQdfhX2FgyyrH2jWJFlJQyuF0LHukWNOzeQjqQ3jc
         PoK+nLYaILrXuAC7q5eN4U3mUZlz4Bs1QVX//qlaGU/HtbJPqnAvKeirLKJaGwqnaZ9g
         zRFEbsVSkyv25KzZcI8BjMF2pHWeyIiss/pGdAH4kNuMj3SGwOQ/hzLWycs2mrtOBrFe
         rNBKLYC6lBsASbw/Ah4WJXp7FlfNtL0oWTJVLFE4fLeDLi67BbtXF8gsOEv9zt9WmtA4
         Coh6Rnb5LShAGWr4w4oAgYyJcFnaCLCArUqpTK2RN8JCTanKl2KCVMcA80t4dqbOynyu
         4FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9lVMlOdIyNxLzGMiXNj2N9UYux15sD/EtwgLiUczR68=;
        b=e/cfQgbU6BkNh5U5Nt2qa+95hbC/dwof8F8wEBUsnqmNaz4AVza3ge9IBsQhdGfun7
         fxkvOG//BDRUuh0o/lXQ/AuX6W3GHOy+gyldv12Y6RsDmJj8/LDVmvSP7CTmTqiklGoO
         QEyCa+cRbSKXHalOIXSnJ7rHMXV1wP8Eh7l+ePORSsKbMTZp/VlmXN6RQX59MAaWDZUR
         ykAnN8M4a1ryq3yVFjGsFIsllBVc6F1Pt3HsEZQ1k6k5pIPEAL5CoNWOgObfF7g59dhL
         cQcvAVlfsNOIo9MjoWQLlYt1/OYWtocOaBjoJRrELPE4II9iQPpY/smfG8ZG5JToHTVA
         j43w==
X-Gm-Message-State: AOAM532PCBln12MNWCcQoekvCa7IBX4ntFQDipVxbJne0tcDJtZDQG5y
        dn46Gttl2f0GbLLqIsFns0SA07MC9S4PcO/S
X-Google-Smtp-Source: ABdhPJySXdwj3CLQ0yEHHLQIIJimTYgUOu6BXtPn4akRwatVE26vzbLMCKx03UNsHAutW7tfTuBTdA==
X-Received: by 2002:a05:6214:178e:: with SMTP id ct14mr3860484qvb.73.1592489179664;
        Thu, 18 Jun 2020 07:06:19 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id d140sm3005219qkc.22.2020.06.18.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:06:19 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        keescook@chromium.org, linux@rasmusvillemoes.dk,
        davidgow@google.com
Subject: [PATCH v2] lib: overflow-test: add KUnit test of check_*_overflow functions
Date:   Thu, 18 Jun 2020 11:06:15 -0300
Message-Id: <20200618140615.135606-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the conversion of the runtime tests of check_*_overflow functions,
from `lib/test_overflow.c`to KUnit tests.

The log similar to the one seen in dmesg running test_overflow.c can be
seen in `test.log`.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
v2:
  * moved lib/test_overflow.c to lib/overflow-test.c; 
    * back to original license;
    * fixed style code;
    * keeps __initconst and added _refdata on overflow_test_cases variable;
    * keeps macros intact making asserts with the variable err;
    * removed duplicate test_s8_overflow();
  * fixed typos on commit message;
---
 lib/Kconfig.debug                        | 20 +++++++--
 lib/Makefile                             |  2 +-
 lib/{test_overflow.c => overflow-test.c} | 54 +++++++++---------------
 3 files changed, 38 insertions(+), 38 deletions(-)
 rename lib/{test_overflow.c => overflow-test.c} (96%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d74ac0fd6b2d..fb8a3955e969 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2000,9 +2000,6 @@ config TEST_UUID
 config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
-config TEST_OVERFLOW
-	tristate "Test check_*_overflow() functions at runtime"
-
 config TEST_RHASHTABLE
 	tristate "Perform selftest on resizable hash table"
 	help
@@ -2155,6 +2152,23 @@ config SYSCTL_KUNIT_TEST
 
 	  If unsure, say N.
 
+config OVERFLOW_KUNIT_TEST
+	tristate "KUnit test for overflow" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the overflow KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a production
+	  build.
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
index b1c42c10073b..3b725c9f92d4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -75,7 +75,6 @@ obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
-obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
@@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow-test.o
diff --git a/lib/test_overflow.c b/lib/overflow-test.c
similarity index 96%
rename from lib/test_overflow.c
rename to lib/overflow-test.c
index 7a4b6f6c5473..d40ef06b1ade 100644
--- a/lib/test_overflow.c
+++ b/lib/overflow-test.c
@@ -4,14 +4,11 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/device.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/mm.h>
-#include <linux/module.h>
 #include <linux/overflow.h>
-#include <linux/slab.h>
-#include <linux/types.h>
 #include <linux/vmalloc.h>
 
 #define DEFINE_TEST_ARRAY(t)			\
@@ -270,7 +267,7 @@ DEFINE_TEST_FUNC(u64, "%llu");
 DEFINE_TEST_FUNC(s64, "%lld");
 #endif
 
-static int __init test_overflow_calculation(void)
+static void __init overflow_calculation_test(struct kunit *test)
 {
 	int err = 0;
 
@@ -285,10 +282,10 @@ static int __init test_overflow_calculation(void)
 	err |= test_s64_overflow();
 #endif
 
-	return err;
+	KUNIT_EXPECT_FALSE(test, err);
 }
 
-static int __init test_overflow_shift(void)
+static void __init overflow_shift_test(struct kunit *test)
 {
 	int err = 0;
 
@@ -479,7 +476,7 @@ static int __init test_overflow_shift(void)
 	err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
 	err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
 
-	return err;
+	KUNIT_EXPECT_FALSE(test, err);
 }
 
 /*
@@ -555,7 +552,7 @@ DEFINE_TEST_ALLOC(kvzalloc_node, kvfree,     0, 1, 1);
 DEFINE_TEST_ALLOC(devm_kmalloc,  devm_kfree, 1, 1, 0);
 DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
 
-static int __init test_overflow_allocation(void)
+static void __init overflow_allocation_test(struct kunit *test)
 {
 	const char device_name[] = "overflow-test";
 	struct device *dev;
@@ -563,10 +560,8 @@ static int __init test_overflow_allocation(void)
 
 	/* Create dummy device for devm_kmalloc()-family tests. */
 	dev = root_device_register(device_name);
-	if (IS_ERR(dev)) {
-		pr_warn("Cannot register test device\n");
-		return 1;
-	}
+	if (IS_ERR(dev))
+		kunit_warn(test, "Cannot register test device\n");
 
 	err |= test_kmalloc(NULL);
 	err |= test_kmalloc_node(NULL);
@@ -585,30 +580,21 @@ static int __init test_overflow_allocation(void)
 
 	device_unregister(dev);
 
-	return err;
+	KUNIT_EXPECT_FALSE(test, err);
 }
 
-static int __init test_module_init(void)
-{
-	int err = 0;
-
-	err |= test_overflow_calculation();
-	err |= test_overflow_shift();
-	err |= test_overflow_allocation();
-
-	if (err) {
-		pr_warn("FAIL!\n");
-		err = -EINVAL;
-	} else {
-		pr_info("all tests passed\n");
-	}
+static struct kunit_case __refdata overflow_test_cases[] = {
+	KUNIT_CASE(overflow_calculation_test),
+	KUNIT_CASE(overflow_shift_test),
+	KUNIT_CASE(overflow_allocation_test),
+	{}
+};
 
-	return err;
-}
+static struct kunit_suite overflow_test_suite = {
+	.name = "overflow",
+	.test_cases = overflow_test_cases,
+};
 
-static void __exit test_module_exit(void)
-{ }
+kunit_test_suites(&overflow_test_suite);
 
-module_init(test_module_init);
-module_exit(test_module_exit);
 MODULE_LICENSE("Dual MIT/GPL");

base-commit: 7bf200b3a4ac10b1b0376c70b8c66ed39eae7cdd
prerequisite-patch-id: e827b6b22f950b9f69620805a04e4a264cf4cc6a
-- 
2.26.2

