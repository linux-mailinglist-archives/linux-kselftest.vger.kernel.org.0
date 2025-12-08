Return-Path: <linux-kselftest+bounces-47255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB53CAC0AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 06:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F1E3301D666
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 05:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8809022CBD9;
	Mon,  8 Dec 2025 05:02:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D53B8D40;
	Mon,  8 Dec 2025 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765170144; cv=none; b=NS0HdW4as5AIEGiTGKL0W8UKOaM2PXQ2rjIqLlxeKY2HI8Vw9KW8VumkE8rPKqCQcf3plNqusSZtiqbhKA6dKZvUlIn3utnHxqd9NXCi8mcpN9VoypRg+CHCRuv3m/ftYTql+aEgsUvXLXAWBk+scd5WimoZxwDUHzgJLPdml3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765170144; c=relaxed/simple;
	bh=GrCW6lpytmdvhHsWDAir1hb/VLeBay0nv50dDkC6kqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MiZqk00umsk1tFwROGDCJJ70HmZbOquPXAkaWm8+21GSsvktUUD9d8P9StSvKecNYjYtLptqeCPSxN0+yoTLDQC0X/+lbmnATF/plE6s2g98jza54e2feXVuwDz/VcIjA2YH910uyDCpgCmgwvEgrl9cD11nd1Bfse157nllenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CC1C1595;
	Sun,  7 Dec 2025 21:02:14 -0800 (PST)
Received: from [10.164.18.52] (unknown [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC3033F762;
	Sun,  7 Dec 2025 21:02:14 -0800 (PST)
Message-ID: <b66f285f-20d8-4c29-ad0d-1ab0857b38b0@arm.com>
Date: Mon, 8 Dec 2025 10:32:12 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/16] arm64/ptrace: Split report_syscall()
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
 <20251204082123.2792067-3-ruanjinjie@huawei.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251204082123.2792067-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/25 1:51 PM, Jinjie Ruan wrote:
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
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> v8:
> - report_syscall_enter() -> report_syscall_entry().
> - Add ptrace_save_reg() helper.
> ---
>  arch/arm64/kernel/ptrace.c | 41 +++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 4b001121c72d..4532e9831856 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2317,9 +2317,10 @@ enum ptrace_syscall_dir {
>  	PTRACE_SYSCALL_EXIT,
>  };
>  
> -static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
> +static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
> +						     enum ptrace_syscall_dir dir,
> +						     int *regno)
>  {
> -	int regno;
>  	unsigned long saved_reg;
>  
>  	/*
> @@ -2338,15 +2339,31 @@ static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
>  	 * - Syscall stops behave differently to seccomp and pseudo-step traps
>  	 *   (the latter do not nobble any registers).
>  	 */
> -	regno = (is_compat_task() ? 12 : 7);
> -	saved_reg = regs->regs[regno];
> -	regs->regs[regno] = dir;
> +	*regno = (is_compat_task() ? 12 : 7);
> +	saved_reg = regs->regs[*regno];
> +	regs->regs[*regno] = dir;
>  
> -	if (dir == PTRACE_SYSCALL_ENTER) {
> -		if (ptrace_report_syscall_entry(regs))
> -			forget_syscall(regs);
> -		regs->regs[regno] = saved_reg;
> -	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
> +	return saved_reg;
> +}
> +
> +static void report_syscall_entry(struct pt_regs *regs)
> +{
> +	unsigned long saved_reg;
> +	int regno;
> +
> +	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
> +	if (ptrace_report_syscall_entry(regs))
> +		forget_syscall(regs);
> +	regs->regs[regno] = saved_reg;
> +}
> +
> +static void report_syscall_exit(struct pt_regs *regs)
> +{
> +	unsigned long saved_reg;
> +	int regno;
> +
> +	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_EXIT, &regno);
> +	if (!test_thread_flag(TIF_SINGLESTEP)) {
>  		ptrace_report_syscall_exit(regs, 0);
>  		regs->regs[regno] = saved_reg;
>  	} else {
> @@ -2366,7 +2383,7 @@ int syscall_trace_enter(struct pt_regs *regs)
>  	unsigned long flags = read_thread_flags();
>  
>  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> -		report_syscall(regs, PTRACE_SYSCALL_ENTER);
> +		report_syscall_entry(regs);
>  		if (flags & _TIF_SYSCALL_EMU)
>  			return NO_SYSCALL;
>  	}
> @@ -2394,7 +2411,7 @@ void syscall_trace_exit(struct pt_regs *regs)
>  		trace_sys_exit(regs, syscall_get_return_value(current, regs));
>  
>  	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
> -		report_syscall(regs, PTRACE_SYSCALL_EXIT);
> +		report_syscall_exit(regs);
>  
>  	rseq_syscall(regs);
>  }


