Return-Path: <linux-kselftest+bounces-9369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C248BAC34
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 14:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031751F237C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153161534E0;
	Fri,  3 May 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho8smVSd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312F9219EB;
	Fri,  3 May 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738746; cv=none; b=HHgOZmZtFvbYpTLyQaSZF+Inxlr8wSkvfkrCE22ia8CXQ0PbDk2/cD5m74Nkk1d2qjiFm5nn8yZ69BTyFZeYJBDFPyIdavnxbmmaoxEDa6S0O97oImVIl+rDPHUBQD8k53Ap6ky0MM9GCki978NrEiuWprnqtya2fPRgmFNnDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738746; c=relaxed/simple;
	bh=6gKn9QPi0z7knofzQyy7QIG7JzQko8aNuX/0O0sK8hc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eLMKhEv2FofLZaZiiq/wXrir74MUR5uyZ5vWjjpd0HB990PPEr9WlI8X8z2na/F1IcY+LsxDW9l4DcqsHvqScj0wtbAwQBLSUZ2ou0w2X4l+7Ml5J/6w5PhcV+70y9GseEAVvqqcrrf96McnHwmR76jcRZbzb8xPtn7toI2lktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho8smVSd; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51faf2325f4so83392e87.1;
        Fri, 03 May 2024 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714738742; x=1715343542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yahvMJQIrLp7vbvM1QrDQybr5qXlcpY1TYPX1ymXTw8=;
        b=Ho8smVSdevePzfNaT48c/pSbnAXu+L9dBn8FWpQ471Ol3B17r355UGnaFYCDCPSakQ
         ss5DgQG5UDkzHGmQMFBI8tiYLxnN9zo1hk08oGBc63IoXGlFXCgGt/1AGBh/RlReGVM8
         evmlx69Gu695BVu4xxA6LkVOSn3NhcdBupsjcqiulV0VZGg8sLVioqWnJdn7f1HXKClX
         6PuYF5Cu5j+W1Z7CBS3aa5bFFUsPLuC8YA8DRBv7kbRdjXiycYmbr4ZH+2usxN9i3cd7
         nNyJ9dJReV6SY+SShUrMOQ2a2knfVOY1n87zPxyvPb8tZJ+hfs+gthqS7Fq17g1OM8Nr
         hPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714738742; x=1715343542;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yahvMJQIrLp7vbvM1QrDQybr5qXlcpY1TYPX1ymXTw8=;
        b=uh52+BUQJ9BE7GNX84Ht8QBTZVUjxU5yp9ASI7+w5ZvelP/i9OnlbdXrfQ524voE8P
         qKW9v9o9PTa0CUEtywjvFqQgt0cTnroMEAszf1CM1U7xUW32ucaaC6P7VdOzglHWyO+Z
         voTq4bAmZiS10s9YmXRUnrvobyt9yh6FPwkZyB73r4yHyvCtK/5y46g9gIh80H70afSL
         dKDN0wg5dBYmfRyIKcapwI2F2ZY5CpTQFq2kgQsT7r2v9e52BhTFkUqC8RlhDstjZ6NE
         be+SwkiErUOyBLCdurlKjhP0BGQCvXZoxbj2HervDwgcIFdgdwx7q+ts8MiJ9wIl49eT
         7kyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNSht7ClGMPQQ9fFW9n8OBUfVIum65k0ArzisiPrfoYzrav0Toj+OIwt2N0aEnE6HZXkEMPb2lDJGLHiRQajGtrUMZTEFI+es1PlH7ZbSOxU45kNjHXwiqT67GW7rHtci+GF/Jun3w+UFj/h25
X-Gm-Message-State: AOJu0YwCGBGGA+8k5BNzNrDcf22L6L/UGabJliJ4+VxiIVZhGSC+QHWp
	RTYn58CehOZl36GEvJh3gt6ZM9bl1ajhowgO5cWXdJhZgekH70no
X-Google-Smtp-Source: AGHT+IHC6ftcvIHtFfuviR7nKafG5DaRoBhLQ9v4ds663Npa8xhUBqcfe8H8jGdMMUn0kTs7sk5KlQ==
X-Received: by 2002:a2e:9482:0:b0:2e2:1647:8308 with SMTP id c2-20020a2e9482000000b002e216478308mr1626554ljh.2.1714738741868;
        Fri, 03 May 2024 05:19:01 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id g17-20020adfa491000000b0034de87e81c7sm3673218wrb.23.2024.05.03.05.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 05:19:01 -0700 (PDT)
Message-ID: <8fbe310e-5b2d-4ac0-95f7-4b09a069a7d6@gmail.com>
Date: Fri, 3 May 2024 13:18:58 +0100
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

s/definitions/declarations/g :)

-- 
Kind regards,
Ivan Orlov


