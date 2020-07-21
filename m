Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504BB22889E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGUSzo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgGUSzk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 14:55:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A61CC0619DA
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 11:55:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so2006205pje.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jul 2020 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sa4evJdXF/XDbFHEBNhlzmxlS/sWp3bcVQWe3733ZCQ=;
        b=DjUFGZd50SOCaZ4BUrg0JNH00bQgXsFWHbiQ5e6H6lfOG7+dm2UGTW5jOoXmsp4O03
         N21hvUvXR1pbVlblSlkHs4V7VW/Fn0qWg+ftu9fhLqNJTLujiAjBGW6qVKnsBqM/wcol
         pvpFQMUlI3yBy7Fhg2qPDaeLQfJ6yIG2ceMy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sa4evJdXF/XDbFHEBNhlzmxlS/sWp3bcVQWe3733ZCQ=;
        b=JZxl/9kXdSVbVsNe3HiM/bU/XjW092W5OlKdqvqHr78+PJvroPpBgcvb+BoGnhfFpi
         YRbFYG4PNzKjLaC+rW2JF/EjEqUBuBoylDTUZ5Eyo8RyP3hN2hVo/rRW4XIBMm50yNxp
         f4liYJeLQu9+VKWS1AGpT2zUxK42qNv+nNRfaPZRoFn1WZLyJDHKQOkAg/kuJLQpi3Jt
         GcH44AzdQXnrUIV0BVjuAKwTS3+pwk1I/lX5gM9+dV348/6ze5j8hNsHo6UcFpuANHdC
         O4/m9v5fjeaaf+oWbDY0XvJjLX32jv7PRef9WPi+wHJO/nP7FFLf7lbRhm9HSDEPkuDT
         sLeA==
X-Gm-Message-State: AOAM531+rPOZjcvY+dKS1tnGTsEFneDjjx3707GUFUEPKAivoMcknT9U
        FxvcQXJOv5eOBbWGauukb3ECvQ==
X-Google-Smtp-Source: ABdhPJxRpnm3k8+zl/g0bTQFkDAedEqwYWR+brTwFDhLXTh4mxvfGZnX0l8rT1w+6V0skUokb/DlgQ==
X-Received: by 2002:a17:90b:30d0:: with SMTP id hi16mr6437503pjb.65.1595357739861;
        Tue, 21 Jul 2020 11:55:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i128sm21193742pfe.74.2020.07.21.11.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:55:39 -0700 (PDT)
Date:   Tue, 21 Jul 2020 11:55:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: overflow_kunit: add KUnit test conversion of
 check_*_overflow
Message-ID: <202007211150.73CF60A9@keescook>
References: <20200720224418.200495-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720224418.200495-1-vitor@massaru.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 20, 2020 at 07:44:18PM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the runtime tests of check_*_overflow functions,
> from `lib/test_overflow.c`to KUnit tests.
> 
> The log similar to the one seen in dmesg running test_overflow.c can be
> seen in `test.log`.
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Tested-by: David Gow <davidgow@google.com>
> ---
> v2:
>   * moved lib/test_overflow.c to lib/overflow-test.c;
>     * back to original license;
>     * fixed style code;
>     * keeps __initconst and added _refdata on overflow_test_cases variable;
>     * keeps macros intact making asserts with the variable err;
>     * removed duplicate test_s8_overflow();
>   * fixed typos on commit message;
> 
> v3:
>   * changed filename to overflow_kunit.c;
>   * replace _refdata by _inidata;

It looks like this still needs to be _refdata (says the test bot)

> -static int __init test_ ## t ## _overflow(void) {			\
> +static int __init test_ ## t ## _overflow(struct kunit *test) {	\

style nit: it seems like "test" isn't a great variable name. Why not
make this "kunit" or "context" or something more specific?

>  	int err = 0;							\
>  	unsigned i;							\
>  									\
> @@ -256,6 +253,7 @@ static int __init test_ ## t ## _overflow(void) {			\
>  		ARRAY_SIZE(t ## _tests));				\
>  	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
>  		err |= do_test_ ## t(&t ## _tests[i]);			\
> +	KUNIT_EXPECT_FALSE(test, err);					\
>  	return err;							\
>  }

Also, if the caller is being made "void", probably this can be made void
too?

And if that's happening, maybe just plumb the EXPECT into the
do_test_... call instead?

> 
> @@ -270,25 +268,25 @@ DEFINE_TEST_FUNC(u64, "%llu");
>  DEFINE_TEST_FUNC(s64, "%lld");
>  #endif
> 
> -static int __init test_overflow_calculation(void)
> +static void __init overflow_calculation_test(struct kunit *test)
>  {
>  	int err = 0;
> 
> -	err |= test_u8_overflow();
> -	err |= test_s8_overflow();
> -	err |= test_u16_overflow();
> -	err |= test_s16_overflow();
> -	err |= test_u32_overflow();
> -	err |= test_s32_overflow();
> +	err |= test_u8_overflow(test);
> +	err |= test_s8_overflow(test);
> +	err |= test_u16_overflow(test);
> +	err |= test_s16_overflow(test);
> +	err |= test_u32_overflow(test);
> +	err |= test_s32_overflow(test);
>  #if BITS_PER_LONG == 64
> -	err |= test_u64_overflow();
> -	err |= test_s64_overflow();
> +	err |= test_u64_overflow(test);
> +	err |= test_s64_overflow(test);
>  #endif
> 
> -	return err;
> +	KUNIT_EXPECT_FALSE(test, err);

This seems redundant (the tests were already tested)?

>  }
> 
> -static int __init test_overflow_shift(void)
> +static void __init overflow_shift_test(struct kunit *test)
>  {
>  	int err = 0;
> 
> @@ -313,9 +311,9 @@ static int __init test_overflow_shift(void)
>  			pr_warn("got %llu\n", (u64)__d);		\
>  		__failed = 1;						\
>  	}								\
> -	if (!__failed)							\
> -		pr_info("ok: (%s)(%s << %s) == %s\n", #t, #a, #s,	\
> -			of ? "overflow" : #expect);			\
> +	KUNIT_EXPECT_FALSE_MSG(test, __failed,				\
> +			       "ok: (%s)(%s << %s) == %s\n", #t, #a, #s,\
> +			       of ? "overflow" : #expect);		\
>  	__failed;							\
>  })
> 
> @@ -479,7 +477,7 @@ static int __init test_overflow_shift(void)
>  	err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
>  	err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
> 
> -	return err;
> +	KUNIT_EXPECT_FALSE(test, err);
>  }
> 
>  /*
> @@ -499,7 +497,7 @@ static int __init test_overflow_shift(void)
>  #define TEST_SIZE		(5 * 4096)
> 
>  #define DEFINE_TEST_ALLOC(func, free_func, want_arg, want_gfp, want_node)\
> -static int __init test_ ## func (void *arg)				\
> +static int __init test_ ## func (struct kunit *test, void *arg)		\
>  {									\
>  	volatile size_t a = TEST_SIZE;					\
>  	volatile size_t b = (SIZE_MAX / TEST_SIZE) + 1;			\
> @@ -507,19 +505,15 @@ static int __init test_ ## func (void *arg)				\
>  									\
>  	/* Tiny allocation test. */					\
>  	ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg, 1);\
> -	if (!ptr) {							\
> -		pr_warn(#func " failed regular allocation?!\n");	\
> -		return 1;						\
> -	}								\
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,			\
> +			#func " failed regular allocation?!\n");	\
>  	free ## want_arg (free_func, arg, ptr);				\
>  									\
>  	/* Wrapped allocation test. */					\
>  	ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,	\
>  							  a * b);	\
> -	if (!ptr) {							\
> -		pr_warn(#func " unexpectedly failed bad wrapping?!\n");	\
> -		return 1;						\
> -	}								\
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr,			\
> +			#func " unexpectedly failed bad wrapping?!\n"); \
>  	free ## want_arg (free_func, arg, ptr);				\
>  									\
>  	/* Saturated allocation test. */				\
> @@ -555,7 +549,7 @@ DEFINE_TEST_ALLOC(kvzalloc_node, kvfree,     0, 1, 1);
>  DEFINE_TEST_ALLOC(devm_kmalloc,  devm_kfree, 1, 1, 0);
>  DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
> 
> -static int __init test_overflow_allocation(void)
> +static void __init overflow_allocation_test(struct kunit *test)
>  {
>  	const char device_name[] = "overflow-test";
>  	struct device *dev;
> @@ -563,52 +557,40 @@ static int __init test_overflow_allocation(void)
> 
>  	/* Create dummy device for devm_kmalloc()-family tests. */
>  	dev = root_device_register(device_name);
> -	if (IS_ERR(dev)) {
> -		pr_warn("Cannot register test device\n");
> -		return 1;
> -	}
> -
> -	err |= test_kmalloc(NULL);
> -	err |= test_kmalloc_node(NULL);
> -	err |= test_kzalloc(NULL);
> -	err |= test_kzalloc_node(NULL);
> -	err |= test_kvmalloc(NULL);
> -	err |= test_kvmalloc_node(NULL);
> -	err |= test_kvzalloc(NULL);
> -	err |= test_kvzalloc_node(NULL);
> -	err |= test_vmalloc(NULL);
> -	err |= test_vmalloc_node(NULL);
> -	err |= test_vzalloc(NULL);
> -	err |= test_vzalloc_node(NULL);
> -	err |= test_devm_kmalloc(dev);
> -	err |= test_devm_kzalloc(dev);
> +	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev), "Cannot register test device\n");
> +
> +	err |= test_kmalloc(test, NULL);
> +	err |= test_kmalloc_node(test, NULL);
> +	err |= test_kzalloc(test, NULL);
> +	err |= test_kzalloc_node(test, NULL);
> +	err |= test_kvmalloc(test, NULL);
> +	err |= test_kvmalloc_node(test, NULL);
> +	err |= test_kvzalloc(test, NULL);
> +	err |= test_kvzalloc_node(test, NULL);
> +	err |= test_vmalloc(test, NULL);
> +	err |= test_vmalloc_node(test, NULL);
> +	err |= test_vzalloc(test, NULL);
> +	err |= test_vzalloc_node(test, NULL);
> +	err |= test_devm_kmalloc(test, dev);
> +	err |= test_devm_kzalloc(test, dev);
> 
>  	device_unregister(dev);
> 
> -	return err;
> +	KUNIT_EXPECT_FALSE(test, err);
>  }
> 
> -static int __init test_module_init(void)
> -{
> -	int err = 0;
> -
> -	err |= test_overflow_calculation();
> -	err |= test_overflow_shift();
> -	err |= test_overflow_allocation();
> -
> -	if (err) {
> -		pr_warn("FAIL!\n");
> -		err = -EINVAL;
> -	} else {
> -		pr_info("all tests passed\n");
> -	}

The reason for older feedback on leaving "err" as it was, was to make
sure it was easy for a human to see if everything passed or not. If
KUnit provides a summary of all the tests at the end, then I don't need
to preserve that here (in which case "err" can go away). However, if
that summary does not exist for KUnit yet, then I'd like to keep the
summary that is being removed here.

> +static struct kunit_case __initdata overflow_test_cases[] = {
> +	KUNIT_CASE(overflow_calculation_test),
> +	KUNIT_CASE(overflow_shift_test),
> +	KUNIT_CASE(overflow_allocation_test),
> +	{}
> +};
> 
> -	return err;
> -}
> +static struct kunit_suite __initdata overflow_test_suite = {
> +	.name = "overflow",
> +	.test_cases = overflow_test_cases,
> +};
> 
> -static void __exit test_module_exit(void)
> -{ }
> +kunit_test_suites(&overflow_test_suite);
> 
> -module_init(test_module_init);
> -module_exit(test_module_exit);
>  MODULE_LICENSE("Dual MIT/GPL");
> 
> base-commit: c63d2dd7e134ebddce4745c51f9572b3f0d92b26
> --
> 2.26.2
> 

-- 
Kees Cook
