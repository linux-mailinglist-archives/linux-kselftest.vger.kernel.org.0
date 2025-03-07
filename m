Return-Path: <linux-kselftest+bounces-28527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C810EA574BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 23:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6E23AA1E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 22:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1645E258CE9;
	Fri,  7 Mar 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1jvkDng"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD452580F3;
	Fri,  7 Mar 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385401; cv=none; b=nf50YZIcMIw+fcSwcXZQkfx6nEQslWAnwN+XAgWsMv0JpDa8/N5iN/zbyrzwsiZ75yeySwmXO1m54wjgWpb7nUkZAJ6PRVHZ6+/fLzmNtgj1OR3m89frdUzmfmUpeZb78ZhYjLWj8JuwoKqps0ZIizUgsIT/wQ5V9JwuFAnpNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385401; c=relaxed/simple;
	bh=iNTwRun+617rtdADiezsWnkqbbw8TpSDFmSzD2qs180=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rTgv7euvxcRXysTXtqMyX3nhgvI7TnhzRhCFYV4mqtHLMiJo0AyNSrNAyq3EQqmFsLpX9VTZwBfYP4l8U8QDumEil+Qv9H5xHkIguTTuprqEb57MEjRc+WSXT8M+cRrGxG7iWV97760/0fK3V0cSb8CPCad1PclKtYPlG/pe/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1jvkDng; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3d9cdb0ccso441704885a.3;
        Fri, 07 Mar 2025 14:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741385398; x=1741990198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rq6rpvLxlaLKLeBagrOBjQrFrjHENkhMrqRVgxcl+Rg=;
        b=N1jvkDngqY8Ci7GoG7w3u+S70qfwgbQDUIcE3aKpEvQllUIP3NK3ODYQxGAnNHr/sY
         YqbXsAItsYne16chMNm0xyyT5SmEFRCJ7rMrtuXE9ceoy1qQU28j7qcztg9ke6o8soh4
         cQ00HEqX4g5aFjogOtyjYwKRrGgndt/af9z2JeGPNq2m98jnY1iCRZEuHqw3nhKJiuZ7
         S9UZcIATlpQPZqoxHo6QFk/DsvGWaB/qn5uB0GGjeFt+OiL+N00ZfrnFZLt7jdAyWMi4
         uxdeRWTs6Q54yBhNM1cbv7CG9ZXf4Z/Wid8UzMNuVI6ExMXHm/WAywb7Bxrs5FkIXykg
         gBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741385398; x=1741990198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rq6rpvLxlaLKLeBagrOBjQrFrjHENkhMrqRVgxcl+Rg=;
        b=O69kvZucOSUqVxF5fqQwJOrbnGbGoReFYu4LFENLce4OtkeihFfrvrXKd5JIoloyi7
         /gWe8NradGYP4iRFnWgDRiyTnZL+lrf14dlFTvNmqy22iI5/Qbxm5q3r8tO3gtZey0iq
         geGkjnnxAgMvi9bSebIdtEmnpV57zkj0vI3GPpU8RZ64Vlu1bq2zUYCevm4tDzU2Ke97
         CRigx22W9tRziajrVHvVJezfQBR4C88X5zxFMUmDfI/fI99GwYNkmiOdX+kLA1nCxbRg
         1jWpK9HRQOqe5L4hBIaE/k7eSjisSTvtkKu7lq81x0a7YTlbkzipGg5qUzZE+FkxChAQ
         joiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy401LqY8sV2+WtM28lQy8gdbGSMWyG407Z/tPGaeC+5p1dR4fMwnOmbsrlj4U9BEocvj91v8cuws=@vger.kernel.org, AJvYcCVRTeSBuM8TJX+kxPtwxIWiog3oZK1fG74K4FLEoB0LUv4XpnkFwUJXl7QJ9b5NAzURSJmoa0QgmnkRNeocTP8x@vger.kernel.org, AJvYcCXrvTupfKtofjLE7BJIyxd5mjcteH5Ocecah4I4SkUQI3hJy9Wof1uvlniUyzQYhUfkWQQhedzFqJMP@vger.kernel.org
X-Gm-Message-State: AOJu0YzQs/tkD4071N++6J6URHdK8O3ubHvndB660F9y37h0JhZgDHWy
	fpizpjFxw8fF4ikFv1BCL2PQRw41bmdsuDnKs3y5hjeSzX3Kg0jb
X-Gm-Gg: ASbGnct5yIJBSqfwvf4pstKqpsFNFuN2EPoMrhY7fyaybho5Jh48neGIA4/XuCeUhCl
	oNv9pFRujxkRXwUeGksvhljLWJIf/2K6tR1gsN13C6LIKwC4StIF3yX3N1IeUKXUEIvBWRDeOIp
	AdvgD+HfFzS1CfCPufmxz87jmtXQtq99v5pjJdTznzegAIgqyn5tZ0O6qO3JqpT8fm+PFMHeJtd
	jS9SouVkPGq5DnVzRBG8X1KEHd2PGvbXIXcOi7vXJRqaG1tLCfrd2Jvop6MpLmKvuolcQ4wDACz
	Jq8Vz9+H81PbZ6PHw+pwPSFrccRFOHM0QMemCk6wSV/DdFg43iOcENBrKkb1YM32kzLccEcv0Ux
	f
X-Google-Smtp-Source: AGHT+IELzRk4FbPDhdtS3kkUosVsyCQrQZILa+SH/WlHt+UzdGQESwY1IsG2VWsr0M5LWrer0AhV1A==
X-Received: by 2002:a05:620a:1463:b0:7c5:3e22:616f with SMTP id af79cd13be357-7c53e22627cmr60556785a.21.1741385397646;
        Fri, 07 Mar 2025 14:09:57 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a095sm295001385a.3.2025.03.07.14.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:09:56 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 17:08:57 -0500
Subject: [PATCH v6 2/3] printf: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-printf-kunit-convert-v6-2-4d85c361c241@gmail.com>
References: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>
In-Reply-To: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>
To: Arpitha Raghunandan <98.arpi@gmail.com>, 
 David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linuxppc-dev@lists.ozlabs.org, workflows@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Move all tests into `printf_test_cases`. This gives us nicer output in
the event of a failure.

Combine `plain_format` and `plain_hash` into `hash_pointer` since
they're testing the same scenario.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/tests/printf_kunit.c | 295 ++++++++++++++++-------------------------------
 1 file changed, 102 insertions(+), 193 deletions(-)

diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
index 1f4096b015c6..dd373cb9036a 100644
--- a/lib/tests/printf_kunit.c
+++ b/lib/tests/printf_kunit.c
@@ -38,10 +38,8 @@ static unsigned int total_tests;
 static char *test_buffer;
 static char *alloced_buffer;
 
-static struct kunit *kunittest;
-
-static void __printf(4, 0)
-do_test(int bufsize, const char *expect, int elen,
+static void __printf(5, 0)
+do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
 	const char *fmt, va_list ap)
 {
 	va_list aq;
@@ -102,8 +100,8 @@ do_test(int bufsize, const char *expect, int elen,
 	}
 }
 
-static void __printf(3, 4)
-__test(const char *expect, int elen, const char *fmt, ...)
+static void __printf(4, 5)
+__test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, ...)
 {
 	va_list ap;
 	int rand;
@@ -124,11 +122,11 @@ __test(const char *expect, int elen, const char *fmt, ...)
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
@@ -144,10 +142,10 @@ __test(const char *expect, int elen, const char *fmt, ...)
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
@@ -155,11 +153,11 @@ test_basic(void)
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
@@ -181,7 +179,7 @@ test_number(void)
 }
 
 static void
-test_string(void)
+test_string(struct kunit *kunittest)
 {
 	test("", "%s%.0s", "", "123");
 	test("ABCD|abc|123", "%s|%.3s|%.*s", "ABCD", "abcdef", 3, "123456");
@@ -218,30 +216,6 @@ test_string(void)
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
-		kunit_warn(kunittest,
-			   "crng possibly not yet initialized. plain 'p' buffer contains \"%s\"\n",
-			   PTR_VAL_NO_CRNG);
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
@@ -251,90 +225,47 @@ plain_format(void)
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
-		kunit_warn(kunittest,
+		kunit_skip(kunittest,
 			   "crng possibly not yet initialized. plain 'p' buffer contains \"%s\"\n",
 			   PTR_VAL_NO_CRNG);
-		return 0;
 	}
-
-	return 0;
 }
 
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
-}
-
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
-		kunit_warn(kunittest, "skipping plain 'p' tests");
-		return;
-	}
+	char buf[PLAIN_BUF_SIZE];
 
-	err = plain_hash();
-	if (err) {
-		KUNIT_FAIL(kunittest, "plain 'p' does not appear to be hashed\n");
-		return;
-	}
+	plain_hash_to_buffer(kunittest, PTR, buf, PLAIN_BUF_SIZE);
 
-	err = plain_format();
-	if (err) {
-		KUNIT_FAIL(kunittest, "hashing plain 'p' has unexpected format\n");
-	}
+	/*
+	 * The hash of %p is unpredictable, therefore test() cannot be used.
+	 *
+	 * Instead verify that the first 32 bits are zeros on a 64-bit system
+	 * and that the non-hashed value is not printed.
+	 */
+
+	KUNIT_EXPECT_MEMEQ(kunittest, buf, ZEROS, strlen(ZEROS));
+	KUNIT_EXPECT_MEMNEQ(kunittest, buf, PTR_STR, PTR_WIDTH);
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
@@ -343,7 +274,7 @@ test_hashed(const char *fmt, const void *p)
  * NULL pointers aren't hashed.
  */
 static void
-null_pointer(void)
+null_pointer(struct kunit *kunittest)
 {
 	test(ZEROS "00000000", "%p", NULL);
 	test(ZEROS "00000000", "%px", NULL);
@@ -354,7 +285,7 @@ null_pointer(void)
  * Error pointers aren't hashed.
  */
 static void
-error_pointer(void)
+error_pointer(struct kunit *kunittest)
 {
 	test(ONES "fffffff5", "%p", ERR_PTR(-11));
 	test(ONES "fffffff5", "%px", ERR_PTR(-11));
@@ -364,26 +295,26 @@ error_pointer(void)
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
@@ -432,7 +363,7 @@ struct_resource(void)
 }
 
 static void
-struct_range(void)
+struct_range(struct kunit *kunittest)
 {
 	struct range test_range = DEFINE_RANGE(0xc0ffee00ba5eba11,
 					       0xc0ffee00ba5eba11);
@@ -448,17 +379,17 @@ struct_range(void)
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
 
@@ -469,7 +400,7 @@ hex_string(void)
 }
 
 static void
-mac(void)
+mac(struct kunit *kunittest)
 {
 	const u8 addr[6] = {0x2d, 0x48, 0xd6, 0xfc, 0x7a, 0x05};
 
@@ -481,7 +412,7 @@ mac(void)
 }
 
 static void
-ip4(void)
+ip4(struct kunit *kunittest)
 {
 	struct sockaddr_in sa;
 
@@ -496,19 +427,12 @@ ip4(void)
 }
 
 static void
-ip6(void)
-{
-}
-
-static void
-ip(void)
+ip6(struct kunit *kunittest)
 {
-	ip4();
-	ip6();
 }
 
 static void
-uuid(void)
+uuid(struct kunit *kunittest)
 {
 	const char uuid[16] = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
 			       0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf};
@@ -535,7 +459,7 @@ static struct dentry test_dentry[4] = {
 };
 
 static void
-dentry(void)
+dentry(struct kunit *kunittest)
 {
 	test("foo", "%pd", &test_dentry[0]);
 	test("foo", "%pd2", &test_dentry[0]);
@@ -556,12 +480,12 @@ dentry(void)
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
@@ -595,12 +519,12 @@ time_and_date(void)
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
@@ -614,7 +538,7 @@ large_bitmap(void)
 }
 
 static void
-bitmap(void)
+bitmap(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(bits, 20);
 	const int primes[] = {2,3,5,7,11,13,17,19};
@@ -633,11 +557,11 @@ bitmap(void)
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
 
@@ -663,8 +587,8 @@ static const struct page_flags_test pft[] = {
 };
 
 static void
-page_flags_test(int section, int node, int zone, int last_cpupid,
-		int kasan_tag, unsigned long flags, const char *name,
+page_flags_test(struct kunit *kunittest, int section, int node, int zone,
+		int last_cpupid, int kasan_tag, unsigned long flags, const char *name,
 		char *cmp_buf)
 {
 	unsigned long values[] = {section, node, zone, last_cpupid, kasan_tag};
@@ -701,25 +625,24 @@ page_flags_test(int section, int node, int zone, int last_cpupid,
 }
 
 static void
-flags(void)
+flags(struct kunit *kunittest)
 {
 	unsigned long flags;
 	char *cmp_buffer;
 	gfp_t gfp;
 
-	cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
-	if (!cmp_buffer)
-		return;
+	cmp_buffer = kunit_kmalloc(kunittest, BUF_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(kunittest, cmp_buffer);
 
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
 
@@ -744,11 +667,9 @@ flags(void)
 							(unsigned long) gfp);
 	gfp |= __GFP_HIGH;
 	test(cmp_buffer, "%pGg", &gfp);
-
-	kfree(cmp_buffer);
 }
 
-static void fwnode_pointer(void)
+static void fwnode_pointer(struct kunit *kunittest)
 {
 	const struct software_node first = { .name = "first" };
 	const struct software_node second = { .name = "second", .parent = &first };
@@ -762,8 +683,7 @@ static void fwnode_pointer(void)
 
 	rval = software_node_register_node_group(group);
 	if (rval) {
-		kunit_warn(kunittest, "cannot register softnodes; rval %d\n", rval);
-		return;
+		kunit_skip(kunittest, "cannot register softnodes; rval %d\n", rval);
 	}
 
 	test(full_name_second, "%pfw", software_node_fwnode(&second));
@@ -775,7 +695,7 @@ static void fwnode_pointer(void)
 	software_node_unregister_node_group(group);
 }
 
-static void fourcc_pointer(void)
+static void fourcc_pointer(struct kunit *kunittest)
 {
 	struct {
 		u32 code;
@@ -793,13 +713,13 @@ static void fourcc_pointer(void)
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
@@ -812,65 +732,54 @@ errptr(void)
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
+static int printf_suite_init(struct kunit_suite *suite)
 {
+	total_tests = 0;
+
 	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
 	if (!alloced_buffer)
-		return;
+		return -ENOMEM;
 	test_buffer = alloced_buffer + PAD_SIZE;
 
-	kunittest = test;
-
-	test_basic();
-	test_number();
-	test_string();
-	test_pointer();
-
-	kfree(alloced_buffer);
-}
-
-static int printf_suite_init(struct kunit_suite *suite)
-{
-	total_tests = 0;
 	return 0;
 }
 
 static void printf_suite_exit(struct kunit_suite *suite)
 {
+	kfree(alloced_buffer);
+
 	kunit_info(suite, "ran %u tests\n", total_tests);
 }
 
 static struct kunit_case printf_test_cases[] = {
-	KUNIT_CASE(printf_test),
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
 	{}
 };
 

-- 
2.48.1


