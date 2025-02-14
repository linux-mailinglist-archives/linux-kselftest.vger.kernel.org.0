Return-Path: <linux-kselftest+bounces-26692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F198A367DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 22:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6E7170430
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 21:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D61F5413;
	Fri, 14 Feb 2025 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm98idaT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C11DC9AA;
	Fri, 14 Feb 2025 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569980; cv=none; b=RMFSSfWyzDr/JgYEGRCGmbEF2lAFz65yIhKghHsf3EIggVsIuGlefAxwMmDaYxaL3RFYDiddiX6XsOp3UHE5Qzs6VbaNaDNVlnUaSa/PbNxYiGhloc3bAXefoZTyvlJdswCFkrklbZtyU6rVrWEMQYEOvOO4DK6ppUkGOM15t/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569980; c=relaxed/simple;
	bh=dH+zFFm4fjLTPNvGX/bCrNLhcT4Gtx0gHQWhKq3mXv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbfEis2jmvc2AhTqrfj84zbV2ZGhOaKB1geh8enz4CiMfTDui+5P0Cc4dmuAYgqnOtA+aCoxzhLySgrZ4pNdkGXWmnr67Qw3jkzEDAXl56I0vi7lwDZc8MD+A+tC+q57dq78mrTg68CAiAdK3aY/rg2ETU6cUiZqrQDJrGtxdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm98idaT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e46269d2c2so31536506d6.3;
        Fri, 14 Feb 2025 13:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739569977; x=1740174777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7V/1SVkX5galDi5RzNtpRXmOGl9JTS9joUJrr16+8s=;
        b=bm98idaTrrtihDPysJf6qWcMCGkbaQ9/WcLsdrWfPkAL4SNzVEIN/N/h+OmsOzFkv+
         993jKbrO6+Reu5wBsyfT4/gMvH1D2j0Sg/T92mvOJ2o6WImyQa1/ZmSKU6FjmMSKVEjk
         OeV+sxcqv5yOT9C5dNJxSOhKL3taLsosnrRWUz4t97yItfmCy27wgOQw55WcrSDJVwUw
         ImiNXsUryxS+FzY2kdypFIf47OpLMTX6GBEQ0g0iGPJD+BESdr0BqYUvIbIxSK0Hkpid
         9jICCqC+frnvAKwBE7NI6w22AR6APzYd8qRfLi/Tfc2H83QYVqwopsSFzyBqflY2yapQ
         Ha4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739569977; x=1740174777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7V/1SVkX5galDi5RzNtpRXmOGl9JTS9joUJrr16+8s=;
        b=NWeLFbJOyypuzGuF7dPsYjx83vTPtpeTBEX0OpnMfvmB78xbnLOkRkzzHwIBKW69nT
         5l9b9+Gbf0adK+GZWWrnoUd9ulMhpSglfQm2DUxCEZM86YSmWtN3xvckx8g3RgvLe75i
         ZD2aLe/pbJUBDwhVZrc6bKX5/eMO5rXkIDHksC2SquxPt926XM8sV6i9c8LJ4grVXkRx
         e525bRMkrrvKqFQqVRjV3K/uT+6DQPxHjRhw/JUZYqUWp/X8pznOnJQyWDByLiNjZEED
         2CRM5lDA9SzZSyJBiyZ0uel6FyeNiDgcxUR3pKUQ5XpfZJ9bKpQf461q0snE8DM+tx2B
         Txjg==
X-Forwarded-Encrypted: i=1; AJvYcCVXkdMWl/A02uwDJeLo0LLnbnRZOB925MuYedp4tuTyE38h6zVItbE9QhJo24U0NaXgd9WzCcdX2qE=@vger.kernel.org, AJvYcCW9WcVunhO2L62E9RaetUr3xbTVSpkMeL8yY3kWTDATqMM9/5RFPZvS/MgREVsSfSsGkQIAhyNDb+9AqTxBvgMx@vger.kernel.org
X-Gm-Message-State: AOJu0YzTTt/A1yRUB4qhDXyBJU2i6j2ZWp4vIaaThVYplVoVIgzoarpv
	vqTET8/VhXy3+6g8q9H1A02RslhzYTIyIm7Rim3VK/gtIAxxDgIZYLyLrxXH
X-Gm-Gg: ASbGncvnHkxA5nyjk2XbXeIPf4kj1LNNVP7/tddVzo3TlEFm4cGjx8RlHHH4rCuhrn9
	a1K3UuHqbOibLjdCT33+Amse1HXFd1pIGpNRQVE6ALvxcz5tYpiME33texXoFXyWPDj6Uy0+3SZ
	2yxeeTCvnb0Dd+UGM9BrOK7cEzDg1gHSUpBpofPqY36dXuZJwfgdbFTOZrN1b1aoEFTf00WVhVJ
	ltMu+caWTGGW+1oLkVSZu6WSobB3ebIGg+GfpQfKoN7Xk6wwvzNdObCWAsRYeMftBx43BFpRLQQ
	cpzsauSCUhrlApXEfQ2ntS0e/CTy0rzKwW01mQ==
X-Google-Smtp-Source: AGHT+IEFF9WqJ24X15ApTqa0Z/L6kJ9CnE3fZnk0wObBWQ9jAIy3XyVSHF+ok2o2XPULmc/9Pir0pw==
X-Received: by 2002:a05:6214:1c4a:b0:6d8:d5f6:8c75 with SMTP id 6a1803df08f44-6e66cc98006mr14738776d6.12.1739569977191;
        Fri, 14 Feb 2025 13:52:57 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:d4df:402c:65f0:87da])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af3367sm21844451cf.59.2025.02.14.13.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:52:55 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 16:52:39 -0500
Subject: [PATCH v4 1/3] printf: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-printf-kunit-convert-v4-1-c254572f1565@gmail.com>
References: <20250214-printf-kunit-convert-v4-0-c254572f1565@gmail.com>
In-Reply-To: <20250214-printf-kunit-convert-v4-0-c254572f1565@gmail.com>
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
 Documentation/core-api/printk-formats.rst   |   4 +-
 MAINTAINERS                                 |   2 +-
 lib/Kconfig.debug                           |  12 +-
 lib/Makefile                                |   1 -
 lib/tests/Makefile                          |   1 +
 lib/{test_printf.c => tests/printf_kunit.c} | 188 +++++++++++++++-------------
 tools/testing/selftests/lib/config          |   1 -
 tools/testing/selftests/lib/printf.sh       |   4 -
 8 files changed, 117 insertions(+), 96 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ecccc0473da9..4bdc394e86af 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -661,7 +661,7 @@ Do *not* use it from C.
 Thanks
 ======
 
-If you add other %p extensions, please extend <lib/test_printf.c> with
-one or more test cases, if at all feasible.
+If you add other %p extensions, please extend <lib/tests/printf_kunit.c>
+with one or more test cases, if at all feasible.
 
 Thank you for your cooperation and attention.
diff --git a/MAINTAINERS b/MAINTAINERS
index 92fc0eca7061..d85366e22ff6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25466,8 +25466,8 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/core-api/printk-formats.rst
-F:	lib/test_printf.c
 F:	lib/test_scanf.c
+F:	lib/tests/printf_kunit.c
 F:	lib/vsprintf.c
 
 VT1211 HARDWARE MONITOR DRIVER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 85b95d645b10..0c27745dff56 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2436,6 +2436,15 @@ config ASYNC_RAID6_TEST
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
@@ -2449,9 +2458,6 @@ config STRING_HELPERS_KUNIT_TEST
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
 
-config TEST_PRINTF
-	tristate "Test printf() family of functions at runtime"
-
 config TEST_SCANF
 	tristate "Test scanf() family of functions at runtime"
 
diff --git a/lib/Makefile b/lib/Makefile
index 961aef91d493..f31e6a3100ba 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,7 +77,6 @@ obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
-obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 8961fbcff7a4..183c6a838a5d 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
 CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
+obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
diff --git a/lib/test_printf.c b/lib/tests/printf_kunit.c
similarity index 87%
rename from lib/test_printf.c
rename to lib/tests/printf_kunit.c
index 59dbe4f9a4cb..287bbfb61148 100644
--- a/lib/test_printf.c
+++ b/lib/tests/printf_kunit.c
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
index 306a3d4dca98..f4b4b8822241 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,4 +1,3 @@
-CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITOPS=m
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


