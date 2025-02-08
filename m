Return-Path: <linux-kselftest+bounces-26102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD2DA2D680
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 14:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDB9188C598
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E74248191;
	Sat,  8 Feb 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc0CJ/Vh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AED248172;
	Sat,  8 Feb 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739023119; cv=none; b=omG55nLsJaQWDzHloRBGDtPZ6R4lRSsL1Td3Ok3y/4PzxeLO1sgZLBfjF5qeomj6WB7/azOmPHz+oPnQfSigsaOc8oksgA1e63pxLuvgSzPXQofpjwiC6gU3eclrMI4b0WMXAB/zdgdcxYAHW2j2G5yxzRpVO53uuxzqNOodVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739023119; c=relaxed/simple;
	bh=4h/5xCQ9DdpC0sspKUfmY1D7Zf1P+efH/5bWl2+bD18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hz+k7eMdfxFzexhgT9O+84UAUZGcVzOD1Rc7wazawJZy4xXQ0dKfWIfjIgMevFOKbhTqORRfvDyfARfk5Su6+doOCOvp/ISb7whfusGeXcRxFvancwgkPjyzzwyHD0BOv1Jjl5WKDbOrupE2chsGQGD3Bk2qz88Luw74mdppUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc0CJ/Vh; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be8f281714so284480585a.1;
        Sat, 08 Feb 2025 05:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739023116; x=1739627916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0OiCJUdI9I/BaY3MuN9yP75cGdrCi/IQPunLjbXuKE=;
        b=cc0CJ/Vh6xWYJxRtOkCwR5MmTGbDCH2JI2nO+m4vGIHFzo3nTtAvtNo1DxAiwYjH7z
         izorMapBc+lrFO0f+WEB2G0h2ph7uU9p5BNTx170rxmbEA8ddxNa7NngqKjzMY9ZDuFn
         2ejRhEqsbNBe3viES75eSCMtFHlViW0DmJUcrOzSgmOKrSA2xZSyyoGYRNIMRwVuoqzj
         bsOgLgart1HhIDbpg4qLNZtNP9oTNPSO0mtLwzSBe7olf+8jrRG9Hm7c2K61b6rdmKtM
         IeDWyR64sWzfI1MvlEvZX6NV4ivxRZbvqDZ95p6VmzbOaWlz6tS62q4g3RK2ZlOm7nzm
         lOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739023116; x=1739627916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0OiCJUdI9I/BaY3MuN9yP75cGdrCi/IQPunLjbXuKE=;
        b=nZ3Y50/5SQAm6a6nMH/RaNGqScOhmURvVot2NRh84FwmFEw8G5A23bC0ALKXaaL9xs
         MDrjc7wUBjAEXKz5bs194iLV3aKA4jeodaUZt7IUxDlrxoIQBdcmCUiX4owDYn9+WFcp
         pZWmbuvAF7WQFyXEYe2HQtxMuKLREMkGaC3SmQ65M8QJojlSSJVKbB6u0hZesdg4Q5HY
         /Ax9uHk4+qWU04zNRAyzVRNycHvgJMD0zbqoDmxPDuEbb0AgHoH5f33kNkq2TZVrlYa9
         LSNoV1o+VCfJjh/TZcJj2xOjkexUuz5p17F8IVMIxdhkR1tk8T7ARz/YJdbzd/pOYF21
         vAYg==
X-Forwarded-Encrypted: i=1; AJvYcCWvlGv0TCd7mNU2NWBKPVvpqtchf+DI5Pr57PfQjm0ZYaPRjO4NPY6OPgW6gN9RE7AdcKLkt5a/eL0feUIZaA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAdpBw+d0AgnGJI+ppA/bVikkZmXKSJzsxfZFcJZcWKlUjRIp
	ggsBROrdluo3En1QqttMuy7oXf9Q6UuqhF1gWx9raFR5CBIdpEQM
X-Gm-Gg: ASbGncsFYrDOKLQcMBbqJ2TOyNUAzFSyl+wIz8jBgBLblq62x22jDqA4CTv58rLgEPu
	K4knHUbaWPmJBDqTzT2U8+45eQNxk6u3QJlHCuFC6Qad3WS0qxZUDST/m3ENyfIaBboH+01H+LS
	MEqjXW9dPHXZqYo9Ig7Ylsf6toR3PUjplJt0rGvQ5Tya32Buqh6sVrMo6ajWXm7SmDL8a7VOQUF
	byHHBhhD4oBIqCHnV1SbWVqQuAOhyF900SLSmNKEJkV28C3gqg60scajcGS8xE+dLJsGc+LNgSG
	aB91LdA+acYhl+ov3eSATD7NRYlKSYhk3zZwOYnIY4/3rzX9Ng==
X-Google-Smtp-Source: AGHT+IEFQlNzRIrNeyhe6JrHL0OiDdXZDr7RaD8Z+CaXGcG6UWscsajLWHK1HgsQDFW+EAVjMcJBwA==
X-Received: by 2002:a05:620a:f14:b0:7b1:5763:4ba2 with SMTP id af79cd13be357-7c047c7504dmr1229407885a.40.1739023116034;
        Sat, 08 Feb 2025 05:58:36 -0800 (PST)
Received: from Tamirs-MacBook-Pro.local ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471810804e9sm3268471cf.80.2025.02.08.05.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 05:58:35 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 08 Feb 2025 08:58:29 -0500
Subject: [PATCH v2 2/2] lib/prime_numbers: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-prime_numbers-kunit-convert-v2-2-863119447e04@gmail.com>
References: <20250208-prime_numbers-kunit-convert-v2-0-863119447e04@gmail.com>
In-Reply-To: <20250208-prime_numbers-kunit-convert-v2-0-863119447e04@gmail.com>
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
 lib/math/prime_numbers.c                     | 82 ++++------------------------
 lib/math/prime_numbers_private.h             | 17 ++++++
 lib/math/tests/Makefile                      |  1 +
 lib/math/tests/prime_numbers_kunit.c         | 59 ++++++++++++++++++++
 tools/testing/selftests/lib/config           |  1 -
 tools/testing/selftests/lib/prime_numbers.sh |  4 --
 7 files changed, 102 insertions(+), 76 deletions(-)

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
index 9a17ee9af93a..540d9b7b178f 100644
--- a/lib/math/prime_numbers.c
+++ b/lib/math/prime_numbers.c
@@ -1,16 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "prime numbers: " fmt
 
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/prime_numbers.h>
-#include <linux/slab.h>
 
-struct primes {
-	struct rcu_head rcu;
-	unsigned long last, sz;
-	unsigned long primes[];
-};
+#include "prime_numbers_private.h"
 
 #if BITS_PER_LONG == 64
 static const struct primes small_primes = {
@@ -64,7 +58,13 @@ static const struct primes __rcu *primes = RCU_INITIALIZER(&small_primes);
 
 static unsigned long selftest_max;
 
-static bool slow_is_prime_number(unsigned long x)
+#ifdef CONFIG_PRIME_NUMBERS_KUNIT_TEST
+EXPORT_SYMBOL(slow_is_prime_number);
+
+#else
+static
+#endif
+bool slow_is_prime_number(unsigned long x)
 {
 	unsigned long y = int_sqrt(x);
 
@@ -239,74 +239,14 @@ bool is_prime_number(unsigned long x)
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
-}
-
-static void __exit primes_exit(void)
-{
-	free_primes();
 }
 
-module_init(primes_init);
-module_exit(primes_exit);
+module_exit(free_primes);
 
 module_param_named(selftest, selftest_max, ulong, 0400);
 
diff --git a/lib/math/prime_numbers_private.h b/lib/math/prime_numbers_private.h
new file mode 100644
index 000000000000..9e1d440c5398
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
+#ifdef CONFIG_PRIME_NUMBERS_KUNIT_TEST
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


