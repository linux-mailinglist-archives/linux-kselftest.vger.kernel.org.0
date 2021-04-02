Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96C3530D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 23:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhDBVoy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 17:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBVox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 17:44:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46F4C0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 14:44:51 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r17so5658290ilt.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Adice11UwmWvW+U6T9ZhShvoUX7I0FtvMtpHfXTd0g=;
        b=RbULyQYrBgZJQYCm10LOck1E5A+jgyKNlyofQgXi2+mN/UN2+r1i7PV4/z6oaj2VIy
         xkOUHWl0YOdc+O1oogQ2HJSsNwGom5/H/2Qzdsp4OmIaLw66UWvCWzocOguK/OcZ4DFe
         bFPXGnoqdv2YkrE9KtBII5vn8ho+AtQLiK7ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Adice11UwmWvW+U6T9ZhShvoUX7I0FtvMtpHfXTd0g=;
        b=hLZFv2LnB0i7oBhCbDs6jWDksI6Ltl8QljYewKR/HduV5xtXgr3hXOR3g+zMV20itM
         LTKUodAtLVjiO9HsPoVJbhk608kFB6D1UaV0VoCPLz6QBs/uiGLu7levX5uFbmE9jetH
         i4+NG79VhpDkIlafliMDFHdlR1nlGH9xn+QuDX2VLRf/ztROJGZqcyt2qnUM4dQPHhJI
         8wVYl8+BM33XMxc2TQg0oTbkTJk0g74qjFiCP+W7h/Nq0BXmd9R/iVxPK4tpvV1H8iZI
         iLBH/PFcpnliVsXCdb3SZwjEhDiqAvibXFS522QPbnYujpGqboX3hXm0972dVG/na1En
         n/3A==
X-Gm-Message-State: AOAM530/11Fnc3MKxyUu24FFLjfVGZnpsadbvD5m5XoL7byq2ryUQ829
        K6+vxKrencjwV1UNNPYmwzRh1g==
X-Google-Smtp-Source: ABdhPJytJaIOHiSDTFJmyHb58wcqaOZ4L9OC6M6avxtkyA1Zu0/Ah94WieinYikzakIoLu3AZFizsw==
X-Received: by 2002:a92:d382:: with SMTP id o2mr13044404ilo.94.1617399891285;
        Fri, 02 Apr 2021 14:44:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f9sm5111049iol.23.2021.04.02.14.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 14:44:50 -0700 (PDT)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3774e8c7-4183-d627-8c53-16bdc0bed6eb@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 15:44:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAGS_qxozjVfeOa42Y+v7dB0s6Ucvf8yHhRxDpficEJ9MGE-orw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/2/21 3:25 PM, Daniel Latypov wrote:
> On Fri, Apr 2, 2021 at 10:53 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 4/2/21 2:55 AM, Brendan Higgins wrote:
>>> On Thu, Mar 11, 2021 at 7:23 AM Daniel Latypov <dlatypov@google.com> wrote:
>>>>
>>>> From: Uriel Guajardo <urielguajardo@google.com>
>>>>
>>>> Add a kunit_fail_current_test() function to fail the currently running
>>>> test, if any, with an error message.
>>>>
>>>> This is largely intended for dynamic analysis tools like UBSAN and for
>>>> fakes.
>>>> E.g. say I had a fake ops struct for testing and I wanted my `free`
>>>> function to complain if it was called with an invalid argument, or
>>>> caught a double-free. Most return void and have no normal means of
>>>> signalling failure (e.g. super_operations, iommu_ops, etc.).
>>>>
>>>> Key points:
>>>> * Always update current->kunit_test so anyone can use it.
>>>>     * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
>>>>     CONFIG_KASAN=y
>>>>
>>>> * Create a new header <kunit/test-bug.h> so non-test code doesn't have
>>>> to include all of <kunit/test.h> (e.g. lib/ubsan.c)
>>>>
>>>> * Forward the file and line number to make it easier to track down
>>>> failures
>>>>
>>>> * Declare the helper function for nice __printf() warnings about mismatched
>>>> format strings even when KUnit is not enabled.
>>>>
>>>> Example output from kunit_fail_current_test("message"):
>>>> [15:19:34] [FAILED] example_simple_test
>>>> [15:19:34]     # example_simple_test: initializing
>>>> [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
>>>> [15:19:34]     not ok 1 - example_simple_test
>>>>
>>>> Co-developed-by: Daniel Latypov <dlatypov@google.com>
>>>> Signed-off-by: Daniel Latypov <dlatypov@google.com>
>>>> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
>>>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>>
>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>
>>
>> Please run checkpatch on your patches in the future. I am seeing
>> a few checkpatch readability type improvements that can be made.
>>
>> Please make changes and send v2 with Brendan's Reviewed-by.
> 
> Thanks for the catch.
> checkpatch.pl --strict should now be happy (aside from complaining
> about line wrapping)
> 
> v5 here: https://lore.kernel.org/linux-kselftest/20210402212131.835276-1-dlatypov@google.com
> 
> Note: Brendan didn't give an explicit Reviewed-by on the second patch,
> not sure if that was intentional.
> 

No worries. I applied this one as well. I was able to fix it with just
checkpatch --fix option.

All set now.

thanks,
-- Shuah

