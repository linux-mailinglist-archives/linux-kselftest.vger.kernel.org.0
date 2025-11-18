Return-Path: <linux-kselftest+bounces-45895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C245C6AE3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id EA1A728F4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C33A1CEE;
	Tue, 18 Nov 2025 17:13:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0884A3A79B8;
	Tue, 18 Nov 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486018; cv=none; b=hhD78CtOBRaob5dGbvEBhvn8DtOMlnyfhpMtSUD57QFHp+IGg1Dk26/PY8MG17PAPjP5XlOBfd9rRO3JruOMf/7S6PENjnEX44l2NG+Wi+tImbUsnrBk0JVQ8a7bvXYR464Pr6CFZW9Dwoh7VlWD8F5PJ+Aa3HF8FvTcYvVhCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486018; c=relaxed/simple;
	bh=Fmmm4fevuMAqvOzkDtVZjZZxU4PIY4jDIF6zoy7hUgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GxK+XRQQw7D3c+wdwnDDnVOo2dVabNRFTYubRXaYle+/fdov6ElINWsdOEz/6PbTuLhtkBlD+vh83fmuPjS+FB1cs9CLW4ONm8ui8+QzgHQITN8EeIXLBmdBjAn2Ai3Rl243l61aLjiyS6Oas9VJ6Pwy/cVuskX4UfZR/qERxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6AAD168F;
	Tue, 18 Nov 2025 09:13:28 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAB0B3F66E;
	Tue, 18 Nov 2025 09:13:30 -0800 (PST)
Message-ID: <55e1345f-94d7-41a9-8f0a-694fd56f63ed@arm.com>
Date: Tue, 18 Nov 2025 18:13:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/11] entry: Add
 arch_ptrace_report_syscall_entry/exit()
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 akpm@linux-foundation.org, ldv@strace.io, macro@orcam.me.uk, deller@gmx.de,
 mark.rutland@arm.com, song@kernel.org, mbenes@suse.cz, ryan.roberts@arm.com,
 ada.coupriediaz@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com, kmal@cock.li, lihongbo22@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251117133048.53182-1-ruanjinjie@huawei.com>
 <20251117133048.53182-9-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 14:30, Jinjie Ruan wrote:
> Differ from generic entry, due to historical reasons, ARM64 need to
> save/restore during syscall entry/exit because ARM64 use a scratch
> register (ip(r12) on AArch32, x7 on AArch64) to denote syscall entry/exit.
>
> In preparation for moving arm64 over to the generic entry code,
> add arch_ptrace_report_syscall_entry/exit() as the default
> ptrace_report_syscall_entry/exit() implementation. This allows
> arm64 to implement the architecture specific version.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>

I don't think I suggested this patch. I see that I suggested renaming
some functions on v3, but I don't think that justifies a Suggested-by tag.

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/entry/syscall-common.c | 43 +++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
> index 66e6ba7fa80c..27310e611567 100644
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -17,6 +17,25 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>  	}
>  }
>  
> +/**
> + * arch_ptrace_report_syscall_entry - Architecture specific
> + *				      ptrace_report_syscall_entry().
> + *
> + * Invoked from syscall_trace_enter() to wrap ptrace_report_syscall_entry().
> + * Defaults to ptrace_report_syscall_entry.
> + *
> + * The main purpose is to support arch-specific ptrace_report_syscall_entry()
> + * implementation.
> + */
> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs);
> +
> +#ifndef arch_ptrace_report_syscall_entry
> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs)
> +{
> +	return ptrace_report_syscall_entry(regs);

I saw that Thomas suggested this approach on v4, and it makes sense to
me, but I find the naming surprising. If an architecture does need extra
handling, then the generic function should never be called from generic
code. So it seems to me that the more logical change would be:

* Rename: ptrace_report_syscall_entry -> __ptrace_report_syscall_entry
* Introduce ptrace_report_syscall_entry(), defaults to
__ptrace_report_syscall_entry()

All this would be done in <linux/ptrace.h>, where it clearly belongs.
The __ prefix makes it clear that the generic function is not the main
interface. Even better, no need to change any caller with that approach.

- Kevin

> +}
> +#endif
> +
>  long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  				unsigned long work)
>  {
> @@ -34,7 +53,7 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  
>  	/* Handle ptrace */
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
> -		ret = ptrace_report_syscall_entry(regs);
> +		ret = arch_ptrace_report_syscall_entry(regs);
>  		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
>  			return -1L;
>  	}
> @@ -84,6 +103,26 @@ static inline bool report_single_step(unsigned long work)
>  	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
>  }
>  
> +/**
> + * arch_ptrace_report_syscall_exit - Architecture specific
> + *				     ptrace_report_syscall_exit.
> + *
> + * Invoked from syscall_exit_work() to wrap ptrace_report_syscall_exit().
> + *
> + * The main purpose is to support arch-specific ptrace_report_syscall_exit
> + * implementation.
> + */
> +static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
> +							    int step);
> +
> +#ifndef arch_ptrace_report_syscall_exit
> +static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
> +							    int step)
> +{
> +	ptrace_report_syscall_exit(regs, step);
> +}
> +#endif
> +
>  void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>  {
>  	bool step;
> @@ -108,5 +147,5 @@ void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>  
>  	step = report_single_step(work);
>  	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
> -		ptrace_report_syscall_exit(regs, step);
> +		arch_ptrace_report_syscall_exit(regs, step);
>  }

