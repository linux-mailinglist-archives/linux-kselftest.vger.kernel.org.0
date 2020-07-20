Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50439227275
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 00:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGTWo0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 18:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgGTWoZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 18:44:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88BC061794
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jul 2020 15:44:24 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so14713978qtr.9
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jul 2020 15:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ag3CH9gIrCGq60wqLtIh8GQRzVO4EAvpufO2Zb/zlwc=;
        b=MijXTMv2wmOpRT0tSxn67usaHrw7v5/wM9T09O2XbEPBquJps5+8tk8hPgi+9s8haX
         DwenNjaAEUmqapQyTASXTIMFLrqfJ5maiAbJQLOCfogISvfTxHrXjb/P3vx8ORIPJZON
         IKLq7gwEwA4XcBWmR2Z24Pi7TAlfL9mNK6ntT2H9RvN/4/UbbmwNRY/A9QLg8S1sVL4p
         kQBzA5Al3O8Ct7hjyr+Q6j6YqSAcL+/GJIPjnN6I9OuxTl2lrbQPHmJy048u9YeXUZDo
         /0Y5h6zcEukIuboddjdF2QFrEnX1ablLh0vlr2c8qn2PzSq2CTzpap7gEEC7oJdQxH6k
         JlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ag3CH9gIrCGq60wqLtIh8GQRzVO4EAvpufO2Zb/zlwc=;
        b=FXpV4MEi3QXDnA/EcyNpCLYxV1H4PSyu5miN3L/3K/YQ1I5pGZJXDBaNURU2+n6xGv
         J13NTHHD7Bcg3T1dVJLyIi804DzNlLxQxDxT5RhRJp+RXOo5fCX8CYE+ZVxS3CF6HJEp
         ehUR1DWpBUU6YgjywQbbHhTxzivo9pNAAU0Elp+S9J7E8l7pvdPswc9ZObY4E5Bldmx1
         o+9JBhpC07ePSYnsdTlTQ+RGjPzsriMysojbj+oAQ47kuBI8WdsUUBYxEY1UGofoVRMS
         lnxRoiX+9QW8bLul7c4m7Q1mU4NluNy3KWl830Yp/vvwRFR7jP7pgsymIOJ6TZhMrYwU
         TIzA==
X-Gm-Message-State: AOAM533vAAgl7uN4r+BsrOIEvpz/0errblfO/CSN7++mKCIACAvlZ8Sy
        WzgkSiDSrHUqKfVswz7k8p6jZ8e6Lgdh6A==
X-Google-Smtp-Source: ABdhPJwpZN6+9Bs9wz4nAsemF8PM8GzrSfDmAGPEYHHS4VKn288EfCse8gYvM/GJ6JWxwBpXQ1D0RQ==
X-Received: by 2002:ac8:3985:: with SMTP id v5mr25758367qte.337.1595285064006;
        Mon, 20 Jul 2020 15:44:24 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id g136sm795513qke.82.2020.07.20.15.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:44:22 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] lib: overflow_kunit: add KUnit test conversion of check_*_overflow
Date:   Mon, 20 Jul 2020 19:44:18 -0300
Message-Id: <20200720224418.200495-1-vitor@massaru.org>
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
Tested-by: David Gow <davidgow@google.com>
---
v2:
  * moved lib/test_overflow.c to lib/overflow-test.c;
    * back to original license;
    * fixed style code;
    * keeps __initconst and added _refdata on overflow_test_cases variable;
    * keeps macros intact making asserts with the variable err;
    * removed duplicate test_s8_overflow();
  * fixed typos on commit message;

v3:
  * changed filename to overflow_kunit.c;
  * replace _refdata by _inidata;
  * added expects/asserts on individual tests;
---
 lib/Kconfig.debug                         |  20 +++-
 lib/Makefile                              |   2 +-
 lib/{test_overflow.c => overflow_kunit.c} | 122 +++++++++-------------
 3 files changed, 70 insertions(+), 74 deletions(-)
 rename lib/{test_overflow.c => overflow_kunit.c} (91%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..230aaf418dc0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1999,9 +1999,6 @@ config TEST_UUID
 config TEST_XARRAY
 	tristate "Test the XArray code at runtime"

-config TEST_OVERFLOW
-	tristate "Test check_*_overflow() functions at runtime"
-
 config TEST_RHASHTABLE
 	tristate "Perform selftest on resizable hash table"
 	help
@@ -2154,6 +2151,23 @@ config SYSCTL_KUNIT_TEST

 	  If unsure, say N.

+config OVERFLOW_KUNIT
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
index b1c42c10073b..c3cf72ec6c52 100644
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
+obj-$(CONFIG_OVERFLOW_KUNIT) += overflow_kunit.o
diff --git a/lib/test_overflow.c b/lib/overflow_kunit.c
similarity index 91%
rename from lib/test_overflow.c
rename to lib/overflow_kunit.c
index 7a4b6f6c5473..475d0daeb801 100644
--- a/lib/test_overflow.c
+++ b/lib/overflow_kunit.c
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
@@ -248,7 +245,7 @@ static int __init do_test_ ## t(const struct test_ ## t *p)		\
 	return err;							\
 }									\
 									\
-static int __init test_ ## t ## _overflow(void) {			\
+static int __init test_ ## t ## _overflow(struct kunit *test) {	\
 	int err = 0;							\
 	unsigned i;							\
 									\
@@ -256,6 +253,7 @@ static int __init test_ ## t ## _overflow(void) {			\
 		ARRAY_SIZE(t ## _tests));				\
 	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
 		err |= do_test_ ## t(&t ## _tests[i]);			\
+	KUNIT_EXPECT_FALSE(test, err);					\
 	return err;							\
 }

@@ -270,25 +268,25 @@ DEFINE_TEST_FUNC(u64, "%llu");
 DEFINE_TEST_FUNC(s64, "%lld");
 #endif

-static int __init test_overflow_calculation(void)
+static void __init overflow_calculation_test(struct kunit *test)
 {
 	int err = 0;

-	err |= test_u8_overflow();
-	err |= test_s8_overflow();
-	err |= test_u16_overflow();
-	err |= test_s16_overflow();
-	err |= test_u32_overflow();
-	err |= test_s32_overflow();
+	err |= test_u8_overflow(test);
+	err |= test_s8_overflow(test);
+	err |= test_u16_overflow(test);
+	err |= test_s16_overflow(test);
+	err |= test_u32_overflow(test);
+	err |= test_s32_overflow(test);
 #if BITS_PER_LONG == 64
-	err |= test_u64_overflow();
-	err |= test_s64_overflow();
+	err |= test_u64_overflow(test);
+	err |= test_s64_overflow(test);
 #endif

-	return err;
+	KUNIT_EXPECT_FALSE(test, err);
 }

-static int __init test_overflow_shift(void)
+static void __init overflow_shift_test(struct kunit *test)
 {
 	int err = 0;

@@ -313,9 +311,9 @@ static int __init test_overflow_shift(void)
 			pr_warn("got %llu\n", (u64)__d);		\
 		__failed = 1;						\
 	}								\
-	if (!__failed)							\
-		pr_info("ok: (%s)(%s << %s) == %s\n", #t, #a, #s,	\
-			of ? "overflow" : #expect);			\
+	KUNIT_EXPECT_FALSE_MSG(test, __failed,				\
+			       "ok: (%s)(%s << %s) == %s\n", #t, #a, #s,\
+			       of ? "overflow" : #expect);		\
 	__failed;							\
 })

@@ -479,7 +477,7 @@ static int __init test_overflow_shift(void)
 	err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
 	err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);

-	return err;
+	KUNIT_EXPECT_FALSE(test, err);
 }

 /*
@@ -499,7 +497,7 @@ static int __init test_overflow_shift(void)
 #define TEST_SIZE		(5 * 4096)

 #define DEFINE_TEST_ALLOC(func, free_func, want_arg, want_gfp, want_node)\
-static int __init test_ ## func (void *arg)				\
+static int __init test_ ## func (struct kunit *test, void *arg)		\
 {									\
 	volatile size_t a = TEST_SIZE;					\
 	volatile size_t b = (SIZE_MAX / TEST_SIZE) + 1;			\
@@ -507,19 +505,15 @@ static int __init test_ ## func (void *arg)				\
 									\
 	/* Tiny allocation test. */					\
 	ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg, 1);\
-	if (!ptr) {							\
-		pr_warn(#func " failed regular allocation?!\n");	\
-		return 1;						\
-	}								\
+	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,			\
+			#func " failed regular allocation?!\n");	\
 	free ## want_arg (free_func, arg, ptr);				\
 									\
 	/* Wrapped allocation test. */					\
 	ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,	\
 							  a * b);	\
-	if (!ptr) {							\
-		pr_warn(#func " unexpectedly failed bad wrapping?!\n");	\
-		return 1;						\
-	}								\
+	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,			\
+			#func " unexpectedly failed bad wrapping?!\n"); \
 	free ## want_arg (free_func, arg, ptr);				\
 									\
 	/* Saturated allocation test. */				\
@@ -555,7 +549,7 @@ DEFINE_TEST_ALLOC(kvzalloc_node, kvfree,     0, 1, 1);
 DEFINE_TEST_ALLOC(devm_kmalloc,  devm_kfree, 1, 1, 0);
 DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);

-static int __init test_overflow_allocation(void)
+static void __init overflow_allocation_test(struct kunit *test)
 {
 	const char device_name[] = "overflow-test";
 	struct device *dev;
@@ -563,52 +557,40 @@ static int __init test_overflow_allocation(void)

 	/* Create dummy device for devm_kmalloc()-family tests. */
 	dev = root_device_register(device_name);
-	if (IS_ERR(dev)) {
-		pr_warn("Cannot register test device\n");
-		return 1;
-	}
-
-	err |= test_kmalloc(NULL);
-	err |= test_kmalloc_node(NULL);
-	err |= test_kzalloc(NULL);
-	err |= test_kzalloc_node(NULL);
-	err |= test_kvmalloc(NULL);
-	err |= test_kvmalloc_node(NULL);
-	err |= test_kvzalloc(NULL);
-	err |= test_kvzalloc_node(NULL);
-	err |= test_vmalloc(NULL);
-	err |= test_vmalloc_node(NULL);
-	err |= test_vzalloc(NULL);
-	err |= test_vzalloc_node(NULL);
-	err |= test_devm_kmalloc(dev);
-	err |= test_devm_kzalloc(dev);
+	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev), "Cannot register test device\n");
+
+	err |= test_kmalloc(test, NULL);
+	err |= test_kmalloc_node(test, NULL);
+	err |= test_kzalloc(test, NULL);
+	err |= test_kzalloc_node(test, NULL);
+	err |= test_kvmalloc(test, NULL);
+	err |= test_kvmalloc_node(test, NULL);
+	err |= test_kvzalloc(test, NULL);
+	err |= test_kvzalloc_node(test, NULL);
+	err |= test_vmalloc(test, NULL);
+	err |= test_vmalloc_node(test, NULL);
+	err |= test_vzalloc(test, NULL);
+	err |= test_vzalloc_node(test, NULL);
+	err |= test_devm_kmalloc(test, dev);
+	err |= test_devm_kzalloc(test, dev);

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
+static struct kunit_case __initdata overflow_test_cases[] = {
+	KUNIT_CASE(overflow_calculation_test),
+	KUNIT_CASE(overflow_shift_test),
+	KUNIT_CASE(overflow_allocation_test),
+	{}
+};

-	return err;
-}
+static struct kunit_suite __initdata overflow_test_suite = {
+	.name = "overflow",
+	.test_cases = overflow_test_cases,
+};

-static void __exit test_module_exit(void)
-{ }
+kunit_test_suites(&overflow_test_suite);

-module_init(test_module_init);
-module_exit(test_module_exit);
 MODULE_LICENSE("Dual MIT/GPL");

base-commit: c63d2dd7e134ebddce4745c51f9572b3f0d92b26
--
2.26.2

