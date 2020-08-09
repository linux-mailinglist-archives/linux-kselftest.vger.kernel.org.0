Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40ABE23FEC9
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Aug 2020 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgHIOpl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Aug 2020 10:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIOpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Aug 2020 10:45:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9403EC061756;
        Sun,  9 Aug 2020 07:45:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ep8so3497838pjb.3;
        Sun, 09 Aug 2020 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2iuVv4gM1MdMOYd40ce8eT3xg35aeEd9myudBM64X18=;
        b=bctJ7jE7Rl7Y7z9oAwWJiMIC0vdXTHSHvwOHOvk9dgFIrXKECb1QbBJDLEcq6r6QhW
         UkWTPWtdq+0YSumECg4Q81bOCnChp1SunrhX5R+M9inTgPjUhoa3QheedrmKJgt/2D2q
         alkNe7b/xupQTHSDL3RgDlJP09ApFY0/I3UDHXitAdf50/wSjDy2HVlzQaKh6rlvkwgr
         rB7YHvxphL8ItWySxCPhcwxF9EX5kTpiPuohhwaotpgsNtyKKI15tPNS3QVvtz2MrMdv
         ihkBYnrhV1k+DsxePR3byPFrhaTeHyBOGVHVzdEj+eA0zc3VlftrJ7nVs5bfafa89bGm
         gLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2iuVv4gM1MdMOYd40ce8eT3xg35aeEd9myudBM64X18=;
        b=An4oyBtHHKLimfkS1in6H+PLOETk+6JGKFucIJaIfy1nGw1vNhymiYky6vjLDAFBX0
         R3NJrHndNO5tELzz6p0bqjhzNk1RYxDUvWiT958lRfF9AEqjGkHQ7nmOyfJdqpLDn0Wg
         4INbdPvD4VbZ4HI/4IcrErrI6virvzNeh3zD0oJMxuOkxCmbf3za/qS5MHniVn/MW6pS
         xrwcsrVH81RIoIliZKAb+fIEmLMUjcKvln8RKDA+ZyKpZKfMPcWppY8cjNM6qHwC4W47
         KJu4h1dzr+lsei+Xb5FpVwArc+rTiexJtsQLowV3DP2S535SEVvSkRLX2sUzb+KhWEtO
         xoxg==
X-Gm-Message-State: AOAM531/VtsKLxk7NVMKOeklf+mT6DgA3Erhsup7+tFTWc9NLDxBMM7D
        eYyGtYW5iH1ABSbHSjRHopo=
X-Google-Smtp-Source: ABdhPJwKB738poNztH/3a0EWwL8KRY1GV4fvAtsuYiZSJGHIgHJEEgW7jMOcKq2j5Ga4sGD0YkZyjQ==
X-Received: by 2002:a17:90a:2110:: with SMTP id a16mr22924416pje.104.1596984338130;
        Sun, 09 Aug 2020 07:45:38 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([49.206.15.28])
        by smtp.gmail.com with ESMTPSA id 203sm14244523pge.34.2020.08.09.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 07:45:37 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] lib: Convert test_hexdump.c to KUnit
Date:   Sun,  9 Aug 2020 20:15:08 +0530
Message-Id: <20200809144508.61076-1-98.arpi@gmail.com>
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
Changes v1->v2:
- Replace KUNIT_EXPECT_EQ() with KUNIT_EXPECT_EQ_MSG()
- Replace KUNIT_EXPECT_NE() with KUNIT_EXPECT_NE_MSG()
- Prints expected and real buffer values in case of test failure

 lib/Kconfig.debug                       |  7 +-
 lib/Makefile                            |  2 +-
 lib/{test_hexdump.c => hexdump_kunit.c} | 85 ++++++++++---------------
 3 files changed, 40 insertions(+), 54 deletions(-)
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
index f39962104036..73ae79e36cc9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
 obj-y += hexdump.o
-obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
@@ -345,3 +344,4 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
+obj-$(CONFIG_HEXDUMP_KUNIT_TEST) += hexdump_kunit.o
diff --git a/lib/test_hexdump.c b/lib/hexdump_kunit.c
similarity index 74%
rename from lib/test_hexdump.c
rename to lib/hexdump_kunit.c
index 5144899d3c6b..fea074b8c2e5 100644
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
@@ -138,28 +134,25 @@ static void __init test_hexdump(size_t len, int rowsize, int groupsize,
 	test_hexdump_prepare_test(len, rowsize, groupsize, test, sizeof(test),
 				  ascii);
 
-	if (memcmp(test, real, TEST_HEXDUMP_BUF_SIZE)) {
-		pr_err("Len: %zu row: %d group: %d\n", len, rowsize, groupsize);
-		pr_err("Result: '%s'\n", real);
-		pr_err("Expect: '%s'\n", test);
-		failed_tests++;
-	}
+	KUNIT_EXPECT_EQ_MSG(kunittest, 0, memcmp(test, real, TEST_HEXDUMP_BUF_SIZE),
+			"Len: %zu row: %d group: %d\nResult: '%s'\nExpect: '%s'\n",
+			len, rowsize, groupsize, real, test);
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
@@ -167,8 +160,6 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 	int ae, he, e, f, r;
 	bool a;
 
-	total_tests++;
-
 	memset(buf, FILL_CHAR, sizeof(buf));
 
 	r = hex_dump_to_buffer(data_b, len, rs, gs, buf, buflen, ascii);
@@ -196,16 +187,12 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 
 	buf[sizeof(buf) - 1] = '\0';
 
-	if (!a) {
-		pr_err("Len: %zu buflen: %zu strlen: %zu\n",
-			len, buflen, strnlen(buf, sizeof(buf)));
-		pr_err("Result: %d '%s'\n", r, buf);
-		pr_err("Expect: %d '%s'\n", e, test);
-		failed_tests++;
-	}
+	KUNIT_EXPECT_NE_MSG(kunittest, 0, a,
+			"Len: %zu buflen: %zu strlen: %zu\nResult: %d '%s'\nExpect: %d '%s",
+			len, buflen, strnlen(buf, sizeof(buf)), r, buf, e, test);
 }
 
-static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
+static void test_hexdump_overflow_set(struct kunit *test, size_t buflen, bool ascii)
 {
 	unsigned int i = 0;
 	int rs = (get_random_int() % 2 + 1) * 16;
@@ -214,43 +201,41 @@ static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
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

