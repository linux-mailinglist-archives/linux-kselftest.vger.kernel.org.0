Return-Path: <linux-kselftest+bounces-25518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66295A24883
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 12:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EB83A4A56
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74617145A09;
	Sat,  1 Feb 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di1263yk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5974A3E;
	Sat,  1 Feb 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738408864; cv=none; b=EPnIzB+hqVuAaEhOycLy/1g/L6wCky6IZVARF7Q/NkP5cqtx5RmmoRPgctd4E6UvIilEs9fYKUqlb7p71oo5QRXJfTTpno1qgB1jQymDkVH/D8RY0VTR1f50b0B8/cyEsq6tSGUTVo1MJm5q2+ARFH+wbor25mxmDZUWTn+TeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738408864; c=relaxed/simple;
	bh=Pkz6KNTBDbYPEp20NDDuYafiscU7CmXy27olzQlgkCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdDf4J650ZwfIlLKjyBGF9cmVuT7Mt6C98zFUQw1VaY+RkpOlSGomeOkgV/gMdB01AeLx6Mrg3Uzz8LGi+Ky8pkDxNVt6+cJJgHa6tU+KgxnpsbGKFwcAB8ROdEAZCchGYX6GFEFO9O303FRjiB1x09tOjaHbFBHi2Q52hDXoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di1263yk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2162c0f6a39so70820525ad.0;
        Sat, 01 Feb 2025 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738408862; x=1739013662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpXB01KAhrqJhHJwN7yldMlPl2KTotioErkNMfqnalU=;
        b=Di1263ykdIiL0BMkRN9trkwISGhwvBvMa4nTJlD1+ApLQHlM/pn2VwQP5AalsbU13I
         hDkufmxqh4wDWKQdI324ROMF2IYyzLy+vOtnzvDntw38pX2EjRWHiYsL84iid7tTSCkA
         rqCLH+O1SKbs/UBbW+++SzUlK26NthNF7Qdxc2PmGNqcpvPhQ/ELY9h5iiwJJ/kaOF+9
         suKcHHbCVFdqumyO2vP4ZJGTeRi56pJBSkkcTnp1T5lLGhETY30F0XAXJQbbA6/9I8Au
         Sm4Ic85pIKcWA/ZaBbtjL1QDWEoJNEHDv4Try1F2x0mj2uRTaLvEffinR18DVbiiO387
         Cqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738408862; x=1739013662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpXB01KAhrqJhHJwN7yldMlPl2KTotioErkNMfqnalU=;
        b=Anyz70OO2n1TS1flxqYkYLsSoFLd+v6M7AtExTiZuieqF0AWjJ5U/dJT1bstWSbxSK
         AXy6LngXPiddLkHdZeWHzvakdbuZJcjf4LTlUBNjXRJYuQIMavXSsO5Okru65+JgqoD7
         6X7aHP0F9V2R32q2Z+QWNW4kAIYYIWJIXdR0MqnHitO3vygClIEp18Zn6QlVq3l2PUfv
         rtw5bip1MuZVQt/vwm1yo6YhQgIps9Uu2SdeApljp7Nq/InbTiJZWWmLXGRfH6j1oVHt
         rQnhaDgDgknY473caNTptEwom7yzI0/kJ6ElvSDhV6ZM9rPiQ7xXHNXSywVl0uidYTMp
         zHGg==
X-Forwarded-Encrypted: i=1; AJvYcCUPrkBBN9zvDv9Fc9dpfJKPobhIc/SfT6dd66mG/jbeZZn2CawCOT9R70py0GTYFaCAUYyU8zdoEsn22Pw=@vger.kernel.org, AJvYcCWxbMoftEzhfQTkATCF6mK9xumWhjofl22paqUI2o/nab+upkQXZ/nVfDAjrr8fS8ek+Mzvod00ANB/3UshcKor@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGCO7K2j6T5MUyT9Qh+XVckRJAlskDntTQET5UkSeveuTD3/y
	UKnKqbWsz6+l2MHcIFmotGhvRGW5xHXGrg2SHCZN3R5NHp9BULQkEq7/1EU1/hg=
X-Gm-Gg: ASbGncshovH+jQpUNwKtLgI2pit9rI4SoZ2HHSVwq3Hqh9zOC+t6piiR6ClXdAIR5RW
	ZQrqXE8mMM3apBqzQnVlIQHY6gJUmwwNo5kOk62W9q43VDoMeYpXEIkUuG5dLAIB45t5X9rDrJ3
	Lqra27SfCl7HjZXkVEflJMY1r7cdVArcryvv8p9VNWsunE5ocDt0p7/ItJMiIqxhxKzIcM3jaaF
	nvBaJMRCygLvQa18sJJGs0RJ0Vl+O7qlFWn7g5AjRSzvGfb9tgsXvxAixm/eD+rFJjTqP1gJ1bS
	Nl1wXHIB0s9w/h+rdwWqrD89kYm1NVagh8IYEMlKjha91dZhlMNbdGUQXG5atmOt0ffNsw==
X-Google-Smtp-Source: AGHT+IHN+mBNBPkLxrKNYilnN9ZM4/vcCO/uUgYYvC+5rHQngX7sQc4gsrp8y9ARjCpsSZJMYDrQZw==
X-Received: by 2002:a05:6a00:35cd:b0:725:d64c:f122 with SMTP id d2e1a72fcca58-72ff2b48d88mr11362863b3a.2.1738408861922;
        Sat, 01 Feb 2025 03:21:01 -0800 (PST)
Received: from ?IPV6:2409:40c0:1035:9c47:d3e9:3f8e:7f5d:858a? ([2409:40c0:1035:9c47:d3e9:3f8e:7f5d:858a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1cb70sm4737608b3a.180.2025.02.01.03.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 03:21:01 -0800 (PST)
Message-ID: <0f8eed3c-d485-4fbd-98d5-d6c4066789a6@gmail.com>
Date: Sat, 1 Feb 2025 16:50:55 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vDSO: Fix undefined CLONE_NEWTIME by including
To: Christophe Leroy <christophe.leroy@csgroup.eu>, skhan@linuxfoundation.org
Cc: shuah@kernel.org, Jason@zx2c4.com, liaoyu15@huawei.com,
 broonie@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250126105932.63762-1-purvayeshi550@gmail.com>
 <d85f9c94-249a-4847-a323-2f547fe60732@csgroup.eu>
 <171e15dc-b48f-4592-8466-b220185bae78@gmail.com>
 <3150e796-9249-4ac1-a91a-7efb7ec4de16@csgroup.eu>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <3150e796-9249-4ac1-a91a-7efb7ec4de16@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/01/25 12:32, Christophe Leroy wrote:
> 
> 
> Le 29/01/2025 à 19:17, Purva Yeshi a écrit :
>>
>> On 27/01/25 13:32, Christophe Leroy wrote:
>>>
>>>
>>> Le 26/01/2025 à 11:59, Purva Yeshi a écrit :
>>>> [Vous ne recevez pas souvent de courriers de purvayeshi550@gmail.com.
>>>> Découvrez pourquoi ceci est important à
>>>> https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> Fix the build failure caused by the undefined `CLONE_NEWTIME`.
>>>> Include the `linux/sched.h` header file where the function is 
>>>> defined to
>>>> ensure successful compilation of the selftests.
>>>
>>> This is supposed to be already fixed by commit 34d5b600172b ("selftests:
>>> vDSO: Explicitly include sched.h")
>>>
>>> Can you explain what is the exact problem still ? And why 
>>> linux/sched.h ?
>>
>> Yes, I noticed that sched.h is already included, but I still encountered
>> an "undeclared CLONE_NEWTIME" error during compilation.
> 
> Must be that your sched.h is not up-to-date I guess. On my side I have:
> 
> /usr/include/linux/sched.h:#define CLONE_NEWTIME    0x00000080    /* New 
> time namespace */
> /usr/include/bits/sched.h:#define CLONE_NEWTIME    0x00000080      /* 
> New time namespace */
> 
> And
> 
> /usr/include/sched.h:#include <bits/sched.h>
> 
> 
>>
>> Error I got:
>> CC       vdso_test_getrandom
>> vdso_test_getrandom.c: In function ‘kselftest’:
>> vdso_test_getrandom.c:257:29: error: ‘CLONE_NEWTIME’ undeclared (first
>> use in this function); did you mean ‘CLONE_NEWPID’?
>>    257 |         ksft_assert(unshare(CLONE_NEWTIME) == 0);
>>        |                             ^~~~~
>> vdso_test_getrandom.c:47:20: note: in definition of macro ‘ksft_assert’
>>     47 |         do { if (!(condition)) ksft_exit_fail_msg("Assertion
>> failed: %s\n", #condition); } while (0)
>>        |                    ^~~~~
>> vdso_test_getrandom.c:257:29: note: each undeclared identifier is
>> reported only once for each function it appears in
>>    257 |         ksft_assert(unshare(CLONE_NEWTIME) == 0);
>>        |                             ^~~~~
>> vdso_test_getrandom.c:47:20: note: in definition of macro ‘ksft_assert’
>>     47 |         do { if (!(condition)) ksft_exit_fail_msg("Assertion
>> failed: %s\n", #condition); } while (0)
>>        |                    ^~~~~
>> make[1]: * [../lib.mk:222:
>> /home/purva/linux/tools/testing/selftests/vDSO/vdso_test_getrandom] 
>> Error 1
>> make[1]: Leaving directory 
>> '/home/purva/linux/tools/testing/selftests/vDSO'
>>
>> I found that CLONE_NEWTIME is declared in both sched.h and
>> linux/sched.h. Since sched.h was already included, it was surprising
>> that the error persisted. Adding linux/sched.h as a header resolved the
>> issue, and the selftests compiled successfully after that.
> 
> Can you recheck that the sched.h that contains CLONE_NEWTIME is really 
> the one used by your compiler ?

I rechecked the header files on my system and got the following output:

purva@purva-IdeaPad-Gaming-3-15IHU6:~/linux$ grep -r "CLONE_NEWTIME" 
/usr/include/linux/sched.h /usr/include/bits/sched.h /usr/include/sched.h
/usr/include/linux/sched.h:#define CLONE_NEWTIME	0x00000080	/* New time 
namespace */

This shows that the definition of CLONE_NEWTIME exists only in 
/usr/include/linux/sched.h

> 
>>
>>>
>>> Did you properly build kernel headers before building selftests ?
>>
>> Yes, I ensured that I properly built the kernel headers before building
>> the selftests by following the documentation provided here
> 
> 
> At the end we should probably wonder if we want selftests to build with 
> old libc's that do not include latest defines. If we want to, then you 
> should probably replace sched.h by linux/sched.h . I'm not sure about 
> what to do really.

Since sched.h from libc may not define CLONE_NEWTIME on older systems, 
should we explicitly include linux/sched.h to ensure compatibility with 
older libc versions?

Thank you for your time and feedback!

Best regards,
Purva Yeshi


