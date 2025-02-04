Return-Path: <linux-kselftest+bounces-25728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 866BAA27B2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9B5162B4E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF03219A67;
	Tue,  4 Feb 2025 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg4MHoWh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F0218AC4;
	Tue,  4 Feb 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697168; cv=none; b=Sd0od9avVgsZ48Pmu16EifOjjAGVKeLDrPlYxFaviN14KLKwLhuoXA1j3UkBLlalbEQNod0igwfChXnpeEP/qLQp1I7ue28mNjJ0+TparDiEoTWPYHb5RX2p55qmQy/10FJhEoWc+sZnr1b/+99kFD/bj+1Lppn1QkMSASuqUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697168; c=relaxed/simple;
	bh=nCKxtGRi7xsDXZ1OzoLTpqTLCwurQWvJ5u8r6GdhnaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ls4L1RMRgKZaTnAz9IxcPoTvxFIlfygCdPvJOlyxQw/pEnWoKqYHn/o18FGo/V4W8YgaSPI+5rD4pzr5GIZhSFtGd87O4QulvGr6Oo1V+OGbqhvgd2ep1iOMWXvlRn0zpZ/R0qYO5p2BPQzfac4/gU7JYJ2kDzkxyx21Q75dYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg4MHoWh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be3d681e74so531217685a.0;
        Tue, 04 Feb 2025 11:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697165; x=1739301965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FySZ9dfCAaun7fSjmjJgxjeEV75temB+3BVnbZKMXSs=;
        b=Qg4MHoWhWINn2NsoGn7vZ16OHIQwyKemrWTORl1wSFmWjehOlQQ3u/88Dcv05xpuXq
         vvqUJ9Gw9cRIcTrdfM5ihCXTDI2hjnEqa7GK14Pq83EfWFpRPsj1raBYTlgOHzu4hd/H
         hpTO+o9pr3giM7tsRyoypHDNghpHQpMUAZ4miZc6NYdu/2o9J7MmfejstiXDwONxUlj4
         ttUaTV2iVaPE+oO0FhP68EW1eJyIpD/ewxAHoWxU4qHGMUHWbZie9nF3Gg+RpmHCdv4w
         l2+fW4uX0E8puVKbhqYiGLjyEUDzf5btnzrO+1YRh54P4NjAQBR6gdZYOC6JKqX3+iqk
         1rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697165; x=1739301965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FySZ9dfCAaun7fSjmjJgxjeEV75temB+3BVnbZKMXSs=;
        b=gqyTUsDOrCyy960Ji18FQxBy3ZAM6PPHHOjvAEQeUI1/16i7I92shA3XFOINrGB2V3
         n7dLrzRZIVccMM0msTDgMQGSoFNEVyV4VIMKEMzVXTJwSU2NSJG5XC/2+lqNrD1aCOpH
         kDDn8nZzSLx7zLQk8fW5CCqK0Sy/2qjczVrX8g02oaqWU4ggDVNlk4ZF8cKtaphkmwgw
         PxL5dy1wNtm87F+fsM4+nTfh3wtHyxryvA4Y/w4Q3fYIHyLpVN3gA1Z/Q3YYblMcvEoX
         EHlE/xi4z+JEK+9PT9NdO5e4Ui0pU5ix7XO5RMmv8ubKhApYLBQGctSbOuP7F+NQkyFi
         qV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXV6afbdHOuYJriSf+Gi+bsDDuRDmmz0zi9kMCCrpxV9+kXrTWJmX5MgcO77KWLBFrdkZZJrR+hxRXTNQd5mto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroX1ZRBht3f/xGpSr5mexC8lcp06GpWAsBclnxSfD6+r7irH8
	mqUosnB5O69hz8IqknZut6Ll7+r7yngurm5vO3Dke5MG4eDtwXpzWfvG6h5p
X-Gm-Gg: ASbGncuUw4ROuVCCCg5q4ss0Y7wsfvhQOgEsw4PMH+dPtby6hGs+n1GRlpj36EjM+9t
	9/mkp+gLDMUDPEMfguY8a8djoMDbj8OOzXxm+sdVZiG1VSaLQCurSHPEdjsymW/S2Fvol/XgHdj
	yf1K1bNuNo4Can2pnCCQAZDa7fajQR8MpMsL1/hA7kVETUqafF3rQDjoKEs54C+JJkWDTP6mgfR
	ohmmz2yTABiz+EgX8R5AawnQy7bFvQd1LS2miIDcbk1XyahWMrMN1oF72fzaQGiCvRpxcwbDRNN
	fd+Z1HHvPfRDBVaTO/noeo5Jsfv+9ukXypogsPNs1cpcOUziUD0UpDar3AYTsDb+pT3rny8mHCv
	1NF9Kv55sCXEPz9+TfmWM4f7r
X-Google-Smtp-Source: AGHT+IHipqhRE0vwk2BmgtTV5j2ha4FvA+sZs9vSF8tk+J8FY7XwOEGpKKR8y2z3i2LIP0Od1sZRVQ==
X-Received: by 2002:a05:620a:4484:b0:7b6:6e3f:49dc with SMTP id af79cd13be357-7bffcd13863mr4150560485a.31.1738697164948;
        Tue, 04 Feb 2025 11:26:04 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:6ca8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90d032sm668429685a.107.2025.02.04.11.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:26:04 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 04 Feb 2025 14:25:56 -0500
Subject: [PATCH v3 2/2] scanf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-scanf-kunit-convert-v3-2-386d7c3ee714@gmail.com>
References: <20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com>
In-Reply-To: <20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com>
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

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/scanf_kunit.c | 82 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/lib/scanf_kunit.c b/lib/scanf_kunit.c
index 70364ce20ec3..c2ab994609b6 100644
--- a/lib/scanf_kunit.c
+++ b/lib/scanf_kunit.c
@@ -423,8 +423,11 @@ static void numbers_list_hh(struct kunit *test, const char *delim)
 	numbers_list_8(test, signed char,	"0x%hhx",	delim, "hhi", check_char);
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
@@ -495,8 +498,11 @@ static void numbers_list_field_width_hh(struct kunit *test, const char *delim)
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
@@ -558,8 +564,11 @@ static void numbers_list_field_width_val_hh(struct kunit *test, const char *deli
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
@@ -575,7 +584,12 @@ static void numbers_list_field_width_val_width(struct kunit *test, const char *d
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
 
 #define test_number_prefix(test, T, str, scan_fmt, expect0, expect1, n_args, fn)\
@@ -722,62 +736,60 @@ static const char * const number_delimiters[] = {
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


