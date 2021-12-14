Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499D1474E60
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 23:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhLNW7c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 17:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbhLNW7c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 17:59:32 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11C4C06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 14:59:31 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y16so27009263ioc.8
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 14:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HfidycnwylUlQ+qYe9z7uM3KoYdpX90Ppicd/jnVc0g=;
        b=BgI6qCDDUMJuxi/+7XkZdPNA6SENFzDXn3LdpyYmnorXH/c8l29UdLd3AcOjiae6xO
         q25gSrfvjb1Wb+U3AO65gwJI6GSeCyOQIr7g8jE1gKMxiIvuUIzhtA8FXbwjeNSmFAhM
         D2iq+OWokFxXdezk2tW+Ohps+Ng3aaha7YnhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HfidycnwylUlQ+qYe9z7uM3KoYdpX90Ppicd/jnVc0g=;
        b=l1eEUFRdqkn3YWKbkkBfz7TXFUrdGvLicLKz0fUCvk01+rcUW49WgMrt3plRDv8+2a
         oM9qIJ0K5WXffgSip3fiSrsQGAfiUFCZ0LZih+/QIXPBBzwntmtROhRWCovqR/Hana6W
         4cbZWTovsfYkwqv8imFGmnXHaX3C8N5207YoSyWkMNtdXGyN+rWi55JiakckLGW210Er
         NrzHvz7X5rbAvgxf9E51nym8kBC1ULjvTK3r/ty7zcCtQ0IOHtR7aKrcEvpisc6lvoYI
         91QDfVtyw6+tiopkI6VRGVGspkIJ4Oq1CIUXiZWVKyHpq9Wq4KpbXlZpdFKH/oXR7CFp
         lYxQ==
X-Gm-Message-State: AOAM533QyLDJovV6CHFBeBlH24KqB8TNW+ptGCXybHYJXKib3LQsaE52
        iPV/MbyKrqOIKOE10xUNxm9cgg==
X-Google-Smtp-Source: ABdhPJyNq+2N/a/hVTa53CCubQgkEi8/T0MK5PoZJsDWnSDVNPSt1HQvm6vMdgIuxibMr4IKTVpz1Q==
X-Received: by 2002:a6b:b7c8:: with SMTP id h191mr5161673iof.155.1639522771178;
        Tue, 14 Dec 2021 14:59:31 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r14sm98308ill.70.2021.12.14.14.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 14:59:30 -0800 (PST)
Subject: Re: [PATCH V2] selftests/sgx: Fix build error caused by missing
 dependency
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, jarkko@kernel.org,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <de2a262e97e7b173548b909a608e9e99aab38e9d.1639509500.git.reinette.chatre@intel.com>
 <8b7c98f4-f050-bc1c-5699-fa598ecc66a2@linuxfoundation.org>
 <4dc1dd00-320b-e625-83db-70184141e9c9@intel.com>
 <b64a7830-d21a-fc61-b5ef-8938a97ce878@linuxfoundation.org>
 <2269d5a5-f388-773f-c6ec-758003ae2e59@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <63293c72-55ca-9446-35eb-74aff4c8ba5d@linuxfoundation.org>
Date:   Tue, 14 Dec 2021 15:59:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2269d5a5-f388-773f-c6ec-758003ae2e59@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/14/21 3:27 PM, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 12/14/2021 1:55 PM, Shuah Khan wrote:
>> On 12/14/21 2:28 PM, Reinette Chatre wrote:
>>> Hi Shuah,
>>>
>>> On 12/14/2021 12:10 PM, Shuah Khan wrote:
>>>
>>>>
>>>> Let's not add one more __cpuid() define to the individual tests.
>>>> We so far have:
>>>>
>>>> tools/testing/selftests/vm/pkey-x86.h
>>>> selftests/x86/corrupt_xstate_header.c
>>>>
>>>> Let's move the defines to kselftest.h and remove all these duplicate
>>>> defines.
>>>>
>>>> For now you could include vm/pkey-x86.h just to fix the build error
>>>> and do the proper cleanup.
>>>
>>> Thank you so much for taking a look. We actually do have an alternative fix that could be considered for the other users of __cpuid(). Instead of another clone of the kernel's __cpuid() the fix includes cpuid.h and uses the existing __cpuid_count() from it.
>>>
>>> Please see:
>>> https://lore.kernel.org/linux-sgx/20211204202355.23005-1-jarkko@kernel.org/
>>>
>>
>> This looks good to me.
> 
> Thank you very much for taking a look.
> 
>>
>>> We decided against the above fix using __cpuid_count() because we could not explain why all the existing users of __cpuid() implement their own and decided to follow the custom instead ...
>>>
>>
>> Most likely, copy and paste and taking the easy route. I looked at a couple of
>> defines and I dont't see a difference. If there are differences, that would be
>> a bigger concern. The whole idea of not having duplicates is that we don't have
>> bugs in these duplicates.
>>
>>> Do you see any problem with including cpuid.h into a selftest? If not, then we can go back to our original fix of this issue and I could also submit a change to remove all the __cpuid() clones and replace them with the library's __cpuid_count().
>>>
>>
>> There are no problems including cpuid.h - where is this though. I couldn't find
>> it in my cscope search?
> 
> On my system it arrived via user space's libgcc-dev package. This does not seem to be the first time including files from this source - I did a quick check and from what I can tell existing includes like stdarg.h, stdbool.h, stdatomic.h, unwind.h, x86intrin.h ... arrive via libgcc-dev.
> 
> Do you still find that cpuid.h is ok to include?
> 
> Reinette

Yes. I found it on my system as well.

/usr/lib/llvm-13/lib/clang/13.0.0/include/cpuid.h
/usr/lib/llvm-12/lib/clang/12.0.1/include/cpuid.h
/usr/lib/gcc/x86_64-linux-gnu/11/include/cpuid.h
/usr/lib/gcc/x86_64-linux-gnu/10/include/cpuid.h

No problems using it.

thanks,
-- Shuah


