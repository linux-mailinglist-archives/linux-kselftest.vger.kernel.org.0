Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715B82A43C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Nov 2020 12:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgKCLMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 06:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCLMA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 06:12:00 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD4C0613D1;
        Tue,  3 Nov 2020 03:12:00 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b3so13924029pfo.2;
        Tue, 03 Nov 2020 03:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHoRc7n0jAf5PVFi03ryHeEzyuO2vsIUFVuNwVKAUxY=;
        b=OB8s5WPxvSfaE88QI7//IspaCDhK1DAbLsFkdUHb/mEzpZkqf5hWPQ0T7Pca+uBYKs
         V4Wj7qQoyaoIicf9XEItj3dz+d0lfqwfz/fgI5+rSIn26xyEUYJHagO/35W9KtdnBHUQ
         3/u62LstRKIcc84Z6psdIn87t5xRwuO3iLGR4zpj7lRFEn+jiP4YqIlANdzhQoNFFxY1
         c83u0aJIMIIt6F03+8Mckx2DmaYvtteahYEh6cXfZe9pSZLqgkdwAI1TQ84lPHz+CJZC
         tescsKt7CbY6MKZs1iFcjhW0BU5NQ4V/E4OuKz8ueGUj+h3a5TiFNM7xECwlKwhORsnM
         nhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHoRc7n0jAf5PVFi03ryHeEzyuO2vsIUFVuNwVKAUxY=;
        b=dj0LkAQqdc6aoSlARxJJVf0rdH7rcCrnKiQwwPlFp5YXOPLDuL7UoOBLg6TRd1ss0A
         k2ZqLaj2Ttok/Xl/vFJX3BsPiVJEtjazHlJ0A9/4Q7FoOfAe3xLhYp267vuIeiq6SeEE
         qK3So8u6DAQgh3FK/goMkD71QW1C2l7lxoYgnxD/8CTds5kybPVz2W+/ua7TFFegKkgT
         bGoWGR9LR4Nj0lMblggzw/IWgTRdyX0kfHkgxJgGusWf6SMsdpTrcrt2H5K6NFY1EHgF
         Uj45ZFBrMfqvLuvQoMl4so3KbvlGjdAQ9st2Np+LoOiwz8xRrUk2x5ILRkVh8XbDayTW
         PE9A==
X-Gm-Message-State: AOAM530P9gLn8ZbzOcPdd0+WLREMQAVQ1jqg2Kpn612ewe/nJ4xkF8Au
        InVx4OZXrvvYyK8MElqmv2M=
X-Google-Smtp-Source: ABdhPJyZXEGbBORq8Q09J+BufnCmQR1d7005SVJr7+Ehk7npZN80T4yTdqkuDU99OH99ijvOiW9FmQ==
X-Received: by 2002:a62:8847:0:b029:15b:51c6:6a10 with SMTP id l68-20020a6288470000b029015b51c66a10mr24734946pfd.69.1604401919358;
        Tue, 03 Nov 2020 03:11:59 -0800 (PST)
Received: from arpitha-Inspiron-7570.lan ([106.51.243.217])
        by smtp.gmail.com with ESMTPSA id z3sm14928383pgl.73.2020.11.03.03.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 03:11:58 -0800 (PST)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        idryomov@gmail.com
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] lib: Convert test_printf.c to KUnit
Date:   Tue,  3 Nov 2020 16:40:49 +0530
Message-Id: <20201103111049.51916-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Convert test lib/test_printf.c to KUnit. More information about
KUnit can be found at:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
KUnit provides a common framework for unit tests in the kernel.
KUnit and kselftest are standardizing around KTAP, converting this
test to KUnit makes this test output in KTAP which we are trying to
make the standard test result format for the kernel. More about
the KTAP format can be found at:
https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/.
I ran both the original and converted tests as is to produce the
output for success of the test in the two cases. I also ran these
tests with a small modification to show the difference in the output
for failure of the test in both cases. The modification I made is:
- test("127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
+ test("127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);

Original test success:
[    0.540860] test_printf: loaded.
[    0.540863] test_printf: random seed = 0x5c46c33837bc0619
[    0.541022] test_printf: all 388 tests passed

Original test failure:
[    0.537980] test_printf: loaded.
[    0.537983] test_printf: random seed = 0x1bc1efd881954afb
[    0.538029] test_printf: vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
[    0.538030] test_printf: kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
[    0.538124] test_printf: failed 2 out of 388 tests
[    0.538125] test_printf: random seed used was 0x1bc1efd881954afb

Converted test success:
    # Subtest: printf
    1..25
    ok 1 - test_basic
    ok 2 - test_number
    ok 3 - test_string
    ok 4 - plain
    ok 5 - null_pointer
    ok 6 - error_pointer
    ok 7 - invalid_pointer
    ok 8 - symbol_ptr
    ok 9 - kernel_ptr
    ok 10 - struct_resource
    ok 11 - addr
    ok 12 - escaped_str
    ok 13 - hex_string
    ok 14 - mac
    ok 15 - ip
    ok 16 - uuid
    ok 17 - dentry
    ok 18 - struct_va_format
    ok 19 - time_and_date
    ok 20 - struct_clk
    ok 21 - bitmap
    ok 22 - netdev_features
    ok 23 - flags
    ok 24 - errptr
    ok 25 - fwnode_pointer
ok 1 - printf

Converted test failure:
    # Subtest: printf
    1..25
    ok 1 - test_basic
    ok 2 - test_number
    ok 3 - test_string
    ok 4 - plain
    ok 5 - null_pointer
    ok 6 - error_pointer
    ok 7 - invalid_pointer
    ok 8 - symbol_ptr
    ok 9 - kernel_ptr
    ok 10 - struct_resource
    ok 11 - addr
    ok 12 - escaped_str
    ok 13 - hex_string
    ok 14 - mac
    # ip: EXPECTATION FAILED at lib/printf_kunit.c:82
vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
    # ip: EXPECTATION FAILED at lib/printf_kunit.c:124
kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
    not ok 15 - ip
    ok 16 - uuid
    ok 17 - dentry
    ok 18 - struct_va_format
    ok 19 - time_and_date
    ok 20 - struct_clk
    ok 21 - bitmap
    ok 22 - netdev_features
    ok 23 - flags
    ok 24 - errptr
    ok 25 - fwnode_pointer
not ok 1 - printf

This patch is based on top of Andy's series that renames KUnit based
tests in lib/ and Ramsus' series on deterministic random testing.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
Changes v2->v3:
- Split tests into multiple KUNIT_CASE()
- kunittest variable made static
- Allocation and freeing done through init and exit callbacks in KUnit
Changes v1->v2:
- Retain the control flow (early returns) in do_test()
- Display less irrelevant information on test failure
- A more detailed commit message

 lib/Kconfig.debug                     |   7 +-
 lib/Makefile                          |   2 +-
 lib/{test_printf.c => printf_kunit.c} | 266 ++++++++++++++------------
 3 files changed, 150 insertions(+), 125 deletions(-)
 rename lib/{test_printf.c => printf_kunit.c} (78%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c789b39ed527..42de097d4c5f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2051,9 +2051,6 @@ config TEST_STRSCPY
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
-config TEST_PRINTF
-	tristate "Test printf() family of functions at runtime"
-
 config TEST_BITMAP
 	tristate "Test bitmap_*() family of functions at runtime"
 	help
@@ -2280,6 +2277,10 @@ config BITS_TEST
 
 	  If unsure, say N.
 
+config PRINTF_KUNIT_TEST
+	tristate "KUnit test for printf() family of functions at runtime"
+	depends on KUNIT
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index dc76e7d8a453..1351d242447c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -84,7 +84,6 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
-obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
@@ -352,3 +351,4 @@ obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_BITS_TEST) += bits_kunit.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += linear_ranges_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list_kunit.o
+obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
diff --git a/lib/test_printf.c b/lib/printf_kunit.c
similarity index 78%
rename from lib/test_printf.c
rename to lib/printf_kunit.c
index bbea8b807d1e..46b4a11f4b47 100644
--- a/lib/test_printf.c
+++ b/lib/printf_kunit.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -33,60 +34,55 @@
 
 static char *test_buffer __initdata;
 static char *alloced_buffer __initdata;
+static struct kunit *kunittest;
 
-static int __printf(4, 0) __init
+static void __printf(4, 0) __init
 do_test(int bufsize, const char *expect, int elen,
 	const char *fmt, va_list ap)
 {
 	va_list aq;
 	int ret, written;
 
-	total_tests++;
-
 	memset(alloced_buffer, FILL_CHAR, BUF_SIZE + 2*PAD_SIZE);
 	va_copy(aq, ap);
 	ret = vsnprintf(test_buffer, bufsize, fmt, aq);
 	va_end(aq);
 
 	if (ret != elen) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
+		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
 			bufsize, fmt, ret, elen);
-		return 1;
+		return;
 	}
 
 	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
-		return 1;
+		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
+		return;
 	}
 
 	if (!bufsize) {
-		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
-			pr_warn("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
-				fmt);
-			return 1;
-		}
-		return 0;
+		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE))
+			KUNIT_FAIL(kunittest, "vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n", fmt);
+		return;
 	}
 
 	written = min(bufsize-1, elen);
 	if (test_buffer[written]) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
+		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
 			bufsize, fmt);
-		return 1;
+		return;
 	}
 
 	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
+		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
 			bufsize, fmt);
-		return 1;
+		return;
 	}
 
 	if (memcmp(test_buffer, expect, written)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
+		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
 			bufsize, fmt, test_buffer, written, expect);
-		return 1;
+		return;
 	}
-	return 0;
 }
 
 static void __printf(3, 4) __init
@@ -97,9 +93,8 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	char *p;
 
 	if (elen >= BUF_SIZE) {
-		pr_err("error in test suite: expected output length %d too long. Format was '%s'.\n",
+		KUNIT_FAIL(kunittest, "error in test suite: expected output length %d too long. Format was '%s'.\n",
 		       elen, fmt);
-		failed_tests++;
 		return;
 	}
 
@@ -111,7 +106,7 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * enough and 0), and then we also test that kvasprintf would
 	 * be able to print it as expected.
 	 */
-	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
+	do_test(BUF_SIZE, expect, elen, fmt, ap);
 	rand = prandom_u32_range_state(&rnd_state, 1, elen + 1);
 	/*
 	 * Except for elen == 0, we have 1 <= rand <= elen < BUF_SIZE,
@@ -120,16 +115,14 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * larger than it really is. For the boring case of elen == 0,
 	 * rand is 1, which is of course also <= BUF_SIZE.
 	 */
-	failed_tests += do_test(rand, expect, elen, fmt, ap);
-	failed_tests += do_test(0, expect, elen, fmt, ap);
+	do_test(rand, expect, elen, fmt, ap);
+	do_test(0, expect, elen, fmt, ap);
 
 	p = kvasprintf(GFP_KERNEL, fmt, ap);
 	if (p) {
-		total_tests++;
 		if (memcmp(p, expect, elen+1)) {
-			pr_warn("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
+			KUNIT_FAIL(kunittest, "kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
 				fmt, p, expect);
-			failed_tests++;
 		}
 		kfree(p);
 	}
@@ -139,9 +132,10 @@ __test(const char *expect, int elen, const char *fmt, ...)
 #define test(expect, fmt, ...)					\
 	__test(expect, strlen(expect), fmt, ##__VA_ARGS__)
 
-static void __init
-test_basic(void)
+static void
+test_basic(struct kunit *ktest)
 {
+	kunittest = ktest;
 	/* Work around annoying "warning: zero-length gnu_printf format string". */
 	char nul = '\0';
 
@@ -151,9 +145,10 @@ test_basic(void)
 	__test("xxx\0yyy", 7, "xxx%cyyy", '\0');
 }
 
-static void __init
-test_number(void)
+static void
+test_number(struct kunit *ktest)
 {
+	kunittest = ktest;
 	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
 	test("  0x1234abcd", "%#12x", 0x1234abcd);
 	test("0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|% d", 0, 1, 12, 123, 1234, -123, -1234);
@@ -183,9 +178,10 @@ test_number(void)
 #endif
 }
 
-static void __init
-test_string(void)
+static void
+test_string(struct kunit *ktest)
 {
+	kunittest = ktest;
 	test("", "%s%.0s", "", "123");
 	test("ABCD|abc|123", "%s|%.3s|%.*s", "ABCD", "abcdef", 3, "123456");
 	test("1  |  2|3  |  4|5  ", "%-3s|%3s|%-*s|%*s|%*s", "1", "2", 3, "3", 3, "4", -3, "5");
@@ -301,23 +297,21 @@ plain_hash(void)
  * We can't use test() to test %p because we don't know what output to expect
  * after an address is hashed.
  */
-static void __init
-plain(void)
+static void
+plain(struct kunit *ktest)
 {
+	kunittest = ktest;
 	int err;
 
 	err = plain_hash();
 	if (err) {
-		pr_warn("plain 'p' does not appear to be hashed\n");
-		failed_tests++;
+		KUNIT_FAIL(kunittest, "plain 'p' does not appear to be hashed\n");
 		return;
 	}
 
 	err = plain_format();
-	if (err) {
-		pr_warn("hashing plain 'p' has unexpected format\n");
-		failed_tests++;
-	}
+	if (err)
+		KUNIT_FAIL(kunittest, "hashing plain 'p' has unexpected format\n");
 }
 
 static void __init
@@ -340,9 +334,10 @@ test_hashed(const char *fmt, const void *p)
 /*
  * NULL pointers aren't hashed.
  */
-static void __init
-null_pointer(void)
+static void
+null_pointer(struct kunit *ktest)
 {
+	kunittest = ktest;
 	test(ZEROS "00000000", "%p", NULL);
 	test(ZEROS "00000000", "%px", NULL);
 	test("(null)", "%pE", NULL);
@@ -351,9 +346,10 @@ null_pointer(void)
 /*
  * Error pointers aren't hashed.
  */
-static void __init
-error_pointer(void)
+static void
+error_pointer(struct kunit *ktest)
 {
+	kunittest = ktest;
 	test(ONES "fffffff5", "%p", ERR_PTR(-11));
 	test(ONES "fffffff5", "%px", ERR_PTR(-11));
 	test("(efault)", "%pE", ERR_PTR(-11));
@@ -361,43 +357,50 @@ error_pointer(void)
 
 #define PTR_INVALID ((void *)0x000000ab)
 
-static void __init
-invalid_pointer(void)
+static void
+invalid_pointer(struct kunit *ktest)
 {
+	kunittest = ktest;
 	test_hashed("%p", PTR_INVALID);
 	test(ZEROS "000000ab", "%px", PTR_INVALID);
 	test("(efault)", "%pE", PTR_INVALID);
 }
 
-static void __init
-symbol_ptr(void)
+static void
+symbol_ptr(struct kunit *ktest)
 {
+	kunittest = ktest;
 }
 
-static void __init
-kernel_ptr(void)
+static void
+kernel_ptr(struct kunit *ktest)
 {
+	kunittest = ktest;
 	/* We can't test this without access to kptr_restrict. */
 }
 
-static void __init
-struct_resource(void)
+static void
+struct_resource(struct kunit *ktest)
 {
+	kunittest = ktest;
 }
 
-static void __init
-addr(void)
+static void
+addr(struct kunit *ktest)
 {
+	kunittest = ktest;
 }
 
-static void __init
-escaped_str(void)
+static void
+escaped_str(struct kunit *ktest)
 {
+	kunittest = ktest;
 }
 
-static void __init
-hex_string(void)
+static void
+hex_string(struct kunit *ktest)
 {
+	kunittest = ktest;
 	const char buf[3] = {0xc0, 0xff, 0xee};
 
 	test("c0 ff ee|c0:ff:ee|c0-ff-ee|c0ffee",
@@ -406,9 +409,10 @@ hex_string(void)
 	     "%*ph|%*phC|%*phD|%*phN", 3, buf, 3, buf, 3, buf, 3, buf);
 }
 
-static void __init
-mac(void)
+static void
+mac(struct kunit *ktest)
 {
+	kunittest = ktest;
 	const u8 addr[6] = {0x2d, 0x48, 0xd6, 0xfc, 0x7a, 0x05};
 
 	test("2d:48:d6:fc:7a:05", "%pM", addr);
@@ -438,16 +442,18 @@ ip6(void)
 {
 }
 
-static void __init
-ip(void)
+static void
+ip(struct kunit *ktest)
 {
+	kunittest = ktest;
 	ip4();
 	ip6();
 }
 
-static void __init
-uuid(void)
+static void
+uuid(struct kunit *ktest)
 {
+	kunittest = ktest;
 	const char uuid[16] = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
 			       0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf};
 
@@ -472,9 +478,10 @@ static struct dentry test_dentry[4] __initdata = {
 	  .d_iname = "romeo" },
 };
 
-static void __init
-dentry(void)
+static void
+dentry(struct kunit *ktest)
 {
+	kunittest = ktest;
 	test("foo", "%pd", &test_dentry[0]);
 	test("foo", "%pd2", &test_dentry[0]);
 
@@ -493,14 +500,16 @@ dentry(void)
 	test("  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
 }
 
-static void __init
-struct_va_format(void)
+static void
+struct_va_format(struct kunit *ktest)
 {
+	kunittest = ktest;
 }
 
-static void __init
-time_and_date(void)
+static void
+time_and_date(struct kunit *ktest)
 {
+	kunittest = ktest;
 	/* 1543210543 */
 	const struct rtc_time tm = {
 		.tm_sec = 43,
@@ -527,9 +536,10 @@ time_and_date(void)
 	test("15:32:23|0119-00-04", "%ptTtr|%ptTdr", &t, &t);
 }
 
-static void __init
-struct_clk(void)
+static void
+struct_clk(struct kunit *ktest)
 {
+	kunittest = ktest;
 }
 
 static void __init
@@ -546,9 +556,10 @@ large_bitmap(void)
 	bitmap_free(bits);
 }
 
-static void __init
-bitmap(void)
+static void
+bitmap(struct kunit *ktest)
 {
+	kunittest = ktest;
 	DECLARE_BITMAP(bits, 20);
 	const int primes[] = {2,3,5,7,11,13,17,19};
 	int i;
@@ -569,14 +580,16 @@ bitmap(void)
 	large_bitmap();
 }
 
-static void __init
-netdev_features(void)
+static void
+netdev_features(struct kunit *ktest)
 {
+	kunittest = ktest;
 }
 
-static void __init
-flags(void)
+static void
+flags(struct kunit *ktest)
 {
+	kunittest = ktest;
 	unsigned long flags;
 	gfp_t gfp;
 	char *cmp_buffer;
@@ -623,8 +636,9 @@ flags(void)
 	kfree(cmp_buffer);
 }
 
-static void __init fwnode_pointer(void)
+static void fwnode_pointer(struct kunit *ktest)
 {
+	kunittest = ktest;
 	const struct software_node softnodes[] = {
 		{ .name = "first", },
 		{ .name = "second", .parent = &softnodes[0], },
@@ -654,9 +668,10 @@ static void __init fwnode_pointer(void)
 	software_node_unregister(&softnodes[0]);
 }
 
-static void __init
-errptr(void)
+static void
+errptr(struct kunit *ktest)
 {
+	kunittest = ktest;
 	test("-1234", "%pe", ERR_PTR(-1234));
 
 	/* Check that %pe with a non-ERR_PTR gets treated as ordinary %p. */
@@ -674,48 +689,57 @@ errptr(void)
 #endif
 }
 
-static void __init
-test_pointer(void)
-{
-	plain();
-	null_pointer();
-	error_pointer();
-	invalid_pointer();
-	symbol_ptr();
-	kernel_ptr();
-	struct_resource();
-	addr();
-	escaped_str();
-	hex_string();
-	mac();
-	ip();
-	uuid();
-	dentry();
-	struct_va_format();
-	time_and_date();
-	struct_clk();
-	bitmap();
-	netdev_features();
-	flags();
-	errptr();
-	fwnode_pointer();
-}
-
-static void __init selftest(void)
-{
-	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
+static int printf_test_init(struct kunit *ktest)
+{
+	alloced_buffer = kunit_kmalloc(ktest, BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
 	if (!alloced_buffer)
-		return;
+		return -ENOMEM;
 	test_buffer = alloced_buffer + PAD_SIZE;
+	return 0;
+}
 
-	test_basic();
-	test_number();
-	test_string();
-	test_pointer();
+static void printf_test_exit(struct kunit *ktest)
+{
+	kunit_kfree(ktest, alloced_buffer);
+}
+
+static struct kunit_case printf_test_cases[] = {
+	KUNIT_CASE(test_basic),
+	KUNIT_CASE(test_number),
+	KUNIT_CASE(test_string),
+	KUNIT_CASE(plain),
+	KUNIT_CASE(null_pointer),
+	KUNIT_CASE(error_pointer),
+	KUNIT_CASE(invalid_pointer),
+	KUNIT_CASE(symbol_ptr),
+	KUNIT_CASE(kernel_ptr),
+	KUNIT_CASE(struct_resource),
+	KUNIT_CASE(addr),
+	KUNIT_CASE(escaped_str),
+	KUNIT_CASE(hex_string),
+	KUNIT_CASE(mac),
+	KUNIT_CASE(ip),
+	KUNIT_CASE(uuid),
+	KUNIT_CASE(dentry),
+	KUNIT_CASE(struct_va_format),
+	KUNIT_CASE(time_and_date),
+	KUNIT_CASE(struct_clk),
+	KUNIT_CASE(bitmap),
+	KUNIT_CASE(netdev_features),
+	KUNIT_CASE(flags),
+	KUNIT_CASE(errptr),
+	KUNIT_CASE(fwnode_pointer),
+	{}
+};
 
-	kfree(alloced_buffer);
-}
+static struct kunit_suite printf_test_suite = {
+	.name = "printf",
+	.init = printf_test_init,
+	.exit = printf_test_exit,
+	.test_cases = printf_test_cases,
+};
+
+kunit_test_suite(printf_test_suite);
 
-KSTM_MODULE_LOADERS(test_printf);
 MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
 MODULE_LICENSE("GPL");
-- 
2.25.1

