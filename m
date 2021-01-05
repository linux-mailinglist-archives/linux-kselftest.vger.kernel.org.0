Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DAD2EB3B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jan 2021 20:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbhAETw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jan 2021 14:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbhAETw4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jan 2021 14:52:56 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C0C061793
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Jan 2021 11:52:16 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 81so448605ioc.13
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Jan 2021 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MUmClyAZBPlE7Le4cgLYa46jVi3l4PFDRJWl+ePxKps=;
        b=MavlyPFNkKPuclSzMb3GoGCfiFYFDPAmLM8mrU9ii2oKdjb7M97cCdw/FUvuAD/tvg
         qq80P25bb9inOMZpNdKnChezh+SuNcWIWhM0gUJtKJ1GzE8B03EeNBPUGFdJgsY1XClt
         FntkhRU4Vp9vqMA3qc2iwIvwycZCbNKL7ELQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MUmClyAZBPlE7Le4cgLYa46jVi3l4PFDRJWl+ePxKps=;
        b=Oddw843tE5AmlDHFKA1kUZwnwMdn9bvGuVsTvoEToGnGbEUNK+1IOnXqig4SMDmoex
         wsZA5XvIjQ3PpBZ5k0yCQEAqNMG/T6WnisXbH3zGLmCPNQmU5SVb0xA27wt9adA9nSY6
         UF8l2JkjxhIue+br4FNjvsAsOJbEaXFlmnjKFx69VITS44kMVLWJW2dTWo/66HpY6v42
         E6h33aMuXLhwMSgx7NO8X2SY5Xe2QGcJashIrJVzUfeEyFdIuov2zRoUjTw7QLo30vk1
         H3M3W8jkpQtDOzHI4G+NPwIvo1vtmX3roDu/EEx7Kv33frrZoqHZith1gQGH3kUiWwPc
         wLDg==
X-Gm-Message-State: AOAM530nARgi8ndRJJQmK7FNSEwrUAgH1DjOqGu+QjS1EiNiktzvQA2Y
        Ik8pzT7INWZTWIDi0FgpV0E/Sw==
X-Google-Smtp-Source: ABdhPJy/4xKWsJqauwUWBPNxLIHPJbD9egorxkf2SJisb+l9V4Udu88+b7tT5z8D0BRnhFfsm2SDhQ==
X-Received: by 2002:a5e:8344:: with SMTP id y4mr549885iom.116.1609876335465;
        Tue, 05 Jan 2021 11:52:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r11sm152669ilg.39.2021.01.05.11.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 11:52:14 -0800 (PST)
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201222073900.3490607-1-davidgow@google.com>
 <20201222111102.GC4077@smile.fi.intel.com>
 <4ae7779c-15c5-0474-5840-44531dcf1d94@linuxfoundation.org>
 <X/SSJQ+I5zEMaYYJ@alley>
 <3828c7ee-52b0-42f9-5771-74ef9386756c@linuxfoundation.org>
 <20210105185731.GT4077@smile.fi.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <918b2d05-f51b-0866-89b3-19a016abdaa3@linuxfoundation.org>
Date:   Tue, 5 Jan 2021 12:52:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105185731.GT4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/5/21 11:57 AM, Andy Shevchenko wrote:
> On Tue, Jan 05, 2021 at 09:34:33AM -0700, Shuah Khan wrote:
>> On 1/5/21 9:21 AM, Petr Mladek wrote:
>>> On Mon 2021-01-04 09:23:57, Shuah Khan wrote:
>>>> On 12/22/20 4:11 AM, Andy Shevchenko wrote:
>>>>> On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
>>>>>> kunit_tool relies on the UML console outputting printk() output to the
>>>>>> tty in order to get results. Since the default console driver could
>>>>>> change, pass 'console=tty' to the kernel.
>>>>>>
>>>>>> This is triggered by a change[1] to use ttynull as a fallback console
>>>>>> driver which -- by chance or by design -- seems to have changed the
>>>>>> default console output on UML, breaking kunit_tool. While this may be
>>>>>> fixed, we should be less fragile to such changes in the default.
>>>>>>
>>>>>> [1]:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
>>>>>
>>>>> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>
>>>>
>>>> Thank you all. Now in linux-kselftest kunit-fixes branch.
>>>>
>>>> Will send this up for rc3.
>>>>
>>>> Sorry for the delay - have been away from the keyboard for a
>>>> bit.
>>>
>>> JFYI, I am not sure that this is the right solution. I am
>>> looking into it, see
>>> https://lore.kernel.org/linux-kselftest/X%2FSRA1P8t+ONZFKb@alley/
>>> for more details.
>>>
>>
>> Thanks Petr. I will hold off on sending the patch up to Linus and
>> let you find a the right solution.
> 
> Please. leave it in Linux Next at least. Otherwise kunit will be broken for a
> long time which is not good.
> 
> 

Yes. That is the plan. It will be in there until real fix comes in.

thanks,
-- Shuah
