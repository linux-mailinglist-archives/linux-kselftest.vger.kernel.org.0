Return-Path: <linux-kselftest+bounces-46199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EDC77B3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 08:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 16E542BE4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288F338584;
	Fri, 21 Nov 2025 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BWDCPuIZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66432FA26;
	Fri, 21 Nov 2025 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710201; cv=none; b=YHgo7QBHdMIPN5pXHZqyzCHam+Z8jylIkibmhCRS7sdqFx+Wh3z5YoeGhx8fGqkZPQMy52fPm6SjDAbFuQiojTRiiaYjTZmLgZakLAvhp634AMS/KGOIfHDNnZra+bFH37lyPxWPMMrMuHc0BPVEjF+lMy8c5UlAaezPPxiJKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710201; c=relaxed/simple;
	bh=XCC70O6aygXS6msGgQDHEc9SNvVW1q9SjduvGsqHZGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hogd2PYyFC0mAO3QF9FMuVo3l6axnfDS0Fh7T3duETZ/GVtR7yUxMJ/lS4/MzTWRv6DX6cwDbDegaS7MW8PeWU0LXcC1djiy7//wLgvAG8YwgihiRF7N5BB05wzh/e2369sq0azyEVWaOWtUfq/v/CP6G/RHVre4goDuXo9FqGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BWDCPuIZ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yXg8+7/IaBeahjUcoxp7tnRw/aA/6ViGCJ49LoFeOZY=;
	b=BWDCPuIZauSbS7kpISZx+lbXlOQi8ORkqYVjuyrDXbFs+yIsiwHAMLmUx67uxxMQYnbwxF5cO
	+sRHBt+QaAhe81TOPUfdEfqV5/LIYtAUsrAWxcF437IxQk1g3joCkF0PFG6DIi/I7/a2XncjiY7
	mY0/l7JUeQCu0RV2xJYRHWs=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dCRdk0kPQz1prL2;
	Fri, 21 Nov 2025 15:28:10 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id D5DB6180BCF;
	Fri, 21 Nov 2025 15:29:55 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 15:29:53 +0800
Message-ID: <a383b3c6-e036-294e-5c62-c7719349c75c@huawei.com>
Date: Fri, 21 Nov 2025 15:29:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v7 06/11] arm64/ptrace: Expand secure_computing() in place
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
 <20251117133048.53182-7-ruanjinjie@huawei.com>
 <e33d0fdb-e8a5-4abd-8e40-773349008b6b@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <e33d0fdb-e8a5-4abd-8e40-773349008b6b@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/11/19 1:12, Kevin Brodsky wrote:
> On 17/11/2025 14:30, Jinjie Ruan wrote:
>> The generic entry expand secure_computing() in place and call
>> __secure_computing() directly.
>>
>> In order to switch to the generic entry for arm64, refactor
>> secure_computing() for syscall_trace_enter().
>>
>> No functional changes.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/ptrace.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 707951ad5d24..9af3046a2ce9 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -2387,8 +2387,11 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
>>  	}
>>  
>>  	/* Do the secure computing after ptrace; failures should be fast. */
>> -	if (secure_computing() == -1)
>> -		return NO_SYSCALL;
>> +	if (flags & _TIF_SECCOMP) {
>> +		ret = __secure_computing(NULL);
> 
> No argument was passed to __secure_computing() in v6, as expected since
> it was removed in v6.15. Not sure why this NULL reappeared.
> 
There is a typo here.

>> +		if (ret == -1L)
> 
> ret is an int, so should be -1, not -1L.

Right, not -1L.

> 
> - Kevin
> 
>> +			return NO_SYSCALL;
>> +	}
>>  
>>  	/* Either of the above might have changed the syscall number */
>>  	syscall = syscall_get_nr(current, regs);
> 

