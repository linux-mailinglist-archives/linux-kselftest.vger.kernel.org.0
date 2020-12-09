Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7682D4408
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Dec 2020 15:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgLIOQd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Dec 2020 09:16:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:41156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbgLIOQd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Dec 2020 09:16:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607523345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ZGK7g35Goq64Ci9MeapPBQgkMe+5KSgf3nOc5lvEFA=;
        b=R47mLGAr7aLiQsrHNJH+SRoAOoJ5WYQZd5B2ksYtQu9uFF57MTwsYvxkG2obJg051NemD3
        clV59YMSpHdpqnN4q+j/bZAUTinYcY5tmjd9e0JQi3Xml0td8ftMSjVy5XgSNdAPjpzJqP
        4GZ6VwuFWZyTsJz/xMVIlB5+ecMEc9I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F016AB2DC;
        Wed,  9 Dec 2020 14:15:44 +0000 (UTC)
Date:   Wed, 9 Dec 2020 15:15:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        shuah@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] lib: test_scanf: Add tests for sscanf number
 conversion
Message-ID: <X9DcEL54k0qRayr+@alley>
References: <20201130145800.19960-1-rf@opensource.cirrus.com>
 <20201130145800.19960-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130145800.19960-2-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2020-11-30 14:57:58, Richard Fitzgerald wrote:
> Adds test_sscanf to test various number conversion cases, as
> number conversion was previously broken.
> 
> This also tests the simple_strtoxxx() functions exported from
> vsprintf.c.

It is impressive.

Honestly, I do not feel to be expert on testing and mathematics.
I am not sure how comprehensive the test is. Also I am not
sure what experts would say about the tricks with random
numbers.

Anyway, this is much more than what I have expected. And it checks
great number of variants and corner cases.

I suggest only one small change, see below.

> --- /dev/null
> +++ b/lib/test_scanf.c
> @@ -0,0 +1,747 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test cases for sscanf facility.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bitops.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/printk.h>
> +#include <linux/random.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "../tools/testing/selftests/kselftest_module.h"
> +
> +#define BUF_SIZE 1024
> +
> +static unsigned total_tests __initdata;
> +static unsigned failed_tests __initdata;
> +static char *test_buffer __initdata;
> +static char *fmt_buffer __initdata;
> +static struct rnd_state rnd_state __initdata;
> +
> +typedef int (*check_fn)(const void *check_data, const char *string,
> +			const char *fmt, int n_args, va_list ap);
> +
> +static void __scanf(4, 6) __init
> +_test(check_fn fn, const void *check_data, const char *string, const char *fmt,
> +	int n_args, ...)
> +{
> +	va_list ap, ap_copy;
> +	int ret;
> +
> +	total_tests++;
> +
> +	va_start(ap, n_args);
> +	va_copy(ap_copy, ap);
> +	ret = vsscanf(string, fmt, ap_copy);
> +	va_end(ap_copy);
> +
> +	if (ret != n_args) {
> +		pr_warn("vsscanf(\"%s\", \"%s\", ...) returned %d expected %d\n",
> +			string, fmt, ret, n_args);
> +		goto fail;
> +	}
> +
> +	ret = (*fn)(check_data, string, fmt, n_args, ap);
> +	if (ret)
> +		goto fail;
> +
> +	va_end(ap);
> +
> +	return;
> +
> +fail:
> +	failed_tests++;
> +	va_end(ap);
> +}
> +
> +#define test_one_number(T, gen_fmt, scan_fmt, val, fn)			\
> +do {									\
> +	const T expect_val = (T)(val);					\
> +	T result = ~expect_val; /* should be overwritten */		\

If I get it correctly, this is supposed to initialize the temporary
variable with a value that is different from the expected value.
It will cause test failure when it is not updated by vsscanf().

It does not work for zero value. A better solution might be to add
a constant, for example:

	T result = expect_val + 3; /* do not match when not overwritten */ \

I did not use "+ 1" intentionally because it might hide some overflow
issues.

> +									\
> +	snprintf(test_buffer, BUF_SIZE, gen_fmt, expect_val);		\
> +	_test(fn, &expect_val, test_buffer, "%" scan_fmt, 1, &result);	\
> +} while (0)

Otherwise, it looks good to me.

Best Regards,
Petr
