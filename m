Return-Path: <linux-kselftest+bounces-26672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930BA362EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2AD188FEF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E186267B17;
	Fri, 14 Feb 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqK3BHfX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA63267AE8;
	Fri, 14 Feb 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550023; cv=none; b=ADr9DUv3eek/HKmOck/TG/J4FDuyKoKU0a2fscNn7zYXCXDl4+S25FR/24fNwj6Kh05jroecwSzhzeUK/0YbdAskEVHn2E9/mhCuYSwKV47s3nvW0+xwlckduKyA0xe6zarKPtgRKxFecYPxiyCf5xqVJg8BtnVk8RyfAEDhey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550023; c=relaxed/simple;
	bh=hFIdtrrfEFBYDz5o5JUKbXTS33/240JJ6HCd+hbDb8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isnh6ZSb/1Oan8bwwcX8qyIWWinlz/RmtJfN4F3ZmZiWesKaBn9UKo/E7cvhIBZVk+s9lIv5GRqEgDY32OhhSrlY+IZoHLj2X0J+809nwuaMRCNeYFVHOBlAnLssY7GviuSioMG2eiEe2BgxyNJ1x/iLaJIpNqr3rxYtZKCv70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqK3BHfX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471b36d6766so19958461cf.2;
        Fri, 14 Feb 2025 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550020; x=1740154820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HY5XrygemAI7GO6XQVsrwKH+b6zMhA6wwjDH5Lplluc=;
        b=LqK3BHfX349qlDAA/vmlEfBghB744Cjfiqd5YbweeFfmRYN9LuzCn3DpYWzsVRwuGm
         DOZasQYSGkpyr8o0eZD/SqkpoFdgCV094ihdvsjO0VoKTQAZzpftcYYUC6VhH+EGe/CB
         2XgqWwOeiBMItCBHQt1BHyI+fQJTpK5jnBpKY53yGJXUf3KaWo4GqfQF+VZPJYKv2s+T
         SuRTqgw0a/q7DmkKeN5XPlFiunA6qEIXsmSZIXoLWRWT101UjI7b66TqkVwqKV92hbkL
         ZTjvAxvUSIwQQ0IpYDNQA1DvJbFmRDsu5F0GilfYg+4mQoGBvLKm6c8DazxcpfnDI1cw
         zZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550020; x=1740154820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY5XrygemAI7GO6XQVsrwKH+b6zMhA6wwjDH5Lplluc=;
        b=Pfmp+Cg2hLi3QoKg08PwxOQQIjNPohuQTWB0pPJE67R9WYwea0zvEe5eLRtKxYXYb7
         SsJ6OPhNEdePtJOAyrkAzmS6POv552Yk+u0qaspFimyGQqe3aIbCo1T+suZZxgzASUlK
         nyYaO9SSCEYj9iahybFFogtBrZb7nVzvj2VZJIPyWAzZkFDJyVVpak0ImEdHRQhHKKUO
         j9x1PFn4Z7BBycBHENSZzax0J8xo/yUVMezeRKBnB2wRhaFH5vLOnzKTnaCKwblCkuV9
         cX7tUa5l7FFvUxqGpTo/POBvl2qnkbziPnSKU2V4XeqttzY96FDANjjbbtQGQm/fX6KK
         EYAw==
X-Forwarded-Encrypted: i=1; AJvYcCUFPBvLOxuCwkVKV2uK+NxxwDNhtKZMVqa6Xm6eTjTgEq/ENpO5rDnskqP+3MdBXHTFkJSBSuYx8VsqkCo=@vger.kernel.org, AJvYcCUwSSpXG6csK13i0yc7BsGxbdp0t90B/wlJV0BjZQKD7bJ7yiOkh7Sr4uYI8qyHimXd8eW1uZdfYiVb0eBlQ2my@vger.kernel.org
X-Gm-Message-State: AOJu0Ywea9O9tyUoUZVkSPwyRM3bgn41ui7Vq+h3uoTmG6+402HT+ES3
	ICEqIDs+JE0XiQEpot35/au5YRwuBhAQR7Nj4ci0tSGc0NHSi3Ae
X-Gm-Gg: ASbGncv6bNcV3XvIZP9oi/S5QbiUuxNYgp9fB2PIFf/aBzlRVDG9vQbLbdR5aye0dHB
	HVGhjY/Up6J3cCqA61Q/OilE5CtyFSpnuC3GNR9hb8U4Q1TKiIAXfcn6Dd+yfdPi45MuUCPoG/H
	zs6Um0NGcYkny3mkXyXyRMo587xe67kUDbwacfZufzlCxcbq+JcsUBf3UF8FVy44j9th8+RiLQN
	g8X22fnT2uuy31RoJsBGv9+ZRfew1/gebtMNPe1Cbg3JjH65eFMR6RQTHOIfW5N8bVreHn8G4JX
	nyhF5qxvYRSWoLzFYP9aeBDUEKhvVyf6xVWPAw==
X-Google-Smtp-Source: AGHT+IEEligZE+6AVvNn+kyi+tOG0B57/J0XUYVp2UKssML2RX4ygkFmKyYDx8RbUoBtxNhzoM6S6Q==
X-Received: by 2002:a05:622a:189a:b0:467:5d0b:c750 with SMTP id d75a77b69052e-471bed70234mr118061011cf.22.1739550020087;
        Fri, 14 Feb 2025 08:20:20 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:d4df:402c:65f0:87da])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af37c7sm19196911cf.61.2025.02.14.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:20:19 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 11:20:01 -0500
Subject: [PATCH v8 4/4] scanf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
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

Use `suite_init` and move some tests into `scanf_test_cases`. This
gives us nicer output in the event of a failure.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/tests/scanf_kunit.c | 95 ++++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 44 deletions(-)

diff --git a/lib/tests/scanf_kunit.c b/lib/tests/scanf_kunit.c
index 3bbad9ebe437..fa215a7db366 100644
--- a/lib/tests/scanf_kunit.c
+++ b/lib/tests/scanf_kunit.c
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
 
@@ -50,10 +46,9 @@ do {										\
 	for (; n_args > 0; n_args--, expect++) {				\
 		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
 		if (got != *expect) {						\
-			KUNIT_FAIL(test,					\
-				   "%s:%d: vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt, \
-				   file, line, str, fmt, *expect, got);		\
-			return;							\
+			KUNIT_FAIL_AND_ABORT(test,				\
+					     "%s:%d: vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt, \
+					     file, line, str, fmt, *expect, got); \
 		}								\
 	}									\
 } while (0)
@@ -435,8 +430,11 @@ static void numbers_list_hh(struct kunit *test, const char *delim)
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
@@ -507,8 +505,11 @@ static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
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
@@ -570,8 +571,11 @@ static void numbers_list_field_width_val_hh(struct kunit *test, const char *deli
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
@@ -587,7 +591,12 @@ static void numbers_list_field_width_val_width(struct kunit *test, const char *d
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
@@ -738,62 +747,60 @@ static const char * const number_delimiters[] = {
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


