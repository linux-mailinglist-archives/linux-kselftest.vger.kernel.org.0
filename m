Return-Path: <linux-kselftest+bounces-46788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A22C969B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 11:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B069F4E04F7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F55B301716;
	Mon,  1 Dec 2025 10:18:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2593002D0;
	Mon,  1 Dec 2025 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584283; cv=none; b=BXXuJwsTYZ9Cl3/stNmyTOQws4txSMh1/rRdnSAQ0kTdzILGtFbD8Lakp8LhhLkkZNa+ExcdEX2o/4RGk2m83ryZFV2QcOFhu/tTRRpSgsfsLQjp2Gg7GGf28HOGw9CuPcOeLYOfSthuL9PJ3ZSFq86fuGvKIB4JjQl8Zg1cXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584283; c=relaxed/simple;
	bh=0ohCcHE9Ps+Wxv0p+B+GebAPjC2U8EY2WYXm4N9ptDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R/+0TooA+UwfUP/a4XpfhP9/yD/wGgl/NAvwTAYQX9+JTmXmTW6kSoX5Ui0aWDPszqC0znwrermQl7wVl27QdQLN+VXhD2tZjRNvVotee4/CKfTgHtuhtdq6118vLD/8m4xkIncN85egNQ6VStIRSZa7QCyT1lP3wGQ+9gzVSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49C01FEC;
	Mon,  1 Dec 2025 02:17:52 -0800 (PST)
Received: from [10.57.43.170] (unknown [10.57.43.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D606E3F73B;
	Mon,  1 Dec 2025 02:17:54 -0800 (PST)
Message-ID: <65c7307b-1f4e-4ae7-8bcf-8bfd9a9186fb@arm.com>
Date: Mon, 1 Dec 2025 11:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/12] arm64: entry: Convert to generic entry
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
 <20251126071446.3234218-12-ruanjinjie@huawei.com>
 <c6cf8755-34d0-468d-99c4-ac6d266f9efb@arm.com>
 <bfdd914c-4c3a-9af7-d530-f57f3532c3d5@huawei.com>
 <8c55c2a1-995e-44a1-8d48-b7d794f5176f@arm.com>
 <0e65df65-c454-df7f-0685-42e9c0f0f9e3@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <0e65df65-c454-df7f-0685-42e9c0f0f9e3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/11/2025 02:23, Jinjie Ruan wrote:
>>>>>  #define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
>>>>>  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
>>>>>  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>>>>> -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
>>>>> -#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
>>>>> -#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
>>>>> -#define TIF_SECCOMP		11	/* syscall secure computing */
>>>>> -#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
>>>>> +#define TIF_SECCOMP		11      /* syscall secure computing */
>>>>> +#define TIF_SYSCALL_EMU		12      /* syscall emulation active */
>>>> These seem to have reappeared in v8 for some reason?
>>> v8 add "ARCH_SYSCALL_WORK_EXIT" to be defined as "SECCOMP | SYSCALL_EMU"
>>>   to keep the arm64 behaviour unchanged as mentioned in v7.
>> Ah then that is where the issue is, I missed that: surely switching to
>> generic entry means that we are using SYSCALL_WORK_BIT_* rather than
>> TIF_* for all these flags?
> I think they may be the same thing as you mentioned in v7，neither
> SYSCALL_WORK_EXIT nor report_single_step() excluded SYSCALL_EMU, maybe
> we should clarify them for arm64 together in a separate patch.

These two might indeed be related. On second thoughts, while waiting for
more knowledgeable arm64 reviewers, I would suggest aligning arm64 with
the generic entry. Which means...

> 1、"The generic report_single_step() always returns false if SYSCALL_EMU
> is set."

... replicating this behaviour on arm64 (in a separate patch), and...

> 2、"
>      > -void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
>      > -{
>      > -	unsigned long flags = read_thread_flags();
>      > -
>      > -	rseq_syscall(regs);
>      > -
>      > -	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
>
>      I believe switching to the generic function introduces a change
>      here: syscall_exit_work() is only called if a flag in
> SYSCALL_WORK_EXIT is set, and this set does not include SYSCALL_EMU and
>     SECCOMP. Practically this means that audit_syscall_exit() will no
>     longer be called if only SECCOMP and/or SYSCALL_EMU is set.
>
>    It doesn't feel like a major behaviour change, but it should be
>    pointed out."

... replicating this on arm64 as well, i.e. introducing a separate set
of flags for syscall exit. This should be a patch of its own, as it
isn't directly related to the report_single_step() behaviour (especially
since it concerns SECCOMP as well). It would also be an occasion to get
rid of has_syscall_work(), in preparation to the move to generic entry.

- Kevin

