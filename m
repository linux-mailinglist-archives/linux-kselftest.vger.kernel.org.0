Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05024CD08
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 06:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHUEyo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Aug 2020 00:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHUEyn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Aug 2020 00:54:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A9FC061385;
        Thu, 20 Aug 2020 21:54:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so354094plr.0;
        Thu, 20 Aug 2020 21:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FeLWSTdoM4nf+36Zjzc7ne8kyEInVTO4IOni7rUwpas=;
        b=cwe7WcRuGsa6f/zGPnLYLtWyVucgzXqUMN+gDwsJfZZ8jjhKvHxJOX30r7GqxWs7Qd
         qfh9x+hbvHjsz/jwN2Pc/brQaR0Kaaa67FRBA2VicBgJqjmoaV/Wi/JYnwxrHhW4zgxX
         P7wYR1zBZLOGPqK3Hrx/FjuFz3i7oWT9a9+D5VZUSvFx9A3DyjjaXTbWLZGqdqyx0cd0
         9Rx/UzHI3cP1klYZhfnNeraGjE8tb9MdCUg0bIE5kQ50QJRRBXronFnF8iytC3ml/Frd
         c83dKCeL+Hwei5yesXlif/HeqnQ/6cRJHSGeY86DxYzhlUzWBqoNK6W+A0u3ntzUJAwM
         zVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FeLWSTdoM4nf+36Zjzc7ne8kyEInVTO4IOni7rUwpas=;
        b=GBpXe1M6Geizj99R0XGk50P+98jP9/HXNyDfbrXszVBnpQBW2WJ/YhucFID5ZaR2eE
         lXN2IIam7Sv48bBDHWV1HdeDQJBP1HsegwPEXti6gJyxQC4GacN43y4LRLwVXCAlavXX
         Fd3LVbI7NA65f/jQDfTs19HA0iK2zbuq6XL57iEoRrq2xle0hZSCgqcdHSYLkpL69mWw
         Lv2A/azGea5imfpFLFBZ2B/PVektOaMG1nYaYLRWJK86b0T4zok+9D7aSrxc2407MkjJ
         KVSpw2n3oWLE0suyeQUm5s02bLYhTNu+EaxViSYGqD6aTMbHI2oD3ChJVq6N0xgz/4Nv
         H7jA==
X-Gm-Message-State: AOAM531I0MrEKm8i6OHfBXDaViqx1Z9Z5y/lp+TtgRi24YXqLLSW3kLR
        sr8bFLRIKss2oLVE0wLnoJjSGyeJzfZsbkNO
X-Google-Smtp-Source: ABdhPJwSYeHb6R0XOe+q1qknq8go0JYAceoF6n2aOzvEaYKe5W+Xf6Gec0ftsAnTCpKMlQp/dhtA3g==
X-Received: by 2002:a17:902:b681:: with SMTP id c1mr1017367pls.214.1597985682615;
        Thu, 20 Aug 2020 21:54:42 -0700 (PDT)
Received: from [192.168.86.81] ([49.206.11.137])
        by smtp.gmail.com with ESMTPSA id b185sm829596pfg.71.2020.08.20.21.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 21:54:41 -0700 (PDT)
Subject: Re: [PATCH] lib: Convert test_printf.c to KUnit
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200817043028.76502-1-98.arpi@gmail.com>
 <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <2e1d1e40-b448-9389-d7d2-93841af60a88@gmail.com>
Date:   Fri, 21 Aug 2020 10:24:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/08/20 12:36 pm, Rasmus Villemoes wrote:
> On 17/08/2020 06.30, Arpitha Raghunandan wrote:
>> Converts test lib/test_printf.c to KUnit.
>> More information about KUnit can be found at
>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
>> KUnit provides a common framework for unit tests in the kernel.
> 
> So I can continue to build a kernel with some appropriate CONFIG set to
> y, boot it under virt-me, run dmesg and see if I broke printf? That's
> what I do now, and I don't want to have to start using some enterprisy
> framework.
> 

Yes, the test can be run on boot up. More information about this can be found here: https://www.kernel.org/doc/html/latest/dev-tools/kunit/start.html#running-tests-without-the-kunit-wrapper.

>> diff --git a/lib/test_printf.c b/lib/printf_kunit.c
>> similarity index 45%
>> rename from lib/test_printf.c
>> rename to lib/printf_kunit.c
>> index 7ac87f18a10f..68ac5f9b8d28 100644
>> --- a/lib/test_printf.c
>> +++ b/lib/printf_kunit.c
>> @@ -5,6 +5,7 @@
>>  
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>  
>> +#include <kunit/test.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> @@ -30,79 +31,61 @@
>>  #define PAD_SIZE 16
>>  #define FILL_CHAR '$'
>>  
>> -static unsigned total_tests __initdata;
>> -static unsigned failed_tests __initdata;
>> -static char *test_buffer __initdata;
>> -static char *alloced_buffer __initdata;
>> +static char *test_buffer;
>> +static char *alloced_buffer;
>>  
>> -static int __printf(4, 0) __init
>> -do_test(int bufsize, const char *expect, int elen,
>> +static void __printf(5, 0)
>> +do_test(struct kunit *kunittest, int bufsize, const char *expect, int elen,
>>  	const char *fmt, va_list ap)
>>  {
>>  	va_list aq;
>>  	int ret, written;
>>  
>> -	total_tests++;
>> -
>>  	memset(alloced_buffer, FILL_CHAR, BUF_SIZE + 2*PAD_SIZE);
>>  	va_copy(aq, ap);
>>  	ret = vsnprintf(test_buffer, bufsize, fmt, aq);
>>  	va_end(aq);
>>  
>> -	if (ret != elen) {
>> -		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
>> +	KUNIT_EXPECT_EQ_MSG(kunittest, ret, elen,
>> +			"vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
>>  			bufsize, fmt, ret, elen);
>> -		return 1;
>> -	}
> 
> 
> IIRC, some of these early returns are required to ensure the following
> checks do not fail (as in, potentially crash the kernel) simply because
> they go off into the weeds. Please double-check that they are all safe
> to continue to perform (though, another reason I might have put them in
> is to simply avoid lots of useless collateral).
> 

These are safe to perform. I will check once again though.

> 
>> -	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
>> +	KUNIT_EXPECT_EQ_MSG(kunittest, memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE), NULL,
> 
>> -		if (memchr_inv(test_buffer, FILL_CHAR, BUF_SIZE + PAD_SIZE)) {
>> +		KUNIT_EXPECT_FALSE_MSG(kunittest,
> 
>> -	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
>> +	KUNIT_EXPECT_FALSE_MSG(kunittest,
>> +			memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))
> 
> Why the inconsistency in what a memchr_inv != NULL check gets converted to?
> 

Oh my bad. I will make this consistent.

> 
>>  
>> -static void __printf(3, 4) __init
>> -__test(const char *expect, int elen, const char *fmt, ...)
>> +static void __printf(4, 5)
>> +__test(struct kunit *kunittest, const char *expect, int elen, const char *fmt, ...)
>>  {
>>  	va_list ap;
>>  	int rand;
>>  	char *p;
>>  
>> -	if (elen >= BUF_SIZE) {
>> -		pr_err("error in test suite: expected output length %d too long. Format was '%s'.\n",
>> -		       elen, fmt);
>> -		failed_tests++;
>> -		return;
>> -	}
>> +	KUNIT_EXPECT_LT_MSG(kunittest, elen, BUF_SIZE,
>> +			"error in test suite: expected output length %d too long. Format was '%s'.\n",
>> +			elen, fmt);
> 
> And it's ok to continue with the tests when the test suite itself is
> buggy because? [*]
> 
>>  	va_start(ap, fmt);
>>  
>> @@ -112,49 +95,46 @@ __test(const char *expect, int elen, const char *fmt, ...)
>>  	 * enough and 0), and then we also test that kvasprintf would
>>  	 * be able to print it as expected.
>>  	 */
>> -	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
>> +	do_test(kunittest, BUF_SIZE, expect, elen, fmt, ap);
>>  	rand = 1 + prandom_u32_max(elen+1);
>>  	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
>> -	failed_tests += do_test(rand, expect, elen, fmt, ap);
> 
> [*] Certainly this invariant gets violated, so we (may) provide do_test
> with a buffer size larger than, well, BUF_SIZE.
> 
>>  
>> -#define test(expect, fmt, ...)					\
>> -	__test(expect, strlen(expect), fmt, ##__VA_ARGS__)
>> +#define test(kunittest, expect, fmt, ...)					\
>> +	__test(kunittest, expect, strlen(expect), fmt, ##__VA_ARGS__)
>>  
>> -static void __init
>> -test_basic(void)
>> +static void
>> +test_basic(struct kunit *kunittest)
>>  {
>>  	/* Work around annoying "warning: zero-length gnu_printf format string". */
>>  	char nul = '\0';
>>  
>> -	test("", &nul);
>> -	test("100%", "100%%");
>> -	test("xxx%yyy", "xxx%cyyy", '%');
>> -	__test("xxx\0yyy", 7, "xxx%cyyy", '\0');
>> +	test(kunittest, "", &nul);
>> +	test(kunittest, "100%", "100%%");
>> +	test(kunittest, "xxx%yyy", "xxx%cyyy", '%');
>> +	__test(kunittest, "xxx\0yyy", 7, "xxx%cyyy", '\0');
> 
> Am I reading this right that all this is simply to prepend kunittest to
> the arguments? How about just redefining the test macro so it
> automagically does that instead of all this churn? The few cases that
> use __test may need to be handled specially.
> 
>> +
>> +static void selftest(struct kunit *kunittest)
>>  {
>>  	alloced_buffer = kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
>>  	if (!alloced_buffer)
>>  		return;
>>  	test_buffer = alloced_buffer + PAD_SIZE;
>>  
>> -	test_basic();
>> -	test_number();
>> -	test_string();
>> -	test_pointer();
>> +	test_basic(kunittest);
>> +	test_number(kunittest);
>> +	test_string(kunittest);
>> +	test_pointer(kunittest);
>>  
>>  	kfree(alloced_buffer);
>>  }
> 
> Even better, since the whole thing still relies on the static variables
> test_buffer and alloced_buffer, why not just stash the struct kunit*
> that the framework passes in a file-scope static and avoid even more
> churn? Then only the newly introduce KUNIT_CHECK_* macros need to refer
> to it, and none of the existing code (or future cases) needs that piece
> of boilerplate.
> 

Yes, using file-scope static will be better. I will make this change.

> BTW, does the framework have some kind of logic that ensures nobody runs
> the printf suite twice in parallel?
> 

Brendan would have a better idea about this. But, it wouldn't be possible at boot up because KUnit only dispatches each test once. The other way for a KUnit test to be executed currently is as a module, and a module can only be loaded once until it is unloaded.

Thanks for the review.
