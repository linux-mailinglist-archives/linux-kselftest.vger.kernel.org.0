Return-Path: <linux-kselftest+bounces-41650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F248B7CCA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E7448046B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 03:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FAF26CE37;
	Wed, 17 Sep 2025 03:51:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F1266B52;
	Wed, 17 Sep 2025 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081102; cv=none; b=dgVgqK9HJVfD/aHtR7hapGiPa48nmn++Ub12VHptXAH1W45uC2u0RUxyNr+rTEfO4EhotU6gesvSRI/UGKvh1UH/a8Xr4RwVugPDKxy9c9XdaBU8GyLTSNiLUMNAMQbB9T1kqg0njHZvvFpfSJznHayJUbVkuZHDg3dyImVeY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081102; c=relaxed/simple;
	bh=u7c+r//wgKuoq5mfIPiqxIeI+U7gJ7weyS82CWY8jL0=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HPQhl/8EF20cAX30TJL9DqiaiFvSkCo7hHnV6eZmM5lJY5cco0lN/mRvzIXvV1dDBW9OOjw5soLXKmMI64/vjycY+R51jiyjLajy30jaIAjoaqhhl2+8eWll+fEUBWnRrDd+IJbKsmAw9if8Z4qUzdDmu0IeWw1uPvpVEzYyDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cRPqw6FCQz24j6S;
	Wed, 17 Sep 2025 11:48:12 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 032081401F4;
	Wed, 17 Sep 2025 11:51:37 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 11:51:22 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 11:51:21 +0800
CC: <yangyicong@hisilicon.com>, Will Deacon <will@kernel.org>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <shameerali.kolothum.thodi@huawei.com>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <xuwei5@huawei.com>,
	<tangchengchang@huawei.com>, <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v4 5/7] arm64: Add support for FEAT_{LS64, LS64_V}
To: Catalin Marinas <catalin.marinas@arm.com>
References: <20250715081356.12442-1-yangyicong@huawei.com>
 <20250715081356.12442-6-yangyicong@huawei.com>
 <aL7Fgx__LeLfbDyU@willie-the-truck>
 <5d2ba565-715b-9b17-951b-f805dde5988b@huawei.com>
 <aMLvtpaCgRqPAU2Z@willie-the-truck> <20250912144736.00007673@huawei.com>
 <666e3588-2e42-2275-f9ec-94ba0954bdc6@huawei.com> <aMl6u7xTDLhrZmqK@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <0dfe5781-7ca7-7d9f-b099-b20da5e10a1b@huawei.com>
Date: Wed, 17 Sep 2025 11:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aMl6u7xTDLhrZmqK@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/9/16 22:56, Catalin Marinas wrote:
> On Mon, Sep 15, 2025 at 04:29:25PM +0800, Yicong Yang wrote:
>> On 2025/9/12 21:47, Jonathan Cameron wrote:
>>> On Thu, 11 Sep 2025 16:50:14 +0100
>>> Will Deacon <will@kernel.org> wrote:
>>>> On Tue, Sep 09, 2025 at 09:48:04AM +0800, Yicong Yang wrote:
>>>>> per ARM DDI0487 L.b section C3.2.6,
>>>>>
>>>>>   When the instructions access a memory type that is not one of the following,
>>>>>   a data abort for unsupported Exclusive or atomic access is generated...  
>>>>
>>>> That's about the memory _type_. I'm talking about a supported memory type
>>>> (e.g. writeback cacheable) but when the physical location doesn't support
>>>> the instruction. That's captured a little later in the same section:
>>>>
>>>>   | If the target memory location does not support the LD64B or ST64B
>>>>   | instructions, then one of the following behaviors occurs:
>>>>   |  * A stage 1 Data Abort, reported using the DFSC code of 0b110101,
>>>>   |    is generated.
>>>>   |  * The instruction performs the memory accesses, but the accesses
>>>>   |    are not single-copy atomic above the byte level
> 
> Is this a new addition to the L.b release of the ARM ARM? Maybe it was
> there before in some other form (or a different place). At least it
> doesn't say "unpredictable".
> 

i think it's new in L.b. didn't find this is mentioned in K.a either.

>>>> and I think that's a bad interface to expose blindly to userspace solely
>>>> as a boolean hwcap.
>>>
>>> Nasty, so now I'm curious. Any thoughts on how to expose what regions it is appropriate
>>> for?  I can think of various heavy weight options but wondering if there is a simple
>>> solution.
>>
>> in my understanding the hwcap only describes the capabilities of the CPU but not
>> the whole system. the users should make sure the function works as expected if the
>> CPU supports it and they're going to use it. specifically the LS64 is intended for
>> device memory only, so the user should take responsibility of using it on supported
>> memory.
> 
> We have other cases like MTE where we avoid exposing the HWCAP to user
> if we know the memory system does not support MTE, though we intercepted
> this early and asked the (micro)architects to tie the CPU ID field to
> what the system supports.
> 

but we lack the same identification mechanism as CPU for the memory system, so it's just a
restriction for the hardware vendor that if certain feature is not supported for the whole
system (SoC) then do not advertise it in the CPU's ID field. otherwise i think we're currently
doing in the manner that if capability mismatch or cannot work as expected together then a
errata/workaround is used to disable the feature or add some workaround on this certain
platform.

this is also the case for LS64 but a bit more complex, since it involves the completer outside
the SoC (the device) and could be a hotplug one (PCIe). from the SoC part we can restrict to
advertise the feature only if it's fully supported (what we've already done on our hardware).

>> may raise the similar question if use other atomic instructions (e.g. LSE) on the
>> memory does not support atomicity. find this restriction in ARM DDI0487 L.b section B2.2.6
>>
>>   Some system implementations might not support atomic instructions for all regions of the
>>   memory
> 
> With exclusives or atomics, we require that the general purpose (system)
> RAM supports the feature, otherwise Linux won't work properly (I don't
> think we specifically documented this but it would be fairly obvious
> when the kernel doesn't boot or user-space randomly crashes).
> 

yes the spec requires general purpose memory to support atomicity.

  The architecture only requires that Conventional memory that is mapped in this way supports
  this functionality

otherwise users should have knowledge whether the target memory agent support atomicity.

>> and if perform atomic instruction on unsupported memory it's allowed to implement as
>>
>>   * The instruction generates a synchronous External abort.
>>   * The instruction generates a System Error interrupt.
>>   * The instruction generates an IMPLEMENTATION DEFINED MMU fault reported using the Data
>>     Abort Fault status code of ESR_ELx.DFSC = 110101.
>>   * The instruction is treated as a NOP.
>>   * The instructions are performed, but there is no guarantee that the memory accesses were
>>     performed atomically in regard to other agents that access memory. In this case, the
>>     instruction might also generate a System Error interrupt.
>>
>> if instruction performed without generate a SEI in the last implementation, it's quite similar
>> to the condition of LS64.
> 
> The difference is that we don't support Linux on such systems.
> 
> Arguably, the use of LD/ST64B* is fairly specialised and won't be used
> on the general purpose RAM and by random applications. It needs a device
> driver to create the NC/Device mapping and specific programs/libraries
> to access it. I'm not sure the LS64 properties are guaranteed by the
> device alone or the device together with the interconnect. I suspect the
> latter and neither the kernel driver nor user space can tell. In the
> best case, you get a fault and realise the system doesn't work as
> expected. Worse is the non-atomicity with potentially silent corruption.
> 

will be the latter one, both interconnect and the target device need to
support it. but I think the driver developer (kernel driver or userspace
driver) must have knowledge about the support status, otherwise they
should not use it.

for general purpose ram currently we have fault mechenism to avoid ld/st64b
usage (there's maybe an exception if FEAT_LS64WB is supported, which is
introduced in the latest feature list but no spec describe it and allows
perform ld/st64b on memory with write-back attribute. but currently I have
no details about this feature from any public documents)

> So, to Will's point, the HWCAP is not sufficient for user space to make
> an informed decision on whether it can safely use the LS64 instructions.
> Can a (generic) device driver tell or do we need additional information
> in firmware tables to advertise the correct behaviour?
> 

my thoughts is that the driver developer should have known whether their
device support it or not if going to use this. the information in the
firmware table should be fine for platform devices, but cannot describe
information for hotpluggable ones like PCIe endpoint devices which may
not be listed in a firmware table.

thanks.


