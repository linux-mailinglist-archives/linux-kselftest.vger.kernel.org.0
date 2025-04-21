Return-Path: <linux-kselftest+bounces-31225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA78BA94CC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 09:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E40188F130
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 07:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DCB259C98;
	Mon, 21 Apr 2025 07:07:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91025745A;
	Mon, 21 Apr 2025 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745219234; cv=none; b=rgnGcyibHvlwLjA5l295FBd/GK80RQ3qKKyfUqDvfkXrocn7nDtmyxTIuacShq96T0HCncLy52oQUQJGLnmGEBLNTdYsrqLChQmpqWsSDdDTXB3BWRdDc7haf6OtNoN636ZByEQEEh3mY6p89oyTLPk/Iv52g+ac7fDkp6e7Nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745219234; c=relaxed/simple;
	bh=KM9dw/BrdxBJjxiyJkfPdIqzRHPVv4tm1yoz+8E7ojE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uc8BkdRX8GPMDVEaqJ1BboT8pefFfed793G5XXFw1yFSFhQ5MVPk6X2ExD9fjC7rSavKvGH3ELCpdRSwOseF3DA3GIjzztWtMUlRY4Q+WR5YheVPHQd1TMuuw6a8AK6sOW/vh+spu1FaLg2zXvHLam1mYB3bc2RERyMhc4K6q+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E847344210;
	Mon, 21 Apr 2025 07:06:59 +0000 (UTC)
Message-ID: <ba11b910-9959-4845-b3a3-dd9a52466823@ghiti.fr>
Date: Mon, 21 Apr 2025 09:06:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH 1/5] riscv: misaligned: factorize trap handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Shuah Khan <shuah@kernel.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20250414123543.1615478-1-cleger@rivosinc.com>
 <20250414123543.1615478-2-cleger@rivosinc.com>
Content-Language: en-US
In-Reply-To: <20250414123543.1615478-2-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfhuffvvehfjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhveeugfdvhefhvedtffevhefhfeevkeeigeetieeuvdeluefgvdejieeuhffgieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemudhfheejmegvudgtugemudekugdtmegttddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemudhfheejmegvudgtugemudekugdtmegttddvkedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemudhfheejmegvudgtugemudekugdtmegttddvkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheptghlvghgvghrsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhto
 heplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Clément,


On 14/04/2025 14:34, Clément Léger wrote:
> misaligned accesses traps are not nmi and should be treated as normal
> one using irqentry_enter()/exit().


All the traps that come from kernel mode are treated as nmi as it was 
suggested by Peter here: 
https://lore.kernel.org/linux-riscv/Yyhv4UUXuSfvMOw+@hirez.programming.kicks-ass.net/

I don't know the differences between irq_nmi_entry/exit() and 
irq_entry/exit(), so is that still correct to now treat the kernel traps 
as non-nmi?

Thanks,

Alex


> Since both load/store and user/kernel
> should use almost the same path and that we are going to add some code
> around that, factorize it.
>
> Signed-off-by: Clément Léger<cleger@rivosinc.com>
> ---
>   arch/riscv/kernel/traps.c | 49 ++++++++++++++++-----------------------
>   1 file changed, 20 insertions(+), 29 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 8ff8e8b36524..55d9f3450398 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -198,47 +198,38 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>   DO_ERROR_INFO(do_trap_load_fault,
>   	SIGSEGV, SEGV_ACCERR, "load access fault");
>   
> -asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
> +enum misaligned_access_type {
> +	MISALIGNED_STORE,
> +	MISALIGNED_LOAD,
> +};
> +
> +static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
>   {
> -	if (user_mode(regs)) {
> -		irqentry_enter_from_user_mode(regs);
> +	irqentry_state_t state = irqentry_enter(regs);
>   
> +	if (type ==  MISALIGNED_LOAD) {
>   		if (handle_misaligned_load(regs))
>   			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> -			      "Oops - load address misaligned");
> -
> -		irqentry_exit_to_user_mode(regs);
> +				      "Oops - load address misaligned");
>   	} else {
> -		irqentry_state_t state = irqentry_nmi_enter(regs);
> -
> -		if (handle_misaligned_load(regs))
> +		if (handle_misaligned_store(regs))
>   			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> -			      "Oops - load address misaligned");
> -
> -		irqentry_nmi_exit(regs, state);
> +				      "Oops - store (or AMO) address misaligned");
>   	}
> +
> +	irqentry_exit(regs, state);
>   }
>   
> -asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
> +asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
>   {
> -	if (user_mode(regs)) {
> -		irqentry_enter_from_user_mode(regs);
> -
> -		if (handle_misaligned_store(regs))
> -			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> -				"Oops - store (or AMO) address misaligned");
> -
> -		irqentry_exit_to_user_mode(regs);
> -	} else {
> -		irqentry_state_t state = irqentry_nmi_enter(regs);
> -
> -		if (handle_misaligned_store(regs))
> -			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> -				"Oops - store (or AMO) address misaligned");
> +	do_trap_misaligned(regs, MISALIGNED_LOAD);
> +}
>   
> -		irqentry_nmi_exit(regs, state);
> -	}
> +asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
> +{
> +	do_trap_misaligned(regs, MISALIGNED_STORE);
>   }
> +
>   DO_ERROR_INFO(do_trap_store_fault,
>   	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
>   DO_ERROR_INFO(do_trap_ecall_s,

