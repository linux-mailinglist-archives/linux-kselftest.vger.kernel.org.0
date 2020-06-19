Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FBD201D7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgFSV5b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 17:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgFSV50 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 17:57:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51081C0613EF
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 14:57:24 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x62so5031249qtd.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rdhxkZX4GmXKSSpsPwGF4bgioI4q0DW5JlXRU/AUlkk=;
        b=mRiPlpOuXbePKoXKYhDFTZ4Jtt6zf1Okl1KJwxQLCsOk74sMT88rOgCfDBrGrWz6F7
         +DE0O4fOnwgtlG3IN91gYWFphtijC32KzwEXJhu5w29ejvAp+98RKifWyXchiMYMCX92
         mZH9Id5OWqXgM6ymZE+c7sazt/Mhu8ki3ndIAKoousXZuQiGULxgVSwjKiStbU6TpPul
         4ZvjVI1CdsQeLJ698wirI9deBBVy6eXjlqeVxlcyHvXwVMgG+fY46jatAGSNLBElK0A8
         JAdrCGSKtCeblFPMe/mEHvTiHEh/fLjYm32V0ZaiAJ6G84FkXrGHfv1xwNLoYb6cggDe
         hacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rdhxkZX4GmXKSSpsPwGF4bgioI4q0DW5JlXRU/AUlkk=;
        b=b0W6SX3F2VJ3uqS2lsAiAsG3zEMZkUk2XHPs679PSqU3v/FdXZWnMz+R/28nnZ55U1
         36ukogTSVffqiMliPvXJuVyqlbCdH1RJc3sAG+iIL7l1SUhMdQktfa9maEK8aObVG/Gx
         Dtp13Wn2NYXyOzgWpEJbr7yIkaBeSUvnj7ku5y7HVaAwu5xQmxs1Xp+cQJuO+eBfZPPy
         3BYZXFaKnktVSp5Qtqi2cGuaDlWq5QZZAWGOPfJsZL89HPhDyVBqkGehAQSHCSSQaD+o
         GOu702IBuu8paU250prBOClU/I1adV0zVMTh4itHkMSK0N6DwU1EYnAI2f1NABgp/big
         ZrnA==
X-Gm-Message-State: AOAM532ROLMn04XW3q8aaOxaZ+AN4JvMEmvtoGC7wONHIiwkP7/0z7rw
        7cbE3dlES8OONbXtKIydj/QWKg==
X-Google-Smtp-Source: ABdhPJzDEbhH9/2WoXmmZH2RrRnKaQv0db5TBB7Xaag8scxB9vAIb4QCZdoLN4qlc8YWSIKcq0cqcA==
X-Received: by 2002:ac8:688a:: with SMTP id m10mr2810282qtq.254.1592603843298;
        Fri, 19 Jun 2020 14:57:23 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id g140sm7437850qke.98.2020.06.19.14.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 14:57:22 -0700 (PDT)
Message-ID: <2251a43aa773dbd4a417dca20ba12ee0559f9031.camel@massaru.org>
Subject: Re: [RESEND, PATCH v2] lib: overflow-test: add KUnit test of
 check_*_overflow functions
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kunit-dev@googlegroups.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux@rasmusvillemoes.dk, davidgow@google.com
Date:   Fri, 19 Jun 2020 18:57:19 -0300
In-Reply-To: <202006181949.6402C456@keescook>
References: <20200618140814.135948-1-vitor@massaru.org>
         <202006181949.6402C456@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2020-06-18 at 20:05 -0700, Kees Cook wrote:
> On Thu, Jun 18, 2020 at 11:08:14AM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the runtime tests of check_*_overflow
> > functions,
> > from `lib/test_overflow.c`to KUnit tests.
> > 
> > The log similar to the one seen in dmesg running test_overflow.c
> > can be
> > seen in `test.log`.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Tested-by: David Gow <davidgow@google.com>
> > ---
> > v2:
> >   * moved lib/test_overflow.c to lib/overflow-test.c; 

Sure.

> I still don't want a dash in the filename, as this creates a
> difference
> between the source name and the module name. While I still prefer
> overflow_kunit.c, I can get over it and accept overflow_test.c :)
> 
> >     * back to original license;
> >     * fixed style code;
> >     * keeps __initconst and added _refdata on overflow_test_cases
> > variable;
> >     * keeps macros intact making asserts with the variable err;
> >     * removed duplicate test_s8_overflow();
> >   * fixed typos on commit message;
> > ---
> >  lib/Kconfig.debug                        | 20 +++++++--
> >  lib/Makefile                             |  2 +-
> >  lib/{test_overflow.c => overflow-test.c} | 54 +++++++++-----------
> > ----
> >  3 files changed, 38 insertions(+), 38 deletions(-)
> >  rename lib/{test_overflow.c => overflow-test.c} (96%)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d74ac0fd6b2d..fb8a3955e969 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2000,9 +2000,6 @@ config TEST_UUID
> >  config TEST_XARRAY
> >  	tristate "Test the XArray code at runtime"
> >  
> > -config TEST_OVERFLOW
> > -	tristate "Test check_*_overflow() functions at runtime"
> > -
> >  config TEST_RHASHTABLE
> >  	tristate "Perform selftest on resizable hash table"
> >  	help
> > @@ -2155,6 +2152,23 @@ config SYSCTL_KUNIT_TEST
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
> > diff --git a/lib/Makefile b/lib/Makefile
> > index b1c42c10073b..3b725c9f92d4 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -75,7 +75,6 @@ obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
> >  obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
> >  obj-$(CONFIG_TEST_LKM) += test_module.o
> >  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
> > -obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
> >  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
> >  obj-$(CONFIG_TEST_SORT) += test_sort.o
> >  obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
> > @@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
> >  # KUnit tests
> >  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> >  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> > +obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow-test.o
> > diff --git a/lib/test_overflow.c b/lib/overflow-test.c
> > similarity index 96%
> > rename from lib/test_overflow.c
> > rename to lib/overflow-test.c
> > index 7a4b6f6c5473..d40ef06b1ade 100644
> > --- a/lib/test_overflow.c
> > +++ b/lib/overflow-test.c
> > @@ -4,14 +4,11 @@
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
> > @@ -270,7 +267,7 @@ DEFINE_TEST_FUNC(u64, "%llu");
> >  DEFINE_TEST_FUNC(s64, "%lld");
> >  #endif
> >  
> > -static int __init test_overflow_calculation(void)
> > +static void __init overflow_calculation_test(struct kunit *test)
> >  {
> >  	int err = 0;
> >  
> > @@ -285,10 +282,10 @@ static int __init
> > test_overflow_calculation(void)
> >  	err |= test_s64_overflow();
> >  #endif
> >  
> > -	return err;
> > +	KUNIT_EXPECT_FALSE(test, err);
> >  }
> 
> Ah! Well, yes, I guess that is one way to do it. :) I'm just curious:
> why the change away from doing EXPECTs on individual tests?

When returning the err variables, I was not sure if it was to make the
asserts individually, I can do that.

> >  
> > -static int __init test_overflow_shift(void)
> > +static void __init overflow_shift_test(struct kunit *test)
> >  {
> >  	int err = 0;
> >  
> > @@ -479,7 +476,7 @@ static int __init test_overflow_shift(void)
> >  	err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
> >  	err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
> >  
> > -	return err;
> > +	KUNIT_EXPECT_FALSE(test, err);
> >  }
> >  
> >  /*
> > @@ -555,7 +552,7 @@ DEFINE_TEST_ALLOC(kvzalloc_node, kvfree,     0,
> > 1, 1);
> >  DEFINE_TEST_ALLOC(devm_kmalloc,  devm_kfree, 1, 1, 0);
> >  DEFINE_TEST_ALLOC(devm_kzalloc,  devm_kfree, 1, 1, 0);
> >  
> > -static int __init test_overflow_allocation(void)
> > +static void __init overflow_allocation_test(struct kunit *test)
> >  {
> >  	const char device_name[] = "overflow-test";
> >  	struct device *dev;
> > @@ -563,10 +560,8 @@ static int __init
> > test_overflow_allocation(void)
> >  
> >  	/* Create dummy device for devm_kmalloc()-family tests. */
> >  	dev = root_device_register(device_name);
> > -	if (IS_ERR(dev)) {
> > -		pr_warn("Cannot register test device\n");
> > -		return 1;
> > -	}
> > +	if (IS_ERR(dev))
> > +		kunit_warn(test, "Cannot register test device\n");
> >  
> >  	err |= test_kmalloc(NULL);
> >  	err |= test_kmalloc_node(NULL);
> > @@ -585,30 +580,21 @@ static int __init
> > test_overflow_allocation(void)
> >  
> >  	device_unregister(dev);
> >  
> > -	return err;
> > +	KUNIT_EXPECT_FALSE(test, err);
> >  }
> >  
> > -static int __init test_module_init(void)
> > -{
> > -	int err = 0;
> > -
> > -	err |= test_overflow_calculation();
> > -	err |= test_overflow_shift();
> > -	err |= test_overflow_allocation();
> > -
> > -	if (err) {
> > -		pr_warn("FAIL!\n");
> > -		err = -EINVAL;
> > -	} else {
> > -		pr_info("all tests passed\n");
> > -	}
> > +static struct kunit_case __refdata overflow_test_cases[] = {
> 
> Erm, __refdata? This seems like it should be __initdata.

I tried to use __initdata, but the build still gave warnings.

> 
> > +	KUNIT_CASE(overflow_calculation_test),
> > +	KUNIT_CASE(overflow_shift_test),
> > +	KUNIT_CASE(overflow_allocation_test),
> > +	{}
> > +};
> >  
> > -	return err;
> > -}
> > +static struct kunit_suite overflow_test_suite = {
> 
> And this.
> 
> > +	.name = "overflow",
> > +	.test_cases = overflow_test_cases,
> > +};
> >  
> > -static void __exit test_module_exit(void)
> > -{ }
> > +kunit_test_suites(&overflow_test_suite);
> 
> I suspect the problem causing the need for __refdata there is the
> lack
> of __init markings on the functions in kunit_test_suites()?

From the kunit_test_suites() documentation I saw that I need to write
the test as a module to solve this problem. I'll fix this.

> 
> (Or maybe this is explained somewhere else I've missed it.)
> 
> For example, would this work? (I haven't tested it all.)

Oops. It doesn't work, I'm sorry.


> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 59f3144f009a..aad746d59d2f 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -233,9 +233,9 @@ size_t kunit_suite_num_test_cases(struct
> kunit_suite *suite);
>  unsigned int kunit_test_case_num(struct kunit_suite *suite,
>  				 struct kunit_case *test_case);
>  
> -int __kunit_test_suites_init(struct kunit_suite **suites);
> +int __init __kunit_test_suites_init(struct kunit_suite **suites);
>  
> -void __kunit_test_suites_exit(struct kunit_suite **suites);
> +void __exit __kunit_test_suites_exit(struct kunit_suite **suites);
>  
>  /**
>   * kunit_test_suites() - used to register one or more &struct
> kunit_suite
> @@ -263,8 +263,9 @@ void __kunit_test_suites_exit(struct kunit_suite
> **suites);
>   * everything else is definitely initialized.
>   */
>  #define kunit_test_suites(suites_list...)				
> \
> -	static struct kunit_suite *suites[] = {suites_list, NULL};	
> \
> -	static int kunit_test_suites_init(void)				
> \
> +	static struct kunit_suite *suites[] __initdata =		\
> +		{suites_list, NULL};					
> \
> +	static int __init kunit_test_suites_init(void)			
> \
>  	{								\
>  		return __kunit_test_suites_init(suites);		\
>  	}								\
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c36037200310..bfb0f563721b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -381,7 +381,7 @@ static void kunit_init_suite(struct kunit_suite
> *suite)
>  	kunit_debugfs_create_suite(suite);
>  }
>  
> -int __kunit_test_suites_init(struct kunit_suite **suites)
> +int __init __kunit_test_suites_init(struct kunit_suite **suites)
>  {
>  	unsigned int i;
>  
> @@ -393,7 +393,7 @@ int __kunit_test_suites_init(struct kunit_suite
> **suites)
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
>  
> -static void kunit_exit_suite(struct kunit_suite *suite)
> +static void __exit kunit_exit_suite(struct kunit_suite *suite)
>  {
>  	kunit_debugfs_destroy_suite(suite);
>  }
> 
> >  
> > -module_init(test_module_init);
> > -module_exit(test_module_exit);
> >  MODULE_LICENSE("Dual MIT/GPL");
> > 
> > base-commit: 7bf200b3a4ac10b1b0376c70b8c66ed39eae7cdd
> > prerequisite-patch-id: e827b6b22f950b9f69620805a04e4a264cf4cc6a
> > -- 
> > 2.26.2
> > 
> 
> Thanks again for the conversion!


Thanks for the review.

