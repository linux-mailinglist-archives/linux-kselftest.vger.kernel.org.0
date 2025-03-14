Return-Path: <linux-kselftest+bounces-29027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899DFA6105D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA8617CAD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8E1FCFE3;
	Fri, 14 Mar 2025 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lxgR6E9g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96D18CBF2
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952847; cv=none; b=j2MtyqDxWTaJFgMgwTWDq4NrGKdO/WH0hn0Sfrwz4jz+4EF7tzxQTWxYvFuxgQIWglYflwVZGiyX4kBqkPcvY2KW38NlqQfpKnYrTx+ZyroSvf7+Y9liTQ/WenBbXWRIc3W1sf+Wc6aEUzy+fXP6y7A6Gu1mnT3N6ET0vBYnIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952847; c=relaxed/simple;
	bh=9S08aj6cuSDTLfzLSRyiaJKUipi4ZUDEq0jVrExy7QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2f0oCdepG/dHHDtcXfM+kCKm4cp/8F1TBsQvspXn7h4JxcSmtduF4RKOa33OlS7slsBnAe9b5pkxVjV2vTWTCa/Zy0ipU/EFrct4mQJZFUAi9QA8+90cI5fNsWzmwA506pCw5HCRGNoOriXc5gYNhC7XRpfr2kUBAaM5FAUC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lxgR6E9g; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913fdd003bso1059971f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741952844; x=1742557644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzikXcMBGZjkkMXY0vzLgpXOZlJlOHrf1lUiKHrI63E=;
        b=lxgR6E9gEPI2VQ/wcCjV0KIp7cMr4bfJFjWk/5GOeuVJ5qhF6/UAbFYuad33lThEP6
         RZEHmyL9PpkGCDT3TCjogJ9o6q9Be16fVfq/cyYI0dFdSx6U0OIoRkwmmLRCvrhdv0DH
         8g4+Ximy1DW0f5gMs3+o/rbX7PKwSotv+AkBRZosfBD3gCrgaBiqeT4Z8nVTMEqlIx8n
         tw4Me7/t/jSIkmOMAc4ko40U/e5wwEbDsJ4vlluHdnrWSxOQ7kK1Z3Fm2VcfDdXww6bt
         pQHgjR2QWB+IFf36S2R0Ce0djPsuLKnFZ3MwEqtO5s2jegYQqmUlV04lMBTKO4TlEyXD
         HQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741952844; x=1742557644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzikXcMBGZjkkMXY0vzLgpXOZlJlOHrf1lUiKHrI63E=;
        b=J6+ZXB5bIa/I39jbwmF4DGlRrftoxBgEXmkoSGOLDUguYLfl0OIxHzDdxpn616TDOl
         O8xZO0VZ3hIXa3DF9qeUVZ1moKWYoXFT4WXI7A1a/tnVfQhdrCBuntc0/UUgTh+f+N2O
         3mNGLmpdOmTNCoVQJv6NbCtZiOYOosL6uEYsOk8vk0d6ax4S1W0c3fcd95oBdacsvRZh
         JrpSzABwXh1n2IbQhfmQImN4Hd828kcWMMH3WCqHIgQt8QCWbysofsJSJU3qhTkaN0UD
         lNu9OZJ093BdrS5CyAQFSAEb076ni/maVewBmjg2Br69TiWyXZJJkkOqRtvTF2balXVO
         0B8g==
X-Forwarded-Encrypted: i=1; AJvYcCV7oHYdKXwbfzzdgSNB65c79Tl+Ck6x2OLrYljLGWtSrheZ5KSs6rWorF/wQ7OpSUF9EljQNToh9CbrdS77Uiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3K5aCBsQAYPKzp08SQopkP4Vs4xoA0v5MYxN5/S77tONBmqh
	DglcCS3WtSGd4D10MG5PKV/JFOJGaeE0HZIlON3oAwVPcn3jCuk+phwvPk8rzcs=
X-Gm-Gg: ASbGnctdJAZRyA1elEUE4DhXAMd5x4UhAZwuK4IDyLGtCQ0XiRtrhpYd28yWu/lVCNC
	f7Qn2WO+P4rhMGFy2BCk0gTYzt4ltMpTQf3fv3GxBhGfFflmqM4S0AEABoXVMdiyta3DiEfMUEZ
	b8muHV9y80sr6M5IMVUdLmnfVgxWNpRvQjjBwKLuxQQSIIM1c6qlmAoloa3ymVSHINoAVXvwfdd
	fq1PsNjijHKzL12uxy3hmUS/6n3jNFoqiQBd7zXfE3YEHNmnUsngrL0CywbyKCH+pg8loJp0axm
	0OhD1PqVj62xTnUSCJesicDiLr6k89kucxylq6nu+1aL2PhadreT3p4eThQSCEa435Lcf6wlfYF
	8uKuLo/2CFdGjEw==
X-Google-Smtp-Source: AGHT+IGtfAcAmGZVPhIyucY33egMDOBZySQ+8fr8l7lHLk072SvheDgQHi3fAYh9SVsSUmw9CF0urA==
X-Received: by 2002:a05:6000:2cf:b0:390:f116:d220 with SMTP id ffacd0b85a97d-3971c97ba0cmr2373277f8f.17.1741952844036;
        Fri, 14 Mar 2025 04:47:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9ccsm5371909f8f.96.2025.03.14.04.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 04:47:23 -0700 (PDT)
Message-ID: <f0945e93-7ac0-4217-8095-93fff303bdf2@rivosinc.com>
Date: Fri, 14 Mar 2025 12:47:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/17] riscv: misaligned: use correct CONFIG_ ifdef for
 misaligned_access_speed
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-7-cleger@rivosinc.com>
 <20250313-a437330d8e1c638a9aa61e0a@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250313-a437330d8e1c638a9aa61e0a@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/03/2025 14:06, Andrew Jones wrote:
> On Mon, Mar 10, 2025 at 04:12:13PM +0100, Clément Léger wrote:
>> misaligned_access_speed is defined under CONFIG_RISCV_SCALAR_MISALIGNED
>> but was used under CONFIG_RISCV_PROBE_UNALIGNED_ACCESS. Fix that by
>> using the correct config option.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/kernel/traps_misaligned.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index ffac424faa88..7fe25adf2539 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -362,7 +362,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
>>  
>>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>>  
>> -#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>> +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>>  	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
>>  #endif
> 
> Sure, but CONFIG_RISCV_PROBE_UNALIGNED_ACCESS selects
> CONFIG_RISCV_SCALAR_MISALIGNED, so this isn't fixing anything. 

Indeed, that is not fixing anything (hence no Fixes tag), it compiles as
a side effect of Kconfig dependencies.

> Changing it
> does make sense though since this line in handle_scalar_misaligned_load()
> "belongs" to check_unaligned_access_emulated() which is also under
> CONFIG_RISCV_SCALAR_MISALIGNED. Anyway, all this unaligned configs need a
> major cleanup.

Yes, as I said, I'd be advocating to remove all that ifdefery mess.

Thanks,

Clément

> 
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew
> 
>>  
>> -- 
>> 2.47.2
>>
>>
>> -- 
>> kvm-riscv mailing list
>> kvm-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kvm-riscv


