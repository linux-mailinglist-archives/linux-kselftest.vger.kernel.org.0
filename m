Return-Path: <linux-kselftest+bounces-25734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A6A27B62
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514A93A244D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AB921519F;
	Tue,  4 Feb 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzrvdqVm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1912054F8;
	Tue,  4 Feb 2025 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697817; cv=none; b=EmIV7eRyjMoJngWPp1nCC+PoKjAyKLICc1hS8UlYPTDkl7/pXolmAja+m0VVPz7yrtvBqZbr8j5EpvYWAqpc7KAMNN4H0Ze7IaKMOVsKHYNHhG1zzeham6BIWBhReEzsXCdJWYksSI6WSDCzWalogU9Y6T/QFjBooLPvXD3hiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697817; c=relaxed/simple;
	bh=OMpdrKku1L9sKmISoXWHKttXFLzUPsinHBv2GNqo+4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcVtY/Dqw/Dh774vUYMBd0wKo68yRcTnHXx68jnzWfDvvGrcoRzROjy+yG1JfZOhqp1W++EdxjjN8JzXjdaF+DXaNmXnzNu25+cssqh+ydDKPIl4tSU+a8wBPzpFS1ADsJNBL6aIfqgvf+iDOWXOKlg2dQhrokss7AVmhh2tFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzrvdqVm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46b1d40ac6bso1326241cf.0;
        Tue, 04 Feb 2025 11:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738697814; x=1739302614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pbi+xDKGj1Or2jJoj4TQ214/Y96tAhVTyI6Ee4G1ETo=;
        b=BzrvdqVmDl64ptVZf9++q7qdiwQyTVA1XK4duAyycXXteADJyIJkGRMKfVONRrmtHd
         ByT1WBZjwouNgs75venEnl4pZR8eXs/aVnHVmVbG2bLIt73i+sg4ZvbXZma9ogjsTh6G
         3ERmvUfGSbvCs+LFBUNad0e9CzLREc1ECJ34iluEKs/UN5KgD94S+JqqLXqMHsxSi2L1
         dsktWasF6Hj12Nr3NNYSMGY2g1dZ86Q75r3ANOH6pRgE6EsEegDWjRGIKvKTJdkWyy8b
         2rjW3nr85kTwyel9M/3tDBe1QP84c2I2CmAiSw0VlaPggZfKVORoiUCeFBHOwHPfiJrl
         LGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738697814; x=1739302614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pbi+xDKGj1Or2jJoj4TQ214/Y96tAhVTyI6Ee4G1ETo=;
        b=ehPnk1nS183HRc0qBhSFdolJpu+HpoIYY3irB12r7OpHtCOmMO4pjOp2t8mmDDXzn4
         m8O/ihp9EHWFVpaqjTAU8hzUdRtXY8LWhtNOMPGIZ1YHTR2mpjcCJ2H67vjocq380hp1
         4oikfCNlDbCdDLRId0TRug9bsvpUN1XuLzxT9qp+sVr3sLFeu5c3n1BB/e+V9/WR41WV
         UzqAN6B5buYpNkq/HUHs8H6f5EXHcPRVYbGpQ7KjBSVTlUqzRE4e7dPHA6IFvNGtURoI
         MKsIeer9BmWQo05oJLQowc8ZiZ4oGW84TNOHyVd8biKepAGDCqy5YIabaqlBfjtypxK4
         niSA==
X-Forwarded-Encrypted: i=1; AJvYcCXgRTo1j41fDLx8fVBMEoYgb8bDIgEE6vypHBYyS9bMGiK/xz8j6NMuMAwhhlJc344j6if7sg6nLa78H0dWwBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44+P3iS8oqAllBhteR9dR4xNJrZRmuczSZWlFoFsi80PFvWd6
	nuoIkFfYGPtWW9ocvoqO33wlRLwP6vrFU6q1cV5SthmnlnhSvigw
X-Gm-Gg: ASbGncty/+1PfiJkuU8jPpJK9DsZLGsK31lf2/pRvvGynt+7naV/kqfP0Yq9+qCwHpK
	lAK3iAOVHdYXgxF66YgAFwTJ9A8MKOQvy8Rv9HnMU351LHaN+2HBZyWLW5nbk8TfkeVQEksNS85
	chCs/h/StC75MuzPxNpuwZSSkeow1S4MdvQT8wL9mXkKTtJgb9CN69OTeE1MpJs0txyX6BXJvaD
	Wdv5UkHrUu5siBnRjRY++WXoQLIwkMgW/uvVoVoIV5nviRw7WBkJwjepoAgppRRv+T74fdSWPsV
	MFAO3OnCqsty1PYlJTpV3yyu826K652N8A2wloKSOkRnPWv2oroIFYy96orAourYDZk/8iXWGwu
	PrBzfxHilSMNsd2oDakTp9EY4
X-Google-Smtp-Source: AGHT+IHFhcAiTNxL2G30my1744aMZk9tmCqivA75hy462A4kE4+NCkwBS+8jXAM0/7ie4FIfG0tk1w==
X-Received: by 2002:a05:622a:1a9d:b0:466:9ab3:c2c7 with SMTP id d75a77b69052e-4702782895emr2899221cf.14.1738697814203;
        Tue, 04 Feb 2025 11:36:54 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:6ca8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf18a420sm62121031cf.77.2025.02.04.11.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:36:52 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 04 Feb 2025 14:36:38 -0500
Subject: [PATCH 2/2] printf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-printf-kunit-convert-v1-2-ecf1b846a4de@gmail.com>
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
In-Reply-To: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
To: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use `suite_{init,exit}` and move all tests into `printf_test_cases`.
This gives us nicer output in the event of a failure.

Combine `plain_format` and `plain_hash` into `hash_pointer` since
they're testing the same scenario.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/printf_kunit.c | 196 ++++++++++++++++++-----------------------------------
 1 file changed, 65 insertions(+), 131 deletions(-)

diff --git a/lib/printf_kunit.c b/lib/printf_kunit.c
index e889aca69eba..e88b70ad3830 100644
--- a/lib/printf_kunit.c
+++ b/lib/printf_kunit.c
@@ -180,29 +180,6 @@ test_string(struct kunit *test)
 #define ZEROS "00000000"	/* hex 32 zero bits */
 #define ONES "ffffffff"		/* hex 32 one bits */
 
-static int
-plain_format(void)
-{
-	char buf[PLAIN_BUF_SIZE];
-	int nchars;
-
-	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
-
-	if (nchars != PTR_WIDTH)
-		return -1;
-
-	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
-		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
-			PTR_VAL_NO_CRNG);
-		return 0;
-	}
-
-	if (strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
-		return -1;
-
-	return 0;
-}
-
 #else
 
 #define PTR_WIDTH 8
@@ -212,79 +189,44 @@ plain_format(void)
 #define ZEROS ""
 #define ONES ""
 
-static int
-plain_format(void)
-{
-	/* Format is implicitly tested for 32 bit machines by plain_hash() */
-	return 0;
-}
-
 #endif	/* BITS_PER_LONG == 64 */
 
-static int
-plain_hash_to_buffer(const void *p, char *buf, size_t len)
+static void
+plain_hash_to_buffer(struct kunit *test, const void *p, char *buf, size_t len)
 {
-	int nchars;
-
-	nchars = snprintf(buf, len, "%p", p);
-
-	if (nchars != PTR_WIDTH)
-		return -1;
+	KUNIT_ASSERT_EQ(test, snprintf(buf, len, "%p", p), PTR_WIDTH);
 
 	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
 		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
 			PTR_VAL_NO_CRNG);
-		return 0;
 	}
-
-	return 0;
 }
 
-static int
-plain_hash(void)
+static void
+hash_pointer(struct kunit *test)
 {
-	char buf[PLAIN_BUF_SIZE];
-	int ret;
+	if (no_hash_pointers)
+		kunit_skip(test, "hash pointers disabled");
 
-	ret = plain_hash_to_buffer(PTR, buf, PLAIN_BUF_SIZE);
-	if (ret)
-		return ret;
+	char buf[PLAIN_BUF_SIZE];
 
-	if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
-		return -1;
+	plain_hash_to_buffer(test, PTR, buf, PLAIN_BUF_SIZE);
 
-	return 0;
-}
-
-/*
- * We can't use test() to test %p because we don't know what output to expect
- * after an address is hashed.
- */
-static void
-plain(struct kunit *test)
-{
-	if (no_hash_pointers) {
-		pr_warn("skipping plain 'p' tests");
-		return;
-	}
+	/*
+	 * We can't use test() to test %p because we don't know what output to expect
+	 * after an address is hashed.
+	 */
 
-	KUNIT_EXPECT_FALSE(test, plain_hash());
-	KUNIT_EXPECT_FALSE(test, plain_format());
+	KUNIT_EXPECT_MEMEQ(test, buf, ZEROS, strlen(ZEROS));
+	KUNIT_EXPECT_MEMNEQ(test, buf+strlen(ZEROS), PTR_STR, PTR_WIDTH);
 }
 
 static void
 test_hashed(struct kunit *test, const char *fmt, const void *p)
 {
 	char buf[PLAIN_BUF_SIZE];
-	int ret;
 
-	/*
-	 * No need to increase failed test counter since this is assumed
-	 * to be called after plain().
-	 */
-	ret = plain_hash_to_buffer(p, buf, PLAIN_BUF_SIZE);
-	if (ret)
-		return;
+	plain_hash_to_buffer(test, p, buf, PLAIN_BUF_SIZE);
 
 	tc(test, buf, fmt, p);
 }
@@ -322,12 +264,12 @@ invalid_pointer(struct kunit *test)
 }
 
 static void
-symbol_ptr(void)
+symbol_ptr(struct kunit *test)
 {
 }
 
 static void
-kernel_ptr(void)
+kernel_ptr(struct kunit *test)
 {
 	/* We can't test this without access to kptr_restrict. */
 }
@@ -398,12 +340,12 @@ struct_range(struct kunit *test)
 }
 
 static void
-addr(void)
+addr(struct kunit *test)
 {
 }
 
 static void
-escaped_str(void)
+escaped_str(struct kunit *test)
 {
 }
 
@@ -446,15 +388,8 @@ ip4(struct kunit *test)
 }
 
 static void
-ip6(void)
-{
-}
-
-static void
-ip(struct kunit *test)
+ip6(struct kunit *test)
 {
-	ip4(test);
-	ip6();
 }
 
 static void
@@ -506,7 +441,7 @@ dentry(struct kunit *test)
 }
 
 static void
-struct_va_format(void)
+struct_va_format(struct kunit *test)
 {
 }
 
@@ -545,7 +480,7 @@ time_and_date(struct kunit *test)
 }
 
 static void
-struct_clk(void)
+struct_clk(struct kunit *test)
 {
 }
 
@@ -587,7 +522,7 @@ bitmap(struct kunit *test)
 }
 
 static void
-netdev_features(void)
+netdev_features(struct kunit *test)
 {
 }
 
@@ -712,8 +647,7 @@ static void fwnode_pointer(struct kunit *test)
 
 	rval = software_node_register_node_group(group);
 	if (rval) {
-		pr_warn("cannot register softnodes; rval %d\n", rval);
-		return;
+		kunit_skip(test, "cannot register softnodes; rval %d\n", rval);
 	}
 
 	tc(test, full_name_second, "%pfw", software_node_fwnode(&second));
@@ -762,57 +696,57 @@ errptr(struct kunit *test)
 #endif
 }
 
-static void
-test_pointer(struct kunit *test)
-{
-	plain(test);
-	null_pointer(test);
-	error_pointer(test);
-	invalid_pointer(test);
-	symbol_ptr();
-	kernel_ptr();
-	struct_resource(test);
-	struct_range(test);
-	addr();
-	escaped_str();
-	hex_string(test);
-	mac(test);
-	ip(test);
-	uuid(test);
-	dentry(test);
-	struct_va_format();
-	time_and_date(test);
-	struct_clk();
-	bitmap(test);
-	netdev_features();
-	flags(test);
-	errptr(test);
-	fwnode_pointer(test);
-	fourcc_pointer(test);
-}
-
-static void printf_test(struct kunit *test)
+static struct kunit_case printf_test_cases[] = {
+	KUNIT_CASE(test_basic),
+	KUNIT_CASE(test_number),
+	KUNIT_CASE(test_string),
+	KUNIT_CASE(hash_pointer),
+	KUNIT_CASE(null_pointer),
+	KUNIT_CASE(error_pointer),
+	KUNIT_CASE(invalid_pointer),
+	KUNIT_CASE(symbol_ptr),
+	KUNIT_CASE(kernel_ptr),
+	KUNIT_CASE(struct_resource),
+	KUNIT_CASE(struct_range),
+	KUNIT_CASE(addr),
+	KUNIT_CASE(escaped_str),
+	KUNIT_CASE(hex_string),
+	KUNIT_CASE(mac),
+	KUNIT_CASE(ip4),
+	KUNIT_CASE(ip6),
+	KUNIT_CASE(uuid),
+	KUNIT_CASE(dentry),
+	KUNIT_CASE(struct_va_format),
+	KUNIT_CASE(time_and_date),
+	KUNIT_CASE(struct_clk),
+	KUNIT_CASE(bitmap),
+	KUNIT_CASE(netdev_features),
+	KUNIT_CASE(flags),
+	KUNIT_CASE(errptr),
+	KUNIT_CASE(fwnode_pointer),
+	KUNIT_CASE(fourcc_pointer),
+	{}
+};
+
+static int printf_suite_init(struct kunit_suite *suite)
 {
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
 	if (!alloced_buffer)
-		return;
+		return -1;
 	test_buffer = alloced_buffer + PAD_SIZE;
+	return 0;
+}
 
-	test_basic(test);
-	test_number(test);
-	test_string(test);
-	test_pointer(test);
-
+static void printf_suite_exit(struct kunit_suite *suite)
+{
 	kfree(alloced_buffer);
 }
 
-static struct kunit_case printf_test_cases[] = {
-	KUNIT_CASE(printf_test),
-	{}
-};
 
 static struct kunit_suite printf_test_suite = {
 	.name = "printf",
+	.suite_init = printf_suite_init,
+	.suite_exit = printf_suite_exit,
 	.test_cases = printf_test_cases,
 };
 

-- 
2.48.1


