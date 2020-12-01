Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF42CAFF7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 23:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgLAW3Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 17:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgLAW3X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 17:29:23 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B731C0613D4
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Dec 2020 14:28:43 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id r17so3290227ilo.11
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Dec 2020 14:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zEVORstsrTaSUgGGMeR0Tq7V6fCGhtA2/JQrS+CPcPM=;
        b=P1DviP74adgMmlwWKQrywJMta3DKhYPt7EEAf7M9nSMiOTTKSo2CvaGYxrVV4kEnl/
         B42RELckfkTh6KC+dDfnenfHzx2WM5MoeqWh6UmsCv0d+EE93QvFCF2kaHKBX/lpIOZb
         KrmZNE56Y3CIOeQaCnp6rLdZhw2c0pi3aiHHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zEVORstsrTaSUgGGMeR0Tq7V6fCGhtA2/JQrS+CPcPM=;
        b=uk7lotDfUPa0E58I5rjN7qhW8qafI6y4SpFd09HJZtBk5NRsNKTk3K1plY1tnWaZF1
         x7rPOYt0mSTjskpoH3q86TfqPDgIyh/GUVnk0akqlkvuTOS1DUiY/rRbtyZBFn9q5ojF
         lieBYMMJ5XIWEERzwH2DBkCZqpat63UyhSQvtpqYx+tSAR0MKPfKD2woalREkuJ4Mom6
         UHccT41mPs4XOBI+YeEDD7e8yYaej2UywjDxL1LTvs1/IAurf6xVskFl9DkQBXI3VzkH
         UFkFGaiN9CM2IIFcvKxIIblcYaHfQ1kQhxTvZUWUnGQ8pyBZmb2MHjmyOTJ9N+YRgE6y
         gGDg==
X-Gm-Message-State: AOAM530++C+M7lCBFzX67A79/5oijRoXtmkBaB6BefsGFqR1ROvxvoCP
        HVnToyjYhWVSlNsjC3kSZLFc7Q==
X-Google-Smtp-Source: ABdhPJyoyG9ADgJ6dsBiNM1XKs7dyiBINsra2s2Ul2TQ/NhNuX+TnwTAu5r8ljVvYPPBgzF65GRHfw==
X-Received: by 2002:a92:512:: with SMTP id q18mr4738719ile.147.1606861722917;
        Tue, 01 Dec 2020 14:28:42 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r21sm462090ioa.20.2020.12.01.14.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 14:28:42 -0800 (PST)
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Marco Elver <elver@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Iurii Zaikin <yzaikin@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org, skhan@linuxfoundation.org
References: <20201116054035.211498-1-98.arpi@gmail.com>
 <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
 <CANpmjNOhb13YthVHmXxMjpD2JZUO4H2Z1KZSKqHeFUv-RbM5+Q@mail.gmail.com>
 <CABVgOSnGnkCnAyAqVoLhMGb6XV_irtYB7pyOTon5Scab8GxKtg@mail.gmail.com>
 <CAFd5g4768o7UtOmM3X0X5upD0uF3j-=g3txi0_Ue3z8oM_Ghow@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <505b8cd0-a61e-5ec3-7e0b-239d0ff55d56@linuxfoundation.org>
Date:   Tue, 1 Dec 2020 15:28:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g4768o7UtOmM3X0X5upD0uF3j-=g3txi0_Ue3z8oM_Ghow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/30/20 3:22 PM, Brendan Higgins wrote:
> On Mon, Nov 23, 2020 at 11:25 PM David Gow <davidgow@google.com> wrote:
>>
>> On Mon, Nov 23, 2020 at 9:08 PM Marco Elver <elver@google.com> wrote:
>>>
>>> On Tue, 17 Nov 2020 at 08:21, David Gow <davidgow@google.com> wrote:
>>>> On Mon, Nov 16, 2020 at 1:41 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>>>>>
>>>>> Implementation of support for parameterized testing in KUnit. This
>>>>> approach requires the creation of a test case using the
>>>>> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
>>>>>
>>>>> This generator function should return the next parameter given the
>>>>> previous parameter in parameterized tests. It also provides a macro to
>>>>> generate common-case generators based on arrays. Generators may also
>>>>> optionally provide a human-readable description of parameters, which is
>>>>> displayed where available.
>>>>>
>>>>> Note, currently the result of each parameter run is displayed in
>>>>> diagnostic lines, and only the overall test case output summarizes
>>>>> TAP-compliant success or failure of all parameter runs. In future, when
>>>>> supported by kunit-tool, these can be turned into subsubtest outputs.
>>>>>
>>>>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>>>>> Co-developed-by: Marco Elver <elver@google.com>
>>>>> Signed-off-by: Marco Elver <elver@google.com>
>>>>> ---
>>>> [Resending this because my email client re-defaulted to HTML! Aarrgh!]
>>>>
>>>> This looks good to me! I tested it in UML and x86-64 w/ KASAN, and
>>>> both worked fine.
>>>>
>>>> Reviewed-by: David Gow <davidgow@google.com>
>>>> Tested-by: David Gow <davidgow@google.com>
>>>
>>> Thank you!
>>>
>>>> Thanks for sticking with this!
>>>
>>> Will these patches be landing in 5.11 or 5.12?
>>>
>>
>> I can't think of any reason not to have these in 5.11. We haven't
>> started staging things in the kselftest/kunit branch for 5.11 yet,
>> though.
>>
>> Patch 2 will probably need to be acked by Ted for ext4 first.
>>
>> Brendan, Shuah: can you make sure this doesn't get lost in patchwork?
> 
> Looks good to me. I would definitely like to pick this up. But yeah,
> in order to pick up 2/2 we will need an ack from either Ted or Iurii.
> 
> Ted seems to be busy right now, so I think I will just ask Shuah to go
> ahead and pick this patch up by itself and we or Ted can pick up patch
> 2/2 later.
> 
> Cheers
> 

I am seeing

ERROR: need consistent spacing around '*' (ctx:WxV)
#272: FILE: include/kunit/test.h:1786:
+		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : 
(array);	\
  		                   ^

Can you look into this and send v10?

thanks,
-- Shuah
