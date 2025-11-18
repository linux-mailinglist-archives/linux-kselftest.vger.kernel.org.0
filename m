Return-Path: <linux-kselftest+bounces-45876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4692DC6AE41
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E52E13A6ABD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379F35CB9B;
	Tue, 18 Nov 2025 17:09:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E0283FE2;
	Tue, 18 Nov 2025 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485776; cv=none; b=OoaSCLhEIukmDF3myojomMNO8fEx0LZA7+5v7mtUEtJ/RciNgp+tkV5V/EZlx6RFZVJmhIiWAckkTYGBWthF0pXKHlrZmB5q7pfu8RDOKlhDpNeTTTI45vmKVJD9zW39XlziO89+GJ8oBE3uT4QxMNCjt5QLPIeD1Iv8p1QiAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485776; c=relaxed/simple;
	bh=PxkNeIggyTBWuk+fxgSQ5VWzLeflCAbLnHl2KegEVW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gab47glby4xmXXKrBX9LiEsT9C4bgbNIwpWuRPOXUHO53kWbQFLLKfR5g9u0G3Dvx7te/bRx0VphphPXL9A0TYMzoQIlFUgz+vpRgdebnSnr0zzElvlGqItC15Rtz9zL4i2uiemtA24tNB09xrC0Lznf5xXJ3T7XZiRTTT1n9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E205A497;
	Tue, 18 Nov 2025 09:09:26 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A87D83F66E;
	Tue, 18 Nov 2025 09:09:29 -0800 (PST)
Message-ID: <970d9689-4188-4c40-92e6-bdf1e589e8a2@arm.com>
Date: Tue, 18 Nov 2025 18:09:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/11] arm64/ptrace: Split report_syscall()
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
 <20251117133048.53182-2-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 14:30, Jinjie Ruan wrote:
> The generic syscall entry code has the form:
>
> | syscall_trace_enter()
> | {
> |	ptrace_report_syscall_entry()
> | }
> |
> | syscall_exit_work()
> | {
> |	ptrace_report_syscall_exit()
> | }
>
> In preparation for moving arm64 over to the generic entry code, split
> report_syscall() to two separate enter and exit functions to align
> the structure of the arm64 code with syscall_trace_enter() and
> syscall_exit_work() from the generic entry code.
>
> No functional changes.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/ptrace.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 4b001121c72d..5534c175ceb7 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2317,7 +2317,7 @@ enum ptrace_syscall_dir {
>  	PTRACE_SYSCALL_EXIT,
>  };

This is now unused so it should be removed.

>  
> -static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
> +static void report_syscall_enter(struct pt_regs *regs)

Nit: better to call it "report_syscall_entry" to match its final name.

>  {
>  	int regno;
>  	unsigned long saved_reg;
> @@ -2340,13 +2340,24 @@ static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
>  	 */
>  	regno = (is_compat_task() ? 12 : 7);
>  	saved_reg = regs->regs[regno];
> -	regs->regs[regno] = dir;
> +	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
>  
> -	if (dir == PTRACE_SYSCALL_ENTER) {
> -		if (ptrace_report_syscall_entry(regs))
> -			forget_syscall(regs);
> -		regs->regs[regno] = saved_reg;
> -	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
> +	if (ptrace_report_syscall_entry(regs))
> +		forget_syscall(regs);
> +	regs->regs[regno] = saved_reg;
> +}
> +
> +static void report_syscall_exit(struct pt_regs *regs)
> +{
> +	int regno;
> +	unsigned long saved_reg;
> +
> +	/* See comment for report_syscall_enter() above */
> +	regno = (is_compat_task() ? 12 : 7);

Probably best not to duplicate such magic numbers, moving this line to a
helper would be good.

- Kevin

> +	saved_reg = regs->regs[regno];
> +	regs->regs[regno] = PTRACE_SYSCALL_EXIT;
> +
> +	if (!test_thread_flag(TIF_SINGLESTEP)) {
>  		ptrace_report_syscall_exit(regs, 0);
>  		regs->regs[regno] = saved_reg;
>  	} else {
> @@ -2366,7 +2377,7 @@ int syscall_trace_enter(struct pt_regs *regs)
>  	unsigned long flags = read_thread_flags();
>  
>  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> -		report_syscall(regs, PTRACE_SYSCALL_ENTER);
> +		report_syscall_enter(regs);
>  		if (flags & _TIF_SYSCALL_EMU)
>  			return NO_SYSCALL;
>  	}
> @@ -2394,7 +2405,7 @@ void syscall_trace_exit(struct pt_regs *regs)
>  		trace_sys_exit(regs, syscall_get_return_value(current, regs));
>  
>  	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
> -		report_syscall(regs, PTRACE_SYSCALL_EXIT);
> +		report_syscall_exit(regs);
>  
>  	rseq_syscall(regs);
>  }

