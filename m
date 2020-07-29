Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB5232559
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 21:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG2TYF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 15:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgG2TYF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 15:24:05 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D17DC0619D2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 12:24:05 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id u8so11377891qvj.12
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SwSqvKuJ15CN8Pd3kcCDQFe6pLkTGduRccmzzWLc2A=;
        b=K5/RCOcYEuoJdGd7OJb5yJ6/Lp1P2Uv31Dh5+mmKmpyziGwZOYtuMRQOdrHVE93Djf
         0SN+1P9tWnm5tt3RpLoqe1LEhKFV/FK6lf48aTBP+Qj/DnH4wyKgSrXw3/kGraV9r2ug
         bIuACKQl26Zz4H+VLxQWxIm6tUx0WOwWWL2+nNk/LdYR919pRWNcKLalP1uA/zKs5TXC
         nYXCocZChjph335257hhoYeUaTQUgSHfdL8sVJK0afwCR3xH5Ll/a3bFP3C9bvmo/j83
         egVDuqHfmgFGft4wnOjiNffQRQ24FOukfjKgtrWNkLsZ3mXogWm6eWwQ/xzT1GLrowf7
         P8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SwSqvKuJ15CN8Pd3kcCDQFe6pLkTGduRccmzzWLc2A=;
        b=Bx/lG+DZ5jzQs2SYFZ1VmpwLf4ZKqeYo7FIrLNGSYo5QFtjqD8X1sHxkyKckACJ8S3
         zuhTbS86cHbqCmYTDzmsVwL4AXBe2FPYz99fMvFE01o5BAHxvx5Dk4FjFj4AOgi6KsoN
         otxP6SOBXyS9iqOyiF3Jpyar16m2L1/9FZ75inEFrJKdgCbOxYUWMj09Ltv9o1QwnnSJ
         BqScfClvDh7HvZg0Vw+ZvFeVcQP2gA+ZSFrByOGEFrKYqJ1794IcSyuK8k8Q7qrHqAxc
         1VpnS3TbjhzOOr6IP5+FTa2UGAeHK0RZYmOLsXJpZg7GhLzyxnM23K2YPZIVxK2HEjT4
         WnXQ==
X-Gm-Message-State: AOAM532Zuh7MuS9c4lo+iXeyKOe+gesaDV4oYiAvvwg3Hyl6vav9f+PF
        tnCj1cCyhD99ymcPN3QpmmBj6A==
X-Google-Smtp-Source: ABdhPJwq+Incj3x19IXHTzGNy6+lm+i0AnLJAof2on0zHxL0dqNnvJ6kPWljWDo17jP6Xv8zVsgPKQ==
X-Received: by 2002:a0c:d60f:: with SMTP id c15mr27882794qvj.17.1596050643994;
        Wed, 29 Jul 2020 12:24:03 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id s30sm2505016qtc.87.2020.07.29.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:24:03 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, arnd@arndb.de,
        elfring@users.sourceforge.net, mhocko@suse.com
Subject: [PATCH] lib: kunit: add list_sort test conversion to KUnit
Date:   Wed, 29 Jul 2020 16:23:57 -0300
Message-Id: <20200729192357.477350-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the conversion of the runtime tests of test_list_sort,
from `lib/test_list_sort.c` to KUnit tests.

Please apply this commit first (linux-kselftest/kunit-fixes):
3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space

Code Style Documentation: [0]

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
---
 lib/Kconfig.debug                           | 29 +++++---
 lib/Makefile                                |  2 +-
 lib/{test_list_sort.c => list_sort_kunit.c} | 73 +++++++++++----------
 3 files changed, 58 insertions(+), 46 deletions(-)
 rename lib/{test_list_sort.c => list_sort_kunit.c} (62%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..de4fd020a4af 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1854,16 +1854,6 @@ config LKDTM
 	Documentation on how to use the module can be found in
 	Documentation/fault-injection/provoke-crashes.rst
 
-config TEST_LIST_SORT
-	tristate "Linked list sorting test"
-	depends on DEBUG_KERNEL || m
-	help
-	  Enable this to turn on 'list_sort()' function test. This test is
-	  executed only once during system boot (so affects only boot time),
-	  or at module load time.
-
-	  If unsure, say N.
-
 config TEST_MIN_HEAP
 	tristate "Min heap test"
 	depends on DEBUG_KERNEL || m
@@ -2173,6 +2163,25 @@ config LIST_KUNIT_TEST
 
 	  If unsure, say N.
 
+config LIST_SORT_KUNIT
+	tristate "KUnit Linked list sorting test"
+	depends on KUNIT
+	depends on DEBUG_KERNEL || m
+	help
+	  Enable this to turn on 'list_sort()' function test. This test is
+	  executed only once during system boot (so affects only boot time),
+	  or at module load time.
+
+          KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config LINEAR_RANGES_TEST
 	tristate "KUnit test for linear_ranges"
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..798724b7cde0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -71,7 +71,6 @@ obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
-obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
@@ -317,4 +316,5 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
+obj-$(CONFIG_LIST_SORT_KUNIT) += list_sort_kunit.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
diff --git a/lib/test_list_sort.c b/lib/list_sort_kunit.c
similarity index 62%
rename from lib/test_list_sort.c
rename to lib/list_sort_kunit.c
index 1f017d3b610e..20cbacbb7d6c 100644
--- a/lib/test_list_sort.c
+++ b/lib/list_sort_kunit.c
@@ -1,13 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "list_sort_test: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/kernel.h>
 #include <linux/list_sort.h>
 #include <linux/list.h>
-#include <linux/module.h>
-#include <linux/printk.h>
-#include <linux/slab.h>
 #include <linux/random.h>
+#include <kunit/test.h>
 
 /*
  * The pattern of set bits in the list length determines which cases
@@ -29,28 +26,28 @@ struct debug_el {
 /* Array, containing pointers to all elements in the test list */
 static struct debug_el **elts __initdata;
 
-static int __init check(struct debug_el *ela, struct debug_el *elb)
+static int __init check(struct kunit *context, struct debug_el *ela, struct debug_el *elb)
 {
 	if (ela->serial >= TEST_LIST_LEN) {
-		pr_err("error: incorrect serial %d\n", ela->serial);
+		KUNIT_FAIL(context, "incorrect serial %d", ela->serial);
 		return -EINVAL;
 	}
 	if (elb->serial >= TEST_LIST_LEN) {
-		pr_err("error: incorrect serial %d\n", elb->serial);
+		KUNIT_FAIL(context, "incorrect serial %d", elb->serial);
 		return -EINVAL;
 	}
 	if (elts[ela->serial] != ela || elts[elb->serial] != elb) {
-		pr_err("error: phantom element\n");
+		KUNIT_FAIL(context, "phantom element");
 		return -EINVAL;
 	}
 	if (ela->poison1 != TEST_POISON1 || ela->poison2 != TEST_POISON2) {
-		pr_err("error: bad poison: %#x/%#x\n",
-			ela->poison1, ela->poison2);
+		KUNIT_FAIL(context, "bad poison: %#x/%#x",
+			   ela->poison1, ela->poison2);
 		return -EINVAL;
 	}
 	if (elb->poison1 != TEST_POISON1 || elb->poison2 != TEST_POISON2) {
-		pr_err("error: bad poison: %#x/%#x\n",
-			elb->poison1, elb->poison2);
+		KUNIT_FAIL(context, "bad poison: %#x/%#x",
+			   elb->poison1, elb->poison2);
 		return -EINVAL;
 	}
 	return 0;
@@ -63,27 +60,26 @@ static int __init cmp(void *priv, struct list_head *a, struct list_head *b)
 	ela = container_of(a, struct debug_el, list);
 	elb = container_of(b, struct debug_el, list);
 
-	check(ela, elb);
+	check(priv, ela, elb);
 	return ela->value - elb->value;
 }
 
-static int __init list_sort_test(void)
+static void __init test_list_sort(struct kunit *context)
 {
-	int i, count = 1, err = -ENOMEM;
+	int i, count = 1;
 	struct debug_el *el;
 	struct list_head *cur;
 	LIST_HEAD(head);
 
-	pr_debug("start testing list_sort()\n");
-
 	elts = kcalloc(TEST_LIST_LEN, sizeof(*elts), GFP_KERNEL);
-	if (!elts)
-		return err;
+	KUNIT_ASSERT_FALSE_MSG(context, elts == NULL, "kcalloc failed");
 
 	for (i = 0; i < TEST_LIST_LEN; i++) {
 		el = kmalloc(sizeof(*el), GFP_KERNEL);
-		if (!el)
+		if (!el) {
+			KUNIT_FAIL(context, "kmalloc failed");
 			goto exit;
+		}
 
 		 /* force some equivalencies */
 		el->value = prandom_u32() % (TEST_LIST_LEN / 3);
@@ -94,55 +90,62 @@ static int __init list_sort_test(void)
 		list_add_tail(&el->list, &head);
 	}
 
-	list_sort(NULL, &head, cmp);
+	list_sort(context, &head, cmp);
 
-	err = -EINVAL;
 	for (cur = head.next; cur->next != &head; cur = cur->next) {
 		struct debug_el *el1;
 		int cmp_result;
 
 		if (cur->next->prev != cur) {
-			pr_err("error: list is corrupted\n");
+			KUNIT_FAIL(context, "list is corrupted");
 			goto exit;
 		}
 
-		cmp_result = cmp(NULL, cur, cur->next);
+		cmp_result = cmp(context, cur, cur->next);
 		if (cmp_result > 0) {
-			pr_err("error: list is not sorted\n");
+			KUNIT_FAIL(context, "list is not sorted");
 			goto exit;
 		}
 
 		el = container_of(cur, struct debug_el, list);
 		el1 = container_of(cur->next, struct debug_el, list);
 		if (cmp_result == 0 && el->serial >= el1->serial) {
-			pr_err("error: order of equivalent elements not "
-				"preserved\n");
+			KUNIT_FAIL(context, "order of equivalent elements not preserved");
 			goto exit;
 		}
 
-		if (check(el, el1)) {
-			pr_err("error: element check failed\n");
+		if (check(context, el, el1)) {
 			goto exit;
 		}
 		count++;
 	}
 	if (head.prev != cur) {
-		pr_err("error: list is corrupted\n");
+		KUNIT_FAIL(context, "list is corrupted");
 		goto exit;
 	}
 
 
 	if (count != TEST_LIST_LEN) {
-		pr_err("error: bad list length %d", count);
+		KUNIT_FAIL(context, "bad list length %d", count);
 		goto exit;
 	}
 
-	err = 0;
 exit:
 	for (i = 0; i < TEST_LIST_LEN; i++)
 		kfree(elts[i]);
 	kfree(elts);
-	return err;
 }
-module_init(list_sort_test);
+
+static struct kunit_case __refdata list_sort_test_cases[] = {
+	KUNIT_CASE(test_list_sort),
+	{}
+};
+
+static struct kunit_suite list_sort_test_suite = {
+	.name = "list-sort",
+	.test_cases = list_sort_test_cases,
+};
+
+kunit_test_suites(&list_sort_test_suite);
+
 MODULE_LICENSE("GPL");

base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
-- 
2.26.2

