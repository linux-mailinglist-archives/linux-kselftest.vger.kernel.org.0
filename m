Return-Path: <linux-kselftest+bounces-45897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BA3C6AF18
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 997623A8C28
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54AB33C191;
	Tue, 18 Nov 2025 17:14:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2DD31ED8E;
	Tue, 18 Nov 2025 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486098; cv=none; b=d219zzTwotak5J/1WMVST0s7HyiTtGsXark+M8N+hZoZA6PRPbfL1CB9QKgD8H5gopXfgz9IaaNLddNLr+d3dt6dJmfypOmMktIt/oEikL4fL1X0ALWVl70fPODNRxm4QkxSXD4eTZ0AnhQHMYzSE1sLUBPz9+kZ68RsaDqVyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486098; c=relaxed/simple;
	bh=gEsf+gH61daFMStd7VAxlqlP2RgvpbauCMS0yDBeLzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IfA6Jt1vZR6SBxJJJ9MC6nRNHem/wXKz4soikFOtM9XukR34dAlJ0WNsY2swviGochYTMju9yerWDPuoG7OzI/XvyKXSn4v0uUjSJfrKi7dGWB6mxXXTnM3rdJlyGRNL9PZ7J3c0GrFAhJ8s7AyzTZEyOE4XVoGtyRi2hXN1bjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FD321692;
	Tue, 18 Nov 2025 09:14:48 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E25563F66E;
	Tue, 18 Nov 2025 09:14:50 -0800 (PST)
Message-ID: <39243d7f-e72a-4d37-8cd2-fb9c9f53e751@arm.com>
Date: Tue, 18 Nov 2025 18:14:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] arm64: entry: Convert to generic entry
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
 <20251117133048.53182-11-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 14:30, Jinjie Ruan wrote:
> [...]
>
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index 6225981fbbdb..c91938718468 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -9,6 +9,8 @@
>  #include <linux/compat.h>
>  #include <linux/err.h>
>  
> +#include <asm/vdso.h>
> +
>  typedef long (*syscall_fn_t)(const struct pt_regs *regs);
>  
>  extern const syscall_fn_t sys_call_table[];
> @@ -114,12 +116,30 @@ static inline int syscall_get_arch(struct task_struct *task)
>  	return AUDIT_ARCH_AARCH64;
>  }
>  
> -static inline bool has_syscall_work(unsigned long flags)
> +static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>  {
> -	return unlikely(flags & _TIF_SYSCALL_WORK);
> -}
> +	unsigned long vdso = (unsigned long)current->mm->context.vdso;
> +	unsigned long vdso_pages, vdso_text_len;
> +	unsigned long pc = regs->pc - 4;

On AArch32 (i.e. COMPAT), instructions may be 16-bit (in T32/Thumb), so
we shouldn't blindly use PC - 4.

>  
> -int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
> -void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
> +#ifdef CONFIG_COMPAT
> +	if (is_compat_task()) {
> +		vdso = (unsigned long)current->mm->context.sigpage;
> +		if (pc >= vdso && pc < vdso + PAGE_SIZE)

Just return that expression (instead of true/false).

I think the approach is reasonable, as we have 4 possible trampolines in
COMPAT and they all live in a dedicated page. I don't think we need to
worry about offsetting PC, because even if it points after the last
trampoline, it will still fall within the page. IOW, just use the
unmodified value of regs->pc.

> +			return true;
> +
> +		return false;
> +	}
> +#endif
> +	if (regs->syscallno != __NR_rt_sigreturn)
> +		return false;
> +
> +	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
> +	vdso_text_len = vdso_pages << PAGE_SHIFT;
> +	if (pc < vdso || pc >= vdso + vdso_text_len)
> +		return false;

Why not use the same approach as x86 and simply check that regs->pc
points after the trampoline? We already have a way to get the address of
the vDSO's sigreturn trampoline on arm64:
VDSO_SYMBOL(current->mm->context.vdso, sigtramp) (see signal.c). The
trampoline consists of two instructions that cannot be changed (pretty
much part of the ABI), so we could compare regs->pc with sigtramp + 8.

> +
> +	return true;
> +}
>  #endif	/* __ASM_SYSCALL_H */
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index f241b8601ebd..0c083be23018 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -43,6 +43,7 @@ struct thread_info {
>  	void			*scs_sp;
>  #endif
>  	u32			cpu;
> +	unsigned long		syscall_work;   /* SYSCALL_WORK_ flags */
>  };
>  
>  #define thread_saved_pc(tsk)	\
> @@ -65,11 +66,6 @@ void arch_setup_new_exec(void);
>  #define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
>  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
> -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
> -#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
> -#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> -#define TIF_SECCOMP		11	/* syscall secure computing */
> -#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
>  #define TIF_PATCH_PENDING	13	/* pending live patching update */
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>  #define TIF_FREEZE		19
> @@ -92,30 +88,14 @@ void arch_setup_new_exec(void);
>  #define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
> -#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
> -#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
> -#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
> -#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
> -#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
>  #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
> -#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>  #define _TIF_32BIT		(1 << TIF_32BIT)
>  #define _TIF_SVE		(1 << TIF_SVE)
>  #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
>  #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
>  
> -#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
> -				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> -				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
> -				 _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING | \
> -				 _TIF_PATCH_PENDING)

AFAICT this was already unused before this series, since commit
b3cf07851b6c ("arm64: entry: Switch to generic IRQ entry"). It should be
removed in a separate commit.

> [...]
>
> -void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
> -{
> -	unsigned long flags = read_thread_flags();
> -
> -	rseq_syscall(regs);
> -
> -	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)

I believe switching to the generic function introduces a change here:
syscall_exit_work() is only called if a flag in SYSCALL_WORK_EXIT is
set, and this set does not include SYSCALL_EMU and SECCOMP. Practically
this means that audit_syscall_exit() will no longer be called if only
SECCOMP and/or SYSCALL_EMU is set.

It doesn't feel like a major behaviour change, but it should be pointed out.

- Kevin

> -		syscall_trace_exit(regs, flags);
> -}
>
> [...]

