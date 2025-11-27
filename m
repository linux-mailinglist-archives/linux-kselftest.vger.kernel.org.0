Return-Path: <linux-kselftest+bounces-46642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F8C8E75E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 14:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9B2234C8DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA61272816;
	Thu, 27 Nov 2025 13:29:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C00271454;
	Thu, 27 Nov 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250151; cv=none; b=f+/tPNitw/0A8h7IuPJ0PbWhZ4SXHvW2MvFjuzJbNGH7EPjB3YMtEDbe/IRRn5Vj6GGyYb8WJfdXliz89He4+L/DfxByAzmRTF2ZJlE9Pgv6Weej3zfDbIgnfUfzM4h9r/S1zV0bcAmt8mOAOrnw6FhrxxIMhliSh8MelqCy3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250151; c=relaxed/simple;
	bh=E+6UX/zV0q6Iaw16IOD6GpveZ4+R3wi38DeR8Abh40s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q3wT4NrURJSjZUFXGKlyuoj0jGGHZcVYgTuT5NImRVQcutUzfIkJDckGb26kin8U6rS5g1dALt82bWm5r61yC/S0NJH5142uAr8VDQPHbMo/e338woiVXqbNGrDUETwRHyPBZAnQR2mmDut/0jOgO/4wC18dh7h3cAL8Azy0lHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 527A81713;
	Thu, 27 Nov 2025 05:29:02 -0800 (PST)
Received: from [10.57.43.59] (unknown [10.57.43.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAFA23F66E;
	Thu, 27 Nov 2025 05:29:03 -0800 (PST)
Message-ID: <e769993b-b508-4f59-bc66-f6cb955375e5@arm.com>
Date: Thu, 27 Nov 2025 14:29:00 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/12] arm64: syscall: Rework el0_svc_common()
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
 <20251126071446.3234218-6-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251126071446.3234218-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2025 08:14, Jinjie Ruan wrote:
> The generic syscall syscall_exit_work() has the following content:
>
> | audit_syscall_exit(regs)
> | trace_sys_exit(regs, ...)
> | ptrace_report_syscall_exit(regs, step)
>
> The generic syscall syscall_exit_to_user_mode_work() has
> the following form:
>
> | unsigned long work = READ_ONCE(current_thread_info()->syscall_work)
> | rseq_syscall()
> | if (unlikely(work & SYSCALL_WORK_EXIT))
> |	syscall_exit_work(regs, work)
>
> In preparation for moving arm64 over to the generic entry code,
> rework el0_svc_common() as below:
>
> - Rename syscall_trace_exit() to syscall_exit_work().
>
> - Add syscall_exit_to_user_mode_prepare() function to replace
>   the combination of read_thread_flags() and syscall_exit_work(),
>   also move the syscall exit check logic into it. Move has_syscall_work()
>   helper into asm/syscall.h for reuse.
>
> - As currently rseq_syscall() is always called and itself is controlled
>   by the CONFIG_DEBUG_RSEQ macro, so the CONFIG_DEBUG_RSEQ check
>   is removed.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

