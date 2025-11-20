Return-Path: <linux-kselftest+bounces-46095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A75C73A0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98C654E8AEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66E432F74F;
	Thu, 20 Nov 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wzxAJriX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC409309F12;
	Thu, 20 Nov 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636771; cv=none; b=Q+bfsEflp/QdRU1XLpKGgWd6uQQHGrSe4yx67bbyeE0J6sEximmFIF1sXa3yXeBnU4o89N1kyqzl+e0v2GZlHWi049Dbot45NvPRPK5qQ+diu/e4qC7zJOfsVhiHXxh+MTX9lBGgX2W1JIT+NLeKDzUbk/N1f/HiZm3s2LURjE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636771; c=relaxed/simple;
	bh=EAJpm77ss3DmS3HdAXR559PE45aUdlWP59zVML6Hsgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r9ktmRI1wO680SjVvooNFmq4VWOtMOLkTRd4VPeCL+6KFpsNuKOP8Iou7DoDkjh6taZiEvkvHNajrdh8JM69zERXm2/PT7/50aoB1dsqIpuR1w/jHG/ruBEtnxsVfXUcnGjaRzTX4MmLheI+6SzaPLoN/pFX+6pQU2k5HuQEdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wzxAJriX; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Wo9AYU4ZP87/cRBaweFBQ81kmpPLnOM/YafttZhjfmw=;
	b=wzxAJriXfqmkwATr2VfoB44bwdVdEKqh609g0CKJOI6NRNJY599ufGo3ZNKLJjSdgRoZxEs50
	WHwFmKXT+BmBiyQxYZWxkvFlZnpZMReGlT7dOSggzWM+4XmAdk8ZRfniz9Hz6TZrPL0eotNl++8
	f2TK84FQnY7aQE2ktME8pTM=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dBwTm2nTqz12LHn;
	Thu, 20 Nov 2025 19:04:28 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 619C8140144;
	Thu, 20 Nov 2025 19:05:55 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 19:05:53 +0800
Message-ID: <d1aeb83e-d380-be80-9bd7-72f95a9aa09a@huawei.com>
Date: Thu, 20 Nov 2025 19:05:52 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v7 02/11] arm64/ptrace: Refactor
 syscall_trace_enter/exit()
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
 <20251117133048.53182-3-ruanjinjie@huawei.com>
 <4984d8e6-1431-4dcc-9723-c5470b5bcd49@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <4984d8e6-1431-4dcc-9723-c5470b5bcd49@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/11/19 1:09, Kevin Brodsky wrote:
> On 17/11/2025 14:30, Jinjie Ruan wrote:
>> [...]
>>
>> @@ -2386,19 +2384,27 @@ int syscall_trace_enter(struct pt_regs *regs)
>>  	if (secure_computing() == -1)
>>  		return NO_SYSCALL;
>>  
>> -	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>> -		trace_sys_enter(regs, regs->syscallno);
>> +	/* Either of the above might have changed the syscall number */
>> +	syscall = syscall_get_nr(current, regs);
>> +
>> +	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
>> +		trace_sys_enter(regs, syscall);
>>  
>> -	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
>> +		/*
>> +		 * Probes or BPF hooks in the tracepoint may have changed the
>> +		 * system call number as well.
>> +		 */
>> +		 syscall = syscall_get_nr(current, regs);
>> +	}
>> +
>> +	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
>>  			    regs->regs[2], regs->regs[3]);
>>  
>>  	return regs->syscallno;
> 
> It would be good to align the return with the generic version as well.

Right, could be aligned with the return with the generic version.

> 
>>  }
>>  
>> -void syscall_trace_exit(struct pt_regs *regs)
>> +void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
>>  {
>> -	unsigned long flags = read_thread_flags();
>> -
>>  	audit_syscall_exit(regs);
>>  
>>  	if (flags & _TIF_SYSCALL_TRACEPOINT)
>> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
>> index aba7ca6bca2d..6e3fe760e0bb 100644
>> --- a/arch/arm64/kernel/syscall.c
>> +++ b/arch/arm64/kernel/syscall.c
>> @@ -124,7 +124,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>>  		 */
>>  		if (scno == NO_SYSCALL)
>>  			syscall_set_return_value(current, regs, -ENOSYS, 0);
>> -		scno = syscall_trace_enter(regs);
>> +		scno = syscall_trace_enter(regs, regs->syscallno, flags);
> 
> Nit: could use scno instead of regs->syscallno.

That is ok.

> 
> - Kevin
> 
>>  		if (scno == NO_SYSCALL)
>>  			goto trace_exit;
>>  	}
>> @@ -143,7 +143,8 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>>  	}
>>  
>>  trace_exit:
>> -	syscall_trace_exit(regs);
>> +	flags = read_thread_flags();
>> +	syscall_trace_exit(regs, flags);
>>  }
>>  
>>  void do_el0_svc(struct pt_regs *regs)
> 

