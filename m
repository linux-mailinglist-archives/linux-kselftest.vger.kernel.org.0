Return-Path: <linux-kselftest+bounces-27222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD4A4010E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBCB701B7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A89253F3A;
	Fri, 21 Feb 2025 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa02rRWu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42346253F07;
	Fri, 21 Feb 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170085; cv=none; b=DaZlOzpQ6eXh3TWTs7j9hKuno/Hthxfb/73iV+Z7Wrpdl/M0VKyircvanl9wrgOOyDdezID35eCBbs0BG4rE+EChAg4+IzSJFhlXsF9TyJY5/uDI5BERp45xE2CgumVpW8gKW0yMyuXp2K9e3eNfvpkqn10i3/jqy9ZWXSJ/vJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170085; c=relaxed/simple;
	bh=rviAPBtUobspkNDwfOwDylqUb3/l41NbO4AFds2nZuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhGOap6A7DVfBMP4vXZhihR9G55GMM0MPp6FrKWHjDrI4pBEj00+61v14SNb/bw8gCT8nwAXX2A1j0g+8nbkyY6EmZ8l42cl3fNSDhJXc20Y74Mjr13+ipyMx+cymA58p7d0BhQFooMb+AZ4wpyHymrxfiMU4vTM+NMD31ZB+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa02rRWu; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e66b4607d2so11546856d6.3;
        Fri, 21 Feb 2025 12:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740170081; x=1740774881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eoi45DrFExaeO8JTjw8qgTrj/TOzu6Gqxn36YdKMoVM=;
        b=Fa02rRWu565WCJyFnY9mqr1/7OJW9D+YDnFk36IF8HteIz2U0nNdrAz0qJxrMZuXiq
         uK9AfALH5blT+nIoW+PeUSzTsglNChKobXi6GhaQd/PRA7gJ9ExTHyPRziDS7CXdKsjF
         n4HY6QPxYXtIqNqij+wpqle6N2iivw2yQAFGiLELWCbzlO5jT5LgFadYxumPHXwxWUrB
         wb/BwvOOfD/U0cNg7n5IZ0bnOgJsBnwnchiuxvc0Ye57kAE9elsVDVKz3k/Br42G45vV
         ImG98SwY35+U8GnBlbGra8CwQsH5cNwNmsnmho137AK9JIL3RMdY7m969gb0KsxShSTS
         iOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740170081; x=1740774881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eoi45DrFExaeO8JTjw8qgTrj/TOzu6Gqxn36YdKMoVM=;
        b=fYIG2bRZLK0Qg2JQDWRruuM5YhGgAvyABvdD2nef4aztSzR5Py0a9oNw5fNQFjmIIK
         fjsZMEVDShSE1vC46nBJXhQzX6FmCLe34IdhI69XOCeoMnh/rIxbZ91MzxHJrC3NYttl
         bEX+LAneHddCgoLcV21NhpLVszgfZOoQJnvi+a5G2BtSkeP3yh6jxL12QOVcNydrasMC
         Qpi+fX+29u60SJqGc82/EmHXZO/mqZcMPU3aeJBh3G9HaGjhCIOc9cpbKaKWGAQnLuDB
         TTkspKVtkAhdoqHr0ZLRaJ220T2yvElU6lRdK4t7402qseayBeMZu1Uzc307d+tqM5EP
         LPLA==
X-Forwarded-Encrypted: i=1; AJvYcCWfpCBxBZ5rjaddfB8dpFHt3VjSKSUezwgC0wCC0nFQM0WsU1Bgh8sloPbnEuxS9x9hXVcqURl3vp4=@vger.kernel.org, AJvYcCXqzSktyFzvTgEbmS26c2IpxuwZsRVUr0y/cwxgh1INjSn69uyQuH2cFLp3wnX1uIhelwqYUmsW9+AvUqU/tk54@vger.kernel.org
X-Gm-Message-State: AOJu0YzwuMbeaDUYunvCFBStEk2X3IbB9WcKvhXdHHuCuH4AUAWUp5Cp
	C1ljQU803yCyx6SnAQyMIy58sck8TTQ86dd7apeXWcLLZK/us047pIwshV0EvhI=
X-Gm-Gg: ASbGncu8tTFcvkZjFsM2jgkP2KYgqIg7miGCCSl8oKAsOoWtgGPERYmLumDA/m+PHWS
	7Lb4O4uVZ/fl37AfKpwW+Sk4nSOK0jLP8yP4jvOrVcsKSVV7ZGg1JjIUQrDTq6WzhpdgRHwO5Zx
	5akB2Yl2XUNjCkNvI0NaAmYR+DHoeEsW2MeJXGl0eZRDFdCgiaIZiq212rA84exgJRM7MKb9Y/+
	DOaA0hEAtA1sLYVWHDI6SyTssil9Eaeyy2+AekGYT2fUCVQMqsiZajdCnBEIiiFGChdCiYiJKMh
	5sT/8djGqPBW3rC16B5L92JRO9BQkbZbGSnkqpVCTXziMbZmlw==
X-Google-Smtp-Source: AGHT+IHZk626/PCbkUmvjSlL6T9hQUoiEhcd/cjugAXTLDwX+GAde7Djl8OMDd5sudOZWoO2zG+F+w==
X-Received: by 2002:a05:6214:2422:b0:6d8:9a85:5b44 with SMTP id 6a1803df08f44-6e6ae9959bdmr52539466d6.29.1740170081234;
        Fri, 21 Feb 2025 12:34:41 -0800 (PST)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:880f:47d4:56c6:b852])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f36easm101677546d6.74.2025.02.21.12.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:34:40 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 15:34:32 -0500
Subject: [PATCH v5 3/3] printf: implicate test line in failure messages
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-printf-kunit-convert-v5-3-5db840301730@gmail.com>
References: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
In-Reply-To: <20250221-printf-kunit-convert-v5-0-5db840301730@gmail.com>
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
 linuxppc-dev@lists.ozlabs.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This improves the failure output by pointing to the failing line at the
top level of the test, e.g.:
      # test_number: EXPECTATION FAILED at lib/printf_kunit.c:103
  lib/printf_kunit.c:167: vsnprintf(buf, 256, "%#-12x", ...) wrote '0x1234abcd  ', expected '0x1234abce  '
      # test_number: EXPECTATION FAILED at lib/printf_kunit.c:142
  lib/printf_kunit.c:167: kvasprintf(..., "%#-12x", ...) returned '0x1234abcd  ', expected '0x1234abce  '

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/tests/printf_kunit.c | 62 ++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
index 013df6f6dd49..ed6e708ddb61 100644
--- a/lib/tests/printf_kunit.c
+++ b/lib/tests/printf_kunit.c
@@ -38,9 +38,9 @@ static unsigned int total_tests;
 static char *test_buffer;
 static char *alloced_buffer;
 
-static void __printf(5, 0)
-do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
-	const char *fmt, va_list ap)
+static void __printf(7, 0)
+do_test(struct kunit *kunittest, const char *file, const int line, int bufsize, const char *expect,
+	int elen, const char *fmt, va_list ap)
 {
 	va_list aq;
 	int ret, written;
@@ -53,21 +53,24 @@ do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
 	va_end(aq);
 
 	if (ret != elen) {
-		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d",
-			   bufsize, fmt, ret, elen);
+		KUNIT_FAIL(kunittest,
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d",
+			   file, line, bufsize, fmt, ret, elen);
 		return;
 	}
 
 	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
-		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote before buffer",
-			   bufsize, fmt);
+		KUNIT_FAIL(kunittest,
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) wrote before buffer",
+			   file, line, bufsize, fmt);
 		return;
 	}
 
 	if (!bufsize) {
 		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
-			KUNIT_FAIL(kunittest, "vsnprintf(buf, 0, \"%s\", ...) wrote to buffer",
-				   fmt);
+			KUNIT_FAIL(kunittest,
+				   "%s:%d: vsnprintf(buf, 0, \"%s\", ...) wrote to buffer",
+				   file, line, fmt);
 		}
 		return;
 	}
@@ -75,33 +78,36 @@ do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
 	written = min(bufsize-1, elen);
 	if (test_buffer[written]) {
 		KUNIT_FAIL(kunittest,
-			   "vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer",
-			   bufsize, fmt);
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer",
+			   file, line, bufsize, fmt);
 		return;
 	}
 
 	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
 		KUNIT_FAIL(kunittest,
-			   "vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator",
-			   bufsize, fmt);
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator",
+			   file, line, bufsize, fmt);
 		return;
 	}
 
 	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
-		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer",
-			   bufsize, fmt);
+		KUNIT_FAIL(kunittest,
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer",
+			   file, line, bufsize, fmt);
 		return;
 	}
 
 	if (memcmp(test_buffer, expect, written)) {
-		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'",
-			   bufsize, fmt, test_buffer, written, expect);
+		KUNIT_FAIL(kunittest,
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'",
+			   file, line, bufsize, fmt, test_buffer, written, expect);
 		return;
 	}
 }
 
-static void __printf(4, 0)
-__test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, ...)
+static void __printf(6, 0)
+__test(struct kunit *kunittest, const char *file, const int line, const char *expect, int elen,
+	const char *fmt, ...)
 {
 	va_list ap;
 	int rand;
@@ -109,8 +115,8 @@ __test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, .
 
 	if (elen >= BUF_SIZE) {
 		KUNIT_FAIL(kunittest,
-			   "error in test suite: expected length (%d) >= BUF_SIZE (%d). fmt=\"%s\"",
-			   elen, BUF_SIZE, fmt);
+			   "%s:%d: error in test suite: expected length (%d) >= BUF_SIZE (%d). fmt=\"%s\"",
+			   file, line, elen, BUF_SIZE, fmt);
 		return;
 	}
 
@@ -122,19 +128,19 @@ __test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, .
 	 * enough and 0), and then we also test that kvasprintf would
 	 * be able to print it as expected.
 	 */
-	do_test(kunittest, BUF_SIZE, expect, elen, fmt, ap);
+	do_test(kunittest, file, line, BUF_SIZE, expect, elen, fmt, ap);
 	rand = get_random_u32_inclusive(1, elen + 1);
 	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
-	do_test(kunittest, rand, expect, elen, fmt, ap);
-	do_test(kunittest, 0, expect, elen, fmt, ap);
+	do_test(kunittest, file, line, rand, expect, elen, fmt, ap);
+	do_test(kunittest, file, line, 0, expect, elen, fmt, ap);
 
 	p = kvasprintf(GFP_KERNEL, fmt, ap);
 	if (p) {
 		total_tests++;
 		if (memcmp(p, expect, elen+1)) {
 			KUNIT_FAIL(kunittest,
-				   "kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'",
-				   fmt, p, expect);
+				   "%s:%d: kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'",
+				   file, line, fmt, p, expect);
 		}
 		kfree(p);
 	}
@@ -142,7 +148,7 @@ __test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, .
 }
 
 #define test(expect, fmt, ...)					\
-	__test(kunittest, expect, strlen(expect), fmt, ##__VA_ARGS__)
+	__test(kunittest, __FILE__, __LINE__, expect, strlen(expect), fmt, ##__VA_ARGS__)
 
 static void
 test_basic(struct kunit *kunittest)
@@ -153,7 +159,7 @@ test_basic(struct kunit *kunittest)
 	test("", &nul);
 	test("100%", "100%%");
 	test("xxx%yyy", "xxx%cyyy", '%');
-	__test(kunittest, "xxx\0yyy", 7, "xxx%cyyy", '\0');
+	__test(kunittest, __FILE__, __LINE__, "xxx\0yyy", 7, "xxx%cyyy", '\0');
 }
 
 static void

-- 
2.48.1


