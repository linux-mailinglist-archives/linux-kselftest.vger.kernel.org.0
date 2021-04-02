Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167E13530E0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 23:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBVrk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 17:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBVrj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 17:47:39 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2525EC0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 14:47:38 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u2so5646904ilk.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tltgo4wOB5veD6Atp560I36vsQKrOOIkKptJK7NQ6JA=;
        b=MlxLjTyMB0BGt61VkFDZIaswz3rwNGl9NBIthdNc3yRe2Gx/5RcXbAjLFyTFLwMOHi
         UVzFur2AgcAjFtQuda4YkA97qQP2Y6v4Axhe178PTYWutusYVXSv/1lKJgbvAnS4Eq/1
         9mZEVM+IEHJl9Be2cUj/tiuj51M6nFuDMjl1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tltgo4wOB5veD6Atp560I36vsQKrOOIkKptJK7NQ6JA=;
        b=DpnQ03XNH1h5wE7d4+oPi2z+ZHCrSo9IFGPqp3W8p9sGAB6ijACcBkS5EieTKwvFxd
         DrahdPKinJ44vBOWw5rmTMryXeOOWoEYlxoem1+genufXU8wZUd7FZZm7R/JjiJD6XsD
         8+bOk+v4ihHKuNOIzc7v7lBMcE4pee+rY/k6wbbRIhBZMAUpg1myokftpWsPk9c/rqtN
         PeD9aBpDnqN9rRxPPLGP5TcOGpCMB4/u8LRZo9mSLuwOOq7zYbykibUBaekspgU4w6YL
         d6qortMZ/yFRkADYqqFltIdG6T+i8/9L92S1GLG15bI80X+mW/K1Sbl7B8QnE3rm8/jP
         ldTA==
X-Gm-Message-State: AOAM530LuqlRpja+S0J6MFsBwAiwNPDUTQUumDOMZNdKeYTDPWqlA1GY
        /YBa/QLpfCsBGgNjTm8ZM0QD+g==
X-Google-Smtp-Source: ABdhPJyiV8RC361hxU1a7DYCX4IVApwcK/UQylGOjeeE+KvzsMk/LHdjCX+7XEil5To3Z5Qt3oSg/A==
X-Received: by 2002:a92:4452:: with SMTP id a18mr11548229ilm.46.1617400057568;
        Fri, 02 Apr 2021 14:47:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x3sm4734952ilg.2.2021.04.02.14.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 14:47:37 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] kunit: support failure from dynamic analysis tools
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Uriel Guajardo <urielguajardo@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210311152314.3814916-1-dlatypov@google.com>
 <20210311152314.3814916-2-dlatypov@google.com>
 <CAFd5g46fy_9mPH6AihwUf5GW7aTJ=ecvmD0S266EKtNtweSOcg@mail.gmail.com>
 <16fe1cc0-5819-986d-9065-433a80783edb@linuxfoundation.org>
 <CAGS_qxozjVfeOa42Y+v7dB0s6Ucvf8yHhRxDpficEJ9MGE-orw@mail.gmail.com>
 <3774e8c7-4183-d627-8c53-16bdc0bed6eb@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <570d4758-8891-2423-fd37-92f69fbb2e1d@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 15:47:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3774e8c7-4183-d627-8c53-16bdc0bed6eb@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/2/21 3:44 PM, Shuah Khan wrote:
> On 4/2/21 3:25 PM, Daniel Latypov wrote:
>> On Fri, Apr 2, 2021 at 10:53 AM Shuah Khan <skhan@linuxfoundation.org> 
>> wrote:
>>>
>>> On 4/2/21 2:55 AM, Brendan Higgins wrote:
>>>> On Thu, Mar 11, 2021 at 7:23 AM Daniel Latypov <dlatypov@google.com> 
>>>> wrote:
>>>>>
>>>>> From: Uriel Guajardo <urielguajardo@google.com>
>>>>>
>>>>> Add a kunit_fail_current_test() function to fail the currently running
>>>>> test, if any, with an error message.
>>>>>
>>>>> This is largely intended for dynamic analysis tools like UBSAN and for
>>>>> fakes.
>>>>> E.g. say I had a fake ops struct for testing and I wanted my `free`
>>>>> function to complain if it was called with an invalid argument, or
>>>>> caught a double-free. Most return void and have no normal means of
>>>>> signalling failure (e.g. super_operations, iommu_ops, etc.).
>>>>>
>>>>> Key points:
>>>>> * Always update current->kunit_test so anyone can use it.
>>>>>     * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated 
>>>>> it for
>>>>>     CONFIG_KASAN=y
>>>>>
>>>>> * Create a new header <kunit/test-bug.h> so non-test code doesn't have
>>>>> to include all of <kunit/test.h> (e.g. lib/ubsan.c)
>>>>>
>>>>> * Forward the file and line number to make it easier to track down
>>>>> failures
>>>>>
>>>>> * Declare the helper function for nice __printf() warnings about 
>>>>> mismatched
>>>>> format strings even when KUnit is not enabled.
>>>>>
>>>>> Example output from kunit_fail_current_test("message"):
>>>>> [15:19:34] [FAILED] example_simple_test
>>>>> [15:19:34]     # example_simple_test: initializing
>>>>> [15:19:34]     # example_simple_test: 
>>>>> lib/kunit/kunit-example-test.c:24: message
>>>>> [15:19:34]     not ok 1 - example_simple_test
>>>>>
>>>>> Co-developed-by: Daniel Latypov <dlatypov@google.com>
>>>>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
>>>>> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
>>>>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>>>
>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>>
>>>
>>> Please run checkpatch on your patches in the future. I am seeing
>>> a few checkpatch readability type improvements that can be made.
>>>
>>> Please make changes and send v2 with Brendan's Reviewed-by.
>>
>> Thanks for the catch.
>> checkpatch.pl --strict should now be happy (aside from complaining
>> about line wrapping)
>>
>> v5 here: 
>> https://lore.kernel.org/linux-kselftest/20210402212131.835276-1-dlatypov@google.com 
>>
>>
>> Note: Brendan didn't give an explicit Reviewed-by on the second patch,
>> not sure if that was intentional.
>>
> 
> No worries. I applied this one as well. I was able to fix it with just
> checkpatch --fix option.
> 

Clarification. Applied 1/2 - I will wait for Brendan's ack on 2/2

thanks,
-- Shuah
