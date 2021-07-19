Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D1F3CF04B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jul 2021 01:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhGSXMe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jul 2021 19:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388248AbhGSUrk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jul 2021 16:47:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CCCC061762
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jul 2021 14:23:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o11-20020a056902110bb029055b266be219so27238541ybu.13
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Jul 2021 14:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JqBecYsg8zAakph71sf/lypdtgnGpmLoT+MvOHlqW8M=;
        b=PXGfLRe5xUHWj5P1l/3VqKayiC7Tah44TES9JEFW+1Ij2576ufCGnk1YcX5Q0BQhVF
         0+/3g6oiPzfKcIEy0L59sNsNWbuhKWFj04C/VEGdwS1FM8Ic3GpuXBcwFznzAfWpSA7u
         1GhuBf8gVxe/JsZC6NzNaIbbXkDrkZgOl/Rj4MjOTQ9aa9ftQAwn9EW7TtnrfND05VxT
         hD0zYKtoJrDyr+wSAnEtKZYrYdmPdlCXkszwtjzFWCScOlsyPXGduFCmkjzX8osiog/y
         FqDSFHt8TijraBbGnqUBTP1waOPOeXrCk0SFfm/BN1+MuixtzyYr7yESP7K0je5EzT04
         b5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JqBecYsg8zAakph71sf/lypdtgnGpmLoT+MvOHlqW8M=;
        b=AUSbBtzbdx6uyhdy7viMyc8qoqPoFbk24q3RkjQj8m1sPKS9BJGaygUK1zqVeG/9vF
         BirD2f9cZM2YmG17S8V7a0W3fxWKsrhnaw/vIuG+8DSP7hS5gWeZBuHTC8t/PM3GyC+T
         bCAAi8XG38HX2PAJe8H9tNBawqVufTLQaKAlkK5UspDAakkpNwMDEAjBp1wkt/V8QvQt
         cOrBpdm3LONdtaPtw6YQqSHO0gn4qajXZuZI4TGP/S4VMRrQZ/uB+GAEnGW08LFEhJFD
         b5iRY1c0X/vypl89K31jmUFMyEgpFvgr9dvJUxXCoNFlfh3zXP8+aAPN7mwoKhp1T5wZ
         ilrA==
X-Gm-Message-State: AOAM531oLjdViK+77Dy+kK3vz6NfvYt0Ixx5jNGXdzNqE3gRqmRjYGxk
        vjWrXMrlhpOGGl8Qh9ZfSQ7+8x3NLmq+3Q==
X-Google-Smtp-Source: ABdhPJw4nAJeMTvnEaHi0aMGSkDMW888SJayo1LqkeRt75qVrfI6+Lr6chhVTyowcEe67nneME2fTYfT99tPXg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d686:24ec:b16b:9a7f])
 (user=dlatypov job=sendgmr) by 2002:a5b:486:: with SMTP id
 n6mr34800197ybp.95.1626729794723; Mon, 19 Jul 2021 14:23:14 -0700 (PDT)
Date:   Mon, 19 Jul 2021 14:23:02 -0700
Message-Id: <20210719212302.167186-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH] lib/test: convert test_min_heap.c to use KUnit
From:   Daniel Latypov <dlatypov@google.com>
To:     irogers@google.com
Cc:     peterz@infradead.org, brendanhiggins@google.com,
        davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We leave the file names and Kconfig option unchanged for now to minimize
disruption.

So functionally, this just means that the test output will be slightly
changed and it'll now depend on CONFIG_KUNIT=y/m.

It'll still run at boot time and can still be built as a loadable
module, but it can now be run a bit more easily via:
$ ./tools/testing/kunit/kunit.py run

By default, the above command will run with CONFIG_KUNIT_ALL_TESTS=y.
Users could run this test individually via something like:

$ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
CONFIG_KUNIT=y
CONFIG_TEST_MIN_HEAP=y
EOF

Example output:
[14:57:54] ============================================================
[14:57:54] ======== [PASSED] lib_minmax_heap ========
[14:57:54] [PASSED] test_min_heap
[14:57:54] [PASSED] test_max_heap
[14:57:54] ============================================================
[14:57:54] Testing complete. 2 tests run. 0 failed. 0 crashed. 0 skipped.
[14:57:54] Elapsed time: 39.696s total, 0.001s configuring, 36.705s building, 0.000s running

Note: this is the time it took after a `make mrproper`.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/Kconfig.debug   |   5 ++-
 lib/test_min_heap.c | 102 ++++++++++++++++++++------------------------
 2 files changed, 49 insertions(+), 58 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 831212722924..36e9529ede65 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2068,8 +2068,9 @@ config TEST_LIST_SORT
 	  If unsure, say N.
 
 config TEST_MIN_HEAP
-	tristate "Min heap test"
-	depends on DEBUG_KERNEL || m
+	tristate "Min heap test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable this to turn on min heap function tests. This test is
 	  executed only once during system boot (so affects only boot time),
diff --git a/lib/test_min_heap.c b/lib/test_min_heap.c
index d19c8080fd4d..c0f1ef78c08e 100644
--- a/lib/test_min_heap.c
+++ b/lib/test_min_heap.c
@@ -1,27 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "min_heap_test: " fmt
-
 /*
  * Test cases for the min max heap.
  */
 
+#include <kunit/test.h>
+
 #include <linux/log2.h>
 #include <linux/min_heap.h>
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/random.h>
 
-static __init bool less_than(const void *lhs, const void *rhs)
+static bool less_than(const void *lhs, const void *rhs)
 {
 	return *(int *)lhs < *(int *)rhs;
 }
 
-static __init bool greater_than(const void *lhs, const void *rhs)
+static bool greater_than(const void *lhs, const void *rhs)
 {
 	return *(int *)lhs > *(int *)rhs;
 }
 
-static __init void swap_ints(void *lhs, void *rhs)
+static void swap_ints(void *lhs, void *rhs)
 {
 	int temp = *(int *)lhs;
 
@@ -29,37 +29,27 @@ static __init void swap_ints(void *lhs, void *rhs)
 	*(int *)rhs = temp;
 }
 
-static __init int pop_verify_heap(bool min_heap,
-				struct min_heap *heap,
-				const struct min_heap_callbacks *funcs)
+static void pop_verify_heap(struct kunit *test, bool min_heap,
+			    struct min_heap *heap,
+			    const struct min_heap_callbacks *funcs)
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
+			KUNIT_EXPECT_LE(test, last, values[0]);
 		} else {
-			if (last < values[0]) {
-				pr_err("error: expected %d >= %d\n", last,
-					values[0]);
-				err++;
-			}
+			KUNIT_EXPECT_GE(test, last, values[0]);
 		}
 		last = values[0];
 		min_heap_pop(heap, funcs);
 	}
-	return err;
 }
 
-static __init int test_heapify_all(bool min_heap)
+static void test_heapify_all(struct kunit *test, bool min_heap)
 {
 	int values[] = { 3, 1, 2, 4, 0x8000000, 0x7FFFFFF, 0,
 			 -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
@@ -73,11 +63,11 @@ static __init int test_heapify_all(bool min_heap)
 		.less = min_heap ? less_than : greater_than,
 		.swp = swap_ints,
 	};
-	int i, err;
+	int i;
 
 	/* Test with known set of values. */
 	min_heapify_all(&heap, &funcs);
-	err = pop_verify_heap(min_heap, &heap, &funcs);
+	pop_verify_heap(test, min_heap, &heap, &funcs);
 
 
 	/* Test with randomly generated values. */
@@ -86,12 +76,10 @@ static __init int test_heapify_all(bool min_heap)
 		values[i] = get_random_int();
 
 	min_heapify_all(&heap, &funcs);
-	err += pop_verify_heap(min_heap, &heap, &funcs);
-
-	return err;
+	pop_verify_heap(test, min_heap, &heap, &funcs);
 }
 
-static __init int test_heap_push(bool min_heap)
+static void test_heap_push(struct kunit *test, bool min_heap)
 {
 	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
 			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
@@ -106,25 +94,23 @@ static __init int test_heap_push(bool min_heap)
 		.less = min_heap ? less_than : greater_than,
 		.swp = swap_ints,
 	};
-	int i, temp, err;
+	int i, temp;
 
 	/* Test with known set of values copied from data. */
 	for (i = 0; i < ARRAY_SIZE(data); i++)
 		min_heap_push(&heap, &data[i], &funcs);
 
-	err = pop_verify_heap(min_heap, &heap, &funcs);
+	pop_verify_heap(test, min_heap, &heap, &funcs);
 
 	/* Test with randomly generated values. */
 	while (heap.nr < heap.size) {
 		temp = get_random_int();
 		min_heap_push(&heap, &temp, &funcs);
 	}
-	err += pop_verify_heap(min_heap, &heap, &funcs);
-
-	return err;
+	pop_verify_heap(test, min_heap, &heap, &funcs);
 }
 
-static __init int test_heap_pop_push(bool min_heap)
+static void test_heap_pop_push(struct kunit *test, bool min_heap)
 {
 	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
 			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
@@ -139,7 +125,7 @@ static __init int test_heap_pop_push(bool min_heap)
 		.less = min_heap ? less_than : greater_than,
 		.swp = swap_ints,
 	};
-	int i, temp, err;
+	int i, temp;
 
 	/* Fill values with data to pop and replace. */
 	temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
@@ -150,7 +136,7 @@ static __init int test_heap_pop_push(bool min_heap)
 	for (i = 0; i < ARRAY_SIZE(data); i++)
 		min_heap_pop_push(&heap, &data[i], &funcs);
 
-	err = pop_verify_heap(min_heap, &heap, &funcs);
+	pop_verify_heap(test, min_heap, &heap, &funcs);
 
 	heap.nr = 0;
 	for (i = 0; i < ARRAY_SIZE(data); i++)
@@ -161,34 +147,38 @@ static __init int test_heap_pop_push(bool min_heap)
 		temp = get_random_int();
 		min_heap_pop_push(&heap, &temp, &funcs);
 	}
-	err += pop_verify_heap(min_heap, &heap, &funcs);
+	pop_verify_heap(test, min_heap, &heap, &funcs);
+}
 
-	return err;
+static void test_heap(struct kunit *test, bool min_heap)
+{
+	test_heapify_all(test, min_heap);
+	test_heap_push(test, min_heap);
+	test_heap_pop_push(test, min_heap);
 }
 
-static int __init test_min_heap_init(void)
+static void test_min_heap(struct kunit *test)
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
+	test_heap(test, true);
 }
-module_init(test_min_heap_init);
 
-static void __exit test_min_heap_exit(void)
+static void test_max_heap(struct kunit *test)
 {
-	/* do nothing */
+	test_heap(test, false);
 }
-module_exit(test_min_heap_exit);
+
+static struct kunit_case __refdata minmax_heap_test_cases[] = {
+	KUNIT_CASE(test_min_heap),
+	KUNIT_CASE(test_max_heap),
+	{}
+};
+
+static struct kunit_suite minmax_heap_test_suite = {
+	.name = "lib_minmax_heap",
+	.test_cases = minmax_heap_test_cases,
+};
+
+kunit_test_suites(&minmax_heap_test_suite);
+
 
 MODULE_LICENSE("GPL");

base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
-- 
2.32.0.402.g57bb445576-goog

