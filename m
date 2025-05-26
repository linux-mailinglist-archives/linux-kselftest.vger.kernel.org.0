Return-Path: <linux-kselftest+bounces-33773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6AAC3D0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 11:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B38F1888A7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514B1EFFB2;
	Mon, 26 May 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="t75CBBJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CD19D88F
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252300; cv=none; b=oiubRXIcoU54rrxKU4BAKggOkRgVyRIcyoM4o/CVuCJRjTcpuIdFgSavciz7TXHZ6KQX9AUe4KJnvHicNrimhj41iWYjDv4MQZ2zcr7tNLhmsIVYnQVK7bBwsiDyDmgMLRZY251SW+wEsssNauR9HnY2BkBj7KLVcD+UPcs/8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252300; c=relaxed/simple;
	bh=i9i8/ewq7VfXozbNbj+b/u9iFiv/PHquWUPkUve+/0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uG9mqbNPlgATCrFh7z0qk2iF5pvAmLumxWBkUNHIgQnAQhnuC3yoBAkikuCW3PNDKzbnYsq2u4A097A7QFSYGEFfMGTJWmC5721zD2xCUpXJT8fqpmlV95mugOIuFQzwS9J6KlrgX1rA9141fdiU4kvZU8Owr6Lg56ide3ac3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=t75CBBJ7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7426c44e014so1546395b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748252297; x=1748857097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ayXEI8Cfv1/N/P9sk6QD8plzK1Zh4bjNNg4FyYTKeW8=;
        b=t75CBBJ7R1LrkYCsBz5TIfMTqIl70m9KyqO7kgTF4RIHArUiDG3ZzgE1UVinXfohWk
         GJ9cvQDAcoC/365RclM8JQL6xgG9pCX2slQfk/2DvrMbhVqdP8ZBZMJ+Al+U5ODE5Mhc
         mp+M+7B7u8vQ7ENRPl6mzi0UZle+l8TqTtl2BmcoRorbmkr9sgdbD64QW0KEz8iopxT1
         shCd5t/b7KEM92tFRZcN//Cxs23PDZt9jwtHhF7l5d1gTT+FpFqoj168WEvVYfqku8sq
         gKLUvQdgDMvsLtsdUPHAoP3OpR0pFkmEleuPHHsfGjcnZRzU8JCOTCvWzEwMulLXWrDC
         gxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252297; x=1748857097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayXEI8Cfv1/N/P9sk6QD8plzK1Zh4bjNNg4FyYTKeW8=;
        b=VoNt6OGnzPg7mBELDrKuut8W93KI1xXr1wFymRSsN3xWbTa3gftZTWnjTnuxqNbqMD
         SB67iGexL3pZHD6akBCW7/m2ozIw1uhE+pP3HZUJtd/6h7CK0tLqJM32ZZHF0XAguEIi
         W3JmInyWiXiVpwIdTbeGzTUjJCwkXpvB68d0g4ZqFuwJbmOp6HDqhmQRRW3alfuu/hZm
         vXmmNyA6x7V+bHSdn69E974XJ+U+X+balLd/PpB9CyzV3VlJosG9rN7o940xpcazVJYR
         9ndtp0UBy6UmUISPNs0L7diqX3gXDLSqqDMnbaM/S8v0E37ztKmBe+CSqTR/Ii4wx12o
         KF4g==
X-Forwarded-Encrypted: i=1; AJvYcCWpdMD+/hFrIKxeVSR3NEnW/7/36FVah7o4ks5Bjpw3QOVmrAGYktTKOhi4xzyk4xwfrIIHQY97OsQMYnMBKC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUYEZOazQnKS0vgXSfU0b+INUrlOXFGstj81o+373JD+yiYBx
	P5iuWvozd2T7xfnI+j03wzAXL9ZeGKagF1qG+M+hdF5ldTB+75nlOX6VJFZNv1Fduhc=
X-Gm-Gg: ASbGncth9skPK5S8Gf9r5CEajXIQGm/tgVz0KHUXOndGyvPRrP6Vvtstxfo+iXB8tk6
	iJLZDCk2ZJWyzaTdoLH8e/z2rqKGPXmvXRbEuP/Yqq9H7SQLTrfWwg2NRhYrDbMPDnSd2GA12Nt
	EAl6uOCXC/ebLFM5RaUcZhAS9GTjbNzUu4/6PzDb6wy5DQKGs1VsKD3NtXtgHMA4x0NC+8xp+jr
	Oof0GS8J3oyMj74akw66B/6RvGNqiVVaUttwX4k/kGCE2rEyFkVhSI+a4o0nw160SijvAfmiMkP
	IQkiHL8GTsB+jCibXSQyf3TQc2fcLtJM0ebbo7TUlpV9t/98u7jOMfG1k5hQXBi0PoBO3B1wbjN
	g61dnBbFzpQ/0l0p1qPs/
X-Google-Smtp-Source: AGHT+IGtpgkfGcWHXNllZ6N7OfshZvdC/ul39y9uFpqnjdl5yZSiN5+nr2uee+5tOzhJpdCxTYM3zg==
X-Received: by 2002:a05:6a21:8dc6:b0:20d:5076:dd78 with SMTP id adf61e73a8af0-2188c3c78f7mr13332787637.42.1748252297429;
        Mon, 26 May 2025 02:38:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a4af6sm16624196a12.77.2025.05.26.02.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 02:38:16 -0700 (PDT)
Message-ID: <20aeb166-6128-4dda-a963-c9f66f491bcc@rivosinc.com>
Date: Mon, 26 May 2025 11:38:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/14] riscv: misaligned: move emulated access
 uniformity check in a function
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>,
 Deepak Gupta <debug@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-10-cleger@rivosinc.com> <aDC-0qe5STR7ow4m@ghost>
 <b2afb9c7-a3d2-4bf6-bfaa-d804358ccd88@rivosinc.com>
 <20250526-baaca3f03adcac2b6488f040@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250526-baaca3f03adcac2b6488f040@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/05/2025 10:41, Andrew Jones wrote:
> On Fri, May 23, 2025 at 09:21:51PM +0200, Clément Léger wrote:
>>
>>
>> On 23/05/2025 20:30, Charlie Jenkins wrote:
>>> On Fri, May 23, 2025 at 12:19:26PM +0200, Clément Léger wrote:
>>>> Split the code that check for the uniformity of misaligned accesses
>>>> performance on all cpus from check_unaligned_access_emulated_all_cpus()
>>>> to its own function which will be used for delegation check. No
>>>> functional changes intended.
>>>>
>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>>> ---
>>>>  arch/riscv/kernel/traps_misaligned.c | 20 ++++++++++++++------
>>>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>>>> index f1b2af515592..7ecaa8103fe7 100644
>>>> --- a/arch/riscv/kernel/traps_misaligned.c
>>>> +++ b/arch/riscv/kernel/traps_misaligned.c
>>>> @@ -645,6 +645,18 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>>>>  }
>>>>  #endif
>>>>  
>>>> +static bool all_cpus_unaligned_scalar_access_emulated(void)
>>>> +{
>>>> +	int cpu;
>>>> +
>>>> +	for_each_online_cpu(cpu)
>>>> +		if (per_cpu(misaligned_access_speed, cpu) !=
>>>> +		    RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
>>>> +			return false;
>>>> +
>>>> +	return true;
>>>> +}
>>>
>>> This ends up wasting time when !CONFIG_RISCV_SCALAR_MISALIGNED since it
>>> will always return false in that case. Maybe there is a way to simplify
>>> the ifdefs and still have performant code, but I don't think this is a
>>> big enough problem to prevent this patch from merging.
>>
>> Yeah I though of that as well but the amount of call to this function is
>> probably well below 10 times so I guess it does not really matters in
>> that case to justify yet another ifdef ?
> 
> Would it need an ifdef? Or can we just do
> 
>  if (!IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
>     return false;
> 
> at the top of the function?
> 
> While the function wouldn't waste much time since it's not called much and
> would return false on the first check done in the loop, since it's a
> static function, adding the IS_ENABLED() check would likely allow the
> compiler to completely remove it and all the branches depending on it.

Ah yeah indeed ! I'll do that

Thanks,

Clément

> 
> Thanks,
> drew
> 
>>
>>>
>>> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>>> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
>>
>> Thanks,
>>
>> Clément
>>
>>>
>>>> +
>>>>  #ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>>>>  
>>>>  static bool unaligned_ctl __read_mostly;
>>>> @@ -683,8 +695,6 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
>>>>  
>>>>  bool __init check_unaligned_access_emulated_all_cpus(void)
>>>>  {
>>>> -	int cpu;
>>>> -
>>>>  	/*
>>>>  	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
>>>>  	 * accesses emulated since tasks requesting such control can run on any
>>>> @@ -692,10 +702,8 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
>>>>  	 */
>>>>  	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
>>>>  
>>>> -	for_each_online_cpu(cpu)
>>>> -		if (per_cpu(misaligned_access_speed, cpu)
>>>> -		    != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
>>>> -			return false;
>>>> +	if (!all_cpus_unaligned_scalar_access_emulated())
>>>> +		return false;
>>>>  
>>>>  	unaligned_ctl = true;
>>>>  	return true;
>>>> -- 
>>>> 2.49.0
>>>>
>>


