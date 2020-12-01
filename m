Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B203C2C97F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 08:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgLAHSC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 02:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgLAHSB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 02:18:01 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C37C0613D2;
        Mon, 30 Nov 2020 23:17:21 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id hk16so676146pjb.4;
        Mon, 30 Nov 2020 23:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zY0FQFVREnAdR5+7co4qc0e40cmxPIIMDs73EaBn3LQ=;
        b=C5+Vbm0LttFKcGey2TgAOuEQfeK5sMqtxX2qR9aABWMSThPIZLgdyhjFcdadvFqQ+b
         CLLDX1yj3C7zAOzTGJZB0YzopRnoynJb0kZQzRzFfE2Yc0J4ppW8A8g7n3nSNZM4by5m
         y+vze+IQQ6KNUI6KmjRln9fnW8NGpmq+tgLvlyVbbrQAImqWJdWngHvNuBw5fh+Pssh8
         9xMQ/kheF03dYNfd3RNg3iMy7+4SAgBUTruLwMYFd6Sk6QcH0a0MaX3fddLkQhCTUxK4
         b4ncpZUaNJKBe9Kj51OxB7Ok966vS1EZ9dfXU6SUljSEZRCD7fhApprOn13t3Iz2AP2f
         7XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zY0FQFVREnAdR5+7co4qc0e40cmxPIIMDs73EaBn3LQ=;
        b=MzEvaaRRsIqr4N9PbUUWgliySZ6L40eDzHxXEQAG4qRk7nXkeuEIlTQcUNuI5Y5VvB
         zqa3+qBuMsuEI84nNxXpDsFaGpLoQ2gaHhZ0THB+ws8VuDqi4TrHqfMuKVFKuR+jx7bm
         piIAgmC42soeQhdURoMnhjF4NgCpuEE5ig5ga6VB0DOO96djbd0OVjeDQln8c6coL+vR
         q5AgG2iyFZGJ3wyrSwY3/nW7PkEinktl7IX+OqfZmvjfN+skQUWUBDyhXSnhAZOYVEdx
         Y8W+GYxFQkpxBuGuKTXF4qK1Hnf38tgJ5WnR/8NbASVGQ+AB/CYH8z1455wB7sZ8jrOs
         oqzw==
X-Gm-Message-State: AOAM530wpW0guCy8qp32HZ0ND2SsAG/cmofSBHACBtmiT7y+BqX0OzU8
        AkpMmQGliXAZ2VVoimWDo48=
X-Google-Smtp-Source: ABdhPJxtPF3XQZAk1QRHQJNdt1d1zbl3kAlp1XNmL25D1Zbn5k1Cc5M/Hfy9ZTfKV8SXwHGo6FAQrA==
X-Received: by 2002:a17:90a:a506:: with SMTP id a6mr1405824pjq.82.1606807040645;
        Mon, 30 Nov 2020 23:17:20 -0800 (PST)
Received: from arpitha-Inspiron-7570.lan ([106.51.140.48])
        by smtp.gmail.com with ESMTPSA id p1sm1611618pfb.208.2020.11.30.23.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:17:19 -0800 (PST)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] lib: Convert test_hexdump.c to KUnit
Date:   Tue,  1 Dec 2020 12:46:32 +0530
Message-Id: <20201201071632.68471-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Convert test lib/test_hexdump.c to KUnit. More information about
KUnit can be found at:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
KUnit provides a common framework for unit tests in the kernel.
KUnit and kselftest are standardizing around KTAP, converting this
test to KUnit makes this test output in KTAP which we are trying to
make the standard test result format for the kernel.

I ran both the original and converted tests as is to produce the
output for success of the test in the two cases. I also ran these
tests with a small modification to show the difference in the output
for failure of the test in both cases. The modification I made is:
 static const char * const test_data_4_le[] __initconst = {
-       "7bdb32be", "b293180a", "24c4ba70", "9b34837d",
+       "7bdb32be", "b293180a", "24c4ba70", "9b3483d",

The difference in outputs can be seen here:
https://gist.github.com/arpi-r/38f53a3c65692bf684a6bf3453884b6e

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
Changes v2->v3:
- Modify KUNIT_EXPECT macros used
- kunittest variable made static
- A more detailed commit message

Changes v1->v2:
- Replace KUNIT_EXPECT_EQ() with KUNIT_EXPECT_EQ_MSG()
- Replace KUNIT_EXPECT_NE() with KUNIT_EXPECT_NE_MSG()
- Prints expected and real buffer values in case of test failure

 lib/Kconfig.debug                       |  7 ++-
 lib/Makefile                            |  2 +-
 lib/{test_hexdump.c => hexdump_kunit.c} | 73 +++++++++++--------------
 3 files changed, 36 insertions(+), 46 deletions(-)
 rename lib/{test_hexdump.c => hexdump_kunit.c} (78%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c789b39ed527..a82ff23b19e7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2039,9 +2039,6 @@ config ASYNC_RAID6_TEST
 
 	  If unsure, say N.
 
-config TEST_HEXDUMP
-	tristate "Test functions located in the hexdump module at runtime"
-
 config TEST_STRING_HELPERS
 	tristate "Test functions located in the string_helpers module at runtime"
 
@@ -2280,6 +2277,10 @@ config BITS_TEST
 
 	  If unsure, say N.
 
+config HEXDUMP_KUNIT_TEST
+	tristate "KUnit test for functions located in the hexdump module at runtime"
+	depends on KUNIT
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index dc76e7d8a453..f046ecf2817a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -55,7 +55,6 @@ obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
 obj-y += hexdump.o
-obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
@@ -352,3 +351,4 @@ obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_BITS_TEST) += bits_kunit.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += linear_ranges_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list_kunit.o
+obj-$(CONFIG_HEXDUMP_KUNIT_TEST) += hexdump_kunit.o
diff --git a/lib/test_hexdump.c b/lib/hexdump_kunit.c
similarity index 78%
rename from lib/test_hexdump.c
rename to lib/hexdump_kunit.c
index 5144899d3c6b..c12f3229485c 100644
--- a/lib/test_hexdump.c
+++ b/lib/hexdump_kunit.c
@@ -3,6 +3,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -61,12 +62,11 @@ static const char * const test_data_8_be[] __initconst = {
 
 #define FILL_CHAR	'#'
 
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
+static struct kunit *kunittest;
 
-static void __init test_hexdump_prepare_test(size_t len, int rowsize,
-					     int groupsize, char *test,
-					     size_t testlen, bool ascii)
+static void test_hexdump_prepare_test(size_t len, int rowsize,
+				      int groupsize, char *test,
+				      size_t testlen, bool ascii)
 {
 	char *p;
 	const char * const *result;
@@ -122,14 +122,12 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 
 #define TEST_HEXDUMP_BUF_SIZE		(32 * 3 + 2 + 32 + 1)
 
-static void __init test_hexdump(size_t len, int rowsize, int groupsize,
-				bool ascii)
+static void test_hexdump(size_t len, int rowsize, int groupsize,
+			 bool ascii)
 {
 	char test[TEST_HEXDUMP_BUF_SIZE];
 	char real[TEST_HEXDUMP_BUF_SIZE];
 
-	total_tests++;
-
 	memset(real, FILL_CHAR, sizeof(real));
 	hex_dump_to_buffer(data_b, len, rowsize, groupsize, real, sizeof(real),
 			   ascii);
@@ -138,15 +136,12 @@ static void __init test_hexdump(size_t len, int rowsize, int groupsize,
 	test_hexdump_prepare_test(len, rowsize, groupsize, test, sizeof(test),
 				  ascii);
 
-	if (memcmp(test, real, TEST_HEXDUMP_BUF_SIZE)) {
-		pr_err("Len: %zu row: %d group: %d\n", len, rowsize, groupsize);
-		pr_err("Result: '%s'\n", real);
-		pr_err("Expect: '%s'\n", test);
-		failed_tests++;
-	}
+	KUNIT_EXPECT_FALSE_MSG(kunittest, memcmp(test, real, TEST_HEXDUMP_BUF_SIZE),
+			       "Len: %zu row: %d group: %d\nResult: '%s'\nExpect: '%s'\n",
+			       len, rowsize, groupsize, real, test);
 }
 
-static void __init test_hexdump_set(int rowsize, bool ascii)
+static void test_hexdump_set(int rowsize, bool ascii)
 {
 	size_t d = min_t(size_t, sizeof(data_b), rowsize);
 	size_t len = get_random_int() % d + 1;
@@ -157,9 +152,9 @@ static void __init test_hexdump_set(int rowsize, bool ascii)
 	test_hexdump(len, rowsize, 1, ascii);
 }
 
-static void __init test_hexdump_overflow(size_t buflen, size_t len,
-					 int rowsize, int groupsize,
-					 bool ascii)
+static void test_hexdump_overflow(size_t buflen, size_t len,
+				  int rowsize, int groupsize,
+				  bool ascii)
 {
 	char test[TEST_HEXDUMP_BUF_SIZE];
 	char buf[TEST_HEXDUMP_BUF_SIZE];
@@ -167,8 +162,6 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 	int ae, he, e, f, r;
 	bool a;
 
-	total_tests++;
-
 	memset(buf, FILL_CHAR, sizeof(buf));
 
 	r = hex_dump_to_buffer(data_b, len, rs, gs, buf, buflen, ascii);
@@ -196,16 +189,13 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 
 	buf[sizeof(buf) - 1] = '\0';
 
-	if (!a) {
-		pr_err("Len: %zu buflen: %zu strlen: %zu\n",
-			len, buflen, strnlen(buf, sizeof(buf)));
-		pr_err("Result: %d '%s'\n", r, buf);
-		pr_err("Expect: %d '%s'\n", e, test);
-		failed_tests++;
-	}
+	KUNIT_EXPECT_TRUE_MSG(kunittest, a,
+			      "Len: %zu buflen: %zu strlen: %zu\nResult: %d '%s'\nExpect: %d '%s'\n",
+			      len, buflen, strnlen(buf, sizeof(buf)),
+			      r, buf, e, test);
 }
 
-static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
+static void test_hexdump_overflow_set(size_t buflen, bool ascii)
 {
 	unsigned int i = 0;
 	int rs = (get_random_int() % 2 + 1) * 16;
@@ -218,10 +208,11 @@ static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
 	} while (i++ < 3);
 }
 
-static int __init test_hexdump_init(void)
+static void test_hexdump_init(struct kunit *test)
 {
 	unsigned int i;
 	int rowsize;
+	kunittest = test;
 
 	rowsize = (get_random_int() % 2 + 1) * 16;
 	for (i = 0; i < 16; i++)
@@ -236,21 +227,19 @@ static int __init test_hexdump_init(void)
 
 	for (i = 0; i <= TEST_HEXDUMP_BUF_SIZE; i++)
 		test_hexdump_overflow_set(i, true);
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

