Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8925F23251A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgG2TL6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgG2TL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 15:11:58 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127B5C0619D2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 12:11:58 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so23285494qke.11
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiXGvEaxlR+R/poUy+KkKDbPSSxw+vYE0tU7qSg7Gr0=;
        b=QQyoFB/3QZEIbqjLrh11jmrIQZShit6LKFxmT1o2Ns8Njgxj/67t76WMxdNauZLpS4
         xggeFCt7js2asoG0lTI31libhtwx/Lf2xwN4/IrW7bnpfpxZd5bhcYk4HzKyIOeIiorP
         8/zPd7XdHYxn8xGkUSF4VZBxeKK8Sn5ZR2a9eS19DPoml2a8U4MV22tXnE6MWjKbyjBu
         FlGRUBXIKokZJcw+PnvLDfFUTnNTffEzcRlyUu3NSnYDaNYHhZ91WTjvs0q0ZJwfWLFW
         w9tgtFmu70K9611GmIQrGq2lAfz20yktcmYJEql5EpU25w+vk/V5UpzcRAuem45Do2qW
         qXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiXGvEaxlR+R/poUy+KkKDbPSSxw+vYE0tU7qSg7Gr0=;
        b=KUeJdBdg75pgqRcWeeCi2j47kl3S+C3wk1diKCIfgqVk2UQNnzC+abpXlnq9uoab/e
         LDL44ST4xvWyRiMzf6SwLsAE+wwwNP8yijftV6sUjLe6vRsWH08y+UFC/Jvi2Km970k0
         4jZ3yRKbLNuWBc2HcEsyWHMuPGb9nh6ZUoyFWobjTnj1MjAaqtH228TErUNN1HYTcSxm
         /ey/O/Sc4vhFdrF+X4uOJd+EuELC4UUTKJWBLUiOVUCX8+f8fhRq11ShibqASAng5jc6
         f0bw9QU8ypNGmWLCt1T49VUmFZ0Y/cJKZh5QO8XRNjJVKexRM5/Mb//DKGH9ha7CXTFw
         PXLQ==
X-Gm-Message-State: AOAM533nMGG9ovo2H0qqZmxQy6+9UaehabiDX0NFovALdrIX5nuUbnT6
        k9XSAb2EtwXWkX0r5d7OnTJMsIZQvgkv8c4A
X-Google-Smtp-Source: ABdhPJzdBKqmAa7A60uajE8zyLjbuhxiZgjk+/Vh30Ar+K7BeZ3r90QOcK/43nsamnzbaFjsmAZ5NA==
X-Received: by 2002:a05:620a:4d9:: with SMTP id 25mr29737348qks.411.1596049917086;
        Wed, 29 Jul 2020 12:11:57 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id o187sm2270967qkd.112.2020.07.29.12.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:11:56 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, fkostenzer@live.at,
        andriy.shevchenko@linux.intel.com, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: [PATCH v2] lib: kunit: Convert test_sort to KUnit test
Date:   Wed, 29 Jul 2020 16:11:51 -0300
Message-Id: <20200729191151.476368-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the conversion of the test_sort.c to KUnit test.

Please apply this commit first (linux-kselftest/kunit-fixes):
3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space

Code Style Documentation: [0]

Fix these warnings Reported-by lkp@intel.com

WARNING: modpost: vmlinux.o(.data+0x4fc70): Section mismatch in reference from the variable sort_test_cases to the variable .init.text:sort_test
   The variable sort_test_cases references
   the variable __init sort_test
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable

WARNING: modpost: lib/sort_kunit.o(.data+0x11c): Section mismatch in reference from the variable sort_test_cases to the function .init.text:sort_test()
   The variable sort_test_cases references
   the function __init sort_test()

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
---
v2:
    * Add Kunit Code Style reference in commit message;
    * Fix lkp@intel.com warning report;
---
 lib/Kconfig.debug                 | 26 +++++++++++++++++---------
 lib/Makefile                      |  2 +-
 lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------
 3 files changed, 33 insertions(+), 26 deletions(-)
 rename lib/{test_sort.c => sort_kunit.c} (55%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..1fe19e78d7ca 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1874,15 +1874,6 @@ config TEST_MIN_HEAP

 	  If unsure, say N.

-config TEST_SORT
-	tristate "Array-based sort test"
-	depends on DEBUG_KERNEL || m
-	help
-	  This option enables the self-test function of 'sort()' at boot,
-	  or at module load time.
-
-	  If unsure, say N.
-
 config KPROBES_SANITY_TEST
 	bool "Kprobes sanity tests"
 	depends on DEBUG_KERNEL
@@ -2185,6 +2176,23 @@ config LINEAR_RANGES_TEST

 	  If unsure, say N.

+config SORT_KUNIT
+	tristate "KUnit test for Array-based sort"
+	depends on DEBUG_KERNEL || m
+	help
+	  This option enables the KUnit function of 'sort()' at boot,
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
index b1c42c10073b..c22bb13b0a08 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,7 +77,6 @@ obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
-obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
@@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_SORT_KUNIT) += sort_kunit.o
diff --git a/lib/test_sort.c b/lib/sort_kunit.c
similarity index 55%
rename from lib/test_sort.c
rename to lib/sort_kunit.c
index 52edbe10f2e5..602a234f1e7d 100644
--- a/lib/test_sort.c
+++ b/lib/sort_kunit.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/sort.h>
-#include <linux/slab.h>
-#include <linux/module.h>
+#include <kunit/test.h>

 /* a simple boot-time regression test */

@@ -12,13 +11,12 @@ static int __init cmpint(const void *a, const void *b)
 	return *(int *)a - *(int *)b;
 }

-static int __init test_sort_init(void)
+static void __init sort_test(struct kunit *test)
 {
-	int *a, i, r = 1, err = -ENOMEM;
+	int *a, i, r = 1;

 	a = kmalloc_array(TEST_LEN, sizeof(*a), GFP_KERNEL);
-	if (!a)
-		return err;
+	KUNIT_ASSERT_FALSE_MSG(test, a == NULL, "kmalloc_array failed");

 	for (i = 0; i < TEST_LEN; i++) {
 		r = (r * 725861) % 6599;
@@ -27,24 +25,25 @@ static int __init test_sort_init(void)

 	sort(a, TEST_LEN, sizeof(*a), cmpint, NULL);

-	err = -EINVAL;
 	for (i = 0; i < TEST_LEN-1; i++)
 		if (a[i] > a[i+1]) {
-			pr_err("test has failed\n");
+			KUNIT_FAIL(test, "test has failed");
 			goto exit;
 		}
-	err = 0;
-	pr_info("test passed\n");
 exit:
 	kfree(a);
-	return err;
 }

-static void __exit test_sort_exit(void)
-{
-}
+static struct kunit_case __refdata sort_test_cases[] = {
+	KUNIT_CASE(sort_test),
+	{}
+};
+
+static struct kunit_suite sort_test_suite = {
+	.name = "sort",
+	.test_cases = sort_test_cases,
+};

-module_init(test_sort_init);
-module_exit(test_sort_exit);
+kunit_test_suites(&sort_test_suite);

 MODULE_LICENSE("GPL");

base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
--
2.26.2

