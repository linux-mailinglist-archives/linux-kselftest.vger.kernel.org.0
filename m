Return-Path: <linux-kselftest+bounces-5710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E41386E0C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 13:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B29A1C20A32
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9E06D1C1;
	Fri,  1 Mar 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhIW4khV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7426D1A7;
	Fri,  1 Mar 2024 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294437; cv=none; b=S5/pYk6edYO6HmH5GH6/sjgHs8N/oKWiUGl9SEdZIGmaYL02CMHlmYtT6dQiEdPKCCpbiqYfqioovnY0dAbLvJhDLnIEi17VeLBT1OJymRbVz0NOYL2idum8NvFVJpFMBal5kAaSkl11oOSrMSlxdafw4Rftf12+xpWCVxutpCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294437; c=relaxed/simple;
	bh=Bpm6hOspaqm5Ql7XCmGjGb3G6kC5f6KchwepD3KMdv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OezbkTYQce03b0eCu461Mzrnu4XfhTZWncPhaM3UiVip19acVnKiahjj0teAJH1prrzTvUQEsVPyptenDf2z3iUe7G6SrbfKcL3cXtIapbtU4wKZFq/6BOwNdEozNG0Xq3GOpPdPGhQWds5V4Yd0ytumVkzJvs0XFiEhuTAu65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhIW4khV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709294435; x=1740830435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bpm6hOspaqm5Ql7XCmGjGb3G6kC5f6KchwepD3KMdv4=;
  b=hhIW4khVoxPhNhkTybHLGQgwMV9SScSZEVhU+Xj4/J87KUrl6vg5JdMK
   /pzeSHsX5XmPVYXjWDPq7UG1uv9aZCuU6eQX/1a+v1mL/q+ex+myJfyju
   j8E6DXGu8mOTui3U/rzcxQluxbpuVtIOYyFs7Mx620+raBvuuQ38V1SjI
   +L1oo6wbPfsKPnemVZcaTsvwPX4ck3ImS203RSxoNt1icXKvzl3SoHQGD
   W9HJthAqVUcohXqbR+UjQPuHMhCLpKBWlTRzsnhXsDKQdD4Y4FfLOTj63
   mjDcbqEvilPtU5x/e9JErsu8zXGrnH4Y/0hsrH7P5UYBuDYUOM7Yzj+7T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6780642"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="6780642"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 04:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12863458"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.125.242.247]) ([10.125.242.247])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 04:00:22 -0800
Message-ID: <d4d8831c-0b11-4219-b00e-37e6f0781fe1@linux.intel.com>
Date: Fri, 1 Mar 2024 20:00:19 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 15/29] KVM: selftests: TDX: Add TDX MSR read/write
 tests
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-16-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-16-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> The test verifies reads and writes for MSR registers with different access
> level.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>   .../selftests/kvm/include/x86_64/tdx/tdx.h    |   5 +
>   .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  27 +++
>   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 209 ++++++++++++++++++
>   3 files changed, 241 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index 63788012bf94..85ba6aab79a7 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -9,11 +9,16 @@
>   #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
>   
>   #define TDG_VP_VMCALL_INSTRUCTION_IO 30
> +#define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
> +#define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
> +
>   void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
>   uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>   				      uint64_t write, uint64_t *data);
>   void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
>   uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
>   					uint64_t *r13, uint64_t *r14);
> +uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
> +uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
>   
>   #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index e5a9e13c62e2..88ea6f2a6469 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -87,3 +87,30 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
>   
>   	return ret;
>   }
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
>   	printf("\t ... PASSED\n");
>   }
>   
> +/*
> + * Define a filter which denies all MSR access except the following:
> + * MSR_X2APIC_APIC_ICR: Allow read/write access (allowed by default)

The default filtering behavior of tdx_msr_test_filter is
KVM_MSR_FILTER_DEFAULT_DENY, and MSR_X2APIC_APIC_ICR is not covered
by any specific range, shouldn't MSR_X2APIC_APIC_ICR be denied by default?

> + * MSR_IA32_MISC_ENABLE: Allow read access
> + * MSR_IA32_POWER_CTL: Allow write access
> + */
> +#define MSR_X2APIC_APIC_ICR 0x830
> +static u64 tdx_msr_test_allow_bits = 0xFFFFFFFFFFFFFFFF;
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
>   int main(int argc, char **argv)
>   {
>   	setbuf(stdout, NULL);
> @@ -531,6 +738,8 @@ int main(int argc, char **argv)
>   	run_in_new_process(&verify_get_td_vmcall_info);
>   	run_in_new_process(&verify_guest_writes);
>   	run_in_new_process(&verify_guest_reads);
> +	run_in_new_process(&verify_guest_msr_writes);
> +	run_in_new_process(&verify_guest_msr_reads);
>   
>   	return 0;
>   }


