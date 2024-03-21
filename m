Return-Path: <linux-kselftest+bounces-6480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072F6886400
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 00:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38562B21B48
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1291B263;
	Thu, 21 Mar 2024 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZKnDe2D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6429A9;
	Thu, 21 Mar 2024 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064448; cv=none; b=Tlp6T6YLczJ5HshqE22WJFsIGDgiVgvFF3CfXMemXa7mVdwsSNwuu9N2kZuMPhwVv1lofb35qbOlZQOiMIjXU4U1/3/+dYusQHJNWBQlOhmCfQbcMO8rKSORA0pwfOrzloADpnvr8dRGha/O4uVl7Uy9vXy1hqmSd34HlHfrVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064448; c=relaxed/simple;
	bh=lmPYeGS+4lUFLmzt/61FUNZFXKxXzVkv+EU4SNg+F+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0N9nIAdX5aI3wFyAjMpC17FIGAb+fE6DlofD1mM4/k4Ohm9Mw6s4RH5smg0XKGMY0IwyMOBIWufjiFeoqjPnoWfesa4lQq/tL/+GjEsVuWmb5GbksWLvJ5BFQftZZhJBRKmQ1jSTUoBsEgN8i6MGjWgwCAmInJ0A2cID2hNihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZKnDe2D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711064447; x=1742600447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lmPYeGS+4lUFLmzt/61FUNZFXKxXzVkv+EU4SNg+F+g=;
  b=AZKnDe2DieGG8J6ZApWUqLTt6SHb0EiMY3PhwJ3wmVnqhGZXcJ4twPkA
   3gue6gJpHIdATrJ8IahQLnvgkGQ6nNjmTSBSRVh3s2SlUvRwN/XJMxrfI
   hV9I0aUGU3SXiW1uHEM6TYIFY7wvYctLkesPkz1Z/AjtQS/+e60Cffu9O
   fPeL7TzZSazEeHYOM8HWaCgQvuFeiklkFfxa2JE45q+ZtJfX0vlE8lFfG
   dQ8Xc4SYmt0SmxObnDcjie5Ev1rKN3ptpSGD7agCPxw+pFm2FTvYgqQE8
   wuxVqW/vG/GTDBfgob7J/qrZgOg2d4yR8Whi997kQYLS1RPvqTuFr0pdX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5989913"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="5989913"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 16:40:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="14687751"
Received: from dongshen-mobl1.amr.corp.intel.com (HELO [10.212.116.150]) ([10.212.116.150])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 16:40:45 -0700
Message-ID: <c919e42a-01db-4969-9aa7-d0ae1792a6c9@intel.com>
Date: Thu, 21 Mar 2024 16:40:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 15/29] KVM: selftests: TDX: Add TDX MSR read/write
 tests
To: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org,
 Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-16-sagis@google.com>
Content-Language: en-US
From: "Zhang, Dongsheng X" <dongsheng.x.zhang@intel.com>
In-Reply-To: <20231212204647.2170650-16-sagis@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2023 12:46 PM, Sagi Shahar wrote:
> The test verifies reads and writes for MSR registers with different access
> level.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>  .../selftests/kvm/include/x86_64/tdx/tdx.h    |   5 +
>  .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  27 +++
>  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 209 ++++++++++++++++++
>  3 files changed, 241 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index 63788012bf94..85ba6aab79a7 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -9,11 +9,16 @@
>  #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
>  
>  #define TDG_VP_VMCALL_INSTRUCTION_IO 30
> +#define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
> +#define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32

Nit:
"arch/x86/include/uapi/asm/vmx.h" already defined the following defs:
#define EXIT_REASON_IO_INSTRUCTION      30
#define EXIT_REASON_MSR_READ            31
#define EXIT_REASON_MSR_WRITE           32


> +
>  void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
>  uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>  				      uint64_t write, uint64_t *data);
>  void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
>  uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
>  					uint64_t *r13, uint64_t *r14);
> +uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
> +uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
>  
>  #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index e5a9e13c62e2..88ea6f2a6469 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -87,3 +87,30 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
>  
>  	return ret;
>  }
> +
> +uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value)
> +{
> +	uint64_t ret;
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_INSTRUCTION_RDMSR,
> +		.r12 = index,
> +	};
> +
> +	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	if (ret_value)
> +		*ret_value = args.r11;
> +
> +	return ret;
> +}
> +
> +uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_INSTRUCTION_WRMSR,
> +		.r12 = index,
> +		.r13 = value,
> +	};
> +
> +	return __tdx_hypercall(&args, 0);
> +}
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index 699cba36e9ce..5db3701cc6d9 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -515,6 +515,213 @@ void verify_guest_reads(void)
>  	printf("\t ... PASSED\n");
>  }
>  
> +/*
> + * Define a filter which denies all MSR access except the following:
> + * MSR_X2APIC_APIC_ICR: Allow read/write access (allowed by default)
> + * MSR_IA32_MISC_ENABLE: Allow read access
> + * MSR_IA32_POWER_CTL: Allow write access
> + */
> +#define MSR_X2APIC_APIC_ICR 0x830
> +static u64 tdx_msr_test_allow_bits = 0xFFFFFFFFFFFFFFFF;

Nit:
0xFFFFFFFFFFFFFFFF is error prone to define? the following?
static u64 tdx_msr_test_allow_bits = ~0ULL;


> +struct kvm_msr_filter tdx_msr_test_filter = {
> +	.flags = KVM_MSR_FILTER_DEFAULT_DENY,
> +	.ranges = {
> +		{
> +			.flags = KVM_MSR_FILTER_READ,
> +			.nmsrs = 1,
> +			.base = MSR_IA32_MISC_ENABLE,
> +			.bitmap = (uint8_t *)&tdx_msr_test_allow_bits,
> +		}, {
> +			.flags = KVM_MSR_FILTER_WRITE,
> +			.nmsrs = 1,
> +			.base = MSR_IA32_POWER_CTL,
> +			.bitmap = (uint8_t *)&tdx_msr_test_allow_bits,
> +		},
> +	},
> +};
> +
> +/*
> + * Verifies MSR read functionality.
> + */
> +void guest_msr_read(void)
> +{
> +	uint64_t data;
> +	uint64_t ret;
> +
> +	ret = tdg_vp_vmcall_instruction_rdmsr(MSR_X2APIC_APIC_ICR, &data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdx_test_report_64bit_to_user_space(data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdg_vp_vmcall_instruction_rdmsr(MSR_IA32_MISC_ENABLE, &data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	ret = tdx_test_report_64bit_to_user_space(data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	/* We expect this call to fail since MSR_IA32_POWER_CTL is write only */
> +	ret = tdg_vp_vmcall_instruction_rdmsr(MSR_IA32_POWER_CTL, &data);
> +	if (ret) {
> +		ret = tdx_test_report_64bit_to_user_space(ret);
> +		if (ret)
> +			tdx_test_fatal(ret);
> +	} else {
> +		tdx_test_fatal(-99);
> +	}
> +
> +	tdx_test_success();
> +}
> +
> +void verify_guest_msr_reads(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	uint64_t data;
> +	int ret;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +
> +	/*
> +	 * Set explicit MSR filter map to control access to the MSR registers
> +	 * used in the test.
> +	 */
> +	printf("\t ... Setting test MSR filter\n");
> +	ret = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
> +	TEST_ASSERT(ret, "KVM_CAP_X86_USER_SPACE_MSR is unavailable");
> +	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
> +
> +	ret = kvm_check_cap(KVM_CAP_X86_MSR_FILTER);
> +	TEST_ASSERT(ret, "KVM_CAP_X86_MSR_FILTER is unavailable");
> +
> +	ret = ioctl(vm->fd, KVM_X86_SET_MSR_FILTER, &tdx_msr_test_filter);
> +	TEST_ASSERT(ret == 0,
> +		    "KVM_X86_SET_MSR_FILTER failed, ret: %i errno: %i (%s)",
> +		    ret, errno, strerror(errno));
> +
> +	vcpu = td_vcpu_add(vm, 0, guest_msr_read);
> +	td_finalize(vm);
> +
> +	printf("Verifying guest msr reads:\n");
> +
> +	printf("\t ... Setting test MSR values\n");
> +	/* Write arbitrary to the MSRs. */
> +	vcpu_set_msr(vcpu, MSR_X2APIC_APIC_ICR, 4);
> +	vcpu_set_msr(vcpu, MSR_IA32_MISC_ENABLE, 5);
> +	vcpu_set_msr(vcpu, MSR_IA32_POWER_CTL, 6);
> +
> +	printf("\t ... Running guest\n");
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	data = tdx_test_read_64bit_report_from_guest(vcpu);
> +	TEST_ASSERT_EQ(data, 4);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	data = tdx_test_read_64bit_report_from_guest(vcpu);
> +	TEST_ASSERT_EQ(data, 5);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	data = tdx_test_read_64bit_report_from_guest(vcpu);
> +	TEST_ASSERT_EQ(data, TDG_VP_VMCALL_INVALID_OPERAND);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
> +/*
> + * Verifies MSR write functionality.
> + */
> +void guest_msr_write(void)
> +{
> +	uint64_t ret;
> +
> +	ret = tdg_vp_vmcall_instruction_wrmsr(MSR_X2APIC_APIC_ICR, 4);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	/* We expect this call to fail since MSR_IA32_MISC_ENABLE is read only */
> +	ret = tdg_vp_vmcall_instruction_wrmsr(MSR_IA32_MISC_ENABLE, 5);
> +	if (ret) {
> +		ret = tdx_test_report_64bit_to_user_space(ret);
> +		if (ret)
> +			tdx_test_fatal(ret);
> +	} else {
> +		tdx_test_fatal(-99);
> +	}
> +
> +
> +	ret = tdg_vp_vmcall_instruction_wrmsr(MSR_IA32_POWER_CTL, 6);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	tdx_test_success();
> +}
> +
> +void verify_guest_msr_writes(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	uint64_t data;
> +	int ret;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +
> +	/*
> +	 * Set explicit MSR filter map to control access to the MSR registers
> +	 * used in the test.
> +	 */
> +	printf("\t ... Setting test MSR filter\n");
> +	ret = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
> +	TEST_ASSERT(ret, "KVM_CAP_X86_USER_SPACE_MSR is unavailable");
> +	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
> +
> +	ret = kvm_check_cap(KVM_CAP_X86_MSR_FILTER);
> +	TEST_ASSERT(ret, "KVM_CAP_X86_MSR_FILTER is unavailable");
> +
> +	ret = ioctl(vm->fd, KVM_X86_SET_MSR_FILTER, &tdx_msr_test_filter);
> +	TEST_ASSERT(ret == 0,
> +		    "KVM_X86_SET_MSR_FILTER failed, ret: %i errno: %i (%s)",
> +		    ret, errno, strerror(errno));
> +
> +	vcpu = td_vcpu_add(vm, 0, guest_msr_write);
> +	td_finalize(vm);
> +
> +	printf("Verifying guest msr writes:\n");
> +
> +	printf("\t ... Running guest\n");
> +	/* Only the write to MSR_IA32_MISC_ENABLE should trigger an exit */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	data = tdx_test_read_64bit_report_from_guest(vcpu);
> +	TEST_ASSERT_EQ(data, TDG_VP_VMCALL_INVALID_OPERAND);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	printf("\t ... Verifying MSR values writen by guest\n");
> +
> +	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_X2APIC_APIC_ICR), 4);
> +	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_MISC_ENABLE), 0x1800);
> +	TEST_ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_POWER_CTL), 6);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
> +
>  int main(int argc, char **argv)
>  {
>  	setbuf(stdout, NULL);
> @@ -531,6 +738,8 @@ int main(int argc, char **argv)
>  	run_in_new_process(&verify_get_td_vmcall_info);
>  	run_in_new_process(&verify_guest_writes);
>  	run_in_new_process(&verify_guest_reads);
> +	run_in_new_process(&verify_guest_msr_writes);
> +	run_in_new_process(&verify_guest_msr_reads);
>  
>  	return 0;
>  }

