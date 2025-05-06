Return-Path: <linux-kselftest+bounces-32504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A81CAAAC21A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 13:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175C71C23463
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2E127935A;
	Tue,  6 May 2025 11:08:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161E2797B5;
	Tue,  6 May 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529686; cv=none; b=EqIioG5Sw6pzyzO2ahaGqearBxBxp439z3LSRjTfykxSPSQvRFfr6R/2FPAEg81r/S9U9Xz8XGiOZ8d2ZVRL+JIJwRhSvsoRRg7bkI+itkRFqXVQHUvy0fRS9Qc+J859cuII1MlXkc0HnXeZBilBWLaKhfCsYjV1vltbtfQ1WKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529686; c=relaxed/simple;
	bh=dcsOuxpKYYYieYt8ztdlx1yrH3K/8Ma0I15+gjiggV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvjghMHfUx2oBpEDiLaLuusMsTQ1fjk4WHwDFB2UjhTgqXzZsAMlzSNVbNqQYMeUGAZhfEhzjxXDBinufUl8DrHJm7A/Y20Xjqjrkax4QNlgpmaGrlbvIftglFuAWu1GtBWgTh4VyYWdCm4F7V6nUaRaTBXTGonwBFiO1t/Dz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81F364396C;
	Tue,  6 May 2025 11:07:58 +0000 (UTC)
Message-ID: <7db8ae4f-4cde-43b4-9ec5-5a8818d79637@ghiti.fr>
Date: Tue, 6 May 2025 13:07:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] riscv: misaligned: enable IRQs while handling
 misaligned accesses
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
 <20250422162324.956065-3-cleger@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250422162324.956065-3-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedtgeeuhffhveeujeetveevieekleekvdffudefleevgefgieekkefggefhtddtveenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeehkegvudemfhdvsgegmeejrgelvdemfedvledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeehkegvudemfhdvsgegmeejrgelvdemfedvledtpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeehkegvudemfhdvsgegmeejrgelvdemfedvledtngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegtlhgvghgvrhesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrr
 dhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomh
X-GND-Sasl: alex@ghiti.fr

On 22/04/2025 18:23, Clément Léger wrote:
> We can safely reenable IRQs if coming from userspace. This allows to
> access user memory that could potentially trigger a page fault.
>
> Fixes: b686ecdeacf6 ("riscv: misaligned: Restrict user access to kernel memory")
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   arch/riscv/kernel/traps.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index b1d991c78a23..9c83848797a7 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -220,19 +220,23 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
>   {
>   	irqentry_state_t state;
>   
> -	if (user_mode(regs))
> +	if (user_mode(regs)) {
>   		irqentry_enter_from_user_mode(regs);
> -	else
> +		local_irq_enable();
> +	} else {
>   		state = irqentry_nmi_enter(regs);
> +	}
>   
>   	if (misaligned_handler[type].handler(regs))
>   		do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
>   			      misaligned_handler[type].type_str);
>   
> -	if (user_mode(regs))
> +	if (user_mode(regs)) {
> +		local_irq_disable();
>   		irqentry_exit_to_user_mode(regs);
> -	else
> +	} else {
>   		irqentry_nmi_exit(regs, state);
> +	}
>   }
>   
>   asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


