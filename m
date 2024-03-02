Return-Path: <linux-kselftest+bounces-5777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BB086EF26
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 08:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754EF1C21110
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Mar 2024 07:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C915911712;
	Sat,  2 Mar 2024 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElNTMh7f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A9C2E6;
	Sat,  2 Mar 2024 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364678; cv=none; b=SaxB7F/UyCyJMT5doqOrS8jN1wLAsTYhdSr+KNIjv6G0hvd0Duqquw2xTC0vrPXxD6ohGXb6SwvtGYLbBBA/2N0szabpW3Gj6WIVaZw9Iui1HvcxfN5i38JB3A74797gX9haWuQDUVaqb8Tzqx7mX5CJlUvfRsqPqExotJtvZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364678; c=relaxed/simple;
	bh=TN3SmDf8ga5MSo8DFjBXH+p7ASw4GxfM0zrVwvSxZl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tru2jcD7jvW2x9SyjSDkFZOiVxQgtr0RVJN6pCAytK9SvRpB73o0lvZA8Gs5WesZgVV0SZ8u2Spuo5Dq9MInKueOgosODwPJ/vDyxZxJKUOL9eV2m2bIfRdkkzmrEDgCqP14tu6MJlpy6QNMTPuYpL5Vqzlf9urdb0fjPwn87lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElNTMh7f; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709364677; x=1740900677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TN3SmDf8ga5MSo8DFjBXH+p7ASw4GxfM0zrVwvSxZl8=;
  b=ElNTMh7fEK6blwaE0Ujk+JCpbTKJ+uNnK+/BN7AN9sfAk/4SQw+1Z7Gs
   3jaRKHs0USo3Pr6eB0GU6hC2tHfQ1EaZrUmMitYzr06aj4ykCXWvP0Xj/
   P4IG+9NZAAgNyxt8VsEdBWaSm5/Ma5wnySDxWskrWEi71CBWgUyeOWiiX
   TsCXvr5udwqEUlkz+7QeQ2rabFQEmvV3gpGHwOp7ASVDbJ8d5wNMqJKf6
   H4Rvy/41KGhNgyL/rNbZ4oEF8RzgjZhSmR5JwzqtnXDSV5f5RWjGmSo+W
   2JhN3tWLlNCE3mD/OjkpIvQWoFKWHoXF4z6a4XyDoCzLO5JcATHfoLmF4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4033594"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="4033594"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 23:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="39255742"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.125.242.247]) ([10.125.242.247])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 23:31:11 -0800
Message-ID: <1f9d2b41-95ad-42ca-b1e5-70212b93a9c1@linux.intel.com>
Date: Sat, 2 Mar 2024 15:31:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 16/29] KVM: selftests: TDX: Add TDX HLT exit test
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
 <20231212204647.2170650-17-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-17-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> The test verifies that the guest runs TDVMCALL<INSTRUCTION.HLT> and the
> guest vCPU enters to the halted state.
>
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>   .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
>   .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 10 +++
>   .../selftests/kvm/x86_64/tdx_vm_tests.c       | 78 +++++++++++++++++++
>   3 files changed, 90 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index 85ba6aab79a7..b18e39d20498 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -8,6 +8,7 @@
>   #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
>   #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
>   
> +#define TDG_VP_VMCALL_INSTRUCTION_HLT 12
>   #define TDG_VP_VMCALL_INSTRUCTION_IO 30
>   #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
>   #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
> @@ -20,5 +21,6 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
>   					uint64_t *r13, uint64_t *r14);
>   uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
>   uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
> +uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
>   
>   #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index 88ea6f2a6469..9485bafedc38 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -114,3 +114,13 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value)
>   
>   	return __tdx_hypercall(&args, 0);
>   }
> +
> +uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_INSTRUCTION_HLT,
> +		.r12 = interrupt_blocked_flag,
> +	};
> +
> +	return __tdx_hypercall(&args, 0);
> +}
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index 5db3701cc6d9..5fae4c6e5f95 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -721,6 +721,83 @@ void verify_guest_msr_writes(void)
>   	printf("\t ... PASSED\n");
>   }
>   
> +/*
> + * Verifies HLT functionality.
> + */
> +void guest_hlt(void)
> +{
> +	uint64_t ret;
> +	uint64_t interrupt_blocked_flag;
> +
> +	interrupt_blocked_flag = 0;
> +	ret = tdg_vp_vmcall_instruction_hlt(interrupt_blocked_flag);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	tdx_test_success();
> +}
> +
> +void _verify_guest_hlt(int signum);
> +
> +void wake_me(int interval)
> +{
> +	struct sigaction action;
> +
> +	action.sa_handler = _verify_guest_hlt;
> +	sigemptyset(&action.sa_mask);
> +	action.sa_flags = 0;
> +
> +	TEST_ASSERT(sigaction(SIGALRM, &action, NULL) == 0,
> +		    "Could not set the alarm handler!");
> +
> +	alarm(interval);
> +}
> +
> +void _verify_guest_hlt(int signum)
> +{
> +	struct kvm_vm *vm;
> +	static struct kvm_vcpu *vcpu;
> +
> +	/*
> +	 * This function will also be called by SIGALRM handler to check the
> +	 * vCPU MP State. If vm has been initialized, then we are in the signal
> +	 * handler. Check the MP state and let the guest run again.
> +	 */
> +	if (vcpu != NULL) {

What if the following case if there is a bug in KVM so that:

In guest, execution of tdg_vp_vmcall_instruction_hlt() return 0, but the
vcpu is not actually halted. Then guest will call tdx_test_success().

And the first call of _verify_guest_hlt() will call kvm_vm_free(vm) to free
the vm, which also frees the vcpu, and 1 second later, in this path vcpu 
will
be accessed after free.

> +		struct kvm_mp_state mp_state;
> +
> +		vcpu_mp_state_get(vcpu, &mp_state);
> +		TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_HALTED);
> +
> +		/* Let the guest to run and finish the test.*/
> +		mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
> +		vcpu_mp_state_set(vcpu, &mp_state);
> +		return;
> +	}
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_hlt);
> +	td_finalize(vm);
> +
> +	printf("Verifying HLT:\n");
> +
> +	printf("\t ... Running guest\n");
> +
> +	/* Wait 1 second for guest to execute HLT */
> +	wake_me(1);
> +	td_vcpu_run(vcpu);
> +
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
> +void verify_guest_hlt(void)
> +{
> +	_verify_guest_hlt(0);
> +}
>   
>   int main(int argc, char **argv)
>   {
> @@ -740,6 +817,7 @@ int main(int argc, char **argv)
>   	run_in_new_process(&verify_guest_reads);
>   	run_in_new_process(&verify_guest_msr_writes);
>   	run_in_new_process(&verify_guest_msr_reads);
> +	run_in_new_process(&verify_guest_hlt);
>   
>   	return 0;
>   }


