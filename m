Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB62EB02B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jan 2021 17:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbhAEQfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jan 2021 11:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbhAEQfP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jan 2021 11:35:15 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C46C061574
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Jan 2021 08:34:35 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id r9so28734889ioo.7
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Jan 2021 08:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eEsV5GjmLKE0KArAhzJzwbLWUdZGk09TCWvllXL+wYc=;
        b=TRFc9xF6N+Gx71MTz6M6NF5Po6d8blkVfoFTFC9J49EgAaRY5M5VaRdOQJQsqCT4v8
         0LJtM1ATwRA7DXc4MaowjrtyQGqPnHwC+pOTtoflYlrFrg6bWJY97KBo1m6HbD/KszqJ
         yGk1bpIZBlJx5JXffjejYa8Lyfya3dyhOjsX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eEsV5GjmLKE0KArAhzJzwbLWUdZGk09TCWvllXL+wYc=;
        b=VD7bXaekz1Kw4Bx9aG9s0ylNHsF/HJkY4Ejw6DA0S2BcFG2oo3CA7hk9wlqiFgtkL7
         Nh8wsgIa/UXiVFhzyY+hBTAIPblsr01si03A00xBPgXOjBbTC0dtSWZYQwzSGEMRQBC+
         3G6npcGaor+CP5TwAHH1bWnzp3F30pyhb6D/4YyQOskgfjWhMVc1OlUzq+2d4uNKGH/H
         QEnm426U5pybZJMs1OSTEJekn7s5FaUzMwHToBPnsKT99+R+xpXaGvjP60ma6eTosA4p
         yLvsZy0Ap4je8Y4IL+xdx/4Rp70Y2ULGacCs84J/FwaPt8AmURyttwtliSiFLwTw7v/t
         7QGA==
X-Gm-Message-State: AOAM533Jy73XKUT6XWFAcLzfSF7+yQu4KOCDC7fwMRL4/zBxAO4YtWyp
        hLVjxgeGPwjAQNevtvsO7NpZEg==
X-Google-Smtp-Source: ABdhPJyoENdD6Y7jK8od4+dyGrYt+P3X2XmyMb3keo0+VCokN+Y87ht4X1zlOfuzyfK+JsibUwltsg==
X-Received: by 2002:a6b:6016:: with SMTP id r22mr63753744iog.93.1609864474805;
        Tue, 05 Jan 2021 08:34:34 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l78sm55322ild.30.2021.01.05.08.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 08:34:34 -0800 (PST)
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>,
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3828c7ee-52b0-42f9-5771-74ef9386756c@linuxfoundation.org>
Date:   Tue, 5 Jan 2021 09:34:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X/SSJQ+I5zEMaYYJ@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/5/21 9:21 AM, Petr Mladek wrote:
> On Mon 2021-01-04 09:23:57, Shuah Khan wrote:
>> On 12/22/20 4:11 AM, Andy Shevchenko wrote:
>>> On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
>>>> kunit_tool relies on the UML console outputting printk() output to the
>>>> tty in order to get results. Since the default console driver could
>>>> change, pass 'console=tty' to the kernel.
>>>>
>>>> This is triggered by a change[1] to use ttynull as a fallback console
>>>> driver which -- by chance or by design -- seems to have changed the
>>>> default console output on UML, breaking kunit_tool. While this may be
>>>> fixed, we should be less fragile to such changes in the default.
>>>>
>>>> [1]:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
>>>
>>> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>
>> Thank you all. Now in linux-kselftest kunit-fixes branch.
>>
>> Will send this up for rc3.
>>
>> Sorry for the delay - have been away from the keyboard for a
>> bit.
> 
> JFYI, I am not sure that this is the right solution. I am
> looking into it, see
> https://lore.kernel.org/linux-kselftest/X%2FSRA1P8t+ONZFKb@alley/
> for more details.
> 

Thanks Petr. I will hold off on sending the patch up to Linus and
let you find a the right solution.

thanks,
-- Shuah
