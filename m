Return-Path: <linux-kselftest+bounces-31226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F7BA94CCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 09:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182A3162735
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4540725A2C3;
	Mon, 21 Apr 2025 07:13:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962925A2A9;
	Mon, 21 Apr 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745219618; cv=none; b=S6UW07dlZhMuz9qlRcZs0ByvOELccQiytTnvC+DMgSSagThTIAJPZea4o8hK34fQEPhxVlwl3zHCMm1rH/FyIEQf2k+LV4cqcQrM57kQeMqLI8+480Uh3euFC9tc/WwO04neAJhVhioJyayNgWVPqYKV8IGGMaa/xV1CxgXakr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745219618; c=relaxed/simple;
	bh=C+pifOYTd/GGRkXg7x8id7He7MdEboh9RIelu2PSuBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ji1AdiFperg0zU6aG2kpXbYGb5hW9sPhGpyc5lJasQWfHfMfCUEk7ra5inIfoOMbhNa1NSYw5o1Z38kTX1fH0NM0pbqDdPeu/9XSyzulJ7QqpUJOYRYPwy61j5eIaP3NgY6dxN/dwlSjaxhFIdps8mjh4+RlzC41PqPBu2gDf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CA3943A5D;
	Mon, 21 Apr 2025 07:13:23 +0000 (UTC)
Message-ID: <f834a4dd-8c76-4246-9923-600979b1d983@ghiti.fr>
Date: Mon, 21 Apr 2025 09:13:23 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] riscv: misaligned: enable IRQs while handling
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
References: <20250414123543.1615478-1-cleger@rivosinc.com>
 <20250414123543.1615478-3-cleger@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250414123543.1615478-3-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedtgeeuhffhveeujeetveevieekleekvdffudefleevgefgieekkefggefhtddtveenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmedufhehjeemvgdutggumedukegutdemtgdtvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmedufhehjeemvgdutggumedukegutdemtgdtvdekpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmedufhehjeemvgdutggumedukegutdemtgdtvdekngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegtlhgvghgvrhesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrr
 dhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomh
X-GND-Sasl: alex@ghiti.fr

On 14/04/2025 14:34, Clément Léger wrote:
> We can safely reenable IRQs if they were enabled in the previous
> context. This allows to access user memory that could potentially
> trigger a page fault.
>
> Fixes: b686ecdeacf6 ("riscv: misaligned: Restrict user access to kernel memory")
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   arch/riscv/kernel/traps.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 55d9f3450398..3eecc2addc41 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -206,6 +206,11 @@ enum misaligned_access_type {
>   static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
>   {
>   	irqentry_state_t state = irqentry_enter(regs);
> +	bool enable_irqs = !regs_irqs_disabled(regs);
> +
> +	/* Enable interrupts if they were enabled in the interrupted context. */
> +	if (enable_irqs)
> +		local_irq_enable();
>   
>   	if (type ==  MISALIGNED_LOAD) {
>   		if (handle_misaligned_load(regs))
> @@ -217,6 +222,9 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
>   				      "Oops - store (or AMO) address misaligned");
>   	}
>   
> +	if (enable_irqs)
> +		local_irq_disable();
> +
>   	irqentry_exit(regs, state);
>   }
>   


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


