Return-Path: <linux-kselftest+bounces-46098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD0EC73DDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 13:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA2AB35481E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709932E756;
	Thu, 20 Nov 2025 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uMi81M09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B83271A6D;
	Thu, 20 Nov 2025 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640238; cv=none; b=ej5MqXFuKdn/Ryf4B157FEAuitVJG2mzmsWRPUUs09aThI+gjKb7fBHD3+j5tX8B4INETdAbpImrRk8xldGUH8nyXbUInBQhKHcK6aWxKVr7m6x6Ebl9ahaDtipyRxpmM5+9sj+D+uiBNIdxkQwLSswV3yNnasApRf78hko9lqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640238; c=relaxed/simple;
	bh=e9xqZbpvstk95mNHsWwwBAImUSmzdZoLfffEOWjM86A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bMXpC1vT8P8hURom4LbfnthXif1KH9c5iR9Lf4xM1J17dsto2iMmebAyaErFfssydsIOk7HI9vct1DT98hZr/BVcAkeqEP2W7Z/axtRl+v+9EyDwncHCIjOBZHmMrYmJQlmc5H1e5Cqh+pDMQItB2A2ZPeRbHi5CYfUNEp1uMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uMi81M09; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jv8wO1DtfkXsY/ae1Dg1/DwE8bP+V8jd6aqheqjiOgc=;
	b=uMi81M090SzQpqt08FtTaGHZap8RoTOn41f2uoRuD3XvHjjAujVzUsQypK5sBntqbNvqK1JHf
	3S0BpZTCKAMBQlch3lOYW/gAADx8wNxsQhQ6OZbTL+7vRqIC/KH6vveGLYgOOTqNPJl1EEax75O
	EsdG5hHKqxRUDUiGXbZUzh4=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dBxlv0v4LzcZxv;
	Thu, 20 Nov 2025 20:01:47 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 688BE140159;
	Thu, 20 Nov 2025 20:03:51 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:03:49 +0800
Message-ID: <7b317981-659c-fa02-d569-f832bfc09c9c@huawei.com>
Date: Thu, 20 Nov 2025 20:03:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v7 03/11] arm64/ptrace: Refator el0_svc_common()
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
 <20251117133048.53182-4-ruanjinjie@huawei.com>
 <57c2c83c-9eea-40e0-9f95-47f21b1c75be@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <57c2c83c-9eea-40e0-9f95-47f21b1c75be@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/11/19 1:10, Kevin Brodsky wrote:
> In subject: s/refator/refactor/
> 
> Also nit: this is less about ptrace than about syscall entry, so maybe
> "arm64/syscall:"?
> 
> On 17/11/2025 14:30, Jinjie Ruan wrote:
>> Compared to the generic entry code, arm64 terminate the process
> 
> s/terminate/terminates/ (similar observation for other commit messages)

Will update it.

> 
>> after report_syscall_exit() if the syscall is issued within
>> a restartable sequence.
> 
> Presumably this implies that forcing SIGSEGV before or after calling the
> tracing handlers makes no difference, if so it should be clarified.

It seems that it need a separate patch to clarify.

> 
>> In preparation for moving arm64 over to the generic entry code,
>> refactor el0_svc_common() as below:
>>
>> - Extract syscall_exit_to_user_mode_prepare() to replace the
>>   the combination of read_thread_flags() and syscall_trace_exit(),
>>   also move the syscall exit check logic into it.
>>
>> - Move rseq_syscall() ahead, so the CONFIG_DEBUG_RSEQ check is
>>   not needed.
>>
>> - Move has_syscall_work() helper into asm/syscall.h, which will be
>>   reused by ptrace.c.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/include/asm/syscall.h |  7 ++++++-
>>  arch/arm64/kernel/ptrace.c       | 10 +++++++++-
>>  arch/arm64/kernel/syscall.c      | 26 +++++---------------------
>>  3 files changed, 20 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
>> index d69f590a989b..6225981fbbdb 100644
>> --- a/arch/arm64/include/asm/syscall.h
>> +++ b/arch/arm64/include/asm/syscall.h
>> @@ -114,7 +114,12 @@ static inline int syscall_get_arch(struct task_struct *task)
>>  	return AUDIT_ARCH_AARCH64;
>>  }
>>  
>> +static inline bool has_syscall_work(unsigned long flags)
>> +{
>> +	return unlikely(flags & _TIF_SYSCALL_WORK);
>> +}
>> +
>>  int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
>> -void syscall_trace_exit(struct pt_regs *regs, unsigned long flags);
>> +void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
>>  
>>  #endif	/* __ASM_SYSCALL_H */
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index bbb868f6b292..95984bbf53db 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -2403,7 +2403,7 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
>>  	return regs->syscallno;
>>  }
>>  
>> -void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
>> +static void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
>>  {
>>  	audit_syscall_exit(regs);
>>  
>> @@ -2412,8 +2412,16 @@ void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
>>  
>>  	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
>>  		report_syscall_exit(regs);
>> +}
>> +
>> +void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
>> +{
>> +	unsigned long flags = read_thread_flags();
>>  
>>  	rseq_syscall(regs);
>> +
>> +	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
>> +		syscall_trace_exit(regs, flags);
> 
> Since we're trying to align as much with the generic code as possible,
> we might as well rename this function to syscall_exit_work() as well.

Yes, syscall_trace_exit() is very similar to syscall_exit_work().

> 
>>  }
>>  
>>  /*
>> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
>> index 6e3fe760e0bb..9713b038d750 100644
>> --- a/arch/arm64/kernel/syscall.c
>> +++ b/arch/arm64/kernel/syscall.c
>> @@ -65,11 +65,6 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>>  	choose_random_kstack_offset(get_random_u16());
>>  }
>>  
>> -static inline bool has_syscall_work(unsigned long flags)
>> -{
>> -	return unlikely(flags & _TIF_SYSCALL_WORK);
>> -}
>> -
>>  static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>>  			   const syscall_fn_t syscall_table[])
>>  {
>> @@ -125,26 +120,15 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>>  		if (scno == NO_SYSCALL)
>>  			syscall_set_return_value(current, regs, -ENOSYS, 0);
>>  		scno = syscall_trace_enter(regs, regs->syscallno, flags);
>> -		if (scno == NO_SYSCALL)
>> -			goto trace_exit;
> 
> Why not keep the goto instead of duplicating the call? It could be
> renamed if necessary.

That is good.

> 
> - Kevin
> 
>> +		if (scno == NO_SYSCALL) {
>> +			syscall_exit_to_user_mode_prepare(regs);
>> +			return;
>> +		}
>>  	}
>>  
>>  	invoke_syscall(regs, scno, sc_nr, syscall_table);
>>  
>> -	/*
>> -	 * The tracing status may have changed under our feet, so we have to
>> -	 * check again. However, if we were tracing entry, then we always trace
>> -	 * exit regardless, as the old entry assembly did.
>> -	 */
>> -	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
>> -		flags = read_thread_flags();
>> -		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP))
>> -			return;
>> -	}
>> -
>> -trace_exit:
>> -	flags = read_thread_flags();
>> -	syscall_trace_exit(regs, flags);
>> +	syscall_exit_to_user_mode_prepare(regs);
>>  }
>>  
>>  void do_el0_svc(struct pt_regs *regs)
> 

