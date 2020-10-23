Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F312970D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465126AbgJWNnO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 09:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375453AbgJWNnM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 09:43:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD3C0613CE;
        Fri, 23 Oct 2020 06:43:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b23so1295095pgb.3;
        Fri, 23 Oct 2020 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pmBXrQ+H88lZLbmY7ae4U43AsAKG0QhpFdqTk84uGF0=;
        b=KrItvfJQHQ21qy5s8Tjz16tMM+oZgp1LkXY4KLVk4d1JGLZjK/P0DIQfKJDtGV483j
         YKvyiY/gmKVMZrQPYqhPHABHp80chuYsYOgA8X06mFz1KT2iWDji57Cwby3NdAO3qvd7
         x0wcd0hjILLFqVsi4swGWFrK/Bk4A6PX9EOBfMjDsHDgKbTQb4/kwByRbIbRSVbXfSzO
         lsoOL8R3RGKzaA5vMS7Ou3rkvXXVwYTUTsigwY6lOqd6ONNl9M42HPjdCppqGIH8obZ9
         b/w+d8OsTEClwG8DMyFUaL5jludC12FBBv8zXX/zBvAzRHPUOFkg1TGfAWMoCMHJ4j+J
         OlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pmBXrQ+H88lZLbmY7ae4U43AsAKG0QhpFdqTk84uGF0=;
        b=lf6m8HIOZ8V6XMHRhKbuaUf2Jag5OmgIg3U0fVQC8wj6Su2V7Vwkw2I0ejRnln9pZ3
         Fs0E5o+aonsU4n6qADgCfVf1BcST7+P052pnsTtZObGNtRibhB5vOZgpEcZkJmtKTJ/P
         hE62DAyq2jfNlSgPp3xLumt09H6iYD5njJxsMueowvWx3nxzdSsEVJk5dQK9mSyZrSp5
         l2/YEyzjy2SizSVuKJAFETzuVGVbS7M8ZjX9zZLP+nuLdE3C7snxkO9bEvTkDuQ3pY2k
         2OgxzT0K/MooIrKDcIqgiq+kZlNwY7yQLoEM2MZmS87uqhPmzdsfRtKv8pYwVeXol/by
         Fcpg==
X-Gm-Message-State: AOAM532AqweWNa4y1RbCbUfH4lrLEX6Qlpq4qea7OJ6gILcF3wblWNuk
        IwVfnwl/drSOLswe83SerTA=
X-Google-Smtp-Source: ABdhPJxhTREG7RovyQQGCW1i9tNADzaozg3O8mnWd+ll8yyFFaHALVg+4uOpmqxfDL1Gn6kKZMpq0Q==
X-Received: by 2002:a62:2905:0:b029:15b:57ef:3356 with SMTP id p5-20020a6229050000b029015b57ef3356mr2100428pfp.36.1603460592134;
        Fri, 23 Oct 2020 06:43:12 -0700 (PDT)
Received: from [192.168.86.81] ([106.51.242.32])
        by smtp.gmail.com with ESMTPSA id d7sm2116014pgh.17.2020.10.23.06.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 06:43:11 -0700 (PDT)
Subject: Re: [PATCH v2] lib: Convert test_printf.c to KUnit
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        idryomov@gmail.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20201022151349.47436-1-98.arpi@gmail.com>
 <20201022191606.GQ4077@smile.fi.intel.com>
 <0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasmusvillemoes.dk>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <01f8ca45-60d1-ad67-f8eb-354dec411a78@gmail.com>
Date:   Fri, 23 Oct 2020 19:13:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/10/20 4:36 pm, Rasmus Villemoes wrote:
> On 22/10/2020 21.16, Andy Shevchenko wrote:
>> On Thu, Oct 22, 2020 at 08:43:49PM +0530, Arpitha Raghunandan wrote:
>>> Convert test lib/test_printf.c to KUnit. More information about
>>> KUnit can be found at:
>>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
>>> KUnit provides a common framework for unit tests in the kernel.
>>> KUnit and kselftest are standardizing around KTAP, converting this
>>> test to KUnit makes this test output in KTAP which we are trying to
>>> make the standard test result format for the kernel. More about
>>> the KTAP format can be found at:
>>> https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/.
>>> I ran both the original and converted tests as is to produce the
>>> output for success of the test in the two cases. I also ran these
>>> tests with a small modification to show the difference in the output
>>> for failure of the test in both cases. The modification I made is:
>>> - test("127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
>>> + test("127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.sin_addr, &sa.sin_addr);
>>>
>>> Original test success:
>>> [    0.591262] test_printf: loaded.
>>> [    0.591409] test_printf: all 388 tests passed
>>>
>>> Original test failure:
>>> [    0.619345] test_printf: loaded.
>>> [    0.619394] test_printf: vsnprintf(buf, 256, "%piS|%pIS", ...)
>>> wrote '127.000.000.001|127.0.0.1', expected
>>> '127-000.000.001|127.0.0.1'
>>> [    0.619395] test_printf: vsnprintf(buf, 25, "%piS|%pIS", ...) wrote
>>> '127.000.000.001|127.0.0.', expected '127-000.000.001|127.0.0.'
>>> [    0.619396] test_printf: kvasprintf(..., "%piS|%pIS", ...) returned
>>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>> [    0.619495] test_printf: failed 3 out of 388 tests
>>>
>>> Converted test success:
>>>     # Subtest: printf-kunit-test
>>>     1..1
>>>     ok 1 - selftest
>>> ok 1 - printf-kunit-test
>>>
>>> Converted test failure:
>>>     # Subtest: printf-kunit-test
>>>     1..1
>>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
>>> vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote
>>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:82
>>> vsnprintf(buf, 5, "%pi4|%pI4", ...) wrote '127.', expected '127-'
>>>     # selftest: EXPECTATION FAILED at lib/printf_kunit.c:118
>>> kvasprintf(..., "%pi4|%pI4", ...) returned
>>> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>>>     not ok 1 - selftest
>>> not ok 1 - printf-kunit-test
>>
>> Not bad. Rasmus, what do you think?
> 
> Much better, but that '1..1' and reporting the entire test suite as 1
> single (failing or passing) test is (also) a regression. Look at the
> original
> 
>>> [    0.591409] test_printf: all 388 tests passed
> 
> or
> 
>>> [    0.619495] test_printf: failed 3 out of 388 tests
> 
> That's far more informative, and I'd prefer if the summary information
> (whether in the all-good case or some-failing) included something like
> this. In particular, I have at some point spotted that I failed to
> properly hook up a new test case (or perhaps failed to re-compile, or
> somehow still ran the old kernel binary, don't remember which it was) by
> noticing that the total number of tests hadn't increased. The new output
> would not help catch such PEBKACs.
> 
> Rasmus
> 

Splitting the test into multiple test cases in KUnit will display the number and name of tests that pass or fail. This will be similar to the lib/list-test.c test as can be seen here: https://elixir.bootlin.com/linux/latest/source/lib/list-test.c. I will work on this for the next version of this patch.
