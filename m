Return-Path: <linux-kselftest+bounces-38942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC48FB25CB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 09:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984231C22E0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 07:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F66926563F;
	Thu, 14 Aug 2025 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUVRjhnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67A25A659;
	Thu, 14 Aug 2025 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155139; cv=none; b=OgH6wClEOEaRxav42RjDjg+o0yHvSula8uY8DCJS7SGVMu3ZCaD0INKJYatB2BMtboOH4mrhW7NeGavmNUQx0aIE4nXwUyTpJBS2j5xAurisWj6X8OisrF581eXXJTLpk4mp9HE0W9wpX43rQ00juRX531jEZqLeXkde8RCRrVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155139; c=relaxed/simple;
	bh=KXtijr+I+nto8on/vYSGro/glqW/adtu+zzDmd7P0To=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bBlI1S/lYKNz0Xa2wZ5HXwgrQZsvnlVajsahTpG6dWYcS1vDtJrzTG1eRilk523HTPdQm5nTPNTbtOQwdk/OAl6IRdvkwFxFf7yDadQbOeQ4X8QqECUmr5kKx34FH0FrnvAWDrZalw1Q/E9cxVNXp5doUzXnK2vt/DHums/W4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUVRjhnX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755155137; x=1786691137;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=KXtijr+I+nto8on/vYSGro/glqW/adtu+zzDmd7P0To=;
  b=WUVRjhnXTkmur9SJOxddG4rbertoRUIQa5AB5/zKQxGVk8MY972FSYIe
   VbyoLUhifK2fCtEI47u4Yt8jI8Nswsi0VfYPqXul5ByV/no8v25YhUHuY
   38O12S22tf4F+g6cc5bG5xqQj/FR6FaRmVtqfBE5+EzcVhqs1yWn3Jm8K
   Ui/L7XFiF+vfK9dRBiYWF5iSOR18xl9KW4CyqRF3XyBUVO2LMkFFMQOAl
   jL8k4EpHcLYe+Ws613fPdrb5wxug6mptu+4LiaktDhv0cmBM8EmZ59GYY
   JWgsyUh7KfJWEo9d0kgzqIKWjx6E3gZvp64xA71y8DUp0pSWZJRFrr+mF
   w==;
X-CSE-ConnectionGUID: wUzauBo6Q4KPgaOyJ7utfA==
X-CSE-MsgGUID: Xa0w9SKEQB+p8/yjnC3ZcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="80040380"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="80040380"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 00:05:37 -0700
X-CSE-ConnectionGUID: hee8cGoQTVqaZ6GC6+sPXw==
X-CSE-MsgGUID: WlQoPe84Q4y0NiHDRz3qlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="197542278"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 00:05:33 -0700
Message-ID: <c359e0d3-b840-4e98-b06d-94b4e3f7f792@linux.intel.com>
Date: Thu, 14 Aug 2025 15:05:30 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/30] KVM: selftests: TDX: Add report_fatal_error test
From: Binbin Wu <binbin.wu@linux.intel.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny
 <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250807201628.1185915-1-sagis@google.com>
 <20250807201628.1185915-11-sagis@google.com>
 <ef499c6e-d62c-450e-982b-82c53054ea53@linux.intel.com>
Content-Language: en-US
In-Reply-To: <ef499c6e-d62c-450e-982b-82c53054ea53@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/2025 6:58 PM, Binbin Wu wrote:
>
>
> On 8/8/2025 4:16 AM, Sagi Shahar wrote:
>> The test checks report_fatal_error functionality.
>>
>> TD guest can use TDG.VP.VMCALL<ReportFatalError> to report the fatal error
>> it has experienced. TD guest is requesting a termination with the error
>> information that include 16 general-purpose registers.
>
> I think it's worth to mention that KVM converts TDG.VP.VMCALL<ReportFatalError>
> to KVM_EXIT_SYSTEM_EVENT with the type KVM_SYSTEM_EVENT_TDX_FATAL.
>
>>
>> Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Signed-off-by: Sagi Shahar <sagis@google.com>
>> ---
>>   .../selftests/kvm/include/x86/tdx/tdx.h       |  6 ++-
>>   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  1 +
>>   .../selftests/kvm/include/x86/tdx/test_util.h | 19 +++++++
>>   tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 18 +++++++
>>   .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  6 +++
>>   .../selftests/kvm/lib/x86/tdx/test_util.c     | 10 ++++
>>   tools/testing/selftests/kvm/x86/tdx_vm_test.c | 51 ++++++++++++++++++-
>>   7 files changed, 108 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
>> index a7161efe4ee2..2acccc9dccf9 100644
>> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
>> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
>> @@ -4,9 +4,13 @@
>>     #include <stdint.h>
>>   +#include "kvm_util.h"
>> +
>> +#define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
>> +
>>   #define TDG_VP_VMCALL_INSTRUCTION_IO 30
>>     uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>>                         uint64_t write, uint64_t *data);
>> -
>> +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
>>   #endif // SELFTEST_TDX_TDX_H
>> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
>> index 57a2f5893ffe..d66cf17f03ea 100644
>> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
>> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
>> @@ -15,5 +15,6 @@ struct kvm_vm *td_create(void);
>>   void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>>              uint64_t attributes);
>>   void td_finalize(struct kvm_vm *vm);
>> +void td_vcpu_run(struct kvm_vcpu *vcpu);
>>     #endif // SELFTESTS_TDX_KVM_UTIL_H
>> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
>> index 07d63bf1ffe1..dafeee9af1dc 100644
>> --- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
>> +++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
>> @@ -38,4 +38,23 @@ bool is_tdx_enabled(void);
>>   void tdx_test_success(void);
>>   void tdx_test_assert_success(struct kvm_vcpu *vcpu);
>>   +/*
>> + * Report an error with @error_code to userspace.
>> + *
>> + * Return value from tdg_vp_vmcall_report_fatal_error() is ignored since
>> + * execution is not expected to continue beyond this point.
>> + */
>> +void tdx_test_fatal(uint64_t error_code);

Another thing to mention is that tdx_test_fatal() and tdx_test_fatal_with_data()
use R12 to pass the input error_code, which is functionally workable, since both
guest and userspace code are in KVM selftest test code.

But TDX GHCI spec has its own format for R12:
- 31:0
   TD-specific error code
   * Panic – 0x0.
   * Values – 0x1 to 0xFFFFFFFF reserved.
- 62:32
   TD-specific extended error code.
   TD software defined.
- 63
   Set if the TD specified additional information in the GPA parameter (R13).
So, this patch series doesn't follow the format.

Also, tdx_test_fatal_with_data() set bit 63 of R12, so, the value reported to
userspace will be different in R12 from the original parameter passed by the
guest, and setting bit 63 could collide with the error code defined by guest.

IMHO, it's better to follow the GHCI spec.
But if TDX KVM selftest code doesn't want to follow it, then it should not set
bit 63 for tdx_test_fatal_with_data() in R12.

>>
>> +
>> +/*
>> + * Report an error with @error_code to userspace.
>> + *
>> + * @data_gpa may point to an optional shared guest memory holding the error
>> + * string.
>
> A according to the GHCI spec, this is the optional GPA pointing to a shared guest memory, but in these TDX KVM selftest cases, it may not used that way. It may need some clarification about it. And based on the usage in this patch series, the name data_gpa may be misleading.
>
>
>> + *
>> + * Return value from tdg_vp_vmcall_report_fatal_error() is ignored since
>> + * execution is not expected to continue beyond this point.
>> + */
>> +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
>> + 
[...]

