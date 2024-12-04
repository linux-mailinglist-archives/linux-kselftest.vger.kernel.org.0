Return-Path: <linux-kselftest+bounces-22817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA609E362F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 10:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62090281C9E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 09:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB021991CD;
	Wed,  4 Dec 2024 09:08:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C519068E;
	Wed,  4 Dec 2024 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303325; cv=none; b=pcZqQRz/GBnRYEyIhSTmAyUVIwl4r9cvHSekYZfWzJN7WRD51TokhyOrlJrMppfrMIi/zlcm22tKNaOP+Nf3QYNOSRr2Ea1EDiQntE1Yv95yJkrN78NWrtvXyMEsMdbu/cbAOATvatJhaZdvGXZk8OISiEbqHfqXRu+ENJLtdBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303325; c=relaxed/simple;
	bh=3wDR+JwJckqEL0sJDsu15c3Itn6za1uHnfyH9Pgd6DA=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fhQ1ReQY+gOv0KSriOEB03uCIJ8cdukWpuXE5xkYKmVY7qWg9n/Zen8jpIeiSIdMab1669RaGDVo53AKFijNbO7MrbPSFSaw+dQ/Zud/SqalrbeKS+uiqsdyxNj/gb2cwKbQ7rXPTfRxttJVILCOmvtq9OUKgNZbjukyZVhgc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y3BTX4DDsz1kvGw;
	Wed,  4 Dec 2024 17:06:24 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 2902D1401F1;
	Wed,  4 Dec 2024 17:08:41 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 4 Dec 2024 17:08:40 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>
Subject: Re: [PATCH 5/5] KVM: arm64: Handle DABT caused by LS64* instructions
 on unsupported memory
To: Marc Zyngier <maz@kernel.org>
References: <20241202135504.14252-1-yangyicong@huawei.com>
 <20241202135504.14252-6-yangyicong@huawei.com> <87o71trtrx.wl-maz@kernel.org>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <357fbc9b-c73e-7494-0c48-27917b95005f@huawei.com>
Date: Wed, 4 Dec 2024 17:08:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87o71trtrx.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/12/3 17:38, Marc Zyngier wrote:
> On Mon, 02 Dec 2024 13:55:04 +0000,
> Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> FEAT_LS64* instructions only support to access Device/Uncacheable
>> memory, otherwise a data abort for unsupported Exclusive or atomic
> 
> Not quite. FEAT_LS64WB explicitly supports Write-Back mappings.

thanks for the information, I didn't know this since it's not listed on DDI0487K.a,
have seen this feature from [1]. will refine the comments and mention the behaviour
applies when no FEAT_LS64WB.

[1] https://developer.arm.com/documentation/109697/2024_09/Feature-descriptions/The-Armv9-6-architecture-extension

> 
>> access (0x35) is generated per spec. It's implementation defined
>> whether the target exception level is routed and is possible to
>> implemented as route to EL2 on a VHE VM. Per DDI0487K.a Section
>> C3.2.12.2 Single-copy atomic 64-byte load/store:
>>
>>   The check is performed against the resulting memory type after all
>>   enabled stages of translation. In this case the fault is reported
>>   at the final enabled stage of translation.
>>
>> If it's implemented as generate the DABT to the final enabled stage
>> (stage-2), inject a DABT to the guest to handle it.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  arch/arm64/kvm/mmu.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index c9d46ad57e52..b7e6f0a27537 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -1787,6 +1787,20 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>>  		return 1;
>>  	}
>>  
>> +	/*
>> +	 * If instructions of FEAT_{LS64, LS64_V, LS64_ACCDATA} operated on
>> +	 * unsupported memory regions, a DABT for unsupported Exclusive or
>> +	 * atomic access is generated. It's implementation defined whether
>> +	 * the exception will be taken to, a stage-1 DABT or the final enabled
>> +	 * stage of translation (stage-2 in this case as we hit here). Inject
>> +	 * a DABT to the guest to handle it if it's implemented as a stage-2
>> +	 * DABT.
>> +	 */
>> +	if (esr_fsc_is_excl_atomic_fault(esr)) {
>> +		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>> +		return 1;
>> +	}
> 
> This doesn't seem quite right. This is injecting an *External* Data
> Abort, which is not what the spec says happens, as you are emulating
> the *first* acceptable behaviour:
> 
>   "The check is performed at each enabled stage of translation, and
>    the fault is reported for the first stage of translation that
>    provides an inappropriate memory type. In this case, the value of
>    the HCR_EL2.DC bit does not cause accesses generated by the
>    instructions to generate a stage 1 Data abort,"
> 
> So while the exception is reported at a different EL, the fault should
> still be an "unsupported Exclusive or atomic access". 

yes it's trying to emulate the first behaviour to let guest OS handle it
as how host OS handle it - send a SIGBUS to the EL0 task if it's performing
on unsupported memory type. Currently if such cases happens the VM will be
killed without the handling here. Keep the injected FSC as "unsupported
Exclusive or atomic access" should be more proper, will make it in next
version.

> But that's also
> assuming that S2 has a device mapping, and it is EL1 that did
> something wrong. Surely you should check the IPA against its memory
> type?

in my case it happens when both S1 and S2 mapping is normal memory, for example
running the hwcap test (PATCH 3/5) in the VM. But yes the memory type should
be checked here.

> 
> Further questions: what happens when a L2 guest triggers such fault?
> I don't think you can't arbitrarily route it back to L2 without
> looking at why it faulted.
> 

will see what affect to the nested VM case. but as you point out, it's
too early to inject the abort here, at least we should check the memory
type. will address it.

Thanks.





