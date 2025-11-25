Return-Path: <linux-kselftest+bounces-46412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D3C8336C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 04:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9130C3AB28C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 03:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2758521FF2A;
	Tue, 25 Nov 2025 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hHLGhiMB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984819F464;
	Tue, 25 Nov 2025 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041005; cv=none; b=EOaZ3RdSwpzia2qPTQLyiw/Beygv7OqoeW3Xh1rR34OSJiqJ2QbX5lccKPyvBhWPnVBb7p3Y1lvtEEUnUTlR4H4BsFoPyc9gNhU7I2pYdtr+dr7Qw0g5Tgp6n1pL4RTYmT8SVzxjcov1Nx3inS9uj6qRx2gn0pWWKYbEPxfNCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041005; c=relaxed/simple;
	bh=Um8gES0aP3WWM8fWMNme342IcwCLp+u3sGeBFUsR1Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IubDCCNeeETHFqjAsrnYhhJ+40OSnNs/6ksZb3u5g/CMx12AkmVWMK9eOg/a0m+zl42n1KVwObivDmMokrxfjfry8eBMymQSQLtVZW9otqtKxJUSWH124mVwsLTCc/10+mbqHl6OQK/PY90oipUgHZ1832nyR3TvFxF/E5or79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hHLGhiMB; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=N/GlMzXtKU+hfuRyLCDNMAPdT07yfV6LWnrvh0FWnOg=;
	b=hHLGhiMBs/ccMUnV96htEYVgIMJ6y8ixfclW8OTPQ0tM0A9c9FCtaFC5Z1U/98ohZBqAuaXah
	4xcWm99WxZNvCeQUWsMUXJ9HAbFuraNI+CK49Tu81ySp1VV0MGh7lPf7KMOJlZpN752dnFMMihI
	49PXO15qSzKaWsN4Zv7Pgow=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dFnyg6CjyzcZxk;
	Tue, 25 Nov 2025 11:20:59 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id A077D1402C1;
	Tue, 25 Nov 2025 11:23:12 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 11:23:10 +0800
Message-ID: <21071aac-8eaf-cfd7-6211-d119b257ef4c@huawei.com>
Date: Tue, 25 Nov 2025 11:23:04 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v7 09/11] entry: Add has_syscall_work() helper
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
 <20251117133048.53182-10-ruanjinjie@huawei.com>
 <e37844e3-8810-42c1-bae1-30b2e7868b80@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <e37844e3-8810-42c1-bae1-30b2e7868b80@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/11/19 1:13, Kevin Brodsky wrote:
> On 17/11/2025 14:30, Jinjie Ruan wrote:
>> Add has_syscall_work() helper to facilitate reuse of this
>> function in other places.
>>
>> No functional changes.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  include/linux/entry-common.h | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>> index cd6dacb2d8bf..e0f94e937e84 100644
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -44,6 +44,11 @@
>>  				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
>>  				 ARCH_SYSCALL_WORK_EXIT)
>>  
>> +static inline bool has_syscall_work(unsigned long work)
>> +{
>> +	return unlikely(work & SYSCALL_WORK_ENTER);
> 
> I'm not sure this is a good idea, since the generic syscall machinery
> has two separate sets of flags (SYSCALL_WORK_ENTER and
> SYSCALL_WORK_EXIT). Of course we could reflect that in the helper's
> name, but since it's only used twice after patch 10, maybe we don't need
> a helper at all.

Will remove it.

> 
> - Kevin
> 
>> +}
>> +
>>  /**
>>   * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
>>   * @regs:	Pointer to currents pt_regs
>> @@ -91,7 +96,7 @@ static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *re
>>  {
>>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>>  
>> -	if (work & SYSCALL_WORK_ENTER)
>> +	if (has_syscall_work(work))
>>  		syscall = syscall_trace_enter(regs, syscall, work);
>>  
>>  	return syscall;
> 

