Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0D2ED674
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 19:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbhAGSOi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Jan 2021 13:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAGSOh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Jan 2021 13:14:37 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C8C0612F4
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Jan 2021 10:13:57 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m23so7091783ioy.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Jan 2021 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4v8W1olKibG+tkPSMxEvl9d5W+gvZovag0o/cdLJrG8=;
        b=GCZA18IFXtiLsrpExdF4OWY6T3YUFQsZQ0pI5hzSxRum2HZd5PjWVTvB09K9noe0Sm
         BDhb9/uNnsbErjeHpM/01JnESAsx2DWuVa4okzgHHTXiwk07GC/T0msMzWGR1glQKeVI
         6iiPvOODQgMLzeUr6ixevqw7B98U4r6at747k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4v8W1olKibG+tkPSMxEvl9d5W+gvZovag0o/cdLJrG8=;
        b=cM5WuN4aeHWVoQNmdbyifMYTdrmRiED62Zh8o4WrG0ORAo4FfgXik0nd5inIGmJgcr
         3I5hWDIQvrsFX4CPNSKq+iJe7xpMc5d/jw1AJCOWcbLDS9RmdtRc6A/3E091bszU7NSS
         w1z2gtnIm5x19GIwQt2J5xHyz7GAl5oqzLnYXS6aoT4lTd+A8rmv14C4IzWYIt7tlg35
         0OEDEOa4gLNKlnLNNzfZG+1iYfzsN1L16TaboD4AGw9s2iixsq7LK+8Tviw11WZQ4X+S
         gWeKzDE++XOww21IYYlJ7PWhxS/ld8QN2QrDA/D/4o/R1GtFnqJzvDFA286VcCMShtcn
         d0ZQ==
X-Gm-Message-State: AOAM530FdWfPwh+jZdwQww5QS9N1m9LhrOPKQpj5/nz+LC23VL5vF7Jx
        BWvSJTMPjeH51FfoOKftwkVpJA==
X-Google-Smtp-Source: ABdhPJydhQwgn1+aYSgV7WO5YZh9CjoWBndCSExiuxXNuitgYW+BkQs5Z5XIm6//UBosU4iI41llDg==
X-Received: by 2002:a05:6602:59e:: with SMTP id v30mr2204902iox.37.1610043236697;
        Thu, 07 Jan 2021 10:13:56 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o7sm3502364iop.51.2021.01.07.10.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 10:13:56 -0800 (PST)
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
To:     Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201222073900.3490607-1-davidgow@google.com>
 <20201222111102.GC4077@smile.fi.intel.com>
 <4ae7779c-15c5-0474-5840-44531dcf1d94@linuxfoundation.org>
 <X/SSJQ+I5zEMaYYJ@alley>
 <3828c7ee-52b0-42f9-5771-74ef9386756c@linuxfoundation.org>
 <20210105185731.GT4077@smile.fi.intel.com>
 <918b2d05-f51b-0866-89b3-19a016abdaa3@linuxfoundation.org>
 <CABVgOS=DZjv4-68fEweZwB1-=KB7Tb71iQEfHKHt46OTVWC94w@mail.gmail.com>
 <X/c8jQMyXbsJf85M@alley>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <578de82c-5119-78e4-4497-c8a8d642388d@linuxfoundation.org>
Date:   Thu, 7 Jan 2021 11:13:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X/c8jQMyXbsJf85M@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/7/21 9:53 AM, Petr Mladek wrote:
> On Wed 2021-01-06 12:29:12, David Gow wrote:
>> On Wed, Jan 6, 2021 at 3:52 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>> On 1/5/21 11:57 AM, Andy Shevchenko wrote:
>>>> On Tue, Jan 05, 2021 at 09:34:33AM -0700, Shuah Khan wrote:
>>>>> On 1/5/21 9:21 AM, Petr Mladek wrote:
>>>>>> On Mon 2021-01-04 09:23:57, Shuah Khan wrote:
>>>>>>> On 12/22/20 4:11 AM, Andy Shevchenko wrote:
>>>>>>>> On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
>>>>>>>>> kunit_tool relies on the UML console outputting printk() output to the
>>>>>>>>> tty in order to get results. Since the default console driver could
>>>>>>>>> change, pass 'console=tty' to the kernel.
>>>>>>>>>
>>>>>>>>> This is triggered by a change[1] to use ttynull as a fallback console
>>>>>>>>> driver which -- by chance or by design -- seems to have changed the
>>>>>>>>> default console output on UML, breaking kunit_tool. While this may be
>>>>>>>>> fixed, we should be less fragile to such changes in the default.
>>>>>>>>>
>>>>>>>>> [1]:
>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
>>>>>>>>
>>>>>>>> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>>>> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>>>>
>>>>>>>
>>>>>>> Thank you all. Now in linux-kselftest kunit-fixes branch.
>>>>>>>
>>>>>>> Will send this up for rc3.
>>>>>>>
>>>>>>> Sorry for the delay - have been away from the keyboard for a
>>>>>>> bit.
>>>>>>
>>>>>> JFYI, I am not sure that this is the right solution. I am
>>>>>> looking into it, see
>>>>>> https://lore.kernel.org/linux-kselftest/X%2FSRA1P8t+ONZFKb@alley/
>>>>>> for more details.
>>>>>>
>>>>>
>>>>> Thanks Petr. I will hold off on sending the patch up to Linus and
>>>>> let you find a the right solution.
>>>>
>>>> Please. leave it in Linux Next at least. Otherwise kunit will be broken for a
>>>> long time which is not good.
>>>>
>>>>
>>>
>>> Yes. That is the plan. It will be in there until real fix comes in.
> 
> The real fix would be too complicated for 5.11-rc3. Instead, I
> proposed to revert the problematic commit, see
> https://lore.kernel.org/lkml/20210107164400.17904-2-pmladek@suse.com/
> I would like to push it for 5.11-rc3.
> 
>> Personally, I think that this patch makes some sense to keep even if
>> the underlying issue with ttynull is resolved. Given that kunit.py
>> requires the console output, explicitly stating we want console=tty
>> set is probably worth doing rather than relying on it being the
>> default.
> 
> I agree that the patch makes sense on its own. kunit depends on the
> particular console. Note that "tty" is actually the UML-specific
> stdio console implemented in arch/um/drivers/stdio_console.c.
> 

The proposal sounds like revert the problem commit 
https://lore.kernel.org/lkml/20210107164400.17904-2-pmladek@suse.com/

and also send kunit fix up. Sounds reasonable to me. I will send
it for 5.11-rc3

thanks,
-- Shuah
