Return-Path: <linux-kselftest+bounces-45892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7221C6AED0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71D0C4F7C50
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A212FDC47;
	Tue, 18 Nov 2025 17:12:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5622283FE2;
	Tue, 18 Nov 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485934; cv=none; b=ZkbxGBWoN1CR20ZhXm9q80sLGq+OsBmmj8SIJLJ663Ad4YWx5MpBVAL+lwNcH2MxiWJL742Ujs6lRxpn0aOtA36XBCL4JwPboDPM3DSCn+fBA5flBAwnJZK2lW1Cp26WNdvIA3FRDStl2IUnoL/13RTii9FResgkfMNAM43pIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485934; c=relaxed/simple;
	bh=rVb/hqAEDh/VX1MxWqR988V+RJ3+PUPsOJQP3K5sjBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=czuM8ro7ThPo78SbLkS6gvuS/U3ml/xZK7YO0U+D8R4K3IIR3GXEUx45IfekgniZD+INh0qd/G/uybcqZg+jKhNGwukIzYBjtUCethqd4epP5RQA0j5FyhZx72ZUg5QP1R0yCM2BiriXzEPC73HNQt5M8ntn3fSACdxSAV2ydQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 921DB1596;
	Tue, 18 Nov 2025 09:12:04 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90A1D3F66E;
	Tue, 18 Nov 2025 09:12:07 -0800 (PST)
Message-ID: <ba8450ad-e5ab-4b4f-868f-9b0da274f406@arm.com>
Date: Tue, 18 Nov 2025 18:12:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/11] arm64/ptrace: Handle
 ptrace_report_syscall_entry() error
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
 <20251117133048.53182-6-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 14:30, Jinjie Ruan wrote:
> The generic entry handle error of ptrace_report_syscall_entry(), but
> arm64 not.

This suggests that arm64 ignores the error completely, which isn't the
case: no syscall will be performed, but tracing will still occur as normal.

What this patch seems to be doing is to abort the _enter sequence if
ptrace_report_syscall_entry() errors out. The commit title and message
should be reworded accordingly.

> As the comment said, the calling arch code should abort the system

Which comment?

> call and must prevent normal entry so no system call is
> made if ptrace_report_syscall_entry() return nonzero.

This is already the case since we're calling forget_syscall().

> In preparation for moving arm64 over to the generic entry code,
> return early if ptrace_report_syscall_entry() encounters an error.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/ptrace.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 95984bbf53db..707951ad5d24 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2317,10 +2317,10 @@ enum ptrace_syscall_dir {
>  	PTRACE_SYSCALL_EXIT,
>  };
>  
> -static void report_syscall_enter(struct pt_regs *regs)
> +static int report_syscall_enter(struct pt_regs *regs)
>  {
> -	int regno;
>  	unsigned long saved_reg;
> +	int regno, ret;
>  
>  	/*
>  	 * We have some ABI weirdness here in the way that we handle syscall
> @@ -2342,9 +2342,13 @@ static void report_syscall_enter(struct pt_regs *regs)
>  	saved_reg = regs->regs[regno];
>  	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
>  
> -	if (ptrace_report_syscall_entry(regs))
> +	ret = ptrace_report_syscall_entry(regs);
> +	if (ret)
>  		forget_syscall(regs);

The generic syscall_trace_enter() doesn't do this (i.e. setting
regs->syscallno to NO_SYSCALL). Is that an oversight or do we just not
need it? In principle this does have a visible effect (e.g. via
REGSET_SYSTEM_CALL).

- Kevin

> +
>  	regs->regs[regno] = saved_reg;
> +
> +	return ret;
>  }
>  
>  static void report_syscall_exit(struct pt_regs *regs)
> @@ -2374,9 +2378,11 @@ static void report_syscall_exit(struct pt_regs *regs)
>  
>  int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
>  {
> +	int ret;
> +
>  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> -		report_syscall_enter(regs);
> -		if (flags & _TIF_SYSCALL_EMU)
> +		ret = report_syscall_enter(regs);
> +		if (ret || (flags & _TIF_SYSCALL_EMU))
>  			return NO_SYSCALL;
>  	}
>  

