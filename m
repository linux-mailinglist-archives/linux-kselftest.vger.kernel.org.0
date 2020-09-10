Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28A6263E09
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgIJHH6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 03:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgIJHDt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 03:03:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72F9C061799
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 00:03:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a6so4653507ybr.4
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 00:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=l38zBJnCVwP8lZODTAUrnp4l2jbHeiJfoTD6Br1K0zw=;
        b=sfimTjMFFaPyfnwcGXVm5e/OTx1qLozMiOlBXb4T4tHCtM4CwQgMXlUrlXG79sCsnb
         bzqkF+Kv7IA760jEAmw6yelhR//WUMGNMrYn6KNDtu/Entz4RxsX7Wev6k5Vluu3xiWz
         D3LLG3NALkIKynRrbO1TFUJwJ0HRk/ObbZ4vdXz7sf7oRTFoy+HWWb29VPsJO4lbxCSw
         EL+7m8dWZ2kbWJ161h5j3ydRcmP7OqSYgjNw/vfmK2wp6zSOtu2Xrb+wPFNdZEBmVfVw
         kK564rQTfgh4y9kublpewnQyxg2v61YVNGA9tpTLcspQQgwJCMmltDz5rPgU43lxxXFF
         8rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l38zBJnCVwP8lZODTAUrnp4l2jbHeiJfoTD6Br1K0zw=;
        b=YZsUU6/a/OnMIoqhl3Xa/zzb8CvhFUroAmKP/KBvFR3D6Pqht5PZySoAGbtJ8QEgTN
         9VOUALUNXr+qe22NOKTGhCT6QhN+A78GcxMAb6CRoOFi4nu5aIlopuQpP5FBC3mm1MHc
         9ArH7feB+F0H6p2JNATqqCwTjl/Dw1Qur4gIRoVRja3Nn/PEBk2mBgsnBqu2jYQSy9g8
         cs9wHgSQlyyaw+ju3xD3fMY7VmiN9Q38sfW+QvmEJ/7SA+jqBPlx9rf7WHGYcDdeG7DH
         3rVFbp6KNTsAbcD3FFXOhtt0y3vm+P/1kwMPGH0Uo+2jKqHEot7iw9lZe6pb4QSHh6Fe
         gj7w==
X-Gm-Message-State: AOAM531+Fs68Gqemp6Jdp4m7Xea33dzFZSFAfdymOpumwcVZJXmXO+F6
        vQUzmIuSxj0us43fAH1PTPSigg22REC8wQ==
X-Google-Smtp-Source: ABdhPJxfn2TQ8j0aBb2VRBtkP3KwoA60p3inkmx5P3oRJbD/P/X1r4vlEZ49k9TlzmGRnGDk5u2d6dbRuX9mOQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:b111:: with SMTP id
 g17mr11673875ybj.483.1599721426983; Thu, 10 Sep 2020 00:03:46 -0700 (PDT)
Date:   Thu, 10 Sep 2020 00:03:28 -0700
In-Reply-To: <20200910070331.3358048-1-davidgow@google.com>
Message-Id: <20200910070331.3358048-4-davidgow@google.com>
Mime-Version: 1.0
References: <20200910070331.3358048-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v13 3/5] KASAN: Port KASAN Tests to KUnit
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

Transfer all previous tests for KASAN to KUnit so they can be run
more easily. Using kunit_tool, developers can run these tests with their
other KUnit tests and see "pass" or "fail" with the appropriate KASAN
report instead of needing to parse each KASAN report to test KASAN
functionalities. All KASAN reports are still printed to dmesg.

Stack tests do not work properly when KASAN_STACK is enabled so
those tests use a check for "if IS_ENABLED(CONFIG_KASAN_STACK)" so they
only run if stack instrumentation is enabled. If KASAN_STACK is not
enabled, KUnit will print a statement to let the user know this test
was not run with KASAN_STACK enabled.

copy_user_test and kasan_rcu_uaf cannot be run in KUnit so there is a
separate test file for those tests, which can be run as before as a
module.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/Kconfig.kasan       |  22 +-
 lib/Makefile            |   3 +-
 lib/test_kasan.c        | 687 +++++++++++++++-------------------------
 lib/test_kasan_module.c | 111 +++++++
 4 files changed, 385 insertions(+), 438 deletions(-)
 create mode 100644 lib/test_kasan_module.c

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 047b53dbfd58..9a237887e52e 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -167,12 +167,24 @@ config KASAN_VMALLOC
 	  for KASAN to detect more sorts of errors (and to support vmapped
 	  stacks), but at the cost of higher memory usage.
 
-config TEST_KASAN
-	tristate "Module for testing KASAN for bug detection"
-	depends on m
+config KASAN_KUNIT_TEST
+	tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
+	depends on KASAN && KUNIT
+	default KUNIT_ALL_TESTS
 	help
-	  This is a test module doing various nasty things like
-	  out of bounds accesses, use after free. It is useful for testing
+	  This is a KUnit test suite doing various nasty things like
+	  out of bounds and use after free accesses. It is useful for testing
 	  kernel debugging features like KASAN.
 
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit
+
+config TEST_KASAN_MODULE
+	tristate "KUnit-incompatible tests of KASAN bug detection capabilities"
+	depends on m && KASAN
+	help
+	  This is a part of the KASAN test suite that is incompatible with
+	  KUnit. Currently includes tests that do bad copy_from/to_user
+	  accesses.
+
 endif # KASAN
diff --git a/lib/Makefile b/lib/Makefile
index a4a4c6864f51..8c94cad26db7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -65,9 +65,10 @@ CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
-obj-$(CONFIG_TEST_KASAN) += test_kasan.o
+obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
 CFLAGS_test_kasan.o += -fno-builtin
 CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
+obj-$(CONFIG_TEST_KASAN_MODULE) += test_kasan_module.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 58bffadd8367..63c26171a791 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -5,8 +5,6 @@
  * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
  */
 
-#define pr_fmt(fmt) "kasan test: %s " fmt, __func__
-
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kasan.h>
@@ -77,416 +75,327 @@ static void kasan_test_exit(struct kunit *test)
 			fail_data.report_found); \
 } while (0)
 
-
-
-/*
- * Note: test functions are marked noinline so that their names appear in
- * reports.
- */
-static noinline void __init kmalloc_oob_right(void)
+static void kmalloc_oob_right(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 123;
 
-	pr_info("out-of-bounds to right\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	ptr[size + OOB_TAG_OFF] = 'x';
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 'x');
 	kfree(ptr);
 }
 
-static noinline void __init kmalloc_oob_left(void)
+static void kmalloc_oob_left(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 15;
 
-	pr_info("out-of-bounds to left\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-	*ptr = *(ptr - 1);
+	KUNIT_EXPECT_KASAN_FAIL(test, *ptr = *(ptr - 1));
 	kfree(ptr);
 }
 
-static noinline void __init kmalloc_node_oob_right(void)
+static void kmalloc_node_oob_right(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 4096;
 
-	pr_info("kmalloc_node(): out-of-bounds to right\n");
 	ptr = kmalloc_node(size, GFP_KERNEL, 0);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-	ptr[size] = 0;
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
 	kfree(ptr);
 }
 
-#ifdef CONFIG_SLUB
-static noinline void __init kmalloc_pagealloc_oob_right(void)
+static void kmalloc_pagealloc_oob_right(struct kunit *test)
 {
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
+	if (!IS_ENABLED(CONFIG_SLUB)) {
+		kunit_info(test, "CONFIG_SLUB is not enabled.");
+		return;
+	}
+
 	/* Allocate a chunk that does not fit into a SLUB cache to trigger
 	 * the page allocator fallback.
 	 */
-	pr_info("kmalloc pagealloc allocation: out-of-bounds to right\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	ptr[size + OOB_TAG_OFF] = 0;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 0);
 	kfree(ptr);
 }
 
-static noinline void __init kmalloc_pagealloc_uaf(void)
+static void kmalloc_pagealloc_uaf(struct kunit *test)
 {
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
-	pr_info("kmalloc pagealloc allocation: use-after-free\n");
-	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
+	if (!IS_ENABLED(CONFIG_SLUB)) {
+		kunit_info(test, "CONFIG_SLUB is not enabled.");
 		return;
 	}
 
+	ptr = kmalloc(size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
 	kfree(ptr);
-	ptr[0] = 0;
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = 0);
 }
 
-static noinline void __init kmalloc_pagealloc_invalid_free(void)
+static void kmalloc_pagealloc_invalid_free(struct kunit *test)
 {
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
-	pr_info("kmalloc pagealloc allocation: invalid-free\n");
-	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
+	if (!IS_ENABLED(CONFIG_SLUB)) {
+		kunit_info(test, "CONFIG_SLUB is not enabled.");
 		return;
 	}
 
-	kfree(ptr + 1);
+	ptr = kmalloc(size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, kfree(ptr + 1));
 }
-#endif
 
-static noinline void __init kmalloc_large_oob_right(void)
+static void kmalloc_large_oob_right(struct kunit *test)
 {
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE - 256;
 	/* Allocate a chunk that is large enough, but still fits into a slab
 	 * and does not trigger the page allocator fallback in SLUB.
 	 */
-	pr_info("kmalloc large allocation: out-of-bounds to right\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-	ptr[size] = 0;
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
 	kfree(ptr);
 }
 
-static noinline void __init kmalloc_oob_krealloc_more(void)
+static void kmalloc_oob_krealloc_more(struct kunit *test)
 {
 	char *ptr1, *ptr2;
 	size_t size1 = 17;
 	size_t size2 = 19;
 
-	pr_info("out-of-bounds after krealloc more\n");
 	ptr1 = kmalloc(size1, GFP_KERNEL);
-	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
-	if (!ptr1 || !ptr2) {
-		pr_err("Allocation failed\n");
-		kfree(ptr1);
-		kfree(ptr2);
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
-	ptr2[size2 + OOB_TAG_OFF] = 'x';
+	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2 + OOB_TAG_OFF] = 'x');
 	kfree(ptr2);
 }
 
-static noinline void __init kmalloc_oob_krealloc_less(void)
+static void kmalloc_oob_krealloc_less(struct kunit *test)
 {
 	char *ptr1, *ptr2;
 	size_t size1 = 17;
 	size_t size2 = 15;
 
-	pr_info("out-of-bounds after krealloc less\n");
 	ptr1 = kmalloc(size1, GFP_KERNEL);
-	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
-	if (!ptr1 || !ptr2) {
-		pr_err("Allocation failed\n");
-		kfree(ptr1);
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
-	ptr2[size2 + OOB_TAG_OFF] = 'x';
+	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2 + OOB_TAG_OFF] = 'x');
 	kfree(ptr2);
 }
 
-static noinline void __init kmalloc_oob_16(void)
+static void kmalloc_oob_16(struct kunit *test)
 {
 	struct {
 		u64 words[2];
 	} *ptr1, *ptr2;
 
-	pr_info("kmalloc out-of-bounds for 16-bytes access\n");
 	ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
+
 	ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
-	if (!ptr1 || !ptr2) {
-		pr_err("Allocation failed\n");
-		kfree(ptr1);
-		kfree(ptr2);
-		return;
-	}
-	*ptr1 = *ptr2;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 = *ptr2);
 	kfree(ptr1);
 	kfree(ptr2);
 }
 
-static noinline void __init kmalloc_oob_memset_2(void)
+static void kmalloc_oob_memset_2(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 8;
 
-	pr_info("out-of-bounds in memset2\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	memset(ptr + 7 + OOB_TAG_OFF, 0, 2);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 7 + OOB_TAG_OFF, 0, 2));
 	kfree(ptr);
 }
 
-static noinline void __init kmalloc_oob_memset_4(void)
+static void kmalloc_oob_memset_4(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 8;
 
-	pr_info("out-of-bounds in memset4\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	memset(ptr + 5 + OOB_TAG_OFF, 0, 4);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 5 + OOB_TAG_OFF, 0, 4));
 	kfree(ptr);
 }
 
 
-static noinline void __init kmalloc_oob_memset_8(void)
+static void kmalloc_oob_memset_8(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 8;
 
-	pr_info("out-of-bounds in memset8\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	memset(ptr + 1 + OOB_TAG_OFF, 0, 8);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 1 + OOB_TAG_OFF, 0, 8));
 	kfree(ptr);
 }
 
-static noinline void __init kmalloc_oob_memset_16(void)
+static void kmalloc_oob_memset_16(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 16;
 
-	pr_info("out-of-bounds in memset16\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	memset(ptr + 1 + OOB_TAG_OFF, 0, 16);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + 1 + OOB_TAG_OFF, 0, 16));
 	kfree(ptr);
 }
 
-static noinline void __init kmalloc_oob_in_memset(void)
+static void kmalloc_oob_in_memset(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 666;
 
-	pr_info("out-of-bounds in memset\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	memset(ptr, 0, size + 5 + OOB_TAG_OFF);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr, 0, size + 5 + OOB_TAG_OFF));
 	kfree(ptr);
 }
 
-static noinline void __init kmalloc_memmove_invalid_size(void)
+static void kmalloc_memmove_invalid_size(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 64;
 	volatile size_t invalid_size = -2;
 
-	pr_info("invalid size in memmove\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	memset((char *)ptr, 0, 64);
-	memmove((char *)ptr, (char *)ptr + 4, invalid_size);
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
 	kfree(ptr);
 }
 
-static noinline void __init kmalloc_uaf(void)
+static void kmalloc_uaf(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 10;
 
-	pr_info("use-after-free\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	kfree(ptr);
-	*(ptr + 8) = 'x';
+	KUNIT_EXPECT_KASAN_FAIL(test, *(ptr + 8) = 'x');
 }
 
-static noinline void __init kmalloc_uaf_memset(void)
+static void kmalloc_uaf_memset(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 33;
 
-	pr_info("use-after-free in memset\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	kfree(ptr);
-	memset(ptr, 0, size);
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr, 0, size));
 }
 
-static noinline void __init kmalloc_uaf2(void)
+static void kmalloc_uaf2(struct kunit *test)
 {
 	char *ptr1, *ptr2;
 	size_t size = 43;
 
-	pr_info("use-after-free after another kmalloc\n");
 	ptr1 = kmalloc(size, GFP_KERNEL);
-	if (!ptr1) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
 	kfree(ptr1);
+
 	ptr2 = kmalloc(size, GFP_KERNEL);
-	if (!ptr2) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr1[40] = 'x');
+	KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
 
-	ptr1[40] = 'x';
-	if (ptr1 == ptr2)
-		pr_err("Could not detect use-after-free: ptr1 == ptr2\n");
 	kfree(ptr2);
 }
 
-static noinline void __init kfree_via_page(void)
+static void kfree_via_page(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 8;
 	struct page *page;
 	unsigned long offset;
 
-	pr_info("invalid-free false positive (via page)\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	page = virt_to_page(ptr);
 	offset = offset_in_page(ptr);
 	kfree(page_address(page) + offset);
 }
 
-static noinline void __init kfree_via_phys(void)
+static void kfree_via_phys(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 8;
 	phys_addr_t phys;
 
-	pr_info("invalid-free false positive (via phys)\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	phys = virt_to_phys(ptr);
 	kfree(phys_to_virt(phys));
 }
 
-static noinline void __init kmem_cache_oob(void)
+static void kmem_cache_oob(struct kunit *test)
 {
 	char *p;
 	size_t size = 200;
 	struct kmem_cache *cache = kmem_cache_create("test_cache",
 						size, 0,
 						0, NULL);
-	if (!cache) {
-		pr_err("Cache allocation failed\n");
-		return;
-	}
-	pr_info("out-of-bounds in kmem_cache_alloc\n");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
 	p = kmem_cache_alloc(cache, GFP_KERNEL);
 	if (!p) {
-		pr_err("Allocation failed\n");
+		kunit_err(test, "Allocation failed: %s\n", __func__);
 		kmem_cache_destroy(cache);
 		return;
 	}
 
-	*p = p[size + OOB_TAG_OFF];
-
+	KUNIT_EXPECT_KASAN_FAIL(test, *p = p[size + OOB_TAG_OFF]);
 	kmem_cache_free(cache, p);
 	kmem_cache_destroy(cache);
 }
 
-static noinline void __init memcg_accounted_kmem_cache(void)
+static void memcg_accounted_kmem_cache(struct kunit *test)
 {
 	int i;
 	char *p;
@@ -494,12 +403,8 @@ static noinline void __init memcg_accounted_kmem_cache(void)
 	struct kmem_cache *cache;
 
 	cache = kmem_cache_create("test_cache", size, 0, SLAB_ACCOUNT, NULL);
-	if (!cache) {
-		pr_err("Cache allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
 
-	pr_info("allocate memcg accounted object\n");
 	/*
 	 * Several allocations with a delay to allow for lazy per memcg kmem
 	 * cache creation.
@@ -519,134 +424,93 @@ static noinline void __init memcg_accounted_kmem_cache(void)
 
 static char global_array[10];
 
-static noinline void __init kasan_global_oob(void)
+static void kasan_global_oob(struct kunit *test)
 {
 	volatile int i = 3;
 	char *p = &global_array[ARRAY_SIZE(global_array) + i];
 
-	pr_info("out-of-bounds global variable\n");
-	*(volatile char *)p;
-}
-
-static noinline void __init kasan_stack_oob(void)
-{
-	char stack_array[10];
-	volatile int i = OOB_TAG_OFF;
-	char *p = &stack_array[ARRAY_SIZE(stack_array) + i];
-
-	pr_info("out-of-bounds on stack\n");
-	*(volatile char *)p;
+	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
 
-static noinline void __init ksize_unpoisons_memory(void)
+static void ksize_unpoisons_memory(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 123, real_size;
 
-	pr_info("ksize() unpoisons the whole allocated chunk\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	real_size = ksize(ptr);
 	/* This access doesn't trigger an error. */
 	ptr[size] = 'x';
 	/* This one does. */
-	ptr[real_size] = 'y';
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[real_size] = 'y');
 	kfree(ptr);
 }
 
-static noinline void __init copy_user_test(void)
+static void kasan_stack_oob(struct kunit *test)
 {
-	char *kmem;
-	char __user *usermem;
-	size_t size = 10;
-	int unused;
-
-	kmem = kmalloc(size, GFP_KERNEL);
-	if (!kmem)
-		return;
+	char stack_array[10];
+	volatile int i = OOB_TAG_OFF;
+	char *p = &stack_array[ARRAY_SIZE(stack_array) + i];
 
-	usermem = (char __user *)vm_mmap(NULL, 0, PAGE_SIZE,
-			    PROT_READ | PROT_WRITE | PROT_EXEC,
-			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
-	if (IS_ERR(usermem)) {
-		pr_err("Failed to allocate user memory\n");
-		kfree(kmem);
+	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
+		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
 		return;
 	}
 
-	pr_info("out-of-bounds in copy_from_user()\n");
-	unused = copy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
-
-	pr_info("out-of-bounds in copy_to_user()\n");
-	unused = copy_to_user(usermem, kmem, size + 1 + OOB_TAG_OFF);
-
-	pr_info("out-of-bounds in __copy_from_user()\n");
-	unused = __copy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
-
-	pr_info("out-of-bounds in __copy_to_user()\n");
-	unused = __copy_to_user(usermem, kmem, size + 1 + OOB_TAG_OFF);
-
-	pr_info("out-of-bounds in __copy_from_user_inatomic()\n");
-	unused = __copy_from_user_inatomic(kmem, usermem, size + 1 + OOB_TAG_OFF);
-
-	pr_info("out-of-bounds in __copy_to_user_inatomic()\n");
-	unused = __copy_to_user_inatomic(usermem, kmem, size + 1 + OOB_TAG_OFF);
-
-	pr_info("out-of-bounds in strncpy_from_user()\n");
-	unused = strncpy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
-
-	vm_munmap((unsigned long)usermem, PAGE_SIZE);
-	kfree(kmem);
+	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
 
-static noinline void __init kasan_alloca_oob_left(void)
+static void kasan_alloca_oob_left(struct kunit *test)
 {
 	volatile int i = 10;
 	char alloca_array[i];
 	char *p = alloca_array - 1;
 
-	pr_info("out-of-bounds to left on alloca\n");
-	*(volatile char *)p;
+	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
+		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
+		return;
+	}
+
+	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
 
-static noinline void __init kasan_alloca_oob_right(void)
+static void kasan_alloca_oob_right(struct kunit *test)
 {
 	volatile int i = 10;
 	char alloca_array[i];
 	char *p = alloca_array + i;
 
-	pr_info("out-of-bounds to right on alloca\n");
-	*(volatile char *)p;
+	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
+		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
+		return;
+	}
+
+	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
 
-static noinline void __init kmem_cache_double_free(void)
+static void kmem_cache_double_free(struct kunit *test)
 {
 	char *p;
 	size_t size = 200;
 	struct kmem_cache *cache;
 
 	cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
-	if (!cache) {
-		pr_err("Cache allocation failed\n");
-		return;
-	}
-	pr_info("double-free on heap object\n");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+
 	p = kmem_cache_alloc(cache, GFP_KERNEL);
 	if (!p) {
-		pr_err("Allocation failed\n");
+		kunit_err(test, "Allocation failed: %s\n", __func__);
 		kmem_cache_destroy(cache);
 		return;
 	}
 
 	kmem_cache_free(cache, p);
-	kmem_cache_free(cache, p);
+	KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_free(cache, p));
 	kmem_cache_destroy(cache);
 }
 
-static noinline void __init kmem_cache_invalid_free(void)
+static void kmem_cache_invalid_free(struct kunit *test)
 {
 	char *p;
 	size_t size = 200;
@@ -654,20 +518,17 @@ static noinline void __init kmem_cache_invalid_free(void)
 
 	cache = kmem_cache_create("test_cache", size, 0, SLAB_TYPESAFE_BY_RCU,
 				  NULL);
-	if (!cache) {
-		pr_err("Cache allocation failed\n");
-		return;
-	}
-	pr_info("invalid-free of heap object\n");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+
 	p = kmem_cache_alloc(cache, GFP_KERNEL);
 	if (!p) {
-		pr_err("Allocation failed\n");
+		kunit_err(test, "Allocation failed: %s\n", __func__);
 		kmem_cache_destroy(cache);
 		return;
 	}
 
 	/* Trigger invalid free, the object doesn't get freed */
-	kmem_cache_free(cache, p + 1);
+	KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_free(cache, p + 1));
 
 	/*
 	 * Properly free the object to prevent the "Objects remaining in
@@ -678,45 +539,63 @@ static noinline void __init kmem_cache_invalid_free(void)
 	kmem_cache_destroy(cache);
 }
 
-static noinline void __init kasan_memchr(void)
+static void kasan_memchr(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 24;
 
-	pr_info("out-of-bounds in memchr\n");
-	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
-	if (!ptr)
+	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		kunit_info(test,
+			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
 		return;
+	}
+
+	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		kasan_ptr_result = memchr(ptr, '1', size + 1));
 
-	kasan_ptr_result = memchr(ptr, '1', size + 1);
 	kfree(ptr);
 }
 
-static noinline void __init kasan_memcmp(void)
+static void kasan_memcmp(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 24;
 	int arr[9];
 
-	pr_info("out-of-bounds in memcmp\n");
-	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
-	if (!ptr)
+	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		kunit_info(test,
+			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
 		return;
+	}
 
+	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	memset(arr, 0, sizeof(arr));
-	kasan_int_result = memcmp(ptr, arr, size + 1);
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		kasan_int_result = memcmp(ptr, arr, size+1));
 	kfree(ptr);
 }
 
-static noinline void __init kasan_strings(void)
+static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 24;
 
-	pr_info("use-after-free in strchr\n");
-	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
-	if (!ptr)
+	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
+	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+		kunit_info(test,
+			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
 		return;
+	}
+
+	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	kfree(ptr);
 
@@ -727,220 +606,164 @@ static noinline void __init kasan_strings(void)
 	 * will likely point to zeroed byte.
 	 */
 	ptr += 16;
-	kasan_ptr_result = strchr(ptr, '1');
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result = strchr(ptr, '1'));
 
-	pr_info("use-after-free in strrchr\n");
-	kasan_ptr_result = strrchr(ptr, '1');
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result = strrchr(ptr, '1'));
 
-	pr_info("use-after-free in strcmp\n");
-	kasan_int_result = strcmp(ptr, "2");
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strcmp(ptr, "2"));
 
-	pr_info("use-after-free in strncmp\n");
-	kasan_int_result = strncmp(ptr, "2", 1);
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strncmp(ptr, "2", 1));
 
-	pr_info("use-after-free in strlen\n");
-	kasan_int_result = strlen(ptr);
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strlen(ptr));
 
-	pr_info("use-after-free in strnlen\n");
-	kasan_int_result = strnlen(ptr, 1);
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strnlen(ptr, 1));
 }
 
-static noinline void __init kasan_bitops(void)
+static void kasan_bitops(struct kunit *test)
 {
 	/*
 	 * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
 	 * this way we do not actually corrupt other memory.
 	 */
 	long *bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
-	if (!bits)
-		return;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bits);
 
 	/*
 	 * Below calls try to access bit within allocated memory; however, the
 	 * below accesses are still out-of-bounds, since bitops are defined to
 	 * operate on the whole long the bit is in.
 	 */
-	pr_info("out-of-bounds in set_bit\n");
-	set_bit(BITS_PER_LONG, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test, set_bit(BITS_PER_LONG, bits));
 
-	pr_info("out-of-bounds in __set_bit\n");
-	__set_bit(BITS_PER_LONG, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test, __set_bit(BITS_PER_LONG, bits));
 
-	pr_info("out-of-bounds in clear_bit\n");
-	clear_bit(BITS_PER_LONG, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test, clear_bit(BITS_PER_LONG, bits));
 
-	pr_info("out-of-bounds in __clear_bit\n");
-	__clear_bit(BITS_PER_LONG, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit(BITS_PER_LONG, bits));
 
-	pr_info("out-of-bounds in clear_bit_unlock\n");
-	clear_bit_unlock(BITS_PER_LONG, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test, clear_bit_unlock(BITS_PER_LONG, bits));
 
-	pr_info("out-of-bounds in __clear_bit_unlock\n");
-	__clear_bit_unlock(BITS_PER_LONG, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit_unlock(BITS_PER_LONG, bits));
 
-	pr_info("out-of-bounds in change_bit\n");
-	change_bit(BITS_PER_LONG, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test, change_bit(BITS_PER_LONG, bits));
 
-	pr_info("out-of-bounds in __change_bit\n");
-	__change_bit(BITS_PER_LONG, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test, __change_bit(BITS_PER_LONG, bits));
 
 	/*
 	 * Below calls try to access bit beyond allocated memory.
 	 */
-	pr_info("out-of-bounds in test_and_set_bit\n");
-	test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
 
-	pr_info("out-of-bounds in __test_and_set_bit\n");
-	__test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		__test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
 
-	pr_info("out-of-bounds in test_and_set_bit_lock\n");
-	test_and_set_bit_lock(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		test_and_set_bit_lock(BITS_PER_LONG + BITS_PER_BYTE, bits));
 
-	pr_info("out-of-bounds in test_and_clear_bit\n");
-	test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
 
-	pr_info("out-of-bounds in __test_and_clear_bit\n");
-	__test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		__test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
 
-	pr_info("out-of-bounds in test_and_change_bit\n");
-	test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
 
-	pr_info("out-of-bounds in __test_and_change_bit\n");
-	__test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		__test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
 
-	pr_info("out-of-bounds in test_bit\n");
-	kasan_int_result = test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		kasan_int_result =
+			test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
 
 #if defined(clear_bit_unlock_is_negative_byte)
-	pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
-	kasan_int_result = clear_bit_unlock_is_negative_byte(BITS_PER_LONG +
-		BITS_PER_BYTE, bits);
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		kasan_int_result = clear_bit_unlock_is_negative_byte(
+			BITS_PER_LONG + BITS_PER_BYTE, bits));
 #endif
 	kfree(bits);
 }
 
-static noinline void __init kmalloc_double_kzfree(void)
+static void kmalloc_double_kzfree(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 16;
 
-	pr_info("double-free (kfree_sensitive)\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	kfree_sensitive(ptr);
-	kfree_sensitive(ptr);
+	KUNIT_EXPECT_KASAN_FAIL(test, kfree_sensitive(ptr));
 }
 
-#ifdef CONFIG_KASAN_VMALLOC
-static noinline void __init vmalloc_oob(void)
+static void vmalloc_oob(struct kunit *test)
 {
 	void *area;
 
-	pr_info("vmalloc out-of-bounds\n");
+	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
+		kunit_info(test, "CONFIG_KASAN_VMALLOC is not enabled.");
+		return;
+	}
 
 	/*
 	 * We have to be careful not to hit the guard page.
 	 * The MMU will catch that and crash us.
 	 */
 	area = vmalloc(3000);
-	if (!area) {
-		pr_err("Allocation failed\n");
-		return;
-	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, area);
 
-	((volatile char *)area)[3100];
+	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)area)[3100]);
 	vfree(area);
 }
-#else
-static void __init vmalloc_oob(void) {}
-#endif
-
-static struct kasan_rcu_info {
-	int i;
-	struct rcu_head rcu;
-} *global_rcu_ptr;
-
-static noinline void __init kasan_rcu_reclaim(struct rcu_head *rp)
-{
-	struct kasan_rcu_info *fp = container_of(rp,
-						struct kasan_rcu_info, rcu);
-
-	kfree(fp);
-	fp->i = 1;
-}
-
-static noinline void __init kasan_rcu_uaf(void)
-{
-	struct kasan_rcu_info *ptr;
 
-	pr_info("use-after-free in kasan_rcu_reclaim\n");
-	ptr = kmalloc(sizeof(struct kasan_rcu_info), GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	global_rcu_ptr = rcu_dereference_protected(ptr, NULL);
-	call_rcu(&global_rcu_ptr->rcu, kasan_rcu_reclaim);
-}
-
-static int __init kmalloc_tests_init(void)
-{
-	/*
-	 * Temporarily enable multi-shot mode. Otherwise, we'd only get a
-	 * report for the first case.
-	 */
-	bool multishot = kasan_save_enable_multi_shot();
-
-	kmalloc_oob_right();
-	kmalloc_oob_left();
-	kmalloc_node_oob_right();
-#ifdef CONFIG_SLUB
-	kmalloc_pagealloc_oob_right();
-	kmalloc_pagealloc_uaf();
-	kmalloc_pagealloc_invalid_free();
-#endif
-	kmalloc_large_oob_right();
-	kmalloc_oob_krealloc_more();
-	kmalloc_oob_krealloc_less();
-	kmalloc_oob_16();
-	kmalloc_oob_in_memset();
-	kmalloc_oob_memset_2();
-	kmalloc_oob_memset_4();
-	kmalloc_oob_memset_8();
-	kmalloc_oob_memset_16();
-	kmalloc_memmove_invalid_size();
-	kmalloc_uaf();
-	kmalloc_uaf_memset();
-	kmalloc_uaf2();
-	kfree_via_page();
-	kfree_via_phys();
-	kmem_cache_oob();
-	memcg_accounted_kmem_cache();
-	kasan_stack_oob();
-	kasan_global_oob();
-	kasan_alloca_oob_left();
-	kasan_alloca_oob_right();
-	ksize_unpoisons_memory();
-	copy_user_test();
-	kmem_cache_double_free();
-	kmem_cache_invalid_free();
-	kasan_memchr();
-	kasan_memcmp();
-	kasan_strings();
-	kasan_bitops();
-	kmalloc_double_kzfree();
-	vmalloc_oob();
-	kasan_rcu_uaf();
-
-	kasan_restore_multi_shot(multishot);
-
-	return -EAGAIN;
-}
+static struct kunit_case kasan_kunit_test_cases[] = {
+	KUNIT_CASE(kmalloc_oob_right),
+	KUNIT_CASE(kmalloc_oob_left),
+	KUNIT_CASE(kmalloc_node_oob_right),
+	KUNIT_CASE(kmalloc_pagealloc_oob_right),
+	KUNIT_CASE(kmalloc_pagealloc_uaf),
+	KUNIT_CASE(kmalloc_pagealloc_invalid_free),
+	KUNIT_CASE(kmalloc_large_oob_right),
+	KUNIT_CASE(kmalloc_oob_krealloc_more),
+	KUNIT_CASE(kmalloc_oob_krealloc_less),
+	KUNIT_CASE(kmalloc_oob_16),
+	KUNIT_CASE(kmalloc_oob_in_memset),
+	KUNIT_CASE(kmalloc_oob_memset_2),
+	KUNIT_CASE(kmalloc_oob_memset_4),
+	KUNIT_CASE(kmalloc_oob_memset_8),
+	KUNIT_CASE(kmalloc_oob_memset_16),
+	KUNIT_CASE(kmalloc_memmove_invalid_size),
+	KUNIT_CASE(kmalloc_uaf),
+	KUNIT_CASE(kmalloc_uaf_memset),
+	KUNIT_CASE(kmalloc_uaf2),
+	KUNIT_CASE(kfree_via_page),
+	KUNIT_CASE(kfree_via_phys),
+	KUNIT_CASE(kmem_cache_oob),
+	KUNIT_CASE(memcg_accounted_kmem_cache),
+	KUNIT_CASE(kasan_global_oob),
+	KUNIT_CASE(kasan_stack_oob),
+	KUNIT_CASE(kasan_alloca_oob_left),
+	KUNIT_CASE(kasan_alloca_oob_right),
+	KUNIT_CASE(ksize_unpoisons_memory),
+	KUNIT_CASE(kmem_cache_double_free),
+	KUNIT_CASE(kmem_cache_invalid_free),
+	KUNIT_CASE(kasan_memchr),
+	KUNIT_CASE(kasan_memcmp),
+	KUNIT_CASE(kasan_strings),
+	KUNIT_CASE(kasan_bitops),
+	KUNIT_CASE(kmalloc_double_kzfree),
+	KUNIT_CASE(vmalloc_oob),
+	{}
+};
+
+static struct kunit_suite kasan_kunit_test_suite = {
+	.name = "kasan",
+	.init = kasan_test_init,
+	.test_cases = kasan_kunit_test_cases,
+	.exit = kasan_test_exit,
+};
+
+kunit_test_suite(kasan_kunit_test_suite);
 
-module_init(kmalloc_tests_init);
 MODULE_LICENSE("GPL");
diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
new file mode 100644
index 000000000000..2d68db6ae67b
--- /dev/null
+++ b/lib/test_kasan_module.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
+ */
+
+#define pr_fmt(fmt) "kasan test: %s " fmt, __func__
+
+#include <linux/mman.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "../mm/kasan/kasan.h"
+
+#define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_SHADOW_SCALE_SIZE)
+
+static noinline void __init copy_user_test(void)
+{
+	char *kmem;
+	char __user *usermem;
+	size_t size = 10;
+	int unused;
+
+	kmem = kmalloc(size, GFP_KERNEL);
+	if (!kmem)
+		return;
+
+	usermem = (char __user *)vm_mmap(NULL, 0, PAGE_SIZE,
+			    PROT_READ | PROT_WRITE | PROT_EXEC,
+			    MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	if (IS_ERR(usermem)) {
+		pr_err("Failed to allocate user memory\n");
+		kfree(kmem);
+		return;
+	}
+
+	pr_info("out-of-bounds in copy_from_user()\n");
+	unused = copy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
+
+	pr_info("out-of-bounds in copy_to_user()\n");
+	unused = copy_to_user(usermem, kmem, size + 1 + OOB_TAG_OFF);
+
+	pr_info("out-of-bounds in __copy_from_user()\n");
+	unused = __copy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
+
+	pr_info("out-of-bounds in __copy_to_user()\n");
+	unused = __copy_to_user(usermem, kmem, size + 1 + OOB_TAG_OFF);
+
+	pr_info("out-of-bounds in __copy_from_user_inatomic()\n");
+	unused = __copy_from_user_inatomic(kmem, usermem, size + 1 + OOB_TAG_OFF);
+
+	pr_info("out-of-bounds in __copy_to_user_inatomic()\n");
+	unused = __copy_to_user_inatomic(usermem, kmem, size + 1 + OOB_TAG_OFF);
+
+	pr_info("out-of-bounds in strncpy_from_user()\n");
+	unused = strncpy_from_user(kmem, usermem, size + 1 + OOB_TAG_OFF);
+
+	vm_munmap((unsigned long)usermem, PAGE_SIZE);
+	kfree(kmem);
+}
+
+static struct kasan_rcu_info {
+	int i;
+	struct rcu_head rcu;
+} *global_rcu_ptr;
+
+static noinline void __init kasan_rcu_reclaim(struct rcu_head *rp)
+{
+	struct kasan_rcu_info *fp = container_of(rp,
+						struct kasan_rcu_info, rcu);
+
+	kfree(fp);
+	fp->i = 1;
+}
+
+static noinline void __init kasan_rcu_uaf(void)
+{
+	struct kasan_rcu_info *ptr;
+
+	pr_info("use-after-free in kasan_rcu_reclaim\n");
+	ptr = kmalloc(sizeof(struct kasan_rcu_info), GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	global_rcu_ptr = rcu_dereference_protected(ptr, NULL);
+	call_rcu(&global_rcu_ptr->rcu, kasan_rcu_reclaim);
+}
+
+
+static int __init test_kasan_module_init(void)
+{
+	/*
+	 * Temporarily enable multi-shot mode. Otherwise, we'd only get a
+	 * report for the first case.
+	 */
+	bool multishot = kasan_save_enable_multi_shot();
+
+	copy_user_test();
+	kasan_rcu_uaf();
+
+	kasan_restore_multi_shot(multishot);
+	return -EAGAIN;
+}
+
+module_init(test_kasan_module_init);
+MODULE_LICENSE("GPL");
-- 
2.28.0.526.ge36021eeef-goog

