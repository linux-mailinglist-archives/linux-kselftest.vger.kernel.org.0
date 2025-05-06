Return-Path: <linux-kselftest+bounces-32503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A3AAC1DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D431C22A11
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60C27874F;
	Tue,  6 May 2025 10:58:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F4620C028;
	Tue,  6 May 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529089; cv=none; b=fJ/hBLDS2xfKOTOY/y4EVeLrfeGpzN10Sv5QtMJwUcsyVQydM3ygQi/Ng4ukb08VbgsSjBrxqDGlbH34jNXqWZc0Z4yTpFDjqQqKbj5wCXKRnqRpQ31ZdNbILld1fsox4Q/lh+1pU5c0ik28nA9fZS+4qNvU1JvUARv8dgehIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529089; c=relaxed/simple;
	bh=Ol7szAJTyl/5GO2BTyeQtutt87j4uUDYUrUfk8uKs2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWifN1FDYEzFTqTWe/DWR5ribNW9MloEZlSvSIqh3S3U1r1Z5WDL1YIJKKa/au+6lQiLSQvm+vvmz/zKIHTDLB5yP7amz/0G+xyFCs7GFKPIfAzoGIim5BPAGc0+/EHV4Cpw1eRksjmZglX+DzjbPU2Dp4p5iCmB7Meh22HK0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A2BA4327B;
	Tue,  6 May 2025 10:58:02 +0000 (UTC)
Message-ID: <41032f89-4ff3-48b4-8f01-afa793ca9990@ghiti.fr>
Date: Tue, 6 May 2025 12:58:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] riscv: misaligned: factorize trap handling
Content-Language: en-US
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Shuah Khan <shuah@kernel.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 Samuel Holland <samuel.holland@sifive.com>
References: <20250422162324.956065-1-cleger@rivosinc.com>
 <20250422162324.956065-2-cleger@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250422162324.956065-2-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedtgeeuhffhveeujeetveevieekleekvdffudefleevgefgieekkefggefhtddtveenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeehkegvudemfhdvsgegmeejrgelvdemfedvledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeehkegvudemfhdvsgegmeejrgelvdemfedvledtpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeehkegvudemfhdvsgegmeejrgelvdemfedvledtngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegtlhgvghgvrhesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrr
 dhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Clément,

On 22/04/2025 18:23, Clément Léger wrote:
> Since both load/store and user/kernel should use almost the same path and
> that we are going to add some code around that, factorize it.
>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   arch/riscv/kernel/traps.c | 66 +++++++++++++++++++++------------------
>   1 file changed, 36 insertions(+), 30 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 8ff8e8b36524..b1d991c78a23 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -198,47 +198,53 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>   DO_ERROR_INFO(do_trap_load_fault,
>   	SIGSEGV, SEGV_ACCERR, "load access fault");
>   
> -asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
> +enum misaligned_access_type {
> +	MISALIGNED_STORE,
> +	MISALIGNED_LOAD,
> +};
> +static const struct {
> +	const char *type_str;
> +	int (*handler)(struct pt_regs *regs);
> +} misaligned_handler[] = {
> +	[MISALIGNED_STORE] = {
> +		.type_str = "Oops - store (or AMO) address misaligned",
> +		.handler = handle_misaligned_store,
> +	},
> +	[MISALIGNED_LOAD] = {
> +		.type_str = "Oops - load address misaligned",
> +		.handler = handle_misaligned_load,
> +	},
> +};
> +
> +static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
>   {
> -	if (user_mode(regs)) {
> +	irqentry_state_t state;
> +
> +	if (user_mode(regs))
>   		irqentry_enter_from_user_mode(regs);
> +	else
> +		state = irqentry_nmi_enter(regs);
>   
> -		if (handle_misaligned_load(regs))
> -			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> -			      "Oops - load address misaligned");
> +	if (misaligned_handler[type].handler(regs))
> +		do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> +			      misaligned_handler[type].type_str);
>   
> +	if (user_mode(regs))
>   		irqentry_exit_to_user_mode(regs);
> -	} else {
> -		irqentry_state_t state = irqentry_nmi_enter(regs);
> -
> -		if (handle_misaligned_load(regs))
> -			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> -			      "Oops - load address misaligned");
> -
> +	else
>   		irqentry_nmi_exit(regs, state);
> -	}
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


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


