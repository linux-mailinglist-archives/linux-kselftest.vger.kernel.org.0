Return-Path: <linux-kselftest+bounces-22818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95619E3648
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 10:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F80F28197D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0EA19AA5A;
	Wed,  4 Dec 2024 09:13:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90952500C8;
	Wed,  4 Dec 2024 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303603; cv=none; b=LGu6e2cYa49eYO6i+Mm+sQCYT0wwdlfef+Wu68XABzsfNVtnQMndt1nSS0so3XLfHQJN//DTijbdFHN4aoZ0JXcNdyaLiwYpljMIBEIqjKZ1/sy05iEy4gw45uJI1dOugz8aCUO0z/msFYWS5oEmo+CSYpcblTDoTP9nNusel30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303603; c=relaxed/simple;
	bh=zYO/xyDtk4VQN0o/3Yb4A/WNB5aOzL+U3cJO4IeI3v8=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ib3t6ghQm2e+Gt9kWeHRrd6XVPlBHy1IHBRYoIMte9JsmzWF2iEzfUzHfTJlpSoUnex9YIaI1l39V+YHcwYGdMzb+dxxfQb6J55ovHkr0eCbsE0OayLog8M3iwAkPNK9NC/vlZJ6FPOqmtKjsJFDvW3xlW/rFgxxMLfgJ/0WNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y3BYz2SB5z11Ls8;
	Wed,  4 Dec 2024 17:10:15 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C2F5180104;
	Wed,  4 Dec 2024 17:13:12 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 4 Dec 2024 17:13:11 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>
Subject: Re: [PATCH 2/5] arm64: Add support for FEAT_{LS64, LS64_V,
 LS64_ACCDATA}
To: Marc Zyngier <maz@kernel.org>
References: <20241202135504.14252-1-yangyicong@huawei.com>
 <20241202135504.14252-3-yangyicong@huawei.com> <87mshdrtrr.wl-maz@kernel.org>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <01b65d7a-19ae-d26a-845c-4b47c82bd6e8@huawei.com>
Date: Wed, 4 Dec 2024 17:13:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87mshdrtrr.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/12/3 17:38, Marc Zyngier wrote:
> On Mon, 02 Dec 2024 13:55:01 +0000,
> Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Armv8.7 introduces single-copy atomic 64-byte loads and stores
>> instructions and its variants named under FEAT_{LS64, LS64_V,
>> LS64_ACCDATA}. These features are identified by ID_AA64ISAR1_EL1.LS64
>> and the use of such instructions in userspace (EL0) can be trapped.
>> In order to support the use of corresponding instructions in userspace:
>> - Make ID_AA64ISAR1_EL1.LS64 visbile to userspace
>> - Add identifying and enabling in the cpufeature list
>> - Expose these support of these features to userspace through HWCAP
>>   and cpuinfo
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  Documentation/arch/arm64/booting.rst    | 28 ++++++++++
>>  Documentation/arch/arm64/elf_hwcaps.rst |  9 ++++
>>  arch/arm64/include/asm/hwcap.h          |  3 ++
>>  arch/arm64/include/uapi/asm/hwcap.h     |  3 ++
>>  arch/arm64/kernel/cpufeature.c          | 70 ++++++++++++++++++++++++-
>>  arch/arm64/kernel/cpuinfo.c             |  3 ++
>>  arch/arm64/tools/cpucaps                |  3 ++
>>  7 files changed, 118 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
>> index 3278fb4bf219..c35cfe9da501 100644
>> --- a/Documentation/arch/arm64/booting.rst
>> +++ b/Documentation/arch/arm64/booting.rst
>> @@ -449,6 +449,34 @@ Before jumping into the kernel, the following conditions must be met:
>>  
>>      - HFGWTR_EL2.nGCS_EL0 (bit 52) must be initialised to 0b1.
>>  
>> +  For CPUs support for 64-byte loads and stores without status (FEAT_LS64):
>> +
>> +  - If the kernel is entered at EL1 and EL2 is present:
>> +
>> +    - HCRX_EL2.EnALS (bit 1) must be initialised to 0b1.
>> +
>> +  For CPUs support for 64-byte loads and stores with status (FEAT_LS64_V):
>> +
>> +  - If the kernel is entered at EL1 and EL2 is present:
>> +
>> +    - HCRX_EL2.EnASR (bit 2) must be initialised to 0b1.
>> +
>> +  For CPUs support for 64-byte EL0 stores with status (FEAT_LS64_ACCDATA):
>> +
>> +  - If EL3 is present:
>> +
>> +    - SCR_EL3.EnAS0 (bit 36) must be initialised to 0b1.
>> +
>> +    - SCR_EL3.ADEn (bit 37) must be initialised to 0b1.
>> +
>> +  - If the kernel is entered at EL1 and EL2 is present:
>> +
>> +    - HCRX_EL2.EnAS0 (bit 0) must be initialised to 0b1.
>> +
>> +    - HFGRTR_EL2.nACCDATA_EL1 (bit 50) must be initialised to 0b1.
>> +
>> +    - HFGWTR_EL2.nACCDATA_EL1 (bit 50) must be initialised to 0b1.
>> +
>>  The requirements described above for CPU mode, caches, MMUs, architected
>>  timers, coherency and system registers apply to all CPUs.  All CPUs must
>>  enter the kernel in the same exception level.  Where the values documented
>> diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
>> index 2ff922a406ad..6cb2594f0803 100644
>> --- a/Documentation/arch/arm64/elf_hwcaps.rst
>> +++ b/Documentation/arch/arm64/elf_hwcaps.rst
>> @@ -372,6 +372,15 @@ HWCAP2_SME_SF8DP4
>>  HWCAP2_POE
>>      Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
>>  
>> +HWCAP3_LS64
>> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0001.
>> +
>> +HWCAP3_LS64_V
>> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0010.
>> +
>> +HWCAP3_LS64_ACCDATA
>> +    Functionality implied by ID_AA64ISAR1_EL1.LS64 == 0b0011.
>> +
> 
> I don't mind the two others, but I seriously question exposing ST64BV0
> to userspace. How is ACCDATA_EL1 populated? How is it context-switched?
> 
> As it stands, this either does the wrong thing by always having the
> low 32bit set to an UNKNOWN value, or actively leaks kernel data.
> TBH, I don't see it being usable in practice (the more I read this
> part of the architecture, the more broken it looks).
> 

you're right, expose this LS64_ACCDATA alone to userspace won't make it
usable since ACCDATA_EL1 cannot be accessed from EL0. will drop this at
this stage.

Thanks.


