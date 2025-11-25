Return-Path: <linux-kselftest+bounces-46435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E057FC851FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 14:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4458E4E98AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 13:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE123233FA;
	Tue, 25 Nov 2025 13:11:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59A321F5E;
	Tue, 25 Nov 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076262; cv=none; b=GLIHGF6tIKh4P7HB06hMZwBEy6d+Y8+n+X3pAjdBKriQZrCkju06zfyduKycD2JIAOPCJjD6/9+RCD21oih5Benbw0HZyDbOlKZRTrgaRum2uNOTgKB5Io6TDmmGJo1bUCuBCyziDwOEDdKUSm/yhnrhtAomroEDksEu5dhL33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076262; c=relaxed/simple;
	bh=gj9b3dyyPTNy+zHidkmr8z0TSdRDpJfKlpfMvKdIs0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A9zsKPysm5V8nOiTsB9N2qOG0ALgEhIG0IpoR0+NVzMxnsMU317rQjBi2Ls4qI/hTJ+UxJE50SxIaM13Og89TtKik5e++nCOk1zBy4xA55xmc+52rhGLJTyQrsrp50Kts/iExJ3re77OMsHAOuHjtHUaBHw+4UP/rM4yLVkXl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 327A51684;
	Tue, 25 Nov 2025 05:10:51 -0800 (PST)
Received: from [10.44.160.56] (e126510-lin.lund.arm.com [10.44.160.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82DA93F73B;
	Tue, 25 Nov 2025 05:10:52 -0800 (PST)
Message-ID: <1a8034b2-bb8f-4e73-b205-11453df6d02b@arm.com>
Date: Tue, 25 Nov 2025 14:10:49 +0100
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
 <247aa84f-0550-42d9-8d65-615297e78a74@arm.com>
 <48b7443a-2dd9-9764-fbe5-12dc9eef1363@huawei.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <48b7443a-2dd9-9764-fbe5-12dc9eef1363@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2025 03:43, Jinjie Ruan wrote:
>
> On 2025/11/24 23:23, Kevin Brodsky wrote:
>> On 24/11/2025 10:34, Jinjie Ruan wrote:
>>> On 2025/11/19 1:13, Kevin Brodsky wrote:
>>>> On 17/11/2025 14:30, Jinjie Ruan wrote:
>>>>> [...]
>>>>>
>>>>> diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
>>>>> index 66e6ba7fa80c..27310e611567 100644
>>>>> --- a/kernel/entry/syscall-common.c
>>>>> +++ b/kernel/entry/syscall-common.c
>>>>> @@ -17,6 +17,25 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>>>>>  	}
>>>>>  }
>>>>>  
>>>>> +/**
>>>>> + * arch_ptrace_report_syscall_entry - Architecture specific
>>>>> + *				      ptrace_report_syscall_entry().
>>>>> + *
>>>>> + * Invoked from syscall_trace_enter() to wrap ptrace_report_syscall_entry().
>>>>> + * Defaults to ptrace_report_syscall_entry.
>>>>> + *
>>>>> + * The main purpose is to support arch-specific ptrace_report_syscall_entry()
>>>>> + * implementation.
>>>>> + */
>>>>> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs);
>>>>> +
>>>>> +#ifndef arch_ptrace_report_syscall_entry
>>>>> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs)
>>>>> +{
>>>>> +	return ptrace_report_syscall_entry(regs);
>>>> I saw that Thomas suggested this approach on v4, and it makes sense to
>>>> me, but I find the naming surprising. If an architecture does need extra
>>>> handling, then the generic function should never be called from generic
>>>> code. So it seems to me that the more logical change would be:
>>>>
>>>> * Rename: ptrace_report_syscall_entry -> __ptrace_report_syscall_entry
>>>> * Introduce ptrace_report_syscall_entry(), defaults to
>>>> __ptrace_report_syscall_entry()
>>> If ptrace_report_syscall_entry() is defined in linux/ptrace.h, and an
>>> architecture also needs to redefine this function, but the
>>> architecture's own <asm/entry-common.h> must include <linux/ptrace.h>,
>>> the function will end up being defined twice and cause a "duplicate
>>> definition" compile error.
>> There's plenty of arch-defined functions in <linux/ptrace.h> already.
>> __ptrace_report_syscall_entry() should be defined inside an #ifndef and
>> architectures can define their own implementation in <asm/ptrace.h>,
>> like force_successful_syscall_return() for instance.
> Shared functions like ptrace_report_syscall() are all defined in
> <linux/ptrace.h>.
> When we want to override __ptrace_report_syscall_entry() in
> <asm/ptrace.h> we still have to include <linux/ptrace.h> again,then the
> redefine problem occurs again.
>
> What we actually need to reuse is ptrace_report_syscall_entry() (or
> __ptrace_report_syscall_entry()).

You're right, this is yet another of those circular definition problems...

> The arch version need to reuse and wrap ptrace_report_syscall_entry(),
> because for instance arm64 needs to perform additional operations before
> and after this step. Therefore, I believe the current implementation is
> appropriate.

I'm still not fond of arch_X() wrapping X() as this is unusual, but I
don't have a better idea so let's stick to that. It also makes sense to
have this done in syscall-common.c rather than a header considering the
risk of circular dependency.

- Kevin

