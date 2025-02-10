Return-Path: <linux-kselftest+bounces-26179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A13A2F09F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E3A1889F31
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A623E224;
	Mon, 10 Feb 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNrxMIS5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821623BFB1;
	Mon, 10 Feb 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199614; cv=none; b=C8vuryXak3C13amXgK6Pq9s1srb9XS7nBwLOEvokMM2EVlzj1BE229MApO4iD/B3KA7tL+xmgYxWNXZ7hMENC8+lQOwgowNkBrE3OIYHC1yOnAMMeffSSMMKW9MPjHcLZtffhVbD2zBMMjQ1Tbl15Qe5v0me6AJQFi092AGAgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199614; c=relaxed/simple;
	bh=dNH+vCGkNKUYvJZpe4rc+dzG4ZA1+2pvSU3hWULC3rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/QwNLT1A+fILjc+41Jguk5C7sEX59tyUFeNAAf4MD2M3vLJUNLCBtSCsbsFtUGOKvz9Xs1nSMRATwv4twc8LixBU11LsaRkmqHd3HyavrDwtyGOjSYCKrMLQAboTGdFHGZy34g/aM/fQnRho7rQIh1a33h1Xka0hj0aZca8W7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNrxMIS5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd01781b56so53705746d6.0;
        Mon, 10 Feb 2025 07:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739199611; x=1739804411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7DBPHawe1w2zPyykaNrXkuyxCSGjUg76DVdAT9zI60=;
        b=cNrxMIS58LFbBDSDSKopOPitWY9xlQLDCOlFrXP2G97fAzHgbtumHsOvLl+7TsF1ro
         snV9UtqlQSlW4Gz+VOHMxKOGFZkzf4p7C1Yh9Npqy9twpqwTlyE+Xwp12+00QB9AnOJj
         dcS9VUncGMxZkF33iw9UgBoP1jfmeo3D3p4eWB5YlyWQmAqfoE5/yh1kF7NAjrNxrsFS
         Lp/Ri95P8PytoMa3Vw2HlmYpLixDLj7pytOwCQIrVH0vR7pFSOWJf21WyrPohXhP9AOM
         KnfZIWGNyL1q2DcsIZgTr80JpksCOINuEfOGzwDProyU9sI4zZUExicwY1Q7IN4BEU95
         Tkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739199611; x=1739804411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7DBPHawe1w2zPyykaNrXkuyxCSGjUg76DVdAT9zI60=;
        b=G61mKv25hizcos8WkRmxTzdLRdD/RVFcdfDm2yNeOQ7FRe07/FMOarnotgA2+TjzKo
         FOLptB3lhuc89XGMigI9ddxFbnhRJ0POK5qJA8yF4GAbXKLL5pdLM0JPkb3xU4j+qvEh
         /PSQe1tni++DNooSz1XMKSACmuTeQq4ugKxwYCXjYOrCPwnVIIvQu1GD592I0In+MJkh
         /A8FO2XA6ZfQO1mSf6mcoiy1TlLuTpYSsiaaHHmnWF2GJbQZRbM+RBtuU65iaIK4QGRJ
         nQ1Myy7eAPEeLv5Ys4Rw/Tv+AD5O9vMEI/ssik2kyFvur4tU4WYOnZMg6940ERZClvZX
         IY/g==
X-Forwarded-Encrypted: i=1; AJvYcCU6Um1g+mmYhvadz0wwAWjIu/94fRdcxwTmNyBaAvYxZiR6Fctmvr+wi6lpnol9mwyhz2eLJS92OsB9IPk=@vger.kernel.org, AJvYcCWFAlC2TpdRnrqQ+Nw18BxUzDuavzqWAQp4uIbEfUMuZyztZv3f8oUQweY1xDPIa6Rm5oLV0gvZEGrdAj81XmOX@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVtAC/pmuzqJD0wzudtIuXJbD3CFOcRlyhbsBG7yBUU2w6JEr
	LHrwLxPTuNPUgSMSn0lIz3GYxTlpf1bL3frFcKkTTstiX8kEP/Y5OnYfQw91
X-Gm-Gg: ASbGncuIFQC6yHzBfDl9X/hQBc22f2nhJ+7bAX3EHHHVm25FCqKbr62OuNoiAJPhVfD
	kXURu8ropqikwFQ5LDtKNCda2XdcfqsLwZYlT8egQGb++NVs2d3gEtiUT/COblx59zy5j1q2nkS
	Q/gZWxxzx4GzLmCu+YWRMlgSN/5wLm/i+7Eag94aidubiZgMYJ8Rx7GuW2SOx29JjGzeZ6oaZ2+
	oYbnP4z8I/bIvtt5fJhWSlQmL/TGySHJrXhBYWn3m93/5QOrE1wCjUYKUPzbICCRq+n78t/88sZ
	OfdDmaX93mGrneMl8Ycww4TcEDh0YZMj+OrwH+9gr2CvVa+jSIt3NbqkngzRAB4D5a0HBGb/6hv
	Ss0BG8L2PaAr1pD7Z0Ub6ikV9
X-Google-Smtp-Source: AGHT+IFZt7gxklS+yFgrVJFWOVYbWK75g8yQjIjt7R2j9fGA4rIs9N8O0XQ6BPBWi+y8xZ7+uPuFZQ==
X-Received: by 2002:ad4:5f4a:0:b0:6d8:a730:110c with SMTP id 6a1803df08f44-6e445701314mr208444026d6.38.1739199609616;
        Mon, 10 Feb 2025 07:00:09 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:cc94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e445c50a10sm38875896d6.91.2025.02.10.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:00:08 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 10:00:02 -0500
Subject: [PATCH v5 2/2] scanf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-scanf-kunit-convert-v5-2-8e64f3a7de99@gmail.com>
References: <20250210-scanf-kunit-convert-v5-0-8e64f3a7de99@gmail.com>
In-Reply-To: <20250210-scanf-kunit-convert-v5-0-8e64f3a7de99@gmail.com>
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
 lib/scanf_kunit.c | 98 +++++++++++++++++++++++++------------------------------
 1 file changed, 44 insertions(+), 54 deletions(-)

diff --git a/lib/scanf_kunit.c b/lib/scanf_kunit.c
index dfd29b103053..cbbbcc1c88d2 100644
--- a/lib/scanf_kunit.c
+++ b/lib/scanf_kunit.c
@@ -4,19 +4,14 @@
  */
 
 #include <kunit/test.h>
-#include <linux/bitops.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/overflow.h>
-#include <linux/printk.h>
 #include <linux/prandom.h>
-#include <linux/slab.h>
-#include <linux/string.h>
+#include <linux/sprintf.h>
 
 #define BUF_SIZE 1024
 
-static char *test_buffer;
-static char *fmt_buffer;
+static char test_buffer[BUF_SIZE];
+static char fmt_buffer[BUF_SIZE];
 static struct rnd_state rnd_state;
 
 typedef void (*check_fn)(struct kunit *test, const void *check_data, const char *string,
@@ -428,8 +423,11 @@ static void numbers_list_hh(struct kunit *test, const char *delim)
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
@@ -500,8 +498,11 @@ static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
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
@@ -563,8 +564,11 @@ static void numbers_list_field_width_val_hh(struct kunit *test, const char *deli
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
@@ -580,7 +584,12 @@ static void numbers_list_field_width_val_width(struct kunit *test, const char *d
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
@@ -732,62 +741,43 @@ static const char * const number_delimiters[] = {
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
-	test_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
-	if (!test_buffer)
-		return;
-
-	fmt_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
-	if (!fmt_buffer) {
-		kfree(test_buffer);
-		return;
-	}
-
 	prandom_seed_state(&rnd_state, 3141592653589793238ULL);
 
-	test_numbers(test);
-
-	test_simple_strtoull(test);
-	test_simple_strtoll(test);
-	test_simple_strtoul(test);
-	test_simple_strtol(test);
-
-	kfree(fmt_buffer);
-	kfree(test_buffer);
+	return 0;
 }
 
-static struct kunit_case scanf_test_cases[] = {
-	KUNIT_CASE(scanf_test),
-	{}
-};
-
 static struct kunit_suite scanf_test_suite = {
 	.name = "scanf",
+	.suite_init = scanf_suite_init,
 	.test_cases = scanf_test_cases,
 };
 

-- 
2.48.1


