Return-Path: <linux-kselftest+bounces-45877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7DC6ADAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 044052CAC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7863A5E86;
	Tue, 18 Nov 2025 17:09:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6429AAF3;
	Tue, 18 Nov 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485799; cv=none; b=EDL3GJoeiAZJNJXMQR9gvM2ST/Nuy/jh7pPssmsn7aoAf2RMt1HAzd4ADJL5g9Kff/qxkbz1cdbdHJqdYdMdasRsIamJdkOk54zR891O7QAKl5hXV6fO92f08AnPkoWBcx1rzYpSRgIYaK1NzRqdw1y31wPmCIN83rtd63R9RfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485799; c=relaxed/simple;
	bh=RWlkY82LDt1JhkrWv8gqef+RFdB6PU3WVyuXQ5A6oWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sCRcE1kCzqRegG9mpxeLLU20fdAV5WdED1R7pY3Ua2CxXcaKhw4d8MZnDpNkkOSzsbM7Dw/UvLEgqiHOOhphdhXIpNWhy7j/Kc94zUAOZOhgLf47kbOy82GKoH0fvoe/k45Hj1Q+yxFbZShSirVMu2ZZUFkjIMwk1fQGUwD38E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7114A1007;
	Tue, 18 Nov 2025 09:09:49 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B5E3F66E;
	Tue, 18 Nov 2025 09:09:52 -0800 (PST)
Message-ID: <4984d8e6-1431-4dcc-9723-c5470b5bcd49@arm.com>
Date: Tue, 18 Nov 2025 18:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/11] arm64/ptrace: Refactor
 syscall_trace_enter/exit()
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
 <20251117133048.53182-3-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 14:30, Jinjie Ruan wrote:
> [...]
>
> @@ -2386,19 +2384,27 @@ int syscall_trace_enter(struct pt_regs *regs)
>  	if (secure_computing() == -1)
>  		return NO_SYSCALL;
>  
> -	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> -		trace_sys_enter(regs, regs->syscallno);
> +	/* Either of the above might have changed the syscall number */
> +	syscall = syscall_get_nr(current, regs);
> +
> +	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
> +		trace_sys_enter(regs, syscall);
>  
> -	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
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
>  	return regs->syscallno;

It would be good to align the return with the generic version as well.

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
> index aba7ca6bca2d..6e3fe760e0bb 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -124,7 +124,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  		 */
>  		if (scno == NO_SYSCALL)
>  			syscall_set_return_value(current, regs, -ENOSYS, 0);
> -		scno = syscall_trace_enter(regs);
> +		scno = syscall_trace_enter(regs, regs->syscallno, flags);

Nit: could use scno instead of regs->syscallno.

- Kevin

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

