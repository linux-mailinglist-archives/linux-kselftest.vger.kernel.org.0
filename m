Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C6F352F9B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 21:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhDBTT1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 15:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbhDBTTZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 15:19:25 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94FBC06178A
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 12:19:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h7so5360814ilj.8
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B3hYnXq+a5OaKLtU6Jy2TeYxs2K0ko5s/dXgeYpBVcE=;
        b=A5xO6uafIT9A+juHvaUU7CxFX2unJHzu1TluNL0EtnKFL/vhlrpzO73IEUIo7OLnt3
         qUhV7hI/qwsVnk0kcXAsoiEalm6XyGTagctN0wpYZvrZKhvYMeJ1TbSVunV/yASU4/5v
         xueenwaoexXYyyYd3xOZc6CPnrUkOwQM+0f5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B3hYnXq+a5OaKLtU6Jy2TeYxs2K0ko5s/dXgeYpBVcE=;
        b=ZW1MZltRv7C3O40aXvKMKvJEMrLr/qvq/jltqzlH3Y5oR8Hr2HWhxhXPnacasIAUrM
         05EOmcmDICsE+qX6cKDNIDWKsIQuatChTpSIKJ00CLtAd79eU+gwWZa1cU0EpX1buWnP
         2l2HbMT9CTZhK7OB1XfsFQ16V+s8jD4HJ8bgjSR0PHQeyctl6HhOHgVwzRMzha0FT2jE
         1JbDfglxVo2EIxZJARlstkIhaetw6lcvniTK5a4TwEBMiCPD4Zs17RVWjH2TcDPqleUd
         zQYLFvkot+IQjaUTVQ1NXcMZ6dwrBk1UEddQUyDxafkE4JZi4oHmOXlbXSZrpMxJoWMn
         8WTw==
X-Gm-Message-State: AOAM532VrX4TpCaBsOIDW+9Xnlu22JBL49yo/ecl2YzGGO3L1biddkGF
        SAlyXekd0IuHDeWhULehzM2NRw==
X-Google-Smtp-Source: ABdhPJz9rOrQm3Y5P8b/yt9FN6hXeyPNZBCog0yGsua8kLwbYOmtcAPAU7aqNGFP62nWY6cqGf9Ivw==
X-Received: by 2002:a05:6e02:188c:: with SMTP id o12mr11707055ilu.143.1617391160405;
        Fri, 02 Apr 2021 12:19:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c18sm4594507ild.37.2021.04.02.12.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 12:19:20 -0700 (PDT)
Subject: Re: [PATCH] kunit: make KUNIT_EXPECT_STREQ() quote values, don't
 print literals
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210205221808.1966010-1-dlatypov@google.com>
 <CAFd5g44PL+DrN6+0bw-oYQCjCSR-f4Y0=QZL9DsSO-3hKLsFzw@mail.gmail.com>
 <9f5df593-6584-b7d4-3b6e-ad77ee6f8760@linuxfoundation.org>
 <CAGS_qxqE9btMn639uCgDoiqO6PNnNJzqyLA4Vj+b6Ccjhpkbfg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ec95c1b5-7273-9f0b-ad1f-f41e818eaf6f@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 13:19:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAGS_qxqE9btMn639uCgDoiqO6PNnNJzqyLA4Vj+b6Ccjhpkbfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/2/21 1:09 PM, Daniel Latypov wrote:
> On Fri, Apr 2, 2021 at 10:47 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 4/2/21 3:35 AM, Brendan Higgins wrote:
>>> On Fri, Feb 5, 2021 at 2:18 PM Daniel Latypov <dlatypov@google.com> wrote:
>>>>
>>>> Before:
>>>>>    Expected str == "world", but
>>>>>        str == hello
>>>>>        "world" == world
>>>>
>>>> After:
>>>>>    Expected str == "world", but
>>>>>        str == "hello"
>>>> <we don't need to tell the user that "world" == "world">
>>>>
>>>> Note: like the literal ellision for integers, this doesn't handle the
>>>> case of
>>>>     KUNIT_EXPECT_STREQ(test, "hello", "world")
>>>> since we don't expect it to realistically happen in checked in tests.
>>>> (If you really wanted a test to fail, KUNIT_FAIL("msg") exists)
>>>>
>>>> In that case, you'd get:
>>>>>    Expected "hello" == "world", but
>>>> <output for next failure>
>>>>
>>>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
>>>
>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>
>>
>> Hi Daniel,
>>
>> Please run checkpatch on your patches in the future. I am seeing
>> a few checkpatch readability type improvements that can be made.
>>
>> Please make changes and send v2 with Brendan's Reviewed-by.
> 
> Are there some flags you'd like me to pass to checkpatch?
> 
> $ ./scripts/checkpatch.pl --git HEAD
> total: 0 errors, 0 warnings, 42 lines checked
> 

My commit script uses --strict which shows readability errors.

> Commit f66884e8b831 ("kunit: make KUNIT_EXPECT_STREQ() quote values,
> don't print literals") has no obvious style problems and is ready for
> submission.
> 
> I just rebased onto linus/master again since I know checkpatch.pl's
> default behavior had changed recently, but I didn't see any errors
> there.
> 
> I know this commit made some lines go just over 80 characters, so
> $ ./scripts/checkpatch.pl --max-line-length=80 --git HEAD
> ...
> total: 0 errors, 4 warnings, 42 lines checked
> 

Don't worry about line wrap warns. I just ignore them. :)

thanks,
-- Shuah



