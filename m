Return-Path: <linux-kselftest+bounces-46638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D3C8E73D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C81D4E04B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2945265298;
	Thu, 27 Nov 2025 13:27:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882D51D63EF;
	Thu, 27 Nov 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250067; cv=none; b=TgBA+Yf4urBkPlMBeE8k24flAosWl5LmrzfduQD6kCTD0oP1Z5iouMu5v/Fce1IhKK9Vdch2ndFTWqeJBu+RlwrtTtBa7wv15qCWLO7/xtShKObkS4xVzk6UjsEj84HFz0hsXuee3zP2Y6Kmk/euZTHOmIy6cDipYS/MP63fHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250067; c=relaxed/simple;
	bh=zUsdSm7wHChNsLJF0hjxZ7KSO8/aIJH8ctAtRniNal8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fzVC3zAXPRs5IUiGTDU7/1mCiVjYsYO7pRQWkW2zWpUCfjWSV1FiCunR1/jp9N4JsOQPxWA1c5eKCSRhHT1l1LMnyipqpQdp9YnEdJ3egnKFUgP1RNDjAdcFpcOGhVKbDs77s3Hr1EQZb3PPagW3x62K+FRX+s/KuQDi2Yn2xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6412E1477;
	Thu, 27 Nov 2025 05:27:37 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEED13F66E;
	Thu, 27 Nov 2025 05:27:38 -0800 (PST)
Message-ID: <b907563a-43e7-4a17-abdd-cdabc3113992@arm.com>
Date: Thu, 27 Nov 2025 14:27:36 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] arm64: Remove unused _TIF_WORK_MASK
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
 <20251126071446.3234218-2-ruanjinjie@huawei.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20251126071446.3234218-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 08:14, Jinjie Ruan wrote:
> Since commit b3cf07851b6c ("arm64: entry: Switch to generic IRQ
> entry"), _TIF_WORK_MASK is never used, so remove it.
>
> Fixes: b3cf07851b6c ("arm64: entry: Switch to generic IRQ entry")

I'm not sure a Fixes: tag is warranted - this has no functional effect
and doesn't need to be backported.

Otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/include/asm/thread_info.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index f241b8601ebd..ff4998fa1844 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -106,12 +106,6 @@ void arch_setup_new_exec(void);
>  #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
>  
> -#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
> -				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> -				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
> -				 _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING | \
> -				 _TIF_PATCH_PENDING)
> -
>  #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>  				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
>  				 _TIF_SYSCALL_EMU)

