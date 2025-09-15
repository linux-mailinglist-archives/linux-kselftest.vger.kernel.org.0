Return-Path: <linux-kselftest+bounces-41463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A41B572DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 10:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C49C179475
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360012ECD34;
	Mon, 15 Sep 2025 08:29:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F52EBBB9;
	Mon, 15 Sep 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924973; cv=none; b=WHD6d0aWqfbZsmYd7uw2EapBjBpDvdXv2ln6I7hC/eOD9jr/KTmyfSdmu+1X8iq8QuYadH+9Mh+kK9JSmOdVPE2NphvZRoj2wWGrVM1mV6P3nEAqiwQCbqj0eJtAdIivM53cH1CSJvHNoQiJQHM/NM5JO/lxaEul3HYKeKzRvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924973; c=relaxed/simple;
	bh=AM0IbrbasXdUbw78EhhSKGCuGd0Z3zFtSdCsCjeG3Kc=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nZcymlpLPt2UdTFx+cc2Y4WdZRyiS49i7fphIf9FO1+9Srv4WNHPOCi1eO4JfyQBAgLZASxwMDH3hSo48fbUPFBNHrTMiAIz29eNRWe1+qukGoS5pRE6F6M+rqHi4xMZO0xyn5xF5u8CAlmeUUwsvOdb9VX0krLB0r/hisYwI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cQJ5S3xCKz2VRmg;
	Mon, 15 Sep 2025 16:26:04 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id CA5B81402A5;
	Mon, 15 Sep 2025 16:29:26 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Sep 2025 16:29:26 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Sep 2025 16:29:25 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <shameerali.kolothum.thodi@huawei.com>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <xuwei5@huawei.com>,
	<tangchengchang@huawei.com>, <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v4 5/7] arm64: Add support for FEAT_{LS64, LS64_V}
To: Will Deacon <will@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
References: <20250715081356.12442-1-yangyicong@huawei.com>
 <20250715081356.12442-6-yangyicong@huawei.com>
 <aL7Fgx__LeLfbDyU@willie-the-truck>
 <5d2ba565-715b-9b17-951b-f805dde5988b@huawei.com>
 <aMLvtpaCgRqPAU2Z@willie-the-truck> <20250912144736.00007673@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <666e3588-2e42-2275-f9ec-94ba0954bdc6@huawei.com>
Date: Mon, 15 Sep 2025 16:29:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250912144736.00007673@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/9/12 21:47, Jonathan Cameron wrote:
> On Thu, 11 Sep 2025 16:50:14 +0100
> Will Deacon <will@kernel.org> wrote:
> 
>> On Tue, Sep 09, 2025 at 09:48:04AM +0800, Yicong Yang wrote:
>>> On 2025/9/8 20:01, Will Deacon wrote:  
>>>> On Tue, Jul 15, 2025 at 04:13:54PM +0800, Yicong Yang wrote:  
>>>>> diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
>>>>> index 69d7afe56853..9e6db258ff48 100644
>>>>> --- a/Documentation/arch/arm64/elf_hwcaps.rst
>>>>> +++ b/Documentation/arch/arm64/elf_hwcaps.rst
>>>>> @@ -435,6 +435,12 @@ HWCAP2_SME_SF8DP4
>>>>>  HWCAP2_POE
>>>>>      Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
>>>>>  
>>>>> +HWCAP3_LS64
>>>>> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0001.
>>>>> +
>>>>> +HWCAP3_LS64_V
>>>>> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0010.  
>>>>
>>>> Given that these instructions only work on IMPLEMENTATION DEFINED memory
>>>> locations and aren't guaranteed to generate an abort if used elsewhere,
>>>> how is userspace supposed to know what to do with them?
>>>>   
>>>
>>> per ARM DDI0487 L.b section C3.2.6,
>>>
>>>   When the instructions access a memory type that is not one of the following,
>>>   a data abort for unsupported Exclusive or atomic access is generated...  
>>
>> That's about the memory _type_. I'm talking about a supported memory type
>> (e.g. writeback cacheable) but when the physical location doesn't support
>> the instruction. That's captured a little later in the same section:
>>
>>   | If the target memory location does not support the LD64B or ST64B
>>   | instructions, then one of the following behaviors occurs:
>>   |  * A stage 1 Data Abort, reported using the DFSC code of 0b110101,
>>   |    is generated.
>>   |  * The instruction performs the memory accesses, but the accesses
>>   |    are not single-copy atomic above the byte level
>>
>> and I think that's a bad interface to expose blindly to userspace solely
>> as a boolean hwcap.
> Hi Will,
> 
> Nasty, so now I'm curious. Any thoughts on how to expose what regions it is appropriate
> for?  I can think of various heavy weight options but wondering if there is a simple
> solution.
> 

in my understanding the hwcap only describes the capabilities of the CPU but not
the whole system. the users should make sure the function works as expected if the
CPU supports it and they're going to use it. specifically the LS64 is intended for
device memory only, so the user should take responsibility of using it on supported
memory.

may raise the similar question if use other atomic instructions (e.g. LSE) on the
memory does not support atomicity. find this restriction in ARM DDI0487 L.b section B2.2.6

  Some system implementations might not support atomic instructions for all regions of the
  memory

and if perform atomic instruction on unsupported memory it's allowed to implement as

  * The instruction generates a synchronous External abort.
  * The instruction generates a System Error interrupt.
  * The instruction generates an IMPLEMENTATION DEFINED MMU fault reported using the Data
    Abort Fault status code of ESR_ELx.DFSC = 110101.
  * The instruction is treated as a NOP.
  * The instructions are performed, but there is no guarantee that the memory accesses were
    performed atomically in regard to other agents that access memory. In this case, the
    instruction might also generate a System Error interrupt.

if instruction performed without generate a SEI in the last implementation, it's quite similar
to the condition of LS64.

thanks.

