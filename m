Return-Path: <linux-kselftest+bounces-22881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E29E5D76
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DBC285CE1
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7A226EF1;
	Thu,  5 Dec 2024 17:41:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570F224AEA;
	Thu,  5 Dec 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420461; cv=none; b=NudT8xiNkjt501LuTX9C58v2R6GlhE4QLHUQOvCKmr5gbMIpErLQy1qCENhjczL275tbZ3FjocsFHiJFpYUrRcHujsf/qaKBu5tMj3zuKe7r9h1XcyYTNVCyJ2Hu0ckjRDOtESFkOzvTf5aXI66qucN0Sq1pum4ElpzR+bqDxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420461; c=relaxed/simple;
	bh=02QwFU0NbxHwwY4/jSg9aLzGDajj8t0KO3Hq/4zLXos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrDlNtyrbNLDVbvdXBbzK60MVMekN6gXT7owXEdlxq1CD2bX60l2f5g4C7ade6xWoIgkGumDBp7X1iPJtmyBzNnG6N6XRGj6I8WnxSyRLiUb+Eu23Z55wdKEhSUq7s1UycvTg6+lINA3Uk3IXpU5ykVs7LA9MX9KGf9RHBDqQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 236B51BF203;
	Thu,  5 Dec 2024 17:40:45 +0000 (UTC)
Message-ID: <528505d0-e0ba-414b-ad9d-bc78c07464a1@ghiti.fr>
Date: Thu, 5 Dec 2024 18:40:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv/ptrace: add new regset to access original a0
 register
Content-Language: en-US
To: Celeste Liu <uwu@coelacanthus.name>, Oleg Nesterov <oleg@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani
 <abologna@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
 Charlie Jenkins <charlie@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
 <20241203-riscv-new-regset-v2-1-d37da8c0cba6@coelacanthus.name>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241203-riscv-new-regset-v2-1-d37da8c0cba6@coelacanthus.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Celeste,

On 03/12/2024 10:30, Celeste Liu wrote:
> The orig_a0 is missing in struct user_regs_struct of riscv, and there is
> no way to add it without breaking UAPI. (See Link tag below)
>
> Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
> access original a0 register from userspace via ptrace API.
>
> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
>   arch/riscv/kernel/ptrace.c | 32 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/elf.h   |  1 +
>   2 files changed, 33 insertions(+)
>
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index ea67e9fb7a583683b922fe2c017ea61f3bc848db..18ce07ffb27bb1180667769eed800f6fdf96c083 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -31,6 +31,7 @@ enum riscv_regset {
>   #ifdef CONFIG_RISCV_ISA_SUPM
>   	REGSET_TAGGED_ADDR_CTRL,
>   #endif
> +	REGSET_ORIG_A0,
>   };
>   
>   static int riscv_gpr_get(struct task_struct *target,
> @@ -184,6 +185,29 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
>   }
>   #endif
>   
> +static int riscv_orig_a0_get(struct task_struct *target,
> +			     const struct user_regset *regset,
> +			     struct membuf to)
> +{
> +	return membuf_store(&to, task_pt_regs(target)->orig_a0);
> +}
> +
> +static int riscv_orig_a0_set(struct task_struct *target,
> +			     const struct user_regset *regset,
> +			     unsigned int pos, unsigned int count,
> +			     const void *kbuf, const void __user *ubuf)
> +{
> +	unsigned long orig_a0 = task_pt_regs(target)->orig_a0;
> +	int ret;
> +
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &orig_a0, 0, -1);
> +	if (ret)
> +		return ret;
> +
> +	task_pt_regs(target)->orig_a0 = orig_a0;
> +	return ret;
> +}
> +
>   static const struct user_regset riscv_user_regset[] = {
>   	[REGSET_X] = {
>   		.core_note_type = NT_PRSTATUS,
> @@ -224,6 +248,14 @@ static const struct user_regset riscv_user_regset[] = {
>   		.set = tagged_addr_ctrl_set,
>   	},
>   #endif
> +	[REGSET_ORIG_A0] = {
> +		.core_note_type = NT_RISCV_ORIG_A0,
> +		.n = 1,
> +		.size = sizeof(elf_greg_t),
> +		.align = sizeof(elf_greg_t),
> +		.regset_get = riscv_orig_a0_get,
> +		.set = riscv_orig_a0_set,
> +	},
>   };
>   
>   static const struct user_regset_view riscv_user_native_view = {
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b44069d29cecc0f9de90ee66bfffd2137f4275a8..390060229601631da2fb27030d9fa2142e676c14 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -452,6 +452,7 @@ typedef struct elf64_shdr {
>   #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
>   #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
>   #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
> +#define NT_RISCV_ORIG_A0	  0x903	/* RISC-V original a0 register */
>   #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
>   #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
>   #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
>

Do you know how far this should be backported? Does the following fixes 
tag make sense?

Fixes: e2c0cdfba7f6 ("RISC-V: User-facing API")

Thanks,

Alex


