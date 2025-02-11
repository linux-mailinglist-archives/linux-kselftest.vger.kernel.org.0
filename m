Return-Path: <linux-kselftest+bounces-26370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE7A30F65
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5EE1889487
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F1253B71;
	Tue, 11 Feb 2025 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDG+dRtl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3533253B55;
	Tue, 11 Feb 2025 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286827; cv=none; b=OSUx7sAkuQ+z4M65VAq97aFufclifG5p0v+SvKAknDVFIwtIiSR/IWwNcPw5CV/MJcbXyNymM9jxUoelH6HP2I8b1mCxUBGW9DpcsYdJf78Ie4Ku3jhfeKHDJX7WbExfCrq2UAO0IcPw5CL75Max2+8nKcbFxy3yLcP8mbWcB+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286827; c=relaxed/simple;
	bh=sGPGAPbPi8JxaoEKmeQN239YVL0AtONWi23etT5fO6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C08YwWXJiZ+Q3GXK0gjz2agqjnqsQgb9HbaOu3is4UcrxZ8//1MGR8a1RrLjKF9x7+tLOc+dTnD+gSuGnBTuiasDWQD4Z7v5+0prNgkUmAx56m0OvF10A7sV5xqY8h2kq3wxeGKbSfzvWBng2dST/5JvMnXn0Eim/RHkhL8VGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDG+dRtl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c05b700b78so245322185a.2;
        Tue, 11 Feb 2025 07:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739286823; x=1739891623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+0LNzXsk2KPncZd4dsHjBovUHzuOi3+o4xFnOGM9LU=;
        b=cDG+dRtlYNrrY4dPmcOHHa9Pavny2/qxWu2e7NKBdq0u/dZFmfvCqfbyNQZQ/OxA5l
         mr5pdUrkB/KOEpUSJZQ042CTkMa2VlLcrhMuotNEererQXAEy1Tk8DZICHsFwBpd2gt4
         AMKjD1rqpA2xkgtcpHRPTLOsgNy4vy6olA3DXafcdPz0a7qG3wnHDsmOfkj6b76w6UnF
         zxzy8WUqGk1XT4hCT39lDDoR+xT12UIn9X5oWdl7DwN11knQ4LQlQiqdw05ndoHNksHx
         VtZvHvwdR8xjwgWY1BZoYse8fQnTzfp5Cd2AoTLaM2/mLgWhF+bW31FvhCt4Q3Zud8uH
         Sf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286823; x=1739891623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+0LNzXsk2KPncZd4dsHjBovUHzuOi3+o4xFnOGM9LU=;
        b=NOG5yA9U0vwGQrjfJiAer5ZsIk74grWPw/6xx64k9sWjKXzJpfuSHeNb9WJUrHiOPZ
         h/CQZEpbZlFb1g24Y+j7yyhJhE+ZKyQRG9Dt+1O6ydT8CsHFgUwGMoVVilqz35mC3hZT
         MYfK+yFEJ3Fdo1Uz0MuiL1beumbcGqIHLL2aSIZJ0j8snJRHKLdU0NE6HxWGOz9y3U5L
         wWqXk+3SY+3EC9JePIWn0BZpzm+6g+IW/iSX1Plo0CIn6Mn9zgFzHiqGWLY9B2O4ICh0
         lv5xOBQz56X777htYmcOow84nYM95HWDNiO2keMIoQLrSFD/PgazUhXZZUDkc3C0wgi4
         nzUg==
X-Forwarded-Encrypted: i=1; AJvYcCW/iVFUFKi7wAJnX3ou1a6kLYX5w5Fduu76XRW4m42nd0AYppcKafbHrzQzKwJqT3VouOX94bbw1+2CATnmR1JE@vger.kernel.org, AJvYcCXDzouRFpv7Zkp6voEFckKfIX22KsSEjzY8IFrsVZEj1xTNACgzGXQD7hmgfPX1FLh0P3gQOa2mzlxa/9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUWKg6eWBoBd64mGNX+UvWSSQHaHcGtXMtOepGF9obV5mYZVRb
	MIPBQlmi5vRoy/LptLEw+EJJwCtHMpgd9Aoj3RmeiNdbXsjtReOp
X-Gm-Gg: ASbGncvV5ka8T/NrZ4pxM9C4/5Z362QE9yZxp0jvjdMu54iuwHaqXwk/TEDqBiMKocV
	hNokV1OMRjbHtQB8+X+CQYbVc84tJC6sl+0KlI2sIexFCJc7tEx8ZBdi2b3RKf/ZaWbRcYDohGj
	x78j8fZnyq29XFM3qwzvfKTsK+y3cXbQqzb0Nyg/5n6Hcvxg1ft3ZeFdMh22peu8hN9DxWo8Cnj
	+RsXA88CWzYD/8oteu+qFmUiOdtg6RduUM0gNCLD2phPLhazB1dJy9BZttOQ73DMd9qApkvueKo
	CIecn3St5LOgdCFyDLeX6a4/BWGCAEBLZjpW
X-Google-Smtp-Source: AGHT+IHmtGbCZ88Uw/Mx5GR07uJJiOTJ+5cj0A+jNWH7n/2O8el6g595EOs70D42djWe1McargbnNg==
X-Received: by 2002:a05:620a:8010:b0:7c0:5e7f:e199 with SMTP id af79cd13be357-7c06f4148a8mr16776285a.33.1739286823459;
        Tue, 11 Feb 2025 07:13:43 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2620:10d:c091:600::1:b3ba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47193e581cesm26852561cf.40.2025.02.11.07.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:13:43 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 10:13:39 -0500
Subject: [PATCH v7 3/3] scanf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-scanf-kunit-convert-v7-3-c057f0a3d9d8@gmail.com>
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
In-Reply-To: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use `suite_init` and move some tests into `scanf_test_cases`. This
gives us nicer output in the event of a failure.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/scanf_kunit.c | 94 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/lib/scanf_kunit.c b/lib/scanf_kunit.c
index 196a654680c4..e7b40c8eb53e 100644
--- a/lib/scanf_kunit.c
+++ b/lib/scanf_kunit.c
@@ -4,14 +4,10 @@
  */
 
 #include <kunit/test.h>
-#include <linux/bitops.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/overflow.h>
-#include <linux/printk.h>
 #include <linux/prandom.h>
 #include <linux/slab.h>
-#include <linux/string.h>
+#include <linux/sprintf.h>
 
 #define BUF_SIZE 1024
 
@@ -49,9 +45,9 @@ do {										\
 	for (; n_args > 0; n_args--, expect++) {				\
 		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
 		if (got != *expect) {						\
-			KUNIT_FAIL(test,					\
-				   "vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt, \
-				   str, fmt, *expect, got);			\
+			KUNIT_FAIL_AND_ABORT(test,				\
+					     "vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt, \
+					     str, fmt, *expect, got);		\
 		}								\
 	}									\
 } while (0)
@@ -429,8 +425,11 @@ static void numbers_list_hh(struct kunit *test, const char *delim)
 	numbers_list_8(signed char,	   "0x%hhx", delim, "hhi", check_char);
 }
 
-static void numbers_list(struct kunit *test, const char *delim)
+static void numbers_list(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_ll(test, delim);
 	numbers_list_l(test, delim);
 	numbers_list_d(test, delim);
@@ -501,8 +500,11 @@ static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
  * List of numbers separated by delim. Each field width specifier is the
  * maximum possible digits for the given type and base.
  */
-static void numbers_list_field_width_typemax(struct kunit *test, const char *delim)
+static void numbers_list_field_width_typemax(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_field_width_ll(test, delim);
 	numbers_list_field_width_l(test, delim);
 	numbers_list_field_width_d(test, delim);
@@ -564,8 +566,11 @@ static void numbers_list_field_width_val_hh(struct kunit *test, const char *deli
  * List of numbers separated by delim. Each field width specifier is the
  * exact length of the corresponding value digits in the string being scanned.
  */
-static void numbers_list_field_width_val_width(struct kunit *test, const char *delim)
+static void numbers_list_field_width_val_width(struct kunit *test)
 {
+	const char * const *param = test->param_value;
+	const char *delim = *param;
+
 	numbers_list_field_width_val_ll(test, delim);
 	numbers_list_field_width_val_l(test, delim);
 	numbers_list_field_width_val_d(test, delim);
@@ -581,7 +586,12 @@ static void numbers_list_field_width_val_width(struct kunit *test, const char *d
  */
 static void numbers_slice(struct kunit *test)
 {
-	numbers_list_field_width_val_width(test, "");
+	const char *delim = "";
+
+	KUNIT_ASSERT_PTR_EQ(test, test->param_value, NULL);
+	test->param_value = &delim;
+
+	numbers_list_field_width_val_width(test);
 }
 
 #define test_number_prefix(T, str, scan_fmt, expect0, expect1, n_args, fn)	\
@@ -732,62 +742,60 @@ static const char * const number_delimiters[] = {
 	" ", ":", ",", "-", "/",
 };
 
-static void test_numbers(struct kunit *test)
+static void number_delimiter_param_desc(const char * const *param,
+					   char *desc)
 {
-	int i;
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "\"%s\"", *param);
+}
 
-	/* String containing only one number. */
-	numbers_simple(test);
+KUNIT_ARRAY_PARAM(number_delimiters, number_delimiters, number_delimiter_param_desc);
 
+static struct kunit_case scanf_test_cases[] = {
+	KUNIT_CASE(numbers_simple),
 	/* String with multiple numbers separated by delimiter. */
-	for (i = 0; i < ARRAY_SIZE(number_delimiters); i++) {
-		numbers_list(test, number_delimiters[i]);
-
-		/* Field width may be longer than actual field digits. */
-		numbers_list_field_width_typemax(test, number_delimiters[i]);
-
-		/* Each field width exactly length of actual field digits. */
-		numbers_list_field_width_val_width(test, number_delimiters[i]);
-	}
-
+	KUNIT_CASE_PARAM(numbers_list, number_delimiters_gen_params),
+	/* Field width may be longer than actual field digits. */
+	KUNIT_CASE_PARAM(numbers_list_field_width_typemax, number_delimiters_gen_params),
+	/* Each field width exactly length of actual field digits. */
+	KUNIT_CASE_PARAM(numbers_list_field_width_val_width, number_delimiters_gen_params),
 	/* Slice continuous sequence of digits using field widths. */
-	numbers_slice(test);
+	KUNIT_CASE(numbers_slice),
+	KUNIT_CASE(numbers_prefix_overflow),
 
-	numbers_prefix_overflow(test);
-}
+	KUNIT_CASE(test_simple_strtoull),
+	KUNIT_CASE(test_simple_strtoll),
+	KUNIT_CASE(test_simple_strtoul),
+	KUNIT_CASE(test_simple_strtol),
+	{}
+};
 
-static void scanf_test(struct kunit *test)
+static int scanf_suite_init(struct kunit_suite *suite)
 {
 	test_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
 	if (!test_buffer)
-		return;
+		return -ENOMEM;
 
 	fmt_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
 	if (!fmt_buffer) {
 		kfree(test_buffer);
-		return;
+		return -ENOMEM;
 	}
 
 	prandom_seed_state(&rnd_state, 3141592653589793238ULL);
 
-	test_numbers(test);
-
-	test_simple_strtoull(test);
-	test_simple_strtoll(test);
-	test_simple_strtoul(test);
-	test_simple_strtol(test);
+	return 0;
+}
 
+static void scanf_suite_exit(struct kunit_suite *suite)
+{
 	kfree(fmt_buffer);
 	kfree(test_buffer);
 }
 
-static struct kunit_case scanf_test_cases[] = {
-	KUNIT_CASE(scanf_test),
-	{}
-};
-
 static struct kunit_suite scanf_test_suite = {
 	.name = "scanf",
+	.suite_init = scanf_suite_init,
+	.suite_exit = scanf_suite_exit,
 	.test_cases = scanf_test_cases,
 };
 

-- 
2.48.1


