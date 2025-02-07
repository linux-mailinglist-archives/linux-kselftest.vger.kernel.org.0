Return-Path: <linux-kselftest+bounces-25990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B661A2C191
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F20E1887F4F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836801E231F;
	Fri,  7 Feb 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKBiAW35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A21DF735;
	Fri,  7 Feb 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927859; cv=none; b=X/thLAczMc7TfzlnXWAMy81E3ZyfBb6n0z7DZQspDgVDS3FviQ9hTOo8kCXuEv9MJfNfiqmXIksA4/yTksvlDJgXraG6JeC4bxpJRhwsFCK2N4a0BcyhETUNfCpyS6AG/6IiYnftvh3weoDlxA1rhqiQNub/LvU1FOLHZHLfJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927859; c=relaxed/simple;
	bh=ef0gaPwKhQu+8xBL4j0oXbTbe1oL1qkTwFN+m3m7K+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEJdedVG05djn7U1bPBckpaEBeLlinKo+xir2+2HMezGijhIBH4U6e83MoF//0QP2mzxPRmjg32PMYYo86F/iWAEcFBoqIoYmYDkxKn6uYPBvhF7gj+z5ucWsf3LNhQ/+HG8TzK9bGIbLDoUKKCIoVbkoApGjQD6Z4OjGX3Qqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKBiAW35; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6e4d38185so170216885a.0;
        Fri, 07 Feb 2025 03:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738927856; x=1739532656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkunLjvq0ydR/QSasvMaQj1NVdDL4AZHJzB9Nhm+bg0=;
        b=HKBiAW35Zh17yik1YjokdegDNFGHZDMVBr1GXjwrIAQ/OhE5Db06FBrC9TXluAbVsC
         ZU0qqwu8wD7o3BhjuhNREXbHeZ8YSY2rsN5jJJmuPyCeQVB65o46DLYS/5kYBKw+8ekh
         YQiyePp14Jnnsdin6vMTTJ1Yj8Sy/j5hWJ6c6pMaJ62aH6an3mbxt+lCCbQUPzUfbsHm
         wn7POUvGn8qyR6XlhdU8Utd7D0zXymM2Qj0x9FZ7N15+BYBlrHVjjy67iUuFMAiUMwH0
         0PGc9VWRxilD29RLeEr7Z3ssHRXpniDwo7hnXcCbKbMzoqySAp+sW7uyzd6/ec5Sira2
         gqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738927856; x=1739532656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkunLjvq0ydR/QSasvMaQj1NVdDL4AZHJzB9Nhm+bg0=;
        b=ferB6RhLrr4O4gdXfgRUupnXW5hbZQ8DBU/jo0F0MzUec4oOb74yLKGWfkiV66NfwA
         MjD4c8Xk9TSSQDJo8NhswUGhe6RBM2ypBdKN02jDLFB4nj69R/Hqf1eODnhtdKxHszY0
         7tFt0pMtdqVYEhhb94cTUUUUyXif9iaFA3m/9Wpz9TRHmYbFj0rJ0gJQn/SOmlhqJkRB
         4tnlzNlrPONABgnd2GIysbrFQ0dJEoknjhZCKJaS7AyYvQuXxr4mNVAwjxwQ12jLEr0L
         1Bh3+qIu2jJAlJjhr78ljZCeA+4qtxjWgimwaM3bcrr9Q8kBkK1rzZbKDP+qCO3tw5zQ
         MmRw==
X-Forwarded-Encrypted: i=1; AJvYcCV16hXLYemn1gnsUGqd5wAXGY3V/t0KY0wAc1m0OMusQ+mxp6HgVCWmZFvFyH94wP8E8eYSh0H3j7F3Oi/TJls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqRsC/x6xNx9lN+C4RFudTYmHU+jDwV7rlx+mMIlsMW8157fjE
	ZcmTyiKcKh8lF63PJ5/iHbzRWJOLcj6LbbtYLG+8wKC6+AOD68EH
X-Gm-Gg: ASbGncs1uhVtTNMVgfdr7ha6kHzNQrSb8eFma217l4QD5iPD7pyOidJhk/ow+G+sZF8
	5uWRCYdw6FZ+8Rdy84uxUHpvtWbPU/5V2AqbZRtYSHY2QK0I+1jq7/lyx8QXD1X8gnSA7qv+kM8
	aIhnisDgsr6nBuIwquWcEc0+PyDCi1/20LEWmaee9PhBQ2vabD8cb8sZ/tGYN/hwpNoBIMUUuWU
	0faHEN/iKKWl2P1tq3/7Epobq/+gB2FlAch9caeCdQ+b38c3qGNbMKmh9omT6ocxyz55hpXExHq
	PVHvcGHFNTA4vBWNWH9XfYy4QZQwTjiaxeho
X-Google-Smtp-Source: AGHT+IGXoIZ/AfXxMnqzR7RumYsFc/FoWNlmIICgY+YOisLBDXfduaM3wT5+/NfN4bkwsTkczET3Zg==
X-Received: by 2002:a05:620a:178b:b0:7be:7153:63db with SMTP id af79cd13be357-7c047bbaca1mr404714885a.17.1738927856007;
        Fri, 07 Feb 2025 03:30:56 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:fb:aded:686f:8a03])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ded0e7sm178507685a.8.2025.02.07.03.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:30:54 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 06:30:45 -0500
Subject: [PATCH v2 2/2] printf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-printf-kunit-convert-v2-2-057b23860823@gmail.com>
References: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com>
In-Reply-To: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com>
To: Arpitha Raghunandan <98.arpi@gmail.com>, 
 David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use `suite_{init,exit}` and move all tests into `printf_test_cases`.
This gives us nicer output in the event of a failure.

Combine `plain_format` and `plain_hash` into `hash_pointer` since
they're testing the same scenario.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/printf_kunit.c | 286 +++++++++++++++++++----------------------------------
 1 file changed, 103 insertions(+), 183 deletions(-)

diff --git a/lib/printf_kunit.c b/lib/printf_kunit.c
index fe6f4df92dd5..b4b6f9943025 100644
--- a/lib/printf_kunit.c
+++ b/lib/printf_kunit.c
@@ -38,13 +38,11 @@
 static char *test_buffer;
 static char *alloced_buffer;
 
-static struct kunit *kunittest;
-
 #define tc_fail(fmt, ...) \
 	KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
 
-static void __printf(4, 0)
-do_test(int bufsize, const char *expect, int elen,
+static void __printf(5, 0)
+do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
 	const char *fmt, va_list ap)
 {
 	va_list aq;
@@ -99,8 +97,8 @@ do_test(int bufsize, const char *expect, int elen,
 	}
 }
 
-static void __printf(3, 4)
-__test(const char *expect, int elen, const char *fmt, ...)
+static void __printf(4, 5)
+__test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, ...)
 {
 	va_list ap;
 	int rand;
@@ -120,11 +118,11 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * enough and 0), and then we also test that kvasprintf would
 	 * be able to print it as expected.
 	 */
-	do_test(BUF_SIZE, expect, elen, fmt, ap);
+	do_test(kunittest, BUF_SIZE, expect, elen, fmt, ap);
 	rand = get_random_u32_inclusive(1, elen + 1);
 	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
-	do_test(rand, expect, elen, fmt, ap);
-	do_test(0, expect, elen, fmt, ap);
+	do_test(kunittest, rand, expect, elen, fmt, ap);
+	do_test(kunittest, 0, expect, elen, fmt, ap);
 
 	p = kvasprintf(GFP_KERNEL, fmt, ap);
 	if (p) {
@@ -138,10 +136,10 @@ __test(const char *expect, int elen, const char *fmt, ...)
 }
 
 #define test(expect, fmt, ...)					\
-	__test(expect, strlen(expect), fmt, ##__VA_ARGS__)
+	__test(kunittest, expect, strlen(expect), fmt, ##__VA_ARGS__)
 
 static void
-test_basic(void)
+test_basic(struct kunit *kunittest)
 {
 	/* Work around annoying "warning: zero-length gnu_printf format string". */
 	char nul = '\0';
@@ -149,11 +147,11 @@ test_basic(void)
 	test("", &nul);
 	test("100%", "100%%");
 	test("xxx%yyy", "xxx%cyyy", '%');
-	__test("xxx\0yyy", 7, "xxx%cyyy", '\0');
+	__test(kunittest, "xxx\0yyy", 7, "xxx%cyyy", '\0');
 }
 
 static void
-test_number(void)
+test_number(struct kunit *kunittest)
 {
 	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
 	test("  0x1234abcd", "%#12x", 0x1234abcd);
@@ -175,7 +173,7 @@ test_number(void)
 }
 
 static void
-test_string(void)
+test_string(struct kunit *kunittest)
 {
 	test("", "%s%.0s", "", "123");
 	test("ABCD|abc|123", "%s|%.3s|%.*s", "ABCD", "abcdef", 3, "123456");
@@ -212,29 +210,6 @@ test_string(void)
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
@@ -244,89 +219,44 @@ plain_format(void)
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
+plain_hash_to_buffer(struct kunit *kunittest, const void *p, char *buf, size_t len)
 {
-	int nchars;
-
-	nchars = snprintf(buf, len, "%p", p);
-
-	if (nchars != PTR_WIDTH)
-		return -1;
+	KUNIT_ASSERT_EQ(kunittest, snprintf(buf, len, "%p", p), PTR_WIDTH);
 
 	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
 		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
 			PTR_VAL_NO_CRNG);
-		return 0;
 	}
-
-	return 0;
-}
-
-static int
-plain_hash(void)
-{
-	char buf[PLAIN_BUF_SIZE];
-	int ret;
-
-	ret = plain_hash_to_buffer(PTR, buf, PLAIN_BUF_SIZE);
-	if (ret)
-		return ret;
-
-	if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
-		return -1;
-
-	return 0;
 }
 
-/*
- * We can't use test() to test %p because we don't know what output to expect
- * after an address is hashed.
- */
 static void
-plain(void)
+hash_pointer(struct kunit *kunittest)
 {
-	int err;
+	if (no_hash_pointers)
+		kunit_skip(kunittest, "hash pointers disabled");
 
-	if (no_hash_pointers) {
-		pr_warn("skipping plain 'p' tests");
-		return;
-	}
+	char buf[PLAIN_BUF_SIZE];
 
-	err = plain_hash();
-	if (err) {
-		tc_fail("plain 'p' does not appear to be hashed\n");
-		return;
-	}
+	plain_hash_to_buffer(kunittest, PTR, buf, PLAIN_BUF_SIZE);
 
-	err = plain_format();
-	if (err) {
-		tc_fail("hashing plain 'p' has unexpected format\n");
-	}
+	/*
+	 * We can't use test() to test %p because we don't know what output to expect
+	 * after an address is hashed.
+	 */
+
+	KUNIT_EXPECT_MEMEQ(kunittest, buf, ZEROS, strlen(ZEROS));
+	KUNIT_EXPECT_MEMNEQ(kunittest, buf+strlen(ZEROS), PTR_STR, PTR_WIDTH);
 }
 
 static void
-test_hashed(const char *fmt, const void *p)
+test_hashed(struct kunit *kunittest, const char *fmt, const void *p)
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
+	plain_hash_to_buffer(kunittest, p, buf, PLAIN_BUF_SIZE);
 
 	test(buf, fmt, p);
 }
@@ -335,7 +265,7 @@ test_hashed(const char *fmt, const void *p)
  * NULL pointers aren't hashed.
  */
 static void
-null_pointer(void)
+null_pointer(struct kunit *kunittest)
 {
 	test(ZEROS "00000000", "%p", NULL);
 	test(ZEROS "00000000", "%px", NULL);
@@ -346,7 +276,7 @@ null_pointer(void)
  * Error pointers aren't hashed.
  */
 static void
-error_pointer(void)
+error_pointer(struct kunit *kunittest)
 {
 	test(ONES "fffffff5", "%p", ERR_PTR(-11));
 	test(ONES "fffffff5", "%px", ERR_PTR(-11));
@@ -356,26 +286,26 @@ error_pointer(void)
 #define PTR_INVALID ((void *)0x000000ab)
 
 static void
-invalid_pointer(void)
+invalid_pointer(struct kunit *kunittest)
 {
-	test_hashed("%p", PTR_INVALID);
+	test_hashed(kunittest, "%p", PTR_INVALID);
 	test(ZEROS "000000ab", "%px", PTR_INVALID);
 	test("(efault)", "%pE", PTR_INVALID);
 }
 
 static void
-symbol_ptr(void)
+symbol_ptr(struct kunit *kunittest)
 {
 }
 
 static void
-kernel_ptr(void)
+kernel_ptr(struct kunit *kunittest)
 {
 	/* We can't test this without access to kptr_restrict. */
 }
 
 static void
-struct_resource(void)
+struct_resource(struct kunit *kunittest)
 {
 	struct resource test_resource = {
 		.start = 0xc0ffee00,
@@ -424,7 +354,7 @@ struct_resource(void)
 }
 
 static void
-struct_range(void)
+struct_range(struct kunit *kunittest)
 {
 	struct range test_range = DEFINE_RANGE(0xc0ffee00ba5eba11,
 					       0xc0ffee00ba5eba11);
@@ -440,17 +370,17 @@ struct_range(void)
 }
 
 static void
-addr(void)
+addr(struct kunit *kunittest)
 {
 }
 
 static void
-escaped_str(void)
+escaped_str(struct kunit *kunittest)
 {
 }
 
 static void
-hex_string(void)
+hex_string(struct kunit *kunittest)
 {
 	const char buf[3] = {0xc0, 0xff, 0xee};
 
@@ -461,7 +391,7 @@ hex_string(void)
 }
 
 static void
-mac(void)
+mac(struct kunit *kunittest)
 {
 	const u8 addr[6] = {0x2d, 0x48, 0xd6, 0xfc, 0x7a, 0x05};
 
@@ -473,7 +403,7 @@ mac(void)
 }
 
 static void
-ip4(void)
+ip4(struct kunit *kunittest)
 {
 	struct sockaddr_in sa;
 
@@ -488,19 +418,12 @@ ip4(void)
 }
 
 static void
-ip6(void)
+ip6(struct kunit *kunittest)
 {
 }
 
 static void
-ip(void)
-{
-	ip4();
-	ip6();
-}
-
-static void
-uuid(void)
+uuid(struct kunit *kunittest)
 {
 	const char uuid[16] = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
 			       0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf};
@@ -527,7 +450,7 @@ static struct dentry test_dentry[4] = {
 };
 
 static void
-dentry(void)
+dentry(struct kunit *kunittest)
 {
 	test("foo", "%pd", &test_dentry[0]);
 	test("foo", "%pd2", &test_dentry[0]);
@@ -548,12 +471,12 @@ dentry(void)
 }
 
 static void
-struct_va_format(void)
+struct_va_format(struct kunit *kunittest)
 {
 }
 
 static void
-time_and_date(void)
+time_and_date(struct kunit *kunittest)
 {
 	/* 1543210543 */
 	const struct rtc_time tm = {
@@ -587,12 +510,12 @@ time_and_date(void)
 }
 
 static void
-struct_clk(void)
+struct_clk(struct kunit *kunittest)
 {
 }
 
 static void
-large_bitmap(void)
+large_bitmap(struct kunit *kunittest)
 {
 	const int nbits = 1 << 16;
 	unsigned long *bits = bitmap_zalloc(nbits, GFP_KERNEL);
@@ -606,7 +529,7 @@ large_bitmap(void)
 }
 
 static void
-bitmap(void)
+bitmap(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(bits, 20);
 	const int primes[] = {2,3,5,7,11,13,17,19};
@@ -625,11 +548,11 @@ bitmap(void)
 	test("fffff|fffff", "%20pb|%*pb", bits, 20, bits);
 	test("0-19|0-19", "%20pbl|%*pbl", bits, 20, bits);
 
-	large_bitmap();
+	large_bitmap(kunittest);
 }
 
 static void
-netdev_features(void)
+netdev_features(struct kunit *kunittest)
 {
 }
 
@@ -655,8 +578,8 @@ static const struct page_flags_test pft[] = {
 };
 
 static void
-page_flags_test(int section, int node, int zone, int last_cpupid,
-		int kasan_tag, unsigned long flags, const char *name,
+page_flags_test(struct kunit *kunittest, int section, int node, int zone,
+		int last_cpupid, int kasan_tag, unsigned long flags, const char *name,
 		char *cmp_buf)
 {
 	unsigned long values[] = {section, node, zone, last_cpupid, kasan_tag};
@@ -693,7 +616,7 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
 }
 
 static void
-flags(void)
+flags(struct kunit *kunittest)
 {
 	unsigned long flags;
 	char *cmp_buffer;
@@ -704,14 +627,14 @@ flags(void)
 		return;
 
 	flags = 0;
-	page_flags_test(0, 0, 0, 0, 0, flags, "", cmp_buffer);
+	page_flags_test(kunittest, 0, 0, 0, 0, 0, flags, "", cmp_buffer);
 
 	flags = 1UL << NR_PAGEFLAGS;
-	page_flags_test(0, 0, 0, 0, 0, flags, "", cmp_buffer);
+	page_flags_test(kunittest, 0, 0, 0, 0, 0, flags, "", cmp_buffer);
 
 	flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
 		| 1UL << PG_active | 1UL << PG_swapbacked;
-	page_flags_test(1, 1, 1, 0x1fffff, 1, flags,
+	page_flags_test(kunittest, 1, 1, 1, 0x1fffff, 1, flags,
 			"uptodate|dirty|lru|active|swapbacked",
 			cmp_buffer);
 
@@ -740,7 +663,7 @@ flags(void)
 	kfree(cmp_buffer);
 }
 
-static void fwnode_pointer(void)
+static void fwnode_pointer(struct kunit *kunittest)
 {
 	const struct software_node first = { .name = "first" };
 	const struct software_node second = { .name = "second", .parent = &first };
@@ -754,8 +677,7 @@ static void fwnode_pointer(void)
 
 	rval = software_node_register_node_group(group);
 	if (rval) {
-		pr_warn("cannot register softnodes; rval %d\n", rval);
-		return;
+		kunit_skip(kunittest, "cannot register softnodes; rval %d\n", rval);
 	}
 
 	test(full_name_second, "%pfw", software_node_fwnode(&second));
@@ -767,7 +689,7 @@ static void fwnode_pointer(void)
 	software_node_unregister_node_group(group);
 }
 
-static void fourcc_pointer(void)
+static void fourcc_pointer(struct kunit *kunittest)
 {
 	struct {
 		u32 code;
@@ -785,13 +707,13 @@ static void fourcc_pointer(void)
 }
 
 static void
-errptr(void)
+errptr(struct kunit *kunittest)
 {
 	test("-1234", "%pe", ERR_PTR(-1234));
 
 	/* Check that %pe with a non-ERR_PTR gets treated as ordinary %p. */
 	BUILD_BUG_ON(IS_ERR(PTR));
-	test_hashed("%pe", PTR);
+	test_hashed(kunittest, "%pe", PTR);
 
 #ifdef CONFIG_SYMBOLIC_ERRNAME
 	test("(-ENOTSOCK)", "(%pe)", ERR_PTR(-ENOTSOCK));
@@ -804,59 +726,57 @@ errptr(void)
 #endif
 }
 
-static void
-test_pointer(void)
-{
-	plain();
-	null_pointer();
-	error_pointer();
-	invalid_pointer();
-	symbol_ptr();
-	kernel_ptr();
-	struct_resource();
-	struct_range();
-	addr();
-	escaped_str();
-	hex_string();
-	mac();
-	ip();
-	uuid();
-	dentry();
-	struct_va_format();
-	time_and_date();
-	struct_clk();
-	bitmap();
-	netdev_features();
-	flags();
-	errptr();
-	fwnode_pointer();
-	fourcc_pointer();
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
 
-	kunittest = test;
-
-	test_basic();
-	test_number();
-	test_string();
-	test_pointer();
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


