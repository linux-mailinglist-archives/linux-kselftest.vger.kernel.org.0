Return-Path: <linux-kselftest+bounces-22141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD789CFF79
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 16:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C95B24FCB
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5F417BA9;
	Sat, 16 Nov 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnATvkTo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA73FC12;
	Sat, 16 Nov 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731770745; cv=none; b=fv+dp5TMjVlk/so9gPN3Wm5bEL7HgwpuQldJhmTwlU+tSMgUTVwSwBTPcdEJUmsB0bndk/3NMbskjIQreq6Gy58K22vWg9fkPh4UyeSx+wvZxZyA+lTxXVfgUWStRuIUBNONJ0LWk6rxbYsJQQakn4EFZdayEh4VowQWwrP3Bus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731770745; c=relaxed/simple;
	bh=obrV/0cQ9hJsrorEohHeNXHw27ku/AAp2n6zkeNlkYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAwAkq/0YZwd2jKrXCylZhoAOdVIA4zLIz1SOljhd6mwMJZpqFVXkraHvLKGAZkufgvFqeGm3XkALvC97OJMFj2ihrzV0QeOnv0dfVLo0zJayK42yx3iMzZEJo7w9wIECS/Nj/9PGWspWn8fdjECGd65qpxm5xF1oT7iVy5x+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnATvkTo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea2dd09971so770141a91.3;
        Sat, 16 Nov 2024 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731770743; x=1732375543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDjoxcHWQzlcTPxRMAEqKxDEdflI9umWnb9NkBm5LqA=;
        b=LnATvkTorrWfisnK5XxsUK8Z+lR26g67f7a8dOsr9K421U5BUOJGz9OenTrVT+jZIj
         IdfvpYPFxz+PA3MfebqFgR6Muwp8LNSY9a1+F07Cx6pc8HL1h9xJRD1m4dvATuqO72qy
         HMmnWVDDn2YjzYJfra7ziUFF5E44KUEccwKWPWu6xUbNBe3pPARRHdh1vDxXKf5dz6C9
         racYM5pg+fOCwNBkV6uenYjmN9Z+6q48mMAOY7IdfEfiUT5PcznGAMVOsbWp8/x0d0Es
         du6iF6iRh8h8BROKuHK6qo99R0e0E6HLBvy9N9k/hP6aNdP8ndK2FxrAAyUBgOMmSssx
         j89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731770743; x=1732375543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDjoxcHWQzlcTPxRMAEqKxDEdflI9umWnb9NkBm5LqA=;
        b=PO2fHokcgI1Vtk4L6jSTz4WdvfPEBGNWR3lYL/McmR5w6HZM2OtQPi83GjZ98IWryw
         06xNc83xY7BSCGmkKT7HW/b3VdZW2+P1c9tzlnCp+PS9TjYurNB5/MK65LInaCsBmxWS
         68b6aYHMvfZLGZyJ8XG5l7rx9L3uVqVdhS8Wh2Gs7XFe0I1cBiVSp6LS66f5ZuL4ZhgH
         PA8MUE6PNRDUO6RrxIxTwmL/7ZP6vVAw31/Z5fkxDjWRLAPyIoiQKAInvm1HQ0fTMDmy
         wVQINy/dVYJF4ed+dI81hAOEZ4a42pxWwxpdh9JEOn4tvXJrPb3CYUpDX0dRHoXhjkRB
         0JXg==
X-Forwarded-Encrypted: i=1; AJvYcCVRmPRoUgxvuzDwelRDvSmmJVNWj9tz10T/dv17BARUv5g4n2EH9rZbEKdl5DMXiNzSftyiXX1xajphFo4=@vger.kernel.org, AJvYcCWRljFQpHbgcrj1Kwuge3xIL+j87wAj3FmyMAZiQH7MvIhVkGprmOOBdQwY5tG7Wxq9EMNx27pOLM6yXsfBgurMXi/RzOct@vger.kernel.org, AJvYcCXaUjuKPHXGfEC/+DZWpZMGRvti8RkOAHPqYh7WNvZ69w7jdX+I4zpbMKlGHCZcsx/UjuOjdKHQSYfO7WAM3NGR@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTnxgW2m5vhdUGNkwQETtmgfX4u94KqzjF6Xn9og5N3DRrOSq
	EeMW7gD3sifCMG0myn4Q5gug7JAuzild3gk24tN8YbY4BI/V/0/+
X-Google-Smtp-Source: AGHT+IGw4VfASD8aKJiavcRypK0mXbkTJDydc3lHd+ZsM1SsGgcBaeyg/h+UixlVWuHLWUdJK7FU7Q==
X-Received: by 2002:a17:90b:2494:b0:2ea:356f:51a6 with SMTP id 98e67ed59e1d1-2ea356f54a1mr3572540a91.14.1731770743219;
        Sat, 16 Nov 2024 07:25:43 -0800 (PST)
Received: from ?IPV6:2409:40c1:0:e383:932c:79f0:2381:e2d3? ([2409:40c1:0:e383:932c:79f0:2381:e2d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea02481b6bsm4727260a91.8.2024.11.16.07.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:25:42 -0800 (PST)
Message-ID: <4a72bea1-da58-438f-b03e-e79bd4011f64@gmail.com>
Date: Sat, 16 Nov 2024 20:55:32 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: lsm: Refactor
 `flags_overset_lsm_set_self_attr` test
To: Shuah Khan <skhan@linuxfoundation.org>,
 Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc: ricardo@marliere.net, linux-kernel-mentees@lists.linux.dev,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241112182810.24761-1-av2082000@gmail.com>
 <52cc8e51-9e85-465b-8ee3-63a7a0a42951@linuxfoundation.org>
 <c16b7517-e490-48d9-a2b6-f0077cbb0eba@schaufler-ca.com>
 <196eaffe-c90b-4f44-a748-b786b46fd506@linuxfoundation.org>
Content-Language: en-US
From: Amit <av2082000@gmail.com>
In-Reply-To: <196eaffe-c90b-4f44-a748-b786b46fd506@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/24 10:38 pm, Shuah Khan wrote:
> On 11/14/24 09:55, Casey Schaufler wrote:
>>
>> On 11/14/2024 8:25 AM, Shuah Khan wrote:
>>> On 11/12/24 11:28, Amit Vadhavana wrote:
>>>> - Remove unnecessary `tctx` variable, use `ctx` directly.
>>>> - Simplified code with no functional changes.
>>>>
>>>
>>> I would rephrase the short to simply say Remove unused variable,
>>> as refactor implies more extensive changes than what this patch
>>> is actually doing.
>>>
>>> Please write complete sentences instead of bullet points in the
>>> change log.
V2: https://lore.kernel.org/all/20241116152136.10635-1-av2082000@gmail.com/
>>> >>> How did you find this problem? Do include the details on how
>>> in the change log.
While exploring the kselftest framework. I found the this problem.
>>>
>>>> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
>>>> ---
>>>>    tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>>> b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>>> index 66dec47e3ca3..732e89fe99c0 100644
>>>> --- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>>> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
>>>> @@ -56,16 +56,15 @@ TEST(flags_zero_lsm_set_self_attr)
>>>>    TEST(flags_overset_lsm_set_self_attr)
>>>>    {
>>>>        const long page_size = sysconf(_SC_PAGESIZE);
>>>> -    char *ctx = calloc(page_size, 1);
>>>> +    struct lsm_ctx *ctx = calloc(page_size, 1);
>>>
>>> Why not name this tctx and avoid changes to the ASSERT_EQs
>>> below?
>>
>> In the realm of linux security modules ctx is short for "context".
>> I used tctx here because I was lazy. It would be much better to
>> drop tctx, even if it means a tiny bit more change.
>>
> 
> Makes sense.
> 
> Amit, you can ignore this comment about tctx and ctx. Please do fix
> others about the change log and short log.
> 
> thanks,
> -- Shuah
> 

-- 
Thanks,
Amit V.

