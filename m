Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D601F7EFB
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jun 2020 00:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFLWgs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 18:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgFLWgr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 18:36:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825E0C03E96F
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 15:36:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so4310998plb.11
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 15:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lO8mi2zhhtsGQXztgPFepnvQEc1Z1nZkKCQAprRqTJ4=;
        b=XsmsOLCFQ93CbLn9XQetz0h9AFJYU3ErW5h+8j+CVclkQsYBeNjGXvwmosvZkRiHCj
         xycBVj8L/V6qzkc39xxVw3XI6A9itH8pQiXCHcN+kZ/PkXsLDOqTaA8OEHVKdlVmI6D/
         VYg1SNz562LcmJvbRlZRyCd5daQtFxeb8sbPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lO8mi2zhhtsGQXztgPFepnvQEc1Z1nZkKCQAprRqTJ4=;
        b=Uzqbph1Psw42oWgIiQ4PuNOq5JqcQNlsx8NrLMeIxjbMh92Ty4N30R4ku0HuRcC1zy
         h8wa1I8Hn1AB8tPq22PDs8i3I+kIaFU91ulCzek/aWIkDUp+QtQj7koA77i/umxMYA/k
         F/tyCijfkXsrXgW8C7Hj2K+t2RH/M6P1iWeviaSj5W8gqFdIIv9D2yla9dbx+RdQEACf
         BRkJGlRDKHWkeuf+mI3EQ2TjWbSrqTqSajRpdyZjeXT9AVQp8/HKX5EeAoiPj2EYaocb
         rxZr1On4Td50f8fFj8zoUqy4gyi+E0wJpCGDqnPEZHfsTquJa54nq8jXRDB2zesoaBWJ
         0DCg==
X-Gm-Message-State: AOAM532my1uPU2NnJ81ONeyKkJ/K8UwaSMYzMuyVVUzWxHtpnHCxpBT4
        8dpIXL6BfINZu/25bIFVFIrUGg==
X-Google-Smtp-Source: ABdhPJyrBo5EKiDLRgRPY9opnNYen61fBUs9EhgZy/OdHh3845pdzrbzn9u/rdo0zXk8zuFL7tbD7A==
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr1041887pjq.145.1592001405265;
        Fri, 12 Jun 2020 15:36:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13sm6481571pje.25.2020.06.12.15.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 15:36:44 -0700 (PDT)
Date:   Fri, 12 Jun 2020 15:36:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH] lib: kunit_test_overflow: add KUnit test of
 check_*_overflow functions
Message-ID: <202006121403.CF8D57C@keescook>
References: <20200611215501.213058-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611215501.213058-1-vitor@massaru.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 11, 2020 at 06:55:01PM -0300, Vitor Massaru Iha wrote:
> This adds the convertion of the runtime tests of check_*_overflow fuctions,
> from `lib/test_overflow.c`to KUnit tests.
>
> The log similar to the one seen in dmesg running test_overflow can be
> seen in `test.log`.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  lib/Kconfig.debug         |  17 ++
>  lib/Makefile              |   1 +
>  lib/kunit_overflow_test.c | 590 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 608 insertions(+)
>  create mode 100644 lib/kunit_overflow_test.c

What tree is this based on? I can't apply it to v5.7, linux-next, nor
Linus's latest. I've fixed it up to apply to linux-next for now. :)

Looking at linux-next, though, I am reminded of my agony over naming:

obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += kunit_overflow_test.o

*-test
test_*
*_test

This has to get fixed now, and the naming convention needs to be
documented. For old tests, the preferred naming was test_*. For kunit, I
think it should be kunit_* (and no trailing _test; that's redundant).

For for this bikeshed, I think it should be kunit_overflow.c

For the CONFIG name, it seems to be suggested in docs to be
*_KUNIT_TEST:

...
menuconfig). From there, you can enable any KUnit tests you want: they usually
have config options ending in ``_KUNIT_TEST``.
...

I think much stronger language needs to be added to "Writing your first
test" (which actually recommends the wrong thing: "config
MISC_EXAMPLE_TEST"). And then doesn't specify a module file name, though
it hints at one:

...
        obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
...

So, please, let's get this documented: we really really need a single
naming convention for these.

For Kconfig in the tree, I see:

drivers/base/Kconfig:config PM_QOS_KUNIT_TEST
drivers/base/test/Kconfig:config KUNIT_DRIVER_PE_TEST
fs/ext4/Kconfig:config EXT4_KUNIT_TESTS
lib/Kconfig.debug:config SYSCTL_KUNIT_TEST
lib/Kconfig.debug:config OVERFLOW_KUNIT_TEST
lib/Kconfig.debug:config LIST_KUNIT_TEST
lib/Kconfig.debug:config LINEAR_RANGES_TEST
lib/kunit/Kconfig:menuconfig KUNIT
lib/kunit/Kconfig:config KUNIT_DEBUGFS
lib/kunit/Kconfig:config KUNIT_TEST
lib/kunit/Kconfig:config KUNIT_EXAMPLE_TEST
lib/kunit/Kconfig:config KUNIT_ALL_TESTS

Which is:

*_KUNIT_TEST
KUNIT_*_TEST
KUNIT_*_TESTS
*_TEST

Nooooo. ;)

If it should all be *_KUNIT_TEST, let's do that. I think just *_KUNIT
would be sufficient (again, adding the word "test" to "kunit" is
redundant). And it absolutely should not be a prefix, otherwise it'll
get sorted away from the thing it's named after. So my preference is
here would be CONFIG_OVERFLOW_KUNIT. (Yes the old convention was
CONFIG_TEST_*, but those things tended to be regression tests, not unit
tests.)

Please please, can we fix this before we add anything more?

>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1f4ab7a2bdee..72fcfe1f24a4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2075,6 +2075,23 @@ config SYSCTL_KUNIT_TEST
>
>  	  If unsure, say N.
>
> +config OVERFLOW_KUNIT_TEST
> +	tristate "KUnit test for overflow" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the overflow KUnit tests.
> +
> +	  KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> +	  running KUnit test harness and are not for inclusion into a production
> +	  build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config LIST_KUNIT_TEST
>  	tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_ALL_TESTS
>  	depends on KUNIT

Regarding output:

[   36.611358] TAP version 14
[   36.611953]     # Subtest: overflow
[   36.611954]     1..3
...
[   36.622914]     # overflow_calculation_test: s64: 21 arithmetic tests
[   36.624020]     ok 1 - overflow_calculation_test
...
[   36.731096]     # overflow_shift_test: ok: (s64)(0 << 63) == 0
[   36.731840]     ok 2 - overflow_shift_test
...
[   36.750294] kunit_try_catch: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
...
[   36.805350]     # overflow_allocation_test: devm_kzalloc detected saturation
[   36.807763]     ok 3 - overflow_allocation_test
[   36.807765] ok 1 - overflow

A few things here....

- On the outer test report, there is no "plan" line (I was expecting
  "1..1"). Technically it's optional, but it seems like the information
  is available. :)

- The subtest should have its own "TAP version 14" line, and it should
  be using the diagnostic line prefix for the top-level test (this is
  what kselftest is doing).

- There is no way to distinguish top-level TAP output from kernel log
  lines. I think we should stick with the existing marker, which is
  "# ", so that kernel output has no way to be interpreted as TAP
  details -- unless it intentionally starts adding "#"s. ;)

- There is no summary line (to help humans). For example, the kselftest
  API produces a final pass/fail report.

Taken together, I was expecting the output to be:

[   36.611358] # TAP version 14
[   36.611953] # 1..1
[   36.611958] # # TAP version 14
[   36.611954] # # 1..3
...
[   36.622914] # # # overflow_calculation_test: s64: 21 arithmetic tests
[   36.624020] # # ok 1 - overflow_calculation_test
...
[   36.731096] # # # overflow_shift_test: ok: (s64)(0 << 63) == 0
[   36.731840] # # ok 2 - overflow_shift_test
...
[   36.750294] kunit_try_catch: vmalloc: allocation failure: 18446744073709551615 bytes, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
...
[   36.805350] # # # overflow_allocation_test: devm_kzalloc detected saturation
[   36.807763] # # ok 3 - overflow_allocation_test
[   36.807763] # # # overflow: PASS
[   36.807765] # ok 1 - overflow
[   36.807767] # # kunit: PASS

But I assume there are threads on this that I've not read... :)


Now, speaking to actual behavior, I love it. :) All the tests are there
(and then some -- noted below).

> diff --git a/lib/Makefile b/lib/Makefile
> index 685aee60de1d..a3290adc0019 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -309,3 +309,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>
>  # KUnit tests
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> +obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += kunit_overflow_test.o
> diff --git a/lib/kunit_overflow_test.c b/lib/kunit_overflow_test.c
> new file mode 100644
> index 000000000000..c3eb8f0d3d50
> --- /dev/null
> +++ b/lib/kunit_overflow_test.c

A lot of this file is unchanged, so I would suggest doing this as a
"git mv lib/test_overflow.c lib/kunit_overflow.c" and then put the
changes into the file. Then it should be easier to track git history, etc.

Without this, it's a lot harder to review this patch since I'm just
looking at a 590 new lines. ;) Really, it's a diff (which I'll paste
here for the code review...)

> --- a/lib/test_overflow.c	2020-06-12 14:07:11.161999209 -0700
> +++ b/lib/kunit_overflow_test.c	2020-06-12 14:07:27.950183116 -0700
> @@ -1,17 +1,18 @@
> -// SPDX-License-Identifier: GPL-2.0 OR MIT
> +// SPDX-License-Identifier: GPL-2.0

Please don't change the license.

> +/*
> + *  This code is the conversion of the overflow test in runtime to KUnit tests.
> + */
> +

This can be left off.

>  /*
>   * Test cases for arithmetic overflow checks.
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <kunit/test.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> -#include <linux/kernel.h>
>  #include <linux/mm.h>
> -#include <linux/module.h>
>  #include <linux/overflow.h>
> -#include <linux/slab.h>
> -#include <linux/types.h>
>  #include <linux/vmalloc.h>
>  
>  #define DEFINE_TEST_ARRAY(t)			\
> @@ -19,7 +20,7 @@
>  		t a, b;				\
>  		t sum, diff, prod;		\
>  		bool s_of, d_of, p_of;		\
> -	} t ## _tests[] __initconst
> +	} t ## _tests[]

Why drop the __initconst?

>  DEFINE_TEST_ARRAY(u8) = {
>  	{0, 0, 0, 0, 0, false, false, false},
> @@ -44,6 +45,7 @@
>  	{128, 128, 0, 0, 0, true, false, true},
>  	{123, 234, 101, 145, 110, true, true, true},
>  };
> +

Style nit: I'd like to avoid the blank lines here.

>  DEFINE_TEST_ARRAY(u16) = {
>  	{0, 0, 0, 0, 0, false, false, false},
>  	{1, 1, 2, 0, 1, false, false, false},
> @@ -66,6 +68,7 @@
>  	{123, 234, 357, 65425, 28782, false, true, false},
>  	{1234, 2345, 3579, 64425, 10146, false, true, true},
>  };
> +
>  DEFINE_TEST_ARRAY(u32) = {
>  	{0, 0, 0, 0, 0, false, false, false},
>  	{1, 1, 2, 0, 1, false, false, false},
> @@ -163,6 +166,7 @@
>  	{S16_MIN, S16_MIN, 0, 0, 0, true, false, true},
>  	{S16_MAX, S16_MAX, -2, 0, 1, true, false, true},
>  };
> +
>  DEFINE_TEST_ARRAY(s32) = {
>  	{0, 0, 0, 0, 0, false, false, false},
>  
> @@ -186,6 +190,7 @@
>  	{S32_MIN, S32_MIN, 0, 0, 0, true, false, true},
>  	{S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
>  };
> +
>  DEFINE_TEST_ARRAY(s64) = {
>  	{0, 0, 0, 0, 0, false, false, false},
>  
> @@ -215,254 +220,243 @@
>  	{0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
>  };
>  
> -#define check_one_op(t, fmt, op, sym, a, b, r, of) do {		\
> -	t _r;							\
> -	bool _of;						\
> -								\
> -	_of = check_ ## op ## _overflow(a, b, &_r);		\
> -	if (_of != of) {					\
> -		pr_warn("expected "fmt" "sym" "fmt		\
> -			" to%s overflow (type %s)\n",		\
> -			a, b, of ? "" : " not", #t);		\
> -		err = 1;					\
> -	}							\
> -	if (_r != r) {						\
> -		pr_warn("expected "fmt" "sym" "fmt" == "	\
> -			fmt", got "fmt" (type %s)\n",		\
> -			a, b, r, _r, #t);			\
> -		err = 1;					\
> -	}							\
> +#define check_one_op(test, t, fmt, op, sym, a, b, r, of) do {		\
> +	t _r;								\
> +	bool _of;							\
> +									\
> +	_of = check_ ## op ## _overflow(a, b, &_r);			\
> +	if (_of != of) {						\
> +		KUNIT_FAIL(test, "Expected "fmt" "sym" "fmt		\
> +			" to%s overflow (type %s)\n",			\
> +			a, b, of ? "" : " not", #t);			\
> +	}								\
> +	if (_r != r) {							\
> +		KUNIT_FAIL(test, "Expected "fmt" "sym" "fmt" == "	\
> +			fmt", got "fmt" (type %s)\n",			\
> +			a, b, r, _r, #t);				\
> +	}								\
>  } while (0)

The trailing \ makes this more awkward to diff, but one thing I'm not
quite seeing is why "test" needs to be added. It's not a variable in
these macros. i.e. it is used literally:

#define DEFINE_TEST_FUNC(test, t, fmt)						\
static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p)	\
{										\
        check_one_op(test, t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
...

Only callers of the do_test_*() would need to be changed. I think all of
these macros just need the pr_warn/KUNIT_FAIL changes, and the function
prototypes updated to include struct kunit *test.

>  
> -#define DEFINE_TEST_FUNC(t, fmt)					\
> -static int __init do_test_ ## t(const struct test_ ## t *p)		\
> -{							   		\
> -	int err = 0;							\
> -									\
> -	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
> -	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
> -	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
> -	check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);	\
> -	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
> -									\
> -	return err;							\
> -}									\
> -									\
> -static int __init test_ ## t ## _overflow(void) {			\
> -	int err = 0;							\
> -	unsigned i;							\
> -									\
> -	pr_info("%-3s: %zu arithmetic tests\n", #t,			\
> -		ARRAY_SIZE(t ## _tests));				\
> -	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
> -		err |= do_test_ ## t(&t ## _tests[i]);			\
> -	return err;							\
> +#define DEFINE_TEST_FUNC(test, t, fmt)						\
> +static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p)	\
> +{										\
> +	check_one_op(test, t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
> +	check_one_op(test, t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
> +	check_one_op(test, t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
> +	check_one_op(test, t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);	\
> +	check_one_op(test, t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
> +}										\

Then these all only need the prototype on the actual function changed.

> +										\
> +static void  test_ ## t ## _overflow(struct kunit *test)			\
> +{										\
> +	unsigned i;								\
> +										\
> +	kunit_warn(test, "%-3s: %zu arithmetic tests\n", #t,			\
> +		ARRAY_SIZE(t ## _tests));					\
> +	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)				\
> +		do_test_ ## t(test, &t ## _tests[i]);				\
>  }
>  
> -DEFINE_TEST_FUNC(u8, "%d");
> -DEFINE_TEST_FUNC(s8, "%d");
> -DEFINE_TEST_FUNC(u16, "%d");
> -DEFINE_TEST_FUNC(s16, "%d");
> -DEFINE_TEST_FUNC(u32, "%u");
> -DEFINE_TEST_FUNC(s32, "%d");
> +DEFINE_TEST_FUNC(test, u8, "%d");
> +DEFINE_TEST_FUNC(test, s8, "%d");
> +DEFINE_TEST_FUNC(test, u16, "%d");
> +DEFINE_TEST_FUNC(test, s16, "%d");
> +DEFINE_TEST_FUNC(test, u32, "%u");
> +DEFINE_TEST_FUNC(test, s32, "%d");
>  #if BITS_PER_LONG == 64
> -DEFINE_TEST_FUNC(u64, "%llu");
> -DEFINE_TEST_FUNC(s64, "%lld");
> +DEFINE_TEST_FUNC(test, u64, "%llu");
> +DEFINE_TEST_FUNC(test, s64, "%lld");
>  #endif

And all the actual uses of the macros can be left unchanged.

>  
> -static int __init test_overflow_calculation(void)
> +static void  overflow_calculation_test(struct kunit *test)
>  {
> -	int err = 0;
>  
> -	err |= test_u8_overflow();
> -	err |= test_s8_overflow();
> -	err |= test_u16_overflow();
> -	err |= test_s16_overflow();
> -	err |= test_u32_overflow();
> -	err |= test_s32_overflow();
> +	test_u8_overflow(test);
> +	test_s8_overflow(test);
> +	test_s8_overflow(test);

The s8 test got added twice here accidentally.

> +	test_u16_overflow(test);
> +	test_s16_overflow(test);
> +	test_u32_overflow(test);
> +	test_s32_overflow(test);
>  #if BITS_PER_LONG == 64
> -	err |= test_u64_overflow();
> -	err |= test_s64_overflow();
> +	test_u64_overflow(test);
> +	test_s64_overflow(test);
>  #endif
> -
> -	return err;
>  }

I think it might be nice to keep the "err" vars around for a final report
line (maybe per test)? (It would keep the diff churn way lower, too...)

So, yes! I like it. :) Most of my comments here have nothing to do with
specifically this patch (sorry)! But I'd love to see a v2.

Thanks for doing this! I'm glad to see more TAP output. :)

-- 
Kees Cook
