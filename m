Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAA02DD6BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgLQSCS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:02:18 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39490 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbgLQSCS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:02:18 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHHpgXM007072;
        Thu, 17 Dec 2020 12:01:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=EZIh/i/WEg3YIQ4w1BzJ2kt5JXGZxZSHG+uSHjPvoeg=;
 b=lVwhe+dF4C/s5N/F+QelQ6ZhzP2kJZ65seh7pc541u7xanZBx3MJyJcLkAoFmaG0xZ2x
 7rokhQA192amV0xVkRMiWlCgO5GXMvXM6vtxOmL7WbLsCk6rO7FEqdV6ByFqEx6ZT9mD
 L5r22DMHP8BX0eoFKer9GM3z59Z2w0IUnnVZfWLlKEw9CrnZX1NuFJquD5sYJV9yxUBB
 9aQXw+WyBenmv5crU5BsLHC8utCX9HJ8l4SVQdnltMEz9bPb2BiIH0LQApvWb5gPV9jh
 zLNv2HjA4T4CihpappQjmXuyS4aiZWlCA8Ite2RzLuFOCxZdZ2VmXHXpYaiYpLmBh+Yl rg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35cu5ry5ne-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Dec 2020 12:01:02 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 17 Dec
 2020 18:01:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 17 Dec 2020 18:01:00 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.236])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8F2F011CA;
        Thu, 17 Dec 2020 18:01:00 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <shuah@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 3/4] lib: test_scanf: Add tests for sscanf number conversion
Date:   Thu, 17 Dec 2020 18:00:56 +0000
Message-ID: <20201217180057.23786-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201217180057.23786-1-rf@opensource.cirrus.com>
References: <20201217180057.23786-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170123
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds test_sscanf to test various number conversion cases, as
number conversion was previously broken.

This also tests the simple_strtoxxx() functions exported from
vsprintf.c.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS       |   1 +
 lib/Kconfig.debug |   3 +
 lib/Makefile      |   1 +
 lib/test_scanf.c  | 747 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 752 insertions(+)
 create mode 100644 lib/test_scanf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7887d2161be4..d2bf38bd3d0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18782,6 +18782,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git
 F:	Documentation/core-api/printk-formats.rst
 F:	lib/test_printf.c
+F:	lib/test_scanf.c
 F:	lib/vsprintf.c
 
 VT1211 HARDWARE MONITOR DRIVER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c789b39ed527..b934dca35a0c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2054,6 +2054,9 @@ config TEST_KSTRTOX
 config TEST_PRINTF
 	tristate "Test printf() family of functions at runtime"
 
+config TEST_SCANF
+	tristate "Test scanf() family of functions at runtime"
+
 config TEST_BITMAP
 	tristate "Test bitmap_*() family of functions at runtime"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index ce45af50983a..091463b8986a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
+obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
diff --git a/lib/test_scanf.c b/lib/test_scanf.c
new file mode 100644
index 000000000000..96d22d83a7dd
--- /dev/null
+++ b/lib/test_scanf.c
@@ -0,0 +1,747 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test cases for sscanf facility.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "../tools/testing/selftests/kselftest_module.h"
+
+#define BUF_SIZE 1024
+
+static unsigned total_tests __initdata;
+static unsigned failed_tests __initdata;
+static char *test_buffer __initdata;
+static char *fmt_buffer __initdata;
+static struct rnd_state rnd_state __initdata;
+
+typedef int (*check_fn)(const void *check_data, const char *string,
+			const char *fmt, int n_args, va_list ap);
+
+static void __scanf(4, 6) __init
+_test(check_fn fn, const void *check_data, const char *string, const char *fmt,
+	int n_args, ...)
+{
+	va_list ap, ap_copy;
+	int ret;
+
+	total_tests++;
+
+	va_start(ap, n_args);
+	va_copy(ap_copy, ap);
+	ret = vsscanf(string, fmt, ap_copy);
+	va_end(ap_copy);
+
+	if (ret != n_args) {
+		pr_warn("vsscanf(\"%s\", \"%s\", ...) returned %d expected %d\n",
+			string, fmt, ret, n_args);
+		goto fail;
+	}
+
+	ret = (*fn)(check_data, string, fmt, n_args, ap);
+	if (ret)
+		goto fail;
+
+	va_end(ap);
+
+	return;
+
+fail:
+	failed_tests++;
+	va_end(ap);
+}
+
+#define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)		\
+do {										\
+	pr_debug("\"%s\", \"%s\" ->\n", str, fmt);				\
+	for (; n_args > 0; --n_args, ++expect) {				\
+		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
+		pr_debug("\t" arg_fmt "\n", got);				\
+		if (got != *expect) {						\
+			pr_warn("vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt "\n", \
+				str, fmt, *expect, got);			\
+			return 1;						\
+		}								\
+	}									\
+	return 0;								\
+} while (0)
+
+static int __init check_ull(const void *check_data, const char *string,
+			    const char *fmt, int n_args, va_list ap)
+{
+	const unsigned long long *pval = check_data;
+
+	_check_numbers_template("%llu", pval, string, fmt, n_args, ap);
+}
+
+static int __init check_ll(const void *check_data, const char *string,
+			   const char *fmt, int n_args, va_list ap)
+{
+	const long long *pval = check_data;
+
+	_check_numbers_template("%lld", pval, string, fmt, n_args, ap);
+}
+
+static int __init check_ulong(const void *check_data, const char *string,
+			   const char *fmt, int n_args, va_list ap)
+{
+	const unsigned long *pval = check_data;
+
+	_check_numbers_template("%lu", pval, string, fmt, n_args, ap);
+}
+
+static int __init check_long(const void *check_data, const char *string,
+			  const char *fmt, int n_args, va_list ap)
+{
+	const long *pval = check_data;
+
+	_check_numbers_template("%ld", pval, string, fmt, n_args, ap);
+}
+
+static int __init check_uint(const void *check_data, const char *string,
+			     const char *fmt, int n_args, va_list ap)
+{
+	const unsigned int *pval = check_data;
+
+	_check_numbers_template("%u", pval, string, fmt, n_args, ap);
+}
+
+static int __init check_int(const void *check_data, const char *string,
+			    const char *fmt, int n_args, va_list ap)
+{
+	const int *pval = check_data;
+
+	_check_numbers_template("%d", pval, string, fmt, n_args, ap);
+}
+
+static int __init check_ushort(const void *check_data, const char *string,
+			       const char *fmt, int n_args, va_list ap)
+{
+	const unsigned short *pval = check_data;
+
+	_check_numbers_template("%hu", pval, string, fmt, n_args, ap);
+}
+
+static int __init check_short(const void *check_data, const char *string,
+			       const char *fmt, int n_args, va_list ap)
+{
+	const short *pval = check_data;
+
+	_check_numbers_template("%hd", pval, string, fmt, n_args, ap);
+}
+
+static int __init check_uchar(const void *check_data, const char *string,
+			       const char *fmt, int n_args, va_list ap)
+{
+	const unsigned char *pval = check_data;
+
+	_check_numbers_template("%hhu", pval, string, fmt, n_args, ap);
+}
+
+static int __init check_char(const void *check_data, const char *string,
+			       const char *fmt, int n_args, va_list ap)
+{
+	const signed char *pval = check_data;
+
+	_check_numbers_template("%hhd", pval, string, fmt, n_args, ap);
+}
+
+/* Selection of interesting numbers to test, copied from test-kstrtox.c */
+static const unsigned long long numbers[] __initconst = {
+	0x0ULL,
+	0x1ULL,
+	0x7fULL,
+	0x80ULL,
+	0x81ULL,
+	0xffULL,
+	0x100ULL,
+	0x101ULL,
+	0x7fffULL,
+	0x8000ULL,
+	0x8001ULL,
+	0xffffULL,
+	0x10000ULL,
+	0x10001ULL,
+	0x7fffffffULL,
+	0x80000000ULL,
+	0x80000001ULL,
+	0xffffffffULL,
+	0x100000000ULL,
+	0x100000001ULL,
+	0x7fffffffffffffffULL,
+	0x8000000000000000ULL,
+	0x8000000000000001ULL,
+	0xfffffffffffffffeULL,
+	0xffffffffffffffffULL,
+};
+
+#define value_representable_in_type(T, val)					 \
+(is_signed_type(T)								 \
+	? ((long long)(val) >= type_min(T)) && ((long long)(val) <= type_max(T)) \
+	: ((unsigned long long)(val) >= type_min(T)) &&				 \
+	  ((unsigned long long)(val) <= type_max(T)))
+
+#define test_one_number(T, gen_fmt, scan_fmt, val, fn)			\
+do {									\
+	const T expect_val = (T)(val);					\
+	T result = ~expect_val; /* should be overwritten */		\
+									\
+	snprintf(test_buffer, BUF_SIZE, gen_fmt, expect_val);		\
+	_test(fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
+} while (0)
+
+#define simple_numbers_loop(T, gen_fmt, scan_fmt, fn)			\
+do {									\
+	int i;								\
+									\
+	for (i = 0; i < ARRAY_SIZE(numbers); ++i) {			\
+		if (!value_representable_in_type(T, numbers[i]))	\
+			continue;					\
+									\
+		test_one_number(T, gen_fmt, scan_fmt, numbers[i], fn);	\
+									\
+		if (is_signed_type(T))					\
+			test_one_number(T, gen_fmt, scan_fmt,		\
+					-numbers[i], fn);		\
+	}								\
+} while (0)
+
+static void __init numbers_simple(void)
+{
+	simple_numbers_loop(unsigned long long,	"%llu",	  "llu", check_ull);
+	simple_numbers_loop(long long,		"%lld",	  "lld", check_ll);
+	simple_numbers_loop(long long,		"%lld",	  "lli", check_ll);
+	simple_numbers_loop(unsigned long long,	"%llx",	  "llx", check_ull);
+	simple_numbers_loop(long long,		"%llx",	  "llx", check_ll);
+	simple_numbers_loop(long long,		"0x%llx", "lli", check_ll);
+	simple_numbers_loop(unsigned long long, "0x%llx", "llx", check_ull);
+	simple_numbers_loop(long long,		"0x%llx", "llx", check_ll);
+
+	simple_numbers_loop(unsigned long,	"%lu",	  "lu", check_ulong);
+	simple_numbers_loop(long,		"%ld",	  "ld", check_long);
+	simple_numbers_loop(long,		"%ld",	  "li", check_long);
+	simple_numbers_loop(unsigned long,	"%lx",	  "lx", check_ulong);
+	simple_numbers_loop(long,		"%lx",	  "lx", check_long);
+	simple_numbers_loop(long,		"0x%lx",  "li", check_long);
+	simple_numbers_loop(unsigned long,	"0x%lx",  "lx", check_ulong);
+	simple_numbers_loop(long,		"0x%lx",  "lx", check_long);
+
+	simple_numbers_loop(unsigned int,	"%u",	  "u", check_uint);
+	simple_numbers_loop(int,		"%d",	  "d", check_int);
+	simple_numbers_loop(int,		"%d",	  "i", check_int);
+	simple_numbers_loop(unsigned int,	"%x",	  "x", check_uint);
+	simple_numbers_loop(int,		"%x",	  "x", check_int);
+	simple_numbers_loop(int,		"0x%x",   "i", check_int);
+	simple_numbers_loop(unsigned int,	"0x%x",   "x", check_uint);
+	simple_numbers_loop(int,		"0x%x",   "x", check_int);
+
+	simple_numbers_loop(unsigned short,	"%hu",	  "hu", check_ushort);
+	simple_numbers_loop(short,		"%hd",	  "hd", check_short);
+	simple_numbers_loop(short,		"%hd",	  "hi", check_short);
+	simple_numbers_loop(unsigned short,	"%hx",	  "hx", check_ushort);
+	simple_numbers_loop(short,		"%hx",	  "hx", check_short);
+	simple_numbers_loop(short,		"0x%hx",  "hi", check_short);
+	simple_numbers_loop(unsigned short,	"0x%hx",  "hx", check_ushort);
+	simple_numbers_loop(short,		"0x%hx",  "hx", check_short);
+
+	simple_numbers_loop(unsigned char,	"%hhu",	  "hhu", check_uchar);
+	simple_numbers_loop(signed char,	"%hhd",	  "hhd", check_char);
+	simple_numbers_loop(signed char,	"%hhd",	  "hhi", check_char);
+	simple_numbers_loop(unsigned char,	"%hhx",	  "hhx", check_uchar);
+	simple_numbers_loop(signed char,	"%hhx",	  "hhx", check_char);
+	simple_numbers_loop(signed char,	"0x%hhx", "hhi", check_char);
+	simple_numbers_loop(unsigned char,	"0x%hhx", "hhx", check_uchar);
+	simple_numbers_loop(signed char,	"0x%hhx", "hhx", check_char);
+}
+
+/*
+ * This gives a better variety of number "lengths" in a small sample than
+ * the raw prandom*() functions (Not mathematically rigorous!!).
+ * Variabilty of length and value is more important than perfect randomness.
+ */
+static u32 __init next_test_random(u32 max_bits)
+{
+	u32 n_bits = hweight32(prandom_u32_state(&rnd_state)) % (max_bits + 1);
+
+	return prandom_u32_state(&rnd_state) & (UINT_MAX >> (32 - n_bits));
+}
+
+static unsigned long long __init next_test_random_ull(void)
+{
+	u32 rand1 = prandom_u32_state(&rnd_state);
+	u32 n_bits = (hweight32(rand1) * 3) % 64;
+	u64 val = (u64)prandom_u32_state(&rnd_state) * rand1;
+
+	return val & (ULLONG_MAX >> (64 - n_bits));
+}
+
+#define random_for_type(T)				\
+	((T)(sizeof(T) <= sizeof(u32)			\
+		? next_test_random(BITS_PER_TYPE(T))	\
+		: next_test_random_ull()))
+
+/*
+ * Define a pattern of negative and positive numbers to ensure we get
+ * some of both within the small number of samples in a test string.
+ */
+#define NEGATIVES_PATTERN 0x3246	/* 00110010 01000110 */
+
+#define fill_random_array(arr)							\
+do {										\
+	unsigned int neg_pattern = NEGATIVES_PATTERN;				\
+	int i;									\
+										\
+	for (i = 0; i < ARRAY_SIZE(arr); ++i, neg_pattern >>= 1) {		\
+		(arr)[i] = random_for_type(typeof((arr)[0]));			\
+		if (is_signed_type(typeof((arr)[0])) && (neg_pattern & 1))	\
+			(arr)[i] = -(arr)[i];					\
+	}									\
+} while (0)
+
+/*
+ * Convenience wrapper around snprintf() to append at buf_pos in buf,
+ * updating buf_pos and returning the number of characters appended.
+ * On error buf_pos is not changed and return value is 0.
+ */
+static int __init __printf(4, 5)
+append_fmt(char *buf, int *buf_pos, int buf_len, const char *val_fmt, ...)
+{
+	va_list ap;
+	int field_len;
+
+	va_start(ap, val_fmt);
+	field_len = vsnprintf(buf + *buf_pos, buf_len - *buf_pos, val_fmt, ap);
+	va_end(ap);
+
+	if (field_len < 0)
+		field_len = 0;
+
+	*buf_pos += field_len;
+
+	return field_len;
+}
+
+/*
+ * Convenience function to append the field delimiter string
+ * to both the value string and format string buffers.
+ */
+static void __init append_delim(char *str_buf, int *str_buf_pos, int str_buf_len,
+				char *fmt_buf, int *fmt_buf_pos, int fmt_buf_len,
+				const char *delim_str)
+{
+	append_fmt(str_buf, str_buf_pos, str_buf_len, delim_str);
+	append_fmt(fmt_buf, fmt_buf_pos, fmt_buf_len, delim_str);
+}
+
+#define test_array_8(fn, check_data, string, fmt, arr)				\
+do {										\
+	BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);					\
+	_test(fn, check_data, string, fmt, 8,					\
+		&(arr)[0], &(arr)[1], &(arr)[2], &(arr)[3],			\
+		&(arr)[4], &(arr)[5], &(arr)[6], &(arr)[7]);			\
+} while (0)
+
+#define numbers_list_8(T, gen_fmt, field_sep, scan_fmt, fn)			\
+do {										\
+	int i, pos = 0, fmt_pos = 0;						\
+	T expect[8], result[8];							\
+										\
+	fill_random_array(expect);						\
+										\
+	for (i = 0; i < ARRAY_SIZE(expect); ++i) {				\
+		if (i != 0)							\
+			append_delim(test_buffer, &pos, BUF_SIZE,		\
+				     fmt_buffer, &fmt_pos, BUF_SIZE,		\
+				     field_sep);				\
+										\
+		append_fmt(test_buffer, &pos, BUF_SIZE, gen_fmt, expect[i]);	\
+		append_fmt(fmt_buffer, &fmt_pos, BUF_SIZE, "%%%s", scan_fmt);	\
+	}									\
+										\
+	test_array_8(fn, expect, test_buffer, fmt_buffer, result);		\
+} while (0)
+
+#define numbers_list_fix_width(T, gen_fmt, field_sep, width, scan_fmt, fn)	\
+do {										\
+	char full_fmt[16];							\
+										\
+	snprintf(full_fmt, sizeof(full_fmt), "%u%s", width, scan_fmt);		\
+	numbers_list_8(T, gen_fmt, field_sep, full_fmt, fn);			\
+} while (0)
+
+#define numbers_list_val_width(T, gen_fmt, field_sep, scan_fmt, fn)		\
+do {										\
+	int i, val_len, pos = 0, fmt_pos = 0;					\
+	T expect[8], result[8];							\
+										\
+	fill_random_array(expect);						\
+										\
+	for (i = 0; i < ARRAY_SIZE(expect); ++i) {				\
+		if (i != 0)							\
+			append_delim(test_buffer, &pos, BUF_SIZE,		\
+				     fmt_buffer, &fmt_pos, BUF_SIZE, field_sep);\
+										\
+		val_len = append_fmt(test_buffer, &pos, BUF_SIZE, gen_fmt,	\
+				     expect[i]);				\
+		append_fmt(fmt_buffer, &fmt_pos, BUF_SIZE,			\
+			   "%%%u%s", val_len, scan_fmt);			\
+	}									\
+										\
+	test_array_8(fn, expect, test_buffer, fmt_buffer, result);		\
+} while (0)
+
+static void __init numbers_list(const char *delim)
+{
+	numbers_list_8(unsigned long long, "%llu",   delim, "llu", check_ull);
+	numbers_list_8(long long,	   "%lld",   delim, "lld", check_ll);
+	numbers_list_8(long long,	   "%lld",   delim, "lli", check_ll);
+	numbers_list_8(unsigned long long, "%llx",   delim, "llx", check_ull);
+	numbers_list_8(unsigned long long, "0x%llx", delim, "llx", check_ull);
+	numbers_list_8(long long,	   "0x%llx", delim, "lli", check_ll);
+
+	numbers_list_8(unsigned long,	   "%lu",    delim, "lu", check_ulong);
+	numbers_list_8(long,		   "%ld",    delim, "ld", check_long);
+	numbers_list_8(long,		   "%ld",    delim, "li", check_long);
+	numbers_list_8(unsigned long,	   "%lx",    delim, "lx", check_ulong);
+	numbers_list_8(unsigned long,	   "0x%lx",  delim, "lx", check_ulong);
+	numbers_list_8(long,		   "0x%lx",  delim, "li", check_long);
+
+	numbers_list_8(unsigned int,	   "%u",     delim, "u", check_uint);
+	numbers_list_8(int,		   "%d",     delim, "d", check_int);
+	numbers_list_8(int,		   "%d",     delim, "i", check_int);
+	numbers_list_8(unsigned int,	   "%x",     delim, "x", check_uint);
+	numbers_list_8(unsigned int,	   "0x%x",   delim, "x", check_uint);
+	numbers_list_8(int,		   "0x%x",   delim, "i", check_int);
+
+	numbers_list_8(unsigned short,	   "%hu",    delim, "hu", check_ushort);
+	numbers_list_8(short,		   "%hd",    delim, "hd", check_short);
+	numbers_list_8(short,		   "%hd",    delim, "hi", check_short);
+	numbers_list_8(unsigned short,	   "%hx",    delim, "hx", check_ushort);
+	numbers_list_8(unsigned short,	   "0x%hx",  delim, "hx", check_ushort);
+	numbers_list_8(short,		   "0x%hx",  delim, "hi", check_short);
+
+	numbers_list_8(unsigned char,	   "%hhu",   delim, "hhu", check_uchar);
+	numbers_list_8(signed char,	   "%hhd",   delim, "hhd", check_char);
+	numbers_list_8(signed char,	   "%hhd",   delim, "hhi", check_char);
+	numbers_list_8(unsigned char,	   "%hhx",   delim, "hhx", check_uchar);
+	numbers_list_8(unsigned char,	   "0x%hhx", delim, "hhx", check_uchar);
+	numbers_list_8(signed char,	   "0x%hhx", delim, "hhi", check_char);
+}
+
+/*
+ * List of numbers separated by delim. Each field width specifier is the
+ * maximum possible digits for the given type and base.
+ */
+static void __init numbers_list_field_width_typemax(const char *delim)
+{
+	numbers_list_fix_width(unsigned long long, "%llu",   delim, 20, "llu", check_ull);
+	numbers_list_fix_width(long long,	   "%lld",   delim, 20, "lld", check_ll);
+	numbers_list_fix_width(long long,	   "%lld",   delim, 20, "lli", check_ll);
+	numbers_list_fix_width(unsigned long long, "%llx",   delim, 16, "llx", check_ull);
+	numbers_list_fix_width(unsigned long long, "0x%llx", delim, 18, "llx", check_ull);
+	numbers_list_fix_width(long long,	   "0x%llx", delim, 18, "lli", check_ll);
+
+#if BITS_PER_LONG == 64
+	numbers_list_fix_width(unsigned long,	"%lu",	     delim, 20, "lu", check_ulong);
+	numbers_list_fix_width(long,		"%ld",	     delim, 20, "ld", check_long);
+	numbers_list_fix_width(long,		"%ld",	     delim, 20, "li", check_long);
+	numbers_list_fix_width(unsigned long,	"%lx",	     delim, 16, "lx", check_ulong);
+	numbers_list_fix_width(unsigned long,	"0x%lx",     delim, 18, "lx", check_ulong);
+	numbers_list_fix_width(long,		"0x%lx",     delim, 18, "li", check_long);
+#else
+	numbers_list_fix_width(unsigned long,	"%lu",	     delim, 10, "lu", check_ulong);
+	numbers_list_fix_width(long,		"%ld",	     delim, 11, "ld", check_long);
+	numbers_list_fix_width(long,		"%ld",	     delim, 11, "li", check_long);
+	numbers_list_fix_width(unsigned long,	"%lx",	     delim, 8,  "lx", check_ulong);
+	numbers_list_fix_width(unsigned long,	"0x%lx",     delim, 10, "lx", check_ulong);
+	numbers_list_fix_width(long,		"0x%lx",     delim, 10, "li", check_long);
+#endif
+
+	numbers_list_fix_width(unsigned int,	"%u",	     delim, 10, "u", check_uint);
+	numbers_list_fix_width(int,		"%d",	     delim, 11, "d", check_int);
+	numbers_list_fix_width(int,		"%d",	     delim, 11, "i", check_int);
+	numbers_list_fix_width(unsigned int,	"%x",	     delim, 8,  "x", check_uint);
+	numbers_list_fix_width(unsigned int,	"0x%x",	     delim, 10, "x", check_uint);
+	numbers_list_fix_width(int,		"0x%x",	     delim, 10, "i", check_int);
+
+	numbers_list_fix_width(unsigned short,	"%hu",	     delim, 5, "hu", check_ushort);
+	numbers_list_fix_width(short,		"%hd",	     delim, 6, "hd", check_short);
+	numbers_list_fix_width(short,		"%hd",	     delim, 6, "hi", check_short);
+	numbers_list_fix_width(unsigned short,	"%hx",	     delim, 4, "hx", check_ushort);
+	numbers_list_fix_width(unsigned short,	"0x%hx",     delim, 6, "hx", check_ushort);
+	numbers_list_fix_width(short,		"0x%hx",     delim, 6, "hi", check_short);
+
+	numbers_list_fix_width(unsigned char,	"%hhu",	     delim, 3, "hhu", check_uchar);
+	numbers_list_fix_width(signed char,	"%hhd",	     delim, 4, "hhd", check_char);
+	numbers_list_fix_width(signed char,	"%hhd",	     delim, 4, "hhi", check_char);
+	numbers_list_fix_width(unsigned char,	"%hhx",	     delim, 2, "hhx", check_uchar);
+	numbers_list_fix_width(unsigned char,	"0x%hhx",    delim, 4, "hhx", check_uchar);
+	numbers_list_fix_width(signed char,	"0x%hhx",    delim, 4, "hhi", check_char);
+}
+
+/*
+ * List of numbers separated by delim. Each field width specifier is the
+ * exact length of the corresponding value digits in the string being scanned.
+ */
+static void __init numbers_list_field_width_val_width(const char *delim)
+{
+	numbers_list_val_width(unsigned long long, "%llu",   delim, "llu", check_ull);
+	numbers_list_val_width(long long,	   "%lld",   delim, "lld", check_ll);
+	numbers_list_val_width(long long,	   "%lld",   delim, "lli", check_ll);
+	numbers_list_val_width(unsigned long long, "%llx",   delim, "llx", check_ull);
+	numbers_list_val_width(unsigned long long, "0x%llx", delim, "llx", check_ull);
+	numbers_list_val_width(long long,	   "0x%llx", delim, "lli", check_ll);
+
+	numbers_list_val_width(unsigned long,	"%lu",	     delim, "lu", check_ulong);
+	numbers_list_val_width(long,		"%ld",	     delim, "ld", check_long);
+	numbers_list_val_width(long,		"%ld",	     delim, "li", check_long);
+	numbers_list_val_width(unsigned long,	"%lx",	     delim, "lx", check_ulong);
+	numbers_list_val_width(unsigned long,	"0x%lx",     delim, "lx", check_ulong);
+	numbers_list_val_width(long,		"0x%lx",     delim, "li", check_long);
+
+	numbers_list_val_width(unsigned int,	"%u",	     delim, "u", check_uint);
+	numbers_list_val_width(int,		"%d",	     delim, "d", check_int);
+	numbers_list_val_width(int,		"%d",	     delim, "i", check_int);
+	numbers_list_val_width(unsigned int,	"%x",	     delim, "x", check_uint);
+	numbers_list_val_width(unsigned int,	"0x%x",	     delim, "x", check_uint);
+	numbers_list_val_width(int,		"0x%x",	     delim, "i", check_int);
+
+	numbers_list_val_width(unsigned short,	"%hu",	     delim, "hu", check_ushort);
+	numbers_list_val_width(short,		"%hd",	     delim, "hd", check_short);
+	numbers_list_val_width(short,		"%hd",	     delim, "hi", check_short);
+	numbers_list_val_width(unsigned short,	"%hx",	     delim, "hx", check_ushort);
+	numbers_list_val_width(unsigned short,	"0x%hx",     delim, "hx", check_ushort);
+	numbers_list_val_width(short,		"0x%hx",     delim, "hi", check_short);
+
+	numbers_list_val_width(unsigned char,	"%hhu",	     delim, "hhu", check_uchar);
+	numbers_list_val_width(signed char,	"%hhd",	     delim, "hhd", check_char);
+	numbers_list_val_width(signed char,	"%hhd",	     delim, "hhi", check_char);
+	numbers_list_val_width(unsigned char,	"%hhx",	     delim, "hhx", check_uchar);
+	numbers_list_val_width(unsigned char,	"0x%hhx",    delim, "hhx", check_uchar);
+	numbers_list_val_width(signed char,	"0x%hhx",    delim, "hhi", check_char);
+}
+
+/*
+ * Slice a continuous string of digits without field delimiters, containing
+ * numbers of varying length, using the field width to extract each group
+ * of digits. For example the hex values c0,3,bf01,303 would have a
+ * string representation of "c03bf01303" and extracted with "%2x%1x%4x%3x".
+ */
+static void __init numbers_slice(void)
+{
+	numbers_list_field_width_val_width("");
+}
+
+#define test_number_prefix(T, str, scan_fmt, expect0, expect1, n_args, fn)	\
+do {										\
+	const T expect[2] = { expect0, expect1 };				\
+	T result[2] = {~expect[0], ~expect[1]};					\
+										\
+	_test(fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
+} while (0)
+
+/*
+ * Number prefix is >= field width.
+ * Expected behaviour is derived from testing userland sscanf.
+ */
+static void __init numbers_prefix_overflow(void)
+{
+	/*
+	 * Negative decimal with a field of width 1, should quit scanning
+	 * and return 0.
+	 */
+	test_number_prefix(long long,	"-1 1", "%1lld %lld",	0, 0, 0, check_ll);
+	test_number_prefix(long,	"-1 1", "%1ld %ld",	0, 0, 0, check_long);
+	test_number_prefix(int,		"-1 1", "%1d %d",	0, 0, 0, check_int);
+	test_number_prefix(short,	"-1 1", "%1hd %hd",	0, 0, 0, check_short);
+	test_number_prefix(signed char,	"-1 1", "%1hhd %hhd",	0, 0, 0, check_char);
+
+	test_number_prefix(long long,	"-1 1", "%1lli %lli",	0, 0, 0, check_ll);
+	test_number_prefix(long,	"-1 1", "%1li %li",	0, 0, 0, check_long);
+	test_number_prefix(int,		"-1 1", "%1i %i",	0, 0, 0, check_int);
+	test_number_prefix(short,	"-1 1", "%1hi %hi",	0, 0, 0, check_short);
+	test_number_prefix(signed char,	"-1 1", "%1hhi %hhi",	0, 0, 0, check_char);
+
+	/*
+	 * 0x prefix in a field of width 1: 0 is a valid digit so should
+	 * convert. Next field scan starts at the 'x' which isn't a digit so
+	 * scan quits with one field converted.
+	 */
+	test_number_prefix(unsigned long long,	"0xA7", "%1llx%llx", 0, 0, 1, check_ull);
+	test_number_prefix(unsigned long,	"0xA7", "%1lx%lx",   0, 0, 1, check_ulong);
+	test_number_prefix(unsigned int,	"0xA7", "%1x%x",     0, 0, 1, check_uint);
+	test_number_prefix(unsigned short,	"0xA7", "%1hx%hx",   0, 0, 1, check_ushort);
+	test_number_prefix(unsigned char,	"0xA7", "%1hhx%hhx", 0, 0, 1, check_uchar);
+	test_number_prefix(long long,		"0xA7", "%1lli%llx", 0, 0, 1, check_ll);
+	test_number_prefix(long,		"0xA7", "%1li%lx",   0, 0, 1, check_long);
+	test_number_prefix(int,			"0xA7", "%1i%x",     0, 0, 1, check_int);
+	test_number_prefix(short,		"0xA7", "%1hi%hx",   0, 0, 1, check_short);
+	test_number_prefix(char,		"0xA7", "%1hhi%hhx", 0, 0, 1, check_char);
+
+	/*
+	 * 0x prefix in a field of width 2 using %x conversion: first field
+	 * converts to 0. Next field scan starts at the character after "0x".
+	 * Both fields will convert.
+	 */
+	test_number_prefix(unsigned long long,	"0xA7", "%2llx%llx", 0, 0xa7, 2, check_ull);
+	test_number_prefix(unsigned long,	"0xA7", "%2lx%lx",   0, 0xa7, 2, check_ulong);
+	test_number_prefix(unsigned int,	"0xA7", "%2x%x",     0, 0xa7, 2, check_uint);
+	test_number_prefix(unsigned short,	"0xA7", "%2hx%hx",   0, 0xa7, 2, check_ushort);
+	test_number_prefix(unsigned char,	"0xA7", "%2hhx%hhx", 0, 0xa7, 2, check_uchar);
+
+	/*
+	 * 0x prefix in a field of width 2 using %i conversion: first field
+	 * converts to 0. Next field scan starts at the character after "0x",
+	 * which will convert if can be intepreted as decimal but will fail
+	 * if it contains any hex digits (since no 0x prefix).
+	 */
+	test_number_prefix(long long,	"0x67", "%2lli%lli", 0, 67, 2, check_ll);
+	test_number_prefix(long,	"0x67", "%2li%li",   0, 67, 2, check_long);
+	test_number_prefix(int,		"0x67", "%2i%i",     0, 67, 2, check_int);
+	test_number_prefix(short,	"0x67", "%2hi%hi",   0, 67, 2, check_short);
+	test_number_prefix(char,	"0x67", "%2hhi%hhi", 0, 67, 2, check_char);
+
+	test_number_prefix(long long,	"0xA7", "%2lli%lli", 0, 0,  1, check_ll);
+	test_number_prefix(long,	"0xA7", "%2li%li",   0, 0,  1, check_long);
+	test_number_prefix(int,		"0xA7", "%2i%i",     0, 0,  1, check_int);
+	test_number_prefix(short,	"0xA7", "%2hi%hi",   0, 0,  1, check_short);
+	test_number_prefix(char,	"0xA7", "%2hhi%hhi", 0, 0,  1, check_char);
+}
+
+#define _test_simple_strtoxx(T, fn, gen_fmt, expect, base)			\
+do {										\
+	T got;									\
+	char *endp;								\
+	int len;								\
+	bool fail = false;							\
+										\
+	++total_tests;								\
+	len = snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);			\
+	got = (fn)(test_buffer, &endp, base);					\
+	pr_debug(#fn "(\"%s\", %d) -> " gen_fmt "\n", test_buffer, base, got);	\
+	if (got != (expect)) {							\
+		fail = true;							\
+		pr_warn(#fn "(\"%s\", %d): got " gen_fmt " expected " gen_fmt "\n", \
+			test_buffer, base, got, expect);			\
+	} else if (endp != test_buffer + len) {					\
+		fail = true;							\
+		pr_warn(#fn "(\"%s\", %d) startp=0x%px got endp=0x%px expected 0x%px\n", \
+			test_buffer, base, test_buffer,				\
+			test_buffer + len, endp);				\
+	}									\
+										\
+	if (fail)								\
+		++failed_tests;							\
+} while (0)
+
+#define test_simple_strtoxx(T, fn, gen_fmt, base)				\
+do {										\
+	int i;									\
+										\
+	for (i = 0; i < ARRAY_SIZE(numbers); ++i) {				\
+		_test_simple_strtoxx(T, fn, gen_fmt, (T)numbers[i], base);	\
+										\
+		if (is_signed_type(T))						\
+			_test_simple_strtoxx(T, fn, gen_fmt,			\
+					      -(T)numbers[i], base);		\
+	}									\
+} while (0)
+
+static void __init test_simple_strtoull(void)
+{
+	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   10);
+	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llu",   0);
+	test_simple_strtoxx(unsigned long long, simple_strtoull, "%llx",   16);
+	test_simple_strtoxx(unsigned long long, simple_strtoull, "0x%llx", 16);
+	test_simple_strtoxx(unsigned long long, simple_strtoull, "0x%llx", 0);
+}
+
+static void __init test_simple_strtoll(void)
+{
+	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 10);
+	test_simple_strtoxx(long long, simple_strtoll, "%lld",	 0);
+	test_simple_strtoxx(long long, simple_strtoll, "%llx",	 16);
+	test_simple_strtoxx(long long, simple_strtoll, "0x%llx", 16);
+	test_simple_strtoxx(long long, simple_strtoll, "0x%llx", 0);
+}
+
+static void __init test_simple_strtoul(void)
+{
+	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   10);
+	test_simple_strtoxx(unsigned long, simple_strtoul, "%lu",   0);
+	test_simple_strtoxx(unsigned long, simple_strtoul, "%lx",   16);
+	test_simple_strtoxx(unsigned long, simple_strtoul, "0x%lx", 16);
+	test_simple_strtoxx(unsigned long, simple_strtoul, "0x%lx", 0);
+}
+
+static void __init test_simple_strtol(void)
+{
+	test_simple_strtoxx(long, simple_strtol, "%ld",   10);
+	test_simple_strtoxx(long, simple_strtol, "%ld",   0);
+	test_simple_strtoxx(long, simple_strtol, "%lx",   16);
+	test_simple_strtoxx(long, simple_strtol, "0x%lx", 16);
+	test_simple_strtoxx(long, simple_strtol, "0x%lx", 0);
+}
+
+/* Selection of common delimiters/separators between numbers in a string. */
+static const char * const number_delimiters[] __initconst = {
+	" ", ":", ",", "-", "/",
+};
+
+static void __init test_numbers(void)
+{
+	int i;
+
+	/* String containing only one number. */
+	numbers_simple();
+
+	/* String with multiple numbers separated by delimiter. */
+	for (i = 0; i < ARRAY_SIZE(number_delimiters); ++i) {
+		numbers_list(number_delimiters[i]);
+
+		/* Field width may be longer than actual field digits. */
+		numbers_list_field_width_typemax(number_delimiters[i]);
+
+		/* Each field width exactly length of actual field digits. */
+		numbers_list_field_width_val_width(number_delimiters[i]);
+	}
+
+	/* Slice continuous sequence of digits using field widths. */
+	numbers_slice();
+
+	numbers_prefix_overflow();
+}
+
+static void __init selftest(void)
+{
+	test_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
+	if (!test_buffer)
+		return;
+
+	fmt_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
+	if (!fmt_buffer)
+		return;
+
+	prandom_seed_state(&rnd_state, 3141592653589793238ULL);
+
+	test_numbers();
+
+	test_simple_strtoull();
+	test_simple_strtoll();
+	test_simple_strtoul();
+	test_simple_strtol();
+}
+
+KSTM_MODULE_LOADERS(test_scanf);
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

