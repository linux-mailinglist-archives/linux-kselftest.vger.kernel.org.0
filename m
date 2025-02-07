Return-Path: <linux-kselftest+bounces-26058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F42A2D087
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 23:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D884F16CA00
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242971D79A5;
	Fri,  7 Feb 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqCX/ngp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DE1C6FF4;
	Fri,  7 Feb 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967604; cv=none; b=JnHq1Ey70nGbrziNaX0t5ROanWrh5m1mjkcNLn8MXJIsuQxBvOVtGiSd95aQbHXT6trFI+ivCnXAi9kfVAt76oZXajs6YYNovk/mPsavzJcIcMvOPFtvB423N68h2c1FHZSM1GfOXuN0Pm4VghAKsCOtGmVhcQMNlhacLgFtXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967604; c=relaxed/simple;
	bh=GtI4+o8zfzM39kjmC075mkTpxT5jTOegbxq/Tgag+4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=So4FP8vSbhanxOHXYneOXMHvtHfoEwGpok2vUfrmreM4+tVihhQn9a9dkc9dPsS3nhevL+BGe2e9qMDjafaQ78Ym/xLSMss8Y3a7kLGnO1VAuh5/oLUqGlZeqjXyE45DDPS3iy9g/7cqq5op8dwP45XJsZ7xNg6oPO+Qil0jYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqCX/ngp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6f53c12adso209010285a.1;
        Fri, 07 Feb 2025 14:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738967601; x=1739572401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpCGQLCnE5fyYOrH4BzJkEHn03PTRXuWLZTDDQ1NGUA=;
        b=AqCX/ngpoKsTOJ+6qBnU+C7oxui54eKYw440lr1lMutiT3MlU+BQPQaqvFkEGO+4px
         CrJVMxSHX6zmUlwMyqPbQOJEazVJaFsX5RkEoJbhvweU1PIv7nktTotn7espzFiEXbfN
         SPN6in6+C9ijNHxufUeVL7AWfi8t/cSp+jIRZ+CzoMX1gXVL/ORNtn1B4qJaNRiHft7a
         aK5tUSxh0v+EGb9zekp7zdxkft3e/Wd0uGLJ22EsowQk8ZLOx13GZP2Tk4LBL2bmUxds
         XGPPr/vmvdmLJgnfu9MvHL8fW69+dXa9gUww4fcVbIq7PvJsCgh1Is6Au0+KWq/WYOJK
         6AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738967601; x=1739572401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpCGQLCnE5fyYOrH4BzJkEHn03PTRXuWLZTDDQ1NGUA=;
        b=MRRaESNTIBRgZk3XUzPqrH1fTDua5xOIJJCQvxWnAbpKpsZxhbYcZi6zFkhGRnOhfi
         MmS2NjPm9P44jHH0bBYOsbjTLuHZgiYEh5mzXxlMNO12OPd2zAkcYsehg6bwoFIdOabc
         MTeVmjbNvlquf7FSz+CUPVaSS7UqaEw9HDguNwCN1BHdTJ91JepLVxriLG4/IamZA0si
         9tSbdGxH3qrLzOe959rvMcHlzoyKnJTf7T2nXAKJzA8y5NCKzeUrXTg4E5pSuBxELgzq
         XIqrPGJa4De7oYsZexLJiQ9sxGq750OEonIyhB8gYD0rKxth0Ldd2mbZzqXVuc35Onfh
         KNRA==
X-Forwarded-Encrypted: i=1; AJvYcCV5fpvveMTzrZd906zJMMteXpKjjDkQ2b3gjQpqBXAf5CnoE8/LJZ59GGTTMzPzuBt4cR7GaAx04nTkxq1JiAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gdgRp1VjDqj3nVk61QVvNdQ4ljwLLc2zeAQWCtQgSTYCwyWN
	DvgZ/GUv0XrDT1qhy1MO9np48+RIQ2Pmb61PoqZMq/3OGD1iSmWYHO5xiUP0
X-Gm-Gg: ASbGncv6HAXoKNdfFdQF1d7rhyKMihAyghMysfkxhV4d1S9zS3ZyX2m19WSY8FpcARI
	zXcAaoiTyArlN+8cUMM8mhytei5a1QUysbiYH0N2RVoftHeZIPqa9/5A7a4FhVq8dIBa++5Npaw
	cnQqoyLNbJWP0fK2H+PMdLdLHHF4KzRpfYF6cunESUyYIa2wlByYKqb3OgeOiiuThHnXT27i2Ln
	VI07iuhLHzlur2Ik6UXc3+NNjlnbfcxZNsb5jLPnSNtOIKlQAaCCpzvw+qyTbaeAtMBLzxUXxDs
	PPTNWoCEw6JoXSuU5WNGSbfw+3szrRqFgVWcOPwnsuUcZib4uA==
X-Google-Smtp-Source: AGHT+IE76LK9Ujj2iBUFgVAcFbTl4NJpS6AuzNlP/WfbIMDZoOcx/tvJmvteQPFNOdTFikG4+lhwtA==
X-Received: by 2002:a05:620a:414c:b0:7b0:6e8:94ef with SMTP id af79cd13be357-7c047afb1c9mr651108085a.0.1738967601016;
        Fri, 07 Feb 2025 14:33:21 -0800 (PST)
Received: from Tamirs-MacBook-Pro.local ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f965sm240638085a.86.2025.02.07.14.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:33:19 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 17:33:00 -0500
Subject: [PATCH 2/2] lib/prime_numbers: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-prime_numbers-kunit-convert-v1-2-6067f2b7c713@gmail.com>
References: <20250207-prime_numbers-kunit-convert-v1-0-6067f2b7c713@gmail.com>
In-Reply-To: <20250207-prime_numbers-kunit-convert-v1-0-6067f2b7c713@gmail.com>
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
 lib/Kconfig.debug                            |  14 +++
 lib/math/prime_numbers.c                     | 151 +--------------------------
 lib/math/prime_numbers_private.h             |  64 ++++++++++++
 lib/math/tests/Makefile                      |   1 +
 lib/math/tests/prime_numbers_kunit.c         |  92 ++++++++++++++++
 tools/testing/selftests/lib/config           |   1 -
 tools/testing/selftests/lib/prime_numbers.sh |   4 -
 7 files changed, 173 insertions(+), 154 deletions(-)

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
index 9a17ee9af93a..0842b0826672 100644
--- a/lib/math/prime_numbers.c
+++ b/lib/math/prime_numbers.c
@@ -1,70 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#define pr_fmt(fmt) "prime numbers: " fmt
 
-#include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/prime_numbers.h>
 #include <linux/slab.h>
 
-struct primes {
-	struct rcu_head rcu;
-	unsigned long last, sz;
-	unsigned long primes[];
-};
+#include "prime_numbers_private.h"
 
-#if BITS_PER_LONG == 64
-static const struct primes small_primes = {
-	.last = 61,
-	.sz = 64,
-	.primes = {
-		BIT(2) |
-		BIT(3) |
-		BIT(5) |
-		BIT(7) |
-		BIT(11) |
-		BIT(13) |
-		BIT(17) |
-		BIT(19) |
-		BIT(23) |
-		BIT(29) |
-		BIT(31) |
-		BIT(37) |
-		BIT(41) |
-		BIT(43) |
-		BIT(47) |
-		BIT(53) |
-		BIT(59) |
-		BIT(61)
-	}
-};
-#elif BITS_PER_LONG == 32
-static const struct primes small_primes = {
-	.last = 31,
-	.sz = 32,
-	.primes = {
-		BIT(2) |
-		BIT(3) |
-		BIT(5) |
-		BIT(7) |
-		BIT(11) |
-		BIT(13) |
-		BIT(17) |
-		BIT(19) |
-		BIT(23) |
-		BIT(29) |
-		BIT(31)
-	}
-};
-#else
-#error "unhandled BITS_PER_LONG"
-#endif
-
-static DEFINE_MUTEX(lock);
-static const struct primes __rcu *primes = RCU_INITIALIZER(&small_primes);
-
-static unsigned long selftest_max;
-
-static bool slow_is_prime_number(unsigned long x)
+bool slow_is_prime_number(unsigned long x)
 {
 	unsigned long y = int_sqrt(x);
 
@@ -156,19 +97,6 @@ static bool expand_to_next_prime(unsigned long x)
 	return true;
 }
 
-static void free_primes(void)
-{
-	const struct primes *p;
-
-	mutex_lock(&lock);
-	p = rcu_dereference_protected(primes, lockdep_is_held(&lock));
-	if (p != &small_primes) {
-		rcu_assign_pointer(primes, &small_primes);
-		kfree_rcu((struct primes *)p, rcu);
-	}
-	mutex_unlock(&lock);
-}
-
 /**
  * next_prime_number - return the next prime number
  * @x: the starting point for searching to test
@@ -238,78 +166,3 @@ bool is_prime_number(unsigned long x)
 	return result;
 }
 EXPORT_SYMBOL(is_prime_number);
-
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
-static void __exit primes_exit(void)
-{
-	free_primes();
-}
-
-module_init(primes_init);
-module_exit(primes_exit);
-
-module_param_named(selftest, selftest_max, ulong, 0400);
-
-MODULE_AUTHOR("Intel Corporation");
-MODULE_DESCRIPTION("Prime number library");
-MODULE_LICENSE("GPL");
diff --git a/lib/math/prime_numbers_private.h b/lib/math/prime_numbers_private.h
new file mode 100644
index 000000000000..d0da5584aee8
--- /dev/null
+++ b/lib/math/prime_numbers_private.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/bits.h>
+#include <linux/mutex.h>
+#include <linux/rcupdate.h>
+#include <linux/types.h>
+
+struct primes {
+	struct rcu_head rcu;
+	unsigned long last, sz;
+	unsigned long primes[];
+};
+
+#if BITS_PER_LONG == 64
+static const struct primes small_primes = {
+	.last = 61,
+	.sz = 64,
+	.primes = {
+		BIT(2) |
+		BIT(3) |
+		BIT(5) |
+		BIT(7) |
+		BIT(11) |
+		BIT(13) |
+		BIT(17) |
+		BIT(19) |
+		BIT(23) |
+		BIT(29) |
+		BIT(31) |
+		BIT(37) |
+		BIT(41) |
+		BIT(43) |
+		BIT(47) |
+		BIT(53) |
+		BIT(59) |
+		BIT(61)
+	}
+};
+#elif BITS_PER_LONG == 32
+static const struct primes small_primes = {
+	.last = 31,
+	.sz = 32,
+	.primes = {
+		BIT(2) |
+		BIT(3) |
+		BIT(5) |
+		BIT(7) |
+		BIT(11) |
+		BIT(13) |
+		BIT(17) |
+		BIT(19) |
+		BIT(23) |
+		BIT(29) |
+		BIT(31)
+	}
+};
+#else
+#error "unhandled BITS_PER_LONG"
+#endif
+
+static const struct primes __rcu *primes = RCU_INITIALIZER(&small_primes);
+static DEFINE_MUTEX(lock);
+
+bool slow_is_prime_number(unsigned long x);
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
index 000000000000..8b0884887f20
--- /dev/null
+++ b/lib/math/tests/prime_numbers_kunit.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <linux/prime_numbers.h>
+#include <linux/slab.h>
+
+#include "../prime_numbers_private.h"
+
+static void free_primes(struct kunit_suite *suite)
+{
+	const struct primes *p;
+
+	mutex_lock(&lock);
+	p = rcu_dereference_protected(primes, lockdep_is_held(&lock));
+	if (p != &small_primes) {
+		rcu_assign_pointer(primes, &small_primes);
+		kfree_rcu((struct primes *)p, rcu);
+	}
+	mutex_unlock(&lock);
+}
+
+static void dump_primes(struct kunit *test)
+{
+	const struct primes *p;
+	char *buf;
+
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+	rcu_read_lock();
+	p = rcu_dereference(primes);
+
+	if (buf)
+		bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
+	kunit_info(test, "primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s\n",
+		   p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
+
+	rcu_read_unlock();
+
+	kfree(buf);
+}
+
+static void prime_numbers_test(struct kunit *test)
+{
+	const unsigned long max = 65536;
+	unsigned long x, last;
+
+	for (last = 0, x = 2; x < max; x++) {
+		bool slow = slow_is_prime_number(x);
+		bool fast = is_prime_number(x);
+
+		if (slow != fast) {
+			KUNIT_FAIL(test,
+				   "inconsistent result for is-prime(%lu): slow=%s, fast=%s!\n",
+				   x, slow ? "yes" : "no", fast ? "yes" : "no");
+			goto err;
+		}
+
+		if (!slow)
+			continue;
+
+		if (next_prime_number(last) != x) {
+			KUNIT_FAIL(test,
+				   "incorrect result for next-prime(%lu): expected %lu, got %lu\n",
+				   last, x, next_prime_number(last));
+			goto err;
+		}
+		last = x;
+	}
+
+	kunit_info(test, "%s(%lu) passed, last prime was %lu\n", __func__, x, last);
+
+err:
+	dump_primes(test);
+}
+
+static struct kunit_case prime_numbers_cases[] = {
+	KUNIT_CASE(prime_numbers_test),
+	{},
+};
+
+static struct kunit_suite prime_numbers_suite = {
+	.name = "math-prime_numbers",
+	.suite_exit = free_primes,
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


