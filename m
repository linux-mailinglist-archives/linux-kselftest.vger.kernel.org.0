Return-Path: <linux-kselftest+bounces-46391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBF6C81571
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 16:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C530334290D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029F2313E29;
	Mon, 24 Nov 2025 15:23:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E431354B;
	Mon, 24 Nov 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997792; cv=none; b=F79O86yVvU3hCxm/tvZESaysn3cPSpeApnrS+ipwl7tlI7EK52GZgyAxKMcrCvb6vtmW6427MIKKFEn2y/wSKzF/4qiLKnRbNM0IEyux/VDS73XF0tkHFJ3fUOPVh58KVRZdYps6XtWyjJWptPJbCdVQubURqy4v5dEBvypbAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997792; c=relaxed/simple;
	bh=dwWoae4wa4SIvMvPE5ESyCV6t+69Zbvk5VgClXWEPC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l8uokYZokagu+h4aQmHJQ3la72kHa4SgxQN1d0DlRcd7dwu/MWxGkOb6rM9PRpYlCeERqNzVO8/LvI/e6yMn+XifKyq+T4+XTyMBq/AwuH2yaM/rAMBiAfTKlUEyaMp5tRIqFHEWiT1qVIWy++PcrAI+T6AkvtWSoyiaLoho01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F081497;
	Mon, 24 Nov 2025 07:23:01 -0800 (PST)
Received: from [10.57.40.218] (unknown [10.57.40.218])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02BE23F73B;
	Mon, 24 Nov 2025 07:23:03 -0800 (PST)
Message-ID: <247aa84f-0550-42d9-8d65-615297e78a74@arm.com>
Date: Mon, 24 Nov 2025 16:23:01 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/11] entry: Add
 arch_ptrace_report_syscall_entry/exit()
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
 <20251117133048.53182-9-ruanjinjie@huawei.com>
 <55e1345f-94d7-41a9-8f0a-694fd56f63ed@arm.com>
 <8489ee0d-8b9c-080a-04a0-b299549e86cf@huawei.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <8489ee0d-8b9c-080a-04a0-b299549e86cf@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2025 10:34, Jinjie Ruan wrote:
>
> On 2025/11/19 1:13, Kevin Brodsky wrote:
>> On 17/11/2025 14:30, Jinjie Ruan wrote:
>>> [...]
>>>
>>> diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
>>> index 66e6ba7fa80c..27310e611567 100644
>>> --- a/kernel/entry/syscall-common.c
>>> +++ b/kernel/entry/syscall-common.c
>>> @@ -17,6 +17,25 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>>>  	}
>>>  }
>>>  
>>> +/**
>>> + * arch_ptrace_report_syscall_entry - Architecture specific
>>> + *				      ptrace_report_syscall_entry().
>>> + *
>>> + * Invoked from syscall_trace_enter() to wrap ptrace_report_syscall_entry().
>>> + * Defaults to ptrace_report_syscall_entry.
>>> + *
>>> + * The main purpose is to support arch-specific ptrace_report_syscall_entry()
>>> + * implementation.
>>> + */
>>> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs);
>>> +
>>> +#ifndef arch_ptrace_report_syscall_entry
>>> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs)
>>> +{
>>> +	return ptrace_report_syscall_entry(regs);
>> I saw that Thomas suggested this approach on v4, and it makes sense to
>> me, but I find the naming surprising. If an architecture does need extra
>> handling, then the generic function should never be called from generic
>> code. So it seems to me that the more logical change would be:
>>
>> * Rename: ptrace_report_syscall_entry -> __ptrace_report_syscall_entry
>> * Introduce ptrace_report_syscall_entry(), defaults to
>> __ptrace_report_syscall_entry()
> If ptrace_report_syscall_entry() is defined in linux/ptrace.h, and an
> architecture also needs to redefine this function, but the
> architecture's own <asm/entry-common.h> must include <linux/ptrace.h>,
> the function will end up being defined twice and cause a "duplicate
> definition" compile error.

There's plenty of arch-defined functions in <linux/ptrace.h> already.
__ptrace_report_syscall_entry() should be defined inside an #ifndef and
architectures can define their own implementation in <asm/ptrace.h>,
like force_successful_syscall_return() for instance.

- Kevin

>> All this would be done in <linux/ptrace.h>, where it clearly belongs.
>> The __ prefix makes it clear that the generic function is not the main
>> interface. Even better, no need to change any caller with that approach.
>>
>> - Kevin
>>
>>> [...]

