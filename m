Return-Path: <linux-kselftest+bounces-47994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A44CE7CAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 19:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAE193009FE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9797255E43;
	Mon, 29 Dec 2025 18:03:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9A17A31C;
	Mon, 29 Dec 2025 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767031428; cv=none; b=feyYlWHzu6khx/zNV3jNWzLMhsK9wUDB3NezUDIJg3L4xAcEHgULLI+rjH0I/hcRlXxp1x4/sDrRDzEro20SSR4w7LzJM4/akcaNbWyzJkENlzicnS8JZbNgU4iXbIFDArKabaNC0/ZpWrCKmG7UAYQvM4hPiWu0Xd6baUjv/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767031428; c=relaxed/simple;
	bh=g2hyGGgNqSybhF2MCdRktIBVlI3xXl1ThAGj8G3gxek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=shznMHiduPILrv/41E4RLYoUeMWyDljxiKcBd2zg4a0Sw4EiKrvfVWRcG5L/G83lPYTkGLtyIIpy7alAMrbEjiDr/+MaGBdLqY6sUq4WiSmSfkFbmXpioaEWcwVvBmTBbPdK4uliDDrnR3bFePiCsiFVBMe+APei8IS9jzfx++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2877339;
	Mon, 29 Dec 2025 10:03:37 -0800 (PST)
Received: from [10.57.45.222] (unknown [10.57.45.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3994E3F694;
	Mon, 29 Dec 2025 10:03:39 -0800 (PST)
Message-ID: <f3c32e7f-f940-4cb0-941c-cb7f7f628d88@arm.com>
Date: Mon, 29 Dec 2025 19:03:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/16] entry: Split syscall_exit_to_user_mode_work()
 for arch reuse
To: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, tglx@linutronix.de, peterz@infradead.org,
 luto@kernel.org, shuah@kernel.org, kees@kernel.org, wad@chromium.org,
 macro@orcam.me.uk, charlie@rivosinc.com, akpm@linux-foundation.org,
 ldv@strace.io, anshuman.khandual@arm.com, mark.rutland@arm.com,
 thuth@redhat.com, song@kernel.org, ryan.roberts@arm.com,
 ada.coupriediaz@arm.com, broonie@kernel.org, liqiang01@kylinos.cn,
 pengcan@kylinos.cn, kmal@cock.li, dvyukov@google.com,
 richard.weiyang@gmail.com, reddybalavignesh9979@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251222114737.1334364-1-ruanjinjie@huawei.com>
 <20251222114737.1334364-12-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251222114737.1334364-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/12/2025 12:47, Jinjie Ruan wrote:
> In the generic entry code, the beginning of
> syscall_exit_to_user_mode_work() can be reused on arm64 so it makes
> sense to split it.
>
> In preparation for moving arm64 over to the generic entry
> code, split out syscall_exit_to_user_mode_work_prepare() helper from
> syscall_exit_to_user_mode_work().
>
> No functional changes.
>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  include/linux/entry-common.h | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 87efb38b7081..0de0e60630e1 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -121,20 +121,11 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
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
> +static __always_inline void syscall_exit_to_user_mode_work_prepare(struct pt_regs *regs)
>  {
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  	unsigned long nr = syscall_get_nr(current, regs);
> @@ -155,6 +146,24 @@ static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
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
> +	syscall_exit_to_user_mode_work_prepare(regs);

The naming is getting awfully confusing, with the separate introduction
of syscall_exit_to_user_mode_prepare().

Having had a closer look, do we really need
syscall_exit_to_user_mode_work() as it currently stands? Nothing calls
it except the generic syscall_exit_to_user_mode(). Which makes me think:
how about moving the two lines below into syscall_exit_to_user_mode()
instead of creating a new helper? IOW:

@@ -155,8 +155,6 @@ static __always_inline void
syscall_exit_to_user_mode_work(struct pt_regs *regs)
      */
     if (unlikely(work & SYSCALL_WORK_EXIT))
         syscall_exit_work(regs, work);
-    local_irq_disable_exit_to_user();
-    syscall_exit_to_user_mode_prepare(regs);
 }
 
 /**
@@ -192,6 +190,8 @@ static __always_inline void
syscall_exit_to_user_mode(struct pt_regs *regs)
 {
     instrumentation_begin();
     syscall_exit_to_user_mode_work(regs);
+    local_irq_disable_exit_to_user();
+    syscall_exit_to_user_mode_prepare(regs);
     instrumentation_end();
     exit_to_user_mode();
 }

- Kevin

>  	local_irq_disable_exit_to_user();
>  	syscall_exit_to_user_mode_prepare(regs);
>  }

