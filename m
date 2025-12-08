Return-Path: <linux-kselftest+bounces-47256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03792CAC127
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 06:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BBC8300B9B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 05:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBF530F55B;
	Mon,  8 Dec 2025 05:24:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB320283142;
	Mon,  8 Dec 2025 05:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765171486; cv=none; b=fymrF4jPsTN7SAlByfy/51/Mzd3oKZR5xwduwJf/ekRVSQAnKlFErLx5xf4PDfe6LANeQQEuhlWODkQ3ac5FP5F2jdR2+V5a5/n6KwjaF4VdSdCdksHhcAoIlIiF5IVhOWCNfM00sXN1bupM+yhNoEavVb9UMn8JF03yyKggs7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765171486; c=relaxed/simple;
	bh=Txp3Zvflw5ccCR+x3uJdwPZkbFZh9wbtQ7nDVReqPJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NKQhHjkbBuCv2StujBac9MmYB1AI8FpWpQxVivNIEeh8apnwv5PRLieyKAHnkpk3j2z3XKw2MhzKr2BAAVNplRVmRK0meuOWNHuWwoHN50/Hm6rgNAo8wGxVnc5pcMRO27fx28VQaGdwB/oMDDoMx92gzGFbdmdrDWnJKuCh70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C501E168F;
	Sun,  7 Dec 2025 21:24:36 -0800 (PST)
Received: from [10.164.18.52] (unknown [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 890053F762;
	Sun,  7 Dec 2025 21:24:37 -0800 (PST)
Message-ID: <7c7e5c66-f618-466f-b353-54fad71c0e14@arm.com>
Date: Mon, 8 Dec 2025 10:54:34 +0530
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
 deller@gmx.de, macro@orcam.me.uk, charlie@rivosinc.com,
 kevin.brodsky@arm.com, ldv@strace.io, mark.rutland@arm.com, song@kernel.org,
 ryan.roberts@arm.com, ada.coupriediaz@arm.com, broonie@kernel.org,
 pengcan@kylinos.cn, dvyukov@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-4-ruanjinjie@huawei.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251204082123.2792067-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/25 1:51 PM, Jinjie Ruan wrote:
> The generic entry abort the syscall_trace_enter() sequence if
> ptrace_report_syscall_entry() errors out, but arm64 not.
> 
> As the ptrace_report_syscall_entry() comment said, the calling arch code
> should abort the system call and must prevent normal entry so no system
> call is made if ptrace_report_syscall_entry() return nonzero.
> 
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

A small nit.

Could report_syscall_entry(regs) be checked directly in the 'if' conditional
code block thus dropping new 'ret' altogether ?

>  			return NO_SYSCALL;
>  	}
>  


