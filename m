Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C47367299
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Apr 2021 20:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbhDUSdK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Apr 2021 14:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbhDUSdH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Apr 2021 14:33:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA9AC06138A
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Apr 2021 11:32:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s2-20020a5b07420000b02904eb842efc40so16774612ybq.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Apr 2021 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=otRIiTyXS+j6VPjFyTZH8OUE4RgYzuP4apVN1dvGh40=;
        b=pjLoWma3KUHNNHRrFaMOfqDcOq8MNdrYg3yXP/FWN015dWQ3s/IymAPiuTTdSb1hlR
         KdGiW6zGbNTLPTjnAon1Rj8OZtBMvh+L8BBmrDOiU/Ia/s50r/8GB+I8YEmDr/b0Vgl7
         yI2BwX4Az8Z6wPmfBpHb0/UULItQU1twLsKP3r3WNewfh9C6SAvx8jfdpObGwElHvSX7
         HGXca1DWDpY2sEuAQ6ZmMjjaSTM3lhiOklNEcOVkL4cB3zHUjKfVgEOzQNdHhntlkTC/
         I5HUjkX2Dm7YK1iJnwWiOdtapxPZCpVbkRTWq2TjvM83Un065b4tQimEce838u48nIXv
         DYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=otRIiTyXS+j6VPjFyTZH8OUE4RgYzuP4apVN1dvGh40=;
        b=rdzwdHq0qrVe6FKlZQnyRK9xyyU1L8qKxPhVVujTBkNa3B9r5Qsd0NV1CgeuRiXnJs
         U6Gc+tlsNv7+IeYl4QU5JN9CXqQ90ikj4zJhgvvVB+ku7Mtep4UqxdV6UH4yj3rNKZ9x
         KTb3zOqGnd9Cvp55nnbDKEIX6tzQbsDU+tzEJZ47uTBTOtnsG8PdiRN9nA30U8Joiuc8
         FbsEbtz7GT56gUt9z6J6L6xLQCC6qH5GvcWcKmkLMyr99tPD8wrCCXNignk8BhbAQLpm
         SPpURNNmvU/ClAjG2tJHfN4ZQCfSgbFR4QgP4PO+oo6zzpsgewkeP4XVMVenzishVsdO
         +VIA==
X-Gm-Message-State: AOAM53388Etpzn8qW1R8JF79f1m2mmdwih59tS38wpm8ZWRkaz8Kxk/P
        60PdoJ2M9iZ0Rv8IgXWNZsy3yYUqex9aJg==
X-Google-Smtp-Source: ABdhPJxbCeyuDsPF5Qo0G1xygifPPP8HfLoI0mSGQuk1QRbNDb6wXdw/VPWYY+Tikm+yrk/5zf3BVUuOaifJ5Q==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:9524:9c1f:6fff:a9ad])
 (user=dlatypov job=sendgmr) by 2002:a5b:802:: with SMTP id
 x2mr33668814ybp.28.1619029951995; Wed, 21 Apr 2021 11:32:31 -0700 (PDT)
Date:   Wed, 21 Apr 2021 11:32:22 -0700
Message-Id: <20210421183222.2557747-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 2/2] lib/test: convert lib/test_list_sort.c to use KUnit
From:   Daniel Latypov <dlatypov@google.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Functionally, this just means that the test output will be slightly
changed and it'll now depend on CONFIG_KUNIT=y/m.

It'll still run at boot time and can still be built as a loadable
module.

There was a pre-existing patch to convert this test that I found later,
here [1]. Compared to [1], this patch doesn't rename files and uses
KUnit features more heavily (i.e. does more than converting pr_err()
calls to KUNIT_FAIL()).

What this conversion gives us:
* a shorter test thanks to KUnit's macros
* a way to run this a bit more easily via kunit.py (and
CONFIG_KUNIT_ALL_TESTS=y) [2]
* a structured way of reporting pass/fail
* uses kunit-managed allocations to avoid the risk of memory leaks
* more descriptive error messages:
  * i.e. it prints out which fields are invalid, what the expected
  values are, etc.

What this conversion does not do:
* change the name of the file (and thus the name of the module)
* change the name of the config option

Leaving these as-is for now to minimize the impact to people wanting to
run this test. IMO, that concern trumps following KUnit's style guide
for both names, at least for now.

[1] https://lore.kernel.org/linux-kselftest/20201015014616.309000-1-vitor@massaru.org/
[2] Can be run via
$ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
CONFIG_KUNIT=y
CONFIG_TEST_LIST_SORT=y
EOF

[16:55:56] Configuring KUnit Kernel ...
[16:55:56] Building KUnit Kernel ...
[16:56:29] Starting KUnit Kernel ...
[16:56:32] ============================================================
[16:56:32] ======== [PASSED] list_sort ========
[16:56:32] [PASSED] list_sort_test
[16:56:32] ============================================================
[16:56:32] Testing complete. 1 tests run. 0 failed. 0 crashed.
[16:56:32] Elapsed time: 35.668s total, 0.001s configuring, 32.725s building, 0.000s running

Note: the build time is as after a `make mrproper`.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/Kconfig.debug    |   5 +-
 lib/test_list_sort.c | 128 +++++++++++++++++--------------------------
 2 files changed, 54 insertions(+), 79 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 417c3d3e521b..09a0cc8a55cc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1999,8 +1999,9 @@ config LKDTM
 	Documentation/fault-injection/provoke-crashes.rst
 
 config TEST_LIST_SORT
-	tristate "Linked list sorting test"
-	depends on DEBUG_KERNEL || m
+	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable this to turn on 'list_sort()' function test. This test is
 	  executed only once during system boot (so affects only boot time),
diff --git a/lib/test_list_sort.c b/lib/test_list_sort.c
index 1f017d3b610e..ccfd98dbf57c 100644
--- a/lib/test_list_sort.c
+++ b/lib/test_list_sort.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "list_sort_test: " fmt
+#include <kunit/test.h>
 
 #include <linux/kernel.h>
 #include <linux/list_sort.h>
@@ -23,67 +23,52 @@ struct debug_el {
 	struct list_head list;
 	unsigned int poison2;
 	int value;
-	unsigned serial;
+	unsigned int serial;
 };
 
-/* Array, containing pointers to all elements in the test list */
-static struct debug_el **elts __initdata;
-
-static int __init check(struct debug_el *ela, struct debug_el *elb)
+static void check(struct kunit *test, struct debug_el *ela, struct debug_el *elb)
 {
-	if (ela->serial >= TEST_LIST_LEN) {
-		pr_err("error: incorrect serial %d\n", ela->serial);
-		return -EINVAL;
-	}
-	if (elb->serial >= TEST_LIST_LEN) {
-		pr_err("error: incorrect serial %d\n", elb->serial);
-		return -EINVAL;
-	}
-	if (elts[ela->serial] != ela || elts[elb->serial] != elb) {
-		pr_err("error: phantom element\n");
-		return -EINVAL;
-	}
-	if (ela->poison1 != TEST_POISON1 || ela->poison2 != TEST_POISON2) {
-		pr_err("error: bad poison: %#x/%#x\n",
-			ela->poison1, ela->poison2);
-		return -EINVAL;
-	}
-	if (elb->poison1 != TEST_POISON1 || elb->poison2 != TEST_POISON2) {
-		pr_err("error: bad poison: %#x/%#x\n",
-			elb->poison1, elb->poison2);
-		return -EINVAL;
-	}
-	return 0;
+	struct debug_el **elts = test->priv;
+
+	KUNIT_EXPECT_LT_MSG(test, ela->serial, (unsigned int)TEST_LIST_LEN, "incorrect serial");
+	KUNIT_EXPECT_LT_MSG(test, elb->serial, (unsigned int)TEST_LIST_LEN, "incorrect serial");
+
+	KUNIT_EXPECT_PTR_EQ_MSG(test, elts[ela->serial], ela, "phantom element");
+	KUNIT_EXPECT_PTR_EQ_MSG(test, elts[elb->serial], elb, "phantom element");
+
+	KUNIT_EXPECT_EQ_MSG(test, ela->poison1, TEST_POISON1, "bad poison");
+	KUNIT_EXPECT_EQ_MSG(test, ela->poison2, TEST_POISON2, "bad poison");
+
+	KUNIT_EXPECT_EQ_MSG(test, elb->poison1, TEST_POISON1, "bad poison");
+	KUNIT_EXPECT_EQ_MSG(test, elb->poison2, TEST_POISON2, "bad poison");
 }
 
-static int __init cmp(void *priv, struct list_head *a, struct list_head *b)
+/* `priv` is the test pointer so check() can fail the test if the list is invalid. */
+static int cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct debug_el *ela, *elb;
 
 	ela = container_of(a, struct debug_el, list);
 	elb = container_of(b, struct debug_el, list);
 
-	check(ela, elb);
+	check(priv, ela, elb);
 	return ela->value - elb->value;
 }
 
-static int __init list_sort_test(void)
+static void list_sort_test(struct kunit *test)
 {
-	int i, count = 1, err = -ENOMEM;
-	struct debug_el *el;
+	int i, count = 1;
+	struct debug_el *el, **elts;
 	struct list_head *cur;
 	LIST_HEAD(head);
 
-	pr_debug("start testing list_sort()\n");
-
-	elts = kcalloc(TEST_LIST_LEN, sizeof(*elts), GFP_KERNEL);
-	if (!elts)
-		return err;
+	elts = kunit_kcalloc(test, TEST_LIST_LEN, sizeof(*elts), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elts);
+	test->priv = elts;
 
 	for (i = 0; i < TEST_LIST_LEN; i++) {
-		el = kmalloc(sizeof(*el), GFP_KERNEL);
-		if (!el)
-			goto exit;
+		el = kunit_kmalloc(test, sizeof(*el), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, el);
 
 		 /* force some equivalencies */
 		el->value = prandom_u32() % (TEST_LIST_LEN / 3);
@@ -94,55 +79,44 @@ static int __init list_sort_test(void)
 		list_add_tail(&el->list, &head);
 	}
 
-	list_sort(NULL, &head, cmp);
+	list_sort(test, &head, cmp);
 
-	err = -EINVAL;
 	for (cur = head.next; cur->next != &head; cur = cur->next) {
 		struct debug_el *el1;
 		int cmp_result;
 
-		if (cur->next->prev != cur) {
-			pr_err("error: list is corrupted\n");
-			goto exit;
-		}
+		KUNIT_ASSERT_PTR_EQ_MSG(test, cur->next->prev, cur,
+					"list is corrupted");
 
-		cmp_result = cmp(NULL, cur, cur->next);
-		if (cmp_result > 0) {
-			pr_err("error: list is not sorted\n");
-			goto exit;
-		}
+		cmp_result = cmp(test, cur, cur->next);
+		KUNIT_ASSERT_LE_MSG(test, cmp_result, 0, "list is not sorted");
 
 		el = container_of(cur, struct debug_el, list);
 		el1 = container_of(cur->next, struct debug_el, list);
-		if (cmp_result == 0 && el->serial >= el1->serial) {
-			pr_err("error: order of equivalent elements not "
-				"preserved\n");
-			goto exit;
+		if (cmp_result == 0) {
+			KUNIT_ASSERT_LE_MSG(test, el->serial, el1->serial,
+					    "order of equivalent elements not preserved");
 		}
 
-		if (check(el, el1)) {
-			pr_err("error: element check failed\n");
-			goto exit;
-		}
+		check(test, el, el1);
 		count++;
 	}
-	if (head.prev != cur) {
-		pr_err("error: list is corrupted\n");
-		goto exit;
-	}
+	KUNIT_EXPECT_PTR_EQ_MSG(test, head.prev, cur, "list is corrupted");
 
+	KUNIT_EXPECT_EQ_MSG(test, count, TEST_LIST_LEN,
+			    "list length changed after sorting!");
+}
 
-	if (count != TEST_LIST_LEN) {
-		pr_err("error: bad list length %d", count);
-		goto exit;
-	}
+static struct kunit_case list_sort_cases[] = {
+	KUNIT_CASE(list_sort_test),
+	{}
+};
+
+static struct kunit_suite list_sort_suite = {
+	.name = "list_sort",
+	.test_cases = list_sort_cases,
+};
+
+kunit_test_suites(&list_sort_suite);
 
-	err = 0;
-exit:
-	for (i = 0; i < TEST_LIST_LEN; i++)
-		kfree(elts[i]);
-	kfree(elts);
-	return err;
-}
-module_init(list_sort_test);
 MODULE_LICENSE("GPL");
-- 
2.31.1.498.g6c1eba8ee3d-goog

