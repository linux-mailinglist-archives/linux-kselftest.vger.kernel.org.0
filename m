Return-Path: <linux-kselftest+bounces-26199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B1A2F693
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EAD161DE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E7925742A;
	Mon, 10 Feb 2025 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBVM3CC0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA22566FE;
	Mon, 10 Feb 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211252; cv=none; b=G0YmhCWsqdMPjYYuFGc3+Ty70+XQ5Dv0S1KWLP8sqBrhiti7skUoVHiDmsANf1CKUnPtky7Ec7L+duVYGMMiFIYXJcbZt8FHO3OfUQoGpJYBF3AEiw/RQBAqH3p5RbdwVqbkVfE9YM7OUbcInlOLzA4jhrjCyRdhMMeb8oMmt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211252; c=relaxed/simple;
	bh=WgIsW0Ai7n3JQY2rTGFFhuLqQGUQ4sblZV/RR1FiaOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C83wQjYBgE49A2MhlUM15eEVcbW0xi0S2VgvKUVkrDgelfAsZcswDgVGV9NMqvl80Hr/ayvCrP1en/NgSIr5ikzSPBOfT7Q68SmODN5Pap9JTs2NlADalUC8d8nHOONLOlS72agW0wNirn6cflw5Eu+mC1ZhmkGv5ItJN8PM4wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBVM3CC0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4717bb7e7deso20366651cf.1;
        Mon, 10 Feb 2025 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739211249; x=1739816049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jobFrUit/b1mYvI10ySh1rCp2nBCwTd5ruWT/6Z2Spg=;
        b=DBVM3CC0j6A7F/yN0G8rQ7R8ALJKj9gP2EKptp4DcWuwxib/ZGaDFlAIvcbqPA4Fmk
         3At4AnfUrvUxfn2BvqgX/jvhKe6b0aFLCnfrVrsfEOcqoMhHzcAT7mrPUDKIly66Bgfm
         XTzLCh694QIgVKEDBa2f4eNbJtWr1DWjgeG2i2L81cG+/MaDsoCM9F/qonKIHWRP5ASd
         URtRKjCFpzMXU0oJ+cBUcxpf+QES0RU3QR8LdkHjJOxOpXkGAMzxpNrCqp0TNnNFKdbM
         yZRM5W+eLK7o7DXPg3rOY6B5I0mHXSjWX6uYSugjKVLd92q/t2Y4f+2SG4w+IXoZfOBl
         jmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211249; x=1739816049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jobFrUit/b1mYvI10ySh1rCp2nBCwTd5ruWT/6Z2Spg=;
        b=kuLqJYelxpPNF2sJ31WtzQ6MhAxy0B5+uCS34ZMSqI180Jf1910Jn9QnksPQefFt2C
         SilyH9Tfu3iB0qdD6jwnqR2BW1EtTc/11EsKi1SOnW8HuZsxLxVKKyR2XViYqKsUc8xN
         TAwdeq479h7EcesxR/3pDqvdVHIrnMM64zqSf1vh6TqRhvBimyqqNTvsLsDPxSpev+kr
         TFeaG6lA5WPowov39qamMGjyJ+2SX2XP50T2g6GsDTV7qGALgp/tn32RfJLmWbuC6s0Z
         GzpdrPZHRGasAkcSX3PikjJU9vAe1AV9EM7JgiCZePumzSDqr3JzENvhnqh7MwgjFzV2
         bA+A==
X-Forwarded-Encrypted: i=1; AJvYcCUudq9GYJ7y9804rZohdBT5ZZPW+m3UXESa/U2r19MdcVM4CvV9t/UruKZwaXvUZG2HV9uEKB3yHRW0XcqqwiOc@vger.kernel.org, AJvYcCW6r8J6xs6dJXM9AJ3tLBaMBBzrBtc74jAy7zc3By8ysZwuoDoYxvf06K4cdFIwcJ5fKPB/89sf8Ima2UU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hOaEptq2oJPWc24FWsIG6Rf+f5w/kQl409Ipts30Mq7S9Y8H
	Ba2WOs+d8P6tzbRMuGFhZZ8QBvHTIR75Cg9YEKomltbcolaX8KKy
X-Gm-Gg: ASbGncu/Aid+VrQaBvtdhwMNBrVBsFHQnESqTYmVhQly3MxWsRJSidzCCmMWbUbVySM
	FSv2vxe/e31E/PQKH3FcgMDqXiTTaluK+yLG7KwMUu9YSoMS2yil3/768eb8jtmidLDAh8vIpF3
	Pwf7HpHy5FPrqi4L+PONGM5VPqqJynnPxYsTYn/GS7U/i/l+YI5ToHGP+bjprTyXfefEXW0F/cP
	6uB3K72OhX/ZbzI8Cqdps3XYIf57c+ILKvxJQPS1fiZ75gPQIylYVKK4nlsdAmX+NX5CzJXSf0k
	eQ4H+Sqg57ULL0oLclPyqSAMPcYKO+EmbSENms9Qw7joRjhF9evyWsY6Ry1Vgz4KED28D1W5hj4
	tyn5nCFmCE3NH7OAwtv9Hsp8t
X-Google-Smtp-Source: AGHT+IGQ47Oc5ZRTqaX10cBYRP5xx1WFkywnQ10qm/Nh2EkdtsmaSzM1qhkz8kZRMjdZ1KOH/oVkpg==
X-Received: by 2002:a05:6214:3008:b0:6e4:25ff:4bac with SMTP id 6a1803df08f44-6e46804e796mr5056716d6.10.1739211247988;
        Mon, 10 Feb 2025 10:14:07 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:cc94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacbbasm49591376d6.73.2025.02.10.10.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:14:06 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 13:13:49 -0500
Subject: [PATCH v6 2/2] scanf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-scanf-kunit-convert-v6-2-4d583d07f92d@gmail.com>
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

Use `suite_init` and move some tests into `scanf_test_cases`. This
gives us nicer output in the event of a failure.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/scanf_kunit.c | 88 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/lib/scanf_kunit.c b/lib/scanf_kunit.c
index dfd29b103053..7e2e7d891e41 100644
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
 
@@ -428,8 +424,11 @@ static void numbers_list_hh(struct kunit *test, const char *delim)
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
@@ -500,8 +499,11 @@ static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
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
@@ -563,8 +565,11 @@ static void numbers_list_field_width_val_hh(struct kunit *test, const char *deli
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
@@ -580,7 +585,12 @@ static void numbers_list_field_width_val_width(struct kunit *test, const char *d
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


