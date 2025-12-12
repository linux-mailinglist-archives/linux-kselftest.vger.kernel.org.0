Return-Path: <linux-kselftest+bounces-47476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE5BCB7D0D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFC83013397
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F02E1749;
	Fri, 12 Dec 2025 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c8LsiV1s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E7256C70;
	Fri, 12 Dec 2025 04:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765512052; cv=none; b=Fc1L8i6lsT0Z009Zqz/6Bxt7zkMBrqwbp+2RsdWHTolby6kNdaLjkApuq81W0ZDIX941Yb7dt7KSB/m9RIkpKHshuwnAs8G0iKR8zfzIL+AAh5/uP9GvKcD/bLb0+CCjanemy694mg/3oC70y+Ek/s9mEqSSUhLxgm+GN+ZHTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765512052; c=relaxed/simple;
	bh=x0qU9vM+eDgbkfx21pg1MRwOlsw8jFslvLRiQC12Pzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CCkFdtJxuIpREAFhgvqzPL1NlNFUFCYpZxio8Rt1eXIgzUKBla2iWxW09LGFnGoyAelHEnmLTw1VgCj4JneJ1vlURGlTIzk+1L2dH+7UmVpWA8aLkn6cud5ECvkHFvRxZleAbGVrCQXP+GTFt6cmsekr1i4F9mq1Rd6Ucl8uQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c8LsiV1s; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tPLwoUwGjEHAvimSj8cQdy88azT+F1V9CLbQw5PbX84=;
	b=c8LsiV1sC3ls4lji4WJcHUdAykhOZiXd4EVUNzayikuB2KRAtHW+AbS0eaSOrru3Pu5zAFwIF
	9nK6mAjcNnJfWV7Cs69SRWPCHX4yIDwcyIYljpfL47dcwwmYhHk10+yPsDSYecPUhFcBYgm8+gS
	u22GXj8SSPleEg4RF5NTFbw=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dSFzk2MrkzpStQ;
	Fri, 12 Dec 2025 11:58:10 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A948140121;
	Fri, 12 Dec 2025 12:00:45 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Dec 2025 12:00:43 +0800
Message-ID: <051fe45b-f158-85be-3f8e-60c830fb47a2@huawei.com>
Date: Fri, 12 Dec 2025 12:00:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 03/16] arm64/ptrace: Return early for
 ptrace_report_syscall_entry() error
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
 <20251204082123.2792067-4-ruanjinjie@huawei.com>
 <52f63e40-541f-4ed8-9d05-626eab4b39cb@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <52f63e40-541f-4ed8-9d05-626eab4b39cb@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/12/9 21:46, Kevin Brodsky wrote:
> On 04/12/2025 09:21, Jinjie Ruan wrote:
>> The generic entry abort the syscall_trace_enter() sequence if
>> ptrace_report_syscall_entry() errors out, but arm64 not.
>>
>> As the ptrace_report_syscall_entry() comment said, the calling arch code
>> should abort the system call and must prevent normal entry so no system
>> call is made if ptrace_report_syscall_entry() return nonzero.
> 
> This patch is now in the right position, which means that arm64 does
> abort the syscall already without this patch. What we're changing here
> is that the tracing sequence is interrupted. The comment you're
> referring to says nothing about tracing so I'm not sure it helps to
> refer to it.

I think “must prevent normal entry ”means When ptrace requests
interception, all subsequent processing, including audit and seccomp,
should completely bypassed.

> 
> Otherwise:
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> 
>> In preparation for moving arm64 over to the generic entry code,
>> return early if ptrace_report_syscall_entry() encounters an error.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/ptrace.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 4532e9831856..3926ce6aa268 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -2346,15 +2346,18 @@ static __always_inline unsigned long ptrace_save_reg(struct pt_regs *regs,
>>  	return saved_reg;
>>  }
>>  
>> -static void report_syscall_entry(struct pt_regs *regs)
>> +static int report_syscall_entry(struct pt_regs *regs)
>>  {
>>  	unsigned long saved_reg;
>> -	int regno;
>> +	int regno, ret;
>>  
>>  	saved_reg = ptrace_save_reg(regs, PTRACE_SYSCALL_ENTER, &regno);
>> -	if (ptrace_report_syscall_entry(regs))
>> +	ret = ptrace_report_syscall_entry(regs);
>> +	if (ret)
>>  		forget_syscall(regs);
>>  	regs->regs[regno] = saved_reg;
>> +
>> +	return ret;
>>  }
>>  
>>  static void report_syscall_exit(struct pt_regs *regs)
>> @@ -2381,10 +2384,11 @@ static void report_syscall_exit(struct pt_regs *regs)
>>  int syscall_trace_enter(struct pt_regs *regs)
>>  {
>>  	unsigned long flags = read_thread_flags();
>> +	int ret;
>>  
>>  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
>> -		report_syscall_entry(regs);
>> -		if (flags & _TIF_SYSCALL_EMU)
>> +		ret = report_syscall_entry(regs);
>> +		if (ret || (flags & _TIF_SYSCALL_EMU))
>>  			return NO_SYSCALL;
>>  	}
>>  
> 

