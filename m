Return-Path: <linux-kselftest+bounces-45961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EFCC6DD24
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 10:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id ADE562DB48
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342BB33EB0C;
	Wed, 19 Nov 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5T82+hG8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B330504D;
	Wed, 19 Nov 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545798; cv=none; b=Tkny1XF8HxMF4Q/UHk+QmTWaoXFcBuEfKiCv43P7FZA066u7I6669JhbTr8rILTrG7xm0SKyLEoplFKlqDdtxDIihyFUcS/+fTXNL12vgVsnjO/v9fvDbAh5XrJVCTiRhQVMfIK6f/nZRs5ijZFcG5YR52Y+jlEMecmithspqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545798; c=relaxed/simple;
	bh=i8s55KiYGAFG6CP5nPNGxYcoBkX6cUlXN7O5AU5V0Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jYDdhdjnIs3CbwY6RSudbfq/RLxx1NocBdVKJrwAKZQ1qKQfn9QkpYy6inPXORnT8fGiP1s+/ZMvM5cOia0r9XOESrpB6/pYVxYkXo8CFD2C3rw/8pW8Cu19UNYM08chJb4jQEmPbvBiCwrbMWpyZM+CAwlNm+bFp+Zgk47ligE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5T82+hG8; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MPxV851xTjcWbDvstJF4MstyoLzb0xId1eTxrb2FLGI=;
	b=5T82+hG886f1Lt/vohA/vBqbdt+zjEXAej2Pee5+nsD/NfI5oh71S6iVGp7im2EcQvcDJPAHZ
	mpGdHByK8YrH2fOY9WUAuovBEaTWrWouZ9VMmKKXmwPcyfSpBdOMBncBsixZGAIkvgRahC8IBLv
	gUQTuOgg251UY0dn/GBs4yY=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dBGr82Db7zmV8D;
	Wed, 19 Nov 2025 17:48:08 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 39A2F1A0188;
	Wed, 19 Nov 2025 17:49:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Nov 2025 17:49:49 +0800
Message-ID: <9adaa51a-09d1-8450-afb0-838ace0f28e9@huawei.com>
Date: Wed, 19 Nov 2025 17:49:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v7 01/11] arm64/ptrace: Split report_syscall()
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
 <20251117133048.53182-2-ruanjinjie@huawei.com>
 <970d9689-4188-4c40-92e6-bdf1e589e8a2@arm.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <970d9689-4188-4c40-92e6-bdf1e589e8a2@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/11/19 1:09, Kevin Brodsky wrote:
> On 17/11/2025 14:30, Jinjie Ruan wrote:
>> The generic syscall entry code has the form:
>>
>> | syscall_trace_enter()
>> | {
>> |	ptrace_report_syscall_entry()
>> | }
>> |
>> | syscall_exit_work()
>> | {
>> |	ptrace_report_syscall_exit()
>> | }
>>
>> In preparation for moving arm64 over to the generic entry code, split
>> report_syscall() to two separate enter and exit functions to align
>> the structure of the arm64 code with syscall_trace_enter() and
>> syscall_exit_work() from the generic entry code.
>>
>> No functional changes.
>>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/ptrace.c | 29 ++++++++++++++++++++---------
>>  1 file changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 4b001121c72d..5534c175ceb7 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -2317,7 +2317,7 @@ enum ptrace_syscall_dir {
>>  	PTRACE_SYSCALL_EXIT,
>>  };
> 
> This is now unused so it should be removed.

Sure.

> 
>>  
>> -static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
>> +static void report_syscall_enter(struct pt_regs *regs)
> 
> Nit: better to call it "report_syscall_entry" to match its final name.

That makes sense, thanks for the review.

> 
>>  {
>>  	int regno;
>>  	unsigned long saved_reg;
>> @@ -2340,13 +2340,24 @@ static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
>>  	 */
>>  	regno = (is_compat_task() ? 12 : 7);
>>  	saved_reg = regs->regs[regno];
>> -	regs->regs[regno] = dir;
>> +	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
>>  
>> -	if (dir == PTRACE_SYSCALL_ENTER) {
>> -		if (ptrace_report_syscall_entry(regs))
>> -			forget_syscall(regs);
>> -		regs->regs[regno] = saved_reg;
>> -	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
>> +	if (ptrace_report_syscall_entry(regs))
>> +		forget_syscall(regs);
>> +	regs->regs[regno] = saved_reg;
>> +}
>> +
>> +static void report_syscall_exit(struct pt_regs *regs)
>> +{
>> +	int regno;
>> +	unsigned long saved_reg;
>> +
>> +	/* See comment for report_syscall_enter() above */
>> +	regno = (is_compat_task() ? 12 : 7);
> 
> Probably best not to duplicate such magic numbers, moving this line to a
> helper would be good.

That makes sense.  A helper will remove the duplicate.

> 
> - Kevin
> 
>> +	saved_reg = regs->regs[regno];
>> +	regs->regs[regno] = PTRACE_SYSCALL_EXIT;
>> +
>> +	if (!test_thread_flag(TIF_SINGLESTEP)) {
>>  		ptrace_report_syscall_exit(regs, 0);
>>  		regs->regs[regno] = saved_reg;
>>  	} else {
>> @@ -2366,7 +2377,7 @@ int syscall_trace_enter(struct pt_regs *regs)
>>  	unsigned long flags = read_thread_flags();
>>  
>>  	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
>> -		report_syscall(regs, PTRACE_SYSCALL_ENTER);
>> +		report_syscall_enter(regs);
>>  		if (flags & _TIF_SYSCALL_EMU)
>>  			return NO_SYSCALL;
>>  	}
>> @@ -2394,7 +2405,7 @@ void syscall_trace_exit(struct pt_regs *regs)
>>  		trace_sys_exit(regs, syscall_get_return_value(current, regs));
>>  
>>  	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
>> -		report_syscall(regs, PTRACE_SYSCALL_EXIT);
>> +		report_syscall_exit(regs);
>>  
>>  	rseq_syscall(regs);
>>  }
> 

