Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73A51F9D75
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgFOQav (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgFOQav (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 12:30:51 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B24C061A0E
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 09:30:51 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r16so8037538qvm.6
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=T8XFqDYnmxkpwPdlTRMyXPHAi5pNbZIIDoFByY1jdiM=;
        b=rkF7isWpOt0rAgHnmkAyQXznO3ekA5SFwRBS/Vn7y2AOUTR8wIGwo0MmG60/2vy5nx
         mKMLDML3lWQALNieyXml2ZDhObyKbV2rE3D/ySSskQPKm25PF0L1l6qPTJaVwN/Tvvp3
         inex0ckVaS1JfrOcU0sf644L42RZmAQ+wCqGr74uKzdvzJz/urBKFCPKNUJk/V6RFm5A
         YmAVLWi95644wXywwELtHc792uwjJeUsx0tmGq9zs1XDHQGstSnIsjDmUHMOWQmr3i2x
         sWCUW1V3tNqBEPa9Q2zMgc/0gFICWc2sRLcImEwZpqtzaR6xhDZiV4DQmS7dwSlGAFGH
         NlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=T8XFqDYnmxkpwPdlTRMyXPHAi5pNbZIIDoFByY1jdiM=;
        b=qOirKbQj02FQR5OUqVMR0/xipgnBVi229HcDhJcl7AHuYyJY/jumA4Qvq/qmfU/XKI
         A455UAKGuzI5XyWfZXo48RTL6+5UXtkrWSyEm6MWlttKxgmeJ1kkCMLhvJcJo/wA1uMg
         gLN1E4yyQTmiOssx7rqfZFP2W1h9QjU9rn6QTXwg6mzhh3SuWNI2wSw/VsmKIZbyfA7W
         uozp5yW7g4P3SHGAg3OD4w8H6KxV1KyrcWER42kTahaE29VewlBk7RYn4HTTZJ1GQEMl
         QYlW6rnDbXw/VXoz7j0n7nHV9AklOuts4BZEwSc70p4ELDjCwpspYq+pu7C9+HwRnuCz
         t0yg==
X-Gm-Message-State: AOAM532LIsPfhqyBn4UJK46b0knWEoa0impiChve4yYNzwfKmxBJb9gn
        nSEd7+FdpKxVFiI+2vsWLbNg2w==
X-Google-Smtp-Source: ABdhPJzgHoFg4aOYjgYSeonvCC1doXaRe6Xth+QWB9XCoDwjr97ASXbsfdVKMAoNPZ218N8mb3lqiQ==
X-Received: by 2002:a0c:910c:: with SMTP id q12mr24831589qvq.22.1592238649906;
        Mon, 15 Jun 2020 09:30:49 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id r37sm12717454qtk.34.2020.06.15.09.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:30:47 -0700 (PDT)
Message-ID: <0c9d09065dca0b71466600e68b64142402a98d24.camel@massaru.org>
Subject: Re: [PATCH] lib: kunit_test_overflow: add KUnit test of
 check_*_overflow functions
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kunit-dev@googlegroups.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux@rasmusvillemoes.dk
Date:   Mon, 15 Jun 2020 13:30:42 -0300
In-Reply-To: <202006121403.CF8D57C@keescook>
References: <20200611215501.213058-1-vitor@massaru.org>
         <202006121403.CF8D57C@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2020-06-12 at 15:36 -0700, Kees Cook wrote:
> On Thu, Jun 11, 2020 at 06:55:01PM -0300, Vitor Massaru Iha wrote:
> > This adds the convertion of the runtime tests of check_*_overflow
> > fuctions,
> > from `lib/test_overflow.c`to KUnit tests.
> > 
> > The log similar to the one seen in dmesg running test_overflow can
> > be
> > seen in `test.log`.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  lib/Kconfig.debug         |  17 ++
> >  lib/Makefile              |   1 +
> >  lib/kunit_overflow_test.c | 590
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 608 insertions(+)
> >  create mode 100644 lib/kunit_overflow_test.c
> 
> What tree is this based on? I can't apply it to v5.7, linux-next, nor
> Linus's latest. I've fixed it up to apply to linux-next for now. :)
> 
> Looking at linux-next, though, I am reminded of my agony over naming:
> 
> obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += kunit_overflow_test.o
> 
> *-test
> test_*
> *_test
> 
> This has to get fixed now, and the naming convention needs to be
> documented. For old tests, the preferred naming was test_*. For
> kunit, I
> think it should be kunit_* (and no trailing _test; that's redundant).
> 
> For for this bikeshed, I think it should be kunit_overflow.c
> 
> For the CONFIG name, it seems to be suggested in docs to be
> *_KUNIT_TEST:
> 
> ...
> menuconfig). From there, you can enable any KUnit tests you want:
> they usually
> have config options ending in ``_KUNIT_TEST``.
> ...
> 
> I think much stronger language needs to be added to "Writing your
> first
> test" (which actually recommends the wrong thing: "config
> MISC_EXAMPLE_TEST"). And then doesn't specify a module file name,
> though
> it hints at one:
> 
> ...
>         obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
> ...
> 
> So, please, let's get this documented: we really really need a single
> naming convention for these.
> 
> For Kconfig in the tree, I see:
> 
> drivers/base/Kconfig:config PM_QOS_KUNIT_TEST
> drivers/base/test/Kconfig:config KUNIT_DRIVER_PE_TEST
> fs/ext4/Kconfig:config EXT4_KUNIT_TESTS
> lib/Kconfig.debug:config SYSCTL_KUNIT_TEST
> lib/Kconfig.debug:config OVERFLOW_KUNIT_TEST
> lib/Kconfig.debug:config LIST_KUNIT_TEST
> lib/Kconfig.debug:config LINEAR_RANGES_TEST
> lib/kunit/Kconfig:menuconfig KUNIT
> lib/kunit/Kconfig:config KUNIT_DEBUGFS
> lib/kunit/Kconfig:config KUNIT_TEST
> lib/kunit/Kconfig:config KUNIT_EXAMPLE_TEST
> lib/kunit/Kconfig:config KUNIT_ALL_TESTS
> 
> Which is:
> 
> *_KUNIT_TEST
> KUNIT_*_TEST
> KUNIT_*_TESTS
> *_TEST
> 
> Nooooo. ;)
> 
> If it should all be *_KUNIT_TEST, let's do that. I think just *_KUNIT
> would be sufficient (again, adding the word "test" to "kunit" is
> redundant). And it absolutely should not be a prefix, otherwise it'll
> get sorted away from the thing it's named after. So my preference is
> here would be CONFIG_OVERFLOW_KUNIT. (Yes the old convention was
> CONFIG_TEST_*, but those things tended to be regression tests, not
> unit
> tests.)
> 
> Please please, can we fix this before we add anything more?

Sure, I'll rewrite with _KUNIT_TEST, as David Gow suggested in the next
emails.

> 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 1f4ab7a2bdee..72fcfe1f24a4 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2075,6 +2075,23 @@ config SYSCTL_KUNIT_TEST
> > 
> >  	  If unsure, say N.
> > 
> > +config OVERFLOW_KUNIT_TEST
> > +	tristate "KUnit test for overflow" if !KUNIT_ALL_TESTS
> > +	depends on KUNIT
> > +	default KUNIT_ALL_TESTS
> > +	help
> > +	  This builds the overflow KUnit tests.
> > +
> > +	  KUnit tests run during boot and output the results to the
> > debug log
> > +	  in TAP format (http://testanything.org/). Only useful for
> > kernel devs
> > +	  running KUnit test harness and are not for inclusion into a
> > production
> > +	  build.
> > +
> > +	  For more information on KUnit and unit tests in general
> > please refer
> > +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +	  If unsure, say N.
> > +
> >  config LIST_KUNIT_TEST
> >  	tristate "KUnit Test for Kernel Linked-list structures" if
> > !KUNIT_ALL_TESTS
> >  	depends on KUNIT
> 
> Regarding output:
> 
> [   36.611358] TAP version 14
> [   36.611953]     # Subtest: overflow
> [   36.611954]     1..3
> ...
> [   36.622914]     # overflow_calculation_test: s64: 21 arithmetic
> tests
> [   36.624020]     ok 1 - overflow_calculation_test
> ...
> [   36.731096]     # overflow_shift_test: ok: (s64)(0 << 63) == 0
> [   36.731840]     ok 2 - overflow_shift_test
> ...
> [   36.750294] kunit_try_catch: vmalloc: allocation failure:
> 18446744073709551615 bytes, mode:0xcc0(GFP_KERNEL),
> nodemask=(null),cpuset=/,mems_allowed=0
> ...
> [   36.805350]     # overflow_allocation_test: devm_kzalloc detected
> saturation
> [   36.807763]     ok 3 - overflow_allocation_test
> [   36.807765] ok 1 - overflow
> 
> A few things here....
> 
> - On the outer test report, there is no "plan" line (I was expecting
>   "1..1"). Technically it's optional, but it seems like the
> information
>   is available. :)
> 
> - The subtest should have its own "TAP version 14" line, and it
> should
>   be using the diagnostic line prefix for the top-level test (this is
>   what kselftest is doing).
> 
> - There is no way to distinguish top-level TAP output from kernel log
>   lines. I think we should stick with the existing marker, which is
>   "# ", so that kernel output has no way to be interpreted as TAP
>   details -- unless it intentionally starts adding "#"s. ;)
> 
> - There is no summary line (to help humans). For example, the
> kselftest
>   API produces a final pass/fail report.
> 
> Taken together, I was expecting the output to be:
> 
> [   36.611358] # TAP version 14
> [   36.611953] # 1..1
> [   36.611958] # # TAP version 14
> [   36.611954] # # 1..3
> ...
> [   36.622914] # # # overflow_calculation_test: s64: 21 arithmetic
> tests
> [   36.624020] # # ok 1 - overflow_calculation_test
> ...
> [   36.731096] # # # overflow_shift_test: ok: (s64)(0 << 63) == 0
> [   36.731840] # # ok 2 - overflow_shift_test
> ...
> [   36.750294] kunit_try_catch: vmalloc: allocation failure:
> 18446744073709551615 bytes, mode:0xcc0(GFP_KERNEL),
> nodemask=(null),cpuset=/,mems_allowed=0
> ...
> [   36.805350] # # # overflow_allocation_test: devm_kzalloc detected
> saturation
> [   36.807763] # # ok 3 - overflow_allocation_test
> [   36.807763] # # # overflow: PASS
> [   36.807765] # ok 1 - overflow
> [   36.807767] # # kunit: PASS
> 
> But I assume there are threads on this that I've not read... :)
> 
> 
> Now, speaking to actual behavior, I love it. :) All the tests are
> there
> (and then some -- noted below).
> 
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 685aee60de1d..a3290adc0019 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -309,3 +309,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
> > 
> >  # KUnit tests
> >  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> > +obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += kunit_overflow_test.o
> > diff --git a/lib/kunit_overflow_test.c b/lib/kunit_overflow_test.c
> > new file mode 100644
> > index 000000000000..c3eb8f0d3d50
> > --- /dev/null
> > +++ b/lib/kunit_overflow_test.c
> 
> A lot of this file is unchanged, so I would suggest doing this as a
> "git mv lib/test_overflow.c lib/kunit_overflow.c" and then put the
> changes into the file. Then it should be easier to track git history,
> etc.
> 
> Without this, it's a lot harder to review this patch since I'm just
> looking at a 590 new lines. ;) Really, it's a diff (which I'll paste
> here for the code review...)
> 

Sure, I'll do it. I didn't know if the runtime tests were going to
stay.

> > --- a/lib/test_overflow.c	2020-06-12 14:07:11.161999209 -0700
> > +++ b/lib/kunit_overflow_test.c	2020-06-12 14:07:27.950183116
> > -0700
> > @@ -1,17 +1,18 @@
> > -// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Please don't change the license.

Sure I'll fix it.

> 
> > +/*
> > + *  This code is the conversion of the overflow test in runtime to
> > KUnit tests.
> > + */
> > +
> 
> This can be left off.

Sure I'll fix it.
> >  /*
> >   * Test cases for arithmetic overflow checks.
> >   */
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> > +#include <kunit/test.h>
> >  #include <linux/device.h>
> >  #include <linux/init.h>
> > -#include <linux/kernel.h>
> >  #include <linux/mm.h>
> > -#include <linux/module.h>
> >  #include <linux/overflow.h>
> > -#include <linux/slab.h>
> > -#include <linux/types.h>
> >  #include <linux/vmalloc.h>
> >  
> >  #define DEFINE_TEST_ARRAY(t)			\
> > @@ -19,7 +20,7 @@
> >  		t a, b;				\
> >  		t sum, diff, prod;		\
> >  		bool s_of, d_of, p_of;		\
> > -	} t ## _tests[] __initconst
> > +	} t ## _tests[]
> 
> Why drop the __initconst?

I removed __initconst because of these warnings below, as it is used
for the kernel during the module initialization, and I do not use the
module initialization in this tests. Does this have any side effects in
these tests?

WARNING: modpost: vmlinux.o(.text.unlikely+0x131b7): Section mismatch
in reference from the function test_s8_overflow() to the variable
.init.rodata:s8_tests
The function test_s8_overflow() references
the variable __initconst s8_tests.
This is often because test_s8_overflow lacks a __initconst 
annotation or the annotation of s8_tests is wrong.


> >  DEFINE_TEST_ARRAY(u8) = {
> >  	{0, 0, 0, 0, 0, false, false, false},
> > @@ -44,6 +45,7 @@
> >  	{128, 128, 0, 0, 0, true, false, true},
> >  	{123, 234, 101, 145, 110, true, true, true},
> >  };
> > +
> 
> Style nit: I'd like to avoid the blank lines here.
> 
> >  DEFINE_TEST_ARRAY(u16) = {
> >  	{0, 0, 0, 0, 0, false, false, false},
> >  	{1, 1, 2, 0, 1, false, false, false},
> > @@ -66,6 +68,7 @@
> >  	{123, 234, 357, 65425, 28782, false, true, false},
> >  	{1234, 2345, 3579, 64425, 10146, false, true, true},
> >  };
> > +
> >  DEFINE_TEST_ARRAY(u32) = {
> >  	{0, 0, 0, 0, 0, false, false, false},
> >  	{1, 1, 2, 0, 1, false, false, false},
> > @@ -163,6 +166,7 @@
> >  	{S16_MIN, S16_MIN, 0, 0, 0, true, false, true},
> >  	{S16_MAX, S16_MAX, -2, 0, 1, true, false, true},
> >  };
> > +
> >  DEFINE_TEST_ARRAY(s32) = {
> >  	{0, 0, 0, 0, 0, false, false, false},
> >  
> > @@ -186,6 +190,7 @@
> >  	{S32_MIN, S32_MIN, 0, 0, 0, true, false, true},
> >  	{S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
> >  };
> > +
> >  DEFINE_TEST_ARRAY(s64) = {
> >  	{0, 0, 0, 0, 0, false, false, false},
> >  
> > @@ -215,254 +220,243 @@
> >  	{0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
> >  };
> >  
> > -#define check_one_op(t, fmt, op, sym, a, b, r, of) do {		
> > \
> > -	t _r;							\
> > -	bool _of;						\
> > -								\
> > -	_of = check_ ## op ## _overflow(a, b, &_r);		\
> > -	if (_of != of) {					\
> > -		pr_warn("expected "fmt" "sym" "fmt		\
> > -			" to%s overflow (type %s)\n",		\
> > -			a, b, of ? "" : " not", #t);		\
> > -		err = 1;					\
> > -	}							\
> > -	if (_r != r) {						\
> > -		pr_warn("expected "fmt" "sym" "fmt" == "	\
> > -			fmt", got "fmt" (type %s)\n",		\
> > -			a, b, r, _r, #t);			\
> > -		err = 1;					\
> > -	}							\
> > +#define check_one_op(test, t, fmt, op, sym, a, b, r, of) do {	
> > 	\
> > +	t _r;								
> > \
> > +	bool _of;							\
> > +									
> > \
> > +	_of = check_ ## op ## _overflow(a, b, &_r);			\
> > +	if (_of != of) {						\
> > +		KUNIT_FAIL(test, "Expected "fmt" "sym" "fmt		\
> > +			" to%s overflow (type %s)\n",			
> > \
> > +			a, b, of ? "" : " not", #t);			
> > \
> > +	}								\
> > +	if (_r != r) {							
> > \
> > +		KUNIT_FAIL(test, "Expected "fmt" "sym" "fmt" == "	\
> > +			fmt", got "fmt" (type %s)\n",			
> > \
> > +			a, b, r, _r, #t);				\
> > +	}								\
> >  } while (0)
> 
> The trailing \ makes this more awkward to diff, but one thing I'm not
> quite seeing is why "test" needs to be added. It's not a variable in
> these macros. i.e. it is used literally:
> 
> #define DEFINE_TEST_FUNC(test, t, fmt)				
> 		\
> static void do_test_ ## t(struct kunit *test, const struct test_ ## t
> *p)	\
> {									
> 	\
>         check_one_op(test, t, fmt, add, "+", p->a, p->b, p->sum, p-
> >s_of);	\
> ...
> 
> Only callers of the do_test_*() would need to be changed. I think all
> of
> these macros just need the pr_warn/KUNIT_FAIL changes, and the
> function
> prototypes updated to include struct kunit *test.
> 
> >  
> > -#define DEFINE_TEST_FUNC(t, fmt)					
> > \
> > -static int __init do_test_ ## t(const struct test_ ## t *p)	
> > 	\
> > -{							   		\
> > -	int err = 0;							
> > \
> > -									
> > \
> > -	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	
> > \
> > -	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	
> > \
> > -	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	
> > \
> > -	check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);	
> > \
> > -	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	
> > \
> > -									
> > \
> > -	return err;							\
> > -}									
> > \
> > -									
> > \
> > -static int __init test_ ## t ## _overflow(void) {			
> > \
> > -	int err = 0;							
> > \
> > -	unsigned i;							\
> > -									
> > \
> > -	pr_info("%-3s: %zu arithmetic tests\n", #t,			\
> > -		ARRAY_SIZE(t ## _tests));				\
> > -	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			
> > \
> > -		err |= do_test_ ## t(&t ## _tests[i]);			
> > \
> > -	return err;							\
> > +#define DEFINE_TEST_FUNC(test, t, fmt)				
> > 		\
> > +static void do_test_ ## t(struct kunit *test, const struct test_
> > ## t *p)	\
> > +{									
> > 	\
> > +	check_one_op(test, t, fmt, add, "+", p->a, p->b, p->sum, p-
> > >s_of);	\
> > +	check_one_op(test, t, fmt, add, "+", p->b, p->a, p->sum, p-
> > >s_of);	\
> > +	check_one_op(test, t, fmt, sub, "-", p->a, p->b, p->diff, p-
> > >d_of);	\
> > +	check_one_op(test, t, fmt, mul, "*", p->a, p->b, p->prod, p-
> > >p_of);	\
> > +	check_one_op(test, t, fmt, mul, "*", p->b, p->a, p->prod, p-
> > >p_of);	\
> > +}									
> > 	\
> 
> Then these all only need the prototype on the actual function
> changed.
> 
> > +									
> > 	\
> > +static void  test_ ## t ## _overflow(struct kunit *test)		
> > 	\
> > +{									
> > 	\
> > +	unsigned i;								
> > \
> > +									
> > 	\
> > +	kunit_warn(test, "%-3s: %zu arithmetic tests\n", #t,		
> > 	\
> > +		ARRAY_SIZE(t ## _tests));					
> > \
> > +	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			
> > 	\
> > +		do_test_ ## t(test, &t ## _tests[i]);			
> > 	\
> >  }
> >  
> > -DEFINE_TEST_FUNC(u8, "%d");
> > -DEFINE_TEST_FUNC(s8, "%d");
> > -DEFINE_TEST_FUNC(u16, "%d");
> > -DEFINE_TEST_FUNC(s16, "%d");
> > -DEFINE_TEST_FUNC(u32, "%u");
> > -DEFINE_TEST_FUNC(s32, "%d");
> > +DEFINE_TEST_FUNC(test, u8, "%d");
> > +DEFINE_TEST_FUNC(test, s8, "%d");
> > +DEFINE_TEST_FUNC(test, u16, "%d");
> > +DEFINE_TEST_FUNC(test, s16, "%d");
> > +DEFINE_TEST_FUNC(test, u32, "%u");
> > +DEFINE_TEST_FUNC(test, s32, "%d");
> >  #if BITS_PER_LONG == 64
> > -DEFINE_TEST_FUNC(u64, "%llu");
> > -DEFINE_TEST_FUNC(s64, "%lld");
> > +DEFINE_TEST_FUNC(test, u64, "%llu");
> > +DEFINE_TEST_FUNC(test, s64, "%lld");
> >  #endif
> 
> And all the actual uses of the macros can be left unchanged.
> 
> >  
> > -static int __init test_overflow_calculation(void)
> > +static void  overflow_calculation_test(struct kunit *test)
> >  {
> > -	int err = 0;
> >  
> > -	err |= test_u8_overflow();
> > -	err |= test_s8_overflow();
> > -	err |= test_u16_overflow();
> > -	err |= test_s16_overflow();
> > -	err |= test_u32_overflow();
> > -	err |= test_s32_overflow();
> > +	test_u8_overflow(test);
> > +	test_s8_overflow(test);
> > +	test_s8_overflow(test);
> 
> The s8 test got added twice here accidentally.
> 
> > +	test_u16_overflow(test);
> > +	test_s16_overflow(test);
> > +	test_u32_overflow(test);
> > +	test_s32_overflow(test);
> >  #if BITS_PER_LONG == 64
> > -	err |= test_u64_overflow();
> > -	err |= test_s64_overflow();
> > +	test_u64_overflow(test);
> > +	test_s64_overflow(test);
> >  #endif
> > -
> > -	return err;
> >  }
> 
> I think it might be nice to keep the "err" vars around for a final
> report
> line (maybe per test)? (It would keep the diff churn way lower,
> too...)
> 

I will correct these other suggestions.

> So, yes! I like it. :) Most of my comments here have nothing to do
> with
> specifically this patch (sorry)! But I'd love to see a v2.
> 
> Thanks for doing this! I'm glad to see more TAP output. :)
> 

Thanks Kees, I'm learning a lot from you, and as I said privately with
Brendan, I've never seen so much macro in a code. I learned a lot from
it.



