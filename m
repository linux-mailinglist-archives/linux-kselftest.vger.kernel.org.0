Return-Path: <linux-kselftest+bounces-9466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F78BBD40
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 18:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD262B2105B
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C9A5A0F5;
	Sat,  4 May 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2+GG1X2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEB4E1C9;
	Sat,  4 May 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714841111; cv=none; b=Usg2OOmWAG1LBBPyb0pm7fhF+tvs6oS6BSQ7rQ14wwxzaQiEGIse68XxU0Hnt7OUpSbjFqJYcSIEkWG6KD4NycPdEB0T4EtNGBZHv72wQOibPhR+jgIq6l5FMUwv2c5vsukO6j1ycOJ7mLSm7IWViD8huCDpOzeJDYxaHbV8CaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714841111; c=relaxed/simple;
	bh=DJBQjy8UJmY6eVHNdIDiEW6MELxRUW51GKxDhKp3a5k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dFKXluvNtBAr/ZuyVOWyLtUDTXQNlZcXPY00zp4mImd/13VHsHYUbhx0N5Iro1lQKg6y7BraAAcP5K0EA1qGq2lMCzz5wiNGfMgRVw1MpwZ46KSy9zsLAOb+3swCatQWBUnEdKM2Cd+iBLkCSWjVKvGwHxYOB2tCldK4LU0SK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2+GG1X2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34aa836b948so147313f8f.3;
        Sat, 04 May 2024 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714841108; x=1715445908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QZOW0qVZhWfpI6frSKkoNbNeKGBazQ5SDm6EfeSZG3E=;
        b=d2+GG1X25uHHfi50AL3cr9LAzggghQfGeRqcjl/5JnxCsXfEP5obbl22/iXegCB4UR
         tVAqmgt8Zgfyu1IAIqN5T6NQNdaPLT0ztThRCoKvH0rl8pSN/eSr1QHKqALwJbU/PcX0
         aMtC/42w7liy+DQVnIrQ8ZSoY2mXD8FqBtL09Wi++zkO3W4BeKc+8q9JyHnRjSjeSeQH
         /ejgQhdURGE/kdOPZmx9KTVQ0HT9Q6biIySt3mNZ24BrmSjbdzTtEVVvyDKAtbErnw/C
         3JOOz/kWDV5MhikyUl0XwToWEiErILUAMG/s10qF7madpenak43tTXIjnskdoE9G4PfG
         KleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714841108; x=1715445908;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZOW0qVZhWfpI6frSKkoNbNeKGBazQ5SDm6EfeSZG3E=;
        b=CTyrdT3BXpJnlOljbp5cYFDJDaHFXatjn++VldxacdLmneyF11JjHWlHDPEUKhLzBE
         /ubWQBUz8L4q4reg1DKD2ECpFePahKsLzQU0e94POusS1PWx1QDgpVrWx/Hzsveiwf+u
         8mfss/fv29x6gtknbg8tDX7ClM9EGhwA752Q3AbYJbML7iP2PI8X6p/cmTQmeVd6WM2E
         6+2E1ssY5wt+wJUf+Q+UISY4XOtZCBAAGdKL7j8KBQVSmPu5waq0BJpGgcZ1PI4kh0uJ
         r7duSrq2dX7nN5t1fQ5U2KF5VefwsZH0W+PaWbZ5WsGs0xiUY9LkWP9E1iO70I2ym5uo
         ITEg==
X-Forwarded-Encrypted: i=1; AJvYcCUiDX8Gvk8BJuPbZz5OfgKwodk6/N9NZlmDbKwDGzO8WfR4SBfR9vCj/EAeSMzytxjd9idVksaiAw2sFt3TZir0JCdD20D6QgpqzxNG59htvYGwD/q3GKzHjcH8+eC1AIbrdtepjRveGmeEjbcZ
X-Gm-Message-State: AOJu0YzMSzSuSIkOfPMdWSlJHVTZbcB0RWUFuGpVrXCl2vtG9gJ1CnRb
	6RvSLrrbdsVcyc+C5ATx64IVkd5GxCONLb4sECJnWaI07l0+4U6K
X-Google-Smtp-Source: AGHT+IGxfBYqqld63E5ngU9ZN/rWoICx3xinPE5g5xR8vAnktoXPSpnOQULb1LMDTpNnvjCyQ0ESgQ==
X-Received: by 2002:a5d:6390:0:b0:34e:bdf9:32ff with SMTP id p16-20020a5d6390000000b0034ebdf932ffmr1166014wru.1.1714841107380;
        Sat, 04 May 2024 09:45:07 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:1a4e:d69a:7803:ec18? ([2a01:4b00:d20e:7300:1a4e:d69a:7803:ec18])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b0041ba0439a78sm13514287wmq.45.2024.05.04.09.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 09:45:06 -0700 (PDT)
Message-ID: <f069c4b4-e358-4eac-9780-9ca9c598f7ae@gmail.com>
Date: Sat, 4 May 2024 17:45:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: Cover 'assert.c' with tests
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240427220447.231475-1-ivan.orlov0322@gmail.com>
 <CA+GJov45uEfrXVWSUxvzOLYKPCnTeYeGqHvk=W4n-W_TLYyRuQ@mail.gmail.com>
 <89c0f7c2-145c-4d4c-a330-f0fff5bb4098@gmail.com>
Content-Language: en-US
In-Reply-To: <89c0f7c2-145c-4d4c-a330-f0fff5bb4098@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/3/24 12:10, Ivan Orlov wrote:
> On 5/2/24 00:20, Rae Moar wrote:
>> On Sat, Apr 27, 2024 at 6:04 PM Ivan Orlov <ivan.orlov0322@gmail.com> 
>> wrote:
>>>
>>> There are multiple assertion formatting functions in the `assert.c`
>>> file, which are not covered with tests yet. Implement the KUnit test
>>> for these functions.
>>>
>>> The test consists of 11 test cases for the following functions:
>>>
>>> 1) 'is_literal'
>>> 2) 'is_str_literal'
>>> 3) 'kunit_assert_prologue', test case for multiple assert types
>>> 4) 'kunit_assert_print_msg'
>>> 5) 'kunit_unary_assert_format'
>>> 6) 'kunit_ptr_not_err_assert_format'
>>> 7) 'kunit_binary_assert_format'
>>> 8) 'kunit_binary_ptr_assert_format'
>>> 9) 'kunit_binary_str_assert_format'
>>> 10) 'kunit_assert_hexdump'
>>> 11) 'kunit_mem_assert_format'
>>>
>>> The test aims at maximizing the branch coverage for the assertion
>>> formatting functions. As you can see, it covers some of the static
>>> helper functions as well, so we have to import the test source in the
>>> `assert.c` file in order to be able to call and validate them.
>>>
>>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>>
>> Hello!
>>
>> This is a great patch and addition of KUnit tests. Happy to see it.
>> Thank you very much!
>>
>> I do have a few comments below. But none of them are deal breakers.
> 
> 
> Hi Rae,
> 
> Thank you so much for the detailed review.
> 
>>
>>> ---
>>>   lib/kunit/assert.c      |   4 +
>>>   lib/kunit/assert_test.c | 416 ++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 420 insertions(+)
>>>   create mode 100644 lib/kunit/assert_test.c
>>>
>>> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
>>> index dd1d633d0fe2..ab68c6daf546 100644
>>> --- a/lib/kunit/assert.c
>>> +++ b/lib/kunit/assert.c
>>> @@ -270,3 +270,7 @@ void kunit_mem_assert_format(const struct 
>>> kunit_assert *assert,
>>>          }
>>>   }
>>>   EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
>>> +
>>> +#if IS_ENABLED(CONFIG_KUNIT_TEST)
>>> +#include "assert_test.c"
>>> +#endif
>>
>> I might consider using the macro VISIBLE_IF_KUNIT macro, found in
>> include/kunit/visibility.h, to make the static functions in assert.c
>> visible only if KUnit is enabled. To avoid having to add the include
>> here. What do you think?
>>
> 
> Wow, I haven't seen this macro before, thank you for the suggestion! 
> I'll use it in the V2 of the patch.
> 
> I assume we need to use it in combination with EXPORT_SYMBOL_IF_KUNIT, 
> otherwise GCC will complain on use of functions without definitions, right?
> 

Ah, alright, it seems like GCC is going to complain on missing 
prototypes anyway, so we have to declare these static functions in the 
header file if CONFIG_KUNIT is defined.

-- 
Kind regards,
Ivan Orlov


