Return-Path: <linux-kselftest+bounces-28528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B00A574C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 23:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1475F189096A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99056259C83;
	Fri,  7 Mar 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTetT3a/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC126258CE2;
	Fri,  7 Mar 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385402; cv=none; b=Y+Svti/BnkEcQjRejF1x/n+lZY0NX+LtmNGbii+ApF99eq3pNrD0Uu8Qu63u2krnN0tCjElin5Bc8iNhkIIBlMjWvLMNQq5dGKta6ruNs3orfXYxOKfd4/6WA6+nguPpFb+txXGvm0NzgEcd0/B1YOx7FGY7ClH8PnUnHwwXQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385402; c=relaxed/simple;
	bh=7scroXAPP12Sz/2IvdxkRWf0GF2sTk41YWpz1w+aynY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qg/UGVr6iHRaqwW4qzOudCn/+5rXEiugCvAacX1iyQ/3VC9tqj/Szpj91Pnki7w8af69Uy0P+SLEDUixosWKVaDf8yt8vb6owe+pG4PuCObPt4zTpsVUGtuM7ps1gCrGn96yNIPdHW0IqC620clhFSxG3Yi3zlaD5oHo9ylwQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTetT3a/; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c07b65efeeso222658385a.2;
        Fri, 07 Mar 2025 14:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741385399; x=1741990199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67u4yKx69wt0LUt2XYoCDntO5OlMzTpGLsqyjTaA95c=;
        b=VTetT3a/K47Vbjjz1arUvcqE9DeFln8bPzpG2gnOi865MbtRbxXpGnT+yJBLDG5K4f
         nIpXmWV/iTs+7wPoAWX9iubZ4yVKJGXZnftc+ZzbYRSTh3qRZSSunPjt5CqgFdMTpWW8
         oH3LiFa7J9Q2RMU+h0cr85lSwOcu9dqlvPPQS90rH4tBg5/mvrjYKuPSFgKttHMxrq+w
         /MjnNwTVh3GIhytNVqDTPRltKkHYa1jn1y3SeOqnHwKHMHPcSgF+znLFa4MlQHWvWlIR
         BmmtSaX24a4fj0t2mbsFF94H8XdajuhH3iamkRpfuqP24TL/BdvCxGsVcy3zR8LFJWLm
         cuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741385399; x=1741990199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67u4yKx69wt0LUt2XYoCDntO5OlMzTpGLsqyjTaA95c=;
        b=olcI9Hd3pNAM4kr6wzC1k/uOL/hSPk+O/OAMQM4zNsIaFe3hmJV9OMlfpYvK3OVUGd
         FFSxCRxg5BYcdr2AobfuLi2d7WXo3szDPztGK1SOGjz4fPVpChxIS0Nwk3XytrY0t9v0
         oCb/F1X9yk+rhKnzdGXzDV+TRWTN6S6HfbI8Qw5O6cBK4CmVzouo6XIFPYf8Qyun9LlK
         UBo1KrPoERq/5Z5AJHqfIJpQtQJJgz0KGL+hD73sMJUnR/mPKwWfi80qpCD2lYtk6qSl
         gNng7UIwGjpCcfzyDUJcRo9qWpDVlMc2NQlAtqQk5Cv7z8r5K87R/3WqbjOLiHAOHaY9
         5UJA==
X-Forwarded-Encrypted: i=1; AJvYcCU6eIhBf5iAWA+cHQNE7ZYnzNjst4Gpn6Oou8XypKdiMf8L+wnBb92/6kyOFzV00i7rfQtHiWBuEyrP@vger.kernel.org, AJvYcCUwvs5d5ld1j+iMQV3sLViqDqQpVdXIRybSMPdUQYx+7b+ZfN6KqfPmg/HBtjExM6/cKFKmROvdUt0=@vger.kernel.org, AJvYcCWOwxFHQSTYpscPHf212cPzyoDNMptXnVViKkH0L+qiu9Rjm0VgAiPFTSaz4eCuJgIp0ikypJzYcd6wQ94is5Cg@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTjhe+nM0he0JCM2TWfuYT8hsjh3PXYlidn+WiOmzCYvOkbpu
	QAykjDVCFr77JUlPZ8oIBJaPZxY+pt5jGOp/ADj78liJQRVHks8B
X-Gm-Gg: ASbGncsQaXOVMdsCderKlfWAr3JvhMj4NoRJYNnv0NiH4gWDo6vRX5IhmWOAHT2QTKP
	BXhP2mhViadqFoaIgynUm6G8YNvtlw07DsIgfpsSU5O9uqn8O2+CkesNdlYV4bTNEm4AGR0Sp9R
	oBj+RUJsLlhLmtjqoppNBt6aCeePIOpyEHOviha6ILjPrJPm/JM32TpC6Jr8bmo25hZIq/tzmy2
	Rh3tVNJW/Zfw1VwU4Hixr8jDrsWHlQvznkUmWhAzcMZ3vYqQkJc7xUwCJJ3MWUIdPulrorXy22l
	jCAXGugvd3KuWbakUZLBOQWmDSfcTKOATRIUI+FrrjBm0zrQ9aaqgzB0n07U5TI80fseKEq+k/d
	w
X-Google-Smtp-Source: AGHT+IEai4ZR+GPg9IqBNC11z36R1pgnxaE5azU4DgOMhWO/Agxa1FtzDoKPPOy7rPFAxzIZLqbVOw==
X-Received: by 2002:a05:620a:6501:b0:7c3:9cdd:55a3 with SMTP id af79cd13be357-7c4e1679b53mr826383785a.9.1741385399513;
        Fri, 07 Mar 2025 14:09:59 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a095sm295001385a.3.2025.03.07.14.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:09:58 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 17:08:58 -0500
Subject: [PATCH v6 3/3] printf: implicate test line in failure messages
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-printf-kunit-convert-v6-3-4d85c361c241@gmail.com>
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
index dd373cb9036a..2c9f6170bacd 100644
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
@@ -53,20 +53,24 @@ do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
 	va_end(aq);
 
 	if (ret != elen) {
-		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
-			   bufsize, fmt, ret, elen);
+		KUNIT_FAIL(kunittest,
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
+			   file, line, bufsize, fmt, ret, elen);
 		return;
 	}
 
 	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
-		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n",
-			   bufsize, fmt);
+		KUNIT_FAIL(kunittest,
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) wrote before buffer\n",
+			   file, line, bufsize, fmt);
 		return;
 	}
 
 	if (!bufsize) {
 		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
-			KUNIT_FAIL(kunittest, "vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n", fmt);
+			KUNIT_FAIL(kunittest,
+				   "%s:%d: vsnprintf(buf, 0, \"%s\", ...) wrote to buffer\n",
+				   file, line, fmt);
 		}
 		return;
 	}
@@ -74,34 +78,36 @@ do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
 	written = min(bufsize-1, elen);
 	if (test_buffer[written]) {
 		KUNIT_FAIL(kunittest,
-			   "vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
-			   bufsize, fmt);
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) did not nul-terminate buffer\n",
+			   file, line, bufsize, fmt);
 		return;
 	}
 
 	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
 		KUNIT_FAIL(kunittest,
-			   "vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
-			   bufsize, fmt);
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
+			   file, line, bufsize, fmt);
 		return;
 	}
 
 	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
-		KUNIT_FAIL(kunittest, "vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n",
-			   bufsize, fmt);
+		KUNIT_FAIL(kunittest,
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n",
+			   file, line, bufsize, fmt);
 		return;
 	}
 
 	if (memcmp(test_buffer, expect, written)) {
 		KUNIT_FAIL(kunittest,
-			   "vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
-			   bufsize, fmt, test_buffer, written, expect);
+			   "%s:%d: vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
+			   file, line, bufsize, fmt, test_buffer, written, expect);
 		return;
 	}
 }
 
-static void __printf(4, 5)
-__test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, ...)
+static void __printf(6, 7)
+__test(struct kunit *kunittest, const char *file, const int line, const char *expect, int elen,
+	const char *fmt, ...)
 {
 	va_list ap;
 	int rand;
@@ -109,8 +115,8 @@ __test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, .
 
 	if (elen >= BUF_SIZE) {
 		KUNIT_FAIL(kunittest,
-			   "error in test suite: expected length (%d) >= BUF_SIZE (%d). fmt=\"%s\"\n",
-			   elen, BUF_SIZE, fmt);
+			   "%s:%d: error in test suite: expected length (%d) >= BUF_SIZE (%d). fmt=\"%s\"\n",
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
-				   "kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
-				   fmt, p, expect);
+				   "%s:%d: kvasprintf(..., \"%s\", ...) returned '%s', expected '%s'\n",
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


