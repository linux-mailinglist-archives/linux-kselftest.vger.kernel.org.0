Return-Path: <linux-kselftest+bounces-36979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7DB00546
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E6E3B3D56
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3C12737F6;
	Thu, 10 Jul 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NWBVZUWG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328438F5E
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157797; cv=none; b=HJRsaW8a0eE0hEwmJAywHbQ/6L9969hE/1Nw43N9qN7FJLGm0uwWiGgjL4d6/ZPNqlCgeTySCXbF5zugobo8Q3W4Hos8XhOoa2zwGWS4E8km2BUi6zZYuiGjTrydQZVcfaz24hYO4g3vkzn5VUIWGten4UJiHAEo4stEPgE2vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157797; c=relaxed/simple;
	bh=oZ7OonWWPb3CLzQvpruAiAZiFnf3bbsaJiYraXkrTTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGuvf/lVaARJjVpcBMSbuTtkX6OgGre2B7M+J6FhM11UD8frECAXMHhxCxj177GCDDeJM5WkmECiMuf26h66hLfylS+JB74fUmR64bCEdBi8mquXKe8r9gYs3xBTlyUbkbgndfIxiuhyKPAgLWMff4t6wdJCMYmg0dlspP/xz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NWBVZUWG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b54cead6cso800402b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752157794; x=1752762594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70T/mtOHoW67bNGMf99k1u6kIp6BUIzmEHFhVe6xe+4=;
        b=NWBVZUWGh9uoxmAsbhwkX5ajR1Dgt+7wCMG+931urg350JwjgwF0rcZ38mkqF6KtJx
         GEYG1ZA9cV7SrXWxr3HOESSdyEbIQ6VGVG8UouGNMIuSwoAYnahqrXPIR+4LkaIKgRc/
         m/PU6vp4wdkAjrRsD3Qt970M7DB/EQuaivplZCXScf6O+teH2RL8zcBKunLVjdVnfG44
         ckuD9p9KltPZpt2e9nB1IWQJ8KsNBSbrFWp8fkuNNpzMaN/JJXoXk/Mr8/zWza5DXOMN
         LsfS3is+PpJqxvbrE7ZncJ8rEUv/87uRSpO6P8MMYGYIdPwthiPxoMldZPn1OMYPrKHi
         /Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157794; x=1752762594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70T/mtOHoW67bNGMf99k1u6kIp6BUIzmEHFhVe6xe+4=;
        b=ZPST4gfnKW+R4mfCe10BrNd6+DUgR1GftvCJ4fp/ofsyXmgPwI+PqjDRESGTOW5Byk
         KrnIodrQhl5wQl8FG7vzqMkfRHsFVKCujgp6KgUs9SHDXpTIdYLxkGPhL01dZSWxhzke
         Bcw6Zb/khEOIHznK8N5EgkUJJ7GqrvX8SzdSUIHEH6iMyBq47Jcznr1WAdXSPLZSlNeA
         f9zIELoNlkzenKDKOTO4bpFIoxk1DNgcVX+3Wxx5NHl+E4iETwE/EhQLK+szSB+c4MQb
         hgkgr3aWuQH1lGG4T/+7/VHb8W1PrxzgHeYH8clmO+jyhFes7HusT/xUtte19mc9Clh9
         aN7A==
X-Forwarded-Encrypted: i=1; AJvYcCULhyMbdG5D4kxsR737Q66fi73zRhslj2KS35P4Fh6umLAeVYI+iqrqPj8KR0PMEBBwjTrWZp7pQTlpERRs7xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKOIl0/eVbselZDPdk471agOpoEbPyLYzFQNmxv8Vpr5RLvOI
	z4RJn/W+JFSI9NecOBhGMtuL2h8TZPg+6tzkYro6cLUea2veKik/TaI/4b/Ccrm1wRA6trrmlJh
	onWrXh+g=
X-Gm-Gg: ASbGncsocWqKq+rpHy1SSr8P67rOKnOyyhjJoh22BCaaEBK9Fnuh1y3hqOZwCW2gbwu
	PbWO76bXQDR+ToMq9rHk2F0UofDpTNHSGMrrCk+knhavwr1H+y+Jr6nq6g1QBddZ/rF5IDtNKQY
	fqw69Ey7wEXUZ+1dHM5sWTybsOSpT8vl7rhqUEm4UEFqARBWpdxZNu+kbSg51jI/d+9WIoUjtYo
	R9MhuppGpzNWHueHYEJ1xNSxFK8z0vOdiTV08x74YZyNPRpBrS/jpHcfeWf7ds/efSgjJHVZCGV
	u2jnq6KmzH6zuDbX+UcIXeUpG88QReb0q0DMv885NXVHytUlW5hFt4zcxniEWOjlopwhcQUwEMh
	MgH5tZ10Vzp4j6jtgUxVmHmtkEzbsoPW7/f7iUaIzag==
X-Google-Smtp-Source: AGHT+IE6cvc4FDu4lXrrdeGKWhRLkK/Uxe3lGtKWtoiWILObMjxluEPeqmm80yVTtrJwg3ohULnSwA==
X-Received: by 2002:a05:6a00:a27:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-74eb558edfcmr4844441b3a.15.1752157794423;
        Thu, 10 Jul 2025 07:29:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6c5660sm2390825a12.48.2025.07.10.07.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 07:29:53 -0700 (PDT)
Message-ID: <c244c1d4-fef5-439e-8dfe-12c2f8910b18@rivosinc.com>
Date: Thu, 10 Jul 2025 16:29:46 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] selftests: riscv: add misaligned access testing
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20250710133506.994476-1-cleger@rivosinc.com>
 <mvmecuognj7.fsf@suse.de> <5db9ec69-d0e4-4113-a989-ac75d0f1e5dd@rivosinc.com>
 <mvma55cgm63.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <mvma55cgm63.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/07/2025 16:23, Andreas Schwab wrote:
> On Jul 10 2025, Clément Léger wrote:
> 
>> On 10/07/2025 15:53, Andreas Schwab wrote:
>>> On Jul 10 2025, Clément Léger wrote:
>>>
>>>> This selftest tests all the currently emulated instructions (except for
>>>> the RV32 compressed ones which are left as a future exercise for a RV32
>>>> user). For the FPU instructions, all the FPU registers are tested.
>>>
>>> If that didn't catch the missing sign extension that I just fixed in
>>> <https://lore.kernel.org/linux-riscv/mvmikk0goil.fsf@suse.de>, you
>>> should consider extending the tests.
>>>
>>
>> Hi Andreas, you link doesn't work and I didn't find anything about sign
>> extension except a patch you wrote for arch_cmpxg().
> 
> lore.k.o is currently down, here's the patch I have sent:
> 
> From 77c8255da24ee4fac54e2371594d7210d1ddee19 Mon Sep 17 00:00:00 2001
> From: Andreas Schwab <schwab@suse.de>
> Date: Thu, 10 Jul 2025 13:52:35 +0200
> Subject: [PATCH] riscv: traps_misaligned: properly sign extend value in
>  misaligned load handler
> 
> Add missing cast to signed long.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 93043924fe6c..f760e4fcc052 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -461,7 +461,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
>  	}
>  
>  	if (!fp)
> -		SET_RD(insn, regs, val.data_ulong << shift >> shift);
> +		SET_RD(insn, regs, (long)(val.data_ulong << shift) >> shift);

Hi Andreas,

Nice catch, it seems like it was fixed in OpenSBI but never backported
in the kernel. As you suggested, I'll modify the test to test the sign
extension.

Thanks,

Clément

>  	else if (len == 8)
>  		set_f64_rd(insn, regs, val.data_u64);
>  	else


