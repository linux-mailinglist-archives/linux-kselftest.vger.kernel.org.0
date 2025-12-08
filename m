Return-Path: <linux-kselftest+bounces-47259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CB4CAC346
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 07:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C02303463B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 06:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB86030F94C;
	Mon,  8 Dec 2025 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YiyFltbA";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YiyFltbA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63831AA95;
	Mon,  8 Dec 2025 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175520; cv=none; b=d8sclzgm9PgC9PMVXZWBYbuEeMBap2qu4vyDL+Zmisn+jkq8yLTOvolPD2jkAUjQpldQX/D7TwOTKA0kZiBkrNVR8f2yCRK9qcTAP+smW0YBuDU82lqW0jSJo/wvyn9fWLWoAIYbpqJiPUL3OO2O65TMhvrVS7M8KRN2XQ2sC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175520; c=relaxed/simple;
	bh=lP55H7HRxFUGomIendZO7ked2onBjILeZ80BrzavdWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aQp7NBbjQjI6ixWWSGXbqbzslR1JbYYFAf2Yu9hJsp2c2+vaa9qtX94rI/7MbVCy3qyKSzSwTCURBDfiLdCxby0GMd1dIH3JkcZ7wn1jhAa+YQ5CLHRqIW5JRF8NmSXqRu9WRB+6Z1ayHLQqTPs7i0VcnVK1kqpyt8rWXN3ygBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YiyFltbA; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YiyFltbA; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=irJb6cvU/fom+A8NIoGIACpM9tMEXj6ECbx53ePW9ag=;
	b=YiyFltbAWDbuPL00L926hXQ9g4gDJaXdZikPQI1HzTLoLx3qdCdgRP++xwx3a8ZKtZbJSAyAS
	C2PwNZb1cLhMxnC8sv44DyTg+uHZP+HB17EKTAEWyxvhTVXvmH5T2/dEsDwhIggjuidirhRqCNT
	FZJH1cl9v8gauwBkKv+xZSs=
Received: from canpmsgout12.his.huawei.com (unknown [172.19.92.144])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dPsZg4C47z1BG32;
	Mon,  8 Dec 2025 14:31:39 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=irJb6cvU/fom+A8NIoGIACpM9tMEXj6ECbx53ePW9ag=;
	b=YiyFltbAWDbuPL00L926hXQ9g4gDJaXdZikPQI1HzTLoLx3qdCdgRP++xwx3a8ZKtZbJSAyAS
	C2PwNZb1cLhMxnC8sv44DyTg+uHZP+HB17EKTAEWyxvhTVXvmH5T2/dEsDwhIggjuidirhRqCNT
	FZJH1cl9v8gauwBkKv+xZSs=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dPsWz2CyTznTXP;
	Mon,  8 Dec 2025 14:29:19 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 06D23180042;
	Mon,  8 Dec 2025 14:31:38 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Dec 2025 14:31:36 +0800
Message-ID: <1f919820-2c8e-f041-b38d-963b55c8792d@huawei.com>
Date: Mon, 8 Dec 2025 14:31:35 +0800
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
To: Anshuman Khandual <anshuman.khandual@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <oleg@redhat.com>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <deller@gmx.de>, <macro@orcam.me.uk>,
	<charlie@rivosinc.com>, <kevin.brodsky@arm.com>, <ldv@strace.io>,
	<mark.rutland@arm.com>, <song@kernel.org>, <ryan.roberts@arm.com>,
	<ada.coupriediaz@arm.com>, <broonie@kernel.org>, <pengcan@kylinos.cn>,
	<dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-4-ruanjinjie@huawei.com>
 <7c7e5c66-f618-466f-b353-54fad71c0e14@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <7c7e5c66-f618-466f-b353-54fad71c0e14@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/12/8 13:24, Anshuman Khandual wrote:
> On 04/12/25 1:51 PM, Jinjie Ruan wrote:
>> The generic entry abort the syscall_trace_enter() sequence if
>> ptrace_report_syscall_entry() errors out, but arm64 not.
>>
>> As the ptrace_report_syscall_entry() comment said, the calling arch code
>> should abort the system call and must prevent normal entry so no system
>> call is made if ptrace_report_syscall_entry() return nonzero.
>>
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
> 
> A small nit.
> 
> Could report_syscall_entry(regs) be checked directly in the 'if' conditional
> code block thus dropping new 'ret' altogether ?

It’s perfectly fine, but on the one hand, the upcoming refactor of the
secure_computing() patch will be able to use this ‘ret’, and on the
other, the intent of this patch is to highlight the differences from the
generic entry so we can switch over smoothly later. Simplifying it here
therefore doesn’t help much for demonstrating those differences.

> 
>>  			return NO_SYSCALL;
>>  	}
>>  
> 
> 

