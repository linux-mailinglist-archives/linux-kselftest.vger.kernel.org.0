Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB30474D61
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 22:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhLNVzQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 16:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhLNVzQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 16:55:16 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E3AC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 13:55:15 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r26so29013636oiw.5
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 13:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8c5HOWwyfiupLvFyXAzkTvgPJTtnMmzNjIltdHaPf40=;
        b=RvVDKzYKv1p3n2MmPVLRBMSDXGE0pA3Uym8J1ZJfZvBsAn91x0x9MUEeCH2Pcx/mGI
         U5HS5EuTcaZErO731YxWfjJ3d/87/99pdhLYIHnouSAHJ5G/W7ThB5JMbgMhys9QMoxy
         rlYoL5lzuA6kCa/Ehuq2cS1ULS5Fj5+sfuncU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8c5HOWwyfiupLvFyXAzkTvgPJTtnMmzNjIltdHaPf40=;
        b=al1ZVXs6t4G0GD0AzpGUK7CLb7Jn6F/IjasLdUw4G00UAlWFmXlj9dXqKzOLCb7Mzr
         In/Zg8m13Re3MsDmzCFHr/TokQoUxy+9fvslQrBfE21CZL6kTK5j7EDwauxMKj82a5Cj
         JhazFkwvoyWtjtDYxS6K14sNMW2WqJfh9TNN/7LBzznYrUT95KySO3GGsdzHosppcATR
         e4l3QZRdk7UWtF3hceqY7ifhW4kTvxtlpGp6WwiR0d/APXlVqgJYiuu4yuzmB8XqLgmd
         YttNW4AUiscLFRE9ymsR24p2zkZ2IohsSSPNrmeLUDOpngoXnicaPDB164qEEtNUJLo5
         cztg==
X-Gm-Message-State: AOAM530RtNjklRoxOssBLSntGmLbQ9cDlzZkOW0M+D9t3kF18cyc+LxW
        +KWj70JPIwe8KSNmfz+7kiubBQ==
X-Google-Smtp-Source: ABdhPJwUh1lvfglV/GGiMre70dtStcj/zuamo8qUaIigTb/87o6FThfNLQHyZb9gon4A33Hj+66JNw==
X-Received: by 2002:a05:6808:2014:: with SMTP id q20mr35724101oiw.9.1639518915272;
        Tue, 14 Dec 2021 13:55:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s13sm4950otv.34.2021.12.14.13.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 13:55:15 -0800 (PST)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b64a7830-d21a-fc61-b5ef-8938a97ce878@linuxfoundation.org>
Date:   Tue, 14 Dec 2021 14:55:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4dc1dd00-320b-e625-83db-70184141e9c9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/14/21 2:28 PM, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 12/14/2021 12:10 PM, Shuah Khan wrote:
> 
>>
>> Let's not add one more __cpuid() define to the individual tests.
>> We so far have:
>>
>> tools/testing/selftests/vm/pkey-x86.h
>> selftests/x86/corrupt_xstate_header.c
>>
>> Let's move the defines to kselftest.h and remove all these duplicate
>> defines.
>>
>> For now you could include vm/pkey-x86.h just to fix the build error
>> and do the proper cleanup.
> 
> Thank you so much for taking a look. We actually do have an alternative fix that could be considered for the other users of __cpuid(). Instead of another clone of the kernel's __cpuid() the fix includes cpuid.h and uses the existing __cpuid_count() from it.
> 
> Please see:
> https://lore.kernel.org/linux-sgx/20211204202355.23005-1-jarkko@kernel.org/
> 

This looks good to me.

> We decided against the above fix using __cpuid_count() because we could not explain why all the existing users of __cpuid() implement their own and decided to follow the custom instead ...
> 

Most likely, copy and paste and taking the easy route. I looked at a couple of
defines and I dont't see a difference. If there are differences, that would be
a bigger concern. The whole idea of not having duplicates is that we don't have
bugs in these duplicates.

> Do you see any problem with including cpuid.h into a selftest? If not, then we can go back to our original fix of this issue and I could also submit a change to remove all the __cpuid() clones and replace them with the library's __cpuid_count().
> 

There are no problems including cpuid.h - where is this though. I couldn't find
it in my cscope search?

thanks,
-- Shuah

