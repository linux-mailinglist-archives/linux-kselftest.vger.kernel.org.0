Return-Path: <linux-kselftest+bounces-46367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B7C7F8C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 10:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41BE84E5356
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA52F6929;
	Mon, 24 Nov 2025 09:16:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBA62F7AD5;
	Mon, 24 Nov 2025 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975811; cv=none; b=D+YBm8jgzSz2m57zXKDUD6S5qhnXm4+yuo2wlcIxWPnnaUpDB+buFqMQq0q8xd4eW7XMU/c9xeyaSUu0WjxAs5Qv5SudqsBIRJS4Zb13Q0GFMqnclI372+bkJ3inHkD25V5LgKMrb1prodSUG4ZHKVTtXbzJPaZPFJKP/XDWzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975811; c=relaxed/simple;
	bh=+qXvFwgXudpqeHM7Uv9G9N0Kdbu6FoLvn0qsUO9wXv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V/Dmb9Ur6hreUCYov2tUo+mP4fKoAC2p3i49zR3I7otfihgupvkAG5LKxalz75Hbo9mrKdIGf0fA4z+JxhN6WXYf+zc4RnCHa1KboLu+vkzbKfHbxasZFq5IbVL8SixEIz5Iyw8F4HcDrqRj23HWlJhDMuuIeZCtxyYnaubX9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6FFA339;
	Mon, 24 Nov 2025 01:16:39 -0800 (PST)
Received: from [10.57.40.193] (unknown [10.57.40.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1B043F73B;
	Mon, 24 Nov 2025 01:16:41 -0800 (PST)
Message-ID: <f6350045-d1a1-4d1c-b2d3-68da841f7e34@arm.com>
Date: Mon, 24 Nov 2025 10:16:39 +0100
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
 <ba8450ad-e5ab-4b4f-868f-9b0da274f406@arm.com>
 <d1b5ed89-6667-a325-d209-3b43005a778b@huawei.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <d1b5ed89-6667-a325-d209-3b43005a778b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2025 05:15, Jinjie Ruan wrote:
>
> On 2025/11/19 1:12, Kevin Brodsky wrote:
>> On 17/11/2025 14:30, Jinjie Ruan wrote:
>>> The generic entry handle error of ptrace_report_syscall_entry(), but
>>> arm64 not.
>> This suggests that arm64 ignores the error completely, which isn't the
>> case: no syscall will be performed, but tracing will still occur as normal.
>>
>> What this patch seems to be doing is to abort the _enter sequence if
>> ptrace_report_syscall_entry() errors out. The commit title and message
>> should be reworded accordingly.
> You are right,the description is unclear .
>
>>> As the comment said, the calling arch code should abort the system
>> Which comment?
> ptrace_report_syscall_entry()

I found that later, this should be clarified in the commit message.

>>> call and must prevent normal entry so no system call is
>>> made if ptrace_report_syscall_entry() return nonzero.
>> This is already the case since we're calling forget_syscall().
> Yes. it is similar with the generic entry returns NO_SYSCALL.

My point is that this patch is not changing this - arm64 was already
skipping the syscall if ptrace_report_syscall_entry() returns an error.

>>> In preparation for moving arm64 over to the generic entry code,
>>> return early if ptrace_report_syscall_entry() encounters an error.
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>  arch/arm64/kernel/ptrace.c | 16 +++++++++++-----
>>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>>> index 95984bbf53db..707951ad5d24 100644
>>> --- a/arch/arm64/kernel/ptrace.c
>>> +++ b/arch/arm64/kernel/ptrace.c
>>> @@ -2317,10 +2317,10 @@ enum ptrace_syscall_dir {
>>>  	PTRACE_SYSCALL_EXIT,
>>>  };
>>>  
>>> -static void report_syscall_enter(struct pt_regs *regs)
>>> +static int report_syscall_enter(struct pt_regs *regs)
>>>  {
>>> -	int regno;
>>>  	unsigned long saved_reg;
>>> +	int regno, ret;
>>>  
>>>  	/*
>>>  	 * We have some ABI weirdness here in the way that we handle syscall
>>> @@ -2342,9 +2342,13 @@ static void report_syscall_enter(struct pt_regs *regs)
>>>  	saved_reg = regs->regs[regno];
>>>  	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
>>>  
>>> -	if (ptrace_report_syscall_entry(regs))
>>> +	ret = ptrace_report_syscall_entry(regs);
>>> +	if (ret)
>>>  		forget_syscall(regs);
>> The generic syscall_trace_enter() doesn't do this (i.e. setting
>> regs->syscallno to NO_SYSCALL). Is that an oversight or do we just not
>> need it? In principle this does have a visible effect (e.g. via
>> REGSET_SYSTEM_CALL).
> We just not need it because the original syscall_trace_enter() need use
> regs->syscallno as the return value, but now we return early by using
> NO_SYSCALL.

Calling forget_syscall() means setting regs->syscallno to NO_SYSCALL. It
is indeed no longer required for the entry sequence, but it does have
visible side effects. For instance, regs->syscallno can be inspected via
ptrace(PTRACE_GETREGSET, REGSET_SYSTEM_CALL). So the question is whether
we need to deviate from the generic path on arm64 (this is mostly a
question for arm64 maintainers).

- Kevin

