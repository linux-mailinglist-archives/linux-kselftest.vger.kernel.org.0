Return-Path: <linux-kselftest+bounces-8810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA998B13ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16631F24455
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9F13BC29;
	Wed, 24 Apr 2024 20:01:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF613BC19;
	Wed, 24 Apr 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988890; cv=none; b=L+fThRa4GfuxQMaYFVbP0lwPIwzhqUKFRAEFdJM989ihStM4gYv3mRS6GtMdsTwy+ke7JdBQAyDiAmF4n/BMmakVGye6F/GCnwfEdXnAVb18GkTqGMJZ/ApaFsVQ8QkEKeCnghq4cLgtx1CmhuTxIcOXMSq/pFieMQ9wfzHh5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988890; c=relaxed/simple;
	bh=lVUzeWoRGC6Liw5e4wRBgAQt06rT4cQ/EvqQQrQhdRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kH3HIrwRM5GG7/6uYDMevdzGK0ko9DhIer52eaU/eS17u4ySuWz+WjdxxaxeZWoLwb+NnRzpGM/BFcOo6IUeOVH+6hDq/9MKTBYH7vlzfq7E8NHhuqloT11vKeIFXXVmdCHIi7lq3gitX9P5KJfKuCRdSI+1NrL/AVLhoUI2+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB2E1240004;
	Wed, 24 Apr 2024 20:01:15 +0000 (UTC)
Message-ID: <4acc62d0-d62b-4d42-805b-0bc7f663a81c@ghiti.fr>
Date: Wed, 24 Apr 2024 22:01:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] riscv: smp: fail booting up smp if inconsistent
 vlen is detected
Content-Language: en-US
To: Andy Chiu <andy.chiu@sifive.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley
 <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>,
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@rivosinc.com>, Vincent Chen
 <vincent.chen@sifive.com>, Greentime Hu <greentime.hu@sifive.com>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240412-zve-detection-v4-0-e0c45bb6b253@sifive.com>
 <20240412-zve-detection-v4-2-e0c45bb6b253@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240412-zve-detection-v4-2-e0c45bb6b253@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Andy,

On 12/04/2024 08:48, Andy Chiu wrote:
> Currently we only support Vector for SMP platforms, that is, all SMP
> cores have the same vlenb. If we happen to detect a mismatching vlen, it
> is better to just fail bootting it up to prevent further race/scheduling
> issues.
>
> Also, move .Lsecondary_park forward and chage `tail smp_callin` into a
> regular call in the early assembly. So a core would be parked right
> after a return from smp_callin. Note that a successful smp_callin
> does not return.
>
> Fixes: 7017858eb2d7 ("riscv: Introduce riscv_v_vsize to record size of Vector context")
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-riscv/20240228-vicinity-cornstalk-4b8eb5fe5730@spud/
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
> Changelog v4:
>   - update comment also in the assembly code (Yunhui)
> Changelog v2:
>   - update commit message to explain asm code change (Conor)
> ---
>   arch/riscv/kernel/head.S    | 19 ++++++++++++-------
>   arch/riscv/kernel/smpboot.c | 14 +++++++++-----
>   2 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 4236a69c35cb..a00f7523cb91 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -165,9 +165,20 @@ secondary_start_sbi:
>   #endif
>   	call .Lsetup_trap_vector
>   	scs_load_current
> -	tail smp_callin
> +	call smp_callin
>   #endif /* CONFIG_SMP */
>   
> +.align 2
> +.Lsecondary_park:
> +	/*
> +	 * Park this hart if we:
> +	 *  - have too many harts on CONFIG_RISCV_BOOT_SPINWAIT
> +	 *  - receive an early trap, before setup_trap_vector finished
> +	 *  - fail in smp_callin(), as a successful one wouldn't return
> +	 */
> +	wfi
> +	j .Lsecondary_park
> +
>   .align 2
>   .Lsetup_trap_vector:
>   	/* Set trap vector to exception handler */
> @@ -181,12 +192,6 @@ secondary_start_sbi:
>   	csrw CSR_SCRATCH, zero
>   	ret
>   
> -.align 2
> -.Lsecondary_park:
> -	/* We lack SMP support or have too many harts, so park this hart */
> -	wfi
> -	j .Lsecondary_park
> -
>   SYM_CODE_END(_start)
>   
>   SYM_CODE_START(_start_kernel)
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index d41090fc3203..673437ccc13d 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -214,6 +214,15 @@ asmlinkage __visible void smp_callin(void)
>   	struct mm_struct *mm = &init_mm;
>   	unsigned int curr_cpuid = smp_processor_id();
>   
> +	if (has_vector()) {
> +		/*
> +		 * Return as early as possible so the hart with a mismatching
> +		 * vlen won't boot.
> +		 */
> +		if (riscv_v_setup_vsize())
> +			return;
> +	}
> +
>   	/* All kernel threads share the same mm context.  */
>   	mmgrab(mm);
>   	current->active_mm = mm;
> @@ -226,11 +235,6 @@ asmlinkage __visible void smp_callin(void)
>   	numa_add_cpu(curr_cpuid);
>   	set_cpu_online(curr_cpuid, 1);
>   
> -	if (has_vector()) {
> -		if (riscv_v_setup_vsize())
> -			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
> -	}
> -
>   	riscv_user_isa_enable();
>   
>   	/*
>

So this should go into -fixes, would you mind sending a single patch for 
this fix?

Your patch 8 is actually already fixed by Clement's patch 
https://lore.kernel.org/linux-riscv/20240409143839.558784-1-cleger@rivosinc.com/ 
and I already mentioned this one to Palmer.

Thanks,

Alex


