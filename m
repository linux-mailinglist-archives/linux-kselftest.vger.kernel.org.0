Return-Path: <linux-kselftest+bounces-19678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D6099D9A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C5B1C213F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9271D31AF;
	Mon, 14 Oct 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Il9SQWVh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D779143722
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943686; cv=none; b=To1MWRIn5Nq7FpX0V2Nywf1We7JH6kQoIoEdX+uW2nDMyoO4IEByQU+1jAZgvocMc+4OQiT/UV5GYAbTiRSlAMCtzlcf9C62dRr0g2JsurAISyA8LE9lFX7Ut7L9UC+PthLjrLQa9xrO1Vs4T6idp0SYwz3KZlNtGowYDb6l4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943686; c=relaxed/simple;
	bh=fTKWSQXF0ypFNbAGzzmAXxs+vQUO0TtdrsoT5dchpDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgUElN54BgTdD/CY4VGYnW3Xd0EsDNoRypN8nef4Pu9jhslKNFINAN//XhNvwsG9WypKtwVjJXJf9E5M3k2XufqfP8GW8y1RuAUKyyUZdPslSJn0aOMbAZnm1E3RKD3SVQRGfhUzXxc221dUWp7Gm5iLF+y+2d+0IjGfi+PH0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Il9SQWVh; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8354cc1ab0cso171225239f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728943683; x=1729548483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fZn3HVozUCHpAhBChYhgj2VZJQrei88clT/tksTBQE=;
        b=Il9SQWVhQg/3nUHO+hFuKfjNm7gcAJYnnLurr+a+lunXBXJMbZDHZ4p2KIbkib1P0c
         AqNw0XQdPPWUNB9TaTQqkmimHhfd39QsQb3vDi5Cy+ISaFC5etcTpx/29TXriJWvAtnC
         DlFtvfBkJLXqXhs8WF0bCcxry9Ww7PS1L6zPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943683; x=1729548483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fZn3HVozUCHpAhBChYhgj2VZJQrei88clT/tksTBQE=;
        b=D3Ds4NoxJ7Gp2i+92SD0eUy6uLvxst00QLCR/IkUGDObuQ+IgZtnCOw8BiNOgmZb2j
         gzuFrSB6lTq+Il1aBNm0R6MJEgq+5HB9g9JJqtfSkJXaI3mOL+JvbRs86/ES52e7cIOZ
         rgpLA4bHmonABMpvjwNUvYooKxMZKznE99WKpVQnWdMA+Y4+/CSwS9oUe+n5UYNK3wl4
         bkxoKtNIbKgYMUk9D+WzWDZPDsZ9BVfLsMLsS1+YRukuuSSO6z4dhDXmGvR5/RytXbod
         1ND1dUJZDJWcWBa2pX6yrIkFar0ichFr3zdW7DNE8awNEfRWeju4CEl2lypyErIWx59J
         zKLA==
X-Forwarded-Encrypted: i=1; AJvYcCXun6qxRuXH5zLe++/7u1IxjOaJSmejtG6lbtMoDbwQQHpUPkrtjoR+oDq2ZJGTlleFMEvVpCjl1lBMjz/imVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJ902zxSMUl4iXLgU6V046gHyo2InMIU0546Q6+eNUS7vT95Q
	ytnVJU6m4IKdLUIyKTqqfo7rEqulnNgNv++OguQ8pmtYfhI4CRXSh80ctoVv2aU=
X-Google-Smtp-Source: AGHT+IEuDLbunmWHWlwlQRiIV3BbNDg9RT+R6jVm4OC3F9c7hmK3Ji+75kCKpzDyIE0dB4QOU+n1nw==
X-Received: by 2002:a05:6602:6413:b0:835:359b:8a07 with SMTP id ca18e2360f4ac-837952203bdmr949334239f.16.1728943683193;
        Mon, 14 Oct 2024 15:08:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a8b2aa42asm446339f.21.2024.10.14.15.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 15:08:02 -0700 (PDT)
Message-ID: <606f8672-cd66-4828-99b9-2356c738acc2@linuxfoundation.org>
Date: Mon, 14 Oct 2024 16:08:01 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: Remove unneeded semicolon
To: John Stultz <jstultz@google.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, tglx@linutronix.de, sboyd@kernel.org,
 anna-maria@linutronix.de, frederic@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241010073707.4038081-1-nichen@iscas.ac.cn>
 <87492b3f-84d1-426f-ad71-7784a1c1dfc3@linuxfoundation.org>
 <CANDhNCr5X3gkSRR7cWZ13DDbepV3Nb1tQ5E3XuAaJx_5vZ=PCw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCr5X3gkSRR7cWZ13DDbepV3Nb1tQ5E3XuAaJx_5vZ=PCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 18:47, John Stultz wrote:
> On Fri, Oct 11, 2024 at 4:00 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 10/10/24 01:37, Chen Ni wrote:
>>> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
>>> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>>>
>>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>>> ---
>>>    tools/testing/selftests/timers/set-timer-lat.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
>>> index 5365e9ae61c3..7a1a2382538c 100644
>>> --- a/tools/testing/selftests/timers/set-timer-lat.c
>>> +++ b/tools/testing/selftests/timers/set-timer-lat.c
>>> @@ -79,7 +79,7 @@ char *clockstring(int clockid)
>>>                return "CLOCK_BOOTTIME_ALARM";
>>>        case CLOCK_TAI:
>>>                return "CLOCK_TAI";
>>> -     };
>>> +     }
>>>        return "UNKNOWN_CLOCKID";
>>>    }
>>>
>>
>> Looks good to me.
>>
>> John, I will apply this for next of you are okay with it.
> 
> Acked-by: John Stultz <jstultz@google.com>

Thank you. Applied linux-kselftest next for Linux 6.13-rc1.

> 
>> Also I noticed clockstring() is defined in multiple tests.
>> Any thoughts on removing the duplicates and adding it to
>> a header file? This will add a dependency on another source
>> file, but might be good to remove the duplicate code.
> 
> Sure, no objections.

Thanks. I will send patch in soon.

thanks,
-- Shuah

