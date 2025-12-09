Return-Path: <linux-kselftest+bounces-47304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD607CB01A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 14:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A3B730CFA99
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3445D248896;
	Tue,  9 Dec 2025 13:49:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AAE2248A0;
	Tue,  9 Dec 2025 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288141; cv=none; b=BH6BJ9MqMIEZXR/UIosLl99IOF7hxHAa4g00BvMyg67EJlNjYQC5EHnzNV/3MzMK3RMpMwuT+ngrqgsdzExXVccjON+B6/ILPHYEavQeCNAjkuzUIyhR5hR3NECZWmzukdYOify4y7QAXxKN6qPscUg3JPSqXYOyLNImhKZxVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288141; c=relaxed/simple;
	bh=FVuQRujYf++BNgQ6+PI/6/zZw0Q2ZkUFz3N/E8zTCx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hI411ngCLBvzPzqKKY7urU/senu5V2p7UqYQ46jUIjb853R6kaz3dj2Y0TYFqEazFP4AfGyDzIoccfqECzgv/Nir3mPRHvr96PuAlWaI2MLV16P38WLszsJKz8nLpj3PWiEScrXPodm3Cm8WnTOIN4a6mbPLSzxp/z1XT/pLTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A52175A;
	Tue,  9 Dec 2025 05:48:51 -0800 (PST)
Received: from [10.57.45.100] (unknown [10.57.45.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B3343F762;
	Tue,  9 Dec 2025 05:48:54 -0800 (PST)
Message-ID: <b382cc8a-3ce9-4fb1-bc0a-a3d9796251d1@arm.com>
Date: Tue, 9 Dec 2025 14:48:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/16] entry: Inline syscall_exit_work()
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
 <20251204082123.2792067-16-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251204082123.2792067-16-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/12/2025 09:21, Jinjie Ruan wrote:
> After switch arm64 to Generic Entry, a new hotspot syscall_exit_work()
> appeared because syscall_exit_work() is no longer inlined. so inline

Before this series the call to syscall_trace_exit() in el0_svc_common()
could not be inlined, so "no longer inlined" doesn't seem to be accurate.

> syscall_exit_work(), and it has 2.6% performance uplift on perf bench
> basic syscall on kunpeng920 as below.

That seems strange. syscall_exit_work() is only called if some flag in
SYSCALL_WORK_EXIT is set, which means that we're doing something special
like tracing. That shouldn't be the case when running a simple perf
bench syscall.

Also worth nothing that its counterpart (syscall_trace_enter())) is not
currently inlined, the asymmetry would have to be justified.

>     | Metric     | W/O this patch | With this patch | Change    |
>     | ---------- | -------------- | --------------- | --------- |
>     | Total time | 2.171 [sec]    | 2.114 [sec]     |  ↓2.6%    |
>     | usecs/op   | 0.217192       | 0.211453        |  ↓2.6%    |
>     | ops/sec    | 4,604,225      | 4,729,178       |  ↑2.7%    |
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  include/linux/entry-common.h  | 63 ++++++++++++++++++++++++++++++++++-
>  kernel/entry/syscall-common.c | 59 ++------------------------------

These changes are purely generic, surely all architectures using
GENERIC_ENTRY should get similar benefits (assuming LTO isn't used)?

>  2 files changed, 64 insertions(+), 58 deletions(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index cd6dacb2d8bf..2f84377fb016 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -2,6 +2,7 @@
>  #ifndef __LINUX_ENTRYCOMMON_H
>  #define __LINUX_ENTRYCOMMON_H
>  
> +#include <linux/audit.h>
>  #include <linux/irq-entry-common.h>
>  #include <linux/ptrace.h>
>  #include <linux/seccomp.h>
> @@ -128,6 +129,41 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
>  	return ret;
>  }
>  
> +/*
> + * If SYSCALL_EMU is set, then the only reason to report is when
> + * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
> + * instruction has been already reported in syscall_enter_from_user_mode().
> + */
> +static __always_inline bool report_single_step(unsigned long work)
> +{
> +	if (work & SYSCALL_WORK_SYSCALL_EMU)
> +		return false;
> +
> +	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
> +}
> +
> +/**
> + * arch_ptrace_report_syscall_exit - Architecture specific
> + *				     ptrace_report_syscall_exit.
> + *
> + * Invoked from syscall_exit_work() to wrap ptrace_report_syscall_exit().
> + *
> + * The main purpose is to support arch-specific ptrace_report_syscall_exit
> + * implementation.
> + */
> +static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
> +							    int step);
> +
> +#ifndef arch_ptrace_report_syscall_exit
> +static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
> +							    int step)
> +{
> +	ptrace_report_syscall_exit(regs, step);
> +}
> +#endif

If we want syscall_exit_work() to be inline, then why would we define
this hook in syscall-common.c in patch 12? Might as well define both
hooks in entry-common.h right away and avoid some noise here.

- Kevin

> [...]

