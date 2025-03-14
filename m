Return-Path: <linux-kselftest+bounces-29026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B9A61040
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDB1189931C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84E61FDE12;
	Fri, 14 Mar 2025 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fKRJZn8O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B31FDA9C
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952650; cv=none; b=crvVYD/DaBm2WjJ+ikD2hjQSu/VS6TMA9YftOmQMr0PbSkKCezpm4gQOntLvbJqtlED1RqbTA5qmqObjrhSMQYvvGzpL9Q0xUUH6Kw1XQ5EZCO6X1U9lCSdHm/VM7qyTHTCULIxbuHndEpN3tDKvU49V/KPJ9VGiMFeTm/Rrt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952650; c=relaxed/simple;
	bh=k3VquhwGBzj/qmce5+dPovhxa6xW5DKGhqNFIz459Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yv56DgX8xTfSzsmKJr9cJZ+Wg1EsHkv+Sofsja3DiXukawP1zNnUwKkZQZL8YjdgvHWtm/kvvockhjDhocy3fyGI63PUrHAtkwe9fJI4p3dl+aT5fYAwMO67P50YknzXNuLFquW6uXpHNNKup148udlYxLn7up0IwGBtS04h7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fKRJZn8O; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f2f391864so1147470f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741952647; x=1742557447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNXP4301/EYAJtyOh9G36QhlKo8rLTXV/iJ66ebNv0k=;
        b=fKRJZn8O5LWILPL61QJWy9PcxsKvfPy7Vy3XP94utIj0okxdSdAuFC/A/Gu54GYAIT
         W+MWYhJdrxU88ULgbjBEfyDOigvxGPg5J3GFoNCpValNaUjLNun4tXjmOUfuTN0dzvxH
         7by+9njDjWaSLHhi0I1q5vm4Y13ziVqzdU8LbKSJc1dtoB2Y53oxOvz38z59sLyBnwJM
         AQKfPNUirYs4PBoeCWd9uffKuQPegE3TJnL8RDzDOzmf/9hDWAO2XwUGco6+ySHK9vGb
         WDylJrV4EqjG1qDQQ3lRLDguRb+wR7PB4i8Wzf4s+RBDERDY71Cc6KGc5Gdp/WbitUvG
         EApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741952647; x=1742557447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNXP4301/EYAJtyOh9G36QhlKo8rLTXV/iJ66ebNv0k=;
        b=QM+QRwb8EkthZPj0cANZNxvrNQYaCIHEvRf1s9yWqEWTcmXHMTd2c1sVMswiuK4KLf
         rPDwnXcYLe0F2YofXfC5ZSFIYx4lzRhwjltCIGBb55qWWzfI08uVwpcKsdJWseaD73t0
         6WzadKEc4OvulVHEL0bs2vGLpYWTR+Nvwk0vbWF7NsQ+6umm3Zra9GqgJ8/gaVaJUFj1
         vCKWgCxfqa0jdjLpwKyllIU5zvjR9gOZknJn2eiKcIFNVGcQ6xhf92FyWUAacqcsCO6h
         Df8vraSeT4OfXPmqzx8BBN2V0rSP4txL2YOYETBHGZXklKzgK3EnZO2vS1SyzJHlQ58q
         houQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6+3UlNYH/KHh+aKSpZI+PNEiNBVr1g0MC0eKnXo93Mngmh8f9d0jWeO+9/WWqGO7SkTss4Zio7wYrWQpNFfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr85Ham5TIh6Ib7EEGwhtDFeTtCiniIUulV6WX5zWalQDdwA88
	loVAQrMLwI6ssAOy5wECFmqA6KPqmrjtUtuOTrVTEofHkAxaP8QCfXA4YhtiC5A=
X-Gm-Gg: ASbGnculLW2HWYqynshp05TFuvr7VyAwj9yiJcQKUxqxY8KHS+2emWL1VGiEfXi59c8
	ZZnE6A+5XItTW9sjpq3vZol6M2CHH04M/oeebsRQ4dPVrcA12fIEz9oabE1skfrOdGM+VYVY48r
	3teCMTpSCuwevNii6FGSyQqVSWynMgaMAfd1IG1c9TmkLsQVduGkCUu5BPOmVV9clgvhNO/f6f9
	lGjO2aElxtRcjPQnsAoWAEELkoM5+BxJ5Zd4jOBmmE0QuRPS4ZDnxlM7nM9TnY2jAFSzb93NnXA
	Bpdwh9jCtuKOtLUsOr/BggHRrX65LoUelNxTMaVegz6Mx16Ecqpl6ma7zMlfSZWEM5gMVqky44a
	FziLl5d3XUB8N5Q==
X-Google-Smtp-Source: AGHT+IF+PcMLniUgUw+7z04HFQAwTiKLbHivzVvB0Zh2bIees9zyWsKr40uUY0pHyf5dEv8vx5Q9WQ==
X-Received: by 2002:a5d:5f49:0:b0:390:fb37:1bd with SMTP id ffacd0b85a97d-3971f7f8fccmr2700791f8f.46.1741952647046;
        Fri, 14 Mar 2025 04:44:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a32sm5420094f8f.33.2025.03.14.04.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 04:44:06 -0700 (PDT)
Message-ID: <1942580f-cd67-4ddd-b489-0532f95c1ef2@rivosinc.com>
Date: Fri, 14 Mar 2025 12:44:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] riscv: misaligned: use on_each_cpu() for scalar
 misaligned access probing
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-6-cleger@rivosinc.com>
 <20250313-311b94f9bafe73bcd41158a1@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250313-311b94f9bafe73bcd41158a1@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/03/2025 13:57, Andrew Jones wrote:
> On Mon, Mar 10, 2025 at 04:12:12PM +0100, Clément Léger wrote:
>> schedule_on_each_cpu() was used without any good reason while documented
>> as very slow. This call was in the boot path, so better use
>> on_each_cpu() for scalar misaligned checking. Vector misaligned check
>> still needs to use schedule_on_each_cpu() since it requires irqs to be
>> enabled but that's less of a problem since this code is ran in a kthread.
>> Add a comment to explicit that.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/kernel/traps_misaligned.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index 90ac74191357..ffac424faa88 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -616,6 +616,11 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
>>  		return false;
>>  	}
>>  
>> +	/*
>> +	 * While being documented as very slow, schedule_on_each_cpu() is used
>> +	 * since kernel_vector_begin() expects irqs to be enabled or it will panic().
> 
> which expects

Hum that would yield the following:

"schedule_on_each_cpu() is used since kernel_vector_begin() that is
called inside the vector code 'which' expects irqs to be enabled or it
will panic()." which seems wrong as well.

I guess something like this would be better:

"While being documented as very slow, schedule_on_each_cpu() is used
since kernel_vector_begin() expects irqs to be enabled or it will panic()"

Thanks,

Clément

> 
>> +	 */
>>  	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
>>  
>>  	for_each_online_cpu(cpu)
>> @@ -636,7 +641,7 @@ bool check_vector_unaligned_access_emulated_all_cpus(void)
>>  
>>  static bool unaligned_ctl __read_mostly;
>>  
>> -static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
>> +static void check_unaligned_access_emulated(void *arg __always_unused)
>>  {
>>  	int cpu = smp_processor_id();
>>  	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
>> @@ -677,7 +682,7 @@ bool check_unaligned_access_emulated_all_cpus(void)
>>  	 * accesses emulated since tasks requesting such control can run on any
>>  	 * CPU.
>>  	 */
>> -	schedule_on_each_cpu(check_unaligned_access_emulated);
>> +	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
>>  
>>  	for_each_online_cpu(cpu)
>>  		if (per_cpu(misaligned_access_speed, cpu)
>> -- 
>> 2.47.2
>>
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


