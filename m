Return-Path: <linux-kselftest+bounces-26129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDC7A2DA6D
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 03:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39A1165DED
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 02:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1638DD3;
	Sun,  9 Feb 2025 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaebeXnI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E017BB6;
	Sun,  9 Feb 2025 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739069089; cv=none; b=truGGV/fzMvhL9qtO+AY3Exd+loOn9OmNHmNgivoajHfQ32eTZu+XTBtoqWauHjai8Mb9RI39E9EaZ3idpxkD8XaTS4DDLoYr2Z0ql5yNrInBUt/DMaFTklSXK5Zb6eF4ubq+WTaiO543a8yEjQdqh8pz9QR+EZ0A4swcH3wxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739069089; c=relaxed/simple;
	bh=R+Ej3p0JX7u2Jyj9Iq3B0x+4Sof3GFGdiI9iDTVWr70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRSKgwwgF7eVQKsQXD/6l8xNCkDLsa0Uy9LVS0pj6gUlNXYbP5AJLNmunrFzvWBFfbDLWriXkMMJzHaOvL1AIbyywbbAuld3Ws7FmpU2g9RhCPJ7wudo0pOLbY8YE/jPcYGUV+o1kUcuqPf4JLvAyDASvLK3NMowwuzNO8hv5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaebeXnI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e4565be0e0so7291966d6.3;
        Sat, 08 Feb 2025 18:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739069086; x=1739673886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MT2QWKpVJu84Rajm4slK6aTceDcWlXFvsi9MYcPxaz8=;
        b=IaebeXnIalf9epCRs5C/EWR9MNwTkQLWnjblt6ppJmp8I/gp5XUF7b73c+UDd+7Qwt
         NMketi/h5h7y2QPsmfO5ffbDyWJYiarg2sY9b73DwXav4fMORELLx1xqazMS7qEtM/vj
         XhyGkkZ/nAuQ1SYSH/Nto0qd0xmU4bEYckAxujvvDNzaoW75hY748Qug3Eni9/U3HFc9
         B+qus5squJMBv5xu/TcedNCFeVkBGOm8Wf+oPYvtVeIDBRExOh30Ka5pVZH+BrJD4VlA
         ke287qKY+C62ggXzf2aZPtjKRwO5diPK5KCo0VMysSlaGdQhJ6/x01ydf/ZL1YzuhN6p
         Bzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739069086; x=1739673886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT2QWKpVJu84Rajm4slK6aTceDcWlXFvsi9MYcPxaz8=;
        b=wFdkS49NQfwvmVG4VtwV3xE9TRxUTyM7FvfLn83LOG6wjcTuGXd393vzADjVowidV7
         +LNUPSn1B4P7oqW5ue+75uUDur0fMGmFzXPW3pu330RN30iy5XeFd1c2nubjrbVl3dqS
         3Q+FHbWzFyl3LW26Yw2874693nmcV5sIaQfRRV+9Z8EOtDRLJIwuhqHXC8tzs6nsN9PL
         v+6Ujvny0waC+rUkQroAXMzaOZASyzhpn7WNlPWzzH/4VHKxFOuMPGT2dDONp01kw44X
         RyUCYrOoONxof+8H3d0+LAJk+fRnRM+oUMEjfWVzzQbHzJWhYpQCBCyZaeohJW9BqKxA
         EDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6lGuT5EJmRJAqOZHvdIm10Oi/Uz5452NPoqpPOYH906Zx1YBy4DPAkq9qcgZYJh/IHQRVgGv3t6R5iMeaqxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mlDKi7a6IgzEWTIS3fbIbEWyD2Lt2TSqIyVv4b2OQqs7TiEt
	yM7Z3gJHjwMp/zOUi7LBnBAaUX7bMSzZTayNtVMSAQVZUsDzdBT3
X-Gm-Gg: ASbGncuyyBDMbjY3s/G/oCjWdaiCMFn07sn7POTjWCUsBZ+smgZqWHJONWmPOmz0MYI
	Z9EI/T57aTSaTu3RJu+reA4FVh55jOwCEBvADiZmwNHsfGkxdQ8zYGFDPmCX3sXVSKKItjuQ+wp
	gH06Rvx1hUpc2yXJCm03rQUGYQ1r+AMX0yyGoTAi2M5a02jytbKS+Ao9ZolU9fSKK13+VBg8e7a
	Y/7wIaisyQGHMTs5LmOwHjoRoOd4UCnilOnuAG2P/r7OO/vGKBAe1kH06JXmoScQaluKf88FKnf
	qcBBxnqHtKmjFZyBF+mXqu70WgPoWFHMMcwcBO9IgFWEuv6quRhy6OJSSu8Y8XKsxYIWMk/+CVa
	vpgsonfvdKm+ejcYyInpdgcWnsdWIaoE1iFirRQ==
X-Google-Smtp-Source: AGHT+IGlTuYy+vTQkFaC3sxhxmhQ1SJFNcgzMnlTb+R4Cj6Uv6WbfOud36acPhdC0Evc8ctDMl7S+Q==
X-Received: by 2002:ad4:5caf:0:b0:6d8:b229:7b3d with SMTP id 6a1803df08f44-6e445416b69mr141379406d6.0.1739069086448;
        Sat, 08 Feb 2025 18:44:46 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:15f6:96e9:3308:934a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e451a83cbcsm11572356d6.102.2025.02.08.18.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 18:44:45 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 08 Feb 2025 21:44:39 -0500
Subject: [PATCH v5 2/2] lib/prime_numbers: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-prime_numbers-kunit-convert-v5-2-b0cb82ae7c7d@gmail.com>
References: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
In-Reply-To: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Extract a private header and convert the prime_numbers self-test to a
KUnit test. I considered parameterizing the test using
`KUNIT_CASE_PARAM` but didn't see how it was possible since the test
logic is entangled with the test parameter generation logic.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/Kconfig.debug                            | 14 +++++
 lib/math/prime_numbers.c                     | 87 +++++-----------------------
 lib/math/prime_numbers_private.h             | 17 ++++++
 lib/math/tests/Makefile                      |  1 +
 lib/math/tests/prime_numbers_kunit.c         | 59 +++++++++++++++++++
 tools/testing/selftests/lib/config           |  1 -
 tools/testing/selftests/lib/prime_numbers.sh |  4 --
 7 files changed, 106 insertions(+), 77 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0ccfab3ecd21..7570caaacddb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3210,6 +3210,20 @@ config GCD_KUNIT_TEST
 
 	  If unsure, say N
 
+config PRIME_NUMBERS_KUNIT_TEST
+	tristate "Prime number generator test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select PRIME_NUMBERS
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the {is,next}_prime_number
+	  functions.
+
+	  Enabling this option will include tests that compare the prime number
+	  generator functions against a brute force implementation.
+
+	  If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
index 9a17ee9af93a..f88d6e64dbdc 100644
--- a/lib/math/prime_numbers.c
+++ b/lib/math/prime_numbers.c
@@ -1,16 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "prime numbers: " fmt
 
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/prime_numbers.h>
 #include <linux/slab.h>
 
-struct primes {
-	struct rcu_head rcu;
-	unsigned long last, sz;
-	unsigned long primes[];
-};
+#include "prime_numbers_private.h"
 
 #if BITS_PER_LONG == 64
 static const struct primes small_primes = {
@@ -62,9 +57,21 @@ static const struct primes small_primes = {
 static DEFINE_MUTEX(lock);
 static const struct primes __rcu *primes = RCU_INITIALIZER(&small_primes);
 
-static unsigned long selftest_max;
+#if IS_ENABLED(CONFIG_PRIME_NUMBERS_KUNIT_TEST)
+void with_primes(void *ctx, primes_fn fn)
+{
+	rcu_read_lock();
+	fn(ctx, rcu_dereference(primes));
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(with_primes);
+
+EXPORT_SYMBOL(slow_is_prime_number);
 
-static bool slow_is_prime_number(unsigned long x)
+#else
+static
+#endif
+bool slow_is_prime_number(unsigned long x)
 {
 	unsigned long y = int_sqrt(x);
 
@@ -239,77 +246,13 @@ bool is_prime_number(unsigned long x)
 }
 EXPORT_SYMBOL(is_prime_number);
 
-static void dump_primes(void)
-{
-	const struct primes *p;
-	char *buf;
-
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-
-	rcu_read_lock();
-	p = rcu_dereference(primes);
-
-	if (buf)
-		bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
-	pr_info("primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s\n",
-		p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
-
-	rcu_read_unlock();
-
-	kfree(buf);
-}
-
-static int selftest(unsigned long max)
-{
-	unsigned long x, last;
-
-	if (!max)
-		return 0;
-
-	for (last = 0, x = 2; x < max; x++) {
-		bool slow = slow_is_prime_number(x);
-		bool fast = is_prime_number(x);
-
-		if (slow != fast) {
-			pr_err("inconsistent result for is-prime(%lu): slow=%s, fast=%s!\n",
-			       x, slow ? "yes" : "no", fast ? "yes" : "no");
-			goto err;
-		}
-
-		if (!slow)
-			continue;
-
-		if (next_prime_number(last) != x) {
-			pr_err("incorrect result for next-prime(%lu): expected %lu, got %lu\n",
-			       last, x, next_prime_number(last));
-			goto err;
-		}
-		last = x;
-	}
-
-	pr_info("%s(%lu) passed, last prime was %lu\n", __func__, x, last);
-	return 0;
-
-err:
-	dump_primes();
-	return -EINVAL;
-}
-
-static int __init primes_init(void)
-{
-	return selftest(selftest_max);
-}
-
 static void __exit primes_exit(void)
 {
 	free_primes();
 }
 
-module_init(primes_init);
 module_exit(primes_exit);
 
-module_param_named(selftest, selftest_max, ulong, 0400);
-
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Prime number library");
 MODULE_LICENSE("GPL");
diff --git a/lib/math/prime_numbers_private.h b/lib/math/prime_numbers_private.h
new file mode 100644
index 000000000000..a4cab3c8c727
--- /dev/null
+++ b/lib/math/prime_numbers_private.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/types.h>
+
+struct primes {
+	struct rcu_head rcu;
+	unsigned long last, sz;
+	unsigned long primes[];
+};
+
+#if IS_ENABLED(CONFIG_PRIME_NUMBERS_KUNIT_TEST)
+bool slow_is_prime_number(unsigned long x);
+typedef void (*primes_fn)(void *, const struct primes *);
+
+// Calls the callback under RCU lock. The callback must not retain the primes pointer.
+void with_primes(void *ctx, primes_fn fn);
+#endif
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index 6a04b4eb22b6..40ad9de29acc 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
 obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += int_sqrt_kunit.o
 obj-$(CONFIG_GCD_KUNIT_TEST) += gcd_kunit.o
+obj-$(CONFIG_PRIME_NUMBERS_KUNIT_TEST) += prime_numbers_kunit.o
diff --git a/lib/math/tests/prime_numbers_kunit.c b/lib/math/tests/prime_numbers_kunit.c
new file mode 100644
index 000000000000..2f1643208c66
--- /dev/null
+++ b/lib/math/tests/prime_numbers_kunit.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <linux/prime_numbers.h>
+
+#include "../prime_numbers_private.h"
+
+static void dump_primes(void *ctx, const struct primes *p)
+{
+	static char buf[PAGE_SIZE];
+	struct kunit_suite *suite = ctx;
+
+	bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
+	kunit_info(suite, "primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s",
+		   p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
+}
+
+static void prime_numbers_test(struct kunit *test)
+{
+	const unsigned long max = 65536;
+	unsigned long x, last, next;
+
+	for (last = 0, x = 2; x < max; x++) {
+		const bool slow = slow_is_prime_number(x);
+		const bool fast = is_prime_number(x);
+
+		KUNIT_ASSERT_EQ_MSG(test, slow, fast, "is-prime(%lu)", x);
+
+		if (!slow)
+			continue;
+
+		next = next_prime_number(last);
+		KUNIT_ASSERT_EQ_MSG(test, next, x, "next-prime(%lu)", last);
+		last = next;
+	}
+}
+
+static void kunit_suite_exit(struct kunit_suite *suite)
+{
+	with_primes(suite, dump_primes);
+}
+
+static struct kunit_case prime_numbers_cases[] = {
+	KUNIT_CASE(prime_numbers_test),
+	{},
+};
+
+static struct kunit_suite prime_numbers_suite = {
+	.name = "math-prime_numbers",
+	.suite_exit = kunit_suite_exit,
+	.test_cases = prime_numbers_cases,
+};
+
+kunit_test_suite(prime_numbers_suite);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Prime number library");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index dc15aba8d0a3..306a3d4dca98 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,5 +1,4 @@
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
-CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_BITOPS=m
diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
deleted file mode 100755
index 370b79a9cb2e..000000000000
--- a/tools/testing/selftests/lib/prime_numbers.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Checks fast/slow prime_number generation for inconsistencies
-$(dirname $0)/../kselftest/module.sh "prime numbers" prime_numbers selftest=65536

-- 
2.48.1


