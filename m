Return-Path: <linux-kselftest+bounces-28485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9193A566BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B863B7084
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9715D218AD4;
	Fri,  7 Mar 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEYRMH70"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5F218AC3;
	Fri,  7 Mar 2025 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346880; cv=none; b=ZJIJKOl+NXjrZOdVaeqWORo8+LOe6doBmPYt7GOhlRKl/pGmvBvWWd52kiE625OxY4ZgNh7fBasOKKittHOgAsXmdRsiTbfjlxDE5CtfXgEm78VDn3GlYTng/huG4FIrOd/DR3j2JHP8XT0T5mkksmByh3dIA6NAsmkljXrS9Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346880; c=relaxed/simple;
	bh=jPDi4O/0gzr8AA3nOlR2uQcvGYlMJqx/kSoTPPODlqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o03ssWdwLU9mmfE416Jn+fcAg3Q896uS/UxKaoOgITeJZL6snbnNSr5gX+OYAhguWlu3M3pnOGp76mB0vSU4D9uY3lzLKBa703cwNKBxrcU6dbFOyLdG9AEL9qTQDNwso/1ZEjDc9iHsdyhi3Ad4PPKwacLcFy1NGXgx4CHbx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEYRMH70; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f254b875so13150846d6.1;
        Fri, 07 Mar 2025 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346874; x=1741951674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmEtBG3++BrDY8zHLVCnDV8Bx3aQKhFduVfIbo1A7yg=;
        b=VEYRMH70c02XfqJtR8Gm1xOy45X99FyzRvl/e7Co5jvso7IavtqFzglpFy132V7KZP
         lXoorZYGLIOnPNPB0WqLpwTGOB4dhNrBJuF+UdoGOfJUqcnVWzfWz4soYe/n5mPFySp5
         5xYfshOo3s/K44iwAinZ4QfxEQAsCnaAo3lwvu7OJ+NDUvmdr90IpXOxRsnndx/q2RrG
         lpxnBzMQcGrWJB5s4jerw4yQ3Flve31/zs7egX7WvspnLsEfi7DeKNtBbpKCRtlADJIq
         sex1oEY2ogyWDPW7wuCKwtulxTQ0tuUedPP4Xtzk9RJOPkaZE+nsbWzB19TiCs5BP9Ti
         YwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346874; x=1741951674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmEtBG3++BrDY8zHLVCnDV8Bx3aQKhFduVfIbo1A7yg=;
        b=hSjRkB9E1B+F6DSlJIson7rQFtKXYggzhJb+a1AaoPN9K5CICn0PGG/Va/DSFSpCHW
         tER5KlAJWehQqWh+MbF5EAB2vjj8UhgDFQDhKTfESKSObqx9IJQA4CKpmf36/Vg+3YYe
         +zyk73ieXCZSV2WM68/qb6eiu6mDhXw5zfeZ7HP5EplEMGIHOCNfMmR4rEdwMWpXiA3G
         cGDmwcf2zL2vDhRQhHa7uLcEVX5fBkXn9E8VvNutCQECkfOE6EBT2Nmy55srzRYxk1oP
         LmX7AvSGfBn1MXt60dImoJaOIzIfSBsW4LxWkZiAf7cu71q/5RSgNTzzt3pbsonnKF7Q
         w+IA==
X-Forwarded-Encrypted: i=1; AJvYcCV68YIEprYVm7uR3IOhEkTAknY34NBl3W0fIM3wZq/4Aovk2ftZTJkFBtA4KO3VJu0PKwyDixIv4SivQ5qwgDd/@vger.kernel.org, AJvYcCXbM5Zc4X609XJViI/Zk7cZ2AndNKcDZKmu5pPbvPToxVBK0Pub+A4KwLQD5cMTJLkiREKZM3Oja5p/RUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbfUQ+cMmtyBd2NwvhpRAo12rg0IPxEktyfW3Bs/c9fdwITLj
	uf14eQnyXwHWQPGJwW0dm4icUzaR3qa0HJJ8gQmtE3jivgzYq9a5DBv/aso1Q7Y=
X-Gm-Gg: ASbGncu0fbL7/Frk3aQg0XsUTTWPPb1kDQg/rolrmfDSxH75FqausYHp+KwrLdYtyaV
	ilT+SOpd5UW2hjTpGdEQDzsPCjXYp5pRi6hdki0lbQl/hb70B/yPK+3poiBoY00+lupD5E3f41B
	atlS7un3Y2FqJDw8TEyYM9cp1PYgsa73vi/0bSD700+vNxWLksBjfCyLU3wUI7XgFXFRWnYsJpF
	vgZZVLg4M38VdTUBwKv5gtL0aCY5DjldkYWh6k807o4CVfrrIpEGNPCwAD82Z2WVKDxb638hrVm
	wlzRJ4+0R5hxIDnTmnHfg9IlRey3Zwchsm+UbY8TlRcLI1ZXLt5YwheRCBzFugawkgw=
X-Google-Smtp-Source: AGHT+IEl8KUDSEiJVuaJBtf+4CkyxC17rhLhsKu9ZcFRgUVYyLXP1aIjWRNK9jZNKWPDQ5YRn+WSuw==
X-Received: by 2002:a05:6214:1d02:b0:6e8:ebc6:fd5f with SMTP id 6a1803df08f44-6e9006326e9mr42657496d6.20.1741346874602;
        Fri, 07 Mar 2025 03:27:54 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a446dsm18509416d6.56.2025.03.07.03.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:27:54 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 06:27:37 -0500
Subject: [PATCH v9 4/6] scanf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-scanf-kunit-convert-v9-4-b98820fa39ff@gmail.com>
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

Use `suite_init` and move some tests into `scanf_test_cases`. This
gives us nicer output in the event of a failure.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/tests/scanf_kunit.c | 82 ++++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/lib/tests/scanf_kunit.c b/lib/tests/scanf_kunit.c
index 94eb5ec80fdb..e9a36ed80575 100644
--- a/lib/tests/scanf_kunit.c
+++ b/lib/tests/scanf_kunit.c
@@ -434,8 +434,11 @@ static void numbers_list_hh(struct kunit *test, const char *delim)
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
@@ -506,8 +509,11 @@ static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
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
@@ -569,8 +575,11 @@ static void numbers_list_field_width_val_hh(struct kunit *test, const char *deli
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
@@ -586,7 +595,12 @@ static void numbers_list_field_width_val_width(struct kunit *test, const char *d
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
@@ -737,62 +751,60 @@ static const char * const number_delimiters[] = {
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


