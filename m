Return-Path: <linux-kselftest+bounces-46368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313B5C7FA92
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 10:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D863A4B90
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112F72F5A0C;
	Mon, 24 Nov 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dvYlQKJJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24441261388;
	Mon, 24 Nov 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976901; cv=none; b=TBol/Ejx4wWYH9c4Pin/V2NX9O4rkpMe1ZRH5hyp+eJJddHcmOCvIxYomGGZVSlSREHv6JvSxfhvF3NcEekNVlkS8YGfUaoSl1C6Wh0NrTTrwCLZiakP6vp8b8tR9pNKgFRf/NNRky4IELgVz21j5we65n9iuw+NhKb4osoVj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976901; c=relaxed/simple;
	bh=jMLKKIpVKqzMR/J80tuNYD9oXV4OjHeP0TKeRMOUCTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M3zwH2swoTkPqledP4YCd3I1SgFPKRQtjsboI3xwdqQfVBalnJNGlvyVGEdOhBQwqN2b+wRi6fbPj00PmW4GeU0funRC0iHUPdReNdBarccQj6yzwvf+bwOjprJVhvJlKZIa5AJkkuvNptd+lqIZKWUVHH4zYhOITMXqZNG6PJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dvYlQKJJ; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mNH/S57FQxOebr8RKctZnxvthh0Wbt2ic9yErCeoPGM=;
	b=dvYlQKJJLcvfTFqHE+TzBjWifSnMUGF2oYD8wgA/F8ThuSMR/RYA9+7PWjGVBv7roEkRY5n9L
	FtAHGsZQ9HPyZL4vgpKsaMp/NySCFJHkIy+p1ipDellD2qE4Lda2SiTOL6H6NUwd9ZNAn8Xq/Fe
	+1/OLKuGiwtXXFRVmiffpzg=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dFLGQ5xTfz1cyqQ;
	Mon, 24 Nov 2025 17:33:02 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E885B140155;
	Mon, 24 Nov 2025 17:34:49 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Nov 2025 17:34:48 +0800
Message-ID: <8489ee0d-8b9c-080a-04a0-b299549e86cf@huawei.com>
Date: Mon, 24 Nov 2025 17:34:47 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v7 08/11] entry: Add
 arch_ptrace_report_syscall_entry/exit()
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <oleg@redhat.com>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <macro@orcam.me.uk>, <deller@gmx.de>,
	<mark.rutland@arm.com>, <song@kernel.org>, <mbenes@suse.cz>,
	<ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <pengcan@kylinos.cn>,
	<dvyukov@google.com>, <kmal@cock.li>, <lihongbo22@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251117133048.53182-1-ruanjinjie@huawei.com>
 <20251117133048.53182-9-ruanjinjie@huawei.com>
 <55e1345f-94d7-41a9-8f0a-694fd56f63ed@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <55e1345f-94d7-41a9-8f0a-694fd56f63ed@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/11/19 1:13, Kevin Brodsky wrote:
> On 17/11/2025 14:30, Jinjie Ruan wrote:
>> Differ from generic entry, due to historical reasons, ARM64 need to
>> save/restore during syscall entry/exit because ARM64 use a scratch
>> register (ip(r12) on AArch32, x7 on AArch64) to denote syscall entry/exit.
>>
>> In preparation for moving arm64 over to the generic entry code,
>> add arch_ptrace_report_syscall_entry/exit() as the default
>> ptrace_report_syscall_entry/exit() implementation. This allows
>> arm64 to implement the architecture specific version.
>>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
> 
> I don't think I suggested this patch. I see that I suggested renaming
> some functions on v3, but I don't think that justifies a Suggested-by tag.
> 
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  kernel/entry/syscall-common.c | 43 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
>> index 66e6ba7fa80c..27310e611567 100644
>> --- a/kernel/entry/syscall-common.c
>> +++ b/kernel/entry/syscall-common.c
>> @@ -17,6 +17,25 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>>  	}
>>  }
>>  
>> +/**
>> + * arch_ptrace_report_syscall_entry - Architecture specific
>> + *				      ptrace_report_syscall_entry().
>> + *
>> + * Invoked from syscall_trace_enter() to wrap ptrace_report_syscall_entry().
>> + * Defaults to ptrace_report_syscall_entry.
>> + *
>> + * The main purpose is to support arch-specific ptrace_report_syscall_entry()
>> + * implementation.
>> + */
>> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs);
>> +
>> +#ifndef arch_ptrace_report_syscall_entry
>> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs)
>> +{
>> +	return ptrace_report_syscall_entry(regs);
> 
> I saw that Thomas suggested this approach on v4, and it makes sense to
> me, but I find the naming surprising. If an architecture does need extra
> handling, then the generic function should never be called from generic
> code. So it seems to me that the more logical change would be:
> 
> * Rename: ptrace_report_syscall_entry -> __ptrace_report_syscall_entry
> * Introduce ptrace_report_syscall_entry(), defaults to
> __ptrace_report_syscall_entry()

If ptrace_report_syscall_entry() is defined in linux/ptrace.h, and an
architecture also needs to redefine this function, but the
architecture's own <asm/entry-common.h> must include <linux/ptrace.h>,
the function will end up being defined twice and cause a "duplicate
definition" compile error.

> 
> All this would be done in <linux/ptrace.h>, where it clearly belongs.
> The __ prefix makes it clear that the generic function is not the main
> interface. Even better, no need to change any caller with that approach.
> 
> - Kevin
> 
>> +}
>> +#endif
>> +
>>  long syscall_trace_enter(struct pt_regs *regs, long syscall,
>>  				unsigned long work)
>>  {
>> @@ -34,7 +53,7 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
>>  
>>  	/* Handle ptrace */
>>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
>> -		ret = ptrace_report_syscall_entry(regs);
>> +		ret = arch_ptrace_report_syscall_entry(regs);
>>  		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
>>  			return -1L;
>>  	}
>> @@ -84,6 +103,26 @@ static inline bool report_single_step(unsigned long work)
>>  	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
>>  }
>>  
>> +/**
>> + * arch_ptrace_report_syscall_exit - Architecture specific
>> + *				     ptrace_report_syscall_exit.
>> + *
>> + * Invoked from syscall_exit_work() to wrap ptrace_report_syscall_exit().
>> + *
>> + * The main purpose is to support arch-specific ptrace_report_syscall_exit
>> + * implementation.
>> + */
>> +static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
>> +							    int step);
>> +
>> +#ifndef arch_ptrace_report_syscall_exit
>> +static __always_inline void arch_ptrace_report_syscall_exit(struct pt_regs *regs,
>> +							    int step)
>> +{
>> +	ptrace_report_syscall_exit(regs, step);
>> +}
>> +#endif
>> +
>>  void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>>  {
>>  	bool step;
>> @@ -108,5 +147,5 @@ void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>>  
>>  	step = report_single_step(work);
>>  	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
>> -		ptrace_report_syscall_exit(regs, step);
>> +		arch_ptrace_report_syscall_exit(regs, step);
>>  }
> 

