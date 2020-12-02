Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A802CCA28
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 23:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbgLBW7Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 17:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbgLBW7X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 17:59:23 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7560BC0617A7
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 14:58:43 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id y5so79597iow.5
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 14:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5cB+/vzqNyGLlY6gjXLdgcPyiXRJ9zfEjY/dw9Idssc=;
        b=X8557/AaDSnc9UMi9+sP+NzMIycm4dY1OUc43TJwqCyubHtdOXlntePdg7MSqERib7
         2MHzSJXG1VwTGZwJ7AAfpgYiHYKhdFqqbt54Q++1yolC8XAg97L4/l6bPtqFRKYwZHMc
         Aw1BX3BTAcOw807GmPNnGGsHLfghlU/C8d3+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cB+/vzqNyGLlY6gjXLdgcPyiXRJ9zfEjY/dw9Idssc=;
        b=rRtV90kVSfeyCw017uQC14BA3BgDWP39499BbC0aqmacunvD6stuSAMzNj2gcz4qen
         23U88ksSrHwf34fOGlCoAhYUInpqinr7bVymbJ05Eyz5Y9Bveqlg0cYTrc6IHto8nCE+
         RvLfSpTmXUbSInSzQmeEzcPPNTcx45V/t6BCnqxA0WSJh82FEEXW9Unwblge7DzaXnrP
         4Q+jPybpbmKg6bs72vjubFA9fvdrwOhaF4RzAodSRQvxJrOn65Rt6M7gH5SI3C+rJ36E
         KUeUD4kU30SEnHvWOLOoXMAAx99FvNa2dg/sa9ECgzSBK3Ton3yA9etocVwzAHi04vyD
         17lw==
X-Gm-Message-State: AOAM533YYlD51+554DTdQejYIEXKaa8p5u1l9DysiOOSpJ91XBjDIuwW
        SH3mj1DOg1VnkGAKjmgxPIg1+g==
X-Google-Smtp-Source: ABdhPJzw3Rv1enCYSm9+2gzSPLTdHJBQW7KQ7rpvW60Gn0Ix2oysMP10GIdQH+AH3ho7nq+g1z7Y2Q==
X-Received: by 2002:a6b:600a:: with SMTP id r10mr533063iog.143.1606949922814;
        Wed, 02 Dec 2020 14:58:42 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a3sm118730ilp.5.2020.12.02.14.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:58:42 -0800 (PST)
Subject: Re: [PATCH v9 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Iurii Zaikin <yzaikin@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20201116054035.211498-1-98.arpi@gmail.com>
 <CABVgOSkoQahYqMJ3dD1_X2+rF3OgwT658+8HRM2EZ5e0-94jmw@mail.gmail.com>
 <CANpmjNOhb13YthVHmXxMjpD2JZUO4H2Z1KZSKqHeFUv-RbM5+Q@mail.gmail.com>
 <CABVgOSnGnkCnAyAqVoLhMGb6XV_irtYB7pyOTon5Scab8GxKtg@mail.gmail.com>
 <CAFd5g4768o7UtOmM3X0X5upD0uF3j-=g3txi0_Ue3z8oM_Ghow@mail.gmail.com>
 <505b8cd0-a61e-5ec3-7e0b-239d0ff55d56@linuxfoundation.org>
 <CANpmjNMOMD+2OhBWNh5XuFufbm1bhXTUm4Y3_YiNNdfC=G2xdQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <baa3bec1-224e-43c6-1e63-982e5eeb217f@linuxfoundation.org>
Date:   Wed, 2 Dec 2020 15:58:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNMOMD+2OhBWNh5XuFufbm1bhXTUm4Y3_YiNNdfC=G2xdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/1/20 4:31 PM, Marco Elver wrote:
> On Tue, 1 Dec 2020 at 23:28, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 11/30/20 3:22 PM, Brendan Higgins wrote:
>>> On Mon, Nov 23, 2020 at 11:25 PM David Gow <davidgow@google.com> wrote:
>>>>
>>>> On Mon, Nov 23, 2020 at 9:08 PM Marco Elver <elver@google.com> wrote:
>>>>>
>>>>> On Tue, 17 Nov 2020 at 08:21, David Gow <davidgow@google.com> wrote:
>>>>>> On Mon, Nov 16, 2020 at 1:41 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>>>>>>>
>>>>>>> Implementation of support for parameterized testing in KUnit. This
>>>>>>> approach requires the creation of a test case using the
>>>>>>> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
>>>>>>>
>>>>>>> This generator function should return the next parameter given the
>>>>>>> previous parameter in parameterized tests. It also provides a macro to
>>>>>>> generate common-case generators based on arrays. Generators may also
>>>>>>> optionally provide a human-readable description of parameters, which is
>>>>>>> displayed where available.
>>>>>>>
>>>>>>> Note, currently the result of each parameter run is displayed in
>>>>>>> diagnostic lines, and only the overall test case output summarizes
>>>>>>> TAP-compliant success or failure of all parameter runs. In future, when
>>>>>>> supported by kunit-tool, these can be turned into subsubtest outputs.
>>>>>>>
>>>>>>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>>>>>>> Co-developed-by: Marco Elver <elver@google.com>
>>>>>>> Signed-off-by: Marco Elver <elver@google.com>
>>>>>>> ---
>>>>>> [Resending this because my email client re-defaulted to HTML! Aarrgh!]
>>>>>>
>>>>>> This looks good to me! I tested it in UML and x86-64 w/ KASAN, and
>>>>>> both worked fine.
>>>>>>
>>>>>> Reviewed-by: David Gow <davidgow@google.com>
>>>>>> Tested-by: David Gow <davidgow@google.com>
>>>>>
>>>>> Thank you!
>>>>>
>>>>>> Thanks for sticking with this!
>>>>>
>>>>> Will these patches be landing in 5.11 or 5.12?
>>>>>
>>>>
>>>> I can't think of any reason not to have these in 5.11. We haven't
>>>> started staging things in the kselftest/kunit branch for 5.11 yet,
>>>> though.
>>>>
>>>> Patch 2 will probably need to be acked by Ted for ext4 first.
>>>>
>>>> Brendan, Shuah: can you make sure this doesn't get lost in patchwork?
>>>
>>> Looks good to me. I would definitely like to pick this up. But yeah,
>>> in order to pick up 2/2 we will need an ack from either Ted or Iurii.
>>>
>>> Ted seems to be busy right now, so I think I will just ask Shuah to go
>>> ahead and pick this patch up by itself and we or Ted can pick up patch
>>> 2/2 later.
>>>
>>> Cheers
>>>
>>
>> I am seeing
>>
>> ERROR: need consistent spacing around '*' (ctx:WxV)
>> #272: FILE: include/kunit/test.h:1786:
>> +               typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 :
>> (array);        \
>>                                     ^
>>
>> Can you look into this and send v10?
> 
> This is a false positive. I pointed this out here before:
> https://lkml.kernel.org/r/CANpmjNNhpe6TYt0KmBCCR-Wfz1Bxd8qnhiwegwnDQsxRAWmUMg@mail.gmail.com
> 
> checkpatch.pl thinks this is a multiplication, but this is a pointer,
> so the spacing here is correct.
> 

Thank you for confirming. I will apply this.

thanks,
-- Shuah
