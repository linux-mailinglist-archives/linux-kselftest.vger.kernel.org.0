Return-Path: <linux-kselftest+bounces-46414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C10C83489
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 05:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D13AE67C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 04:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418BE1A08BC;
	Tue, 25 Nov 2025 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IEDyH3OH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C634CDD;
	Tue, 25 Nov 2025 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764043230; cv=none; b=Fi/4FhqgV+XPEU1kH2zZrhdxh20fXZCzCaFJcjvnu7vDvhEopx+8B68YCV/L0uoyiKI3SUBGB20jsU+AFqGAzMokX9VcTcbG9jMPKnON6pWudOgLbT9vPxJqTzvA+ixTBCwCFfK0r7pMWlfSU0ptJRW7TQOzjrm0gsXv37D/O7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764043230; c=relaxed/simple;
	bh=FSOpvffTHxrtP2+0ERX476F4IKzKkX5YTA4Gel/th2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wr+5vHDPYQxk4PWVjxkMiTQme9Se6wQKIlAXFtn0zA8N8D7PTJbnjqfzcV/e4a1ucrVXcrobltVsPljcC5azt0RLlV2axYKrISRG75764PIaqfLCOWssnUIvL5cm+wdxfCWKXyhM3QBrbXjqYEIbME+yqh7DxgHkuLhWhrHyNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IEDyH3OH; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ELXTwGY0hM7dn0+0iq2f3NZlNVlqA0NTCJCNOs3mI/4=;
	b=IEDyH3OHckz0WjRzWbzdGrAxLHl5zOZAkGjmivqq5y8T9xeIZe4YwAvuJNmhVgwUBo9Ga8nE0
	kye4yRE8OnZQd5gVcXVwXzIJdqGqzmqx4Jw2lf4aUeqcmIskEsahF7vzGokgq1ISc/3lLAwh7UK
	pfkBhEvyIRWUXbaMe5wwvLI=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dFpnb36PCzcZyV;
	Tue, 25 Nov 2025 11:58:11 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 41F4C14022D;
	Tue, 25 Nov 2025 12:00:24 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 12:00:23 +0800
Message-ID: <a832b414-8da7-6333-b01e-ffd509f52ab7@huawei.com>
Date: Tue, 25 Nov 2025 12:00:22 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v7 10/11] arm64: entry: Convert to generic entry
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <oleg@redhat.com>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <macro@orcam.me.uk>, <deller@gmx.de>,
	<mark.rutland@arm.com>, <song@kernel.org>, <mbenes@suse.cz>,
	<ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <pengcan@kylinos.cn>,
	<dvyukov@google.com>, <kmal@cock.li>, <lihongbo22@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251117133048.53182-1-ruanjinjie@huawei.com>
 <20251117133048.53182-11-ruanjinjie@huawei.com>
 <39243d7f-e72a-4d37-8cd2-fb9c9f53e751@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <39243d7f-e72a-4d37-8cd2-fb9c9f53e751@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/11/19 1:14, Kevin Brodsky wrote:
> On 17/11/2025 14:30, Jinjie Ruan wrote:
>> [...]
>>
>> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
>> index 6225981fbbdb..c91938718468 100644
>> --- a/arch/arm64/include/asm/syscall.h
>> +++ b/arch/arm64/include/asm/syscall.h
>> @@ -9,6 +9,8 @@
>>  #include <linux/compat.h>
>>  #include <linux/err.h>
>>  
>> +#include <asm/vdso.h>
>> +
>>  typedef long (*syscall_fn_t)(const struct pt_regs *regs);
>>  
>>  extern const syscall_fn_t sys_call_table[];
>> @@ -114,12 +116,30 @@ static inline int syscall_get_arch(struct task_struct *task)
>>  	return AUDIT_ARCH_AARCH64;
>>  }
>>  
>> -static inline bool has_syscall_work(unsigned long flags)
>> +static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
>>  {
>> -	return unlikely(flags & _TIF_SYSCALL_WORK);
>> -}
>> +	unsigned long vdso = (unsigned long)current->mm->context.vdso;
>> +	unsigned long vdso_pages, vdso_text_len;
>> +	unsigned long pc = regs->pc - 4;
> 
> On AArch32 (i.e. COMPAT), instructions may be 16-bit (in T32/Thumb), so
> we shouldn't blindly use PC - 4.
> 
>>  
>> -int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
>> -void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
>> +#ifdef CONFIG_COMPAT
>> +	if (is_compat_task()) {
>> +		vdso = (unsigned long)current->mm->context.sigpage;
>> +		if (pc >= vdso && pc < vdso + PAGE_SIZE)
> 
> Just return that expression (instead of true/false).
> 
> I think the approach is reasonable, as we have 4 possible trampolines in
> COMPAT and they all live in a dedicated page. I don't think we need to
> worry about offsetting PC, because even if it points after the last
> trampoline, it will still fall within the page. IOW, just use the
> unmodified value of regs->pc.
> 
>> +			return true;
>> +
>> +		return false;
>> +	}
>> +#endif
>> +	if (regs->syscallno != __NR_rt_sigreturn)
>> +		return false;
>> +
>> +	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
>> +	vdso_text_len = vdso_pages << PAGE_SHIFT;
>> +	if (pc < vdso || pc >= vdso + vdso_text_len)
>> +		return false;
> 
> Why not use the same approach as x86 and simply check that regs->pc
> points after the trampoline? We already have a way to get the address of
> the vDSO's sigreturn trampoline on arm64:
> VDSO_SYMBOL(current->mm->context.vdso, sigtramp) (see signal.c). The
> trampoline consists of two instructions that cannot be changed (pretty
> much part of the ABI), so we could compare regs->pc with sigtramp + 8.

Will update it.

> 
>> +
>> +	return true;
>> +}
>>  #endif	/* __ASM_SYSCALL_H */
>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>> index f241b8601ebd..0c083be23018 100644
>> --- a/arch/arm64/include/asm/thread_info.h
>> +++ b/arch/arm64/include/asm/thread_info.h
>> @@ -43,6 +43,7 @@ struct thread_info {
>>  	void			*scs_sp;
>>  #endif
>>  	u32			cpu;
>> +	unsigned long		syscall_work;   /* SYSCALL_WORK_ flags */
>>  };
>>  
>>  #define thread_saved_pc(tsk)	\
>> @@ -65,11 +66,6 @@ void arch_setup_new_exec(void);
>>  #define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
>>  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
>>  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>> -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
>> -#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
>> -#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
>> -#define TIF_SECCOMP		11	/* syscall secure computing */
>> -#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
>>  #define TIF_PATCH_PENDING	13	/* pending live patching update */
>>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>>  #define TIF_FREEZE		19
>> @@ -92,30 +88,14 @@ void arch_setup_new_exec(void);
>>  #define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
>>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>>  #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
>> -#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
>> -#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>> -#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
>> -#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
>> -#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
>>  #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
>>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>> -#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>>  #define _TIF_32BIT		(1 << TIF_32BIT)
>>  #define _TIF_SVE		(1 << TIF_SVE)
>>  #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
>>  #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>>  #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
>>  
>> -#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
>> -				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
>> -				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
>> -				 _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING | \
>> -				 _TIF_PATCH_PENDING)
> 
> AFAICT this was already unused before this series, since commit
> b3cf07851b6c ("arm64: entry: Switch to generic IRQ entry"). It should be
> removed in a separate commit.

Yes, it was already unused before this series

> 
>> [...]
>>
>> -void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
>> -{
>> -	unsigned long flags = read_thread_flags();
>> -
>> -	rseq_syscall(regs);
>> -
>> -	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
> 
> I believe switching to the generic function introduces a change here:
> syscall_exit_work() is only called if a flag in SYSCALL_WORK_EXIT is
> set, and this set does not include SYSCALL_EMU and SECCOMP. Practically
> this means that audit_syscall_exit() will no longer be called if only
> SECCOMP and/or SYSCALL_EMU is set.
> 
> It doesn't feel like a major behaviour change, but it should be pointed out.

We can add "ARCH_SYSCALL_WORK_EXIT" to be defined as "SECCOMP
||SYSCALL_EMU" to keep the behaviour unchanged.

> 
> - Kevin
> 
>> -		syscall_trace_exit(regs, flags);
>> -}
>>
>> [...]
> 

