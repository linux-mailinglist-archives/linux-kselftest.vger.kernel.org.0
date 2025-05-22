Return-Path: <linux-kselftest+bounces-33495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B54AC04CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 08:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DFF1B677C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 06:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE03221734;
	Thu, 22 May 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h2yatspl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A220146D65
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747896588; cv=none; b=r3pCBBjS0RFPf5uj671KYAFo83v2wOCtTpdj29q5chzk8WDi5at6ewp3eO1LABYUpIGT/zDN41CYdx/K1jWgoUxxqB63yKcs7XDLKIVG5kMs+tAaXDDBSmyIeGFvObqoOHf290VI7Ym5jguFPW9VcuOnqph2tqNQ6ZF602/Uf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747896588; c=relaxed/simple;
	bh=NN18PvERwtDdoTCnb8dTOMXJOoITZnwSQBbXNQA7a0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMnN1EU389WdWcV/yXAEOpXHoCQb4EoRwnREjSB7jJoE/XGMcgIb4C3QNgVKzfOz3INOVdi/E8w7bKJjVGqNs0K5ees6ZRHanCN+frxJ2BwDwit9gKZmQZGftj/hQX0EeGShmsE9Ga+PPB68pgvstJU1CLt7yR4WRjuEQUU2d74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h2yatspl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso61772375e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747896584; x=1748501384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSfZsD4God9Ts/HLONlfHOWEtM7BhkFonFKtAqIE5Mk=;
        b=h2yatspl14MsY6LqiXygHE0cZu/D0s7+Fwtp37NKiq43zLuVrS7EyQrIpZdKrEwA5Z
         3OkjgQ8uFHAA16JzoSAM2WpHJ/vTXryyIsdHmW/dujtGIgcwXcOU0LAh2r8DcqaIg65o
         O37E4sGvn3nNFoBLMYtZM69dk49IFsU2rFp6CJ/P4GaNUEgtebOV4LfuvWtV/EsuNKcl
         tIRpk0OWE1pgkYRpOzufx69hWN6WWUIFfux/5KB9pyv2HP4cRWD3B0HCPAH9zkbk6892
         0Eulj5wmVyX/UeCTt9zWBZ3lFUrlwr4VSvesTMJz6WrY7y6rJzqgP63Aya+jjE1DPKxv
         OqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747896584; x=1748501384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSfZsD4God9Ts/HLONlfHOWEtM7BhkFonFKtAqIE5Mk=;
        b=R5UpMz1lvsnpxm7N94mO+EBei/jr47WiLPRa7/v9fQ7jcJcut4WogsweE9YCfRK7Fx
         TJIiikaWcB0qOjBs7XjZGcAlrltcH1r1ENbKOZsQCWaT26XI9RUCQvdc60Wo9MObdxjB
         tODPS+eObt6QzUE1FdP33xj3RuMOd0oivDLisFIOO/qax1vjbXX6hx5AXeG2TprQXff5
         mOAiL8dTS00hHvu5BBBKOO7SLm/Qc5Mf/UnuzRxLpfHquxIiDTZFhJBjDkV+YgPKNESy
         FO3TRau0VJ2bHesaejmM80YMMg3doyqJEdZkHCOyGTtb2An63ny6BFRYXrD/QEfKkx7h
         380g==
X-Forwarded-Encrypted: i=1; AJvYcCVoJUNoB8BtsM3DLrfhqim4R2pucGzIqk7IEv8uoLdAD1aaQUc+SbpPGQeV3nsdJtRvRyDqyW9QzQQUIOvWSr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1TLiH2/Se+Oujc3oqbBrcX1ME546y1Lmpzhe+V/TRFWn01aD
	AfEv8xcsCOYA64nsSzSG+I5/U44DgljQKHrPTDUyAq07cq73Nwa0bhZ+evWYWC/lZT9ktfQMt7W
	cDgohnsY=
X-Gm-Gg: ASbGncuRzhcFFd2QQgRJ00DaPBjvjoX6ZxwJg9bV/SHtIPPmQ5/5c31A2CeS647wkns
	JOoMiGRq9zThdrXFFwp1EXGKd3DeVziYOaQLr0li9P2l1CvVoOvSDpKNZZTdnH5TbqUysTRw6tb
	KZZ+qcxLnoa65zDI9qHX9Ooaf+RG6TP6Pe7bWnyphMEc4r/tslh+L5QKadkCb2mZc7SgqWHgGde
	kj2GP10i89NzTEgriMIR4hX7qruWWge9EVatA2ud7V6/b6qFZDkQW29Hj6T2k9aAKDPeXfjM1h7
	i+5GVArcQtNREwA9/xsXy1sHvKTYTDyE7kxA3fHJMJrpgy2gugkfEOGQAvi16Z+6lRfpofadTXd
	KGlYyFfGtzPiQGBpGzzTB
X-Google-Smtp-Source: AGHT+IHcBrXU/Fz3UA3Men54JBGMvR7rPmgEKbKc+z1Guu78ah8GEwVQySPOphDeLouhsLRO/zwPHg==
X-Received: by 2002:a05:600c:3c87:b0:442:d9f2:c6ef with SMTP id 5b1f17b1804b1-442fefd5f98mr249592835e9.2.1747896583771;
        Wed, 21 May 2025 23:49:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78b2f19sm90646175e9.32.2025.05.21.23.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 23:49:43 -0700 (PDT)
Message-ID: <957c479e-6233-4294-ac03-ac20b87dfacd@rivosinc.com>
Date: Thu, 22 May 2025 08:49:42 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/14] riscv: misaligned: move emulated access
 uniformity check in a function
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
References: <20250515082217.433227-1-cleger@rivosinc.com>
 <20250515082217.433227-10-cleger@rivosinc.com> <aCu_ce-kVQsyjrh5@ghost>
 <126762fc-17ca-4e9d-94d0-3aed1ae321ff@rivosinc.com> <aCy3A6uUbnWoO9uC@ghost>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <aCy3A6uUbnWoO9uC@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/05/2025 19:08, Charlie Jenkins wrote:
> On Tue, May 20, 2025 at 10:19:47AM +0200, Clément Léger wrote:
>>
>>
>> On 20/05/2025 01:32, Charlie Jenkins wrote:
>>> On Thu, May 15, 2025 at 10:22:10AM +0200, Clément Léger wrote:
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
>>>> index e551ba17f557..287ec37021c8 100644
>>>> --- a/arch/riscv/kernel/traps_misaligned.c
>>>> +++ b/arch/riscv/kernel/traps_misaligned.c
>>>> @@ -647,6 +647,18 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>>>>  }
>>>>  #endif
>>>>  
>>>> +static bool all_cpus_unaligned_scalar_access_emulated(void)
>>>> +{
>>>> +	int cpu;
>>>> +
>>>> +	for_each_online_cpu(cpu)
>>>> +		if (per_cpu(misaligned_access_speed, cpu) !=
>>>
>>> misaligned_access_speed is only defined when
>>> CONFIG_RISCV_SCALAR_MISALIGNED. This function should return false when
>>> !CONFIG_RISCV_SCALAR_MISALIGNED and only use this logic otherwise.
>>
>> Hi Charlie,
>>
>> misaligned_access_speed is defined in unaligned_access_speed.c which is
>> compiled based on CONFIG_RISCV_MISALIGNED (ditto for trap_misaligned.c)
>>
>> obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
>>
>> However, the declaration for it in the header cpu-feature.h however is
>> under a CONFIG_RISCV_SCALAR_MISALIGNED ifdef. So either the declaration
>> or the definition is wrong but the ifdefery soup makes it quite
>> difficult to understand what's going on.
>>
>> I would suggest to move the DECLARE_PER_CPU under
>> CONFIG_RISCV_MISALIGNED so that it reduces ifdef in traps_misaligned as
>> well.
> 
> Here is the patch I am using locally for testing purposes, but if there
> is a way to reduce the number of ifdefs that is probably the better way to go:
> 

Hi Charlie,

I have another way to do so which indeed reduces the number of
ifdef/duplicated functions. I'll submit that.

Thanks,

Clément

> From 18f9a056d3b597934c931abdf72fb6e775ccb714 Mon Sep 17 00:00:00 2001
> From: Charlie Jenkins <charlie@rivosinc.com>
> Date: Mon, 19 May 2025 16:35:51 -0700
> Subject: [PATCH] fixup! riscv: misaligned: move emulated access uniformity
>  check in a function
> 
> ---
>  arch/riscv/kernel/traps_misaligned.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index f3ab84bc4632..1449c6a4ac21 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -647,6 +647,10 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
> +
> +static bool unaligned_ctl __read_mostly;
> +
>  static bool all_cpus_unaligned_scalar_access_emulated(void)
>  {
>  	int cpu;
> @@ -659,10 +663,6 @@ static bool all_cpus_unaligned_scalar_access_emulated(void)
>  	return true;
>  }
>  
> -#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
> -
> -static bool unaligned_ctl __read_mostly;
> -
>  static void check_unaligned_access_emulated(void *arg __always_unused)
>  {
>  	int cpu = smp_processor_id();
> @@ -716,6 +716,10 @@ bool unaligned_ctl_available(void)
>  	return unaligned_ctl;
>  }
>  #else
> +static bool all_cpus_unaligned_scalar_access_emulated(void)
> +{
> +	return false;
> +}
>  bool __init check_unaligned_access_emulated_all_cpus(void)
>  {
>  	return false;


