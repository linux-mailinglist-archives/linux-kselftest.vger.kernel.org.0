Return-Path: <linux-kselftest+bounces-26080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F2A2D4C6
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E30188DA33
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4C01A8F82;
	Sat,  8 Feb 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yw4cVV3X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0811A8403
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Feb 2025 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739002228; cv=none; b=fO8WbkXzRjg510vbA2+IQMeiF63UUaqnfccrF/6iCgwTl1kT7kbnQYKDinVpFg6eSQEzJ910tDaUFhkXlCkvHDbVQs17w37oe35zYywUHRW6somwn/HY4pkVAYuyZgj7SQF0cGZhXkoA0/EPptaL8o1W+dL2ctxwvJUQQDY8wLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739002228; c=relaxed/simple;
	bh=nAlGizJJ7MstBNg1kfQvHRuKX9fdd9zB0FTkdSwCwAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svs2M1unc1+Y29ZuD5kqAxPNDgyOM1GZXRHSYbASBJm+7UWDPQxINSLG9gDHAeDP/yEDDu0A4hRWnhdDA5VPoyETp9jOqZARCzhLi2p8OTp/WPRq9czJRal9pYnvoPvJmkOSMVBLwloGLEt30laO9dVbU7b74hW8iyLXdFLMgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yw4cVV3X; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ddcff5a823so19690596d6.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Feb 2025 00:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739002226; x=1739607026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7jmz0bOYNFxz1BmaVL4SOyNY7RyZdBcE04kichV9wo0=;
        b=Yw4cVV3XLsvd8S8bbhIcCsYl4E/u/muUaKvRq/BaMtBaAgc9rmyX9NxywDS7Et5dVb
         U0TGJ7wK6dTLO/nLRh1D1RDOg5xfnlxceG25i6ySYZzVH7idU3XTiJ06wg9jDcV+lhdh
         ohscCC7hS1hPRJtciL7/t4SBKCasks3miCedei1Rnm2iwTQmhLbNO1abPl3hE9T4IJ9w
         59wR9dh+ZQ5vz8fg2W3j2eu+zJEH9Q+Hqsz/L0IlDJn6UoRHSWB7AOTTKGkgu4QrIy7P
         lrzsP0qDlb/uzh5pjEy3SDM/UXGsaIgJrZWRloE6YFDU3u7fKxxgRY6aX67bgCy31gvD
         vRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739002226; x=1739607026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jmz0bOYNFxz1BmaVL4SOyNY7RyZdBcE04kichV9wo0=;
        b=EpcQgaZuwVLaDjkbOeVool98lPQIvQ1APK8UWnChRQzlNnlpabUYJZELglmZSc50br
         Yug5wRiGIRJgApVcjLg1rqqOj12FfJAmQYtwNmbA0WMN4VjAzpMLP5NJKaaklb3PJyfe
         KzBMjMpQfWCGIvtzIETJpDw1xD8p7tyQDSB7n0UW7PuR1POXTOwrlgmY2C/xLmKJ6pV9
         eveuV0+8adw/oKS8ax3g7T/4V7ILXecsrNMjea01lu9HVnwTE5VIn+glyjBRI3QAlC7j
         SGPX1GjxD6Z2nC8om4fEgfYkL0ActcWtToXlG9lNI2IoaRgIkwM5kbpJb15mUvD+H1Qq
         pJKA==
X-Forwarded-Encrypted: i=1; AJvYcCVLsXxjcN8aC+PdMPXwBihiL4md5pRWWRF1xZBRq68MJJ+k9QRyLHdOY1OkXkEcAXZttBfD/CHmXEiGXAylrQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWd6Hfb/0vgLKmGsdaa+5q6I0oIyZW90XFlA1RUppy2WGUCoTn
	zWkSTlmNpxtPFf5k8pCY834CUQV+fHYVkqFWs+4sX17bIfmnxkju2rpMpeMFNE4BdKaGs8WsV94
	dwwRL+ZfK410HRQKFsqwzVHiQTLPpPc/KUSVw
X-Gm-Gg: ASbGncueAodPL88EjOlGKPatVY0NqNHQ3ufGvgsz9YfRj8W4EmM6MHcII2No18FqwRz
	pWxCOH+jFfsi8qZX9lq2/LBGiME4/t8/RSCc2v+7hUxf2PkFJRM0bDm/lUHnZJ6iexmc1aqoT7g
	==
X-Google-Smtp-Source: AGHT+IHAQDzb2qM5Kj3KssV96GIRJYD8e3V4UaxHAypkefp3ALA/T4Ox56MjteQPIdPH37dTny1cOpvwyvZXbvOOsHg=
X-Received: by 2002:a05:6214:2621:b0:6e1:6bdf:ed1c with SMTP id
 6a1803df08f44-6e4455fdb46mr95306656d6.14.1739002225603; Sat, 08 Feb 2025
 00:10:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-prime_numbers-kunit-convert-v1-0-6067f2b7c713@gmail.com> <20250207-prime_numbers-kunit-convert-v1-2-6067f2b7c713@gmail.com>
In-Reply-To: <20250207-prime_numbers-kunit-convert-v1-2-6067f2b7c713@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Feb 2025 16:10:13 +0800
X-Gm-Features: AWEUYZnyNJLvcaqnwN9Gp9vVAEZYliQTUDDpozbeg3xKsStdH1sI-hPU6s4BsPA
Message-ID: <CABVgOSni012tKugoP7NN1UnwS-aqtw0mi7cOp2RLzLr7yanq1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/prime_numbers: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f45a8a062d9d0142"

--000000000000f45a8a062d9d0142
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Feb 2025 at 06:33, Tamir Duberstein <tamird@gmail.com> wrote:
>
> Extract a private header and convert the prime_numbers self-test to a
> KUnit test. I considered parameterizing the test using
> `KUNIT_CASE_PARAM` but didn't see how it was possible since the test
> logic is entangled with the test parameter generation logic.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

I'm not totally sold on moving everything into the
prime_numbers_private.h file, as we could end up with duplicate copies
of the small primes list and associated variables.

Would it not make more sense to keep as many of these private as
possible, and only export slow_is_prime_number() -- perhaps
conditionally if the test is enabled --, and use that from the test.
The lists of primes (both the small primes list and the rcu-controlled
larger cache) seem to me to still be implementation details, and the
test itself should share the existing ones.

(And, if we wanted the test to keep its own independent versions of
these, we'd still be in trouble, as the prime number library and the
test might access separate versions of the lists, if they're static to
separate files/modules.)

The only tricky bit would be handling dump_primes(): that could be
done either by exporting (perhaps conditionally / in a namespace) the
prime lists, and having dump_primes() be a part of the test, or
exporting dump_primes() -- which would be simpler, but make it harder
to use the kunit log functions.

Thoughts?

Cheers,
-- David

>  lib/Kconfig.debug                            |  14 +++
>  lib/math/prime_numbers.c                     | 151 +--------------------------
>  lib/math/prime_numbers_private.h             |  64 ++++++++++++
>  lib/math/tests/Makefile                      |   1 +
>  lib/math/tests/prime_numbers_kunit.c         |  92 ++++++++++++++++
>  tools/testing/selftests/lib/config           |   1 -
>  tools/testing/selftests/lib/prime_numbers.sh |   4 -
>  7 files changed, 173 insertions(+), 154 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..616beaca4a2b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3197,6 +3197,20 @@ config INT_SQRT_KUNIT_TEST
>
>           If unsure, say N
>
> +config PRIME_NUMBERS_KUNIT_TEST
> +       tristate "Prime number generator test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       select PRIME_NUMBERS
> +       default KUNIT_ALL_TESTS
> +       help
> +         This option enables the KUnit test suite for the {is,next}_prime_number
> +         functions.
> +
> +         Enabling this option will include tests that compare the prime number
> +         generator functions against a brute force implementation.
> +
> +         If unsure, say N
> +
>  endif # RUNTIME_TESTING_MENU
>
>  config ARCH_USE_MEMTEST
> diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
> index 9a17ee9af93a..0842b0826672 100644
> --- a/lib/math/prime_numbers.c
> +++ b/lib/math/prime_numbers.c
> @@ -1,70 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define pr_fmt(fmt) "prime numbers: " fmt
>
> -#include <linux/module.h>
> -#include <linux/mutex.h>
>  #include <linux/prime_numbers.h>
>  #include <linux/slab.h>
>
> -struct primes {
> -       struct rcu_head rcu;
> -       unsigned long last, sz;
> -       unsigned long primes[];
> -};
> +#include "prime_numbers_private.h"
>
> -#if BITS_PER_LONG == 64
> -static const struct primes small_primes = {
> -       .last = 61,
> -       .sz = 64,
> -       .primes = {
> -               BIT(2) |
> -               BIT(3) |
> -               BIT(5) |
> -               BIT(7) |
> -               BIT(11) |
> -               BIT(13) |
> -               BIT(17) |
> -               BIT(19) |
> -               BIT(23) |
> -               BIT(29) |
> -               BIT(31) |
> -               BIT(37) |
> -               BIT(41) |
> -               BIT(43) |
> -               BIT(47) |
> -               BIT(53) |
> -               BIT(59) |
> -               BIT(61)
> -       }
> -};
> -#elif BITS_PER_LONG == 32
> -static const struct primes small_primes = {
> -       .last = 31,
> -       .sz = 32,
> -       .primes = {
> -               BIT(2) |
> -               BIT(3) |
> -               BIT(5) |
> -               BIT(7) |
> -               BIT(11) |
> -               BIT(13) |
> -               BIT(17) |
> -               BIT(19) |
> -               BIT(23) |
> -               BIT(29) |
> -               BIT(31)
> -       }
> -};
> -#else
> -#error "unhandled BITS_PER_LONG"
> -#endif
> -
> -static DEFINE_MUTEX(lock);
> -static const struct primes __rcu *primes = RCU_INITIALIZER(&small_primes);
> -
> -static unsigned long selftest_max;
> -
> -static bool slow_is_prime_number(unsigned long x)
> +bool slow_is_prime_number(unsigned long x)
>  {
>         unsigned long y = int_sqrt(x);
>
> @@ -156,19 +97,6 @@ static bool expand_to_next_prime(unsigned long x)
>         return true;
>  }
>
> -static void free_primes(void)
> -{
> -       const struct primes *p;
> -
> -       mutex_lock(&lock);
> -       p = rcu_dereference_protected(primes, lockdep_is_held(&lock));
> -       if (p != &small_primes) {
> -               rcu_assign_pointer(primes, &small_primes);
> -               kfree_rcu((struct primes *)p, rcu);
> -       }
> -       mutex_unlock(&lock);
> -}
> -
>  /**
>   * next_prime_number - return the next prime number
>   * @x: the starting point for searching to test
> @@ -238,78 +166,3 @@ bool is_prime_number(unsigned long x)
>         return result;
>  }
>  EXPORT_SYMBOL(is_prime_number);
> -
> -static void dump_primes(void)
> -{
> -       const struct primes *p;
> -       char *buf;
> -
> -       buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -
> -       rcu_read_lock();
> -       p = rcu_dereference(primes);
> -
> -       if (buf)
> -               bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
> -       pr_info("primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s\n",
> -               p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
> -
> -       rcu_read_unlock();
> -
> -       kfree(buf);
> -}
> -
> -static int selftest(unsigned long max)
> -{
> -       unsigned long x, last;
> -
> -       if (!max)
> -               return 0;
> -
> -       for (last = 0, x = 2; x < max; x++) {
> -               bool slow = slow_is_prime_number(x);
> -               bool fast = is_prime_number(x);
> -
> -               if (slow != fast) {
> -                       pr_err("inconsistent result for is-prime(%lu): slow=%s, fast=%s!\n",
> -                              x, slow ? "yes" : "no", fast ? "yes" : "no");
> -                       goto err;
> -               }
> -
> -               if (!slow)
> -                       continue;
> -
> -               if (next_prime_number(last) != x) {
> -                       pr_err("incorrect result for next-prime(%lu): expected %lu, got %lu\n",
> -                              last, x, next_prime_number(last));
> -                       goto err;
> -               }
> -               last = x;
> -       }
> -
> -       pr_info("%s(%lu) passed, last prime was %lu\n", __func__, x, last);
> -       return 0;
> -
> -err:
> -       dump_primes();
> -       return -EINVAL;
> -}
> -
> -static int __init primes_init(void)
> -{
> -       return selftest(selftest_max);
> -}
> -
> -static void __exit primes_exit(void)
> -{
> -       free_primes();

I'd argue that we should keep this here: the primes should be freed
when the prime number library exits, not the test.

> -}
> -
> -module_init(primes_init);
> -module_exit(primes_exit);
> -
> -module_param_named(selftest, selftest_max, ulong, 0400);
> -
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Prime number library");
> -MODULE_LICENSE("GPL");
> diff --git a/lib/math/prime_numbers_private.h b/lib/math/prime_numbers_private.h
> new file mode 100644
> index 000000000000..d0da5584aee8
> --- /dev/null
> +++ b/lib/math/prime_numbers_private.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/bits.h>
> +#include <linux/mutex.h>
> +#include <linux/rcupdate.h>
> +#include <linux/types.h>
> +
> +struct primes {
> +       struct rcu_head rcu;
> +       unsigned long last, sz;
> +       unsigned long primes[];
> +};
> +
> +#if BITS_PER_LONG == 64
> +static const struct primes small_primes = {
> +       .last = 61,
> +       .sz = 64,
> +       .primes = {
> +               BIT(2) |
> +               BIT(3) |
> +               BIT(5) |
> +               BIT(7) |
> +               BIT(11) |
> +               BIT(13) |
> +               BIT(17) |
> +               BIT(19) |
> +               BIT(23) |
> +               BIT(29) |
> +               BIT(31) |
> +               BIT(37) |
> +               BIT(41) |
> +               BIT(43) |
> +               BIT(47) |
> +               BIT(53) |
> +               BIT(59) |
> +               BIT(61)
> +       }
> +};
> +#elif BITS_PER_LONG == 32
> +static const struct primes small_primes = {
> +       .last = 31,
> +       .sz = 32,
> +       .primes = {
> +               BIT(2) |
> +               BIT(3) |
> +               BIT(5) |
> +               BIT(7) |
> +               BIT(11) |
> +               BIT(13) |
> +               BIT(17) |
> +               BIT(19) |
> +               BIT(23) |
> +               BIT(29) |
> +               BIT(31)
> +       }
> +};
> +#else
> +#error "unhandled BITS_PER_LONG"
> +#endif
> +
> +static const struct primes __rcu *primes = RCU_INITIALIZER(&small_primes);
> +static DEFINE_MUTEX(lock);
> +
> +bool slow_is_prime_number(unsigned long x);
> diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
> index e1a79f093b2d..da21a592c75a 100644
> --- a/lib/math/tests/Makefile
> +++ b/lib/math/tests/Makefile
> @@ -2,3 +2,4 @@
>
>  obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
>  obj-$(CONFIG_INT_SQRT_KUNIT_TEST) += int_sqrt_kunit.o
> +obj-$(CONFIG_PRIME_NUMBERS_KUNIT_TEST) += prime_numbers_kunit.o
> diff --git a/lib/math/tests/prime_numbers_kunit.c b/lib/math/tests/prime_numbers_kunit.c
> new file mode 100644
> index 000000000000..8b0884887f20
> --- /dev/null
> +++ b/lib/math/tests/prime_numbers_kunit.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <kunit/test.h>
> +#include <linux/module.h>
> +#include <linux/prime_numbers.h>
> +#include <linux/slab.h>
> +
> +#include "../prime_numbers_private.h"
> +
> +static void free_primes(struct kunit_suite *suite)
> +{
> +       const struct primes *p;
> +
> +       mutex_lock(&lock);
> +       p = rcu_dereference_protected(primes, lockdep_is_held(&lock));
> +       if (p != &small_primes) {
> +               rcu_assign_pointer(primes, &small_primes);
> +               kfree_rcu((struct primes *)p, rcu);
> +       }
> +       mutex_unlock(&lock);
> +}
> +
> +static void dump_primes(struct kunit *test)
> +{
> +       const struct primes *p;
> +       char *buf;
> +
> +       buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +
> +       rcu_read_lock();
> +       p = rcu_dereference(primes);
> +
> +       if (buf)
> +               bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
> +       kunit_info(test, "primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s\n",
> +                  p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
> +
> +       rcu_read_unlock();
> +
> +       kfree(buf);
> +}
> +
> +static void prime_numbers_test(struct kunit *test)
> +{
> +       const unsigned long max = 65536;
> +       unsigned long x, last;
> +
> +       for (last = 0, x = 2; x < max; x++) {
> +               bool slow = slow_is_prime_number(x);
> +               bool fast = is_prime_number(x);
> +
> +               if (slow != fast) {
> +                       KUNIT_FAIL(test,
> +                                  "inconsistent result for is-prime(%lu): slow=%s, fast=%s!\n",
> +                                  x, slow ? "yes" : "no", fast ? "yes" : "no");
> +                       goto err;
> +               }
> +
> +               if (!slow)
> +                       continue;
> +
> +               if (next_prime_number(last) != x) {
> +                       KUNIT_FAIL(test,
> +                                  "incorrect result for next-prime(%lu): expected %lu, got %lu\n",
> +                                  last, x, next_prime_number(last));
> +                       goto err;
> +               }
> +               last = x;
> +       }
> +
> +       kunit_info(test, "%s(%lu) passed, last prime was %lu\n", __func__, x, last);
> +
> +err:
> +       dump_primes(test);
> +}
> +
> +static struct kunit_case prime_numbers_cases[] = {
> +       KUNIT_CASE(prime_numbers_test),
> +       {},
> +};
> +
> +static struct kunit_suite prime_numbers_suite = {
> +       .name = "math-prime_numbers",
> +       .suite_exit = free_primes,

Should we be freeing the primes when the test exits? I suspect we
should leave them in case any other part of the kernel needs them.

(This, of course, potentially makes the test more brittle if run
multiple times (or on a system with already initialised primes), but
seems right to me.


> +       .test_cases = prime_numbers_cases,
> +};
> +
> +kunit_test_suite(prime_numbers_suite);
> +
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("Prime number library");
> +MODULE_LICENSE("GPL");
> diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
> index dc15aba8d0a3..306a3d4dca98 100644
> --- a/tools/testing/selftests/lib/config
> +++ b/tools/testing/selftests/lib/config
> @@ -1,5 +1,4 @@
>  CONFIG_TEST_PRINTF=m
>  CONFIG_TEST_SCANF=m
>  CONFIG_TEST_BITMAP=m
> -CONFIG_PRIME_NUMBERS=m
>  CONFIG_TEST_BITOPS=m
> diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
> deleted file mode 100755
> index 370b79a9cb2e..000000000000
> --- a/tools/testing/selftests/lib/prime_numbers.sh
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -# Checks fast/slow prime_number generation for inconsistencies
> -$(dirname $0)/../kselftest/module.sh "prime numbers" prime_numbers selftest=65536
>
> --
> 2.48.1
>

--000000000000f45a8a062d9d0142
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgA2aMinb2Ld6JFYs5dv6jF7ivAuaS
GBnsE/JbqZsuEyAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjA4MDgxMDI2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAEpdzlybZ5Ho1/ylc7i8ET1NzcqtSEuuvxDBXKlpCUuj0lKP
1Z3faSOth0RzStbymAPvzkQN+HBU3Rll1TU3DC7b+/dSodYdI7CProCvNAhij36nZpe1Szn7r9Xg
QPES2m3g5oHirjRrSu0zpxgnLRYf2uvDbSeGMWld6MzbOdVaq/ugzHpU9GqPoXTmCvW6UzIphYdc
5SinjCu3O7aYBPsvQZc2hAnaW+wCPkPVLj8eWy3W9HKGND8T/V32rQ/h4rIMJg4OJtuo+iBczqX1
S0SWiwxx1iZR95qWrng6Ersmj9kxBUcSlBMcQKe+yYl7dhJiCBpd4XVut18Oo8Cx++Y=
--000000000000f45a8a062d9d0142--

