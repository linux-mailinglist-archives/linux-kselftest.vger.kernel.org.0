Return-Path: <linux-kselftest+bounces-26198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69121A2F691
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ECF1888653
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E32566F4;
	Mon, 10 Feb 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPDXT5FW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736D24FBFA;
	Mon, 10 Feb 2025 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211250; cv=none; b=HJK7LcjrpSyRaqOAfJHvAAQHEPvqsQuw7431lFdVK1yq+40xtuN/zKqD2wjzgEfdpYMxYBqG3oHla5FOn9+XCDcOfqu6FH6yoYFP3GeglEG9mMGLwMaBz379Jxn09yxm7gPgyCUcCFozHt2PyOvtRiCNKLrW+/2bPfBUQPbY39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211250; c=relaxed/simple;
	bh=ZrQ/5PIyKVW6b0X3a5h2kgrx5eg6Zndz5fE73u9kU04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHPC81lwkJopoFL5n7pyPuyPbm+fZc369kaYPC65DV/f3ZbzzbyYlOmkSsvy7u8LPzYqYnOC9PtZXiQncDNTgretAYBHVZ3EGEXxNOUEGoMH/lCWGbkFKXbuzirT24yyf3QHKwDk5CGSdAIfkBe3NWBu8x7RjpZ6tbA5PhxesIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPDXT5FW; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd01781b56so56076026d6.0;
        Mon, 10 Feb 2025 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739211246; x=1739816046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk8lW+5C59CtCg2nKbP+JerG8Lzyw96GjqmbMkNJIIU=;
        b=LPDXT5FW6PegS4wrN47PiqM+Zm8hdUVGm1Lw4lqXXzjHlN1kzJnHT1EhNDXKKb3Xgg
         1SysdCqg+BEdcYaeTfRzzjdFZwt+LhKV1eoL99uKNqsuU1W2NyM6gN2Rknf3lgbfpYnb
         07wwuLltpm2zVY0ETN54lEMlrZHUDzX/j9G2EDC+IeS84/bCINjUz3dXt8hGmkaOpJlE
         t4cOIDqvV/fr4aODsp/dz3ezhmFC2GXfFffYRo6Gx2gXasPFwOgJBoqNeEUd++4UEFlN
         vhl2+1cJzoXKKjb+4Pz8r55xxkQxVWb63WziBvIB9SVPtEKdydhWpaypOHklrM+s4f8L
         sKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211246; x=1739816046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk8lW+5C59CtCg2nKbP+JerG8Lzyw96GjqmbMkNJIIU=;
        b=g4OYEMj8HpYWv5lGPD1hx66QYIaUndjLba8GIaG4EYGlMg3HPpERq50PoBUm80QEpD
         8bmGqEppTdrbUo0bHBAMyvCIXvwAGPy4NMqYqrFJGlUuT1uyac/KBBqDiGz7J8vOx7wO
         5os/N/c8cGvCKVg6s739BzEtfht8k1p7a33uKE3KBxLES26e61zBl1WldUvdgcVzsLlh
         Py6MrMMLgEEwn3jm9vDZ7fNmFMlqzfTsVkkqGplBoY6/j7OMdZpYu+VvLAVKY8coTDQ/
         Sj3uvPc+N06/SCyQxG0R+pgYaYbqF6sa6+iTmm/1Y4ALmtUCDR1dpk2icFwZjsBQ4lDK
         XEZA==
X-Forwarded-Encrypted: i=1; AJvYcCUgxjDy9vc8sOnfGI0eem/9ta+XtbiCc+v+rfsFFDDTTjLZKipnN3u2M1y/xNcMLSOkj1R3egILs09H61s=@vger.kernel.org, AJvYcCV9sV7AdCtvBl23uvQcONImRFQKMAI+v1YB2GAju/m6VaAsW7MrpcMQsHSmS8EcYWtxJJ1suv9kzeuktHhzFEv8@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWMnOsKCG6sT9c9wYQy2Pf+4CugUVrAaWier2ZDmDFb/ojgcE
	YDwPxz1k9LrkavibgcaWXDs5llsK5G1g3enslNpH8Gf+Xex4HZtW
X-Gm-Gg: ASbGnctzIR4RNJOiQ5tq8x6s5QPIHCjyvK3mAXl7ENrGcepnII3Lhk4/55ufZIpxGYX
	LanDsRizmok19wgXL5qE2J4OFhubahhm2WcICilFW/SBn3UP+w2i0lL1cX2uOfdoJRsQoOUibCg
	PrA2nC5DdpMD3WwVX0DaNFxbPFldFZ1jrZRhwFt3XcAdlnHB8pOM/ZhohdbEAo1veG0cSmNKCfp
	OxRsTW9r6WucXnr9MxSJv/O108OhCDd128ZGawO+4d9O69XaVe/LUc4wHGddrP2cDPB2NYIl1Ig
	px4LM3C+VJL0RZ+0sJ7F+4TJrkv/fpR60+a8gfiyfbGFIWo2+hwPIm3grl1mPPQLCJLspGxU5fM
	tbyhfSQc5tscn42eURv5KplEs
X-Google-Smtp-Source: AGHT+IEiBbTxW88UCQA+FgHP9/5AUaTqLYyaPAhaaOA3PE1H62peFcg0V/eiiXX1Ow1tk+UEkWfeYw==
X-Received: by 2002:a05:6214:5188:b0:6e4:3eb1:2bdb with SMTP id 6a1803df08f44-6e445750afemr191917146d6.43.1739211246163;
        Mon, 10 Feb 2025 10:14:06 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:cc94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacbbasm49591376d6.73.2025.02.10.10.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:14:05 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 13:13:48 -0500
Subject: [PATCH v6 1/2] scanf: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-scanf-kunit-convert-v6-1-4d583d07f92d@gmail.com>
References: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
In-Reply-To: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
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

Acked-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 MAINTAINERS                          |   2 +-
 lib/Kconfig.debug                    |  12 +-
 lib/Makefile                         |   2 +-
 lib/{test_scanf.c => scanf_kunit.c}  | 228 ++++++++++++++++-------------------
 tools/testing/selftests/lib/Makefile |   2 +-
 tools/testing/selftests/lib/config   |   1 -
 tools/testing/selftests/lib/scanf.sh |   4 -
 7 files changed, 118 insertions(+), 133 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..ab1d90c66c02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25411,8 +25411,8 @@ R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/core-api/printk-formats.rst
+F:	lib/scanf_kunit.c
 F:	lib/test_printf.c
-F:	lib/test_scanf.c
 F:	lib/vsprintf.c
 
 VT1211 HARDWARE MONITOR DRIVER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..48625139fb7f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2427,6 +2427,15 @@ config ASYNC_RAID6_TEST
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
@@ -2443,9 +2452,6 @@ config TEST_KSTRTOX
 config TEST_PRINTF
 	tristate "Test printf() family of functions at runtime"
 
-config TEST_SCANF
-	tristate "Test scanf() family of functions at runtime"
-
 config TEST_BITMAP
 	tristate "Test bitmap_*() family of functions at runtime"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..6bdf2287878d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -85,7 +85,7 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
-obj-$(CONFIG_TEST_SCANF) += test_scanf.o
+obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
 
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
diff --git a/lib/test_scanf.c b/lib/scanf_kunit.c
similarity index 81%
rename from lib/test_scanf.c
rename to lib/scanf_kunit.c
index 44f8508c9d88..dfd29b103053 100644
--- a/lib/test_scanf.c
+++ b/lib/scanf_kunit.c
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
@@ -15,67 +13,49 @@
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
 
-typedef int (*check_fn)(const void *check_data, const char *string,
+typedef void (*check_fn)(struct kunit *test, const void *check_data, const char *string,
 			const char *fmt, int n_args, va_list ap);
 
-static void __scanf(4, 6) __init
-_test(check_fn fn, const void *check_data, const char *string, const char *fmt,
+static void __scanf(5, 7)
+_test(struct kunit *test, check_fn fn, const void *check_data, const char *string, const char *fmt,
 	int n_args, ...)
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
-		pr_warn("vsscanf(\"%s\", \"%s\", ...) returned %d expected %d\n",
-			string, fmt, ret, n_args);
-		goto fail;
+		KUNIT_FAIL(test, "vsscanf(\"%s\", \"%s\", ...) returned %d expected %d",
+			   string, fmt, ret, n_args);
+	} else {
+		(*fn)(test, check_data, string, fmt, n_args, ap);
 	}
 
-	ret = (*fn)(check_data, string, fmt, n_args, ap);
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
 
 #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)		\
 do {										\
-	pr_debug("\"%s\", \"%s\" ->\n", str, fmt);				\
+	kunit_printk(KERN_DEBUG, test, "\"%s\", \"%s\" ->", str, fmt);	\
 	for (; n_args > 0; n_args--, expect++) {				\
 		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
-		pr_debug("\t" arg_fmt "\n", got);				\
-		if (got != *expect) {						\
-			pr_warn("vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt "\n", \
-				str, fmt, *expect, got);			\
-			return 1;						\
-		}								\
+		kunit_printk(KERN_DEBUG, test, "\t" arg_fmt, got);		\
+		KUNIT_EXPECT_EQ_MSG(test, got, *expect,				\
+				    "vsscanf(\"%s\", \"%s\", ...)", str, fmt);  \
 	}									\
-	return 0;								\
 } while (0)
 
-static int __init check_ull(const void *check_data, const char *string,
+static void check_ull(struct kunit *test, const void *check_data, const char *string,
 			    const char *fmt, int n_args, va_list ap)
 {
 	const unsigned long long *pval = check_data;
@@ -83,7 +63,7 @@ static int __init check_ull(const void *check_data, const char *string,
 	_check_numbers_template("%llu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ll(const void *check_data, const char *string,
+static void check_ll(struct kunit *test, const void *check_data, const char *string,
 			   const char *fmt, int n_args, va_list ap)
 {
 	const long long *pval = check_data;
@@ -91,7 +71,7 @@ static int __init check_ll(const void *check_data, const char *string,
 	_check_numbers_template("%lld", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ulong(const void *check_data, const char *string,
+static void check_ulong(struct kunit *test, const void *check_data, const char *string,
 			   const char *fmt, int n_args, va_list ap)
 {
 	const unsigned long *pval = check_data;
@@ -99,7 +79,7 @@ static int __init check_ulong(const void *check_data, const char *string,
 	_check_numbers_template("%lu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_long(const void *check_data, const char *string,
+static void check_long(struct kunit *test, const void *check_data, const char *string,
 			  const char *fmt, int n_args, va_list ap)
 {
 	const long *pval = check_data;
@@ -107,7 +87,7 @@ static int __init check_long(const void *check_data, const char *string,
 	_check_numbers_template("%ld", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_uint(const void *check_data, const char *string,
+static void check_uint(struct kunit *test, const void *check_data, const char *string,
 			     const char *fmt, int n_args, va_list ap)
 {
 	const unsigned int *pval = check_data;
@@ -115,7 +95,7 @@ static int __init check_uint(const void *check_data, const char *string,
 	_check_numbers_template("%u", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_int(const void *check_data, const char *string,
+static void check_int(struct kunit *test, const void *check_data, const char *string,
 			    const char *fmt, int n_args, va_list ap)
 {
 	const int *pval = check_data;
@@ -123,7 +103,7 @@ static int __init check_int(const void *check_data, const char *string,
 	_check_numbers_template("%d", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_ushort(const void *check_data, const char *string,
+static void check_ushort(struct kunit *test, const void *check_data, const char *string,
 			       const char *fmt, int n_args, va_list ap)
 {
 	const unsigned short *pval = check_data;
@@ -131,7 +111,7 @@ static int __init check_ushort(const void *check_data, const char *string,
 	_check_numbers_template("%hu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_short(const void *check_data, const char *string,
+static void check_short(struct kunit *test, const void *check_data, const char *string,
 			       const char *fmt, int n_args, va_list ap)
 {
 	const short *pval = check_data;
@@ -139,7 +119,7 @@ static int __init check_short(const void *check_data, const char *string,
 	_check_numbers_template("%hd", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_uchar(const void *check_data, const char *string,
+static void check_uchar(struct kunit *test, const void *check_data, const char *string,
 			       const char *fmt, int n_args, va_list ap)
 {
 	const unsigned char *pval = check_data;
@@ -147,7 +127,7 @@ static int __init check_uchar(const void *check_data, const char *string,
 	_check_numbers_template("%hhu", pval, string, fmt, n_args, ap);
 }
 
-static int __init check_char(const void *check_data, const char *string,
+static void check_char(struct kunit *test, const void *check_data, const char *string,
 			       const char *fmt, int n_args, va_list ap)
 {
 	const signed char *pval = check_data;
@@ -156,7 +136,7 @@ static int __init check_char(const void *check_data, const char *string,
 }
 
 /* Selection of interesting numbers to test, copied from test-kstrtox.c */
-static const unsigned long long numbers[] __initconst = {
+static const unsigned long long numbers[] = {
 	0x0ULL,
 	0x1ULL,
 	0x7fULL,
@@ -196,7 +176,7 @@ do {									\
 	T result = ~expect_val; /* should be overwritten */		\
 									\
 	snprintf(test_buffer, BUF_SIZE, gen_fmt, expect_val);		\
-	_test(fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
+	_test(test, fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);\
 } while (0)
 
 #define simple_numbers_loop(T, gen_fmt, scan_fmt, fn)			\
@@ -214,7 +194,7 @@ do {									\
 	}								\
 } while (0)
 
-static void __init numbers_simple(void)
+static void numbers_simple(struct kunit *test)
 {
 	simple_numbers_loop(unsigned long long,	"%llu",	  "llu", check_ull);
 	simple_numbers_loop(long long,		"%lld",	  "lld", check_ll);
@@ -267,14 +247,14 @@ static void __init numbers_simple(void)
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
@@ -311,7 +291,7 @@ do {										\
  * updating buf_pos and returning the number of characters appended.
  * On error buf_pos is not changed and return value is 0.
  */
-static int __init __printf(4, 5)
+static int __printf(4, 5)
 append_fmt(char *buf, int *buf_pos, int buf_len, const char *val_fmt, ...)
 {
 	va_list ap;
@@ -333,7 +313,7 @@ append_fmt(char *buf, int *buf_pos, int buf_len, const char *val_fmt, ...)
  * Convenience function to append the field delimiter string
  * to both the value string and format string buffers.
  */
-static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len,
+static void append_delim(char *str_buf, int *str_buf_pos, int str_buf_len,
 				char *fmt_buf, int *fmt_buf_pos, int fmt_buf_len,
 				const char *delim_str)
 {
@@ -344,7 +324,7 @@ static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len
 #define test_array_8(fn, check_data, string, fmt, arr)				\
 do {										\
 	BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);					\
-	_test(fn, check_data, string, fmt, 8,					\
+	_test(test, fn, check_data, string, fmt, 8,				\
 		&(arr)[0], &(arr)[1], &(arr)[2], &(arr)[3],			\
 		&(arr)[4], &(arr)[5], &(arr)[6], &(arr)[7]);			\
 } while (0)
@@ -398,7 +378,7 @@ do {										\
 	test_array_8(fn, expect, test_buffer, fmt_buffer, result);		\
 } while (0)
 
-static void __init numbers_list_ll(const char *delim)
+static void numbers_list_ll(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned long long, "%llu",   delim, "llu", check_ull);
 	numbers_list_8(long long,	   "%lld",   delim, "lld", check_ll);
@@ -408,7 +388,7 @@ static void __init numbers_list_ll(const char *delim)
 	numbers_list_8(long long,	   "0x%llx", delim, "lli", check_ll);
 }
 
-static void __init numbers_list_l(const char *delim)
+static void numbers_list_l(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned long,	   "%lu",    delim, "lu", check_ulong);
 	numbers_list_8(long,		   "%ld",    delim, "ld", check_long);
@@ -418,7 +398,7 @@ static void __init numbers_list_l(const char *delim)
 	numbers_list_8(long,		   "0x%lx",  delim, "li", check_long);
 }
 
-static void __init numbers_list_d(const char *delim)
+static void numbers_list_d(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned int,	   "%u",     delim, "u", check_uint);
 	numbers_list_8(int,		   "%d",     delim, "d", check_int);
@@ -428,7 +408,7 @@ static void __init numbers_list_d(const char *delim)
 	numbers_list_8(int,		   "0x%x",   delim, "i", check_int);
 }
 
-static void __init numbers_list_h(const char *delim)
+static void numbers_list_h(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned short,	   "%hu",    delim, "hu", check_ushort);
 	numbers_list_8(short,		   "%hd",    delim, "hd", check_short);
@@ -438,7 +418,7 @@ static void __init numbers_list_h(const char *delim)
 	numbers_list_8(short,		   "0x%hx",  delim, "hi", check_short);
 }
 
-static void __init numbers_list_hh(const char *delim)
+static void numbers_list_hh(struct kunit *test, const char *delim)
 {
 	numbers_list_8(unsigned char,	   "%hhu",   delim, "hhu", check_uchar);
 	numbers_list_8(signed char,	   "%hhd",   delim, "hhd", check_char);
@@ -448,16 +428,16 @@ static void __init numbers_list_hh(const char *delim)
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
@@ -467,7 +447,7 @@ static void __init numbers_list_field_width_ll(const char *delim)
 	numbers_list_fix_width(long long,	   "0x%llx", delim, 18, "lli", check_ll);
 }
 
-static void __init numbers_list_field_width_l(const char *delim)
+static void numbers_list_field_width_l(struct kunit *test, const char *delim)
 {
 #if BITS_PER_LONG == 64
 	numbers_list_fix_width(unsigned long,	"%lu",	     delim, 20, "lu", check_ulong);
@@ -486,7 +466,7 @@ static void __init numbers_list_field_width_l(const char *delim)
 #endif
 }
 
-static void __init numbers_list_field_width_d(const char *delim)
+static void numbers_list_field_width_d(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned int,	"%u",	     delim, 10, "u", check_uint);
 	numbers_list_fix_width(int,		"%d",	     delim, 11, "d", check_int);
@@ -496,7 +476,7 @@ static void __init numbers_list_field_width_d(const char *delim)
 	numbers_list_fix_width(int,		"0x%x",	     delim, 10, "i", check_int);
 }
 
-static void __init numbers_list_field_width_h(const char *delim)
+static void numbers_list_field_width_h(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned short,	"%hu",	     delim, 5, "hu", check_ushort);
 	numbers_list_fix_width(short,		"%hd",	     delim, 6, "hd", check_short);
@@ -506,7 +486,7 @@ static void __init numbers_list_field_width_h(const char *delim)
 	numbers_list_fix_width(short,		"0x%hx",     delim, 6, "hi", check_short);
 }
 
-static void __init numbers_list_field_width_hh(const char *delim)
+static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
 {
 	numbers_list_fix_width(unsigned char,	"%hhu",	     delim, 3, "hhu", check_uchar);
 	numbers_list_fix_width(signed char,	"%hhd",	     delim, 4, "hhd", check_char);
@@ -520,16 +500,16 @@ static void __init numbers_list_field_width_hh(const char *delim)
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
@@ -539,7 +519,7 @@ static void __init numbers_list_field_width_val_ll(const char *delim)
 	numbers_list_val_width(long long,	   "0x%llx", delim, "lli", check_ll);
 }
 
-static void __init numbers_list_field_width_val_l(const char *delim)
+static void numbers_list_field_width_val_l(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned long,	"%lu",	     delim, "lu", check_ulong);
 	numbers_list_val_width(long,		"%ld",	     delim, "ld", check_long);
@@ -549,7 +529,7 @@ static void __init numbers_list_field_width_val_l(const char *delim)
 	numbers_list_val_width(long,		"0x%lx",     delim, "li", check_long);
 }
 
-static void __init numbers_list_field_width_val_d(const char *delim)
+static void numbers_list_field_width_val_d(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned int,	"%u",	     delim, "u", check_uint);
 	numbers_list_val_width(int,		"%d",	     delim, "d", check_int);
@@ -559,7 +539,7 @@ static void __init numbers_list_field_width_val_d(const char *delim)
 	numbers_list_val_width(int,		"0x%x",	     delim, "i", check_int);
 }
 
-static void __init numbers_list_field_width_val_h(const char *delim)
+static void numbers_list_field_width_val_h(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned short,	"%hu",	     delim, "hu", check_ushort);
 	numbers_list_val_width(short,		"%hd",	     delim, "hd", check_short);
@@ -569,7 +549,7 @@ static void __init numbers_list_field_width_val_h(const char *delim)
 	numbers_list_val_width(short,		"0x%hx",     delim, "hi", check_short);
 }
 
-static void __init numbers_list_field_width_val_hh(const char *delim)
+static void numbers_list_field_width_val_hh(struct kunit *test, const char *delim)
 {
 	numbers_list_val_width(unsigned char,	"%hhu",	     delim, "hhu", check_uchar);
 	numbers_list_val_width(signed char,	"%hhd",	     delim, "hhd", check_char);
@@ -583,13 +563,13 @@ static void __init numbers_list_field_width_val_hh(const char *delim)
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
@@ -598,9 +578,9 @@ static void __init numbers_list_field_width_val_width(const char *delim)
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
@@ -608,14 +588,14 @@ do {										\
 	const T expect[2] = { expect0, expect1 };				\
 	T result[2] = { (T)~expect[0], (T)~expect[1] };				\
 										\
-	_test(fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
+	_test(test, fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);\
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
@@ -684,25 +664,18 @@ do {										\
 	T got;									\
 	char *endp;								\
 	int len;								\
-	bool fail = false;							\
 										\
-	total_tests++;								\
 	len = snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);			\
 	got = (fn)(test_buffer, &endp, base);					\
-	pr_debug(#fn "(\"%s\", %d) -> " gen_fmt "\n", test_buffer, base, got);	\
+	kunit_printk(KERN_DEBUG, test, #fn "(\"%s\", %d) -> " gen_fmt, test_buffer, base, got);	\
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
@@ -718,7 +691,7 @@ do {										\
 	}									\
 } while (0)
 
-static void __init test_simple_strtoull(void)
+static void test_simple_strtoull(struct kunit *test)
 {
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   10);
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   0);
@@ -727,7 +700,7 @@ static void __init test_simple_strtoull(void)
 	test_simple_strtoxx(unsigned long long, simple_strtoull, "0x%llx", 0);
 }
 
-static void __init test_simple_strtoll(void)
+static void test_simple_strtoll(struct kunit *test)
 {
 	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 10);
 	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 0);
@@ -736,7 +709,7 @@ static void __init test_simple_strtoll(void)
 	test_simple_strtoxx(long long, simple_strtoll, "0x%llx", 0);
 }
 
-static void __init test_simple_strtoul(void)
+static void test_simple_strtoul(struct kunit *test)
 {
 	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   10);
 	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   0);
@@ -745,7 +718,7 @@ static void __init test_simple_strtoul(void)
 	test_simple_strtoxx(unsigned long, simple_strtoul, "0x%lx", 0);
 }
 
-static void __init test_simple_strtol(void)
+static void test_simple_strtol(struct kunit *test)
 {
 	test_simple_strtoxx(long, simple_strtol, "%ld",   10);
 	test_simple_strtoxx(long, simple_strtol, "%ld",   0);
@@ -755,35 +728,35 @@ static void __init test_simple_strtol(void)
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
@@ -797,18 +770,29 @@ static void __init selftest(void)
 
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
index dc15aba8d0a3..80b55a504868 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,5 +1,4 @@
 CONFIG_TEST_PRINTF=m
-CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
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


