Return-Path: <linux-kselftest+bounces-26694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B799A367E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 22:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7CF1729AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6C1FC109;
	Fri, 14 Feb 2025 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIH8ubkD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B911FC0E3;
	Fri, 14 Feb 2025 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569984; cv=none; b=rTGgamYb6yx2KfeOBPdsFgBkF8YUN9egv5Y/5AIgeKaCES4r61/IehwVRCBNh/UMHbvz0OoC0rwH/QiZDkjFKC9E1BVp/ZOSynA2O41giT3tx/zktzzDCAw4LpJCzUxtH5L0G7lAJShE4kUqsrEFemx3Bfj5SQNLuyewEu/IQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569984; c=relaxed/simple;
	bh=HavbWFUnciSTOttH8mfqU/8SObb8RPeSLGn2Jxv5I4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTkrImp1pg/Vf0oz+S9hyJatCOPEU/rSi8rLuJZHxRM+qHpz4cVj86siOGilEAcM9gx0nzF6Jz/HpodxurYWbT5z/w9wxae/BEnYWFXhKfqCmAIavpMMlgryeheQMadmv7OqApDLUc5lr2IHdNTisbq0fbcdvRbGe9zQ8i+nRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIH8ubkD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471dc990e18so1502951cf.0;
        Fri, 14 Feb 2025 13:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739569982; x=1740174782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFMliA0Dn/p4u+VrmfnKQQd+kfiJIGEDkR0ON34/fPY=;
        b=JIH8ubkDuoLxWaqLN5X+0s5K0Dgwk7bqnfgzpjF7GQEPWOXS+otkN9l9YhlqcZR4lf
         qfaYA+LlUCCIctdasfU3DHdUxBriXJ/b+LnIFsmKNAKxJcb0KSLEtTxi5NumuZw7/rE+
         WO3P+CXPv8AC7exeJdBU08sR1q8rl5X/ancNI8MloRvy68rReOy7+0NUVvEJr2sHaYTW
         eCqtbZwKl+DUWMtrfYUtd/k/uDi8UbFhanGesm116Gtghr+aa4U0W9JOyqmEdbrS3hlZ
         0XA8L78ZQNVrUM4snh8nIT/T9HbHU+iHBvmdxKzPR/cxsztZezNoe6IRUn2gdhxjqDYN
         ZW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739569982; x=1740174782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFMliA0Dn/p4u+VrmfnKQQd+kfiJIGEDkR0ON34/fPY=;
        b=gKn/Da0RbcAj4tlJLFkwPXW/m2CXBurNbQI/mdY4o/cRPgK2DET/QZFVr0lP8lGKIv
         EW2Am44kOvZRUjsxXw9EWkHjyyl+ZK9RqTwaiLUhOmLEq7H94JISmyc8i1QiDRMwGWA7
         B/dC9j/uALBS/kiVjg3T5Dd+SDDwtgCwRbOQ7WTqjLVQOHRhq0aFrJ2SfobqHnsLkhHK
         1x9EqqIOpVMlJFY7egh7qrlIk+Mv2Kke/nXwsOjeJcdVLIaTfTJhEOjyGJh50Vro6ReS
         Wsc4ao6d3wbQ4MHe7Y33HlRGdL7l5y9Z5iBC+D3PI9Xxql4chDrZrPABbj91WOpqbpoh
         7iyA==
X-Forwarded-Encrypted: i=1; AJvYcCWTbtgTtCr5TORv0IbnVSbtTuyciCM+3OM3HZLrbR9CPkegmS9O+M7Nz+EOD/RrDL1Xj/FUFchdAwv1Qs40Sx1r@vger.kernel.org, AJvYcCXgPGeQkWJT6tfVIZswD4zI5wCIfBKpkllqsLA9tF4paXpMYnTg34NBl4PuSUP2VsyEBQ1Vm5Gc9ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFa2zEtbMhI7BTCe4IiIIBXQ+w6srmbIKNWVjJTzUli2pgCz9
	cef8xvZ+Iyt6YxXo7axAyac4NHrpq2+RYKWJGakLBeYYVLQi6bq4
X-Gm-Gg: ASbGncuPB2Oh6UepeD7VeUqjcoLuLqhuybhQYvQbpfv+unAwWYfTxxwZHnPnv4WUaSS
	UFVnEYIKOKBc8T0WNPQcJzPXEjwOVTXbew982rc+NzMOAI3TTNyBBxgDn83XsjemAHQUnAlPLet
	wCXo+FND+DN2KCdel86oQmNDqtSWetwwqeeZolno28896C1TWfkJjhhSM9krtJemE9cD7BVC8Xf
	Rnw1V2u9oyf4E0C+GZvH0maEiQzMEBaaq5Z/PUl3tt73O6DcuryGDY90Z2Ngs/FVVkBp0qXoGKM
	Pq90AoCtixAbR35WlHEGXzIGSqWYNATOI2ZmOg==
X-Google-Smtp-Source: AGHT+IFHRDJwKLMxI67DD6WpGbO1HVraQMP3bdVweoIapsF2KWSn8IFdluxVK/yBTsz5cTIjR/UZbQ==
X-Received: by 2002:a05:622a:241:b0:471:bce7:39e2 with SMTP id d75a77b69052e-471dbd234f4mr12562881cf.17.1739569981830;
        Fri, 14 Feb 2025 13:53:01 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:d4df:402c:65f0:87da])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2af3367sm21844451cf.59.2025.02.14.13.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:53:00 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 16:52:41 -0500
Subject: [PATCH v4 3/3] printf: implicate test line in failure messages
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-printf-kunit-convert-v4-3-c254572f1565@gmail.com>
References: <20250214-printf-kunit-convert-v4-0-c254572f1565@gmail.com>
In-Reply-To: <20250214-printf-kunit-convert-v4-0-c254572f1565@gmail.com>
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
 lib/tests/printf_kunit.c | 60 ++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/lib/tests/printf_kunit.c b/lib/tests/printf_kunit.c
index 013df6f6dd49..aa5011156788 100644
--- a/lib/tests/printf_kunit.c
+++ b/lib/tests/printf_kunit.c
@@ -39,8 +39,8 @@ static char *test_buffer;
 static char *alloced_buffer;
 
 static void __printf(5, 0)
-do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
-	const char *fmt, va_list ap)
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


