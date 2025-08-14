Return-Path: <linux-kselftest+bounces-38934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EEEB25BDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 08:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186565C4F3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 06:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA5724BD00;
	Thu, 14 Aug 2025 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlWreBeP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834C239E67;
	Thu, 14 Aug 2025 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153287; cv=none; b=FL14wKQeP/UWivdgKx/n0NYrgtlj65hbuqMj3H2LXDp62Pbc5rg1igLPQWwpvl0fBLqofRDAoNuWgfAeQ+wY6siIvIr93HTqXZbQdEGDhsl+IA1cP+IiOh2xWOeTnNybf6sSZXSLWdVPEbXqsmcZ/mHbKvSg20W8AIZ8g3h8UgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153287; c=relaxed/simple;
	bh=pGC86u42hcoH+taM5BME6hxdtNNtCZVgv9q1enbPCbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNaM/QX/cZqC2TdruTINClxJz71e/J+b2T77McKnhWnVsz+bRHvdkZje49IX27HllbufMxqxi9tilr/ShfEkR9JICjmchna/waKgtr32uxeGvi9AhzKYZZxxdK2NluKZT4FVBu7+G+FMn4peVzJyzzLLjbh6NufnnzrgwVwokK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlWreBeP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755153286; x=1786689286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pGC86u42hcoH+taM5BME6hxdtNNtCZVgv9q1enbPCbs=;
  b=AlWreBeP8jHAuaXWfBjMpOA7Spt63LxoefynyEQFeiEn4ul3qPXR3sIg
   du92Z1/1FXPMs7AHpU8W5cF9xeAXQiJXdIVfGl898j870jo8zyMGcf7GD
   McXrnJn4W3ALtdXXWFFtV/uH/p+oY+A9sEwtUZmtroRiB4XQLXpaFaPCm
   EZvOQrjAAZFqH21ezdKxDejEgI8EDfjdo8ugATOriYyP3N8attL36xpa/
   7MFffVeZlcfaHyxajoSRUpZ+MO5k6+LhrmI/5nsnWReSNqhwmx+I/0mcC
   EFMe7seDfqVIkjBH3SOdc2E9PAdOpCHhwFFkwhbOQO0aG5JPvQTEugzuA
   w==;
X-CSE-ConnectionGUID: sHji70WdT8Wu52aMiptZBA==
X-CSE-MsgGUID: S/zvNG2RR2+n+kRVy72efQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74913819"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="74913819"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 23:34:45 -0700
X-CSE-ConnectionGUID: b2U1+SUVSj62UkemM1eYOA==
X-CSE-MsgGUID: xPjxujy4RRus1zaupur14A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167048895"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 23:34:41 -0700
Message-ID: <622f4195-3d6c-43d9-8c1c-5cb1e4b8cb3e@linux.intel.com>
Date: Thu, 14 Aug 2025 14:34:38 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/30] KVM: selftests: TDX: Add basic
 TDG.VP.VMCALL<GetTdVmCallInfo> test
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
 <20250807201628.1185915-14-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250807201628.1185915-14-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/8/2025 4:16 AM, Sagi Shahar wrote:
> The test calls TDG.VP.VMCALL<GetTdVmCallInfo> hypercall from the guest
> and verifies the expected returned values.
>
> TDG.VP.VMCALL<GetTdVmCallInfo> hypercall is a subleaf of TDG.VP.VMCALL to
> enumerate which TDG.VP.VMCALL sub leaves are supported.  This hypercall is
> for future enhancement of the Guest-Host-Communication Interface (GHCI)
> specification. The GHCI version of 344426-001US defines it to require
> input R12 to be zero
There is an update about TDG.VP.VMCALL<GetTdVmCallInfo> in 348552-005US (DRAFT)
https://cdrdv2-public.intel.com/858626/TDX%20Guest-Hypervisor%20Communication%20Interface_1.5_20250623.pdf

And the KVM's implementation has been following the new change.
But the test code in this patch for R12 set to 0 is still valid.

New description of "input R12"
     Leaf to enumerate TDG.VP.VMCALL functionality from this specification
     supported by the host.

     If R12 is set to 0, and successful execution of this TDG.VP.VMCALL (Error
     Code is SUCCESS) is meant to indicate all GHCI base TDG.VP.VMCALLs
     defined in the this specification are supported by the host VMM.
     The GHCI base VMCALLs are: <GetTdVmCallInfo>, <MapGPA>, <GetQuote>,
     <ReportFatalError>, <Instruction.CPUID>, <#VE.RequestMMIO>,
     <Instruction.HLT>, <Instruction.IO>, <Instruction.RDMSR>,
     <Instruction.WRMSR>. These VMCALLs must be supported.

     If R12 is set to 1, and successful execution of this TDG.VP.VMCALL (Error
     Code is SUCCESS) is meant to query the supported sub-function and the
     capability of each sub-function.

     Other: reserved


>   and to return zero in output registers, R11, R12, R13,
> and R14 so that guest TD enumerates no enhancement.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86/tdx/tdx.h       |  3 +
>   .../selftests/kvm/include/x86/tdx/test_util.h | 27 +++++++
>   tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 23 ++++++
>   .../selftests/kvm/lib/x86/tdx/test_util.c     | 42 +++++++++++
>   tools/testing/selftests/kvm/x86/tdx_vm_test.c | 72 ++++++++++++++++++-
>   5 files changed, 166 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> index 2acccc9dccf9..97ceb90c8792 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -6,6 +6,7 @@
>   
>   #include "kvm_util.h"
>   
> +#define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
>   #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
>   
>   #define TDG_VP_VMCALL_INSTRUCTION_IO 30
> @@ -13,4 +14,6 @@
>   uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>   				      uint64_t write, uint64_t *data);
>   void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
> +uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
> +					  uint64_t *r13, uint64_t *r14);
>   #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> index 2af6e810ef78..91031e956462 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
> @@ -4,6 +4,7 @@
>   
>   #include <stdbool.h>
>   
> +#include "kvm_util.h"
>   #include "tdcall.h"
>   
>   #define TDX_TEST_SUCCESS_PORT 0x30
> @@ -92,4 +93,30 @@ uint64_t tdx_test_report_to_user_space(uint32_t data);
>    */
>   uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu);
>   
> +/*
> + * Report a 64 bit value from the guest to user space using TDG.VP.VMCALL
> + * <Instruction.IO> call.
> + *
> + * Data is sent to host in 2 calls. LSB is sent (and needs to be read) first.
> + */
> +uint64_t tdx_test_send_64bit(uint64_t port, uint64_t data);
> +
> +/*
> + * Report a 64 bit value from the guest to user space using TDG.VP.VMCALL
> + * <Instruction.IO> call. Data is reported on port TDX_TEST_REPORT_PORT.
> + */
> +uint64_t tdx_test_report_64bit_to_user_space(uint64_t data);
> +
> +/*
> + * Read a 64 bit value from the guest in user space, sent using
> + * tdx_test_send_64bit().
> + */
> +uint64_t tdx_test_read_64bit(struct kvm_vcpu *vcpu, uint64_t port);
> +
> +/*
> + * Read a 64 bit value from the guest in user space, sent using
> + * tdx_test_report_64bit_to_user_space().
> + */
> +uint64_t tdx_test_read_64bit_report_from_guest(struct kvm_vcpu *vcpu);
> +
>   #endif // SELFTEST_TDX_TEST_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> index ba088bfc1e62..5105dfae0e9e 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> @@ -43,3 +43,26 @@ void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
>   
>   	__tdx_hypercall(&args, 0);
>   }
> +
> +uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
> +					  uint64_t *r13, uint64_t *r14)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_GET_TD_VM_CALL_INFO,
> +		.r12 = 0,
> +	};
> +	uint64_t ret;
> +
> +	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	if (r11)
> +		*r11 = args.r11;
> +	if (r12)
> +		*r12 = args.r12;
> +	if (r13)
> +		*r13 = args.r13;
> +	if (r14)
> +		*r14 = args.r14;
> +
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> index f9bde114a8bc..8c3b6802c37e 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
> @@ -7,6 +7,7 @@
>   #include <unistd.h>
>   
>   #include "kvm_util.h"
> +#include "tdx/tdcall.h"
>   #include "tdx/tdx.h"
>   #include "tdx/tdx_util.h"
>   #include "tdx/test_util.h"
> @@ -124,3 +125,44 @@ uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu)
>   
>   	return res;
>   }
> +
> +uint64_t tdx_test_send_64bit(uint64_t port, uint64_t data)
> +{
> +	uint64_t data_hi = (data >> 32) & 0xFFFFFFFF;
> +	uint64_t data_lo = data & 0xFFFFFFFF;
> +	uint64_t err;
> +
> +	err = tdg_vp_vmcall_instruction_io(port, 4, PORT_WRITE, &data_lo);
> +	if (err)
> +		return err;
> +
> +	return tdg_vp_vmcall_instruction_io(port, 4, PORT_WRITE, &data_hi);
> +}
> +
> +uint64_t tdx_test_report_64bit_to_user_space(uint64_t data)
> +{
> +	return tdx_test_send_64bit(TDX_TEST_REPORT_PORT, data);
> +}
> +
> +uint64_t tdx_test_read_64bit(struct kvm_vcpu *vcpu, uint64_t port)
> +{
> +	uint32_t lo, hi;
> +	uint64_t res;
> +
> +	tdx_test_assert_io(vcpu, port, 4, PORT_WRITE);
> +	lo = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	vcpu_run(vcpu);
> +
> +	tdx_test_assert_io(vcpu, port, 4, PORT_WRITE);
> +	hi = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
> +
> +	res = hi;
> +	res = (res << 32) | lo;
> +	return res;
> +}
> +
> +uint64_t tdx_test_read_64bit_report_from_guest(struct kvm_vcpu *vcpu)
> +{
> +	return tdx_test_read_64bit(vcpu, TDX_TEST_REPORT_PORT);
> +}
> diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> index bbdcca358d71..22143d16e0d1 100644
> --- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> +++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
> @@ -240,6 +240,74 @@ void verify_td_cpuid(void)
>   	printf("\t ... PASSED\n");
>   }
>   
> +/*
> + * Verifies TDG.VP.VMCALL<GetTdVmCallInfo> hypercall functionality.
> + */
> +void guest_code_get_td_vmcall_info(void)
> +{
> +	uint64_t r11, r12, r13, r14;
> +	uint64_t err;
> +
> +	err = tdg_vp_vmcall_get_td_vmcall_info(&r11, &r12, &r13, &r14);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r11);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r12);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r13);
> +	tdx_assert_error(err);
> +
> +	err = tdx_test_report_64bit_to_user_space(r14);
> +	tdx_assert_error(err);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_get_td_vmcall_info(void)
> +{
> +	uint64_t r11, r12, r13, r14;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_code_get_td_vmcall_info);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD get vmcall info:\n");
> +
> +	/* Wait for guest to report r11 value */
> +	tdx_run(vcpu);
> +	r11 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +	/* Wait for guest to report r12 value */
> +	tdx_run(vcpu);
> +	r12 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +	/* Wait for guest to report r13 value */
> +	tdx_run(vcpu);
> +	r13 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +	/* Wait for guest to report r14 value */
> +	tdx_run(vcpu);
> +	r14 = tdx_test_read_64bit_report_from_guest(vcpu);
> +
> +	TEST_ASSERT_EQ(r11, 0);
> +	TEST_ASSERT_EQ(r12, 0);
> +	TEST_ASSERT_EQ(r13, 0);
> +	TEST_ASSERT_EQ(r14, 0);
> +
> +	/* Wait for guest to complete execution */
> +	tdx_run(vcpu);
> +	tdx_test_assert_success(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	ksft_print_header();
> @@ -247,7 +315,7 @@ int main(int argc, char **argv)
>   	if (!is_tdx_enabled())
>   		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
>   
> -	ksft_set_plan(4);
> +	ksft_set_plan(5);
>   	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
>   			 "verify_td_lifecycle\n");
>   	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
> @@ -256,6 +324,8 @@ int main(int argc, char **argv)
>   			 "verify_td_ioexit\n");
>   	ksft_test_result(!run_in_new_process(&verify_td_cpuid),
>   			 "verify_td_cpuid\n");
> +	ksft_test_result(!run_in_new_process(&verify_get_td_vmcall_info),
> +			 "verify_get_td_vmcall_info\n");
>   
>   	ksft_finished();
>   	return 0;


