Return-Path: <linux-kselftest+bounces-45882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9155C6AE9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4766635E34C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E7D3A9BEB;
	Tue, 18 Nov 2025 17:11:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2033A5E98;
	Tue, 18 Nov 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485884; cv=none; b=EwqyIx8o1UTAkBHR8M1qwNcjBRFUImprbwVO1TjSXSaVm/+SUjkQVJg2TITjYCCAlQ6vUJc1or7dHD2U8elDI4g0FMkauYqWQeE7w/umPvRrKVaoiouBCrtMugmOWeSQUiZOyl6sZtwBPSa8weY2PHwwuX2G+YhBcdTTiHKJ/Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485884; c=relaxed/simple;
	bh=rSEsVlgh/sUbgdoQ41V0HN5zUD+TXowim/igLtLGf/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rNUAQF6mdAVVal0s1Z8mvg0vG9uLMNAp1io5cQl6jKS2Uz4RRI09+GfKro/ke7EEp6jEAI8MoTbwc3s9PjDt8fAbqc34LFD7aHXX0kpV/n7SrZKiAaMGXBKcbNJdkfdNxWf4nh6Cz2wzIJC5RfadlxLJxlZF3iH9qjpvFGabx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED541595;
	Tue, 18 Nov 2025 09:11:14 -0800 (PST)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8977C3F66E;
	Tue, 18 Nov 2025 09:11:16 -0800 (PST)
Message-ID: <af048915-40d3-4007-880a-090c1f079e59@arm.com>
Date: Tue, 18 Nov 2025 18:11:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/11] entry: Add syscall_exit_to_user_mode_prepare()
 helper
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
 <20251117133048.53182-5-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251117133048.53182-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2025 14:30, Jinjie Ruan wrote:
> In the generic entry code, the part before
> syscall_exit_to_user_mode_work() calls syscall_exit_work(), which
> serves the same purpose as syscall_exit_to_user_mode_prepare()
> in arm64.

This is really hard to parse, I suppose the point is that the beginning
of syscall_exit_to_user_mode_work() can be reused on arm64 and therefore
it makes sense to split it?

> In preparation for moving arm64 over to the generic entry
> code, extract syscall_exit_to_user_mode_prepare() helper from
> syscall_exit_to_user_mode_work().
>
> No functional changes.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

The position of this patch in the series seems a little arbitrary (it
has no dependency on other patches), it might make more sense to group
it with the other generic patches (i.e. move it to patch 7).

Otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

- Kevin

> ---
>  include/linux/entry-common.h | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 7177436f0f9e..cd6dacb2d8bf 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -137,20 +137,11 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
>   */
>  void syscall_exit_work(struct pt_regs *regs, unsigned long work);
>  
> -/**
> - * syscall_exit_to_user_mode_work - Handle work before returning to user mode
> - * @regs:	Pointer to currents pt_regs
> - *
> - * Same as step 1 and 2 of syscall_exit_to_user_mode() but without calling
> - * exit_to_user_mode() to perform the final transition to user mode.
> - *
> - * Calling convention is the same as for syscall_exit_to_user_mode() and it
> - * returns with all work handled and interrupts disabled. The caller must
> - * invoke exit_to_user_mode() before actually switching to user mode to
> - * make the final state transitions. Interrupts must stay disabled between
> - * return from this function and the invocation of exit_to_user_mode().
> +/*
> + * Syscall specific exit to user mode preparation. Runs with interrupts
> + * enabled.
>   */
> -static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
> +static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
>  {
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  	unsigned long nr = syscall_get_nr(current, regs);
> @@ -171,6 +162,24 @@ static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
>  	 */
>  	if (unlikely(work & SYSCALL_WORK_EXIT))
>  		syscall_exit_work(regs, work);
> +}
> +
> +/**
> + * syscall_exit_to_user_mode_work - Handle work before returning to user mode
> + * @regs:	Pointer to currents pt_regs
> + *
> + * Same as step 1 and 2 of syscall_exit_to_user_mode() but without calling
> + * exit_to_user_mode() to perform the final transition to user mode.
> + *
> + * Calling convention is the same as for syscall_exit_to_user_mode() and it
> + * returns with all work handled and interrupts disabled. The caller must
> + * invoke exit_to_user_mode() before actually switching to user mode to
> + * make the final state transitions. Interrupts must stay disabled between
> + * return from this function and the invocation of exit_to_user_mode().
> + */
> +static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
> +{
> +	syscall_exit_to_user_mode_prepare(regs);
>  	local_irq_disable_exit_to_user();
>  	exit_to_user_mode_prepare(regs);
>  }

