Return-Path: <linux-kselftest+bounces-38933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 201ACB25BA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 08:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61F31C83324
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 06:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEAA23771E;
	Thu, 14 Aug 2025 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwEXh/TL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4062248BE;
	Thu, 14 Aug 2025 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151901; cv=none; b=H6St1MytiRBbae/7GiCcdrCmiZYfIPDeZP/QyS+rOrIiJv1fM6oAWKt87sdfaBRVPNjS6AymXct2xibRPV3JIj5iQnRXD4ZpDfPuR2GMtlcKMz6LHHWqvooFUYz9r/HDXXIEUkgJ+D2USRKYDlERVi6hC/NKd2ZN/x6V4d37+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151901; c=relaxed/simple;
	bh=BF1TnPcozmE6Bo2LDvBLR0nFm5oCeCzAcZkzuJ1oQd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8xXjohJWeyK8nHqwOqaVEZM89Q2k2nnuBikS08mu2gex9XAzaPKUJhjAzBYew93KkQXikah4L3OQFe2E1cAIuK9cdfC4ZlZhjbD7GxPOQ8TvHfhCV0a35SeyPEbS9Y9tUZ9X0OMHm5EQMBWjuNSNPU5/Hit98DPaVYV4q8230Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwEXh/TL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755151900; x=1786687900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BF1TnPcozmE6Bo2LDvBLR0nFm5oCeCzAcZkzuJ1oQd8=;
  b=TwEXh/TLtEvsGnIulS++01IHLdeoOvGsjUnb0eEXAhq7IyhscdeM392x
   Q5MpVVfsdj+aJ9roUuQaxA1bJLPEi6oyfxMVpZ3sIcux6BOC6CV2FXQuC
   8h3kCWc0ce7i1aSd9QW2sLBmtHVujaocxc9lH6lG9JKCTI5xLUR0V5ahG
   q8YXBXn/Gh1k+GUC5yPx/zB+UDtCIj2ET84CBmu4qhbMRiLNC2S93dNFM
   yf2s3LmPgkke5hAbO6RiGtlM2Stm9JYO58MdjsXvdCKwFesyMNBkSihnQ
   4VdTFT/AlShJs0oKinIwvzEi+tmg1omAP8vDsXpEarchTOlTdUc2dopNZ
   g==;
X-CSE-ConnectionGUID: ggQotbS2S9qj97/jUglrnA==
X-CSE-MsgGUID: is38EfEzSPiSNIdG2eo8wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="80036607"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="80036607"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 23:11:37 -0700
X-CSE-ConnectionGUID: vsKjiMWBSeG/MvaG3SSymg==
X-CSE-MsgGUID: IEbkUBcUSNu3DuYs05T+tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="190380993"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 23:11:29 -0700
Message-ID: <7fe79fb3-d54d-43ea-9dc2-879909434fdd@linux.intel.com>
Date: Thu, 14 Aug 2025 14:11:27 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/30] KVM: selftests: TDX: Add basic TDX CPUID test
To: Chenyi Qiang <chenyi.qiang@intel.com>, Sagi Shahar <sagis@google.com>
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
 <20250807201628.1185915-13-sagis@google.com>
 <4fa12f71-74df-4d62-9844-60125b85f677@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <4fa12f71-74df-4d62-9844-60125b85f677@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/2025 11:20 AM, Chenyi Qiang wrote:
>
> On 8/8/2025 4:16 AM, Sagi Shahar wrote:
>> The test reads CPUID values from inside a TD VM and compare them

compare -> compares


>> to expected values.
>>
>> The test targets CPUID values which are virtualized as "As Configured",
>> "As Configured (if Native)", "Calculated", "Fixed" and "Native"
>> according to the TDX spec.
>>
>> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Sagi Shahar <sagis@google.com>
>> ---
>>   .../selftests/kvm/include/x86/tdx/test_util.h | 15 +++
>>   .../selftests/kvm/lib/x86/tdx/test_util.c     | 20 ++++
>>   tools/testing/selftests/kvm/x86/tdx_vm_test.c | 98 ++++++++++++++++++-
>>   3 files changed, 132 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
>> index cf11955d56d6..2af6e810ef78 100644
>> --- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
>> +++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
>> @@ -9,6 +9,9 @@
>>   #define TDX_TEST_SUCCESS_PORT 0x30
>>   #define TDX_TEST_SUCCESS_SIZE 4
>>   
>> +#define TDX_TEST_REPORT_PORT 0x31
>> +#define TDX_TEST_REPORT_SIZE 4
>> +
>>   /* Port I/O direction */
>>   #define PORT_READ	0
>>   #define PORT_WRITE	1
>> @@ -77,4 +80,16 @@ void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
>>    */
>>   void tdx_assert_error(uint64_t error);
>>   
>> +/*
>> + * Report a 32 bit value from the guest to user space using TDG.VP.VMCALL
>> + * <Instruction.IO> call. Data is reported on port TDX_TEST_REPORT_PORT.
>> + */
>> +uint64_t tdx_test_report_to_user_space(uint32_t data);
>> +
>> +/*
>> + * Read a 32 bit value from the guest in user space, sent using
>> + * tdx_test_report_to_user_space().
>> + */
>> +uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu);
>> +
>>   #endif // SELFTEST_TDX_TEST_UTIL_H
>> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
>> index 4ccc5298ba25..f9bde114a8bc 100644
>> --- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
>> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
>> @@ -104,3 +104,23 @@ void tdx_assert_error(uint64_t error)
>>   	if (error)
>>   		tdx_test_fatal(error);
>>   }
>> +
>> +uint64_t tdx_test_report_to_user_space(uint32_t data)
>> +{
>> +	/* Upcast data to match tdg_vp_vmcall_instruction_io() signature */
>> +	uint64_t data_64 = data;
>> +
>> +	return tdg_vp_vmcall_instruction_io(TDX_TEST_REPORT_PORT,
>> +					    TDX_TEST_REPORT_SIZE, PORT_WRITE,
>> +					    &data_64);
>> +}
>> +
>> +uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu)
>> +{
>> +	uint32_t res;
>> +
>> +	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, 4, PORT_WRITE);
>> +	res = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
>> +
>> +	return res;
>> +}
>> diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
>> index 97330e28f236..bbdcca358d71 100644
>> --- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
>> +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
>> @@ -3,6 +3,7 @@
>>   #include <signal.h>
>>   
>>   #include "kvm_util.h"
>> +#include "processor.h"
>>   #include "tdx/tdcall.h"
>>   #include "tdx/tdx.h"
>>   #include "tdx/tdx_util.h"
>> @@ -146,6 +147,99 @@ void verify_td_ioexit(void)
>>   	printf("\t ... PASSED\n");
>>   }
>>   
>> +/*
>> + * Verifies CPUID functionality by reading CPUID values in guest. The guest
>> + * will then send the values to userspace using an IO write to be checked
>> + * against the expected values.
>> + */
>> +void guest_code_cpuid(void)
>> +{
>> +	uint32_t ebx, ecx;
>> +	uint64_t err;
>> +
>> +	/* Read CPUID leaf 0x1 */
>> +	asm volatile ("cpuid"
>> +		      : "=b" (ebx), "=c" (ecx)
>> +		      : "a" (0x1)
>> +		      : "edx");
>> +
>> +	err = tdx_test_report_to_user_space(ebx);
>> +	tdx_assert_error(err);
>> +
>> +	err = tdx_test_report_to_user_space(ecx);
>> +	tdx_assert_error(err);
>> +
>> +	tdx_test_success();
>> +}
>> +
>> +void verify_td_cpuid(void)
>> +{
>> +	uint32_t guest_max_addressable_ids, host_max_addressable_ids;
>> +	const struct kvm_cpuid_entry2 *cpuid_entry;
>> +	uint32_t guest_clflush_line_size;
>> +	uint32_t guest_initial_apic_id;
>> +	uint32_t guest_sse3_enabled;
>> +	uint32_t guest_fma_enabled;
>> +	struct kvm_vcpu *vcpu;
>> +	struct kvm_vm *vm;
>> +	uint32_t ebx, ecx;
>> +
>> +	vm = td_create();
>> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
>> +	vcpu = td_vcpu_add(vm, 0, guest_code_cpuid);
>> +	td_finalize(vm);
>> +
>> +	printf("Verifying TD CPUID:\n");
>> +
>> +	/* Wait for guest to report ebx value */
Should the comments for ebx and ecx be aligned?
>> +	tdx_run(vcpu);
>> +	ebx = tdx_test_read_report_from_guest(vcpu);
>> +
>> +	/* Wait for guest to report either ecx value or error */
>> +	tdx_run(vcpu);
>> +	ecx = tdx_test_read_report_from_guest(vcpu);
>> +
>> +	/* Wait for guest to complete execution */
>> +	tdx_run(vcpu);
>> +	tdx_test_assert_success(vcpu);
>> +
>> +	/* Verify the CPUID values received from the guest. */
>> +	printf("\t ... Verifying CPUID values from guest\n");
>> +
>> +	/* Get KVM CPUIDs for reference */
>> +	cpuid_entry = vcpu_get_cpuid_entry(vcpu, 1);
>> +	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
>> +
>> +	host_max_addressable_ids = (cpuid_entry->ebx >> 16) & 0xFF;
>> +
>> +	guest_sse3_enabled = ecx & 0x1;  // Native
> It seems the CPUID virtualization types in this series are based on some old
> TDX module spec. The SSE3 has become fixed1 in current public 1.5 base spec.
Yes, the comment should be fixed.

Also, BIT(X86_FEATURE_XMM3.bit) could be used for the mask of sse3.
Similar for FMA below.

>
>> +	guest_clflush_line_size = (ebx >> 8) & 0xFF;  // Fixed
>> +	guest_max_addressable_ids = (ebx >> 16) & 0xFF;  // As Configured
>> +	guest_fma_enabled = (ecx >> 12) & 0x1;  // As Configured (if Native)
>> +	guest_initial_apic_id = (ebx >> 24) & 0xFF;  // Calculated
>> +
>> +	TEST_ASSERT_EQ(guest_sse3_enabled, 1);
>> +	TEST_ASSERT_EQ(guest_clflush_line_size, 8);
>> +	TEST_ASSERT_EQ(guest_max_addressable_ids, host_max_addressable_ids);
>> +
>> +	/* TODO: This only tests the native value. To properly test
>> +	 * "As Configured (if Native)" this value needs override in the
>> +	 * TD params.
>> +	 */
>> +	TEST_ASSERT_EQ(guest_fma_enabled, (cpuid_entry->ecx >> 12) & 0x1);
> FMA is configured by XFAM[2]. If we choose this feature, need to set init_vm->xfam
> which has not been used to configure features in this series yet.

Yes, the virtualization type of FMA is "XFAM & Native", since XFAM is not used
to configure FMA in this series, the value will always be 0.

Because this patch series uses the values retried via KVM_TDX_GET_CPUID as the
input values for KVM_SET_CPUID2, the comparison is still valid, no matter XFAM[2]
is set or not.

The comment needs to be update.

>
>> +
>> +	/* TODO: guest_initial_apic_id is calculated based on the number of
>> +	 * vCPUs in the TD. From the spec: "Virtual CPU index, starting from 0
>> +	 * and allocated sequentially on each successful TDH.VP.INIT"
>> +	 * To test non-trivial values either use a TD with multiple vCPUs
>> +	 * or pick a different calculated value.
>> +	 */
>> +	TEST_ASSERT_EQ(guest_initial_apic_id, 0);
>> +
>> +	kvm_vm_free(vm);
>> +	printf("\t ... PASSED\n");
>> +}
>> +
>>   int main(int argc, char **argv)
>>   {
>>   	ksft_print_header();
>> @@ -153,13 +247,15 @@ int main(int argc, char **argv)
>>   	if (!is_tdx_enabled())
>>   		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
>>   
>> -	ksft_set_plan(3);
>> +	ksft_set_plan(4);
>>   	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
>>   			 "verify_td_lifecycle\n");
>>   	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
>>   			 "verify_report_fatal_error\n");
>>   	ksft_test_result(!run_in_new_process(&verify_td_ioexit),
>>   			 "verify_td_ioexit\n");
>> +	ksft_test_result(!run_in_new_process(&verify_td_cpuid),
>> +			 "verify_td_cpuid\n");
>>   
>>   	ksft_finished();
>>   	return 0;


