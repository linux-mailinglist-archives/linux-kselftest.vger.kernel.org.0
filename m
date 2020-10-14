Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6808F28EAFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 04:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgJOCOj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 22:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbgJOCOj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 22:14:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F724C025278
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 16:47:53 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z6so995272qkz.4
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wrnn6DD0M5Puv0hp8zDhFVfWjeqMqGBFBnj5V/64+8=;
        b=qEnFg0M6WRHbr0ghrj4kW7FV63er+uXVMUMlGSqITZvQ5UbcP3ssFjukWGpoOMlRPb
         AZCECvbM+LTJrelT+H7lo+etK1CkVQvdrDhnuTJhiwhKXIcVgCuo83fepS64ijCj5I27
         19wRwXz/L/4fRVFncSXnZ6xadj7OGe0xA66hC1X4uDvHjyx8EJUbOx3Ug4tfs+yW+ocy
         V3Q2Zbrf+GzTcW0ve0Mg9zKrwZEL8zTCYbpPPkAWTCTyxIoVvzs61OjPokHNdPFdtA9G
         Q6uHJosqD3wFRY4wGouwq9SI7myfHxIzp8FzjoH8w5hrmMsbV8rTF5OEqE6C/oC1BEGT
         Xf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3wrnn6DD0M5Puv0hp8zDhFVfWjeqMqGBFBnj5V/64+8=;
        b=Ey2ftUXkKzUgAuOWs9i4Ldydt3aVtkjXMvpUJR8P3ffmwLNOOdPHQClWi0ZQB94roe
         OZDhx/VAmbnR5/NDlsRErkaqbCl0C2Xubt4CwczNiLGPPbdKdlXtOGGcA4YstIYhx+eA
         drQYZn4PSMp/vzBJyZywHPxUV1O53Ph2ekkxQD9gD0ttwQlE7GKqyOFSO3xkW/PBK3vU
         bVmqG0W/TJqaNajZvLwA0Vn8DphXd6G/kjt0E/1lf4E7vIrQnUJiw/+Cq5MOTr81mHuE
         LfRa38BjELtWtmBADQoct1mL97ESJf8EtrVG9kPtpKcd9KEIVOutZkF1BYzJrrm4xdnP
         Ut/A==
X-Gm-Message-State: AOAM532h7NFD31tE+jGUlK/GaFUpWdOQ4i9HjkLb7qKSDAAbIkZVEHFZ
        BcBeb0RCNYjB4MrlCeM2kTw9oQ==
X-Google-Smtp-Source: ABdhPJyYMusmq4hM6y9MlxGdGlBhIL8YURIXybDIuyDfZEwkjVaG+VBd2wyeSMTiriXa4qUw5u9TPw==
X-Received: by 2002:a05:620a:6d2:: with SMTP id 18mr1613165qky.280.1602719271253;
        Wed, 14 Oct 2020 16:47:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7cb:5e0b:6f3d:fca0:306c:a15d])
        by smtp.gmail.com with ESMTPSA id l25sm515286qtf.18.2020.10.14.16.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 16:47:50 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com, irogers@google.com,
        brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        peterz@infradead.org, mingo@kernel.org
Subject: [PATCH v2] lib: kunit: add test_min_heap test conversion to KUnit
Date:   Wed, 14 Oct 2020 20:47:46 -0300
Message-Id: <20201014234746.235634-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the conversion of the runtime tests of test_min_heap,
from `lib/test_min_heap.c` to KUnit tests.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
  v2: 
    * min_heap test now runs when enabling full test coverage (KUNIT_ALL_TESTS).
---
 lib/Kconfig.debug                         |  29 ++++--
 lib/Makefile                              |   2 +-
 lib/{test_min_heap.c => min_heap_kunit.c} | 117 ++++++++++++----------
 3 files changed, 83 insertions(+), 65 deletions(-)
 rename lib/{test_min_heap.c => min_heap_kunit.c} (60%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4f09c6505a2e..b75f4541e7d2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1915,16 +1915,6 @@ config TEST_LIST_SORT
 
 	  If unsure, say N.
 
-config TEST_MIN_HEAP
-	tristate "Min heap test"
-	depends on DEBUG_KERNEL || m
-	help
-	  Enable this to turn on min heap function tests. This test is
-	  executed only once during system boot (so affects only boot time),
-	  or at module load time.
-
-	  If unsure, say N.
-
 config TEST_SORT
 	tristate "Array-based sort test"
 	depends on DEBUG_KERNEL || m
@@ -2256,6 +2246,25 @@ config BITS_TEST
 
 	  If unsure, say N.
 
+config MIN_HEAP_KUNIT
+	tristate "KUnit test for Min heap" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this to turn on min heap function tests. This test is
+	  executed only once during system boot (so affects only boot time),
+	  or at module load time.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index d862d41fdc3d..c88ade843502 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -68,7 +68,6 @@ CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
-obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
@@ -343,3 +342,4 @@ obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
+obj-$(CONFIG_MIN_HEAP_KUNIT) += min_heap_kunit.o
diff --git a/lib/test_min_heap.c b/lib/min_heap_kunit.c
similarity index 60%
rename from lib/test_min_heap.c
rename to lib/min_heap_kunit.c
index d19c8080fd4d..398db1c63146 100644
--- a/lib/test_min_heap.c
+++ b/lib/min_heap_kunit.c
@@ -7,9 +7,8 @@
 
 #include <linux/log2.h>
 #include <linux/min_heap.h>
-#include <linux/module.h>
-#include <linux/printk.h>
 #include <linux/random.h>
+#include <kunit/test.h>
 
 static __init bool less_than(const void *lhs, const void *rhs)
 {
@@ -29,37 +28,34 @@ static __init void swap_ints(void *lhs, void *rhs)
 	*(int *)rhs = temp;
 }
 
-static __init int pop_verify_heap(bool min_heap,
+static __init void pop_verify_heap(struct kunit *context,
+				bool min_heap,
 				struct min_heap *heap,
 				const struct min_heap_callbacks *funcs)
 {
 	int *values = heap->data;
-	int err = 0;
 	int last;
 
 	last = values[0];
 	min_heap_pop(heap, funcs);
 	while (heap->nr > 0) {
 		if (min_heap) {
-			if (last > values[0]) {
-				pr_err("error: expected %d <= %d\n", last,
-					values[0]);
-				err++;
-			}
+			KUNIT_EXPECT_FALSE_MSG(context,
+					       last > values[0],
+					       "expected %d <= %d\n",
+					       last, values[0]);
 		} else {
-			if (last < values[0]) {
-				pr_err("error: expected %d >= %d\n", last,
-					values[0]);
-				err++;
-			}
+			KUNIT_EXPECT_FALSE_MSG(context,
+					       last < values[0],
+					       "expected %d >= %d\n",
+					       last, values[0]);
 		}
 		last = values[0];
 		min_heap_pop(heap, funcs);
 	}
-	return err;
 }
 
-static __init int test_heapify_all(bool min_heap)
+static __init void test_heapify_all(struct kunit *context, bool min_heap)
 {
 	int values[] = { 3, 1, 2, 4, 0x8000000, 0x7FFFFFF, 0,
 			 -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
@@ -73,12 +69,11 @@ static __init int test_heapify_all(bool min_heap)
 		.less = min_heap ? less_than : greater_than,
 		.swp = swap_ints,
 	};
-	int i, err;
+	int i;
 
 	/* Test with known set of values. */
 	min_heapify_all(&heap, &funcs);
-	err = pop_verify_heap(min_heap, &heap, &funcs);
-
+	pop_verify_heap(context, min_heap, &heap, &funcs);
 
 	/* Test with randomly generated values. */
 	heap.nr = ARRAY_SIZE(values);
@@ -86,12 +81,10 @@ static __init int test_heapify_all(bool min_heap)
 		values[i] = get_random_int();
 
 	min_heapify_all(&heap, &funcs);
-	err += pop_verify_heap(min_heap, &heap, &funcs);
-
-	return err;
+	pop_verify_heap(context, min_heap, &heap, &funcs);
 }
 
-static __init int test_heap_push(bool min_heap)
+static __init void test_heap_push(struct kunit *context, bool min_heap)
 {
 	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
 			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
@@ -106,25 +99,22 @@ static __init int test_heap_push(bool min_heap)
 		.less = min_heap ? less_than : greater_than,
 		.swp = swap_ints,
 	};
-	int i, temp, err;
+	int i, temp;
 
 	/* Test with known set of values copied from data. */
 	for (i = 0; i < ARRAY_SIZE(data); i++)
 		min_heap_push(&heap, &data[i], &funcs);
-
-	err = pop_verify_heap(min_heap, &heap, &funcs);
+	pop_verify_heap(context, min_heap, &heap, &funcs);
 
 	/* Test with randomly generated values. */
 	while (heap.nr < heap.size) {
 		temp = get_random_int();
 		min_heap_push(&heap, &temp, &funcs);
 	}
-	err += pop_verify_heap(min_heap, &heap, &funcs);
-
-	return err;
+	pop_verify_heap(context, min_heap, &heap, &funcs);
 }
 
-static __init int test_heap_pop_push(bool min_heap)
+static __init void test_heap_pop_push(struct kunit *context, bool min_heap)
 {
 	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
 			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
@@ -139,7 +129,7 @@ static __init int test_heap_pop_push(bool min_heap)
 		.less = min_heap ? less_than : greater_than,
 		.swp = swap_ints,
 	};
-	int i, temp, err;
+	int i, temp;
 
 	/* Fill values with data to pop and replace. */
 	temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
@@ -149,8 +139,7 @@ static __init int test_heap_pop_push(bool min_heap)
 	/* Test with known set of values copied from data. */
 	for (i = 0; i < ARRAY_SIZE(data); i++)
 		min_heap_pop_push(&heap, &data[i], &funcs);
-
-	err = pop_verify_heap(min_heap, &heap, &funcs);
+	pop_verify_heap(context, min_heap, &heap, &funcs);
 
 	heap.nr = 0;
 	for (i = 0; i < ARRAY_SIZE(data); i++)
@@ -161,34 +150,54 @@ static __init int test_heap_pop_push(bool min_heap)
 		temp = get_random_int();
 		min_heap_pop_push(&heap, &temp, &funcs);
 	}
-	err += pop_verify_heap(min_heap, &heap, &funcs);
+	pop_verify_heap(context, min_heap, &heap, &funcs);
+}
 
-	return err;
+static void __init test_heapify_all_true(struct kunit *context)
+{
+	test_heapify_all(context, true);
 }
 
-static int __init test_min_heap_init(void)
+static void __init test_heapify_all_false(struct kunit *context)
 {
-	int err = 0;
-
-	err += test_heapify_all(true);
-	err += test_heapify_all(false);
-	err += test_heap_push(true);
-	err += test_heap_push(false);
-	err += test_heap_pop_push(true);
-	err += test_heap_pop_push(false);
-	if (err) {
-		pr_err("test failed with %d errors\n", err);
-		return -EINVAL;
-	}
-	pr_info("test passed\n");
-	return 0;
+	test_heapify_all(context, true);
+}
+
+static void __init test_heap_push_true(struct kunit *context)
+{
+	test_heap_push(context, true);
+}
+
+static void __init test_heap_push_false(struct kunit *context)
+{
+	test_heap_push(context, false);
 }
-module_init(test_min_heap_init);
 
-static void __exit test_min_heap_exit(void)
+static void __init test_heap_pop_push_true(struct kunit *context)
 {
-	/* do nothing */
+	test_heap_pop_push(context, true);
 }
-module_exit(test_min_heap_exit);
+
+static void __init test_heap_pop_push_false(struct kunit *context)
+{
+	test_heap_pop_push(context, false);
+}
+
+static struct kunit_case __refdata min_heap_test_cases[] = {
+	KUNIT_CASE(test_heapify_all_true),
+	KUNIT_CASE(test_heapify_all_false),
+	KUNIT_CASE(test_heap_push_true),
+	KUNIT_CASE(test_heap_push_false),
+	KUNIT_CASE(test_heap_pop_push_true),
+	KUNIT_CASE(test_heap_pop_push_false),
+	{}
+};
+
+static struct kunit_suite min_heap_test_suite = {
+	.name = "min-heap",
+	.test_cases = min_heap_test_cases,
+};
+
+kunit_test_suites(&min_heap_test_suite);
 
 MODULE_LICENSE("GPL");

base-commit: d2585f5164c298aaaed14c2c8d313cbe7bd5b253
-- 
2.26.2

