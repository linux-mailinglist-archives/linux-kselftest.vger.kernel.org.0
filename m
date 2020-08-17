Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76F245D08
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Aug 2020 09:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHQHGp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Aug 2020 03:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgHQHGh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Aug 2020 03:06:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B853CC061388
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Aug 2020 00:06:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ba10so11427334edb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Aug 2020 00:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ZvbvvosG6I7wsjApE0BjLkAaZkKZ2tdfYfQHRAdMLU=;
        b=DGWXCaTYy5NVkneXdSYdjTlBT1eQtZBGv420YzMhXMnKAfVtYKvYfgQl2tOkehBTUm
         aIwrpTLvumyUtSHmgNhsWwoqInH/4fySSiAr+Ldtrxh8+Hr4jMurU8kx6LZFhaMeUsoE
         gwtaLUkG56qr9N6TrZqr7MIs/Y8xBa/jh+KFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ZvbvvosG6I7wsjApE0BjLkAaZkKZ2tdfYfQHRAdMLU=;
        b=mo2RMtsZPlPBQNLDZkzP4mVaMbSaU1tqM3F/LGQ+txOkR0kQXV6tI+sbwr/gu4IU7s
         pl4awOmRudEYTCe/jguv9rqyy4mnN10BYkFpKa1pjUU9LvyHNtQJ17HoIQVMrbnkztxl
         W3La0mW8iadDlsbXTjlUcpOgQyvhU+5mX2F+w7CjZKjOn/8NcfgBZIX3/jz4r6yLUFd+
         eQYIppYzf/Xxv79O+2XhFC4Oso5gl+K3+3OEjMFVSXpwWz2gVuyQ5I7meuQKIbmM75y6
         h6+e/4Kkbb16Fm4uGKSqlDsKFyCDy7MI3TCm6Szyp/GgzMTdeZvP2tr1RqNklfUUwlF1
         SM5w==
X-Gm-Message-State: AOAM531BHennbsWdaOBoT0sztgVFycYRDGndlwyk9PIzUfWe6KDGHaUk
        03L0lNtgKuNnm3qVobY8c9vSZBxwXcs08pso
X-Google-Smtp-Source: ABdhPJx0FQlIMH07y60AOp8FWIeK7yINY4Q7g/X5/Z9UDGrRMeSl4OiXsC3siraqCPgZP1xZE3MMKg==
X-Received: by 2002:a50:9e4c:: with SMTP id z70mr13300819ede.384.1597647995423;
        Mon, 17 Aug 2020 00:06:35 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j24sm13514238ejv.32.2020.08.17.00.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 00:06:34 -0700 (PDT)
Subject: Re: [PATCH] lib: Convert test_printf.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        pmladek@suse.com, rostedt@goodmis.org, sergey.senozhatsky@gmail.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200817043028.76502-1-98.arpi@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
Date:   Mon, 17 Aug 2020 09:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817043028.76502-1-98.arpi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/08/2020 06.30, Arpitha Raghunandan wrote:
> Converts test lib/test_printf.c to KUnit.
> More information about KUnit can be found at
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> KUnit provides a common framework for unit tests in the kernel.

So I can continue to build a kernel with some appropriate CONFIG set to
y, boot it under virt-me, run dmesg and see if I broke printf? That's
what I do now, and I don't want to have to start using some enterprisy
framework.

> diff --git a/lib/test_printf.c b/lib/printf_kunit.c
> similarity index 45%
> rename from lib/test_printf.c
> rename to lib/printf_kunit.c
> index 7ac87f18a10f..68ac5f9b8d28 100644
> --- a/lib/test_printf.c
> +++ b/lib/printf_kunit.c
> @@ -5,6 +5,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <kunit/test.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -30,79 +31,61 @@
>  #define PAD_SIZE 16
>  #define FILL_CHAR '$'
>  
> -static unsigned total_tests __initdata;
> -static unsigned failed_tests __initdata;
> -static char *test_buffer __initdata;
> -static char *alloced_buffer __initdata;
> +static char *test_buffer;
> +static char *alloced_buffer;
>  
> -static int __printf(4, 0) __init
> -do_test(int bufsize, const char *expect, int elen,
> +static void __printf(5, 0)
> +do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
>  	const char *fmt, va_list ap)
>  {
>  	va_list aq;
>  	int ret, written;
>  
> -	total_tests++;
> -
>  	memset(alloced_buffer, FILL_CHAR, BUF_SIZE + 2*PAD_SIZE);
>  	va_copy(aq, ap);
>  	ret = vsnprintf(test_buffer, bufsize, fmt, aq);
>  	va_end(aq);
>  
> -	if (ret != elen) {
> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
> +	KUNIT_EXPECT_EQ_MSG(kunittest, ret, elen,
> +			"vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
>  			bufsize, fmt, ret, elen);
> -		return 1;
> -	}


IIRC, some of these early returns are required to ensure the following
checks do not fail (as in, potentially crash the kernel) simply because
they go off into the weeds. Please double-check that they are all safe
to continue to perform (though, another reason I might have put them in
is to simply avoid lots of useless collateral).


> -	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
> +	KUNIT_EXPECT_EQ_MSG(kunittest, memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE), NULL,

> -		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
> +		KUNIT_EXPECT_FALSE_MSG(kunittest,

> -	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
> +	KUNIT_EXPECT_FALSE_MSG(kunittest,
> +			memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))

Why the inconsistency in what a memchr_inv != NULL check gets converted to?


>  
> -static void __printf(3, 4) __init
> -__test(const char *expect, int elen, const char *fmt, ...)
> +static void __printf(4, 5)
> +__test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, ...)
>  {
>  	va_list ap;
>  	int rand;
>  	char *p;
>  
> -	if (elen >= BUF_SIZE) {
> -		pr_err("error in test suite: expected output length %d too long. Format was '%s'.\n",
> -		       elen, fmt);
> -		failed_tests++;
> -		return;
> -	}
> +	KUNIT_EXPECT_LT_MSG(kunittest, elen, BUF_SIZE,
> +			"error in test suite: expected output length %d too long. Format was '%s'.\n",
> +			elen, fmt);

And it's ok to continue with the tests when the test suite itself is
buggy because? [*]

>  	va_start(ap, fmt);
>  
> @@ -112,49 +95,46 @@ __test(const char *expect, int elen, const char *fmt, ...)
>  	 * enough and 0), and then we also test that kvasprintf would
>  	 * be able to print it as expected.
>  	 */
> -	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
> +	do_test(kunittest, BUF_SIZE, expect, elen, fmt, ap);
>  	rand = 1 + prandom_u32_max(elen+1);
>  	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
> -	failed_tests += do_test(rand, expect, elen, fmt, ap);

[*] Certainly this invariant gets violated, so we (may) provide do_test
with a buffer size larger than, well, BUF_SIZE.

>  
> -#define test(expect, fmt, ...)					\
> -	__test(expect, strlen(expect), fmt, ##__VA_ARGS__)
> +#define test(kunittest, expect, fmt, ...)					\
> +	__test(kunittest, expect, strlen(expect), fmt, ##__VA_ARGS__)
>  
> -static void __init
> -test_basic(void)
> +static void
> +test_basic(struct kunit *kunittest)
>  {
>  	/* Work around annoying "warning: zero-length gnu_printf format string". */
>  	char nul = '\0';
>  
> -	test("", &nul);
> -	test("100%", "100%%");
> -	test("xxx%yyy", "xxx%cyyy", '%');
> -	__test("xxx\0yyy", 7, "xxx%cyyy", '\0');
> +	test(kunittest, "", &nul);
> +	test(kunittest, "100%", "100%%");
> +	test(kunittest, "xxx%yyy", "xxx%cyyy", '%');
> +	__test(kunittest, "xxx\0yyy", 7, "xxx%cyyy", '\0');

Am I reading this right that all this is simply to prepend kunittest to
the arguments? How about just redefining the test macro so it
automagically does that instead of all this churn? The few cases that
use __test may need to be handled specially.

> +
> +static void selftest(struct kunit *kunittest)
>  {
>  	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
>  	if (!alloced_buffer)
>  		return;
>  	test_buffer = alloced_buffer + PAD_SIZE;
>  
> -	test_basic();
> -	test_number();
> -	test_string();
> -	test_pointer();
> +	test_basic(kunittest);
> +	test_number(kunittest);
> +	test_string(kunittest);
> +	test_pointer(kunittest);
>  
>  	kfree(alloced_buffer);
>  }

Even better, since the whole thing still relies on the static variables
test_buffer and alloced_buffer, why not just stash the struct kunit*
that the framework passes in a file-scope static and avoid even more
churn? Then only the newly introduce KUNIT_CHECK_* macros need to refer
to it, and none of the existing code (or future cases) needs that piece
of boilerplate.

BTW, does the framework have some kind of logic that ensures nobody runs
the printf suite twice in parallel?

Rasmus
