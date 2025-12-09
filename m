Return-Path: <linux-kselftest+bounces-47301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4CCB0146
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 14:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6C32301373E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E31EFF93;
	Tue,  9 Dec 2025 13:46:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7278AAD4B;
	Tue,  9 Dec 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287976; cv=none; b=OkyEYPZVxKqfna4i0kuG0FOZ211jNxBkVyrEUUwIfJzGOyAoJJylo9PEAj5xQEgXbd4KGzfhBG/K8hbR7skW1LTggHkmTs6uhiDo/tRsrC0bA/ZYbLFx7Pb7WCKrheHhE0FMCo9UgtGMyG1n22TtN6OqFntqnx1ORQL3IJuV2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287976; c=relaxed/simple;
	bh=EqRzRW2j1n9QUJjCGCQOoOQwRVFwkqJvNOvYlxhyXA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kc/NPo93mFzOjn21V7vpnM+T4qJ0UPqZx5tk4AZXjux/oiN0aO4qQs49MWrJfgIhFQr7dKqFOWy0zoQebYXRMGnka0SlfOtNFG36BueqTywUTIi+q9hxra6aEzZv1+BUSfBk4wR0hx2xLqNTSNUxwxvS5PDBvESyftWYnr2SkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A52C1691;
	Tue,  9 Dec 2025 05:46:06 -0800 (PST)
Received: from [10.57.45.100] (unknown [10.57.45.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E1EF3F762;
	Tue,  9 Dec 2025 05:46:08 -0800 (PST)
Message-ID: <52f63e40-541f-4ed8-9d05-626eab4b39cb@arm.com>
Date: Tue, 9 Dec 2025 14:46:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/16] arm64/ptrace: Return early for
 ptrace_report_syscall_entry() error
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 deller@gmx.de, macro@orcam.me.uk, charlie@rivosinc.com, ldv@strace.io,
 mark.rutland@arm.com, song@kernel.org, ryan.roberts@arm.com,
 ada.coupriediaz@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-4-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251204082123.2792067-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2025 09:21, Jinjie Ruan wrote:
> The generic entry abort the syscall_trace_enter() sequence if
> ptrace_report_syscall_entry() errors out, but arm64 not.
>
> As the ptrace_report_syscall_entry() comment said, the calling arch code
> should abort the system call and must prevent normal entry so no system
> call is made if ptrace_report_syscall_entry() return nonzero.

This patch is now in the right position, which means that arm64 does
abort the syscall already without this patch. What we're changing here
is that the tracing sequence is interrupted. The comment you're
referring to says nothing about tracing so I'm not sure it helps to
refer to it.

Otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> In preparation for moving arm64 over to the generic entry code,
> return early if ptrace_report_syscall_entry() encounters an error.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/ptrace.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 4532e9831856..3926ce6aa268 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2346,15 +2346,18 @@ static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
>  	return saved_reg;
>  }
>  
> -static void report_syscall_entry(struct pt_regs *regs)
> +static int report_syscall_entry(struct pt_regs *regs)
>  {
>  	unsigned long saved_reg;
> -	int regno;
> +	int regno, ret;
>  
>  	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
> -	if (ptrace_report_syscall_entry(regs))
> +	ret = ptrace_report_syscall_entry(regs);
> +	if (ret)
>  		forget_syscall(regs);
>  	regs->regs[regno] = saved_reg;
> +
> +	return ret;
>  }
>  
>  static void report_syscall_exit(struct pt_regs *regs)
> @@ -2381,10 +2384,11 @@ static void report_syscall_exit(struct pt_regs *regs)
>  int syscall_trace_enter(struct pt_regs *regs)
>  {
>  	unsigned long flags = read_thread_flags();
> +	int ret;
>  
>  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> -		report_syscall_entry(regs);
> -		if (flags & _TIF_SYSCALL_EMU)
> +		ret = report_syscall_entry(regs);
> +		if (ret || (flags & _TIF_SYSCALL_EMU))
>  			return NO_SYSCALL;
>  	}
>  

