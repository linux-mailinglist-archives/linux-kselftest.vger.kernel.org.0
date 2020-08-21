Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F1624D4CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 14:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHUMUh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Aug 2020 08:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgHUMUA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Aug 2020 08:20:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C75C061385
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Aug 2020 05:19:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y2so1637020ljc.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Aug 2020 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7lm7viw2YMUXjgsgP6el/CrtyEJ66fPWspB4g27Z+UE=;
        b=OLNZ2C+hzQWkN05HvaTkNkBWtQBcEfyJDGRYk69lhSrQ0LO5xRhea1eMU+uFFFGfCo
         QwFok4KZiwuilU/CnFNIz2ZeriSLhDMvF2SR9EjMqSuBx1OFNEAQ7CeaUbOauKutxSTI
         R1t8RXyh02wQBHbCUM3GatxV04t6/RhjNXuIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7lm7viw2YMUXjgsgP6el/CrtyEJ66fPWspB4g27Z+UE=;
        b=NZx5ZJ2b8vfullWQtWcd5xczJmEn5Y7Fw2zE/KjDT6ef1pTv/uoJU1xSFieM/sZGKU
         Y9J6LJL8QzIyEW/jvIx2uzmAuAqtSNqPXofLNVEePeM7MpxIf1FofbskLWF+JtpyF1jO
         WiVUKQw90WO0P25OfGNknRVupApapz+mASqj8hR59Vehpay9qBmtG4ADRLdiT/lySK4y
         oSkhW2TC73+d5ndXBEF/tFQ3RvAATIAFoiKBdhPFutDNYOShc4Q9RihaCS+oA+rNoYyw
         OmPs65YiHxvp90rRS1kHeLo/EESOldaabnKfNiomBkL5QJtw6JQ0g70Hc5aqW7mwrwHG
         d6mA==
X-Gm-Message-State: AOAM531dArcBCfhq+r83YDttyx5Wc3JwB5bmtW2i60sh6EQWS5H3gB1Y
        OWJMbk3ievlOjJ5foJFwRJ9/9g==
X-Google-Smtp-Source: ABdhPJzRsKTLZwqYP+o27aYkSZiasOfSDYCiGBa3/ktDCA08ZIn/QZNgZm7fZnvFWrNFXtcbYmVu1g==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr1458304ljj.199.1598012393003;
        Fri, 21 Aug 2020 05:19:53 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s127sm350943lja.119.2020.08.21.05.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 05:19:52 -0700 (PDT)
Subject: Re: [PATCH] lib: Convert test_printf.c to KUnit
To:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200817043028.76502-1-98.arpi@gmail.com>
 <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
 <20200821113710.GA26290@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4e26f696-3b50-d781-00fd-7fc6fdc2c3eb@rasmusvillemoes.dk>
Date:   Fri, 21 Aug 2020 14:19:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821113710.GA26290@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21/08/2020 13.37, Petr Mladek wrote:
> On Mon 2020-08-17 09:06:32, Rasmus Villemoes wrote:
>> On 17/08/2020 06.30, Arpitha Raghunandan wrote:
>>> Converts test lib/test_printf.c to KUnit.
>>> More information about KUnit can be found at
>>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
>>> KUnit provides a common framework for unit tests in the kernel.
>>
>> So I can continue to build a kernel with some appropriate CONFIG set to
>> y, boot it under virt-me, run dmesg and see if I broke printf? That's
>> what I do now, and I don't want to have to start using some enterprisy
>> framework.
> 
> I had the same concern. I have tried it.

Thanks for doing that and reporting the results.

>     #> modprobe printf_kunit
> 
> produced the following in dmesg:
> 
> [   60.931175] printf_kunit: module verification failed: signature and/or required key missing - tainting kernel
> [   60.942209] TAP version 14
> [   60.945197]     # Subtest: printf-kunit-test
> [   60.945200]     1..1
> [   60.951092]     ok 1 - selftest
> [   60.953414] ok 1 - printf-kunit-test
> 
> I could live with the above. Then I tried to break a test by the following change:
> 
> 
> diff --git a/lib/printf_kunit.c b/lib/printf_kunit.c
> index 68ac5f9b8d28..1689dadd70a3 100644
> --- a/lib/printf_kunit.c
> +++ b/lib/printf_kunit.c
> @@ -395,7 +395,7 @@ ip4(struct kunit *kunittest)
>         sa.sin_port = cpu_to_be16(12345);
>         sa.sin_addr.s_addr = cpu_to_be32(0x7f000001);
>  
> -       test(kunittest, "127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
> +       test(kunittest, "127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
>         test(kunittest, "127.000.000.001|127.0.0.1", "%piS|%pIS", &sa, &sa);
>         sa.sin_addr.s_addr = cpu_to_be32(0x01020304);
>         test(kunittest, "001.002.003.004:12345|1.2.3.4:12345", "%piSp|%pISp", &sa, &sa);
> 
> 
> It produced::
> 
> [   56.786858] TAP version 14
> [   56.787493]     # Subtest: printf-kunit-test
> [   56.787494]     1..1
> [   56.788612]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:76
>                    Expected memcmp(test_buffer, expect, written) == 0, but
>                        memcmp(test_buffer, expect, written) == 1
>                        0 == 0
>                vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> [   56.795433]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:76
>                    Expected memcmp(test_buffer, expect, written) == 0, but
>                        memcmp(test_buffer, expect, written) == 1
>                        0 == 0
>                vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.000.001|127', expected '127-000.000.001|127'
> [   56.800909]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:108
>                    Expected memcmp(p, expect, elen+1) == 0, but
>                        memcmp(p, expect, elen+1) == 1
>                        0 == 0
>                kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> [   56.806497]     not ok 1 - selftest
> [   56.806497] not ok 1 - printf-kunit-test
> 
> while the original code would have written the following error messages:
> 
> [   95.859225] test_printf: loaded.
> [   95.860031] test_printf: vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> [   95.862630] test_printf: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote '127.0', expected '127-0'
> [   95.864118] test_printf: kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> [   95.866589] test_printf: failed 3 out of 388 tests
> 
> 
> Even the error output is acceptable for me.

Urgh. Yeah, perhaps, but the original is much more readable; it really
doesn't matter that a memcmp() fails to compare equal to 0, that's
merely how we figured out that the output was wrong.


I am just curious why
> the 2nd failure is different:
> 
>    + original code: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote '127.0', expected '127-0'
>    + kunit code: vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.000.001|127', expected '127-000.000.001|127'   

That's by design. If you read the code, there's a comment that says we
do every test case four times: With a buffer that is large enough to do
the whole output, with a 0 size buffer (that's essential to allowing
kasprintf to know how much to allocate),  with kvasprintf - but also
with a buffer size that's guaranteed to ensure the output gets truncated
somewhere. And that size is chosen randomly - I guess one could test
every single buffer size between 0 and elen+1, but that's overkill.

Now I should probably have made the tests deterministic in the sense of
getting a random seed for a PRNG, printing that seed and allowing a
module parameter to set the seed in order to repeat the exact same
tests. But so far I haven't really seen any bugs caught by test_printf
which would have been easier to fix with that.

The reason I added that "chop it off somewhere randomly" was, IIRC, due
to some %p extensions that behaved rather weirdly depending on whether
there was enough room left or not, but I fixed those bugs before
creating test_printf (and they were in turn the reason for creating
test_printf). See for example 41416f2330, where %pE at the beginning of
the format string would work ok, but if anything preceded it and the
buffer was too small we'd crash.

> 
> I am also a bit scared by the following note at
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/start.html#running-tests-without-the-kunit-wrapper
> 
>    "KUnit is not designed for use in a production system, and it’s
>    possible that tests may reduce the stability or security of the
>    system."
> 
> What does it mean thay it might reduce stability or security?
> Is it because the tests might cause problems?
> Or because the kunit framework modifies functionality of the running
> system all the time?

Hm, yeah, that sounds a little frightening.

Rasmus
