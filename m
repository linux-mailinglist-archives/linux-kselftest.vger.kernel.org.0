Return-Path: <linux-kselftest+bounces-46643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6900C8E773
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 070544E7A4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F493270569;
	Thu, 27 Nov 2025 13:29:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37BA26B2B0;
	Thu, 27 Nov 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250181; cv=none; b=I2Qw1rv7ICULrOOv7rtnHBJhVhd8V20VfJhyjybjefXK8bjRkyWjru1l8Q5xq8J3QaaqEm40K6IP8jrJCbS2JCn5HLGOlpNxMWtgxyr/qx0vSWUd66eA4MQl0KKFNK+k+2x9epiiLcG4c0F10gELsN20yYasZS4HyiWq/MJgi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250181; c=relaxed/simple;
	bh=BWoZPoJoYLEnfy4pK8K4birtwtRKBnBRP6qqYJPiJUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I737qs7f8nfcIgbjOU3yUbUQ8hU16Rb9XjQmrtImQlanovwYddbuTR4K6D4PEPHDWHsp27AHhuzfnTAArKQNFh6IWS2APCripxzIDbGcgPuso6P641a0trxsyWV8NPISLp0aowzqkt7g/dr79pzxzf3vjlioGnCMwVDCYsQxm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FB671756;
	Thu, 27 Nov 2025 05:29:31 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A00E23F66E;
	Thu, 27 Nov 2025 05:29:31 -0800 (PST)
Message-ID: <2cc2b342-d350-415d-bc5a-05aa3da17d50@arm.com>
Date: Thu, 27 Nov 2025 14:29:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/12] arm64/ptrace: Return early for
 ptrace_report_syscall_entry() error
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
 <20251126071446.3234218-7-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251126071446.3234218-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 08:14, Jinjie Ruan wrote:
> The generic entry abort the syscall_trace_enter() sequence if
> ptrace_report_syscall_entry() errors out, but arm64 not.
>
> As the ptrace_report_syscall_entry() comment said, the calling arch code
> should abort the system call and must prevent normal entry so no system
> call is made if ptrace_report_syscall_entry() return nonzero.

Which is already the case on arm64 before patch 2, which changes
syscall_trace_enter() so that it no longer returns regs->syscallno,
meaning that forget_syscall() no longer skips the syscall.

The most sensible thing to do is probably to move this patch before
patch 2. This ensures patch 2 doesn't introduce a regression, and then
the only effect of this patch is to abort the trace sequence early.

- Kevin

> In preparation for moving arm64 over to the generic entry code,
> return early if ptrace_report_syscall_entry() encounters an error.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/ptrace.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 233a7688ac94..da9687d30bcf 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2346,15 +2346,18 @@ static inline unsigned long ptrace_save_reg(struct pt_regs *regs,
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
> @@ -2380,9 +2383,11 @@ static void report_syscall_exit(struct pt_regs *regs)
>  
>  int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
>  {
> +	int ret;
> +
>  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> -		report_syscall_entry(regs);
> -		if (flags & _TIF_SYSCALL_EMU)
> +		ret = report_syscall_entry(regs);
> +		if (ret || (flags & _TIF_SYSCALL_EMU))
>  			return NO_SYSCALL;
>  	}
>  

