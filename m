Return-Path: <linux-kselftest+bounces-26125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD7FA2DA06
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 01:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF300165ADC
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B523DE;
	Sun,  9 Feb 2025 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ4aRiJX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127BBF9FE;
	Sun,  9 Feb 2025 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739061703; cv=none; b=kA6mtXHbSVy6xiZZq8vou3IBCGPjX7oq+oFi7Xn52/IqJAD79SYRasdCsj5QLOPDmNHIOtIDXUL4D68eFCMggYmYzLYar2Nsbfd0xdiqUAgV62ZlN/f2CH6IBRTHP4XltXG0pg/qK87k4xxN58RPXQHzMn8VhZ+WRbXWnwyHbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739061703; c=relaxed/simple;
	bh=AxhYUtMzMenDpwHmabTxXGNRCSgVXgsIYjsOlaZcyVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADlvKOF8XSA9qe5QdX6QVO/IsqXhpbQkXZxwieymtypsgcGC5SPZ5j+KbMPrpp785guz5yn9ILS0k20liC6Eih2JLpk7FEOK7X7xD47aog6Lxmu7aI2DogdtCdgK6axDZ70UeVVSCg/YGAXehLO9kRPMhycvtBLsg3TDdEujOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ4aRiJX; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7bcf32a6582so312111885a.1;
        Sat, 08 Feb 2025 16:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739061701; x=1739666501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxSxhVLza0+BMhqBPuRtiRWQzX6i+1FzbVxsquN/ITo=;
        b=eZ4aRiJX2s+cMoNHTV+jv+r2NkUu7Y9UYQqfqzm1jFC52q3tKpzzeUS4bC/OOmI2Bb
         05g9zACpuDz9+eVnfWpZ6sVWYUM6u9+26Wx4tGJdojucXeUwBQoMqZmWoFKy2PSOut/I
         EWLR2Z1LeaRgO5n4u34DzbSe/vo3DoGGPIRC6dHEazck955SF77S3oqBB0UKjN/YOY/k
         QhTbWae0YzouiiAdc0fTmqutQb45I1k6fKH0D+llGt7kA6OL2SQLtTfNE3SQE8Xei5bY
         Lf9h+NnMilhxkbtOWKqXnU0cYJKtep6Uy7UalOPwfncRoJxGSMXJ9/PPLiGfibaOYJ0i
         dK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739061701; x=1739666501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxSxhVLza0+BMhqBPuRtiRWQzX6i+1FzbVxsquN/ITo=;
        b=BC3rUtFpDfTjrIEK3GOC4frXl7lEIEZZyt9kr1yhPYym+/hz4FSVhTNeYX7UOqmxBX
         22Grk5u8qeDLf0Y99HtKEzuXJNDv7ANuHyE/vETQN6H6tnxfxu+qrNSKF4Aa4KY913ov
         x7/DR/ylgTwnpKalBEMMLVwvcJ5QujGutb2J+AxlkGZG11vn8zqh6zCJD0eExFA2MeAT
         Lgd48BrAgiuKBf+GQU9o6KC0sgwD7gHoJkWAzaVOS3/Fgnpm5/yMUq/Bw9kk+dJYacYs
         FA2pP/jCtaN1ypa9CGj1otoxXRRxluUOt2cDSpUl+BBe4YacqBlF8SjvzaK6ezhF726J
         F7cA==
X-Forwarded-Encrypted: i=1; AJvYcCWf4UB9DrSk+WfFBEabhrOF7zlDNNzsI1Ze/Lem92T1SwG6ZiP4Y2G1h9FOXaXGT2Si+ZGVkp+VyVvC7WKoTHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLwS39Y717c9JAQfbrMkpVUXJmsa8ig5PjNqYvkO7Q+wZspU1
	1ha8sbOeH1KFUGv14Q+KoP3PaGLBn3fNSKmhw17oPV5A/R7rvJmo
X-Gm-Gg: ASbGncspzubYF9sQwppXZmdbpFmFOh0/uNDQSDrs9Y4e7M+AWpVHMKyKm3FygxD7pFB
	kMxadexmVFlWNRS8d8LpLqtZl36TpT5/oMeqoBjb6Gx90oyBINqMRUmXGsZlkcEfurrbvJ9pTqv
	RptQTNzweYtRAxMA9RiV/kHerJ8BOS9F00olTtrwQ7OPTsPOwO70VEkgAcT+dHeA92AROnLMB/i
	cjhv0ZL8wP7ddjf+dKTRTywisEH1F8NMuI5jkytE9DUtrL2ZiCNjELdKlNer4UTyAQmGrW3hg7s
	hwTsDkmYresFhSt4YnONrgN+a0OK2cpca5iRhdesRkOtOrJ/bUSRmkkFevEpXGtoSwg0WgGeSmJ
	QHfvllzSpP1ZdZsjHSK8bFrWkPWtvSd2gFbubOA==
X-Google-Smtp-Source: AGHT+IGVF9RsrHv0QdlpD/2lSAclUM8HESpIDKz40cuDujuZRtUnlkh7S+I6QnKniEvpvoIu7HawDg==
X-Received: by 2002:a05:620a:43a6:b0:7b6:d34e:b21a with SMTP id af79cd13be357-7c047c7853emr1410983485a.37.1739061700980;
        Sat, 08 Feb 2025 16:41:40 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:15f6:96e9:3308:934a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041eb7f94sm353272885a.96.2025.02.08.16.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 16:41:39 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 08 Feb 2025 19:41:29 -0500
Subject: [PATCH v4 2/2] lib/prime_numbers: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-prime_numbers-kunit-convert-v4-2-76e36bca06a5@gmail.com>
References: <20250208-prime_numbers-kunit-convert-v4-0-76e36bca06a5@gmail.com>
In-Reply-To: <20250208-prime_numbers-kunit-convert-v4-0-76e36bca06a5@gmail.com>
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
 lib/math/prime_numbers.c                     | 76 ++++------------------------
 lib/math/prime_numbers_private.h             | 17 +++++++
 lib/math/tests/Makefile                      |  1 +
 lib/math/tests/prime_numbers_kunit.c         | 59 +++++++++++++++++++++
 tools/testing/selftests/lib/config           |  1 -
 tools/testing/selftests/lib/prime_numbers.sh |  4 --
 7 files changed, 100 insertions(+), 72 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..616beaca4a2b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3197,6 +3197,20 @@ config INT_SQRT_KUNIT_TEST
 
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
index 9a17ee9af93a..1d20d068dacf 100644
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
@@ -62,9 +57,13 @@ static const struct primes small_primes = {
 static DEFINE_MUTEX(lock);
 static const struct primes __rcu *primes = RCU_INITIALIZER(&small_primes);
 
-static unsigned long selftest_max;
+#if IS_ENABLED(CONFIG_PRIME_NUMBERS_KUNIT_TEST)
+EXPORT_SYMBOL(slow_is_prime_number);
 
-static bool slow_is_prime_number(unsigned long x)
+#else
+static
+#endif
+bool slow_is_prime_number(unsigned long x)
 {
 	unsigned long y = int_sqrt(x);
 
@@ -239,65 +238,11 @@ bool is_prime_number(unsigned long x)
 }
 EXPORT_SYMBOL(is_prime_number);
 
-static void dump_primes(void)
+void with_primes(void *ctx, primes_fn fn)
 {
-	const struct primes *p;
-	char *buf;
-
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-
 	rcu_read_lock();
-	p = rcu_dereference(primes);
-
-	if (buf)
-		bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
-	pr_info("primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s\n",
-		p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
-
+	fn(ctx, rcu_dereference(primes));
 	rcu_read_unlock();
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
 }
 
 static void __exit primes_exit(void)
@@ -305,11 +250,8 @@ static void __exit primes_exit(void)
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
index 000000000000..4d0504459490
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
+#endif
+typedef void (*primes_fn)(void *, const struct primes *);
+
+// Calls the callback under RCU lock. The callback must not retain the primes pointer.
+void with_primes(void *ctx, primes_fn fn);
diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
index e1a79f093b2d..da21a592c75a 100644
--- a/lib/math/tests/Makefile
+++ b/lib/math/tests/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
 obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += int_sqrt_kunit.o
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


