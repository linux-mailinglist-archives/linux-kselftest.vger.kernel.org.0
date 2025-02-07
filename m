Return-Path: <linux-kselftest+bounces-25994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E59A2C1E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068C57A1DCF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2A1DF74B;
	Fri,  7 Feb 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQESw395"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F511DF726;
	Fri,  7 Feb 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928967; cv=none; b=szXwaLljJVfjZgxNZul79UlQMdoeKUcRyOp3KxW97etkqJDtxD0xseMKTSEmGkqRwr3ldnwvdN3Mp6lxv0HDgLHey5VQb/vaiOzHwdryzXHlB35qcSLzfEb7cErwaH9jUbD1nYOJ43c6m+Bg4Xio4/4uUHNmwi2zX/eZvcYJD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928967; c=relaxed/simple;
	bh=6LI98nWpmfIwKLFD4MOsZyS7JGUGVQ9Mj8HjC795U5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIVnJLOXbh4usHvWl2L06oEqIDsbo5YH/UyXwPwgZ14toKw/8b+Zm5NRhumQ9kkIWj/mL1swX7dlpA1YruV8fGyknto02TjL/tp3Qu4bjQ9amTUtRCMDsjaUeedYh6H4TeBJMhm7cggqBKBg1XHvuHQnv42Jyc4+cPlmjXmOXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQESw395; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a63f5d1cso16174081cf.0;
        Fri, 07 Feb 2025 03:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738928965; x=1739533765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hK+YCFAeUnwDbxFTqeARy5CxKfn0P294F8L6cIYwfKI=;
        b=OQESw395PusovQppro4mGytZkA0pR2rIE5DFbGfO5m6F/Dfp2zGJej2+OdYGQJzXPd
         70RoZkmNvabjLJucTBSqmylXrW60LDpAspFH7wyQZHvnr8F/NbyJq8CXq2lHWeFO0FMR
         FT4A9W2OVaqXEzkUQ5W1GUKCbNQTMnRcKeQhDFpgvQ+YIMHglIPSlO/0jKHOlGz81qCl
         06SDJrUcECjhw7r8tsX0KQQEgzSL8HEHQ4Fs/DWbnpL+M2th1EAZKIrsvkpb2upWiJOs
         VKrNVOoPQCWvqJWymLwEk+82lv5J2tQjWE216adhX65QTrPuUa//Uv2v7FJ0h8R2egS7
         d9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928965; x=1739533765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK+YCFAeUnwDbxFTqeARy5CxKfn0P294F8L6cIYwfKI=;
        b=JUszsDCaFK7SWSRb2XU/GeW1YSsNqOQCycmd00mAJqMivGx1dnUctCowX09M/GESze
         Z8RkwV6tcikBNz9IFWrK/frWIsS1YSd50KEm0PRNXKiPOnMOAj6tXU/DCPocK+w117zz
         0JEjykIUUTW1qpJhlp6PhYaSOpfrNIQYWr8+hQ77S+9LBTrdMKSvJ5DZGRSo0FjzSaE0
         PzYEP2jtnIN2pOAx/FzQir8cjDnUlwXipvACW0L5iJ5gtBVIIpgQNSYVWwDwLKMHLK9H
         bOU2tsHx93PBB6BH32GaJa2upGGa470PtxYAi5vq7Y2+Anl1lMli5NqgWq8nTz2wEkqj
         neNg==
X-Forwarded-Encrypted: i=1; AJvYcCVxMa3p67GFUDHAr4N5Cv0AG5jBBVNAhfbPCUQYdQ9ZePelJNS1CUZUOJFgPyzJTLGbbySmTDwl7zQzJlZEWvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIqTGAc6McdxhNhlbq3PXxTcQbIBhzNlCg6pQoa/rBO5zCaOj
	Sx/a40YYmHJlKJCgUHdt0/K3AYzQo0SHIp0UaKGA8JqZppx/QCdE
X-Gm-Gg: ASbGncuK6jFYCSn+bmL73ofnoOeG0gqBSxlxV7XpBHO0fxQbCa+3r6nlpSLBAV3sdDd
	qbGOth1UJm6t5fJ36by/hpCt1ZMRiCryx0H72XpraAZT+TqrfKTncykxOsalN1bgVzcCIZThB2E
	3bxBPYLwC4ki6ArbYjYtySH06KKg9EBPDjvjpwHiPoM/KZUa3G8Z7XJwAltm9DFOJb9g3icjqAT
	80POJ+IVvaP7irHenN5j7aH1mZE+EkKdvEQjaFsCWLPHhnbPUgAWDTKuJ4Z23JsCay3bgLSIQi3
	qli9CpWFYSeoXkP6q9KyWhraxLj/pSa/U4Z/
X-Google-Smtp-Source: AGHT+IGxR5KcsF0QxbLNpPy+JQtMWenZBATsqt2Lkl51oLAVcnzHiSaaIoK94C4AErF4bUXchTkRRA==
X-Received: by 2002:a05:622a:64c:b0:466:ac03:a714 with SMTP id d75a77b69052e-47167ad097dmr41893781cf.36.1738928964719;
        Fri, 07 Feb 2025 03:49:24 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492763ebsm15533731cf.1.2025.02.07.03.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:49:23 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 06:49:12 -0500
Subject: [PATCH v4 2/2] scanf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-scanf-kunit-convert-v4-2-a23e2afaede8@gmail.com>
References: <20250207-scanf-kunit-convert-v4-0-a23e2afaede8@gmail.com>
In-Reply-To: <20250207-scanf-kunit-convert-v4-0-a23e2afaede8@gmail.com>
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use `suite_{init,exit}` and move some tests into `scanf_test_cases`.
This gives us nicer output in the event of a failure.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/scanf_kunit.c | 82 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/lib/scanf_kunit.c b/lib/scanf_kunit.c
index ad27b45c605e..05c8f7e724d8 100644
--- a/lib/scanf_kunit.c
+++ b/lib/scanf_kunit.c
@@ -430,8 +430,11 @@ static void numbers_list_hh(struct kunit *test, const char *delim)
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
@@ -502,8 +505,11 @@ static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
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
@@ -565,8 +571,11 @@ static void numbers_list_field_width_val_hh(struct kunit *test, const char *deli
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
@@ -582,7 +591,12 @@ static void numbers_list_field_width_val_width(struct kunit *test, const char *d
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
@@ -734,62 +748,60 @@ static const char * const number_delimiters[] = {
 	" ", ":", ",", "-", "/",
 };
 
-static void test_numbers(struct kunit *test)
+static void number_delimiter_param_desc(const char * const *param,
+					   char *desc)
 {
-	int i;
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "delim=\"%s\"", *param);
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
+		return -1;
 
 	fmt_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
 	if (!fmt_buffer) {
 		kfree(test_buffer);
-		return;
+		return -1;
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


