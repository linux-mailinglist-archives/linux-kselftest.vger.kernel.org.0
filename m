Return-Path: <linux-kselftest+bounces-28483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C21A566B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999F51899CBC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612F218AB3;
	Fri,  7 Mar 2025 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlyBn0px"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941C2185B4;
	Fri,  7 Mar 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346877; cv=none; b=Oe5L4E7VfSXaMD2wG0OFgqQOZOdR9nv8RyWhozy4VQuKtAqHMA1XjJE/FQjtJY0bvK+Gd/ew2sGRrjrsP4nAm3o2gW3W13Id8GwE0zradQnC77pG9wTYU63d3YXFjIMoSSqsC/AFa0xjXqrcDGtb2rI5N4VOUlrP876pPsPP2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346877; c=relaxed/simple;
	bh=5YhZ8QYP0De0dhqPxmOCdz+AsNKMw+0QJRVPGabu4mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COw1/Gv/BZh3r46tqYzIqg9JjDRtnVP1nASwGrQZxC6J4CqFGOXtunBQkMPxtypmqitGhmhvayCBaHgVbiRCNP81SmSi8cKX3/c33U45RksBevvIHpWYaT7KKBueKZPqUPYxFXMVUdpNnlHJmewQHLZCVYoQ10bYJKDw6CLi9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlyBn0px; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f7019422so14651236d6.1;
        Fri, 07 Mar 2025 03:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346873; x=1741951673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPU7bedmhEsbsN84NlPVMhzfXQ4kaWRHoNbK0IaYbP4=;
        b=hlyBn0pxn2HShG49B2Sm1nc53xyJHP0zDdoAuZB/+0ew38plHzwVW56+7E3IJNiOfm
         ifD7VOF/umhIpI5hd+b0szpGW5Yt6IZBfxwI9pYTsKorljKAxgwwlL7V3SX4QdMC1Zs6
         vqt0PV18XqIQbZZMybQ+otpmv6C59ELHJBlJNJ8s9MpgeFOYf1+iXoazbcBszRhyNnzv
         eswdhKAH92wof05EW0C8H9ekZrArdOapUpWWlHmipQbCku2FhyCYV19+S9NRjhtvwT3R
         zK2efJfIGq2QGu78I7q6KB2aZW611b2a6wzSkcBGoTRJnLuZR1KkyrW02ai/DGATQkvD
         W8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346873; x=1741951673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPU7bedmhEsbsN84NlPVMhzfXQ4kaWRHoNbK0IaYbP4=;
        b=Q34HZgIXrxdXPQh6WB/jU3JeC1lKXFNSLcXKrHaHeqnTP7hspMWMtsm4eX+DIwdCI4
         7wtM3L0rNa22XOvPBM5600PNNtR3tjo6DBlOjw0YSWGMKXp6kYqfmc1TPOqfAOLdLPTQ
         qwlvJ0eHmUE3C+5wVmPoRfUNTvW2MZKfKceC6A/y1DvHDnrVrn2sGpQJHEHxAe89ErzC
         q36K8EV3VjZBGj0DfOYsKLhxvRY4rVnHwAqz4B9HpiwTK/iqFeeCVTAyd1Loh9TjMg3y
         2xSeo3vwUqgpihfw5qoupRek9DkGSP38qilaRiTr8iRN9sqRrfFZb9Pp3SS3Zc5CWAAr
         IQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCUgv0QcN8ZPD53zdQSCF/8k4t9gSArAsw2/CU4a3ebl1naSfK1MFvKqhQmlwYaeYrjURqTrnT1IJt6dgIDWKHsR@vger.kernel.org, AJvYcCXJr/enEmM4QBDdjwxoubyKDIXS9Sx+Y+/GKlY5HRfkfDaLzHOj9PHOhFcOGuQOoM3QReB3XvKyf75RAN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOebeuRrOJZul9llrMn6DDAGXCmdxKXjiYyDjgqQvjLH0hw5Gl
	ViNxnfVmC88dqIW+pZd9TkygxGC/1JnbergTcVuIBV6e7RzOqLccz7ljvKPt9fA=
X-Gm-Gg: ASbGncsyJYmVqMSJXH5Z4W3fwwj7/2vWYituME+V6yJ0ZnEHserahIOFXhhiwUqC+db
	AIsUFxAxdQixcOpUPUY1RAz/1bsbJTby97zWNCiJjbFNKI5QtQ6CMvAsHfASOsffw189SMo6o25
	gzyz/DSnCJmh2Ky1Vf3k3Do6RdZcwkwxBaTLVQcmc5B+6+JjcbfNHAgMErCC1bc7n0pK+o2vYGf
	syOUA80hdznPm5FminCck0JgpVdFkIz9d3+oAjOLhe93vUwIZXvXh1noPzYnX6x4GoWG6PVilnU
	PolLEMZY4B30XhykI8+ERA/UUu561GR/BVxiKYjZw7V0g+Ugf7VRBbKZSdsUrFgD3FQ=
X-Google-Smtp-Source: AGHT+IEUs3JjgPBHIdeoWzzKtspjxKuIiGb8J2kg/3wkJWFtotznvYZKr9yAnQQDgt+aw0L8Uzfy6g==
X-Received: by 2002:a05:6214:d48:b0:6e8:f60c:5879 with SMTP id 6a1803df08f44-6e9006f1fadmr34586356d6.42.1741346872807;
        Fri, 07 Mar 2025 03:27:52 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a446dsm18509416d6.56.2025.03.07.03.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:27:51 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 06:27:36 -0500
Subject: [PATCH v9 3/6] scanf: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-scanf-kunit-convert-v9-3-b98820fa39ff@gmail.com>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
In-Reply-To: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 MAINTAINERS                               |   2 +-
 lib/Kconfig.debug                         |  12 +-
 lib/Makefile                              |   1 -
 lib/tests/Makefile                        |   1 +
 lib/{test_scanf.c => tests/scanf_kunit.c} | 252 +++++++++++++++---------------
 tools/testing/selftests/lib/Makefile      |   2 +-
 tools/testing/selftests/lib/config        |   1 -
 tools/testing/selftests/lib/scanf.sh      |   4 -
 8 files changed, 134 insertions(+), 141 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e9e0e52f92e..f5e2c420ed5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25599,8 +25599,8 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/core-api/printk-formats.rst
+F:	lib/tests/scanf_kunit.c
 F:	lib/test_printf.c
-F:	lib/test_scanf.c
 F:	lib/vsprintf.c
 
 VT1211 HARDWARE MONITOR DRIVER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebb5b190e9f9..af6262f84af6 100644
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
index 7bab71e59019..821dd8447f11 100644
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
similarity index 78%
rename from lib/test_scanf.c
rename to lib/tests/scanf_kunit.c
index cb0b57dc7383..94eb5ec80fdb 100644
--- a/lib/test_scanf.c
+++ b/lib/tests/scanf_kunit.c
@@ -3,60 +3,44 @@
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
-#include <linux/printk.h>
 #include <linux/prandom.h>
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
 
-static void __scanf(6, 8) __init
-_test(const char *file, const int line, check_fn fn, const void *check_data, const char *string,
-	const char *fmt, int n_args, ...)
+static void __scanf(7, 9)
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
 
@@ -65,88 +49,92 @@ do {										\
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
 
@@ -154,7 +142,7 @@ static int __init check_char(const char *file, const int line, const void *check
 }
 
 /* Selection of interesting numbers to test, copied from test-kstrtox.c */
-static const unsigned long long numbers[] __initconst = {
+static const unsigned long long numbers[] = {
 	0x0ULL,
 	0x1ULL,
 	0x7fULL,
@@ -194,7 +182,7 @@ do {									\
 	T result = ~expect_val; /* should be overwritten */		\
 									\
 	snprintf(test_buffer, BUF_SIZE, gen_fmt, expect_val);		\
-	_test(__FILE__, __LINE__, fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
+	_test(test, __FILE__, __LINE__, fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);\
 } while (0)
 
 #define simple_numbers_loop(T, gen_fmt, scan_fmt, fn)			\
@@ -212,7 +200,7 @@ do {									\
 	}								\
 } while (0)
 
-static void __init numbers_simple(void)
+static void numbers_simple(struct kunit *test)
 {
 	simple_numbers_loop(unsigned long long,	"%llu",	  "llu", check_ull);
 	simple_numbers_loop(long long,		"%lld",	  "lld", check_ll);
@@ -265,14 +253,14 @@ static void __init numbers_simple(void)
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
@@ -309,7 +297,7 @@ do {										\
  * updating buf_pos and returning the number of characters appended.
  * On error buf_pos is not changed and return value is 0.
  */
-static int __init __printf(4, 5)
+static int __printf(4, 5)
 append_fmt(char *buf, int *buf_pos, int buf_len, const char *val_fmt, ...)
 {
 	va_list ap;
@@ -331,7 +319,7 @@ append_fmt(char *buf, int *buf_pos, int buf_len, const char *val_fmt, ...)
  * Convenience function to append the field delimiter string
  * to both the value string and format string buffers.
  */
-static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len,
+static void append_delim(char *str_buf, int *str_buf_pos, int str_buf_len,
 				char *fmt_buf, int *fmt_buf_pos, int fmt_buf_len,
 				const char *delim_str)
 {
@@ -342,7 +330,7 @@ static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len
 #define test_array_8(fn, check_data, string, fmt, arr)				\
 do {										\
 	BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);					\
-	_test(__FILE__, __LINE__, fn, check_data, string, fmt, 8,		\
+	_test(test, __FILE__, __LINE__, fn, check_data, string, fmt, 8,		\
 		&(arr)[0], &(arr)[1], &(arr)[2], &(arr)[3],			\
 		&(arr)[4], &(arr)[5], &(arr)[6], &(arr)[7]);			\
 } while (0)
@@ -396,7 +384,7 @@ do {										\
 	test_array_8(fn, expect, test_buffer, fmt_buffer, result);		\
 } while (0)
 
-static void __init numbers_list_ll(const char *delim)
+static void numbers_list_ll(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned long long, "%llu",   delim, "llu", check_ull);
 	numbers_list_8(long long,	   "%lld",   delim, "lld", check_ll);
@@ -406,7 +394,7 @@ static void __init numbers_list_ll(const char *delim)
 	numbers_list_8(long long,	   "0x%llx", delim, "lli", check_ll);
 }
 
-static void __init numbers_list_l(const char *delim)
+static void numbers_list_l(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned long,	   "%lu",    delim, "lu", check_ulong);
 	numbers_list_8(long,		   "%ld",    delim, "ld", check_long);
@@ -416,7 +404,7 @@ static void __init numbers_list_l(const char *delim)
 	numbers_list_8(long,		   "0x%lx",  delim, "li", check_long);
 }
 
-static void __init numbers_list_d(const char *delim)
+static void numbers_list_d(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned int,	   "%u",     delim, "u", check_uint);
 	numbers_list_8(int,		   "%d",     delim, "d", check_int);
@@ -426,7 +414,7 @@ static void __init numbers_list_d(const char *delim)
 	numbers_list_8(int,		   "0x%x",   delim, "i", check_int);
 }
 
-static void __init numbers_list_h(const char *delim)
+static void numbers_list_h(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned short,	   "%hu",    delim, "hu", check_ushort);
 	numbers_list_8(short,		   "%hd",    delim, "hd", check_short);
@@ -436,7 +424,7 @@ static void __init numbers_list_h(const char *delim)
 	numbers_list_8(short,		   "0x%hx",  delim, "hi", check_short);
 }
 
-static void __init numbers_list_hh(const char *delim)
+static void numbers_list_hh(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned char,	   "%hhu",   delim, "hhu", check_uchar);
 	numbers_list_8(signed char,	   "%hhd",   delim, "hhd", check_char);
@@ -446,16 +434,16 @@ static void __init numbers_list_hh(const char *delim)
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
@@ -465,7 +453,7 @@ static void __init numbers_list_field_width_ll(const char *delim)
 	numbers_list_fix_width(long long,	   "0x%llx", delim, 18, "lli", check_ll);
 }
 
-static void __init numbers_list_field_width_l(const char *delim)
+static void numbers_list_field_width_l(struct kunit *test, const char *delim)
 {
 #if BITS_PER_LONG == 64
 	numbers_list_fix_width(unsigned long,	"%lu",	     delim, 20, "lu", check_ulong);
@@ -484,7 +472,7 @@ static void __init numbers_list_field_width_l(const char *delim)
 #endif
 }
 
-static void __init numbers_list_field_width_d(const char *delim)
+static void numbers_list_field_width_d(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned int,	"%u",	     delim, 10, "u", check_uint);
 	numbers_list_fix_width(int,		"%d",	     delim, 11, "d", check_int);
@@ -494,7 +482,7 @@ static void __init numbers_list_field_width_d(const char *delim)
 	numbers_list_fix_width(int,		"0x%x",	     delim, 10, "i", check_int);
 }
 
-static void __init numbers_list_field_width_h(const char *delim)
+static void numbers_list_field_width_h(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned short,	"%hu",	     delim, 5, "hu", check_ushort);
 	numbers_list_fix_width(short,		"%hd",	     delim, 6, "hd", check_short);
@@ -504,7 +492,7 @@ static void __init numbers_list_field_width_h(const char *delim)
 	numbers_list_fix_width(short,		"0x%hx",     delim, 6, "hi", check_short);
 }
 
-static void __init numbers_list_field_width_hh(const char *delim)
+static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned char,	"%hhu",	     delim, 3, "hhu", check_uchar);
 	numbers_list_fix_width(signed char,	"%hhd",	     delim, 4, "hhd", check_char);
@@ -518,16 +506,16 @@ static void __init numbers_list_field_width_hh(const char *delim)
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
@@ -537,7 +525,7 @@ static void __init numbers_list_field_width_val_ll(const char *delim)
 	numbers_list_val_width(long long,	   "0x%llx", delim, "lli", check_ll);
 }
 
-static void __init numbers_list_field_width_val_l(const char *delim)
+static void numbers_list_field_width_val_l(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned long,	"%lu",	     delim, "lu", check_ulong);
 	numbers_list_val_width(long,		"%ld",	     delim, "ld", check_long);
@@ -547,7 +535,7 @@ static void __init numbers_list_field_width_val_l(const char *delim)
 	numbers_list_val_width(long,		"0x%lx",     delim, "li", check_long);
 }
 
-static void __init numbers_list_field_width_val_d(const char *delim)
+static void numbers_list_field_width_val_d(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned int,	"%u",	     delim, "u", check_uint);
 	numbers_list_val_width(int,		"%d",	     delim, "d", check_int);
@@ -557,7 +545,7 @@ static void __init numbers_list_field_width_val_d(const char *delim)
 	numbers_list_val_width(int,		"0x%x",	     delim, "i", check_int);
 }
 
-static void __init numbers_list_field_width_val_h(const char *delim)
+static void numbers_list_field_width_val_h(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned short,	"%hu",	     delim, "hu", check_ushort);
 	numbers_list_val_width(short,		"%hd",	     delim, "hd", check_short);
@@ -567,7 +555,7 @@ static void __init numbers_list_field_width_val_h(const char *delim)
 	numbers_list_val_width(short,		"0x%hx",     delim, "hi", check_short);
 }
 
-static void __init numbers_list_field_width_val_hh(const char *delim)
+static void numbers_list_field_width_val_hh(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned char,	"%hhu",	     delim, "hhu", check_uchar);
 	numbers_list_val_width(signed char,	"%hhd",	     delim, "hhd", check_char);
@@ -581,13 +569,13 @@ static void __init numbers_list_field_width_val_hh(const char *delim)
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
@@ -596,9 +584,9 @@ static void __init numbers_list_field_width_val_width(const char *delim)
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
@@ -606,14 +594,14 @@ do {										\
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
@@ -682,24 +670,17 @@ do {										\
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
@@ -715,7 +696,7 @@ do {										\
 	}									\
 } while (0)
 
-static void __init test_simple_strtoull(void)
+static void test_simple_strtoull(struct kunit *test)
 {
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   10);
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   0);
@@ -724,7 +705,7 @@ static void __init test_simple_strtoull(void)
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "0x%llx", 0);
 }
 
-static void __init test_simple_strtoll(void)
+static void test_simple_strtoll(struct kunit *test)
 {
 	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 10);
 	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 0);
@@ -733,7 +714,7 @@ static void __init test_simple_strtoll(void)
 	test_simple_strtoxx(long long, simple_strtoll, "0x%llx", 0);
 }
 
-static void __init test_simple_strtoul(void)
+static void test_simple_strtoul(struct kunit *test)
 {
 	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   10);
 	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   0);
@@ -742,7 +723,7 @@ static void __init test_simple_strtoul(void)
 	test_simple_strtoxx(unsigned long, simple_strtoul, "0x%lx", 0);
 }
 
-static void __init test_simple_strtol(void)
+static void test_simple_strtol(struct kunit *test)
 {
 	test_simple_strtoxx(long, simple_strtol, "%ld",   10);
 	test_simple_strtoxx(long, simple_strtol, "%ld",   0);
@@ -752,35 +733,35 @@ static void __init test_simple_strtol(void)
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
@@ -794,18 +775,29 @@ static void __init selftest(void)
 
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
index 66dcbe2e39fa..dda63c32c0f0 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -4,5 +4,5 @@
 # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
 all:
 
-TEST_PROGS := printf.sh bitmap.sh scanf.sh
+TEST_PROGS := printf.sh bitmap.sh
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


