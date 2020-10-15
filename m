Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0746F28EA6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 03:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgJOBq0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 21:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgJOBqZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 21:46:25 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45981C061755
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 18:46:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id y9so510088qvk.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+KMDSMW+VIAL3mDePAVrUXUBl0wejFu1z7ayCtJdWE=;
        b=cgW9/K3x93TgArMaMN1eVRDH8x6TsGW+2KFrqGZSm9nRochFWHsFWrkqVYLgqCVQzh
         fGSY0sbngNPxQb9U2RwyZgA9E1PRHFUjDnnQmSVtZU3V9WYsa/sNrOtAs729lTc4+4HI
         kLKnqg3FI47AtwWnBflb28IAKoRNhimAM/lwME8aq+hP7qnx1egmOvR5kTXpLKEDbXIm
         OWheODEdG9FcdJxH/Pfv0wNsjpQ7yPxwAx07HCv+EggLm0lk3odFHCYZaiUAwJomClvC
         rewmN3NMeHetnC+uvegWHUstXV/iIN6Sb1WZQqxR6aN5sRozaB4aiecYQ7bxSHqdkK6w
         t76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+KMDSMW+VIAL3mDePAVrUXUBl0wejFu1z7ayCtJdWE=;
        b=lsNLBsk3nljFutbswIQXem+gBYNy93ZrEZ6w+1bHYaC0zbi1CfYMSUWexCXl1cTuZN
         oK6IFxIlezfV2MGXIUqv3T3WlsqFsPDMO6SUEM9SZlruwRkZy3EYqPq9CtB8qI7A8zXf
         GhY/TZH9Q13YQAYZFSgZruRa5MPjWWg1WN+yTO9DRilAjMhxcze5rPS4EwddiuCKd3l0
         aYVpJLB1ls+dycBGcmh1zTRmEIY20S2PwPFFt6BC0Ck44SNL0BEjmE/M2EPCYyGpieY2
         Vhxmn32HxAbuBImGw6vjo+glp3NeS+KZIsyt0wjCzn/4H8AUnE0aKQ3fDQ7OMNvU4hWn
         PNrg==
X-Gm-Message-State: AOAM530zNynlQKKgeVGnlWjavU74Jkt+3q+FAwkYVutJRZZOUXjVtsvM
        uSzayZYomzfBX60rejT0Sty0WQ==
X-Google-Smtp-Source: ABdhPJzYM/lcrs60DNosmH1aZkomG9f401VbNqKieHGPn3ss7ztP5CAqKfbf6uPnoTX8dE58FnKQwA==
X-Received: by 2002:ad4:4f22:: with SMTP id fc2mr2288567qvb.28.1602726383312;
        Wed, 14 Oct 2020 18:46:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7cb:5e0b:6f3d:fca0:306c:a15d])
        by smtp.gmail.com with ESMTPSA id h9sm541448qth.78.2020.10.14.18.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 18:46:22 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com, brendanhiggins@google.com,
        elver@google.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, arnd@arndb.de,
        elfring@users.sourceforge.net, mhocko@suse.com
Subject: [PATCH v2] lib: kunit: add list_sort test conversion to KUnit
Date:   Wed, 14 Oct 2020 22:46:16 -0300
Message-Id: <20201015014616.309000-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the conversion of the runtime tests of test_list_sort,
from `lib/test_list_sort.c` to KUnit tests.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
v2:
  * fix  KUNIT_TEST sufix;
  * make kconfig help more concise;
  * remove obsolete commit comments;
  * change Kconfig entries to be more adherent to KUnit documentation;
---
 lib/Kconfig.debug                           | 24 ++++---
 lib/Makefile                                |  2 +-
 lib/{test_list_sort.c => list_sort_kunit.c} | 73 +++++++++++----------
 3 files changed, 53 insertions(+), 46 deletions(-)
 rename lib/{test_list_sort.c => list_sort_kunit.c} (62%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4f09c6505a2e..b4b1338c523a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1905,16 +1905,6 @@ config LKDTM
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
@@ -2233,6 +2223,20 @@ config LIST_KUNIT_TEST
 
 	  If unsure, say N.
 
+config LIST_SORT_KUNIT_TEST
+	tristate "KUnit Linked list sorting test" if !KUNIT_ALL_TESTS 
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this to turn on 'list_sort()' function test. This test is
+	  executed only once during system boot (so affects only boot time),
+	  or at module load time.
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
index d862d41fdc3d..a00e26d34263 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -67,7 +67,6 @@ obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
-obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
@@ -341,5 +340,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 # KUnit tests
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
+obj-$(CONFIG_LIST_SORT_KUNIT_TEST) += list_sort_kunit.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
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

base-commit: d2585f5164c298aaaed14c2c8d313cbe7bd5b253
-- 
2.26.2

