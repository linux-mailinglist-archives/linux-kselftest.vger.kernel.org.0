Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A782046A54A
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 20:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348155AbhLFTEY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 14:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbhLFTEY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 14:04:24 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11234C0613F8
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 11:00:55 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso14915681ota.5
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 11:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iMXyhhYM1muMv9jtGH7761BAJSehLUX2R720MHkszZs=;
        b=bxk1+6gwz716UvC5kPDAZdF39e0lNiACPiH3VTa/zTStmhTG07mZ8BL9grQumJi/Fg
         B2tzNMg2Sx/dL6wzMWB8FU923ANrhPHRjQgMX1CWEHrBlMIriB7L7EmCDkn3PPHuCCyR
         vHCg4GyXI3Ttxvp3qJBdyDeo5Zp92T3VV7sMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iMXyhhYM1muMv9jtGH7761BAJSehLUX2R720MHkszZs=;
        b=mXr4ml/bKnHksAsAHY1mZZ8gDMjZz5SPaCXVjM9dKAGPLwgDc7e4yVd98qJCNHdb6d
         2tS/nrb7cuX/CbaIqN/7oR+8FKdtJsKYeE8QVyeEoBtshFLqhYcIqCg/bgPPSuQEY+zR
         lokroUQtdLVqtocWyWVcOsZ91VyBTVk76jucFIejhfg5ns+wjX7Qq4AxycBTxlFGkat2
         Yb3Q40O74ojcwiUGpmE7jk1/g4OQ2zT8GOk1wpudZKmdIFl3sqbFy8gq5jKjPmrKYmgt
         eS/4O2llAP8UXB9mu39Zqi+aEb9rQRtqhHIlkjzXH98ynbTdhky8ur+7EUfP90M5SHFe
         fFHA==
X-Gm-Message-State: AOAM531DpTEnIR27Bk5zaYGowbC7MJHSHMxR2AH0FI3fFAKpre98tJgD
        fkHmiGRG8uZp6+r4wLQ3h1nU4w==
X-Google-Smtp-Source: ABdhPJymQYnvohPzSLEiN7EBa2qjtuMvyq0wuYedYjGh9lqitfhSnsYf27KggbnzyOSKvsp17YkE1g==
X-Received: by 2002:a05:6830:183:: with SMTP id q3mr30410706ota.285.1638817254337;
        Mon, 06 Dec 2021 11:00:54 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id bg38sm3120915oib.40.2021.12.06.11.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 11:00:53 -0800 (PST)
Subject: Re: [PATCH] mnt: remove unneeded conversion to bool
To:     Joe Perches <joe@perches.com>, davidcomponentone@gmail.com,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <3a7435c9e7e7aa8f24d22fd576ce912eb0540272.1637737086.git.yang.guang5@zte.com.cn>
 <07f4ba23-cf4c-6817-f7a4-5428f35d966c@linuxfoundation.org>
 <983ee57718a6e5838f79be96b7f7efc638177f76.camel@perches.com>
 <eef8e264-7cf7-8747-867e-b40c9f180d0d@linuxfoundation.org>
 <2236458d6a4e77bd09afb13bba65747a3416f293.camel@perches.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aaef3a0e-4ed6-36b9-030c-13ad8455fc76@linuxfoundation.org>
Date:   Mon, 6 Dec 2021 12:00:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2236458d6a4e77bd09afb13bba65747a3416f293.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/3/21 8:06 PM, Joe Perches wrote:
> On Fri, 2021-12-03 at 17:24 -0700, Shuah Khan wrote:
>> On 12/3/21 12:50 PM, Joe Perches wrote:
>>> On Fri, 2021-12-03 at 11:26 -0700, Shuah Khan wrote:
>>>> On 11/24/21 5:56 PM, davidcomponentone@gmail.com wrote:
>>>>> From: Yang Guang <yang.guang5@zte.com.cn>
>>>>>
>>>>> The coccinelle report
>>>>> ./tools/testing/selftests/mount/unprivileged-remount-test.c:285:54-59:
>>>>> WARNING: conversion to bool not needed here
>>>>> ./tools/testing/selftests/mount/unprivileged-remount-test.c:207:54-59:
>>>>> WARNING: conversion to bool not needed here
>>>>> Relational and logical operators evaluate to bool,
>>>>> explicit conversion is overly verbose and unneeded.
>>>>>
>>>>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>>>>> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
>>>>> ---
>>>>>     tools/testing/selftests/mount/unprivileged-remount-test.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
>>>>> index 584dc6bc3b06..d2917054fe3a 100644
>>>>> --- a/tools/testing/selftests/mount/unprivileged-remount-test.c
>>>>> +++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
>>>>> @@ -204,7 +204,7 @@ bool test_unpriv_remount(const char *fstype, const char *mount_options,
>>>>>     		if (!WIFEXITED(status)) {
>>>>>     			die("child did not terminate cleanly\n");
>>>>>     		}
>>>>> -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
>>>>> +		return WEXITSTATUS(status) == EXIT_SUCCESS;
>>>>>     	}
>>>>>     
>>>>>     	create_and_enter_userns();
>>>>> @@ -282,7 +282,7 @@ static bool test_priv_mount_unpriv_remount(void)
>>>>>     		if (!WIFEXITED(status)) {
>>>>>     			die("child did not terminate cleanly\n");
>>>>>     		}
>>>>> -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
>>>>> +		return WEXITSTATUS(status) == EXIT_SUCCESS;
>>>>>     	}
>>>>>     
>>>>>     	orig_mnt_flags = read_mnt_flags(orig_path);
>>>>>
>>>>
>>>> This change doesn't look right. WEXITSTATUS(status) return could be
>>>>> 1 or 0 or negative.
>>>
>>> The change is at least logically correct.
>>>
>>> And isn't WEXITSTATUS range limited from 0->255 ?
>>>
>>> https://www.gnu.org/software/libc/manual/html_node/Exit-Status.html
>>>
>>
>> You are right. In any case, I don't see any value in changing the current
>> logic. The way it is coded is cryptic enough :)
> 
> Well, it'd be more like the rest of the kernel when changed.
> 
> bool function()
> {
> 	...
> 	return <foo> ? true : false;
> }
> 
> is pretty redundant.
> 
> 

Fair enough.

Yang Guang,

Applied patch. In the future, make sure to use selftests/<test>: convention
for patch summary. I fixed this one for now.

thanks,
-- Shuah
