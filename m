Return-Path: <linux-kselftest+bounces-46407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E0C83204
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 03:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7A8E343453
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 02:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F421D9A54;
	Tue, 25 Nov 2025 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SqqrohGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C71D63F0;
	Tue, 25 Nov 2025 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764038610; cv=none; b=HaJ7QJ7QR61D/NdJrTM7sMQzTd8WKH5WiP5tjhzoJkYolislDw2KQpxQ+cTnm0Osc+Sf/EyjYykAq2909PfWU+WCH2C5mEu5Zfe99+qvxooC7a+wCUyEwH5gKNpLZOa0r6EeePLE8DjR1B++wtX15cceTsMk7mplCU33QMyvxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764038610; c=relaxed/simple;
	bh=AG6TtJiMA3zBzBSxfcCYQGjYOqmjaqEBpfRAVP2iBSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SheAd2eIegSCH08czoNYBHSMCyT214qt5Fv3AWdqc6KdhsiQ2G08Cqui45SUO6xxMQxCjtFEU3s/Kd7F8kmM2nNbw4oT/VgcccqM0QTQO6T0WAIdaMwPUAI7pqRycSjZxmbwPY65DiuOClkzXc3VgBoBmIFappvLCpHdSL4/7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SqqrohGm; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8+eUWJFw0hDATzVyoymAn34cz1/y9o5OALJowK6mO3Y=;
	b=SqqrohGmLZV+sDK9qVmNpsLM+SPimd9bMrmLYYka9Q0Ig0cr7ipqTprCZljyNZd7+o05B1kca
	OnIMa1WKdruPldnfNnEWscPoE1wjdbjyfIOV6LFA80v59CJxrfc751C7f5oQXK4f5mwWeKCqmIo
	9yTZDGW5T3VILAvFgf2D3zE=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dFn5870Jsz1K96Y;
	Tue, 25 Nov 2025 10:41:32 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8720A1A0188;
	Tue, 25 Nov 2025 10:43:18 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 10:43:17 +0800
Message-ID: <48b7443a-2dd9-9764-fbe5-12dc9eef1363@huawei.com>
Date: Tue, 25 Nov 2025 10:43:16 +0800
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
 <8489ee0d-8b9c-080a-04a0-b299549e86cf@huawei.com>
 <247aa84f-0550-42d9-8d65-615297e78a74@arm.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <247aa84f-0550-42d9-8d65-615297e78a74@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/11/24 23:23, Kevin Brodsky wrote:
> On 24/11/2025 10:34, Jinjie Ruan wrote:
>>
>> On 2025/11/19 1:13, Kevin Brodsky wrote:
>>> On 17/11/2025 14:30, Jinjie Ruan wrote:
>>>> [...]
>>>>
>>>> diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
>>>> index 66e6ba7fa80c..27310e611567 100644
>>>> --- a/kernel/entry/syscall-common.c
>>>> +++ b/kernel/entry/syscall-common.c
>>>> @@ -17,6 +17,25 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>>>>  	}
>>>>  }
>>>>  
>>>> +/**
>>>> + * arch_ptrace_report_syscall_entry - Architecture specific
>>>> + *				      ptrace_report_syscall_entry().
>>>> + *
>>>> + * Invoked from syscall_trace_enter() to wrap ptrace_report_syscall_entry().
>>>> + * Defaults to ptrace_report_syscall_entry.
>>>> + *
>>>> + * The main purpose is to support arch-specific ptrace_report_syscall_entry()
>>>> + * implementation.
>>>> + */
>>>> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs);
>>>> +
>>>> +#ifndef arch_ptrace_report_syscall_entry
>>>> +static __always_inline int arch_ptrace_report_syscall_entry(struct pt_regs *regs)
>>>> +{
>>>> +	return ptrace_report_syscall_entry(regs);
>>> I saw that Thomas suggested this approach on v4, and it makes sense to
>>> me, but I find the naming surprising. If an architecture does need extra
>>> handling, then the generic function should never be called from generic
>>> code. So it seems to me that the more logical change would be:
>>>
>>> * Rename: ptrace_report_syscall_entry -> __ptrace_report_syscall_entry
>>> * Introduce ptrace_report_syscall_entry(), defaults to
>>> __ptrace_report_syscall_entry()
>> If ptrace_report_syscall_entry() is defined in linux/ptrace.h, and an
>> architecture also needs to redefine this function, but the
>> architecture's own <asm/entry-common.h> must include <linux/ptrace.h>,
>> the function will end up being defined twice and cause a "duplicate
>> definition" compile error.
> 
> There's plenty of arch-defined functions in <linux/ptrace.h> already.
> __ptrace_report_syscall_entry() should be defined inside an #ifndef and
> architectures can define their own implementation in <asm/ptrace.h>,
> like force_successful_syscall_return() for instance.

Shared functions like ptrace_report_syscall() are all defined in
<linux/ptrace.h>.
When we want to override __ptrace_report_syscall_entry() in
<asm/ptrace.h> we still have to include <linux/ptrace.h> again,then the
redefine problem occurs again.

What we actually need to reuse is ptrace_report_syscall_entry() (or
__ptrace_report_syscall_entry()).

The arch version need to reuse and wrap ptrace_report_syscall_entry(),
because for instance arm64 needs to perform additional operations before
and after this step. Therefore, I believe the current implementation is
appropriate.

> 
> - Kevin
> 
>>> All this would be done in <linux/ptrace.h>, where it clearly belongs.
>>> The __ prefix makes it clear that the generic function is not the main
>>> interface. Even better, no need to change any caller with that approach.
>>>
>>> - Kevin
>>>
>>>> [...]
> 

