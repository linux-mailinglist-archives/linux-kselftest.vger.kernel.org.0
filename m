Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590CA440566
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Oct 2021 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhJ2WZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 18:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJ2WZd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 18:25:33 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48F9C061570
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 15:23:03 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h2so12093974ili.11
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p7UKH93nqJbnjgzvxtzNJ+VSIOto15SRM0Q3/xyJtUY=;
        b=UQpUd8XdbcbkVLI6okUt3F/7VRB6A4TEUtSGndWNft3ohARwNu0RfycSz6ymvo7ogl
         hjmQCJuTukPQZvnajmoOFhB1m9sz43UCNATDW/Vmz8B9QxZmu9th2wzVlV3I+cADgksN
         QDOP65GK0/77RXP9qoMA3iyaK5SPLtdSWF77I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p7UKH93nqJbnjgzvxtzNJ+VSIOto15SRM0Q3/xyJtUY=;
        b=MxtLp0xjA4VcoVsZuNPFOXjzDZFgtmWovPUuCPEHE3GUos8J1yqI0k4L4IO4nD/h8T
         MhmTwKmKoxXWwoLh1RGJdzzsFdUOHWLPxLkubZ0Rau2zkK7HJhdOSquH/7vef6g0Lv6K
         zl2i8fsdmPs2ZznVJZTjSavQfF2Gbaax9bgZoxhN1NFyTrvP0sKITJ5SWkxU1OI10yWv
         6eF71Pa/qUsSdo4/MJ5Bu88x68aguk9sc45b+Nw1KzTxY2g9+RVIPMGb2hh2wPSx1E7U
         Y7uebOS2sUpraUfZ11G3meRi+ijD/u6Ym3CJ2jXwZDK+Ewi60bUzw4/32P2DIsBVan9z
         x/Cw==
X-Gm-Message-State: AOAM533xmM+bbf0+7qbXmgow45BAg3yPijXDL0Tvt6iwtDAjVxb2m7qu
        kAeCJgSmSX3FwpZxQQKtgZY5Sw==
X-Google-Smtp-Source: ABdhPJx+HOeT+MydkmuJ4CJ7iIG9afL2dqYnp3PVn5b6tu3j8GQvdeJblZHo4tkQzShaw9+xYY72aw==
X-Received: by 2002:a05:6e02:1aa5:: with SMTP id l5mr8992834ilv.268.1635546182922;
        Fri, 29 Oct 2021 15:23:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l14sm4354841iow.27.2021.10.29.15.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 15:23:02 -0700 (PDT)
Subject: Re: [PATCH] selftests: kselftest.h: mark functions with 'noreturn'
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211029114312.1921603-1-anders.roxell@linaro.org>
 <834d18b6-4106-045f-0264-20e54edf47bc@linuxfoundation.org>
 <CAKwvOdk8D5=AxzSpqjvXJc4XXL8CA7O=WY-LW0mZb3eQRK_EWg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0beef0a1-cfa0-b653-fbc6-41ba707c2926@linuxfoundation.org>
Date:   Fri, 29 Oct 2021 16:23:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdk8D5=AxzSpqjvXJc4XXL8CA7O=WY-LW0mZb3eQRK_EWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/29/21 4:08 PM, Nick Desaulniers wrote:
> On Fri, Oct 29, 2021 at 11:19 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 10/29/21 5:43 AM, Anders Roxell wrote:
>>> When building kselftests/capabilities the following warning shows up:
>>>
>>> clang -O2 -g -std=gnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o test_execve
>>> test_execve.c:121:13: warning: variable 'have_outer_privilege' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>>>           } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
>>>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> test_execve.c:136:9: note: uninitialized use occurs here
>>>           return have_outer_privilege;
>>>                  ^~~~~~~~~~~~~~~~~~~~
>>> test_execve.c:121:9: note: remove the 'if' if its condition is always true
>>>           } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
>>>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> test_execve.c:94:27: note: initialize the variable 'have_outer_privilege' to silence this warning
>>>           bool have_outer_privilege;
>>>                                    ^
>>>                                     = false
>>>
>>> Rework so all the ksft_exit_*() functions have attribue
>>> '__attribute__((noreturn))' so the compiler knows that there wont be
>>> any return from the function. That said, without
>>> '__attribute__((noreturn))' the compiler warns about the above issue
>>> since it thinks that it will get back from the ksft_exit_skip()
>>> function, which it wont.
>>> Cleaning up the callers that rely on ksft_exit_*() return code, since
>>> the functions ksft_exit_*() have never returned anything.
>>>
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>
>> Lot of changes to fix this warning. Is this necessary? I would
>> like to explore if there is an easier and localized change that
>> can fix the problem.
> 
> via `man 3 exit`:
> ```
> The  exit() function causes normal process termination ...
> ...
> RETURN VALUE
>         The exit() function does not return.
> ```
> so seeing `ksft_exit_pass`, `ksft_exit_fail`, `ksft_exit_fail_msg`,
> `ksft_exit_xfail`, `ksft_exit_xpass`, and `ksft_exit_skip` all
> unconditional call `exit` yet return an `int` looks wrong to me on
> first glance. So on that point this patch and its resulting diffstat
> LGTM.
> 
> That said, there are many changes that explicitly call `ksft_exit`
> with an expression; are those setting the correct exit code? Note that
> ksft_exit_pass is calling exit with KSFT_PASS which is 0.  So some of
> the negations don't look quite correct to me.  For example:
> 
> -       return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
> +       ksft_exit(!ksft_get_fail_cnt());
> 
> so if ksft_get_fail_cnt() returns 0, then we were calling
> ksft_exit_pass() which exited with 0. Now we'd be exiting with 1?
> 

Right. This is another concern I have that the tests will return
a different values and the wrapper will interpret them as failures.

So his doesn't look like the right change to fix the problem.

thanks,
-- Shuah
