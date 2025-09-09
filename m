Return-Path: <linux-kselftest+bounces-41008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E099BB49ED9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 03:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB561BC384A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 01:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C0230D14;
	Tue,  9 Sep 2025 01:48:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB202236FA;
	Tue,  9 Sep 2025 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382493; cv=none; b=SjT2QsitlDR3/jWqNzSPSkMRqXOS5BHKF4lv1Vqiajm3//DpdwnD+H2rFesYqvInDeK6lMetprP+Vmhbua8fnu1Mbp1g1E1DavXydKikDKxSH488oXqk8oSLC3q+pbGelRHoK+tNStxw2pAI5YLeLpOvPjHEfssfRivgH9pSCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382493; c=relaxed/simple;
	bh=is2pUEHEiZMQU1R2ZtXgqvP+1teelQQSyxe1k0SHyzk=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RsxHqscZ/XmDeI/zu85IWWZQDjR9coDm1a8+ZkQ9PzG2En+DUZbn3hR5EWPihp1TSPPqSkL/XdrdO0uuG7EKaZS9YTRZQ6bDzPIMQvbp+MVNpC+0pCX2KdD9YTQXiE0JDG6dkW8OFHLMZKFSbM2zADGpM3kXXwBvoQUYQNTpT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cLRRj1mY3zRk4L;
	Tue,  9 Sep 2025 09:43:29 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AAE7180087;
	Tue,  9 Sep 2025 09:48:06 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 09:48:05 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 09:48:04 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <tangchengchang@huawei.com>,
	<wangzhou1@hisilicon.com>
Subject: Re: [PATCH v4 5/7] arm64: Add support for FEAT_{LS64, LS64_V}
To: Will Deacon <will@kernel.org>
References: <20250715081356.12442-1-yangyicong@huawei.com>
 <20250715081356.12442-6-yangyicong@huawei.com>
 <aL7Fgx__LeLfbDyU@willie-the-truck>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <5d2ba565-715b-9b17-951b-f805dde5988b@huawei.com>
Date: Tue, 9 Sep 2025 09:48:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aL7Fgx__LeLfbDyU@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/9/8 20:01, Will Deacon wrote:
> On Tue, Jul 15, 2025 at 04:13:54PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Armv8.7 introduces single-copy atomic 64-byte loads and stores
>> instructions and its variants named under FEAT_{LS64, LS64_V}.
>> These features are identified by ID_AA64ISAR1_EL1.LS64 and the
>> use of such instructions in userspace (EL0) can be trapped. In
>> order to support the use of corresponding instructions in userspace:
>> - Make ID_AA64ISAR1_EL1.LS64 visbile to userspace
>> - Add identifying and enabling in the cpufeature list
>> - Expose these support of these features to userspace through HWCAP3
>>   and cpuinfo
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  Documentation/arch/arm64/booting.rst    | 12 ++++++
>>  Documentation/arch/arm64/elf_hwcaps.rst |  6 +++
>>  arch/arm64/include/asm/hwcap.h          |  2 +
>>  arch/arm64/include/uapi/asm/hwcap.h     |  2 +
>>  arch/arm64/kernel/cpufeature.c          | 51 +++++++++++++++++++++++++
>>  arch/arm64/kernel/cpuinfo.c             |  2 +
>>  arch/arm64/tools/cpucaps                |  2 +
>>  7 files changed, 77 insertions(+)
>>
>> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
>> index ee9b790c0d72..837823d49212 100644
>> --- a/Documentation/arch/arm64/booting.rst
>> +++ b/Documentation/arch/arm64/booting.rst
>> @@ -483,6 +483,18 @@ Before jumping into the kernel, the following conditions must be met:
>>  
>>     - MDCR_EL3.TPM (bit 6) must be initialized to 0b0
>>  
>> +  For CPUs support for 64-byte loads and stores without status (FEAT_LS64):
> 
> nit: I think you're missing a word ("For CPUs with support ...").
> 
>> +
>> +  - If the kernel is entered at EL1 and EL2 is present:
>> +
>> +    - HCRX_EL2.EnALS (bit 1) must be initialised to 0b1.
>> +
>> +  For CPUs support for 64-byte loads and stores with status (FEAT_LS64_V):
> 
> Same here, but also FEAT_LS64_V only applies to stores so no need to
> mention loads.
> 
>> +
>> +  - If the kernel is entered at EL1 and EL2 is present:
>> +
>> +    - HCRX_EL2.EnASR (bit 2) must be initialised to 0b1.
>> +
>>  The requirements described above for CPU mode, caches, MMUs, architected
>>  timers, coherency and system registers apply to all CPUs.  All CPUs must
>>  enter the kernel in the same exception level.  Where the values documented
>> diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
>> index 69d7afe56853..9e6db258ff48 100644
>> --- a/Documentation/arch/arm64/elf_hwcaps.rst
>> +++ b/Documentation/arch/arm64/elf_hwcaps.rst
>> @@ -435,6 +435,12 @@ HWCAP2_SME_SF8DP4
>>  HWCAP2_POE
>>      Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
>>  
>> +HWCAP3_LS64
>> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0001.
>> +
>> +HWCAP3_LS64_V
>> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0010.
> 
> Given that these instructions only work on IMPLEMENTATION DEFINED memory
> locations and aren't guaranteed to generate an abort if used elsewhere,
> how is userspace supposed to know what to do with them?
> 

per ARM DDI0487 L.b section C3.2.6,

  When the instructions access a memory type that is not one of the following,
  a data abort for unsupported Exclusive or atomic access is generated...

so...

> As it stands, exposing the feature blindly feels like a bad idea to me.
> Surely there needs to be a way for userspace to either probe or request
> memory that supports the instructions? We should also make sure we
> handle the abort properly if it occurs and presumably deliver a SIGBUS.
> 

...on host accessing an unsupported memory region a SIGBUS will be delivered,
selftests for the instruction added in PATCH 7/7 make use of this, comments
added in ls64_sigill() explained there will be a SIGBUS recieved if accessing
the normal memory.

if in a VM the DABT will be taken by the guestOS (then handled in the same
way like host, deliver a SIGBUS by the guestOS) or by the hypervisor depend
on the hardware implementation. for the latter case PATCH 3/7 add the handling
to inject the DABT back to the VM.

as for the usage, since LS64 is intended to interact with the device, currently
we only use it in userspace drviers, as mentioned in the coverletter:

  A real scenario for this feature is that the userspace driver can make use of
  this to implement direct WQE (workqueue entry) - a mechanism to fill WQE
  directly into the hardware.

the userspace driver will know exactly whether their devices support LS64 or not
and request the target memory.

thanks.

