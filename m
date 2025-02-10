Return-Path: <linux-kselftest+bounces-26201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392CBA2F6D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96C4166437
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194592566E6;
	Mon, 10 Feb 2025 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W73DEbYp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF124418C;
	Mon, 10 Feb 2025 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211809; cv=none; b=Ptin9UliW4Wzh9IkYbzai9JxnKx8PE5X3YbmDPCyaCoY0e5qwahgDuYj2f2YdFkaVxBxJl17qL0D/bAFaCQmAWZ4uCrNcoikHIkzgtCc+FMNfjz2hq/KBGd7Z47gTHxL+3Zhz2Ri8+mb4kYAZvK6Dp8WS+XZf5djhS2HGW7RWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211809; c=relaxed/simple;
	bh=UZkfFSNYCZAx5DmgWi+2NjYCrpNBFnsjIfsdna9v4F0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gekjCgg6t6bhNvv5PbhhPaKa8hLqj81ppOd8UTdmUVE24TfebOosZ9zfuthS8s8HseYlGMSsrm+wQHTU9/VgCY4nOlk51r1MnJVNlsjUzKAj/HyK/EE5GUoE7cUj7pae00nroIj2sxkr7dFevAmS41GVjE9LdcExsKZRBnjrOCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W73DEbYp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c05049e67aso115093285a.1;
        Mon, 10 Feb 2025 10:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739211806; x=1739816606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3v4ANujmxu6CWQRkG6kqnE3P9esw8uaBMGeMsGsmVo=;
        b=W73DEbYpeQ/G0FYk2/NcwQdYSq/YPcm0qrTh9qaHyz2nEqXwYuI9MWTMpuc6OLvCoY
         zry4Cm3I9EXSyBum53LaDesQMD/bDRJ8XnurrZQ7rEbD4UuwU7liN1ndzn2ExarRtEhI
         5dlu7XhlHxyB8G514+IXs07sOVvHJLpgnasLQJ4K6xvUInEVG0VtFcxXq6dhOajFEj/B
         Lgi1uXXjLU4tQetFOruswLs0ysu02hqs4Zq6Pu2oxDycz8qJDUjokjMTmp0H6rtuGLhW
         d3slbowb9DLbp/jyb3bkxr9E58U+vbNTFAEw7V274oleUvDHLLXpizXEZ7xU7X8+oxrF
         LfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211806; x=1739816606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3v4ANujmxu6CWQRkG6kqnE3P9esw8uaBMGeMsGsmVo=;
        b=pOWORtrFNCxJluscDORwYLqju60DORmAM6K0N5JG5GcSbG0HIcbu5UxxmwgTuX9QhX
         pEpJBTZGcyMVFfEaEROy2CFuboAx6qtPXuiSHr67Znsi28D0ff2veOx+RuYlxukY1YwV
         lnhyRZjFj82AwZEOBq2Tibhd2EywsPDDC4nc28XY2XrV5QOMsOEbN+/iwbnubsbvoNZb
         yTPBMHQo3MrzO5feX75i6PeNLcBq4jKZQxFOAfdehxN0guK7MjFucx1ePzXirZ5uoWgq
         iz5b6uLxHGMDUXP2d3dJaxE5Rbq+jMCfm+s7MvVY4q5DP7sin/dPpg/1S7wBYO0UQBCK
         I/ew==
X-Forwarded-Encrypted: i=1; AJvYcCVvMtcHkom6VDwaBozP2SwaZqyHSL4WGh3L35Rm01tHw7O9YVbmuRUZV/g+tyQoehuRLwOy2L2Jqh0=@vger.kernel.org, AJvYcCXC7xnthw/vtKwPfX8rsXFlFfkX+kcmPAKNz4YxF9KW96VSPggwpxUIrxsJVtHK/UGjUAxfR1jcD3s2DfMge2We@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1RY0KknxNHilrUHBiRroHTv8KEsqytgomnzAa48DfsT1ZDOjD
	K0UhkmMmSRPzbclS9uMEwbqwBZCG/jMSNF8Ch96Y4ha/NlJ5gSic7tN0mawm
X-Gm-Gg: ASbGncvep2jRt7NnJrSFZ+BwDSfbV1GHuXVWmHZPNFHmj0rJeKxU1mg9Hh0e09ylxMj
	ro6BBqiMimBlzAg/ogqRGFttMtr2H1fa4nIyqkiabaKJ1TwfbEf54UAZzxplAGbfTZxaO3Pb3lN
	Q2RWwup/8HrkXyZx0Mxt6dQi3c/f12XbktPoY6tQ/Wkw5fg1Xv/fZbFQf7FBiPBkZx6JHlpNgTw
	bomHGI0l9fwi7Zk8DRuFYzFbPVLIFSWgSgVJivLB1X/F8LkEDYE7GmLlCVA2zGrPabJ7RteI5cY
	XpvHx+ZsEyg3dM0ZEiRgZJh7ZRpO1aukzSetLHFceIp7psDu0Zgp0R+bbCyI+Fi8/kL5NnpS6i8
	ctqzwX3DxUl6j5XRTbckzKFbH
X-Google-Smtp-Source: AGHT+IE3cHJw4fcQzZaPidyu97RASbfhQI0WBS76SceZ4bB3QCvsAndFt3iCzGzHKu1b02HYzlm0tg==
X-Received: by 2002:ad4:5f89:0:b0:6e4:3faf:3647 with SMTP id 6a1803df08f44-6e4455e96b9mr189544946d6.15.1739211805448;
        Mon, 10 Feb 2025 10:23:25 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:cc94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e440d902d3sm45436456d6.7.2025.02.10.10.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:23:25 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 13:23:22 -0500
Subject: [PATCH v3 1/2] printf: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-printf-kunit-convert-v3-1-ee6ac5500f5e@gmail.com>
References: <20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com>
In-Reply-To: <20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com>
To: Arpitha Raghunandan <98.arpi@gmail.com>, 
 David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linuxppc-dev@lists.ozlabs.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Convert the printf() self-test to a KUnit test.

In the interest of keeping the patch reasonably-sized this doesn't
refactor the tests into proper parameterized tests - it's all one big
test case.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Documentation/core-api/printk-formats.rst |   2 +-
 MAINTAINERS                               |   2 +-
 lib/Kconfig.debug                         |  12 +-
 lib/Makefile                              |   2 +-
 lib/{test_printf.c => printf_kunit.c}     | 188 +++++++++++++++++-------------
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/printf.sh     |   4 -
 7 files changed, 116 insertions(+), 95 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ecccc0473da9..0d9461bd6964 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -661,7 +661,7 @@ Do *not* use it from C.
 Thanks
 ======
 
-If you add other %p extensions, please extend <lib/test_printf.c> with
+If you add other %p extensions, please extend <lib/printf_kunit.c> with
 one or more test cases, if at all feasible.
 
 Thank you for your cooperation and attention.
diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..2d58914c7dd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25411,7 +25411,7 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/core-api/printk-formats.rst
-F:	lib/test_printf.c
+F:	lib/printf_kunit.c
 F:	lib/test_scanf.c
 F:	lib/vsprintf.c
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..9f1e0d3513fb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2427,6 +2427,15 @@ config ASYNC_RAID6_TEST
 config TEST_HEXDUMP
 	tristate "Test functions located in the hexdump module at runtime"
 
+config PRINTF_KUNIT_TEST
+	tristate "KUnit test printf() family of functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the printf functions at runtime.
+
+	  If unsure, say N.
+
 config STRING_KUNIT_TEST
 	tristate "KUnit test string functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
@@ -2440,9 +2449,6 @@ config STRING_HELPERS_KUNIT_TEST
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
-config TEST_PRINTF
-	tristate "Test printf() family of functions at runtime"
-
 config TEST_SCANF
 	tristate "Test scanf() family of functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..844665b1f0e7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -84,7 +84,7 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
-obj-$(CONFIG_TEST_PRINTF) += test_printf.o
+obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
diff --git a/lib/test_printf.c b/lib/printf_kunit.c
similarity index 87%
rename from lib/test_printf.c
rename to lib/printf_kunit.c
index 59dbe4f9a4cb..287bbfb61148 100644
--- a/lib/test_printf.c
+++ b/lib/printf_kunit.c
@@ -3,9 +3,7 @@
  * Test cases for printf facility.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
+#include <kunit/test.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/printk.h>
@@ -25,8 +23,6 @@
 
 #include <linux/property.h>
 
-#include "../tools/testing/selftests/kselftest_module.h"
-
 #define BUF_SIZE 256
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
@@ -37,12 +33,17 @@
 	block \
 	__diag_pop();
 
-KSTM_MODULE_GLOBALS();
+static unsigned int total_tests;
+
+static char *test_buffer;
+static char *alloced_buffer;
+
+static struct kunit *kunittest;
 
-static char *test_buffer __initdata;
-static char *alloced_buffer __initdata;
+#define tc_fail(fmt, ...) \
+	KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
 
-static int __printf(4, 0) __init
+static void __printf(4, 0)
 do_test(int bufsize, const char *expect, int elen,
 	const char *fmt, va_list ap)
 {
@@ -57,52 +58,50 @@ do_test(int bufsize, const char *expect, int elen,
 	va_end(aq);
 
 	if (ret != elen) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d",
 			bufsize, fmt, ret, elen);
-		return 1;
+		return;
 	}
 
 	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n", bufsize, fmt);
-		return 1;
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote before buffer",
+			bufsize, fmt);
+		return;
 	}
 
 	if (!bufsize) {
 		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
-			pr_warn("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
-				fmt);
-			return 1;
+			tc_fail("vsnprintf(buf, 0, \"%s\", ...) wrote to buffer", fmt);
 		}
-		return 0;
+		return;
 	}
 
 	written = min(bufsize-1, elen);
 	if (test_buffer[written]) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer",
 			bufsize, fmt);
-		return 1;
+		return;
 	}
 
 	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator",
 			bufsize, fmt);
-		return 1;
+		return;
 	}
 
 	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
-		return 1;
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer", bufsize, fmt);
+		return;
 	}
 
 	if (memcmp(test_buffer, expect, written)) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
+		tc_fail("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'",
 			bufsize, fmt, test_buffer, written, expect);
-		return 1;
+		return;
 	}
-	return 0;
 }
 
-static void __printf(3, 4) __init
+static void __printf(3, 4)
 __test(const char *expect, int elen, const char *fmt, ...)
 {
 	va_list ap;
@@ -110,9 +109,8 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	char *p;
 
 	if (elen >= BUF_SIZE) {
-		pr_err("error in test suite: expected output length %d too long. Format was '%s'.\n",
-		       elen, fmt);
-		failed_tests++;
+		tc_fail("error in test suite: expected output length %d too long. Format was '%s'.",
+			elen, fmt);
 		return;
 	}
 
@@ -124,19 +122,18 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * enough and 0), and then we also test that kvasprintf would
 	 * be able to print it as expected.
 	 */
-	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
+	do_test(BUF_SIZE, expect, elen, fmt, ap);
 	rand = get_random_u32_inclusive(1, elen + 1);
 	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
-	failed_tests += do_test(rand, expect, elen, fmt, ap);
-	failed_tests += do_test(0, expect, elen, fmt, ap);
+	do_test(rand, expect, elen, fmt, ap);
+	do_test(0, expect, elen, fmt, ap);
 
 	p = kvasprintf(GFP_KERNEL, fmt, ap);
 	if (p) {
 		total_tests++;
 		if (memcmp(p, expect, elen+1)) {
-			pr_warn("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
+			tc_fail("kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'",
 				fmt, p, expect);
-			failed_tests++;
 		}
 		kfree(p);
 	}
@@ -146,7 +143,7 @@ __test(const char *expect, int elen, const char *fmt, ...)
 #define test(expect, fmt, ...)					\
 	__test(expect, strlen(expect), fmt, ##__VA_ARGS__)
 
-static void __init
+static void
 test_basic(void)
 {
 	/* Work around annoying "warning: zero-length gnu_printf format string". */
@@ -158,7 +155,7 @@ test_basic(void)
 	__test("xxx\0yyy", 7, "xxx%cyyy", '\0');
 }
 
-static void __init
+static void
 test_number(void)
 {
 	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
@@ -180,7 +177,7 @@ test_number(void)
 	test("00|0|0|0|0", "%.2d|%.1d|%.0d|%.*d|%1.0d", 0, 0, 0, 0, 0, 0);
 }
 
-static void __init
+static void
 test_string(void)
 {
 	test("", "%s%.0s", "", "123");
@@ -218,7 +215,7 @@ test_string(void)
 #define ZEROS "00000000"	/* hex 32 zero bits */
 #define ONES "ffffffff"		/* hex 32 one bits */
 
-static int __init
+static int
 plain_format(void)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -230,7 +227,7 @@ plain_format(void)
 		return -1;
 
 	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
-		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
+		kunit_warn(kunittest, "crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
 			PTR_VAL_NO_CRNG);
 		return 0;
 	}
@@ -250,7 +247,7 @@ plain_format(void)
 #define ZEROS ""
 #define ONES ""
 
-static int __init
+static int
 plain_format(void)
 {
 	/* Format is implicitly tested for 32 bit machines by plain_hash() */
@@ -259,7 +256,7 @@ plain_format(void)
 
 #endif	/* BITS_PER_LONG == 64 */
 
-static int __init
+static int
 plain_hash_to_buffer(const void *p, char *buf, size_t len)
 {
 	int nchars;
@@ -270,7 +267,7 @@ plain_hash_to_buffer(const void *p, char *buf, size_t len)
 		return -1;
 
 	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
-		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
+		kunit_warn(kunittest, "crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
 			PTR_VAL_NO_CRNG);
 		return 0;
 	}
@@ -278,7 +275,7 @@ plain_hash_to_buffer(const void *p, char *buf, size_t len)
 	return 0;
 }
 
-static int __init
+static int
 plain_hash(void)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -298,32 +295,29 @@ plain_hash(void)
  * We can't use test() to test %p because we don't know what output to expect
  * after an address is hashed.
  */
-static void __init
+static void
 plain(void)
 {
 	int err;
 
 	if (no_hash_pointers) {
-		pr_warn("skipping plain 'p' tests");
-		skipped_tests += 2;
+		kunit_warn(kunittest, "skipping plain 'p' tests");
 		return;
 	}
 
 	err = plain_hash();
 	if (err) {
-		pr_warn("plain 'p' does not appear to be hashed\n");
-		failed_tests++;
+		tc_fail("plain 'p' does not appear to be hashed");
 		return;
 	}
 
 	err = plain_format();
 	if (err) {
-		pr_warn("hashing plain 'p' has unexpected format\n");
-		failed_tests++;
+		tc_fail("hashing plain 'p' has unexpected format");
 	}
 }
 
-static void __init
+static void
 test_hashed(const char *fmt, const void *p)
 {
 	char buf[PLAIN_BUF_SIZE];
@@ -343,7 +337,7 @@ test_hashed(const char *fmt, const void *p)
 /*
  * NULL pointers aren't hashed.
  */
-static void __init
+static void
 null_pointer(void)
 {
 	test(ZEROS "00000000", "%p", NULL);
@@ -354,7 +348,7 @@ null_pointer(void)
 /*
  * Error pointers aren't hashed.
  */
-static void __init
+static void
 error_pointer(void)
 {
 	test(ONES "fffffff5", "%p", ERR_PTR(-11));
@@ -364,7 +358,7 @@ error_pointer(void)
 
 #define PTR_INVALID ((void *)0x000000ab)
 
-static void __init
+static void
 invalid_pointer(void)
 {
 	test_hashed("%p", PTR_INVALID);
@@ -372,18 +366,18 @@ invalid_pointer(void)
 	test("(efault)", "%pE", PTR_INVALID);
 }
 
-static void __init
+static void
 symbol_ptr(void)
 {
 }
 
-static void __init
+static void
 kernel_ptr(void)
 {
 	/* We can't test this without access to kptr_restrict. */
 }
 
-static void __init
+static void
 struct_resource(void)
 {
 	struct resource test_resource = {
@@ -432,7 +426,7 @@ struct_resource(void)
 	     "%pR", &test_resource);
 }
 
-static void __init
+static void
 struct_range(void)
 {
 	struct range test_range = DEFINE_RANGE(0xc0ffee00ba5eba11,
@@ -448,17 +442,17 @@ struct_range(void)
 	     "%pra", &test_range);
 }
 
-static void __init
+static void
 addr(void)
 {
 }
 
-static void __init
+static void
 escaped_str(void)
 {
 }
 
-static void __init
+static void
 hex_string(void)
 {
 	const char buf[3] = {0xc0, 0xff, 0xee};
@@ -469,7 +463,7 @@ hex_string(void)
 	     "%*ph|%*phC|%*phD|%*phN", 3, buf, 3, buf, 3, buf, 3, buf);
 }
 
-static void __init
+static void
 mac(void)
 {
 	const u8 addr[6] = {0x2d, 0x48, 0xd6, 0xfc, 0x7a, 0x05};
@@ -481,7 +475,7 @@ mac(void)
 	test("057afcd6482d", "%pmR", addr);
 }
 
-static void __init
+static void
 ip4(void)
 {
 	struct sockaddr_in sa;
@@ -496,19 +490,19 @@ ip4(void)
 	test("001.002.003.004:12345|1.2.3.4:12345", "%piSp|%pISp", &sa, &sa);
 }
 
-static void __init
+static void
 ip6(void)
 {
 }
 
-static void __init
+static void
 ip(void)
 {
 	ip4();
 	ip6();
 }
 
-static void __init
+static void
 uuid(void)
 {
 	const char uuid[16] = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
@@ -520,7 +514,7 @@ uuid(void)
 	test("03020100-0504-0706-0809-0A0B0C0D0E0F", "%pUL", uuid);
 }
 
-static struct dentry test_dentry[4] __initdata = {
+static struct dentry test_dentry[4] = {
 	{ .d_parent = &test_dentry[0],
 	  .d_name = QSTR_INIT(test_dentry[0].d_iname, 3),
 	  .d_iname = "foo" },
@@ -535,7 +529,7 @@ static struct dentry test_dentry[4] __initdata = {
 	  .d_iname = "romeo" },
 };
 
-static void __init
+static void
 dentry(void)
 {
 	test("foo", "%pd", &test_dentry[0]);
@@ -556,12 +550,12 @@ dentry(void)
 	test("  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2], 12, &test_dentry[2]);
 }
 
-static void __init
+static void
 struct_va_format(void)
 {
 }
 
-static void __init
+static void
 time_and_date(void)
 {
 	/* 1543210543 */
@@ -595,12 +589,12 @@ time_and_date(void)
 	test("15:32:23|0119-00-04", "%ptTtrs|%ptTdrs", &t, &t);
 }
 
-static void __init
+static void
 struct_clk(void)
 {
 }
 
-static void __init
+static void
 large_bitmap(void)
 {
 	const int nbits = 1 << 16;
@@ -614,7 +608,7 @@ large_bitmap(void)
 	bitmap_free(bits);
 }
 
-static void __init
+static void
 bitmap(void)
 {
 	DECLARE_BITMAP(bits, 20);
@@ -637,7 +631,7 @@ bitmap(void)
 	large_bitmap();
 }
 
-static void __init
+static void
 netdev_features(void)
 {
 }
@@ -663,7 +657,7 @@ static const struct page_flags_test pft[] = {
 	 "%#x", "kasantag"},
 };
 
-static void __init
+static void
 page_flags_test(int section, int node, int zone, int last_cpupid,
 		int kasan_tag, unsigned long flags, const char *name,
 		char *cmp_buf)
@@ -701,7 +695,7 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
 	test(cmp_buf, "%pGp", &flags);
 }
 
-static void __init
+static void
 flags(void)
 {
 	unsigned long flags;
@@ -749,7 +743,7 @@ flags(void)
 	kfree(cmp_buffer);
 }
 
-static void __init fwnode_pointer(void)
+static void fwnode_pointer(void)
 {
 	const struct software_node first = { .name = "first" };
 	const struct software_node second = { .name = "second", .parent = &first };
@@ -763,7 +757,7 @@ static void __init fwnode_pointer(void)
 
 	rval = software_node_register_node_group(group);
 	if (rval) {
-		pr_warn("cannot register softnodes; rval %d\n", rval);
+		kunit_warn(kunittest, "cannot register softnodes; rval %d", rval);
 		return;
 	}
 
@@ -776,7 +770,7 @@ static void __init fwnode_pointer(void)
 	software_node_unregister_node_group(group);
 }
 
-static void __init fourcc_pointer(void)
+static void fourcc_pointer(void)
 {
 	struct {
 		u32 code;
@@ -793,7 +787,7 @@ static void __init fourcc_pointer(void)
 		test(try[i].str, "%p4cc", &try[i].code);
 }
 
-static void __init
+static void
 errptr(void)
 {
 	test("-1234", "%pe", ERR_PTR(-1234));
@@ -813,7 +807,7 @@ errptr(void)
 #endif
 }
 
-static void __init
+static void
 test_pointer(void)
 {
 	plain();
@@ -842,13 +836,15 @@ test_pointer(void)
 	fourcc_pointer();
 }
 
-static void __init selftest(void)
+static void printf_test(struct kunit *test)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
 	if (!alloced_buffer)
 		return;
 	test_buffer = alloced_buffer + PAD_SIZE;
 
+	kunittest = test;
+
 	test_basic();
 	test_number();
 	test_string();
@@ -857,7 +853,31 @@ static void __init selftest(void)
 	kfree(alloced_buffer);
 }
 
-KSTM_MODULE_LOADERS(test_printf);
+static int printf_suite_init(struct kunit_suite *suite)
+{
+	total_tests = 0;
+	return 0;
+}
+
+static void printf_suite_exit(struct kunit_suite *suite)
+{
+	kunit_info(suite, "ran %u tests", total_tests);
+}
+
+static struct kunit_case printf_test_cases[] = {
+	KUNIT_CASE(printf_test),
+	{}
+};
+
+static struct kunit_suite printf_test_suite = {
+	.name = "printf",
+	.suite_init = printf_suite_init,
+	.suite_exit = printf_suite_exit,
+	.test_cases = printf_test_cases,
+};
+
+kunit_test_suite(printf_test_suite);
+
 MODULE_AUTHOR("Rasmus Villemoes <linux@rasmusvillemoes.dk>");
 MODULE_DESCRIPTION("Test cases for printf facility");
 MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index dc15aba8d0a3..0a63594177c2 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,4 +1,3 @@
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
diff --git a/tools/testing/selftests/lib/printf.sh b/tools/testing/selftests/lib/printf.sh
deleted file mode 100755
index 05f4544e87f9..000000000000
--- a/tools/testing/selftests/lib/printf.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Tests the printf infrastructure using test_printf kernel module.
-$(dirname $0)/../kselftest/module.sh "printf" test_printf

-- 
2.48.1


