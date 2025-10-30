Return-Path: <linux-kselftest+bounces-44385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDEC1E7D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 07:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CCC234C07D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 06:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF6122A4DA;
	Thu, 30 Oct 2025 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dyk0noWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA44213E6A;
	Thu, 30 Oct 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804076; cv=none; b=pzU/i4RZQdjog4rztjeYXTL8Z5SVUQsZhBU0WrLGGOavbuPpD3HUtEFhbsA5O/P+OQea4FyyxZ5MDgU2DNIw/19VLu7K/jX1BRNaBjJpoyW2IvH0Ooug7O217oDqDfJddR1pGcVW11SgguRbdV52EXgM4l8n6D/ZLsC4wlwJwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804076; c=relaxed/simple;
	bh=9e/+tBi0j6rUqTntzoCnyjZDiCpqqm5t7HfJJgf9V6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OI6rd3/iF/AVmOvObuQeD/wsJh7atEynfPr8dFop95Q+dck/JIk592Sj2nBTApoRmCiHhA1YKYrihdUBcZTA1yVYz9YFQf6Aum63evEJ7colyVV7qGSjU2YJJIlYJeP4RoDTaqtGb/X7r8DQtDDp9u/aX9yTUKA1FbZoHQES0SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dyk0noWO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761804074; x=1793340074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9e/+tBi0j6rUqTntzoCnyjZDiCpqqm5t7HfJJgf9V6A=;
  b=Dyk0noWOZjQQcaToOkljkkK/xoDEwjIT05RRW2BsZccaoQIClHjcCMNO
   cBZD+h9I6Iut/jzhNNrA5XY+yCo3dmqmHKASHQrcYYngQO9ugRs8cA8EQ
   wF5K5doCEuwFys3jHDGBGxCXR5ofcJu1v/3JuNH+TBCkNyiD7uFkHbKr0
   ZRTpFFkAbOB9z9XvtlEuhpNBNRTA+jIXRESoaADOfiSfxbQQuU+3KeBbe
   t/MrDBXO5E1Rxcgp4t/MSOx6UIWFHPGGVOYo2Zl+G+AN+coQN81QwlG1z
   EYwzuB9ioJTwIE1j0foaZM1qszjBJs8TdxPmIDNcnEDJYqKFUsxov7j+I
   A==;
X-CSE-ConnectionGUID: SArjKbZJRzia4ege4MWi2g==
X-CSE-MsgGUID: BSqc1R45Q4GCCNWiy2K4wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74536875"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="74536875"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 23:01:13 -0700
X-CSE-ConnectionGUID: b50VYDypSeiSH6znKCDt9A==
X-CSE-MsgGUID: rx1C7SNQQ2SEzNnQLujYaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185121584"
Received: from yinghaoj-desk.ccr.corp.intel.com (HELO [10.238.1.225]) ([10.238.1.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 23:01:08 -0700
Message-ID: <ccb1dcbc-7fc3-46a4-b7d2-571afea9e39d@linux.intel.com>
Date: Thu, 30 Oct 2025 14:01:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/23] KVM: selftests: Setup memory regions for TDX on
 vm creation
To: Ira Weiny <ira.weiny@intel.com>, Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-17-sagis@google.com>
 <6902141659442_20bb411003c@iweiny-mobl.notmuch>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <6902141659442_20bb411003c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/2025 9:18 PM, Ira Weiny wrote:
> Sagi Shahar wrote:
>> Guest registers are inaccessible to kvm for TDX VMs. In order to set
>> register values for TDX we use a special boot code which loads the
> NIT: who is 'we'?
>
>> register values from memory and write them into the appropriate
>> registers.
>>
>> This patch sets up the memory regions used for the boot code and the
>> boot parameters for TDX.
> NIT: This is not needed.  Use imperative mood.
>
>> Signed-off-by: Sagi Shahar <sagis@google.com>
>> ---
>>   tools/testing/selftests/kvm/lib/kvm_util.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index 0e6a487ca7a4..086e8a2a4d99 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -4,6 +4,7 @@
>>    *
>>    * Copyright (C) 2018, Google LLC.
>>    */
>> +#include "tdx/tdx_util.h"
>>   #include "test_util.h"
>>   #include "kvm_util.h"
>>   #include "processor.h"
>> @@ -435,7 +436,7 @@ void kvm_set_files_rlimit(uint32_t nr_vcpus)
>>   static bool is_guest_memfd_required(struct vm_shape shape)
>>   {
>>   #ifdef __x86_64__
>> -	return shape.type == KVM_X86_SNP_VM;
>> +	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
> This caused me to dig a bit to understand why this hunk was needed given
> the commit message only discusses guest registers.  I did not recall any
> use of is_guest_memfd_required() in the vm_tdx_setup_*() calls so I was a
> bit confused.
>
> With this hunk considered the changelog should read something like:
>
> <commit message>
>
> Guest memfd is required for the primary memory region of TDX VMs.
>
> Furthermore, guest registers are inaccessible to kvm for TDX VMs.  TDX
> must use use special boot code which loads the register values from memory
> and writes them into the appropriate registers.
>
> Use guest_memfd for the primary memory regions and call the TDX boot code
> functions for TDX VMs.
>
> </commit message>
>
> This clearly explains why the change to is_guest_memfd_required() is
> needed.

+1

>
> In addition, the structure of this series is a bit odd to me.  I assume
> this patch exists after the setup calls were added to ensure
> bisect-ability?

I think it's better to switch the order of this patch and patch 15.
Patch 15 relies on the memory regions added by this patch for boot code and
parameters.


>
> Ira
>
>>   #else
>>   	return false;
>>   #endif
>> @@ -469,6 +470,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
>>   	for (i = 0; i < NR_MEM_REGIONS; i++)
>>   		vm->memslots[i] = 0;
>>   
>> +	if (is_tdx_vm(vm)) {
>> +		/* Setup additional mem regions for TDX. */
>> +		vm_tdx_setup_boot_code_region(vm);
>> +		vm_tdx_setup_boot_parameters_region(vm, nr_runnable_vcpus);
>> +	}
>> +
>>   	kvm_vm_elf_load(vm, program_invocation_name);
>>   
>>   	/*
>> -- 
>> 2.51.1.851.g4ebd6896fd-goog
>>
>


