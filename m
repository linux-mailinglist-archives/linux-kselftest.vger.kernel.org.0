Return-Path: <linux-kselftest+bounces-47352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0FCB1C2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 03:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E868930080E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 02:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C8B225409;
	Wed, 10 Dec 2025 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UF5ocA7x";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UF5ocA7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CB14F9D6;
	Wed, 10 Dec 2025 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765335433; cv=none; b=ONWVNrV4E1pcu3FrV+9Q50djtjaMscAB7yO3r9RXDvA/FAyFRmOUhjSvEWvuk8R4bSe1K38zFapPF2hpxPg/2zUS2z6GVG/5dNwSUhanpV7GErPICTNJkqvzPbE9mYibgIgVZX9Q/9O2hqlOUlzGUfOu9lUea62p1fnx9/ZzOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765335433; c=relaxed/simple;
	bh=7m01CPyoeViz6pIdG5hXSEjykElVTEe/TyNdLPtOx9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Iw07q4ehok1Qi56vFRY6rplN/a0UmOKytfRKtQHUz3mLDw6sJPjvb94zkbkSAGfLOjNadtQ3h1YgNTJS651u6FkHhPcV+IUvtQGLqBFpIX4JcHXZIxA6XfdCQFNYyQZIeAVfukpi6wwISDTShkr42Lm/4WTNGvwHix4SMQWkaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UF5ocA7x; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UF5ocA7x; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kHGQxXud0RlcL7IpHDIbVN/X32saQFfy4JvgH1aEGzU=;
	b=UF5ocA7xKojVjMCJX9X7yvttQfUBxknqB2GtiVOUWKX+DVfTk3aRc09+2hAmyPsw4jWLS/GAW
	qs5Mib4O1Tr77+cs4cmkurD3UGPXqSwXxDqiYYgknE4cNLZMvEtgl4foR6sojBCzSXLxEVFZbfe
	b8jwIWJ7upumvXbfTcqGH7U=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dR0k15zwdz1BFnW;
	Wed, 10 Dec 2025 10:56:57 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kHGQxXud0RlcL7IpHDIbVN/X32saQFfy4JvgH1aEGzU=;
	b=UF5ocA7xKojVjMCJX9X7yvttQfUBxknqB2GtiVOUWKX+DVfTk3aRc09+2hAmyPsw4jWLS/GAW
	qs5Mib4O1Tr77+cs4cmkurD3UGPXqSwXxDqiYYgknE4cNLZMvEtgl4foR6sojBCzSXLxEVFZbfe
	b8jwIWJ7upumvXbfTcqGH7U=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dR0gm5kPKz1prKr;
	Wed, 10 Dec 2025 10:55:00 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 60D1014022E;
	Wed, 10 Dec 2025 10:56:58 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Dec 2025 10:56:57 +0800
Message-ID: <132ceb8f-e82d-bed7-7b93-41f5dd505a03@huawei.com>
Date: Wed, 10 Dec 2025 10:56:56 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9 14/16] arm64: Inline el0_svc_common()
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
 <20251204082123.2792067-15-ruanjinjie@huawei.com>
 <746211f0-74b7-4935-a036-48a00bb5701b@arm.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <746211f0-74b7-4935-a036-48a00bb5701b@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/12/9 21:48, Kevin Brodsky wrote:
> On 04/12/2025 09:21, Jinjie Ruan wrote:
>> After switch arm64 to Generic Entry, the compiler no longer inlines
> 
> Did it inline it before this series?

Yes, as below

<do_el0_svc>:
       d503201f        nop
       d503201f        nop
       d503233f        paciasp
       a9be7bfd        stp     x29, x30, [sp, #-32]!
       910003fd        mov     x29, sp
       a90153f3        stp     x19, x20, [sp, #16]
       aa0003f3        mov     x19, x0
       d5384114        mrs     x20, sp_el0
       f9400001        ldr     x1, [x0]
       f9400282        ldr     x2, [x20]
       f9008801        str     x1, [x0, #272]
       f9402001        ldr     x1, [x0, #64]
       b9011801        str     w1, [x0, #280]
       373001e2        tbnz    w2, #6, ffff80008002c0f0 <do_el0_svc+0x70>
       f278105f        tst     x2, #0x1f00
       54000261        b.ne    ffff80008002c108 <do_el0_svc+0x88>  // b.any
       52803ac2        mov     w2, #0x1d6                      // #470
       97ffffb1        bl      ffff80008002bf88 <invoke_syscall.constprop.0>
       f9400280        ldr     x0, [x20]
       92783400        and     x0, x0, #0x3fff00
       926bdc00        and     x0, x0, #0xffffffffffe01fff
       b4000060        cbz     x0, ffff80008002c0e0 <do_el0_svc+0x60>
       aa1303e0        mov     x0, x19
       97ffc835        bl      ffff80008001e1b0 <syscall_trace_exit>
       a94153f3        ldp     x19, x20, [sp, #16]
       a8c27bfd        ldp     x29, x30, [sp], #32
       d50323bf        autiasp
       d65f03c0        ret
       92804000        mov     x0, #0xfffffffffffffdff         // #-513
       f9000260        str     x0, [x19]
       a94153f3        ldp     x19, x20, [sp, #16]
       a8c27bfd        ldp     x29, x30, [sp], #32
       d50323bf        autiasp
       d65f03c0        ret
       3100043f        cmn     w1, #0x1
       54000140        b.eq    ffff80008002c134 <do_el0_svc+0xb4>  // b.none
       aa1303e0        mov     x0, x19
       97ffc7c1        bl      ffff80008001e018 <syscall_trace_enter>
       2a0003e1        mov     w1, w0
       3100041f        cmn     w0, #0x1
       54fffdc0        b.eq    ffff80008002c0d8 <do_el0_svc+0x58>  // b.none
       aa1303e0        mov     x0, x19
       52803ac2        mov     w2, #0x1d6                      // #470
       97ffff97        bl      ffff80008002bf88 <invoke_syscall.constprop.0>
       17ffffea        b       ffff80008002c0d8 <do_el0_svc+0x58>
       928004a0        mov     x0, #0xffffffffffffffda         // #-38
       f9000260        str     x0, [x19]
       17fffff5        b       ffff80008002c110 <do_el0_svc+0x90>
       d53cd044        mrs     x4, tpidr_el2
       d53cd040        mrs     x0, tpidr_el2
       d53cd041        mrs     x1, tpidr_el2
       00000000        udf     #0
       d503201f        nop
       d503201f        nop

> 
>> el0_svc_common() into do_el0_svc(). So inline el0_svc_common() and it
>> has 1% performance uplift on perf bench basic syscall on kunpeng920
>> as below.
>>
>> | Metric     | W/O this patch | With this patch | Change    |
>> | ---------- | -------------- | --------------- | --------- |
>> | Total time | 2.195 [sec]    | 2.171 [sec]     |  ↓1.1%   |
>> | usecs/op   | 0.219575       | 0.217192        |  ↓1.1%   |
>> | ops/sec    | 4,554,260      | 4,604,225       |  ↑1.1%    |
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> I think this is sensible - do_el0_svc() is clearly hot and the small
> increase in code size is completely justified. It also removes a
> performance regression when enabling CONFIG_COMPAT (without it
> el0_svc_common() has only one caller so it should be inlined regardless).
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> 
>> ---
>>  arch/arm64/kernel/syscall.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
>> index 47e193a1cfff..5aa51da9ec25 100644
>> --- a/arch/arm64/kernel/syscall.c
>> +++ b/arch/arm64/kernel/syscall.c
>> @@ -66,8 +66,8 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>>  	choose_random_kstack_offset(get_random_u16());
>>  }
>>  
>> -static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>> -			   const syscall_fn_t syscall_table[])
>> +static __always_inline void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>> +					   const syscall_fn_t syscall_table[])
>>  {
>>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>>  	unsigned long flags = read_thread_flags();
> 

