Return-Path: <linux-kselftest+bounces-46647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D9C8E7E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D78204E9D84
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6EA28A705;
	Thu, 27 Nov 2025 13:31:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78B28751A;
	Thu, 27 Nov 2025 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250282; cv=none; b=tZIKswK4/T5o08nZplVT8Wee3H9+xm4MqaZl09ItuVRbf1LWI5D6vvBK+t7SwavnZvV2RmFgMQPu/aCT1BMqe2s3EY8CYJh3V802itIzTqD9sCtaTDJzfLCb6W8RX+0tyuKntn4kzDhzC7LrqnCus2wCpCRNrubdwbVBM7Dda/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250282; c=relaxed/simple;
	bh=Pw9CfJqXgQ0cI0WodMvC/UXB0kEYzoSPRyfdhSA2W6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hix735g9BPI0+gDO+1SEzQMsr4UIPoXEU4KkCsRObOE6/v3oVmuecgVjCPA9ySccHtY/Ypl5cVoCutcJWXoSZOfnZncBOVxPtEjc86JChryxms/abOXmJetWnwtYIqeq9DvLQ7x+KHzoiHcTSjus6iJj709drKI83OAV6wHVljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7648A1764;
	Thu, 27 Nov 2025 05:31:12 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5373D3F66E;
	Thu, 27 Nov 2025 05:31:13 -0800 (PST)
Message-ID: <c6cf8755-34d0-468d-99c4-ac6d266f9efb@arm.com>
Date: Thu, 27 Nov 2025 14:31:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/12] arm64: entry: Convert to generic entry
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 charlie@rivosinc.com, akpm@linux-foundation.org, ldv@strace.io,
 macro@orcam.me.uk, deller@gmx.de, mark.rutland@arm.com, efault@gmx.de,
 song@kernel.org, mbenes@suse.cz, ryan.roberts@arm.com,
 ada.coupriediaz@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com, kmal@cock.li,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251126071446.3234218-1-ruanjinjie@huawei.com>
 <20251126071446.3234218-12-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251126071446.3234218-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 08:14, Jinjie Ruan wrote:
> Currently, x86, Riscv, Loongarch use the generic entry which makes
> maintainers' work easier and codes more elegant. arm64 has already
> switched to the generic IRQ entry, so completely convert arm64 to use
> the generic entry infrastructure from kernel/entry/*.
>
> The changes are below:
>  - Remove TIF_SYSCALL_* flag, _TIF_WORK_MASK, _TIF_SYSCALL_WORK,

_TIF_WORK_MASK is now removed in patch 1.

>    and remove has_syscall_work(), as _TIF_SYSCALL_WORK is equal with
>    SYSCALL_WORK_ENTER.
>
> [...]
>
> +static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
> +							    int step)
> +{
> +	unsigned long saved_reg;
> +	int regno;
> +
> +	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_EXIT, &regno);
> +	if (!step) {

A difference I noticed here is that the generic report_single_step()
always returns false if SYSCALL_EMU is set. I don't know if the
combination of SYSCALL_EMU and SINGLESTEP is meaningful, but if it is
then I think that's a behaviour change.

> +		ptrace_report_syscall_exit(regs, 0);
> +		regs->regs[regno] = saved_reg;
> +	} else {
> +		regs->regs[regno] = saved_reg;
> +
> +		/*
> +		 * Signal a pseudo-step exception since we are stepping but
> +		 * tracer modifications to the registers may have rewound the
> +		 * state machine.
> +		 */
> +		ptrace_report_syscall_exit(regs, 1);
> +	}
> +}
> +
> +#define arch_ptrace_report_syscall_exit arch_ptrace_report_syscall_exit
> +
>  #endif /* _ASM_ARM64_ENTRY_COMMON_H */
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index 6225981fbbdb..f705ba2bb6fd 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -9,6 +9,9 @@
>  #include <linux/compat.h>
>  #include <linux/err.h>
>  
> +#include <asm/compat.h>
> +#include <asm/vdso.h>
> +
>  typedef long (*syscall_fn_t)(const struct pt_regs *regs);
>  
>  extern const syscall_fn_t sys_call_table[];
> @@ -114,12 +117,21 @@ static inline int syscall_get_arch(struct task_struct *task)
>  	return AUDIT_ARCH_AARCH64;
>  }
>  
> -static inline bool has_syscall_work(unsigned long flags)
> +static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>  {
> -	return unlikely(flags & _TIF_SYSCALL_WORK);
> +	unsigned long sigtramp;
> +
> +#ifdef CONFIG_COMPAT
> +	if (is_compat_task()) {
> +		unsigned long vdso = (unsigned long)current->mm->context.sigpage;

Might as well call it sigpage (separate from the vDSO on arm32).

> +
> +		return (regs->pc >= vdso && regs->pc < (vdso + PAGE_SIZE));

Nit: no need for parentheses around the expression to return.

> +	}
> +#endif
> +	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
> +	return regs->pc == (sigtramp + 8);
>  }
>  
> -int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
> -void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
> +#define ARCH_SYSCALL_WORK_EXIT	(_TIF_SECCOMP | _TIF_SYSCALL_EMU)
>  
>  #endif	/* __ASM_SYSCALL_H */
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index ff4998fa1844..d3142b5d1b9c 100644
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
> @@ -65,11 +66,8 @@ void arch_setup_new_exec(void);
>  #define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
>  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
> -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
> -#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
> -#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> -#define TIF_SECCOMP		11	/* syscall secure computing */
> -#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
> +#define TIF_SECCOMP		11      /* syscall secure computing */
> +#define TIF_SYSCALL_EMU		12      /* syscall emulation active */

These seem to have reappeared in v8 for some reason?

>  #define TIF_PATCH_PENDING	13	/* pending live patching update */
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>  #define TIF_FREEZE		19
> @@ -92,24 +90,16 @@ void arch_setup_new_exec(void);
>  #define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
> -#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
> -#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
> -#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
>  #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)

Ditto.

>  #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
> -#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>  #define _TIF_32BIT		(1 << TIF_32BIT)
>  #define _TIF_SVE		(1 << TIF_SVE)
>  #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
>  #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
>  
> -#define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
> -				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> -				 _TIF_SYSCALL_EMU)
> -
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  #define INIT_SCS							\
>  	.scs_base	= init_shadow_call_stack,			\
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 29307642f4c9..e67643a70405 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -385,11 +385,18 @@ void user_enable_single_step(struct task_struct *task)
>  
>  	if (!test_and_set_ti_thread_flag(ti, TIF_SINGLESTEP))
>  		set_regs_spsr_ss(task_pt_regs(task));
> +
> +	/*
> +	 * Ensure that a trap is triggered once stepping out of a system
> +	 * call prior to executing any user instruction.
> +	 */
> +	set_task_syscall_work(task, SYSCALL_EXIT_TRAP);
>  }
>  NOKPROBE_SYMBOL(user_enable_single_step);
>  
>  void user_disable_single_step(struct task_struct *task)
>  {
>  	clear_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
> +	clear_task_syscall_work(task, SYSCALL_EXIT_TRAP);
>  }
>  NOKPROBE_SYMBOL(user_disable_single_step);
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index c2bd0130212d..9e3b39e207d1 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -42,9 +42,6 @@
>  #include <asm/traps.h>
>  #include <asm/system_misc.h>
>  
> -#define CREATE_TRACE_POINTS
> -#include <trace/events/syscalls.h>
> -
>  struct pt_regs_offset {
>  	const char *name;
>  	int offset;
> @@ -2312,141 +2309,6 @@ long arch_ptrace(struct task_struct *child, long request,
>  	return ptrace_request(child, request, addr, data);
>  }
>  
> -enum ptrace_syscall_dir {
> -	PTRACE_SYSCALL_ENTER = 0,
> -	PTRACE_SYSCALL_EXIT,
> -};
> -
> -static inline unsigned long ptrace_save_reg(struct pt_regs *regs,
> -					    enum ptrace_syscall_dir dir,
> -					    int *regno)
> -{
> -	unsigned long saved_reg;
> -
> -	/*
> -	 * We have some ABI weirdness here in the way that we handle syscall
> -	 * exit stops because we indicate whether or not the stop has been
> -	 * signalled from syscall entry or syscall exit by clobbering a general
> -	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
> -	 * and restoring its old value after the stop. This means that:
> -	 *
> -	 * - Any writes by the tracer to this register during the stop are
> -	 *   ignored/discarded.
> -	 *
> -	 * - The actual value of the register is not available during the stop,
> -	 *   so the tracer cannot save it and restore it later.
> -	 *
> -	 * - Syscall stops behave differently to seccomp and pseudo-step traps
> -	 *   (the latter do not nobble any registers).
> -	 */
> -	*regno = (is_compat_task() ? 12 : 7);
> -	saved_reg = regs->regs[*regno];
> -	regs->regs[*regno] = dir;
> -
> -	return saved_reg;
> -}
> -
> -static int report_syscall_entry(struct pt_regs *regs)
> -{
> -	unsigned long saved_reg;
> -	int regno, ret;
> -
> -	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
> -	ret = ptrace_report_syscall_entry(regs);
> -	if (ret)
> -		forget_syscall(regs);
> -	regs->regs[regno] = saved_reg;
> -
> -	return ret;
> -}
> -
> -static void report_syscall_exit(struct pt_regs *regs)
> -{
> -	unsigned long saved_reg;
> -	int regno;
> -
> -	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_EXIT, &regno);
> -	if (!test_thread_flag(TIF_SINGLESTEP)) {
> -		ptrace_report_syscall_exit(regs, 0);
> -		regs->regs[regno] = saved_reg;
> -	} else {
> -		regs->regs[regno] = saved_reg;
> -
> -		/*
> -		 * Signal a pseudo-step exception since we are stepping but
> -		 * tracer modifications to the registers may have rewound the
> -		 * state machine.
> -		 */
> -		ptrace_report_syscall_exit(regs, 1);
> -	}
> -}
> -
> -static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
> -{
> -	if (unlikely(audit_context())) {
> -		unsigned long args[6];
> -
> -		syscall_get_arguments(current, regs, args);
> -		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> -	}
> -}
> -
> -int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
> -{
> -	int ret;
> -
> -	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> -		ret = report_syscall_entry(regs);
> -		if (ret || (flags & _TIF_SYSCALL_EMU))
> -			return NO_SYSCALL;
> -	}
> -
> -	/* Do the secure computing after ptrace; failures should be fast. */
> -	if (flags & _TIF_SECCOMP) {
> -		ret = __secure_computing();
> -		if (ret == -1)
> -			return NO_SYSCALL;
> -	}
> -
> -	/* Either of the above might have changed the syscall number */
> -	syscall = syscall_get_nr(current, regs);
> -
> -	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
> -		trace_sys_enter(regs, syscall);
> -
> -		/*
> -		 * Probes or BPF hooks in the tracepoint may have changed the
> -		 * system call number as well.
> -		 */
> -		 syscall = syscall_get_nr(current, regs);
> -	}
> -
> -	syscall_enter_audit(regs, syscall);
> -
> -	return ret ? : syscall;
> -}
> -
> -static void syscall_exit_work(struct pt_regs *regs, unsigned long flags)
> -{
> -	audit_syscall_exit(regs);
> -
> -	if (flags & _TIF_SYSCALL_TRACEPOINT)
> -		trace_sys_exit(regs, syscall_get_return_value(current, regs));
> -
> -	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
> -		report_syscall_exit(regs);
> -}
> -
> -void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
> -{
> -	unsigned long flags = read_thread_flags();
> -
> -	rseq_syscall(regs);
> -
> -	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
> -		syscall_exit_work(regs, flags);
> -}

Aside from the small change in arch_ptrace_report_syscall_exit(), these
look exactly equivalent to the generic functions, so LGTM.

- Kevin

