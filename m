Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D323D8E0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Aug 2020 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgHFJqI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Aug 2020 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgHFJpt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Aug 2020 05:45:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5CFC061574;
        Thu,  6 Aug 2020 02:45:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so27239111plk.1;
        Thu, 06 Aug 2020 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWcDbCXjjTS6FI2Lgan9OIsGZAC933SE4UPrECccLi4=;
        b=KKnCtfCegvFbD/tDZxYcvbMK30oQ3CsY9rUNbUO1ne/rJOL//uutNsLiyQwEmU0w7j
         z39/+c0SdKROpUiVvcgOUKEyCivyMDvsj5f5DSVm7Dx1ut65er3z37aiLab1gw460Xv5
         r8sPPFIRjMk4KrkDDRoJ8pix33kuUmOGbwdytFBncHRBMGbWqk/rpkFEXcV7BttRvCSB
         3+cUqBKpLfx7AwQiKWMRUW/jrK/bvcEESGyDf6vWuRZkvm5RBc0Bi4MsZpkrULdi1+mk
         s9Yrw8zSPoV2RT/tB1/Wxultw5MK5vyhpcvWB8+CshnT2jAXL+pjKjWYwtC9QsAmYkBN
         lNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWcDbCXjjTS6FI2Lgan9OIsGZAC933SE4UPrECccLi4=;
        b=SG2SmCON2n6Sp/47RSmh05bY/D0H/LTQiT+RPoFk+GzeeaWwuqrehH9sMpmgXH8m42
         GtuJA9wRQGuFaUdv5QUFpBwSkLsw9YWZti73ccQSP+xwo0e2wYqKNp1wlSbE3/CedfOO
         oN85z9DLhlVVoTH3nOclDadTImSq6diHf0EnGLad6yTDnfP74iOgOgpWfZo5RnykVIGm
         sOdu/VnHKRvX46K5jW8SJnu+gLBOHfJ8tOlan4lfuC8OFfwSwCOlzJi/32UQZJ97YGdQ
         V2mWNdSvdKgbm/xl3K/UdlGxc5XUqDmDzCCSSVToqZSItqj6HRZJdXfx5AERmdIIrFBf
         mbNw==
X-Gm-Message-State: AOAM532v9Eio0QjAy5I4+AlOapQs4ban+TAr/CKo9mYqSl+kmGaitccP
        RHfX1TYnxc8H7tuEDx6MxZVgffW0PYENog==
X-Google-Smtp-Source: ABdhPJweWzPxErikXlHXt2fZRae5rt4PSN+3g5cwiXlmpZWnbdEM0SQRie62WOdOxMGXOv/WIjSyEg==
X-Received: by 2002:a17:90a:fa94:: with SMTP id cu20mr7583230pjb.145.1596707135130;
        Thu, 06 Aug 2020 02:45:35 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([49.206.15.28])
        by smtp.gmail.com with ESMTPSA id 3sm6374496pjo.40.2020.08.06.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 02:45:34 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] lib: Convert test_hexdump.c to KUnit
Date:   Thu,  6 Aug 2020 15:14:40 +0530
Message-Id: <20200806094440.14962-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Converts test lib/test_hexdump.c to KUnit.
More information about KUnit can be found at
https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
KUnit provides a common framework for unit tests in the kernel.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
 lib/Kconfig.debug                       |  7 ++-
 lib/Makefile                            |  2 +-
 lib/{test_hexdump.c => hexdump_kunit.c} | 81 ++++++++++---------------
 3 files changed, 36 insertions(+), 54 deletions(-)
 rename lib/{test_hexdump.c => hexdump_kunit.c} (74%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a164785c3b48..20efea177e02 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2003,9 +2003,6 @@ config ASYNC_RAID6_TEST
 
 	  If unsure, say N.
 
-config TEST_HEXDUMP
-	tristate "Test functions located in the hexdump module at runtime"
-
 config TEST_STRING_HELPERS
 	tristate "Test functions located in the string_helpers module at runtime"
 
@@ -2224,6 +2221,10 @@ config LINEAR_RANGES_TEST
 
 	  If unsure, say N.
 
+config HEXDUMP_KUNIT_TEST
+	tristate "KUnit test for functions located in the hexdump module at runtime"
+	depends on KUNIT
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 435f7f13b8aa..3819d42a4681 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
 obj-y += hexdump.o
-obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
@@ -346,3 +345,4 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_HEXDUMP_KUNIT_TEST) += hexdump_kunit.o
diff --git a/lib/test_hexdump.c b/lib/hexdump_kunit.c
similarity index 74%
rename from lib/test_hexdump.c
rename to lib/hexdump_kunit.c
index 5144899d3c6b..8f8d80114a92 100644
--- a/lib/test_hexdump.c
+++ b/lib/hexdump_kunit.c
@@ -3,6 +3,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -61,10 +62,7 @@ static const char * const test_data_8_be[] __initconst = {
 
 #define FILL_CHAR	'#'
 
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
-
-static void __init test_hexdump_prepare_test(size_t len, int rowsize,
+static void test_hexdump_prepare_test(size_t len, int rowsize,
 					     int groupsize, char *test,
 					     size_t testlen, bool ascii)
 {
@@ -122,14 +120,12 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 
 #define TEST_HEXDUMP_BUF_SIZE		(32 * 3 + 2 + 32 + 1)
 
-static void __init test_hexdump(size_t len, int rowsize, int groupsize,
-				bool ascii)
+static void test_hexdump(struct kunit *kunittest, size_t len, int rowsize,
+				int groupsize, bool ascii)
 {
 	char test[TEST_HEXDUMP_BUF_SIZE];
 	char real[TEST_HEXDUMP_BUF_SIZE];
 
-	total_tests++;
-
 	memset(real, FILL_CHAR, sizeof(real));
 	hex_dump_to_buffer(data_b, len, rowsize, groupsize, real, sizeof(real),
 			   ascii);
@@ -138,28 +134,23 @@ static void __init test_hexdump(size_t len, int rowsize, int groupsize,
 	test_hexdump_prepare_test(len, rowsize, groupsize, test, sizeof(test),
 				  ascii);
 
-	if (memcmp(test, real, TEST_HEXDUMP_BUF_SIZE)) {
-		pr_err("Len: %zu row: %d group: %d\n", len, rowsize, groupsize);
-		pr_err("Result: '%s'\n", real);
-		pr_err("Expect: '%s'\n", test);
-		failed_tests++;
-	}
+	KUNIT_EXPECT_EQ(kunittest, 0, memcmp(test, real, TEST_HEXDUMP_BUF_SIZE));
 }
 
-static void __init test_hexdump_set(int rowsize, bool ascii)
+static void test_hexdump_set(struct kunit *test, int rowsize, bool ascii)
 {
 	size_t d = min_t(size_t, sizeof(data_b), rowsize);
 	size_t len = get_random_int() % d + 1;
 
-	test_hexdump(len, rowsize, 4, ascii);
-	test_hexdump(len, rowsize, 2, ascii);
-	test_hexdump(len, rowsize, 8, ascii);
-	test_hexdump(len, rowsize, 1, ascii);
+	test_hexdump(test, len, rowsize, 4, ascii);
+	test_hexdump(test, len, rowsize, 2, ascii);
+	test_hexdump(test, len, rowsize, 8, ascii);
+	test_hexdump(test, len, rowsize, 1, ascii);
 }
 
-static void __init test_hexdump_overflow(size_t buflen, size_t len,
-					 int rowsize, int groupsize,
-					 bool ascii)
+static void test_hexdump_overflow(struct kunit *kunittest, size_t buflen,
+					size_t len, int rowsize,
+					int groupsize, bool ascii)
 {
 	char test[TEST_HEXDUMP_BUF_SIZE];
 	char buf[TEST_HEXDUMP_BUF_SIZE];
@@ -167,8 +158,6 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 	int ae, he, e, f, r;
 	bool a;
 
-	total_tests++;
-
 	memset(buf, FILL_CHAR, sizeof(buf));
 
 	r = hex_dump_to_buffer(data_b, len, rs, gs, buf, buflen, ascii);
@@ -196,16 +185,10 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 
 	buf[sizeof(buf) - 1] = '\0';
 
-	if (!a) {
-		pr_err("Len: %zu buflen: %zu strlen: %zu\n",
-			len, buflen, strnlen(buf, sizeof(buf)));
-		pr_err("Result: %d '%s'\n", r, buf);
-		pr_err("Expect: %d '%s'\n", e, test);
-		failed_tests++;
-	}
+	KUNIT_EXPECT_NE(kunittest, 0, a);
 }
 
-static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
+static void test_hexdump_overflow_set(struct kunit *test, size_t buflen, bool ascii)
 {
 	unsigned int i = 0;
 	int rs = (get_random_int() % 2 + 1) * 16;
@@ -214,43 +197,41 @@ static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
 		int gs = 1 << i;
 		size_t len = get_random_int() % rs + gs;
 
-		test_hexdump_overflow(buflen, rounddown(len, gs), rs, gs, ascii);
+		test_hexdump_overflow(test, buflen, rounddown(len, gs), rs, gs, ascii);
 	} while (i++ < 3);
 }
 
-static int __init test_hexdump_init(void)
+static void test_hexdump_init(struct kunit *test)
 {
 	unsigned int i;
 	int rowsize;
 
 	rowsize = (get_random_int() % 2 + 1) * 16;
 	for (i = 0; i < 16; i++)
-		test_hexdump_set(rowsize, false);
+		test_hexdump_set(test, rowsize, false);
 
 	rowsize = (get_random_int() % 2 + 1) * 16;
 	for (i = 0; i < 16; i++)
-		test_hexdump_set(rowsize, true);
+		test_hexdump_set(test, rowsize, true);
 
 	for (i = 0; i <= TEST_HEXDUMP_BUF_SIZE; i++)
-		test_hexdump_overflow_set(i, false);
+		test_hexdump_overflow_set(test, i, false);
 
 	for (i = 0; i <= TEST_HEXDUMP_BUF_SIZE; i++)
-		test_hexdump_overflow_set(i, true);
+		test_hexdump_overflow_set(test, i, true);
+}
 
-	if (failed_tests == 0)
-		pr_info("all %u tests passed\n", total_tests);
-	else
-		pr_err("failed %u out of %u tests\n", failed_tests, total_tests);
+static struct kunit_case hexdump_test_cases[] = {
+	KUNIT_CASE(test_hexdump_init),
+	{}
+};
 
-	return failed_tests ? -EINVAL : 0;
-}
-module_init(test_hexdump_init);
+static struct kunit_suite hexdump_test_suite = {
+	.name = "hexdump-kunit-test",
+	.test_cases = hexdump_test_cases,
+};
 
-static void __exit test_hexdump_exit(void)
-{
-	/* do nothing */
-}
-module_exit(test_hexdump_exit);
+kunit_test_suite(hexdump_test_suite);
 
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

