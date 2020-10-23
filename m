Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E762975CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 19:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbgJWRbM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 13:31:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:32872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753456AbgJWRbL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 13:31:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603474269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3rq43a05wms68FvUYQpJ6f6BxWzKhLrTDzGkVJPH+XM=;
        b=PD0NClmWkXNM1R9LE07FzmL1COtEFexv1pz0M3EoIwWhgMmUE7qSMFoLxkjWkbB2V1a8nf
        AVt6h7B/x58sFE9kNpxZM4SumJLliz0RQYtOZv1WOLAV0nHg7Vyy8a2wu4zSVix4GXrXPv
        SJ6R9DVrxAcqXr0uCiM6oYkccq3lVfk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54AF6AB95;
        Fri, 23 Oct 2020 17:31:09 +0000 (UTC)
Date:   Fri, 23 Oct 2020 19:31:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk,
        alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, idryomov@gmail.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib: Convert test_printf.c to KUnit
Message-ID: <20201023173108.GG32486@alley>
References: <20201022151349.47436-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022151349.47436-1-98.arpi@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2020-10-22 20:43:49, Arpitha Raghunandan wrote:
> Convert test lib/test_printf.c to KUnit. More information about

> Converted test success:
>     # Subtest: printf-kunit-test
>     1..1
>     ok 1 - selftest
> ok 1 - printf-kunit-test
> 
> Converted test failure:
>     # Subtest: printf-kunit-test
>     1..1
>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
> vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote
> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
> vsnprintf(buf, 5, "%pi4|%pI4", ...) wrote '127.', expected '127-'
>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:118
> kvasprintf(..., "%pi4|%pI4", ...) returned
> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>     not ok 1 - selftest

I agree with others that there should be more KUNIT_CASEs.

> not ok 1 - printf-kunit-test

> --- a/lib/test_printf.c
> +++ b/lib/printf_kunit.c

There is no standard at the moment. I see struct kunit_source defined,
for example, in the following files:

*test*.c:

      drivers/base/power/qos-test.c:
      drivers/base/test/property-entry-test.c:
      drivers/thunderbolt/test.c:
      fs/ext4/inode-test.c:
      kernel/kcsan/kcsan-test.c:
      kernel/sysctl-test.c:
      lib/kunit/string-stream-test.c:
      lib/list-test.c:
      lib/test_bits.c:
      lib/test_kasan.c:
      lib/test_linear_ranges.c:
      net/mptcp/crypto_test.c:
      net/mptcp/token_test.c:
      security/apparmor/policy_unpack_test.c:

kunit-*-test.c:

       lib/kunit/kunit-example-test.c:
       lib/kunit/kunit-test.c:

*_kunit.c

      lib/bitfield_kunit.c:

Please, either unify names of all the above modules or keep test_printf.c



> @@ -5,6 +5,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <kunit/test.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -30,64 +31,57 @@
>  #define PAD_SIZE 16
>  #define FILL_CHAR '$'
>  
> -static unsigned total_tests __initdata;
> -static unsigned failed_tests __initdata;
>  static char *test_buffer __initdata;
>  static char *alloced_buffer __initdata;
> +struct kunit *kunittest;

This should be static variable.

>  
> -static int __printf(4, 0) __init
> +static void __printf(4, 0) __init
>  do_test(int bufsize, const char *expect, int elen,
>  	const char *fmt, va_list ap)
>  {
>  	va_list aq;
>  	int ret, written;
>  

> @@ -696,8 +684,9 @@ test_pointer(void)
>  	fwnode_pointer();
>  }
>  
> -static void __init selftest(void)
> +static void __init selftest(struct kunit *ktest)

>  {
> +	kunittest = ktest;
>  	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);

The allocation and freeing should be done by the init,exit
callbacs in struct kunit_testsuite. For example, see
lib/kunit/kunit-test.c

This function can then be removed. The particular tests will
be called via more KUNIT_CASE() entries.

>  	if (!alloced_buffer)
>  		return;
> @@ -711,6 +700,17 @@ static void __init selftest(void)
>  	kfree(alloced_buffer);
>  }
>  
> -KSTM_MODULE_LOADERS(test_printf);
> +static struct kunit_case printf_test_cases[] = {
> +	KUNIT_CASE(selftest),
> +	{}
> +};
> +
> +static struct kunit_suite printf_test_suite = {
> +	.name = "printf-kunit-test",

Please, use:

	.name = "printf"

The fact that it is kunit-test should be clear from the context.

> +	.test_cases = printf_test_cases,
> +};
> +
> +kunit_test_suite(printf_test_suite);
> +

Best Regards,
Petr
