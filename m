Return-Path: <linux-kselftest+bounces-47257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E75CAC17F
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 06:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D2D43001C2F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 05:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239586331;
	Mon,  8 Dec 2025 05:48:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCE62AE78;
	Mon,  8 Dec 2025 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765172906; cv=none; b=nNa6MY9yhSUeJHw+gmF3Ei4jbGuzj9LROfOtLG2AwgMxO25y4/BiZm6IK3jWsnnwEhbOw/WjxNR2F14+t1vuNtdHlNGbBNgSdKdm34YDhyy7RvHianFcMm7h6eqNX65yJBUzI2Kj2bITqdV7IT+DUOtKL56CfmNGK0prZ/VeU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765172906; c=relaxed/simple;
	bh=HACHYxKtWBB35vXwiRXSHDkz/E+ty1eVulvsAx2z6Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=acAPC77JuxxVqejslLwRAEj/T4CoJFFYheHO8RcMRK05UIROW+XJ3HDMJr5X9UxSP/7m/OxciiWnNW6DvD/cPciwYthpzUxzr9rbL92bXXafnVJpV/m7TmuXItEE4Cnp/xA9/zLJo7s4fWGYmkxsc51eRVrNHEqgXGXWUW1a6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6770B1692;
	Sun,  7 Dec 2025 21:48:16 -0800 (PST)
Received: from [10.164.18.52] (unknown [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 304C33F762;
	Sun,  7 Dec 2025 21:48:16 -0800 (PST)
Message-ID: <dd3a1421-dfb0-445e-b2f7-7c273fa4a020@arm.com>
Date: Mon, 8 Dec 2025 11:18:14 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] arm64/ptrace: Refactor
 syscall_trace_enter/exit()
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 deller@gmx.de, macro@orcam.me.uk, charlie@rivosinc.com,
 kevin.brodsky@arm.com, ldv@strace.io, mark.rutland@arm.com, song@kernel.org,
 ryan.roberts@arm.com, ada.coupriediaz@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-5-ruanjinjie@huawei.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251204082123.2792067-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/25 1:51 PM, Jinjie Ruan wrote:
> The generic syscall entry code has the following form, which use
> the input syscall work flag and syscall number:
> 
> | syscall_trace_enter(struct pt_regs *regs, long syscall,
> |		      unsigned long work)
> |
> | syscall_exit_work(struct pt_regs *regs, unsigned long work)
> 
> In preparation for moving arm64 over to the generic entry code,
> refactor syscall_trace_enter/exit() to also pass thread flags, and
> get syscall number by syscall_get_nr() helper.
> 
> No functional changes.
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/include/asm/syscall.h |  4 ++--
>  arch/arm64/kernel/ptrace.c       | 25 ++++++++++++++++---------
>  arch/arm64/kernel/syscall.c      |  5 +++--
>  3 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index 5e4c7fc44f73..cef1d9ce6e1b 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -120,7 +120,7 @@ static inline int syscall_get_arch(struct task_struct *task)
>  	return AUDIT_ARCH_AARCH64;
>  }
>  
> -int syscall_trace_enter(struct pt_regs *regs);
> -void syscall_trace_exit(struct pt_regs *regs);
> +int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
> +void syscall_trace_exit(struct pt_regs *regs, unsigned long flags);
>  
>  #endif	/* __ASM_SYSCALL_H */
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 3926ce6aa268..b962cbcca11d 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2381,9 +2381,8 @@ static void report_syscall_exit(struct pt_regs *regs)
>  	}
>  }
>  
> -int syscall_trace_enter(struct pt_regs *regs)
> +int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
>  {
> -	unsigned long flags = read_thread_flags();
>  	int ret;
>  
>  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> @@ -2396,19 +2395,27 @@ int syscall_trace_enter(struct pt_regs *regs)
>  	if (secure_computing() == -1)
>  		return NO_SYSCALL;
>  
> -	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> -		trace_sys_enter(regs, regs->syscallno);
> +	/* Either of the above might have changed the syscall number */
> +	syscall = syscall_get_nr(current, regs);
>  
> -	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> +	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
> +		trace_sys_enter(regs, syscall);
> +
> +		/*
> +		 * Probes or BPF hooks in the tracepoint may have changed the
> +		 * system call number as well.
> +		 */
> +		 syscall = syscall_get_nr(current, regs);
> +	}
> +
> +	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
>  			    regs->regs[2], regs->regs[3]);
>  
> -	return regs->syscallno;
> +	return syscall;

regs->syscallno still remains unchanged even if syscall is evaluated to be different ?

>  }
>  
> -void syscall_trace_exit(struct pt_regs *regs)
> +void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
>  {
> -	unsigned long flags = read_thread_flags();
> -
>  	audit_syscall_exit(regs);
>  
>  	if (flags & _TIF_SYSCALL_TRACEPOINT)
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index aba7ca6bca2d..ec31f82d2e9f 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -124,7 +124,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  		 */
>  		if (scno == NO_SYSCALL)
>  			syscall_set_return_value(current, regs, -ENOSYS, 0);
> -		scno = syscall_trace_enter(regs);
> +		scno = syscall_trace_enter(regs, scno, flags);
>  		if (scno == NO_SYSCALL)
>  			goto trace_exit;
>  	}
> @@ -143,7 +143,8 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  	}
>  
>  trace_exit:
> -	syscall_trace_exit(regs);
> +	flags = read_thread_flags();
> +	syscall_trace_exit(regs, flags);
>  }
>  
>  void do_el0_svc(struct pt_regs *regs)


