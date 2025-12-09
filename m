Return-Path: <linux-kselftest+bounces-47302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A3CCB019A
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 14:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A117C30A7A5D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE53B223702;
	Tue,  9 Dec 2025 13:47:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B822256B;
	Tue,  9 Dec 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288065; cv=none; b=ckWBHeNQgh3Nkd6RmDjXO9nuL2mFD7xSSP8HyLPgLEXP+u3OllYMr9O7sGqD56kynaKGki7TjE605L8ybHYi/2/WcM/M3PJWA+wQ6bRPWiKB385dKE1vckwCxei2XvrrJZa9NVD99NnRB1xsxrdus2bsskOtpcIwKyN0SNF9JMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288065; c=relaxed/simple;
	bh=jtdvN7RDdnCBoLfZQzAedGkR7NZsuSNQGjL9ybT3Ntc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qVSZrgi0p6q8pc/bD/MxYAA9+45FJS066mFJknuwniIgxyP7QUDSy9Z1fBtAS2mTXcxGd0ZgZQexySLx+oUOnfsBHBr2zkpDw9oU4/Aq25zXCXnXihXdnkcxzE85nbYfPeaN/gwh+iqvvICB13QPKIXJ48xaJ6GWYQqg1c7ghCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29CFE169C;
	Tue,  9 Dec 2025 05:47:36 -0800 (PST)
Received: from [10.57.45.100] (unknown [10.57.45.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8289D3F762;
	Tue,  9 Dec 2025 05:47:38 -0800 (PST)
Message-ID: <ec404a91-2e24-4198-975b-e26c6a8330f8@arm.com>
Date: Tue, 9 Dec 2025 14:47:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/16] arm64: entry: Convert to generic entry
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
 <20251204082123.2792067-14-ruanjinjie@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20251204082123.2792067-14-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2025 09:21, Jinjie Ruan wrote:
> Currently, x86, Riscv, Loongarch use the generic entry which makes
> maintainers' work easier and codes more elegant. arm64 has already
> switched to the generic IRQ entry, so completely convert arm64 to use
> the generic entry infrastructure from kernel/entry/*.
>
> The changes are below:
>  - Remove TIF_SYSCALL_* flag.
>
>  - Remove _TIF_SYSCALL_WORK and has_syscall_work(), as _TIF_SYSCALL_WORK
>    is equal with SYSCALL_WORK_ENTER.

Should be updated considering patch 7 (has_syscall_work() no longer
exists and there is also _TIF_SYSCALL_EXIT_WORK).

>  - Implement arch_ptrace_report_syscall_entry/exit() with
>    report_syscall_entry/exit() to do arm64-specific save/restore
>    during syscall entry/exit.
>
>  - Add "ARCH_SYSCALL_WORK_EXIT" to be defined as "_TIF_SECCOMP |
>    _TIF_SYSCALL_EMU" to keep the arm64 behaviour unchanged.

No longer the case.

>  - Remove arm64 syscall_trace_enter(), syscall_exit_to_user_mode_prepare(),
>    and related sub-functions including syscall_exit_work() and
>    syscall_enter_audit(), by calling generic entry's functions with similar
>    functionality.

Would be good to talk about SYSCALL_EXIT_TRAP as well.

Otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> - Implement arch_syscall_is_vdso_sigreturn() to support "Syscall User
>   Dispatch".
>
> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> [...]

