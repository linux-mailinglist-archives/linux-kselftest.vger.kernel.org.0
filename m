Return-Path: <linux-kselftest+bounces-47475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D7CB7CBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F8683015AA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D3D21C9EA;
	Fri, 12 Dec 2025 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OBFwxoTJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB22AD3D;
	Fri, 12 Dec 2025 03:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765511400; cv=none; b=WXlpw6FS92OQPHcuhmc2IaGU0/d2DJgeAoOH7VkAcj0SlKn8y9UMDeiAraPC8cLC64rLxQYlYg4cwf5XMS5yoO6V/fM6qndBLD52jWMbkwKetOJLQ3f69FakoU13JXBA0KsETW41KiBRQEPCuImsgk9o+6egGsJbiCMJThieMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765511400; c=relaxed/simple;
	bh=ntiFQNQaLEga0eSCtIXQwm+/h+9N7FOjVstpvUWYh5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YeCFFGZKSd8pnF2RAJ7bomQnhg+1WijZzswoyFQxGhXShNA8VV0z7fVV2D5KR0Z796yYx84Y5LFDn0QdnrDcfp+TOMoVtOEKQ9Bi3Q3vbaunSmNsqAOrd5uiwz9xq9V1llKQvCXXnqSC/6nEPkXt28RZ7Ke788BthUdNxGuDTBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OBFwxoTJ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=17neSuUulugcx8bb872dAEvFlSNItM7OQrFcbN6jUX4=;
	b=OBFwxoTJd4TDeWlSgtScS0GBINrd13JRUcxwUbsu433KlFvKzBX2a8LlxV3m8yHxsVbTXLkS2
	iyZ9Dbpej4TqOa0i+eeAIjrsDyapu8BDIWOOy84bqINzxS4FwI1xXE8wvUDdHvQT9AtGDCVL8BF
	Tn9Qex/IGLwCTEkC/9e8s38=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dSFlY1YM9znTXC;
	Fri, 12 Dec 2025 11:47:37 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A8E2A180043;
	Fri, 12 Dec 2025 11:49:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Dec 2025 11:49:52 +0800
Message-ID: <4f71fa6e-3026-7921-7da5-3c917c6e956d@huawei.com>
Date: Fri, 12 Dec 2025 11:49:51 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 15/16] entry: Inline syscall_exit_work()
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <oleg@redhat.com>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <deller@gmx.de>, <macro@orcam.me.uk>,
	<charlie@rivosinc.com>, <ldv@strace.io>, <mark.rutland@arm.com>,
	<song@kernel.org>, <ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <pengcan@kylinos.cn>,
	<dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-16-ruanjinjie@huawei.com>
 <b382cc8a-3ce9-4fb1-bc0a-a3d9796251d1@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <b382cc8a-3ce9-4fb1-bc0a-a3d9796251d1@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/12/9 21:48, Kevin Brodsky wrote:
> On 04/12/2025 09:21, Jinjie Ruan wrote:
>> After switch arm64 to Generic Entry, a new hotspot syscall_exit_work()
>> appeared because syscall_exit_work() is no longer inlined. so inline
> 
> Before this series the call to syscall_trace_exit() in el0_svc_common()
> could not be inlined, so "no longer inlined" doesn't seem to be accurate.

I think the original "syscall_trace_exit()" is on an equal footing with
new introduced syscall_exit_to_user_mode_prepare() which is now inlined.

> 
>> syscall_exit_work(), and it has 2.6% performance uplift on perf bench
>> basic syscall on kunpeng920 as below.
> 
> That seems strange. syscall_exit_work() is only called if some flag in
> SYSCALL_WORK_EXIT is set, which means that we're doing something special
> like tracing. That shouldn't be the case when running a simple perf
> bench syscall.
> 
> Also worth nothing that its counterpart (syscall_trace_enter())) is not
> currently inlined, the asymmetry would have to be justified.

Will check the "syscall_trace_enter" inline performance impact.

> 
>>     | Metric     | W/O this patch | With this patch | Change    |
>>     | ---------- | -------------- | --------------- | --------- |
>>     | Total time | 2.171 [sec]    | 2.114 [sec]     |  ↓2.6%    |
>>     | usecs/op   | 0.217192       | 0.211453        |  ↓2.6%    |
>>     | ops/sec    | 4,604,225      | 4,729,178       |  ↑2.7%    |
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  include/linux/entry-common.h  | 63 ++++++++++++++++++++++++++++++++++-
>>  kernel/entry/syscall-common.c | 59 ++------------------------------
> 
> These changes are purely generic, surely all architectures using
> GENERIC_ENTRY should get similar benefits (assuming LTO isn't used)?

It would be great if someone could help test the performance differences.

> 
>>  2 files changed, 64 insertions(+), 58 deletions(-)
>>
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>> index cd6dacb2d8bf..2f84377fb016 100644
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -2,6 +2,7 @@
>>  #ifndef __LINUX_ENTRYCOMMON_H
>>  #define __LINUX_ENTRYCOMMON_H
>>  
>> +#include <linux/audit.h>
>>  #include <linux/irq-entry-common.h>
>>  #include <linux/ptrace.h>
>>  #include <linux/seccomp.h>
>> @@ -128,6 +129,41 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
>>  	return ret;
>>  }
>>  
>> +/*
>> + * If SYSCALL_EMU is set, then the only reason to report is when
>> + * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
>> + * instruction has been already reported in syscall_enter_from_user_mode().
>> + */
>> +static __always_inline bool report_single_step(unsigned long work)
>> +{
>> +	if (work & SYSCALL_WORK_SYSCALL_EMU)
>> +		return false;
>> +
>> +	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
>> +}
>> +
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
> 
> If we want syscall_exit_work() to be inline, then why would we define
> this hook in syscall-common.c in patch 12? Might as well define both
> hooks in entry-common.h right away and avoid some noise here.

Make sense.

> 
> - Kevin
> 
>> [...]
> 

