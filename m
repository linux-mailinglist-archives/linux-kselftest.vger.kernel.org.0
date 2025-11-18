Return-Path: <linux-kselftest+bounces-45879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB3C6ADD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BCD682BEEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54736B061;
	Tue, 18 Nov 2025 17:10:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC05288514;
	Tue, 18 Nov 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485855; cv=none; b=idBuZquFZnjpsI/kSM7rmMSxiXi7Y0lYZWXOhphHRg+tgyLcRpctm1Ix8r7f+3RGdCRLYhlkdMeudEk6nK4FpUN3Sc7xIOWmGTOaPmmFMGeLlqcO9fR0dw+TgfHkyaFjRtq/bXzOm4/99tcxHsyMFRKRokxbOx8iWv1cW+fJ0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485855; c=relaxed/simple;
	bh=/Uc281nLugbVMb8A4fGMDJAfBH5XvXt1z4kRaZd5WH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hP5xJwyGNidMPKkz2zy7CMXL3Td4QbwFvCRZkxr8+VlhU1pB7ETXNcq6zYB4xB7Vh3vPdUf1RGieGkTDeYsq6RpuqcAP+tYNjAtJ1s56CIUuzTORMAADvY1wwYelwGppn4CucAtIJM503NGriwZlyieXKQc5WdrLzvoot6I+9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 649E91516;
	Tue, 18 Nov 2025 09:10:45 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51BE83F66E;
	Tue, 18 Nov 2025 09:10:47 -0800 (PST)
Message-ID: <57c2c83c-9eea-40e0-9f95-47f21b1c75be@arm.com>
Date: Tue, 18 Nov 2025 18:10:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/11] arm64/ptrace: Refator el0_svc_common()
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
 <20251117133048.53182-4-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In subject: s/refator/refactor/

Also nit: this is less about ptrace than about syscall entry, so maybe
"arm64/syscall:"?

On 17/11/2025 14:30, Jinjie Ruan wrote:
> Compared to the generic entry code, arm64 terminate the process

s/terminate/terminates/ (similar observation for other commit messages)

> after report_syscall_exit() if the syscall is issued within
> a restartable sequence.

Presumably this implies that forcing SIGSEGV before or after calling the
tracing handlers makes no difference, if so it should be clarified.

> In preparation for moving arm64 over to the generic entry code,
> refactor el0_svc_common() as below:
>
> - Extract syscall_exit_to_user_mode_prepare() to replace the
>   the combination of read_thread_flags() and syscall_trace_exit(),
>   also move the syscall exit check logic into it.
>
> - Move rseq_syscall() ahead, so the CONFIG_DEBUG_RSEQ check is
>   not needed.
>
> - Move has_syscall_work() helper into asm/syscall.h, which will be
>   reused by ptrace.c.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/include/asm/syscall.h |  7 ++++++-
>  arch/arm64/kernel/ptrace.c       | 10 +++++++++-
>  arch/arm64/kernel/syscall.c      | 26 +++++---------------------
>  3 files changed, 20 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index d69f590a989b..6225981fbbdb 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -114,7 +114,12 @@ static inline int syscall_get_arch(struct task_struct *task)
>  	return AUDIT_ARCH_AARCH64;
>  }
>  
> +static inline bool has_syscall_work(unsigned long flags)
> +{
> +	return unlikely(flags & _TIF_SYSCALL_WORK);
> +}
> +
>  int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
> -void syscall_trace_exit(struct pt_regs *regs, unsigned long flags);
> +void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
>  
>  #endif	/* __ASM_SYSCALL_H */
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index bbb868f6b292..95984bbf53db 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2403,7 +2403,7 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
>  	return regs->syscallno;
>  }
>  
> -void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
> +static void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
>  {
>  	audit_syscall_exit(regs);
>  
> @@ -2412,8 +2412,16 @@ void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
>  
>  	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
>  		report_syscall_exit(regs);
> +}
> +
> +void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
> +{
> +	unsigned long flags = read_thread_flags();
>  
>  	rseq_syscall(regs);
> +
> +	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
> +		syscall_trace_exit(regs, flags);

Since we're trying to align as much with the generic code as possible,
we might as well rename this function to syscall_exit_work() as well.

>  }
>  
>  /*
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 6e3fe760e0bb..9713b038d750 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -65,11 +65,6 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	choose_random_kstack_offset(get_random_u16());
>  }
>  
> -static inline bool has_syscall_work(unsigned long flags)
> -{
> -	return unlikely(flags & _TIF_SYSCALL_WORK);
> -}
> -
>  static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  			   const syscall_fn_t syscall_table[])
>  {
> @@ -125,26 +120,15 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  		if (scno == NO_SYSCALL)
>  			syscall_set_return_value(current, regs, -ENOSYS, 0);
>  		scno = syscall_trace_enter(regs, regs->syscallno, flags);
> -		if (scno == NO_SYSCALL)
> -			goto trace_exit;

Why not keep the goto instead of duplicating the call? It could be
renamed if necessary.

- Kevin

> +		if (scno == NO_SYSCALL) {
> +			syscall_exit_to_user_mode_prepare(regs);
> +			return;
> +		}
>  	}
>  
>  	invoke_syscall(regs, scno, sc_nr, syscall_table);
>  
> -	/*
> -	 * The tracing status may have changed under our feet, so we have to
> -	 * check again. However, if we were tracing entry, then we always trace
> -	 * exit regardless, as the old entry assembly did.
> -	 */
> -	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> -		flags = read_thread_flags();
> -		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP))
> -			return;
> -	}
> -
> -trace_exit:
> -	flags = read_thread_flags();
> -	syscall_trace_exit(regs, flags);
> +	syscall_exit_to_user_mode_prepare(regs);
>  }
>  
>  void do_el0_svc(struct pt_regs *regs)

