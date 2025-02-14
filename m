Return-Path: <linux-kselftest+bounces-26671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EACA1A362EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A48016AC01
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F126267B04;
	Fri, 14 Feb 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7XqZv44"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EF26770C;
	Fri, 14 Feb 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550022; cv=none; b=csEgXE1C84YFzbpSniKN8bzb7tnfPLVrVgyeRh/xMctoLOhg8qiJf3gg/b/LlYF6XImO85tiv2jkDaVDYMkLxHuYvf402mB/KQHB1bBmBXu9y6uR6ZQ79XLotsES1S6HEOBMIN+ksFqQ06GftHvwLa3DvwzzrfjCpRHeJOji4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550022; c=relaxed/simple;
	bh=AhQiOUtEtf8Kfg7ogwG8jjfVbP2I67tNj/tXj8vxYMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ps8BDD0T0eGnaJL+16txdlSRgFtjc72lRZlsQ3u/YNucxscVcmII2xwz2/l8+oXbksUKCb8Gre0L7gi0lY5V0f0haM5EIc34vxEe9Jk2pi3rRYieXsNH77dW1DiofCGvyYAscGBXjyMxBo9zrDxhnafCYGPNrGpoq6R8oUIWtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7XqZv44; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471d0d123d8so7865081cf.0;
        Fri, 14 Feb 2025 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550018; x=1740154818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VCBhSjbpSxxtoIMl4LQSzahtuVSOdMB24YuJYpx5a0=;
        b=d7XqZv4422RoDMe+At2dtgxpsCDZVRW9syPwZSePLXGAzeK8DmuOTs2qY98PDQnJiy
         1CP1n7Bw01lBz/PcgIsmMxCVKOIAYKrP99h6pCegNrspghgyB/XLFBk1gDND7a8MnTE9
         Fpmx6EzYfAAgLH/FuOKRDE+3qeyQhaa9KN6Sbke0aC73ANpD4aUElsSJMWs1ei4WZP1b
         LY9dHNrLs1TF736BNfS9yJ8hI/4YscixIzPpxLELFIodQCUPGRaFs1uuabELhGXMxCEu
         0ELuUeM/wa+GzvpVuKdg4dcKXWoxwhrGvLTSC15crnvEt+nQinP3KCc9Y72t/D7oJTST
         x79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550018; x=1740154818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VCBhSjbpSxxtoIMl4LQSzahtuVSOdMB24YuJYpx5a0=;
        b=k68fBam0JK8jBlZ6+dIfoLZyKFq+sOg7uW3Lhw4reWZexgt4CDqOuS89MXYOI/23oV
         rBE+Pstpd5itP11Iqmpk69nWpUazpBFjBrxT9xpFq/3g48inImxauGjRm4vXFgw11bi8
         lEhdow3pElsUJb0RW/W72oPjFWQpjiNVuTsHgkK1Sn/dt02TlzImsJugpgU18gYVARLP
         vBeZEofu1Qa1gCGjY8zldpCwtgvDvKOTOr48Dp63aX7ICZBsu9KrsggSXKp4tTJd+uFN
         Ot4nX0mQucSXLlI/AxZ4LgzxLk8UJRVfI2YJ5REJ1O+GQ/5KHlE2N7E6/oCbnBfqjLNf
         10GA==
X-Forwarded-Encrypted: i=1; AJvYcCVPq58kd4nIH8/3RAJt4IqgIemoxOZ6ARIo5bkS+u0A6dTMRprWITtnA+ECZeYAFHzTKZ+4T6OZLd0wMs+6BBAn@vger.kernel.org, AJvYcCVQUbn8i3QOS+II/h3j4v5Y+AzLG/uobCLKUL5tuUSSHWzNzTkFZ4zmkf9nbv5Wn8LlEOcOm8seMQn8N0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YweLbBVhl+MxtdYIUwULvjeZB4ISoO3IYi6to4c1I5DF45kUl4Z
	9C0ClV3xVnqKoPWKObPhCrmUkk5BvYVzIdjNoPmGy5YxLGCcQ4hg
X-Gm-Gg: ASbGncvXELe+2FG110pyKyRtcVtBUFjQrS2XpX4CdIG+kGOR01Hl2pFaNnNOq2jdHKx
	HavVKe93ibLJ10f5hms7RGybnhAAF+Qa7xRXfidZmrfdO4R8soscuKfw0JY+8nBH6p28yesmJXY
	OtW3LIP/IKL3mJjiKa0bY+x10ZVGntGUhimV8HgI6j8uEcgjDMw2In4Ptho3rJbgt14G6OLb+kt
	vEq+pmtD3+HqKvRsw0aMRP9wLAAuhjQoql2eAk832IWXABY/K5SKKqH8ycGDnNjH76cNOL6H8N1
	bfXqL5sQSEm8jKIuTduj7A6iCs+D10aq8PWkzw==
X-Google-Smtp-Source: AGHT+IE6T/9N01eDB7ziU4pK0igxY2B5d7EupZB37PemAO66qr7SEcdHk6F4rH85iSDUqK0mf/P31g==
X-Received: by 2002:ac8:7d4c:0:b0:471:c6c7:4847 with SMTP id d75a77b69052e-471c6c74b42mr100704751cf.2.1739550018386;
        Fri, 14 Feb 2025 08:20:18 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:d4df:402c:65f0:87da])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af37c7sm19196911cf.61.2025.02.14.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:20:17 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 11:20:00 -0500
Subject: [PATCH v8 3/4] scanf: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
In-Reply-To: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Convert the scanf() self-test to a KUnit test.

In the interest of keeping the patch reasonably-sized this doesn't
refactor the tests into proper parameterized tests - it's all one big
test case.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 MAINTAINERS                               |   2 +-
 lib/Kconfig.debug                         |  12 +-
 lib/Makefile                              |   1 -
 lib/tests/Makefile                        |   1 +
 lib/{test_scanf.c => tests/scanf_kunit.c} | 251 +++++++++++++++---------------
 tools/testing/selftests/lib/Makefile      |   2 +-
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/scanf.sh      |   4 -
 8 files changed, 134 insertions(+), 140 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92fc0eca7061..8dc8f597596d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25466,8 +25466,8 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/core-api/printk-formats.rst
+F:	lib/tests/scanf_kunit.c
 F:	lib/test_printf.c
-F:	lib/test_scanf.c
 F:	lib/vsprintf.c
 
 VT1211 HARDWARE MONITOR DRIVER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 85b95d645b10..bf3b8999a2ac 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2436,6 +2436,15 @@ config ASYNC_RAID6_TEST
 config TEST_HEXDUMP
 	tristate "Test functions located in the hexdump module at runtime"
 
+config SCANF_KUNIT_TEST
+	tristate "KUnit test scanf() family of functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the scanf functions at runtime.
+
+	  If unsure, say N.
+
 config STRING_KUNIT_TEST
 	tristate "KUnit test string functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
@@ -2452,9 +2461,6 @@ config TEST_KSTRTOX
 config TEST_PRINTF
 	tristate "Test printf() family of functions at runtime"
 
-config TEST_SCANF
-	tristate "Test scanf() family of functions at runtime"
-
 config TEST_BITMAP
 	tristate "Test bitmap_*() family of functions at runtime"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 961aef91d493..459ca67825f4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -78,7 +78,6 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
-obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 8961fbcff7a4..db9b685f2d88 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_MEMCPY_KUNIT_TEST) += memcpy_kunit.o
 CFLAGS_overflow_kunit.o = $(call cc-disable-warning, tautological-constant-out-of-range-compare)
 obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
+obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
diff --git a/lib/test_scanf.c b/lib/tests/scanf_kunit.c
similarity index 79%
rename from lib/test_scanf.c
rename to lib/tests/scanf_kunit.c
index efdde6f498d9..3bbad9ebe437 100644
--- a/lib/test_scanf.c
+++ b/lib/tests/scanf_kunit.c
@@ -3,10 +3,8 @@
  * Test cases for sscanf facility.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
+#include <kunit/test.h>
 #include <linux/bitops.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -15,48 +13,35 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
-#include "../tools/testing/selftests/kselftest_module.h"
-
 #define BUF_SIZE 1024
 
-KSTM_MODULE_GLOBALS();
-static char *test_buffer __initdata;
-static char *fmt_buffer __initdata;
-static struct rnd_state rnd_state __initdata;
+static char *test_buffer;
+static char *fmt_buffer;
+static struct rnd_state rnd_state;
 
-typedef int (*check_fn)(const char *file, const int line, const void *check_data,
-			const char *string, const char *fmt, int n_args, va_list ap);
+typedef void (*check_fn)(struct kunit *test, const char *file, const int line,
+			 const void *check_data, const char *string, const char *fmt, int n_args,
+			 va_list ap);
 
-static void __scanf(6, 0) __init
-_test(const char *file, const int line, check_fn fn, const void *check_data, const char *string,
-	const char *fmt, int n_args, ...)
+static void __scanf(7, 0)
+_test(struct kunit *test, const char *file, const int line, check_fn fn, const void *check_data,
+	const char *string, const char *fmt, int n_args, ...)
 {
 	va_list ap, ap_copy;
 	int ret;
 
-	total_tests++;
-
 	va_start(ap, n_args);
 	va_copy(ap_copy, ap);
 	ret = vsscanf(string, fmt, ap_copy);
 	va_end(ap_copy);
 
 	if (ret != n_args) {
-		pr_warn("%s:%d: vsscanf(\"%s\", \"%s\", ...) returned %d expected %d\n",
-			file, line, string, fmt, ret, n_args);
-		goto fail;
+		KUNIT_FAIL(test, "%s:%d: vsscanf(\"%s\", \"%s\", ...) returned %d expected %d",
+			   file, line, string, fmt, ret, n_args);
+	} else {
+		(*fn)(test, file, line, check_data, string, fmt, n_args, ap);
 	}
 
-	ret = (*fn)(file, line, check_data, string, fmt, n_args, ap);
-	if (ret)
-		goto fail;
-
-	va_end(ap);
-
-	return;
-
-fail:
-	failed_tests++;
 	va_end(ap);
 }
 
@@ -65,88 +50,92 @@ do {										\
 	for (; n_args > 0; n_args--, expect++) {				\
 		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
 		if (got != *expect) {						\
-			pr_warn("%s:%d, vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt "\n", \
-				file, line, str, fmt, *expect, got);		\
-			return 1;						\
+			KUNIT_FAIL(test,					\
+				   "%s:%d: vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt, \
+				   file, line, str, fmt, *expect, got);		\
+			return;							\
 		}								\
 	}									\
-	return 0;								\
 } while (0)
 
-static int __init check_ull(const char *file, const int line, const void *check_data,
-			    const char *string, const char *fmt, int n_args, va_list ap)
+static void check_ull(struct kunit *test, const char *file, const int line, const void *check_data,
+		      const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const unsigned long long *pval = check_data;
 
 	_check_numbers_template("%llu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ll(const char *file, const int line, const void *check_data,
-			   const char *string, const char *fmt, int n_args, va_list ap)
+static void check_ll(struct kunit *test, const char *file, const int line, const void *check_data,
+		     const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const long long *pval = check_data;
 
 	_check_numbers_template("%lld", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ulong(const char *file, const int line, const void *check_data,
-			      const char *string, const char *fmt, int n_args, va_list ap)
+static void check_ulong(struct kunit *test, const char *file, const int line,
+			const void *check_data, const char *string, const char *fmt, int n_args,
+			va_list ap)
 {
 	const unsigned long *pval = check_data;
 
 	_check_numbers_template("%lu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_long(const char *file, const int line, const void *check_data,
-			     const char *string, const char *fmt, int n_args, va_list ap)
+static void check_long(struct kunit *test, const char *file, const int line, const void *check_data,
+		       const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const long *pval = check_data;
 
 	_check_numbers_template("%ld", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_uint(const char *file, const int line, const void *check_data,
-			     const char *string, const char *fmt, int n_args, va_list ap)
+static void check_uint(struct kunit *test, const char *file, const int line, const void *check_data,
+		       const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const unsigned int *pval = check_data;
 
 	_check_numbers_template("%u", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_int(const char *file, const int line, const void *check_data,
-			    const char *string, const char *fmt, int n_args, va_list ap)
+static void check_int(struct kunit *test, const char *file, const int line, const void *check_data,
+		      const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const int *pval = check_data;
 
 	_check_numbers_template("%d", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ushort(const char *file, const int line, const void *check_data,
-			       const char *string, const char *fmt, int n_args, va_list ap)
+static void check_ushort(struct kunit *test, const char *file, const int line,
+			 const void *check_data, const char *string, const char *fmt, int n_args,
+			 va_list ap)
 {
 	const unsigned short *pval = check_data;
 
 	_check_numbers_template("%hu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_short(const char *file, const int line, const void *check_data,
-			      const char *string, const char *fmt, int n_args, va_list ap)
+static void check_short(struct kunit *test, const char *file, const int line,
+			const void *check_data, const char *string, const char *fmt, int n_args,
+			va_list ap)
 {
 	const short *pval = check_data;
 
 	_check_numbers_template("%hd", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_uchar(const char *file, const int line, const void *check_data,
-			      const char *string, const char *fmt, int n_args, va_list ap)
+static void check_uchar(struct kunit *test, const char *file, const int line,
+			const void *check_data, const char *string, const char *fmt, int n_args,
+			va_list ap)
 {
 	const unsigned char *pval = check_data;
 
 	_check_numbers_template("%hhu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_char(const char *file, const int line, const void *check_data,
-			     const char *string, const char *fmt, int n_args, va_list ap)
+static void check_char(struct kunit *test, const char *file, const int line, const void *check_data,
+		       const char *string, const char *fmt, int n_args, va_list ap)
 {
 	const signed char *pval = check_data;
 
@@ -154,7 +143,7 @@ static int __init check_char(const char *file, const int line, const void *check
 }
 
 /* Selection of interesting numbers to test, copied from test-kstrtox.c */
-static const unsigned long long numbers[] __initconst = {
+static const unsigned long long numbers[] = {
 	0x0ULL,
 	0x1ULL,
 	0x7fULL,
@@ -194,7 +183,7 @@ do {									\
 	T result = ~expect_val; /* should be overwritten */		\
 									\
 	snprintf(test_buffer, BUF_SIZE, gen_fmt, expect_val);		\
-	_test(__FILE__, __LINE__, fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
+	_test(test, __FILE__, __LINE__, fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);\
 } while (0)
 
 #define simple_numbers_loop(T, gen_fmt, scan_fmt, fn)			\
@@ -212,7 +201,7 @@ do {									\
 	}								\
 } while (0)
 
-static void __init numbers_simple(void)
+static void numbers_simple(struct kunit *test)
 {
 	simple_numbers_loop(unsigned long long,	"%llu",	  "llu", check_ull);
 	simple_numbers_loop(long long,		"%lld",	  "lld", check_ll);
@@ -265,14 +254,14 @@ static void __init numbers_simple(void)
  * the raw prandom*() functions (Not mathematically rigorous!!).
  * Variabilty of length and value is more important than perfect randomness.
  */
-static u32 __init next_test_random(u32 max_bits)
+static u32 next_test_random(u32 max_bits)
 {
 	u32 n_bits = hweight32(prandom_u32_state(&rnd_state)) % (max_bits + 1);
 
 	return prandom_u32_state(&rnd_state) & GENMASK(n_bits, 0);
 }
 
-static unsigned long long __init next_test_random_ull(void)
+static unsigned long long next_test_random_ull(void)
 {
 	u32 rand1 = prandom_u32_state(&rnd_state);
 	u32 n_bits = (hweight32(rand1) * 3) % 64;
@@ -309,7 +298,7 @@ do {										\
  * updating buf_pos and returning the number of characters appended.
  * On error buf_pos is not changed and return value is 0.
  */
-static int __init __printf(4, 5)
+static int __printf(4, 5)
 append_fmt(char *buf, int *buf_pos, int buf_len, const char *val_fmt, ...)
 {
 	va_list ap;
@@ -331,7 +320,7 @@ append_fmt(char *buf, int *buf_pos, int buf_len, const char *val_fmt, ...)
  * Convenience function to append the field delimiter string
  * to both the value string and format string buffers.
  */
-static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len,
+static void append_delim(char *str_buf, int *str_buf_pos, int str_buf_len,
 				char *fmt_buf, int *fmt_buf_pos, int fmt_buf_len,
 				const char *delim_str)
 {
@@ -342,7 +331,7 @@ static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len
 #define test_array_8(fn, check_data, string, fmt, arr)				\
 do {										\
 	BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);					\
-	_test(__FILE__, __LINE__, fn, check_data, string, fmt, 8,		\
+	_test(test, __FILE__, __LINE__, fn, check_data, string, fmt, 8,		\
 		&(arr)[0], &(arr)[1], &(arr)[2], &(arr)[3],			\
 		&(arr)[4], &(arr)[5], &(arr)[6], &(arr)[7]);			\
 } while (0)
@@ -396,7 +385,7 @@ do {										\
 	test_array_8(fn, expect, test_buffer, fmt_buffer, result);		\
 } while (0)
 
-static void __init numbers_list_ll(const char *delim)
+static void numbers_list_ll(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned long long, "%llu",   delim, "llu", check_ull);
 	numbers_list_8(long long,	   "%lld",   delim, "lld", check_ll);
@@ -406,7 +395,7 @@ static void __init numbers_list_ll(const char *delim)
 	numbers_list_8(long long,	   "0x%llx", delim, "lli", check_ll);
 }
 
-static void __init numbers_list_l(const char *delim)
+static void numbers_list_l(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned long,	   "%lu",    delim, "lu", check_ulong);
 	numbers_list_8(long,		   "%ld",    delim, "ld", check_long);
@@ -416,7 +405,7 @@ static void __init numbers_list_l(const char *delim)
 	numbers_list_8(long,		   "0x%lx",  delim, "li", check_long);
 }
 
-static void __init numbers_list_d(const char *delim)
+static void numbers_list_d(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned int,	   "%u",     delim, "u", check_uint);
 	numbers_list_8(int,		   "%d",     delim, "d", check_int);
@@ -426,7 +415,7 @@ static void __init numbers_list_d(const char *delim)
 	numbers_list_8(int,		   "0x%x",   delim, "i", check_int);
 }
 
-static void __init numbers_list_h(const char *delim)
+static void numbers_list_h(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned short,	   "%hu",    delim, "hu", check_ushort);
 	numbers_list_8(short,		   "%hd",    delim, "hd", check_short);
@@ -436,7 +425,7 @@ static void __init numbers_list_h(const char *delim)
 	numbers_list_8(short,		   "0x%hx",  delim, "hi", check_short);
 }
 
-static void __init numbers_list_hh(const char *delim)
+static void numbers_list_hh(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned char,	   "%hhu",   delim, "hhu", check_uchar);
 	numbers_list_8(signed char,	   "%hhd",   delim, "hhd", check_char);
@@ -446,16 +435,16 @@ static void __init numbers_list_hh(const char *delim)
 	numbers_list_8(signed char,	   "0x%hhx", delim, "hhi", check_char);
 }
 
-static void __init numbers_list(const char *delim)
+static void numbers_list(struct kunit *test, const char *delim)
 {
-	numbers_list_ll(delim);
-	numbers_list_l(delim);
-	numbers_list_d(delim);
-	numbers_list_h(delim);
-	numbers_list_hh(delim);
+	numbers_list_ll(test, delim);
+	numbers_list_l(test, delim);
+	numbers_list_d(test, delim);
+	numbers_list_h(test, delim);
+	numbers_list_hh(test, delim);
 }
 
-static void __init numbers_list_field_width_ll(const char *delim)
+static void numbers_list_field_width_ll(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned long long, "%llu",   delim, 20, "llu", check_ull);
 	numbers_list_fix_width(long long,	   "%lld",   delim, 20, "lld", check_ll);
@@ -465,7 +454,7 @@ static void __init numbers_list_field_width_ll(const char *delim)
 	numbers_list_fix_width(long long,	   "0x%llx", delim, 18, "lli", check_ll);
 }
 
-static void __init numbers_list_field_width_l(const char *delim)
+static void numbers_list_field_width_l(struct kunit *test, const char *delim)
 {
 #if BITS_PER_LONG == 64
 	numbers_list_fix_width(unsigned long,	"%lu",	     delim, 20, "lu", check_ulong);
@@ -484,7 +473,7 @@ static void __init numbers_list_field_width_l(const char *delim)
 #endif
 }
 
-static void __init numbers_list_field_width_d(const char *delim)
+static void numbers_list_field_width_d(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned int,	"%u",	     delim, 10, "u", check_uint);
 	numbers_list_fix_width(int,		"%d",	     delim, 11, "d", check_int);
@@ -494,7 +483,7 @@ static void __init numbers_list_field_width_d(const char *delim)
 	numbers_list_fix_width(int,		"0x%x",	     delim, 10, "i", check_int);
 }
 
-static void __init numbers_list_field_width_h(const char *delim)
+static void numbers_list_field_width_h(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned short,	"%hu",	     delim, 5, "hu", check_ushort);
 	numbers_list_fix_width(short,		"%hd",	     delim, 6, "hd", check_short);
@@ -504,7 +493,7 @@ static void __init numbers_list_field_width_h(const char *delim)
 	numbers_list_fix_width(short,		"0x%hx",     delim, 6, "hi", check_short);
 }
 
-static void __init numbers_list_field_width_hh(const char *delim)
+static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned char,	"%hhu",	     delim, 3, "hhu", check_uchar);
 	numbers_list_fix_width(signed char,	"%hhd",	     delim, 4, "hhd", check_char);
@@ -518,16 +507,16 @@ static void __init numbers_list_field_width_hh(const char *delim)
  * List of numbers separated by delim. Each field width specifier is the
  * maximum possible digits for the given type and base.
  */
-static void __init numbers_list_field_width_typemax(const char *delim)
+static void numbers_list_field_width_typemax(struct kunit *test, const char *delim)
 {
-	numbers_list_field_width_ll(delim);
-	numbers_list_field_width_l(delim);
-	numbers_list_field_width_d(delim);
-	numbers_list_field_width_h(delim);
-	numbers_list_field_width_hh(delim);
+	numbers_list_field_width_ll(test, delim);
+	numbers_list_field_width_l(test, delim);
+	numbers_list_field_width_d(test, delim);
+	numbers_list_field_width_h(test, delim);
+	numbers_list_field_width_hh(test, delim);
 }
 
-static void __init numbers_list_field_width_val_ll(const char *delim)
+static void numbers_list_field_width_val_ll(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned long long, "%llu",   delim, "llu", check_ull);
 	numbers_list_val_width(long long,	   "%lld",   delim, "lld", check_ll);
@@ -537,7 +526,7 @@ static void __init numbers_list_field_width_val_ll(const char *delim)
 	numbers_list_val_width(long long,	   "0x%llx", delim, "lli", check_ll);
 }
 
-static void __init numbers_list_field_width_val_l(const char *delim)
+static void numbers_list_field_width_val_l(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned long,	"%lu",	     delim, "lu", check_ulong);
 	numbers_list_val_width(long,		"%ld",	     delim, "ld", check_long);
@@ -547,7 +536,7 @@ static void __init numbers_list_field_width_val_l(const char *delim)
 	numbers_list_val_width(long,		"0x%lx",     delim, "li", check_long);
 }
 
-static void __init numbers_list_field_width_val_d(const char *delim)
+static void numbers_list_field_width_val_d(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned int,	"%u",	     delim, "u", check_uint);
 	numbers_list_val_width(int,		"%d",	     delim, "d", check_int);
@@ -557,7 +546,7 @@ static void __init numbers_list_field_width_val_d(const char *delim)
 	numbers_list_val_width(int,		"0x%x",	     delim, "i", check_int);
 }
 
-static void __init numbers_list_field_width_val_h(const char *delim)
+static void numbers_list_field_width_val_h(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned short,	"%hu",	     delim, "hu", check_ushort);
 	numbers_list_val_width(short,		"%hd",	     delim, "hd", check_short);
@@ -567,7 +556,7 @@ static void __init numbers_list_field_width_val_h(const char *delim)
 	numbers_list_val_width(short,		"0x%hx",     delim, "hi", check_short);
 }
 
-static void __init numbers_list_field_width_val_hh(const char *delim)
+static void numbers_list_field_width_val_hh(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned char,	"%hhu",	     delim, "hhu", check_uchar);
 	numbers_list_val_width(signed char,	"%hhd",	     delim, "hhd", check_char);
@@ -581,13 +570,13 @@ static void __init numbers_list_field_width_val_hh(const char *delim)
  * List of numbers separated by delim. Each field width specifier is the
  * exact length of the corresponding value digits in the string being scanned.
  */
-static void __init numbers_list_field_width_val_width(const char *delim)
+static void numbers_list_field_width_val_width(struct kunit *test, const char *delim)
 {
-	numbers_list_field_width_val_ll(delim);
-	numbers_list_field_width_val_l(delim);
-	numbers_list_field_width_val_d(delim);
-	numbers_list_field_width_val_h(delim);
-	numbers_list_field_width_val_hh(delim);
+	numbers_list_field_width_val_ll(test, delim);
+	numbers_list_field_width_val_l(test, delim);
+	numbers_list_field_width_val_d(test, delim);
+	numbers_list_field_width_val_h(test, delim);
+	numbers_list_field_width_val_hh(test, delim);
 }
 
 /*
@@ -596,9 +585,9 @@ static void __init numbers_list_field_width_val_width(const char *delim)
  * of digits. For example the hex values c0,3,bf01,303 would have a
  * string representation of "c03bf01303" and extracted with "%2x%1x%4x%3x".
  */
-static void __init numbers_slice(void)
+static void numbers_slice(struct kunit *test)
 {
-	numbers_list_field_width_val_width("");
+	numbers_list_field_width_val_width(test, "");
 }
 
 #define test_number_prefix(T, str, scan_fmt, expect0, expect1, n_args, fn)	\
@@ -606,14 +595,14 @@ do {										\
 	const T expect[2] = { expect0, expect1 };				\
 	T result[2] = { (T)~expect[0], (T)~expect[1] };				\
 										\
-	_test(__FILE__, __LINE__, fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
+	_test(test, __FILE__, __LINE__, fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);\
 } while (0)
 
 /*
  * Number prefix is >= field width.
  * Expected behaviour is derived from testing userland sscanf.
  */
-static void __init numbers_prefix_overflow(void)
+static void numbers_prefix_overflow(struct kunit *test)
 {
 	/*
 	 * Negative decimal with a field of width 1, should quit scanning
@@ -682,24 +671,17 @@ do {										\
 	T got;									\
 	char *endp;								\
 	int len;								\
-	bool fail = false;							\
 										\
-	total_tests++;								\
 	len = snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);			\
 	got = (fn)(test_buffer, &endp, base);					\
 	if (got != (expect)) {							\
-		fail = true;							\
-		pr_warn(#fn "(\"%s\", %d): got " gen_fmt " expected " gen_fmt "\n", \
-			test_buffer, base, got, expect);			\
+		KUNIT_FAIL(test, #fn "(\"%s\", %d): got " gen_fmt " expected " gen_fmt, \
+			   test_buffer, base, got, expect);			\
 	} else if (endp != test_buffer + len) {					\
-		fail = true;							\
-		pr_warn(#fn "(\"%s\", %d) startp=0x%px got endp=0x%px expected 0x%px\n", \
-			test_buffer, base, test_buffer,				\
-			test_buffer + len, endp);				\
+		KUNIT_FAIL(test, #fn "(\"%s\", %d) startp=0x%px got endp=0x%px expected 0x%px", \
+			   test_buffer, base, test_buffer,			\
+			   test_buffer + len, endp);				\
 	}									\
-										\
-	if (fail)								\
-		failed_tests++;							\
 } while (0)
 
 #define test_simple_strtoxx(T, fn, gen_fmt, base)				\
@@ -715,7 +697,7 @@ do {										\
 	}									\
 } while (0)
 
-static void __init test_simple_strtoull(void)
+static void test_simple_strtoull(struct kunit *test)
 {
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   10);
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   0);
@@ -724,7 +706,7 @@ static void __init test_simple_strtoull(void)
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "0x%llx", 0);
 }
 
-static void __init test_simple_strtoll(void)
+static void test_simple_strtoll(struct kunit *test)
 {
 	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 10);
 	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 0);
@@ -733,7 +715,7 @@ static void __init test_simple_strtoll(void)
 	test_simple_strtoxx(long long, simple_strtoll, "0x%llx", 0);
 }
 
-static void __init test_simple_strtoul(void)
+static void test_simple_strtoul(struct kunit *test)
 {
 	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   10);
 	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   0);
@@ -742,7 +724,7 @@ static void __init test_simple_strtoul(void)
 	test_simple_strtoxx(unsigned long, simple_strtoul, "0x%lx", 0);
 }
 
-static void __init test_simple_strtol(void)
+static void test_simple_strtol(struct kunit *test)
 {
 	test_simple_strtoxx(long, simple_strtol, "%ld",   10);
 	test_simple_strtoxx(long, simple_strtol, "%ld",   0);
@@ -752,35 +734,35 @@ static void __init test_simple_strtol(void)
 }
 
 /* Selection of common delimiters/separators between numbers in a string. */
-static const char * const number_delimiters[] __initconst = {
+static const char * const number_delimiters[] = {
 	" ", ":", ",", "-", "/",
 };
 
-static void __init test_numbers(void)
+static void test_numbers(struct kunit *test)
 {
 	int i;
 
 	/* String containing only one number. */
-	numbers_simple();
+	numbers_simple(test);
 
 	/* String with multiple numbers separated by delimiter. */
 	for (i = 0; i < ARRAY_SIZE(number_delimiters); i++) {
-		numbers_list(number_delimiters[i]);
+		numbers_list(test, number_delimiters[i]);
 
 		/* Field width may be longer than actual field digits. */
-		numbers_list_field_width_typemax(number_delimiters[i]);
+		numbers_list_field_width_typemax(test, number_delimiters[i]);
 
 		/* Each field width exactly length of actual field digits. */
-		numbers_list_field_width_val_width(number_delimiters[i]);
+		numbers_list_field_width_val_width(test, number_delimiters[i]);
 	}
 
 	/* Slice continuous sequence of digits using field widths. */
-	numbers_slice();
+	numbers_slice(test);
 
-	numbers_prefix_overflow();
+	numbers_prefix_overflow(test);
 }
 
-static void __init selftest(void)
+static void scanf_test(struct kunit *test)
 {
 	test_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
 	if (!test_buffer)
@@ -794,18 +776,29 @@ static void __init selftest(void)
 
 	prandom_seed_state(&rnd_state, 3141592653589793238ULL);
 
-	test_numbers();
+	test_numbers(test);
 
-	test_simple_strtoull();
-	test_simple_strtoll();
-	test_simple_strtoul();
-	test_simple_strtol();
+	test_simple_strtoull(test);
+	test_simple_strtoll(test);
+	test_simple_strtoul(test);
+	test_simple_strtol(test);
 
 	kfree(fmt_buffer);
 	kfree(test_buffer);
 }
 
-KSTM_MODULE_LOADERS(test_scanf);
+static struct kunit_case scanf_test_cases[] = {
+	KUNIT_CASE(scanf_test),
+	{}
+};
+
+static struct kunit_suite scanf_test_suite = {
+	.name = "scanf",
+	.test_cases = scanf_test_cases,
+};
+
+kunit_test_suite(scanf_test_suite);
+
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
 MODULE_DESCRIPTION("Test cases for sscanf facility");
 MODULE_LICENSE("GPL v2");
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index c52fe3ad8e98..4afda556151f 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -4,5 +4,5 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh scanf.sh
+TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index 306a3d4dca98..1d17fa85de8f 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,4 +1,3 @@
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_BITOPS=m
diff --git a/tools/testing/selftests/lib/scanf.sh b/tools/testing/selftests/lib/scanf.sh
deleted file mode 100755
index b59b8ba561c3..000000000000
--- a/tools/testing/selftests/lib/scanf.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Tests the scanf infrastructure using test_scanf kernel module.
-$(dirname $0)/../kselftest/module.sh "scanf" test_scanf

-- 
2.48.1


