Return-Path: <linux-kselftest+bounces-25391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBCA223C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 19:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99B51685B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFF91EBFE1;
	Wed, 29 Jan 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsXYd6rO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F81E9B28;
	Wed, 29 Jan 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174683; cv=none; b=nX/wLe+DiHOz1//oDNXBHwfDZ7oscQ8ObMd0Gc2bRVJWyG2jOwTWuiGnIcI+Nl3Wh9HVujRlMYLPVfa5v3O2zabhhrsHMj0B6jbuzSXiUjo0eY4W35DOHaIgERk74pADip9ND2xoJVv1Zx2NdA42MGRBRXv+CLUSTxda9s0PawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174683; c=relaxed/simple;
	bh=2BgBH0WnCQhzjZtmH9OlPzrTRHx4aC+Qf+UOnJX7KyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBGiscAsZEFncLQYSy0noBC86geciI+OOuzt7nkXEslDRYxpIGjsg9KwSyfQML42edut8NpyWcxtjzagpVWjuL4BIbLYHjTH49opdFn6kA9Gxa9NjDdqGqzaoCJcp+EsEB+48q4l0Tr1dYHAbb2eMmQbKzzCl7xNprMg9AU/4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsXYd6rO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso9641866a91.1;
        Wed, 29 Jan 2025 10:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738174681; x=1738779481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reym2V+AroeXk1LWaME/n2ncYtxOnWfm8JMHRVV0hCU=;
        b=QsXYd6rOkw5pp0LfA7HLJLpH8TqFNrd23uXv0RJ5J5RAUR7/1N5bFS2d0pbmwOBhlW
         +xCEYOEunDnCrp4aK7Y8RwBFvEtmo5MjqiFIVU6EummNp66wIN1b5QwI7Jz2FJ2YNLK/
         5f01eNZ6s8qfMJH34kEMZbvso4+J3FqVDPbXAaAW5tjo6dOcHVGo0MP7TH7t6O766tNR
         KXDKIAyAe2F9F1my/cP/IW6MyYI+BZwDcoNR4y017qUYSOUqnp84+ozyEg2LIDGntwXL
         WINnrLxRPc/BB9EoHtRNrsbGOZnjqQI2OQjvmI4av0qxWFtckxa+ULn1HDoWMawUEdaG
         qWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174681; x=1738779481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reym2V+AroeXk1LWaME/n2ncYtxOnWfm8JMHRVV0hCU=;
        b=OY1IhrgN5LcTaap638oXJS6JBVIKmllxE73qh904dkj1u64utU7E1yZYX+dimKpzl0
         i7hFdHVBkic2uSzDtS7+2vZ8aRt51y4wXKdDUHiNednMaq9M4V7XFz8UcT5OBhfeEzXi
         FT9advt3TgxCJ+T54N4OgM9VeoBTuNrjRj+WbH3bVnzAgzdA0uxgWmhEywhDvL7Rq3xC
         I7/F2FmmACBUsuVxP5hGYhbauRJC/iFs4Q3fbUiIs53bJY5TBiHSW1xaaSp8IrCnNRSJ
         j/rb1NqULLsJdVnsOLqod2EL2GPC6b/WYy/GMW1jHGTuoDZhho9fAAE8/OrH5dqZ6pkR
         AsBA==
X-Forwarded-Encrypted: i=1; AJvYcCUXHLwHJgbPRsjwLZs0I9eY1/qpfz1ZPJRG6c7yWrE+QVJhOGG59EGmK80dgsgHTWOA1vxRGmafsllRjxsbzSG9@vger.kernel.org, AJvYcCX0CEPeiXedav+Tc936Ecgv+7Ivxb1J2AsgQknNKqM8/PeVuoJAB8vpPahukCky/VtuBmsq25FeD3GjW4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6P2DvhQa13m8JyAwKBlcfarcB5iZGQ0kcLbgd6HDD7E0CAQjt
	VUjg5pFPSS4mcx5D+Wds3/2lPtLLn8tcEfDjMzSrl0wYIQ1HaOah
X-Gm-Gg: ASbGnctaZ0mlqYo+yLHPRObCjIDPMV8sl0y22jkgmYm04CNJQ5yWygBPt+1waOdkxAd
	EFeudGsEyLbGWqYqW4AvabI4zLy+NO9RekkznmzRGIZYPN+wjC0y/J+Wqk6opqofS9Ui/D6hdGj
	31xwg/sSrsqT+nIBAvSsxJglHYEGn+HN4nrpYyKTkq93Jop2xcKeKDPDfFgw1IP4Zyu33YQrIlc
	LWKzJtr70iCGEBv8L8j/HVzHs+gywTKYTsQrv1hVSK+GA/If68FgGD8/8aU/J8HqC2rRSuT6RgX
	hcd8GWteuhlc9esn5Q7McURbvMeA0pZBTOVRL9wFh9AQ0Qg5eV3QavkzL2UezQ==
X-Google-Smtp-Source: AGHT+IGMxStAEw2r76nBYqto/uRPmM4hZiXqS48Or7NV8Im8HQXjG23H2iA8imnj0xJ/NW7mTcjFoQ==
X-Received: by 2002:a17:90b:41:b0:2ee:e961:3052 with SMTP id 98e67ed59e1d1-2f83abf3511mr6619310a91.14.1738174681440;
        Wed, 29 Jan 2025 10:18:01 -0800 (PST)
Received: from ?IPV6:2409:40c0:67:8297:9f66:e40a:ee99:bdd? ([2409:40c0:67:8297:9f66:e40a:ee99:bdd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83be1c37dsm2249579a91.34.2025.01.29.10.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 10:18:01 -0800 (PST)
Message-ID: <171e15dc-b48f-4592-8466-b220185bae78@gmail.com>
Date: Wed, 29 Jan 2025 23:47:51 +0530
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
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <d85f9c94-249a-4847-a323-2f547fe60732@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/01/25 13:32, Christophe Leroy wrote:
> 
> 
> Le 26/01/2025 à 11:59, Purva Yeshi a écrit :
>> [Vous ne recevez pas souvent de courriers de purvayeshi550@gmail.com. 
>> Découvrez pourquoi ceci est important à 
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Fix the build failure caused by the undefined `CLONE_NEWTIME`.
>> Include the `linux/sched.h` header file where the function is defined to
>> ensure successful compilation of the selftests.
> 
> This is supposed to be already fixed by commit 34d5b600172b ("selftests: 
> vDSO: Explicitly include sched.h")
> 
> Can you explain what is the exact problem still ? And why linux/sched.h ?

Yes, I noticed that sched.h is already included, but I still encountered 
an "undeclared CLONE_NEWTIME" error during compilation.

Error I got:
CC       vdso_test_getrandom
vdso_test_getrandom.c: In function ‘kselftest’:
vdso_test_getrandom.c:257:29: error: ‘CLONE_NEWTIME’ undeclared (first 
use in this function); did you mean ‘CLONE_NEWPID’?
   257 |         ksft_assert(unshare(CLONE_NEWTIME) == 0);
       |                             ^~~~~
vdso_test_getrandom.c:47:20: note: in definition of macro ‘ksft_assert’
    47 |         do { if (!(condition)) ksft_exit_fail_msg("Assertion 
failed: %s\n", #condition); } while (0)
       |                    ^~~~~
vdso_test_getrandom.c:257:29: note: each undeclared identifier is 
reported only once for each function it appears in
   257 |         ksft_assert(unshare(CLONE_NEWTIME) == 0);
       |                             ^~~~~
vdso_test_getrandom.c:47:20: note: in definition of macro ‘ksft_assert’
    47 |         do { if (!(condition)) ksft_exit_fail_msg("Assertion 
failed: %s\n", #condition); } while (0)
       |                    ^~~~~
make[1]: * [../lib.mk:222: 
/home/purva/linux/tools/testing/selftests/vDSO/vdso_test_getrandom] Error 1
make[1]: Leaving directory '/home/purva/linux/tools/testing/selftests/vDSO'

I found that CLONE_NEWTIME is declared in both sched.h and 
linux/sched.h. Since sched.h was already included, it was surprising 
that the error persisted. Adding linux/sched.h as a header resolved the 
issue, and the selftests compiled successfully after that.

> 
> Did you properly build kernel headers before building selftests ?

Yes, I ensured that I properly built the kernel headers before building 
the selftests by following the documentation provided here 
(https://docs.kernel.org/dev-tools/kselftest.html#running-the-selftests-hotplug-tests-are-run-in-limited-mode). 
I used the 'make headers' command as part of the process.

> 
> 
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   tools/testing/selftests/vDSO/vdso_test_getrandom.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c 
>> b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> index 95057f7567db..b2c9cf15878b 100644
>> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
>> @@ -29,6 +29,8 @@
>>   #include "vdso_config.h"
>>   #include "vdso_call.h"
>>
>> +#include <linux/sched.h>
>> +
>>   #ifndef timespecsub
>>   #define        timespecsub(tsp, usp, 
>> vsp)                                      \
>>          do 
>> {                                                            \
>> -- 
>> 2.34.1
>>
> 

Let me know if there’s anything further you'd like me to verify or adjust.

Thank you for your time and feedback!

Best regards,
Purva Yeshi

