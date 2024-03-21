Return-Path: <linux-kselftest+bounces-6481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A388640C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 00:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AB92843DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32AE1B7E6;
	Thu, 21 Mar 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTmUJF4f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15E5F516;
	Thu, 21 Mar 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064746; cv=none; b=CIUfHGe8jQTR8fy1gdAVj4wkKPGCTYEg3TvgArF+8m9AP6HamFeCHjktz8BIFcgj1zVMcwF41ET958cCDJBigLJasUzwE1EXzs49xd8jxqhTHuTJiQDFtrz1hK7/tGh3G89i+Y56hJzDTnnqNhzVXOIfobJwP1JFwe0O1d2zw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064746; c=relaxed/simple;
	bh=jW38JzanhRNpu03oZcnIFmEukYYO360wk+qtFn4vZEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCIsSWpMY8SSY0rOGjPtLI/gyqx8nVFiDCay9le1j4y+GZnF5GqSYpfk83td3+xAxYTe43EmA/+8OSbhpmHUALu9UZZSVliQhDYWiXbClSDv83WGbPY+200UIiiUGXIazvtrsWAE1sJuteWJaNmBzGnsU+Od5H9WsSAHJ0KrEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTmUJF4f; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711064745; x=1742600745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jW38JzanhRNpu03oZcnIFmEukYYO360wk+qtFn4vZEQ=;
  b=lTmUJF4fk3NOhGc8DCMDgh9GEwsSZEWLgqODS85iiS4pWITFrxdiwoaU
   WM/pJBjyiE7uPNrkq29IA9Bfb7LITOMryBbOXXOmkY+9rF31HzKhE8AMD
   HvwfeRx4xLh+S28zBll4u8IwKUUkuccjLZKaN5Y2/kb8AE9asT6iNgLJ+
   8F9SY3kzL7BhyIfWwaAkSDTzmcIF6Q19/75rPcRKAP6oSXSJnafD7l8/1
   OX8CPq8k5nJ5l+aJ3gWO9r8K4cVywb0B+VKfUCMWAojz8OsTFTN2Q1/nX
   2PthVxZ7fVkzfO1/fNCwx0/q0Vw9gsG7gYvrTgvmZX3qt15e++5LC8DFS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17246015"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="17246015"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 16:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="15106951"
Received: from dongshen-mobl1.amr.corp.intel.com (HELO [10.212.116.150]) ([10.212.116.150])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 16:45:44 -0700
Message-ID: <dfce9f2e-2253-43b8-b94a-82585879f59d@intel.com>
Date: Thu, 21 Mar 2024 16:45:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 17/29] KVM: selftests: TDX: Add TDX MMIO reads test
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
 <20231212204647.2170650-18-sagis@google.com>
Content-Language: en-US
From: "Zhang, Dongsheng X" <dongsheng.x.zhang@intel.com>
In-Reply-To: <20231212204647.2170650-18-sagis@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2023 12:46 PM, Sagi Shahar wrote:
> The test verifies MMIO reads of various sizes from the host to the guest.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> ---
>  .../selftests/kvm/include/x86_64/tdx/tdcall.h |  2 +
>  .../selftests/kvm/include/x86_64/tdx/tdx.h    |  3 +
>  .../kvm/include/x86_64/tdx/test_util.h        | 23 +++++
>  .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 19 ++++
>  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 87 +++++++++++++++++++
>  5 files changed, 134 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> index b5e94b7c48fa..95fcdbd8404e 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
> @@ -9,6 +9,8 @@
>  
>  #define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
>  #define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
> +#define TDG_VP_VMCALL_VE_REQUEST_MMIO_READ 0
> +#define TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE 1
>  
>  #define TDG_VP_VMCALL_SUCCESS 0x0000000000000000
>  #define TDG_VP_VMCALL_INVALID_OPERAND 0x8000000000000000
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index b18e39d20498..13ce60df5684 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -12,6 +12,7 @@
>  #define TDG_VP_VMCALL_INSTRUCTION_IO 30
>  #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
>  #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
> +#define TDG_VP_VMCALL_VE_REQUEST_MMIO 48
>  
>  void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
>  uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
> @@ -22,5 +23,7 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
>  uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
>  uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
>  uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
> +uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
> +					uint64_t *data_out);
>  
>  #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> index 8a9b6a1bec3e..af412b764604 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
> @@ -35,6 +35,29 @@
>  			(VCPU)->run->io.direction);			\
>  	} while (0)
>  
> +
> +/**
> + * Assert that some MMIO operation involving TDG.VP.VMCALL <#VERequestMMIO> was
> + * called in the guest.
> + */
> +#define TDX_TEST_ASSERT_MMIO(VCPU, ADDR, SIZE, DIR)			\
> +	do {								\
> +		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_MMIO,	\
> +			"Got exit_reason other than KVM_EXIT_MMIO: %u (%s)\n", \
> +			(VCPU)->run->exit_reason,			\
> +			exit_reason_str((VCPU)->run->exit_reason));	\
> +									\
> +		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_MMIO) && \
> +			((VCPU)->run->mmio.phys_addr == (ADDR)) &&	\
> +			((VCPU)->run->mmio.len == (SIZE)) &&		\
> +			((VCPU)->run->mmio.is_write == (DIR)),		\
> +			"Got an unexpected MMIO exit values: %u (%s) %llu %d %d\n", \
> +			(VCPU)->run->exit_reason,			\
> +			exit_reason_str((VCPU)->run->exit_reason),	\
> +			(VCPU)->run->mmio.phys_addr, (VCPU)->run->mmio.len, \
> +			(VCPU)->run->mmio.is_write);			\
> +	} while (0)
> +
>  /**
>   * Check and report if there was some failure in the guest, either an exception
>   * like a triple fault, or if a tdx_test_fatal() was hit.
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index 9485bafedc38..b19f07ebc0e7 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -124,3 +124,22 @@ uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag)
>  
>  	return __tdx_hypercall(&args, 0);
>  }
> +
> +uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
> +					uint64_t *data_out)
> +{
> +	uint64_t ret;
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
> +		.r12 = size,
> +		.r13 = TDG_VP_VMCALL_VE_REQUEST_MMIO_READ,
> +		.r14 = address,
> +	};
> +
> +	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	if (data_out)
> +		*data_out = args.r11;
> +
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> index 5fae4c6e5f95..48902b69d13e 100644
> --- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> @@ -799,6 +799,92 @@ void verify_guest_hlt(void)
>  	_verify_guest_hlt(0);
>  }
>  
> +/* Pick any address that was not mapped into the guest to test MMIO */
> +#define TDX_MMIO_TEST_ADDR 0x200000000
> +
> +void guest_mmio_reads(void)
> +{
> +	uint64_t data;
> +	uint64_t ret;
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 1, &data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +	if (data != 0x12)
> +		tdx_test_fatal(1);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 2, &data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +	if (data != 0x1234)
> +		tdx_test_fatal(2);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 4, &data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +	if (data != 0x12345678)
> +		tdx_test_fatal(4);
> +
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 8, &data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +	if (data != 0x1234567890ABCDEF)
> +		tdx_test_fatal(8);
> +
> +	// Read an invalid number of bytes.
> +	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 10, &data);
> +	if (ret)
> +		tdx_test_fatal(ret);
> +
> +	tdx_test_success();
> +}
> +
> +/*
> + * Varifies guest MMIO reads.

Nit: typo?  Varifies ==> Verifies

> + */
> +void verify_mmio_reads(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_mmio_reads);
> +	td_finalize(vm);
> +
> +	printf("Verifying TD MMIO reads:\n");
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 1, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
> +	*(uint8_t *)vcpu->run->mmio.data = 0x12;
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 2, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
> +	*(uint16_t *)vcpu->run->mmio.data = 0x1234;
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 4, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
> +	*(uint32_t *)vcpu->run->mmio.data = 0x12345678;
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 8, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
> +	*(uint64_t *)vcpu->run->mmio.data = 0x1234567890ABCDEF;
> +
> +	td_vcpu_run(vcpu);
> +	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
> +	TEST_ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_SUCCESS(vcpu);
> +
> +	kvm_vm_free(vm);
> +	printf("\t ... PASSED\n");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	setbuf(stdout, NULL);
> @@ -818,6 +904,7 @@ int main(int argc, char **argv)
>  	run_in_new_process(&verify_guest_msr_writes);
>  	run_in_new_process(&verify_guest_msr_reads);
>  	run_in_new_process(&verify_guest_hlt);
> +	run_in_new_process(&verify_mmio_reads);
>  
>  	return 0;
>  }

