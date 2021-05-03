Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B75372224
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhECU7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhECU7q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 16:59:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44960C061763
        for <linux-kselftest@vger.kernel.org>; Mon,  3 May 2021 13:58:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x186-20020a25e0c30000b02904f0d007a955so9253685ybg.12
        for <linux-kselftest@vger.kernel.org>; Mon, 03 May 2021 13:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mDcI1Y9GPb+eAb8K0nyQVGSFvYCSg/wqmfsNlDLdw/8=;
        b=lAVsGTbl6Ah35De/85oqM9GtJUC465dkllh3Kets0tLhy/u0wawPdytdJLKZWsfc/p
         0i0r1CmUIvr1ay6XWq5Dy+S8zhIsqMgyWnPev+MLnWAlN3crcLr9x0cx4Y9FKfxPTq/j
         fjGOESPMRsKaQB+gM9oU/NHQUVJpiGhacPG0M17z/K+A7U5fLOd1ENcYD4U6q3wqmr1m
         Rx1dZNFU94UZRRpx3l0zvW8vdNP3LA8ijwDCtlfHQ3oYGIFGp8G6dkenWCUH9j6ksGvH
         eVV3k1ea/tPJ/kFBF3tGjVyVUuhRcLKIZr0JvZQHpfvMmpW3TPZtOohBKkguvJqukepa
         Y0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDcI1Y9GPb+eAb8K0nyQVGSFvYCSg/wqmfsNlDLdw/8=;
        b=Yh80R9HqqefTO48tOiApAEh9PdQlA3G3zQ9e1dB+bM09f8tOPN675x3XRII6/VK1oL
         uBpoW6khh/U+gpbWiATFdcwnbuu2Ibek/WPnrQax6PD34Mje5Kq2oTe9yyzwCM66KPeh
         BiM7oPJRInLDFQeBK/HK2dzF7RtZaH9++FshnNBHZ1/eftuxp1OgzJUzz54pIA042OLJ
         JPJrRITp41ou9GCrfbsN1whaNSp79772il01ctQkdysO0M4nGCEkhzfQ8JhHvd4cwBWF
         tK4l6QgG7oWka9156qTpivenv9cOtET3gYVFjGEU7E5wNgjj7Y6WdKCxzjhh4WE9rpDC
         ycmQ==
X-Gm-Message-State: AOAM5301KtoOLQ89IM+OE3UuKQ4DhNHUaZp64OFAkjPLmpY/bg0SwKct
        xgsPvbbBZ4tO3n2vnT7m5sOPh1Y+diAWMw==
X-Google-Smtp-Source: ABdhPJxnzYVwgDkJ5P6ghqr2Wj9zOL89zQWnn1/CSl17cCn507l4Zv6cY906ncDSvAzW9c2nJvJEzgwfVoK7eA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1dbc:8749:a56:dada])
 (user=dlatypov job=sendgmr) by 2002:a25:e041:: with SMTP id
 x62mr26769701ybg.424.1620075531393; Mon, 03 May 2021 13:58:51 -0700 (PDT)
Date:   Mon,  3 May 2021 13:58:35 -0700
In-Reply-To: <20210503205835.1370850-1-dlatypov@google.com>
Message-Id: <20210503205835.1370850-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210503205835.1370850-1-dlatypov@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 2/2] lib/test: convert lib/test_list_sort.c to use KUnit
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     npache@redhat.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
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
Tested-by: David Gow <davidgow@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: no change. Might make a v3 if we want to rename the
file/config options to make it match.
---
 lib/Kconfig.debug    |   5 +-
 lib/test_list_sort.c | 129 +++++++++++++++++--------------------------
 2 files changed, 54 insertions(+), 80 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580..5553508080db 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2047,8 +2047,9 @@ config LKDTM
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
index 00daaf23316f..ade7a1ea0c8e 100644
--- a/lib/test_list_sort.c
+++ b/lib/test_list_sort.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "list_sort_test: " fmt
+#include <kunit/test.h>
 
 #include <linux/kernel.h>
 #include <linux/list_sort.h>
@@ -23,68 +23,52 @@ struct debug_el {
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
 
-static int __init cmp(void *priv, const struct list_head *a,
-		      const struct list_head *b)
+/* `priv` is the test pointer so check() can fail the test if the list is invalid. */
+static int cmp(void *priv, const struct list_head *a, const struct list_head *b)
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
@@ -95,55 +79,44 @@ static int __init list_sort_test(void)
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
2.31.1.527.g47e6f16901-goog

