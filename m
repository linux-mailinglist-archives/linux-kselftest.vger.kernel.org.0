Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6AA245BA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Aug 2020 06:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgHQEcN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Aug 2020 00:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQEcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Aug 2020 00:32:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B12AC061388;
        Sun, 16 Aug 2020 21:32:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x6so7504243pgx.12;
        Sun, 16 Aug 2020 21:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o16XKgkA2ur5Ph6lBNP9KHPR/oIni79Ag1N9S6v1K2o=;
        b=As19D1qHxSdX3e9YqLolSSkeXUujrsfLQS9QVNxzc66IZiXEJMnxAF7Y8MVx2TUD/w
         6u1BWUlcqGQa/+ux91fEDaowj5VR6iYkTLecKH1R8s3UNLq3h1F5XvJDMkg2J4Qwej0y
         kyvXvkIkKTSki7LCYpNUSBf0rL/Te0SXCJ7UzbBb6sy5H2O7ed5RMFR8ir7Zx2Sfnqv/
         +h3+EGN/t7TrwdBtp42CT1GN3H0BFS8rHh+IrcuS6515MwBbR59MkzEjlCDoFCEVhqwa
         tK7bIBn2y1BZirCL8BfEDNBwJ0zikhuFX7wcDvK8JkdtWGNVib0KQ7PZeUG+pg9gLIZ+
         vLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o16XKgkA2ur5Ph6lBNP9KHPR/oIni79Ag1N9S6v1K2o=;
        b=CY/1TIxmDD4C7vQ1emnm97mqXLGSmjs5pChr6WtyHUx3pBSpOqRIzrKktgCNme+JGl
         dAQ4//IwCanMZdNngl+6Nr/0TFNZQUNDD4kbN+PSxMPaE6kDGs7hCPQxsTo2d23wIw4G
         SOJGLVclUsYuqwhbi9ckuseDDReCMKJJhTtdbTXqaDxSv3duFHdgztvSKvG2cgphpO1q
         GMbFDgibkHZ7fpsVDS4uYUOQpkw1o4MSOb0oIk4L8ske4r4jCw7bDovplSvmkn2ZtgxJ
         DgYd3QuU0qubaD95ZMOPpb+cKsBtBfCj/Pj5MikHipUxfHffHXMtQvC78sEZixR5wYcG
         Ubsg==
X-Gm-Message-State: AOAM531qvHLlAIMi6JcUOQximCQFiTN8APvMZHl4v/LEjS6qzc4AAZ0Z
        UDhLpAnf6SNZCh9NVOpPYz/CyU82dd1UzzEi
X-Google-Smtp-Source: ABdhPJxhES5XEyYScNPO1ffXhKomc2f9q42i0fhBcJzUvwKy9ZGv8CwbzY3JB4RlgpqKGmD9t7pLgg==
X-Received: by 2002:a63:cf03:: with SMTP id j3mr8860127pgg.14.1597638726255;
        Sun, 16 Aug 2020 21:32:06 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([49.206.11.137])
        by smtp.gmail.com with ESMTPSA id e22sm14900684pgi.62.2020.08.16.21.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 21:32:05 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        linux@rasmusvillemoes.dk
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] lib: Convert test_printf.c to KUnit
Date:   Mon, 17 Aug 2020 10:00:28 +0530
Message-Id: <20200817043028.76502-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Converts test lib/test_printf.c to KUnit.
More information about KUnit can be found at
https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
KUnit provides a common framework for unit tests in the kernel.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
 lib/Kconfig.debug                     |   7 +-
 lib/Makefile                          |   2 +-
 lib/{test_printf.c => printf_kunit.c} | 498 +++++++++++++-------------
 3 files changed, 246 insertions(+), 261 deletions(-)
 rename lib/{test_printf.c => printf_kunit.c} (45%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c7189a..7454258cf57a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2027,9 +2027,6 @@ config TEST_STRSCPY
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
-config TEST_PRINTF
-	tristate "Test printf() family of functions at runtime"
-
 config TEST_BITMAP
 	tristate "Test bitmap_*() family of functions at runtime"
 	help
@@ -2247,6 +2244,10 @@ config BITS_TEST
 
 	  If unsure, say N.
 
+config PRINTF_KUNIT_TEST
+	tristate "KUnit tests for printf() family of functions at runtime"
+	depends on KUNIT
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index e290fc5707ea..68e5b32a185f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,7 +77,6 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
-obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
 obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
@@ -343,3 +342,4 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
+obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
diff --git a/lib/test_printf.c b/lib/printf_kunit.c
similarity index 45%
rename from lib/test_printf.c
rename to lib/printf_kunit.c
index 7ac87f18a10f..68ac5f9b8d28 100644
--- a/lib/test_printf.c
+++ b/lib/printf_kunit.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -30,79 +31,61 @@
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
 
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
-static char *test_buffer __initdata;
-static char *alloced_buffer __initdata;
+static char *test_buffer;
+static char *alloced_buffer;
 
-static int __printf(4, 0) __init
-do_test(int bufsize, const char *expect, int elen,
+static void __printf(5, 0)
+do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
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
 
-	if (ret != elen) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
+	KUNIT_EXPECT_EQ_MSG(kunittest, ret, elen,
+			"vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
 			bufsize, fmt, ret, elen);
-		return 1;
-	}
 
-	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
-		return 1;
-	}
+	KUNIT_EXPECT_EQ_MSG(kunittest, memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE), NULL,
+			"vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n",
+			bufsize, fmt);
 
 	if (!bufsize) {
-		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
-			pr_warn("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
-				fmt);
-			return 1;
-		}
-		return 0;
+		KUNIT_EXPECT_FALSE_MSG(kunittest,
+			memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE),
+			"vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n", fmt);
+		return;
 	}
 
 	written = min(bufsize-1, elen);
-	if (test_buffer[written]) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
+	KUNIT_EXPECT_FALSE_MSG(kunittest, test_buffer[written],
+			"vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
 			bufsize, fmt);
-		return 1;
-	}
 
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
+	KUNIT_EXPECT_FALSE_MSG(kunittest,
+			memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1)),
+			"vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
 			bufsize, fmt);
-		return 1;
-	}
 
-	if (memcmp(test_buffer, expect, written)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
+	KUNIT_EXPECT_EQ_MSG(kunittest, memcmp(test_buffer, expect, written), 0,
+			"vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
 			bufsize, fmt, test_buffer, written, expect);
-		return 1;
-	}
-	return 0;
 }
 
-static void __printf(3, 4) __init
-__test(const char *expect, int elen, const char *fmt, ...)
+static void __printf(4, 5)
+__test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, ...)
 {
 	va_list ap;
 	int rand;
 	char *p;
 
-	if (elen >= BUF_SIZE) {
-		pr_err("error in test suite: expected output length %d too long. Format was '%s'.\n",
-		       elen, fmt);
-		failed_tests++;
-		return;
-	}
+	KUNIT_EXPECT_LT_MSG(kunittest, elen, BUF_SIZE,
+			"error in test suite: expected output length %d too long. Format was '%s'.\n",
+			elen, fmt);
 
 	va_start(ap, fmt);
 
@@ -112,49 +95,46 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * enough and 0), and then we also test that kvasprintf would
 	 * be able to print it as expected.
 	 */
-	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
+	do_test(kunittest, BUF_SIZE, expect, elen, fmt, ap);
 	rand = 1 + prandom_u32_max(elen+1);
 	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
-	failed_tests += do_test(rand, expect, elen, fmt, ap);
-	failed_tests += do_test(0, expect, elen, fmt, ap);
+	do_test(kunittest, rand, expect, elen, fmt, ap);
+	do_test(kunittest, 0, expect, elen, fmt, ap);
 
 	p = kvasprintf(GFP_KERNEL, fmt, ap);
 	if (p) {
-		total_tests++;
-		if (memcmp(p, expect, elen+1)) {
-			pr_warn("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
+		KUNIT_EXPECT_EQ_MSG(kunittest, memcmp(p, expect, elen+1), 0,
+				"kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
 				fmt, p, expect);
-			failed_tests++;
-		}
 		kfree(p);
 	}
 	va_end(ap);
 }
 
-#define test(expect, fmt, ...)					\
-	__test(expect, strlen(expect), fmt, ##__VA_ARGS__)
+#define test(kunittest, expect, fmt, ...)					\
+	__test(kunittest, expect, strlen(expect), fmt, ##__VA_ARGS__)
 
-static void __init
-test_basic(void)
+static void
+test_basic(struct kunit *kunittest)
 {
 	/* Work around annoying "warning: zero-length gnu_printf format string". */
 	char nul = '\0';
 
-	test("", &nul);
-	test("100%", "100%%");
-	test("xxx%yyy", "xxx%cyyy", '%');
-	__test("xxx\0yyy", 7, "xxx%cyyy", '\0');
+	test(kunittest, "", &nul);
+	test(kunittest, "100%", "100%%");
+	test(kunittest, "xxx%yyy", "xxx%cyyy", '%');
+	__test(kunittest, "xxx\0yyy", 7, "xxx%cyyy", '\0');
 }
 
-static void __init
-test_number(void)
+static void
+test_number(struct kunit *kunittest)
 {
-	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
-	test("  0x1234abcd", "%#12x", 0x1234abcd);
-	test("0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|% d", 0, 1, 12, 123, 1234, -123, -1234);
-	test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
-	test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
-	test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
+	test(kunittest, "0x1234abcd  ", "%#-12x", 0x1234abcd);
+	test(kunittest, "  0x1234abcd", "%#12x", 0x1234abcd);
+	test(kunittest, "0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|% d", 0, 1, 12, 123, 1234, -123, -1234);
+	test(kunittest, "0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
+	test(kunittest, "0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
+	test(kunittest, "2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
 	/*
 	 * POSIX/C99: »The result of converting zero with an explicit
 	 * precision of zero shall be no characters.« Hence the output
@@ -163,7 +143,7 @@ test_number(void)
 	 * case. This test case simply documents the current
 	 * behaviour.
 	 */
-	test("00|0|0|0|0", "%.2d|%.1d|%.0d|%.*d|%1.0d", 0, 0, 0, 0, 0, 0);
+	test(kunittest, "00|0|0|0|0", "%.2d|%.1d|%.0d|%.*d|%1.0d", 0, 0, 0, 0, 0, 0);
 #ifndef __CHAR_UNSIGNED__
 	{
 		/*
@@ -173,19 +153,19 @@ test_number(void)
 		 * with 0xff or cast to u8.
 		 */
 		char val = -16;
-		test("0xfffffff0|0xf0|0xf0", "%#02x|%#02x|%#02x", val, val & 0xff, (u8)val);
+		test(kunittest, "0xfffffff0|0xf0|0xf0", "%#02x|%#02x|%#02x", val, val & 0xff, (u8)val);
 	}
 #endif
 }
 
-static void __init
-test_string(void)
+static void
+test_string(struct kunit *kunittest)
 {
-	test("", "%s%.0s", "", "123");
-	test("ABCD|abc|123", "%s|%.3s|%.*s", "ABCD", "abcdef", 3, "123456");
-	test("1  |  2|3  |  4|5  ", "%-3s|%3s|%-*s|%*s|%*s", "1", "2", 3, "3", 3, "4", -3, "5");
-	test("1234      ", "%-10.4s", "123456");
-	test("      1234", "%10.4s", "123456");
+	test(kunittest, "", "%s%.0s", "", "123");
+	test(kunittest, "ABCD|abc|123", "%s|%.3s|%.*s", "ABCD", "abcdef", 3, "123456");
+	test(kunittest, "1  |  2|3  |  4|5  ", "%-3s|%3s|%-*s|%*s|%*s", "1", "2", 3, "3", 3, "4", -3, "5");
+	test(kunittest, "1234      ", "%-10.4s", "123456");
+	test(kunittest, "      1234", "%10.4s", "123456");
 	/*
 	 * POSIX and C99 say that a negative precision (which is only
 	 * possible to pass via a * argument) should be treated as if
@@ -199,10 +179,10 @@ test_string(void)
 	 * anyone ever feel the need to follow the standards more
 	 * closely, this can be revisited.
 	 */
-	test("    ", "%4.*s", -5, "123456");
-	test("123456", "%.s", "123456");
-	test("a||", "%.s|%.0s|%.*s", "a", "b", 0, "c");
-	test("a  |   |   ", "%-3.s|%-3.0s|%-3.*s", "a", "b", 0, "c");
+	test(kunittest, "    ", "%4.*s", -5, "123456");
+	test(kunittest, "123456", "%.s", "123456");
+	test(kunittest, "a||", "%.s|%.0s|%.*s", "a", "b", 0, "c");
+	test(kunittest, "a  |   |   ", "%-3.s|%-3.0s|%-3.*s", "a", "b", 0, "c");
 }
 
 #define PLAIN_BUF_SIZE 64	/* leave some space so we don't oops */
@@ -216,7 +196,7 @@ test_string(void)
 #define ZEROS "00000000"	/* hex 32 zero bits */
 #define ONES "ffffffff"		/* hex 32 one bits */
 
-static int __init
+static int
 plain_format(void)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -248,7 +228,7 @@ plain_format(void)
 #define ZEROS ""
 #define ONES ""
 
-static int __init
+static int
 plain_format(void)
 {
 	/* Format is implicitly tested for 32 bit machines by plain_hash() */
@@ -257,7 +237,7 @@ plain_format(void)
 
 #endif	/* BITS_PER_LONG == 64 */
 
-static int __init
+static int
 plain_hash_to_buffer(const void *p, char *buf, size_t len)
 {
 	int nchars;
@@ -276,7 +256,7 @@ plain_hash_to_buffer(const void *p, char *buf, size_t len)
 	return 0;
 }
 
-static int __init
+static int
 plain_hash(void)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -296,27 +276,20 @@ plain_hash(void)
  * We can't use test() to test %p because we don't know what output to expect
  * after an address is hashed.
  */
-static void __init
-plain(void)
+static void
+plain(struct kunit *kunittest)
 {
 	int err;
 
 	err = plain_hash();
-	if (err) {
-		pr_warn("plain 'p' does not appear to be hashed\n");
-		failed_tests++;
-		return;
-	}
+	KUNIT_EXPECT_EQ_MSG(kunittest, err, 0, "plain 'p' does not appear to be hashed\n");
 
 	err = plain_format();
-	if (err) {
-		pr_warn("hashing plain 'p' has unexpected format\n");
-		failed_tests++;
-	}
+	KUNIT_EXPECT_EQ_MSG(kunittest, err, 0, "hashing plain 'p' has unexpected format\n");
 }
 
-static void __init
-test_hashed(const char *fmt, const void *p)
+static void
+test_hashed(struct kunit *kunittest, const char *fmt, const void *p)
 {
 	char buf[PLAIN_BUF_SIZE];
 	int ret;
@@ -329,92 +302,92 @@ test_hashed(const char *fmt, const void *p)
 	if (ret)
 		return;
 
-	test(buf, fmt, p);
+	test(kunittest, buf, fmt, p);
 }
 
 /*
  * NULL pointers aren't hashed.
  */
-static void __init
-null_pointer(void)
+static void
+null_pointer(struct kunit *kunittest)
 {
-	test(ZEROS "00000000", "%p", NULL);
-	test(ZEROS "00000000", "%px", NULL);
-	test("(null)", "%pE", NULL);
+	test(kunittest, ZEROS "00000000", "%p", NULL);
+	test(kunittest, ZEROS "00000000", "%px", NULL);
+	test(kunittest, "(null)", "%pE", NULL);
 }
 
 /*
  * Error pointers aren't hashed.
  */
-static void __init
-error_pointer(void)
+static void
+error_pointer(struct kunit *kunittest)
 {
-	test(ONES "fffffff5", "%p", ERR_PTR(-11));
-	test(ONES "fffffff5", "%px", ERR_PTR(-11));
-	test("(efault)", "%pE", ERR_PTR(-11));
+	test(kunittest, ONES "fffffff5", "%p", ERR_PTR(-11));
+	test(kunittest, ONES "fffffff5", "%px", ERR_PTR(-11));
+	test(kunittest, "(efault)", "%pE", ERR_PTR(-11));
 }
 
 #define PTR_INVALID ((void *)0x000000ab)
 
-static void __init
-invalid_pointer(void)
+static void
+invalid_pointer(struct kunit *kunittest)
 {
-	test_hashed("%p", PTR_INVALID);
-	test(ZEROS "000000ab", "%px", PTR_INVALID);
-	test("(efault)", "%pE", PTR_INVALID);
+	test_hashed(kunittest, "%p", PTR_INVALID);
+	test(kunittest, ZEROS "000000ab", "%px", PTR_INVALID);
+	test(kunittest, "(efault)", "%pE", PTR_INVALID);
 }
 
-static void __init
-symbol_ptr(void)
+static void
+symbol_ptr(struct kunit *kunittest)
 {
 }
 
-static void __init
-kernel_ptr(void)
+static void
+kernel_ptr(struct kunit *kunittest)
 {
 	/* We can't test this without access to kptr_restrict. */
 }
 
-static void __init
-struct_resource(void)
+static void
+struct_resource(struct kunit *kunittest)
 {
 }
 
-static void __init
-addr(void)
+static void
+addr(struct kunit *kunittest)
 {
 }
 
-static void __init
-escaped_str(void)
+static void
+escaped_str(struct kunit *kunittest)
 {
 }
 
-static void __init
-hex_string(void)
+static void
+hex_string(struct kunit *kunittest)
 {
 	const char buf[3] = {0xc0, 0xff, 0xee};
 
-	test("c0 ff ee|c0:ff:ee|c0-ff-ee|c0ffee",
+	test(kunittest, "c0 ff ee|c0:ff:ee|c0-ff-ee|c0ffee",
 	     "%3ph|%3phC|%3phD|%3phN", buf, buf, buf, buf);
-	test("c0 ff ee|c0:ff:ee|c0-ff-ee|c0ffee",
+	test(kunittest, "c0 ff ee|c0:ff:ee|c0-ff-ee|c0ffee",
 	     "%*ph|%*phC|%*phD|%*phN", 3, buf, 3, buf, 3, buf, 3, buf);
 }
 
-static void __init
-mac(void)
+static void
+mac(struct kunit *kunittest)
 {
 	const u8 addr[6] = {0x2d, 0x48, 0xd6, 0xfc, 0x7a, 0x05};
 
-	test("2d:48:d6:fc:7a:05", "%pM", addr);
-	test("05:7a:fc:d6:48:2d", "%pMR", addr);
-	test("2d-48-d6-fc-7a-05", "%pMF", addr);
-	test("2d48d6fc7a05", "%pm", addr);
-	test("057afcd6482d", "%pmR", addr);
+	test(kunittest, "2d:48:d6:fc:7a:05", "%pM", addr);
+	test(kunittest, "05:7a:fc:d6:48:2d", "%pMR", addr);
+	test(kunittest, "2d-48-d6-fc-7a-05", "%pMF", addr);
+	test(kunittest, "2d48d6fc7a05", "%pm", addr);
+	test(kunittest, "057afcd6482d", "%pmR", addr);
 }
 
-static void __init
-ip4(void)
+static void
+ip4(struct kunit *kunittest)
 {
 	struct sockaddr_in sa;
 
@@ -422,34 +395,34 @@ ip4(void)
 	sa.sin_port = cpu_to_be16(12345);
 	sa.sin_addr.s_addr = cpu_to_be32(0x7f000001);
 
-	test("127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
-	test("127.000.000.001|127.0.0.1", "%piS|%pIS", &sa, &sa);
+	test(kunittest, "127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
+	test(kunittest, "127.000.000.001|127.0.0.1", "%piS|%pIS", &sa, &sa);
 	sa.sin_addr.s_addr = cpu_to_be32(0x01020304);
-	test("001.002.003.004:12345|1.2.3.4:12345", "%piSp|%pISp", &sa, &sa);
+	test(kunittest, "001.002.003.004:12345|1.2.3.4:12345", "%piSp|%pISp", &sa, &sa);
 }
 
-static void __init
-ip6(void)
+static void
+ip6(struct kunit *kunittest)
 {
 }
 
-static void __init
-ip(void)
+static void
+ip(struct kunit *kunittest)
 {
-	ip4();
-	ip6();
+	ip4(kunittest);
+	ip6(kunittest);
 }
 
-static void __init
-uuid(void)
+static void
+uuid(struct kunit *kunittest)
 {
 	const char uuid[16] = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
 			       0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf};
 
-	test("00010203-0405-0607-0809-0a0b0c0d0e0f", "%pUb", uuid);
-	test("00010203-0405-0607-0809-0A0B0C0D0E0F", "%pUB", uuid);
-	test("03020100-0504-0706-0809-0a0b0c0d0e0f", "%pUl", uuid);
-	test("03020100-0504-0706-0809-0A0B0C0D0E0F", "%pUL", uuid);
+	test(kunittest, "00010203-0405-0607-0809-0a0b0c0d0e0f", "%pUb", uuid);
+	test(kunittest, "00010203-0405-0607-0809-0A0B0C0D0E0F", "%pUB", uuid);
+	test(kunittest, "03020100-0504-0706-0809-0a0b0c0d0e0f", "%pUl", uuid);
+	test(kunittest, "03020100-0504-0706-0809-0A0B0C0D0E0F", "%pUL", uuid);
 }
 
 static struct dentry test_dentry[4] __initdata = {
@@ -467,34 +440,34 @@ static struct dentry test_dentry[4] __initdata = {
 	  .d_iname = "romeo" },
 };
 
-static void __init
-dentry(void)
+static void
+dentry(struct kunit *kunittest)
 {
-	test("foo", "%pd", &test_dentry[0]);
-	test("foo", "%pd2", &test_dentry[0]);
+	test(kunittest, "foo", "%pd", &test_dentry[0]);
+	test(kunittest, "foo", "%pd2", &test_dentry[0]);
 
-	test("(null)", "%pd", NULL);
-	test("(efault)", "%pd", PTR_INVALID);
-	test("(null)", "%pD", NULL);
-	test("(efault)", "%pD", PTR_INVALID);
+	test(kunittest, "(null)", "%pd", NULL);
+	test(kunittest, "(efault)", "%pd", PTR_INVALID);
+	test(kunittest, "(null)", "%pD", NULL);
+	test(kunittest, "(efault)", "%pD", PTR_INVALID);
 
-	test("romeo", "%pd", &test_dentry[3]);
-	test("alfa/romeo", "%pd2", &test_dentry[3]);
-	test("bravo/alfa/romeo", "%pd3", &test_dentry[3]);
-	test("/bravo/alfa/romeo", "%pd4", &test_dentry[3]);
-	test("/bravo/alfa", "%pd4", &test_dentry[2]);
+	test(kunittest, "romeo", "%pd", &test_dentry[3]);
+	test(kunittest, "alfa/romeo", "%pd2", &test_dentry[3]);
+	test(kunittest, "bravo/alfa/romeo", "%pd3", &test_dentry[3]);
+	test(kunittest, "/bravo/alfa/romeo", "%pd4", &test_dentry[3]);
+	test(kunittest, "/bravo/alfa", "%pd4", &test_dentry[2]);
 
-	test("bravo/alfa  |bravo/alfa  ", "%-12pd2|%*pd2", &test_dentry[2], -12, &test_dentry[2]);
-	test("  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
+	test(kunittest, "bravo/alfa  |bravo/alfa  ", "%-12pd2|%*pd2", &test_dentry[2], -12, &test_dentry[2]);
+	test(kunittest, "  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
 }
 
-static void __init
-struct_va_format(void)
+static void
+struct_va_format(struct kunit *kunittest)
 {
 }
 
-static void __init
-time_and_date(void)
+static void
+time_and_date(struct kunit *kunittest)
 {
 	/* 1543210543 */
 	const struct rtc_time tm = {
@@ -508,27 +481,27 @@ time_and_date(void)
 	/* 2019-01-04T15:32:23 */
 	time64_t t = 1546615943;
 
-	test("(%pt?)", "%pt", &tm);
-	test("2018-11-26T05:35:43", "%ptR", &tm);
-	test("0118-10-26T05:35:43", "%ptRr", &tm);
-	test("05:35:43|2018-11-26", "%ptRt|%ptRd", &tm, &tm);
-	test("05:35:43|0118-10-26", "%ptRtr|%ptRdr", &tm, &tm);
-	test("05:35:43|2018-11-26", "%ptRttr|%ptRdtr", &tm, &tm);
-	test("05:35:43 tr|2018-11-26 tr", "%ptRt tr|%ptRd tr", &tm, &tm);
+	test(kunittest, "(%pt?)", "%pt", &tm);
+	test(kunittest, "2018-11-26T05:35:43", "%ptR", &tm);
+	test(kunittest, "0118-10-26T05:35:43", "%ptRr", &tm);
+	test(kunittest, "05:35:43|2018-11-26", "%ptRt|%ptRd", &tm, &tm);
+	test(kunittest, "05:35:43|0118-10-26", "%ptRtr|%ptRdr", &tm, &tm);
+	test(kunittest, "05:35:43|2018-11-26", "%ptRttr|%ptRdtr", &tm, &tm);
+	test(kunittest, "05:35:43 tr|2018-11-26 tr", "%ptRt tr|%ptRd tr", &tm, &tm);
 
-	test("2019-01-04T15:32:23", "%ptT", &t);
-	test("0119-00-04T15:32:23", "%ptTr", &t);
-	test("15:32:23|2019-01-04", "%ptTt|%ptTd", &t, &t);
-	test("15:32:23|0119-00-04", "%ptTtr|%ptTdr", &t, &t);
+	test(kunittest, "2019-01-04T15:32:23", "%ptT", &t);
+	test(kunittest, "0119-00-04T15:32:23", "%ptTr", &t);
+	test(kunittest, "15:32:23|2019-01-04", "%ptTt|%ptTd", &t, &t);
+	test(kunittest, "15:32:23|0119-00-04", "%ptTtr|%ptTdr", &t, &t);
 }
 
-static void __init
-struct_clk(void)
+static void
+struct_clk(struct kunit *kunittest)
 {
 }
 
-static void __init
-large_bitmap(void)
+static void
+large_bitmap(struct kunit *kunittest)
 {
 	const int nbits = 1 << 16;
 	unsigned long *bits = bitmap_zalloc(nbits, GFP_KERNEL);
@@ -537,69 +510,69 @@ large_bitmap(void)
 
 	bitmap_set(bits, 1, 20);
 	bitmap_set(bits, 60000, 15);
-	test("1-20,60000-60014", "%*pbl", nbits, bits);
+	test(kunittest, "1-20,60000-60014", "%*pbl", nbits, bits);
 	bitmap_free(bits);
 }
 
-static void __init
-bitmap(void)
+static void
+bitmap(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(bits, 20);
 	const int primes[] = {2,3,5,7,11,13,17,19};
 	int i;
 
 	bitmap_zero(bits, 20);
-	test("00000|00000", "%20pb|%*pb", bits, 20, bits);
-	test("|", "%20pbl|%*pbl", bits, 20, bits);
+	test(kunittest, "00000|00000", "%20pb|%*pb", bits, 20, bits);
+	test(kunittest, "|", "%20pbl|%*pbl", bits, 20, bits);
 
 	for (i = 0; i < ARRAY_SIZE(primes); ++i)
 		set_bit(primes[i], bits);
-	test("a28ac|a28ac", "%20pb|%*pb", bits, 20, bits);
-	test("2-3,5,7,11,13,17,19|2-3,5,7,11,13,17,19", "%20pbl|%*pbl", bits, 20, bits);
+	test(kunittest, "a28ac|a28ac", "%20pb|%*pb", bits, 20, bits);
+	test(kunittest, "2-3,5,7,11,13,17,19|2-3,5,7,11,13,17,19", "%20pbl|%*pbl", bits, 20, bits);
 
 	bitmap_fill(bits, 20);
-	test("fffff|fffff", "%20pb|%*pb", bits, 20, bits);
-	test("0-19|0-19", "%20pbl|%*pbl", bits, 20, bits);
+	test(kunittest, "fffff|fffff", "%20pb|%*pb", bits, 20, bits);
+	test(kunittest, "0-19|0-19", "%20pbl|%*pbl", bits, 20, bits);
 
-	large_bitmap();
+	large_bitmap(kunittest);
 }
 
-static void __init
-netdev_features(void)
+static void
+netdev_features(struct kunit *kunittest)
 {
 }
 
-static void __init
-flags(void)
+static void
+flags(struct kunit *kunittest)
 {
 	unsigned long flags;
 	gfp_t gfp;
 	char *cmp_buffer;
 
 	flags = 0;
-	test("", "%pGp", &flags);
+	test(kunittest, "", "%pGp", &flags);
 
 	/* Page flags should filter the zone id */
 	flags = 1UL << NR_PAGEFLAGS;
-	test("", "%pGp", &flags);
+	test(kunittest, "", "%pGp", &flags);
 
 	flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
 		| 1UL << PG_active | 1UL << PG_swapbacked;
-	test("uptodate|dirty|lru|active|swapbacked", "%pGp", &flags);
+	test(kunittest, "uptodate|dirty|lru|active|swapbacked", "%pGp", &flags);
 
 
 	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC
 			| VM_DENYWRITE;
-	test("read|exec|mayread|maywrite|mayexec|denywrite", "%pGv", &flags);
+	test(kunittest, "read|exec|mayread|maywrite|mayexec|denywrite", "%pGv", &flags);
 
 	gfp = GFP_TRANSHUGE;
-	test("GFP_TRANSHUGE", "%pGg", &gfp);
+	test(kunittest, "GFP_TRANSHUGE", "%pGg", &gfp);
 
 	gfp = GFP_ATOMIC|__GFP_DMA;
-	test("GFP_ATOMIC|GFP_DMA", "%pGg", &gfp);
+	test(kunittest, "GFP_ATOMIC|GFP_DMA", "%pGg", &gfp);
 
 	gfp = __GFP_ATOMIC;
-	test("__GFP_ATOMIC", "%pGg", &gfp);
+	test(kunittest, "__GFP_ATOMIC", "%pGg", &gfp);
 
 	cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
 	if (!cmp_buffer)
@@ -608,17 +581,17 @@ flags(void)
 	/* Any flags not translated by the table should remain numeric */
 	gfp = ~__GFP_BITS_MASK;
 	snprintf(cmp_buffer, BUF_SIZE, "%#lx", (unsigned long) gfp);
-	test(cmp_buffer, "%pGg", &gfp);
+	test(kunittest, cmp_buffer, "%pGg", &gfp);
 
 	snprintf(cmp_buffer, BUF_SIZE, "__GFP_ATOMIC|%#lx",
 							(unsigned long) gfp);
 	gfp |= __GFP_ATOMIC;
-	test(cmp_buffer, "%pGg", &gfp);
+	test(kunittest, cmp_buffer, "%pGg", &gfp);
 
 	kfree(cmp_buffer);
 }
 
-static void __init fwnode_pointer(void)
+static void fwnode_pointer(struct kunit *kunittest)
 {
 	const struct software_node softnodes[] = {
 		{ .name = "first", },
@@ -638,79 +611,90 @@ static void __init fwnode_pointer(void)
 		return;
 	}
 
-	test(full_name_second, "%pfw", software_node_fwnode(&softnodes[1]));
-	test(full_name, "%pfw", software_node_fwnode(&softnodes[2]));
-	test(full_name, "%pfwf", software_node_fwnode(&softnodes[2]));
-	test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
-	test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
+	test(kunittest, full_name_second, "%pfw", software_node_fwnode(&softnodes[1]));
+	test(kunittest, full_name, "%pfw", software_node_fwnode(&softnodes[2]));
+	test(kunittest, full_name, "%pfwf", software_node_fwnode(&softnodes[2]));
+	test(kunittest, second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
+	test(kunittest, third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
 
 	software_node_unregister(&softnodes[2]);
 	software_node_unregister(&softnodes[1]);
 	software_node_unregister(&softnodes[0]);
 }
 
-static void __init
-errptr(void)
+static void
+errptr(struct kunit *kunittest)
 {
-	test("-1234", "%pe", ERR_PTR(-1234));
+	test(kunittest, "-1234", "%pe", ERR_PTR(-1234));
 
 	/* Check that %pe with a non-ERR_PTR gets treated as ordinary %p. */
 	BUILD_BUG_ON(IS_ERR(PTR));
-	test_hashed("%pe", PTR);
+	test_hashed(kunittest, "%pe", PTR);
 
 #ifdef CONFIG_SYMBOLIC_ERRNAME
-	test("(-ENOTSOCK)", "(%pe)", ERR_PTR(-ENOTSOCK));
-	test("(-EAGAIN)", "(%pe)", ERR_PTR(-EAGAIN));
+	test(kunittest, "(-ENOTSOCK)", "(%pe)", ERR_PTR(-ENOTSOCK));
+	test(kunittest, "(-EAGAIN)", "(%pe)", ERR_PTR(-EAGAIN));
 	BUILD_BUG_ON(EAGAIN != EWOULDBLOCK);
-	test("(-EAGAIN)", "(%pe)", ERR_PTR(-EWOULDBLOCK));
-	test("[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
-	test("[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
-	test("-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
+	test(kunittest, "(-EAGAIN)", "(%pe)", ERR_PTR(-EWOULDBLOCK));
+	test(kunittest, "[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
+	test(kunittest, "[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
+	test(kunittest, "-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
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
+static void
+test_pointer(struct kunit *kunittest)
+{
+	plain(kunittest);
+	null_pointer(kunittest);
+	error_pointer(kunittest);
+	invalid_pointer(kunittest);
+	symbol_ptr(kunittest);
+	kernel_ptr(kunittest);
+	struct_resource(kunittest);
+	addr(kunittest);
+	escaped_str(kunittest);
+	hex_string(kunittest);
+	mac(kunittest);
+	ip(kunittest);
+	uuid(kunittest);
+	dentry(kunittest);
+	struct_va_format(kunittest);
+	time_and_date(kunittest);
+	struct_clk(kunittest);
+	bitmap(kunittest);
+	netdev_features(kunittest);
+	flags(kunittest);
+	errptr(kunittest);
+	fwnode_pointer(kunittest);
+}
+
+static void selftest(struct kunit *kunittest)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
 	if (!alloced_buffer)
 		return;
 	test_buffer = alloced_buffer + PAD_SIZE;
 
-	test_basic();
-	test_number();
-	test_string();
-	test_pointer();
+	test_basic(kunittest);
+	test_number(kunittest);
+	test_string(kunittest);
+	test_pointer(kunittest);
 
 	kfree(alloced_buffer);
 }
 
-KSTM_MODULE_LOADERS(test_printf);
+static struct kunit_case printf_test_cases[] = {
+	KUNIT_CASE(selftest),
+	{}
+};
+
+static struct kunit_suite printf_test_suite = {
+	.name = "printf-kunit-test",
+	.test_cases = printf_test_cases,
+};
+
+kunit_test_suite(printf_test_suite);
+
 MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
 MODULE_LICENSE("GPL");
-- 
2.25.1

