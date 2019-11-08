Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6D5F3D7A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 02:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfKHBky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 20:40:54 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37719 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKHBky (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 20:40:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so3647298pfn.4
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 17:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=omgkosYhpSIUhGpgr0G9r775xrjXzdbgkWmbfALZqCs=;
        b=TVt3qbZC+XpXTbvOnxgCdM3ViXxajuGgVp8xhwjyqQhEpKwNpOMn5ffo5IkEwnKg89
         lZD4e2x0LiBOkjHP9XrKw+gEm2heySILnXJVvxxXEchs/vnpugsWvFIXEfzp50qlx0/e
         1og4xtxP/vwguP3TpT3FO0Fys5FhIUOCDhBtlz6M4ptwXqNvUrl1PujidH82xRCmCo+B
         cfD23QlZariy2lUl9+Quymwv/NbOixc9gHKGyU5SnePr24C5TJBG+tDKS37okyydqvWk
         0rgLHgxDZ8VFf90XdP+CznWH5EwVCQWhhgc6mikOvG45JZsN0ltsnm/ktpJn1EB1Hey9
         6lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omgkosYhpSIUhGpgr0G9r775xrjXzdbgkWmbfALZqCs=;
        b=CWGn3jaR5fI1Hd2CRqP7lD8Q2mwsfB0uUJelGYBxyB1AlPj1bxapWodZ2vXT7AASL1
         /sa1k8+5x/1rfiVLSGb1vOsWwddwtWh/iRWF3TsT5DB66e1+rdv6ocAS1c+rB12NDBqG
         1n3d7KCr/gjIhi9sZo64AiYeoqv1UxUvQEpJADGckdMX2Hm+jp2akqCO/+GTrnwiQ0m8
         MZe0MqJ/Y866YK6MU287dSIesUPgkSF4KMIQl86IR+HBwaAqCOh0wAnAecuMmJRYoVCa
         2aIMdxCtfLmqhWPyH5Lu0cEbLwzcNvJ4seOGAJgDYq8caZN1G5qZ9GkZXn5mNUkdhZUW
         dlww==
X-Gm-Message-State: APjAAAVXA9ki3Zh2B4xbX0XDJZiFfqGfvAku6qD44ikIZn57EOOfKFZO
        LcxWpsRSwEPUBdee9Xc/vRBvKQ==
X-Google-Smtp-Source: APXvYqzlhYb3nRzqg9PsLj9IoD42cfUInzHIJPEe+c3A8bD6iaesOYDxsQNa0K5hTqY9lUywlCgxxA==
X-Received: by 2002:a63:f40e:: with SMTP id g14mr8567981pgi.132.1573177252836;
        Thu, 07 Nov 2019 17:40:52 -0800 (PST)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id hi2sm3246498pjb.22.2019.11.07.17.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 17:40:52 -0800 (PST)
Date:   Thu, 7 Nov 2019 17:40:47 -0800
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, keescook@chromium.org,
        yzaikin@google.com, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        joe.lawrence@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        schowdary@nvidia.com, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v3 linux-kselftest-test 4/6] kunit: allow kunit tests to
 be loaded as a module
Message-ID: <20191108014047.GA216971@google.com>
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
 <1571335639-21675-5-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571335639-21675-5-git-send-email-alan.maguire@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 07:07:17PM +0100, Alan Maguire wrote:
> as tests are added to kunit, it will become less feasible to execute
  ^
nit: please capitalize "as".

> all built tests together.  By supporting modular tests we provide
> a simple way to do selective execution on a running system; specifying
> 
> CONFIG_KUNIT=y
> CONFIG_KUNIT_EXAMPLE_TEST=m
> 
> ...means we can simply "insmod example-test.ko" to run the tests.
> 
> To achieve this we need to
> 
> o export the required symbols in kunit
> o for non-exported symbols, we need to utilize kunit_find_symbol;
>   the simplest way is for the test suite init to call
>   KUNIT_INIT_[FN|VAR]_SYMBOL() for each non-exported symbol.
> o support a new way of declaring test suites.  Because a module cannot
>   do multiple late_initcall()s, we provide a kunit_test_suites() macro
>   to declare multiple suites within the same module at once.
> 
> When compiled as a module, use of KUNIT_INIT_[FN|VAR]_symbol() will
> retrieve the symbol address via kunit_find_symbol() and assign a local
> variable with the same symbol name appropriately.  When compiled builtin,
> these definitions are used to verify that the types we specify match
> the type of the symbol we are looking for.  Compiler errors will be
> generated if not.
> 
> One wrinkle here is that we cannot use the same names for local function
> pointer definitions; the reason for this is we have likely #included
> a definition for the function in question already, so an attempt to
> redefine it as a function pointer variable fails.  As a result the
> KUNIT_INIT_FN_SYMBOL() macro requires a name for a local symbol we
> have defined as a function pointer (with a signature matching the
> desired function).
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  include/kunit/test.h           | 115 +++++++++++++++++++++++++++++++++++++----
>  kernel/sysctl-test.c           |   4 +-
>  lib/Kconfig.debug              |   2 +-
>  lib/kunit/Kconfig              |   4 +-
>  lib/kunit/assert.c             |   8 +++
>  lib/kunit/example-test.c       |   4 +-
>  lib/kunit/string-stream-test.c |  44 ++++++++++++----
>  lib/kunit/test-test.c          |  32 ++++++++----
>  lib/kunit/test.c               |   9 ++++
>  lib/kunit/try-catch.c          |   2 +
>  10 files changed, 187 insertions(+), 37 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index c645d18..9a3835a 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -12,6 +12,7 @@
>  #include <kunit/assert.h>
>  #include <kunit/try-catch.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
> @@ -78,6 +79,86 @@ struct kunit_resource {
>  	struct list_head node;
>  };
>  
> +/**
> + * KUNIT_VAR_SYMBOL - A helper for defining non-exported variable symbols
> + *
> + * @name: name of the symbol.
> + * @type: type of symbol.
> + *
> + * In the module case, we define the pointer to the symbol type where
> + * we will store the symbol address; KUNIT_INIT_VAR_SYMBOL() will assign
> + * the symbol name to the dereferenced kunit_<symbol_name>.  Note that
> + * in the builtin case we still define kunit_<symbol_name>; the reason
> + * for this is it allows us to verify that the type value is correct
> + * in the builtin case and has not fallen out-of-sync with its original

Very clever! Can you maybe elaborate on how? I didn't understand until I
looked at the initialization code. It would probably be sufficient to
just tell the reader to look at the initialization code.

> + * definition.
> + */
> +#ifdef MODULE
> +#define KUNIT_VAR_SYMBOL(symbol, type)					\
> +	type * kunit_##symbol;						\
> +	type symbol
> +#else
> +#define KUNIT_VAR_SYMBOL(symbol, type)					\
> +	type * kunit_##symbol
> +#endif
> +
> +/**
> + * KUNIT_INIT_VAR_SYMBOL - A helper for initializing non-exported variable
> + *			   symbols
> + * @test: optional pointer to test context
> + * @name: name of symbol
> + *
> + * In the module case, initialization consists of using kunit_find_symbol()
> + * to find the address of the symbol, and if found, we set the variable
> + * to the dereferenced address value.  As mentioned above, in the builtin
> + * case we simply assing kunit_<symbol_name> to &<symbol_name> ; this will
> + * generate a compilation warning if the type we specified in KUNIT_VAR_SYMBOL
> + * and the type of the symbol itself do not match.
> + */
> +#ifdef MODULE
> +#define KUNIT_INIT_VAR_SYMBOL(test, symbol)				\
> +	do {								\
> +		if (!(kunit_##symbol)) {				\
> +			kunit_##symbol = kunit_find_symbol(#symbol);	\
> +			if (!IS_ERR((kunit_##symbol)))			\
> +				symbol = *(kunit_##symbol);		\
> +		}							\
> +		if (test)						\
> +			KUNIT_ASSERT_NOT_ERR_OR_NULL(test,		\
> +						     kunit_##symbol);	\
> +	} while (0)
> +#else
> +#define KUNIT_INIT_VAR_SYMBOL(test, symbol)				\
> +	kunit_##symbol = &(symbol)
> +#endif
> +
> +/**
> + * KUNIT_INIT_FN_SYMBOL - A helper for initializing non-exported function
> + *			  symbols
> + * @test: optional pointer to test context
> + * @symbol: name of symbol
> + * @name: local name of function used to store function pointer to symbol
> + *
> + * In the module case, initialization consists of using kunit_find_symbol()
> + * to find the address of the symbol, and if found, we set function pointer
> + * name to the function address value.  In the non-module case, we simply
> + * assign name to symbol; this will generate a compilation error if the
> + * type we specified for function pointer @name does not match the symbol
> + * function type.
> + */
> +#ifdef MODULE
> +#define KUNIT_INIT_FN_SYMBOL(test, symbol, name)			\
> +	do {								\
> +		if (!name)						\
> +			name = kunit_find_symbol(#symbol);		\
> +		if (test)                                               \
> +			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, name);	\
> +	} while (0)
> +#else
> +#define KUNIT_INIT_FN_SYMBOL(test, symbol, name)			\
> +	name = symbol
> +#endif
> +

Can you put all the KUNIT_*_SYMBOL stuff in another patchset along with
the kunit_find_symbol?

>  struct kunit;
>  
>  /**
> @@ -197,31 +278,45 @@ struct kunit {
>  int kunit_run_tests(struct kunit_suite *suite);
>  
>  /**
> - * kunit_test_suite() - used to register a &struct kunit_suite with KUnit.
> + * kunit_test_suites() - used to register one or more &struct kunit_suite
> + *			 with KUnit.
>   *
> - * @suite: a statically allocated &struct kunit_suite.
> + * @suites: a statically allocated list of &struct kunit_suite.
>   *
> - * Registers @suite with the test framework. See &struct kunit_suite for
> + * Registers @suites with the test framework. See &struct kunit_suite for
>   * more information.
>   *
> - * NOTE: Currently KUnit tests are all run as late_initcalls; this means
> + * When builtin,  KUnit tests are all run as late_initcalls; this means
>   * that they cannot test anything where tests must run at a different init
>   * phase. One significant restriction resulting from this is that KUnit
>   * cannot reliably test anything that is initialize in the late_init phase;
>   * another is that KUnit is useless to test things that need to be run in
>   * an earlier init phase.
>   *
> + * An alternative is to build the tests as a module.  Because modules
> + * do not support multiple late_initcall()s, we need to initialize an
> + * array of suites for a module.
> + *
>   * TODO(brendanhiggins@google.com): Don't run all KUnit tests as
>   * late_initcalls.  I have some future work planned to dispatch all KUnit
>   * tests from the same place, and at the very least to do so after
>   * everything else is definitely initialized.
>   */
> -#define kunit_test_suite(suite)						       \
> -	static int kunit_suite_init##suite(void)			       \
> -	{								       \
> -		return kunit_run_tests(&suite);				       \
> -	}								       \
> -	late_initcall(kunit_suite_init##suite)
> +#define kunit_test_suites(...)						\
> +	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
> +	static int kunit_test_suites_init(void)				\
> +	{								\
> +		unsigned int i;						\
> +		for (i = 0; suites[i] != NULL; i++)			\
> +			kunit_run_tests(suites[i]);			\
> +		return 0;						\
> +	}								\
> +	late_initcall(kunit_test_suites_init);				\
> +	static void __exit kunit_test_suites_exit(void)			\
> +	{								\
> +		return;							\
> +	}								\
> +	module_exit(kunit_test_suites_exit)
>  
>  /*
>   * Like kunit_alloc_resource() below, but returns the struct kunit_resource
