Return-Path: <linux-kselftest+bounces-47461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 598FBCB789A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 02:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C2D3023556
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 01:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50021A9F91;
	Fri, 12 Dec 2025 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6C+SBFhT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731317B43F;
	Fri, 12 Dec 2025 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765502811; cv=none; b=UlDRGhukVc5QH5EE3ba3BW1+AvZcJ0p0Tl4G7ESWYmBykD3uZQmHEgqnlGXUaDcMY16jEmrcPcWqjbAFKqXUez1luBK6x7OT8MChcqCQM1Ss1mCXiN9L2RZ6CPFVojwc1CrNr8nrBJ64RM5/TVemUynaCERzHQJwS1UCuOsr8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765502811; c=relaxed/simple;
	bh=1PZkALHj3LLro5RYx+PTyNasPfvty7jBzL/KeXKHtX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZnElopjP1AeywYFGj82Er1kq3cNy7Sc/38n2VrqiY0Aa4OUb5n+mS+CVfURcfcr9V45fv+oPSp/hAPTDjeuyz+PESDFoiuX6QRs9j7+BO0XWeIHRCJjZzskWE12SVSytY9yXFr2dH7XbG+6dU++HanGNRagy2GPsVy86/hsM/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6C+SBFhT; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=prBMLbyd2mt/FcMAKdUEZS7SXQh45bnj3FnaMyVSix0=;
	b=6C+SBFhTjOncm1GRrKZr3oSFsl8o5J9Jmx5aXXU20S0EBs0pOVK535R4wqXwJ9hhqvSXiBk29
	XVPoSDPfX1TNYs796vyPCo4uuyXecT6aU82kd5yDEagcJReophzTYqrl1LFkgl01Sea6jqkzKBa
	qIFsQHKkrONGL0FeH9fHw2I=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dSBYw641QzpT0F;
	Fri, 12 Dec 2025 09:24:04 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A7B7140143;
	Fri, 12 Dec 2025 09:26:39 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Dec 2025 09:26:38 +0800
Message-ID: <77e16fa4-3024-2068-9bb2-82a904eec112@huawei.com>
Date: Fri, 12 Dec 2025 09:26:37 +0800
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
To: Thomas Gleixner <tglx@linutronix.de>, Kevin Brodsky
	<kevin.brodsky@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<oleg@redhat.com>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>, <deller@gmx.de>,
	<macro@orcam.me.uk>, <charlie@rivosinc.com>, <ldv@strace.io>,
	<mark.rutland@arm.com>, <song@kernel.org>, <ryan.roberts@arm.com>,
	<ada.coupriediaz@arm.com>, <anshuman.khandual@arm.com>, <broonie@kernel.org>,
	<pengcan@kylinos.cn>, <dvyukov@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251204082123.2792067-1-ruanjinjie@huawei.com>
 <20251204082123.2792067-16-ruanjinjie@huawei.com>
 <b382cc8a-3ce9-4fb1-bc0a-a3d9796251d1@arm.com> <87345hfqyh.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87345hfqyh.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/12/11 14:55, Thomas Gleixner wrote:
> On Tue, Dec 09 2025 at 14:48, Kevin Brodsky wrote:
>> On 04/12/2025 09:21, Jinjie Ruan wrote:
>>> After switch arm64 to Generic Entry, a new hotspot syscall_exit_work()
>>> appeared because syscall_exit_work() is no longer inlined. so inline
>>
>> Before this series the call to syscall_trace_exit() in el0_svc_common()
>> could not be inlined, so "no longer inlined" doesn't seem to be accurate.
>>
>>> syscall_exit_work(), and it has 2.6% performance uplift on perf bench
>>> basic syscall on kunpeng920 as below.
>>
>> That seems strange. syscall_exit_work() is only called if some flag in
>> SYSCALL_WORK_EXIT is set, which means that we're doing something special
>> like tracing. That shouldn't be the case when running a simple perf
>> bench syscall.
>>
>> Also worth nothing that its counterpart (syscall_trace_enter())) is not
>> currently inlined, the asymmetry would have to be justified.
>>
>>>     | Metric     | W/O this patch | With this patch | Change    |
>>>     | ---------- | -------------- | --------------- | --------- |
>>>     | Total time | 2.171 [sec]    | 2.114 [sec]     |  ↓2.6%    |
>>>     | usecs/op   | 0.217192       | 0.211453        |  ↓2.6%    |
>>>     | ops/sec    | 4,604,225      | 4,729,178       |  ↑2.7%    |
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>  include/linux/entry-common.h  | 63 ++++++++++++++++++++++++++++++++++-
>>>  kernel/entry/syscall-common.c | 59 ++------------------------------
>>
>> These changes are purely generic, surely all architectures using
>> GENERIC_ENTRY should get similar benefits (assuming LTO isn't used)?
> 
> Correct, but as you said this does not make sense as the syscall exit
> work should be rare.
> 
> Jinjie, can you please figure out which TIF bit is causing this to be
> invoked?
> 
> I have a suspicion that it is TIF_NOTIFY_RESUME. If that's the case
> you're seing the RSEQ overhead, which should be completely gone with the
> rewrite that got just merged into Linus tree.

It maybe audit flag, the test is with audit on.

> 
> Thanks,
> 
>         tglx
> 
> 

