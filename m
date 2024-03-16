Return-Path: <linux-kselftest+bounces-6371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F8887D90E
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Mar 2024 07:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBB31F21B51
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Mar 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED49C79F3;
	Sat, 16 Mar 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NdSGXzFH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CDF9CF;
	Sat, 16 Mar 2024 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570298; cv=none; b=CAumLe2oIil73o/B2Z142c54fhCPWHeOYzXyGYMZgEbwENkoThC9+DdGVFi6jzL63tUeSYWMKQxVxt7nCE4zEX0ZCzHcAZypEHrOhXNWlaouu08Jgdy/nL1Daun5kae4WcEnONkZXplPNQYcft0MIqOBQAsuAelUb2Jn7ijHuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570298; c=relaxed/simple;
	bh=lpCmIOaWDW0lK0tO6FfNL6Zr9krWRVmzaB1o7KsbiFs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=FPPDJXGIdoffTTm4tXLpos5U6AMJSWVvQAPCcwf53GKoQofTeTuY8GPvBsAagC6Xvq/4nVMoJN71xQ6lsHrFQcWEZMALAa5zzgrW1lXBRRrR+51ZmGKPNZ+3H3MPmkjCmQNLXE3hOsVWylRMyfJt/oe2VcMSIXI7izQ+Hx5DMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NdSGXzFH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710570296; x=1742106296;
  h=message-id:date:mime-version:from:subject:to:references:
   cc:in-reply-to:content-transfer-encoding;
  bh=lpCmIOaWDW0lK0tO6FfNL6Zr9krWRVmzaB1o7KsbiFs=;
  b=NdSGXzFHXxDexDejLsM4r7C0ihhWfJ2biAENlIYvACI45eT81rArG37U
   kHwaYRxoObfg0DXNAczeciHHNvBw6IUU3ImhnGXomvHtmpJie+uTI+yJd
   xo/3JVJgwvSUsenlXAHl2o5dieleub6cyP75kAjOcPiGW6oUaUmlaCjKD
   GFl3Eb6sNAW/xgtsUxqE9h0R1EVN5lXySOnd9mXKFljjb7PowGN4QQ+Jo
   Oq3ft73cITozfSzJg1KqnYG76StOoE1xioUCuddYK5FCMBNbGp5RSb9LV
   MzbIpCE9fYJRPJdLEBiF7HRIfpArk1PtzmKCRwftGfSA/bYbM4vbDaJlL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="16099338"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="16099338"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 23:24:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="43953442"
Received: from jhanbaba-mobl.amr.corp.intel.com (HELO [10.124.36.86]) ([10.124.36.86])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 23:24:55 -0700
Message-ID: <548933c5-04aa-422c-9738-110ab5eb4ad4@intel.com>
Date: Fri, 15 Mar 2024 23:24:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Chen, Zide" <zide.chen@intel.com>
Subject: Re: [RFC PATCH v5 23/29] KVM: selftests: TDX: Add shared memory test
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 "Afranji, Ryan" <afranji@google.com>, "Aktas, Erdem"
 <erdemaktas@google.com>, Sagi Shahar <sagis@google.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-24-sagis@google.com>
 <DS7PR11MB7886AA5F8A19CDFCB5566B0EF6292@DS7PR11MB7886.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "Annapurve, Vishal" <vannapurve@google.com>,
 Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>,
 jmattson@google.com, dmatlack@google.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <DS7PR11MB7886AA5F8A19CDFCB5566B0EF6292@DS7PR11MB7886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2023 12:47 PM, Sagi Shahar wrote:
> 
> 
> -----Original Message-----
> From: Sagi Shahar <sagis@google.com> 
> Sent: Tuesday, December 12, 2023 12:47 PM
> To: linux-kselftest@vger.kernel.org; Ackerley Tng <ackerleytng@google.com>; Afranji, Ryan <afranji@google.com>; Aktas, Erdem <erdemaktas@google.com>; Sagi Shahar <sagis@google.com>; Yamahata, Isaku <isaku.yamahata@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>; Paolo Bonzini <pbonzini@redhat.com>; Shuah Khan <shuah@kernel.org>; Peter Gonda <pgonda@google.com>; Xu, Haibo1 <haibo1.xu@intel.com>; Chao Peng <chao.p.peng@linux.intel.com>; Annapurve, Vishal <vannapurve@google.com>; Roger Wang <runanwang@google.com>; Vipin Sharma <vipinsh@google.com>; jmattson@google.com; dmatlack@google.com; linux-kernel@vger.kernel.org; kvm@vger.kernel.org; linux-mm@kvack.org
> Subject: [RFC PATCH v5 23/29] KVM: selftests: TDX: Add shared memory test
> 
> From: Ryan Afranji <afranji@google.com>
> 
> Adds a test that sets up shared memory between the host and guest.
> 
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/x86_64/tdx/tdx.h    |   2 +
>  .../kvm/include/x86_64/tdx/tdx_util.h         |   2 +
>  .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  26 ++++
>  .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  25 ++++
>  .../kvm/x86_64/tdx_shared_mem_test.c          | 135 ++++++++++++++++++
>  6 files changed, 191 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 80d4a50eeb9f..8c0a6b395ee5 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -156,6 +156,7 @@ TEST_GEN_PROGS_x86_64 += steal_time
>  TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
>  TEST_GEN_PROGS_x86_64 += system_counter_offset_test
>  TEST_GEN_PROGS_x86_64 += x86_64/tdx_vm_tests
> +TEST_GEN_PROGS_x86_64 += x86_64/tdx_shared_mem_test
>  
>  # Compiled outputs used by test targets
>  TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> index 6b176de1e795..db4cc62abb5d 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
> @@ -8,6 +8,7 @@
>  #define TDG_VP_INFO 1
>  
>  #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
> +#define TDG_VP_VMCALL_MAP_GPA 0x10001
>  #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
>  
>  #define TDG_VP_VMCALL_INSTRUCTION_CPUID 10 @@ -36,5 +37,6 @@ uint64_t tdg_vp_vmcall_instruction_cpuid(uint32_t eax, uint32_t ecx,  uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
>  		     uint64_t *r8, uint64_t *r9,
>  		     uint64_t *r10, uint64_t *r11);
> +uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, 
> +uint64_t *data_out);
>  
>  #endif // SELFTEST_TDX_TDX_H
> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> index 32dd6b8fda46..3e850ecb85a6 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
> @@ -13,5 +13,7 @@ void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  		   uint64_t attributes);
>  void td_finalize(struct kvm_vm *vm);
>  void td_vcpu_run(struct kvm_vcpu *vcpu);
> +void handle_memory_conversion(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
> +			bool shared_to_private);
>  
>  #endif // SELFTESTS_TDX_KVM_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> index bcd9cceb3372..061a5c0bef34 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> @@ -4,9 +4,11 @@
>  
>  #include "tdx/tdcall.h"
>  #include "tdx/tdx.h"
> +#include "tdx/tdx_util.h"
>  
>  void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)  {
> +	struct kvm_vm *vm = vcpu->vm;
>  	struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
>  	uint64_t vmcall_subfunction = vmcall_info->subfunction;
>  
> @@ -20,6 +22,14 @@ void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
>  		vcpu->run->system_event.data[2] = vmcall_info->in_r13;
>  		vmcall_info->status_code = 0;
>  		break;
> +	case TDG_VP_VMCALL_MAP_GPA:
> +		uint64_t gpa = vmcall_info->in_r12 & ~vm->arch.s_bit;
> +		bool shared_to_private = !(vm->arch.s_bit &
> +					   vmcall_info->in_r12);
> +		handle_memory_conversion(vm, gpa, vmcall_info->in_r13,
> +					 shared_to_private);
> +		vmcall_info->status_code = 0;
> +		break;
>  	default:
>  		TEST_FAIL("TD VMCALL subfunction %lu is unsupported.\n",
>  			  vmcall_subfunction);
> @@ -210,3 +220,19 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
>  
>  	return ret;
>  }
> +
> +uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, 
> +uint64_t *data_out) {
> +	uint64_t ret;
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_MAP_GPA,
> +		.r12 = address,
> +		.r13 = size
> +	};
> +
> +	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	if (data_out)
> +		*data_out = args.r11;
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> index d745bb6287c1..92fa6bd13229 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
> @@ -531,3 +531,28 @@ void td_vcpu_run(struct kvm_vcpu *vcpu)
>  		handle_userspace_tdg_vp_vmcall_exit(vcpu);
>  	}
>  }
> +
> +/**
> + * Handle conversion of memory with @size beginning @gpa for @vm. Set
> + * @shared_to_private to true for shared to private conversions and 
> +false
> + * otherwise.
> + *
> + * Since this is just for selftests, we will just keep both pieces of 
> +backing
> + * memory allocated and not deallocate/allocate memory; we'll just do 
> +the
> + * minimum of calling KVM_MEMORY_ENCRYPT_REG_REGION and
> + * KVM_MEMORY_ENCRYPT_UNREG_REGION.
> + */
> +void handle_memory_conversion(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
> +			bool shared_to_private)
> +{
> +	struct kvm_memory_attributes range;
> +
> +	range.address = gpa;
> +	range.size = size;
> +	range.attributes = shared_to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE : 0;
> +	range.flags = 0;
> +
> +	printf("\t ... calling KVM_SET_MEMORY_ATTRIBUTES ioctl with gpa=%#lx, 
> +size=%#lx, attributes=%#llx\n", gpa, size, range.attributes);
> +
> +	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &range); }
> diff --git a/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c b/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c
> new file mode 100644
> index 000000000000..ba6bdc470270
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/kvm.h>
> +#include <stdint.h>
> +
> +#include "kvm_util_base.h"
> +#include "processor.h"
> +#include "tdx/tdcall.h"
> +#include "tdx/tdx.h"
> +#include "tdx/tdx_util.h"
> +#include "tdx/test_util.h"
> +#include "test_util.h"
> +
> +#define TDX_SHARED_MEM_TEST_PRIVATE_GVA (0x80000000) #define 
> +TDX_SHARED_MEM_TEST_VADDR_SHARED_MASK BIT_ULL(30)
> +#define TDX_SHARED_MEM_TEST_SHARED_GVA     \
> +	(TDX_SHARED_MEM_TEST_PRIVATE_GVA | \
> +	 TDX_SHARED_MEM_TEST_VADDR_SHARED_MASK)
> +
> +#define TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE (0xcafecafe) #define 
> +TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE (0xabcdabcd)
> +
> +#define TDX_SHARED_MEM_TEST_INFO_PORT 0x87
> +
> +/*
> + * Shared variables between guest and host  */ static uint64_t 
> +test_mem_private_gpa; static uint64_t test_mem_shared_gpa;
> +
> +void guest_shared_mem(void)
> +{
> +	uint32_t *test_mem_shared_gva =
> +		(uint32_t *)TDX_SHARED_MEM_TEST_SHARED_GVA;
> +
> +	uint64_t placeholder;
> +	uint64_t ret;
> +
> +	/* Map gpa as shared */
> +	ret = tdg_vp_vmcall_map_gpa(test_mem_shared_gpa, PAGE_SIZE,
> +				    &placeholder);
> +	if (ret)
> +		tdx_test_fatal_with_data(ret, __LINE__);
> +
> +	*test_mem_shared_gva = TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE;
> +
> +	/* Exit so host can read shared value */
> +	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> +					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					   &placeholder);
> +	if (ret)
> +		tdx_test_fatal_with_data(ret, __LINE__);
> +
> +	/* Read value written by host and send it back out for verification */
> +	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> +					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
> +					   (uint64_t *)test_mem_shared_gva);
> +	if (ret)
> +		tdx_test_fatal_with_data(ret, __LINE__); }
> +
> +int verify_shared_mem(void)
> +{
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +
> +	vm_vaddr_t test_mem_private_gva;
> +	uint32_t *test_mem_hva;
> +
> +	vm = td_create();
> +	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
> +	vcpu = td_vcpu_add(vm, 0, guest_shared_mem);
> +
> +	/*
> +	 * Set up shared memory page for testing by first allocating as private
> +	 * and then mapping the same GPA again as shared. This way, the TD does
> +	 * not have to remap its page tables at runtime.
> +	 */
> +	test_mem_private_gva = vm_vaddr_alloc(vm, vm->page_size,
> +					      TDX_SHARED_MEM_TEST_PRIVATE_GVA);
> +	TEST_ASSERT_EQ(test_mem_private_gva, TDX_SHARED_MEM_TEST_PRIVATE_GVA);
> +
> +	test_mem_hva = addr_gva2hva(vm, test_mem_private_gva);
> +	TEST_ASSERT(test_mem_hva != NULL,
> +		    "Guest address not found in guest memory regions\n");
> +
> +	test_mem_private_gpa = addr_gva2gpa(vm, test_mem_private_gva);
> +	virt_pg_map_shared(vm, TDX_SHARED_MEM_TEST_SHARED_GVA,
> +			   test_mem_private_gpa);

As mentioned in the comments in [PATCH 22/29], how about replacing
virt_pg_map_shared() with the following?

  vm_phy_pages_conversion();  // new API to update protected_phy_pages
  virt_pg_map(); // set s_bit according to protected_phy_pages
 > +
> +	test_mem_shared_gpa = test_mem_private_gpa | BIT_ULL(vm->pa_bits - 1);
> +	sync_global_to_guest(vm, test_mem_private_gpa);
> +	sync_global_to_guest(vm, test_mem_shared_gpa);
> +
> +	td_finalize(vm);
> +
> +	printf("Verifying shared memory accesses for TDX\n");
> +
> +	/* Begin guest execution; guest writes to shared memory. */
> +	printf("\t ... Starting guest execution\n");
> +
> +	/* Handle map gpa as shared */
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
> +
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> +			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE);
> +
> +	*test_mem_hva = TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE;
> +	td_vcpu_run(vcpu);
> +	TDX_TEST_ASSERT_IO(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> +			   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
> +	TEST_ASSERT_EQ(
> +		*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE);
> +
> +	printf("\t ... PASSED\n");
> +
> +	kvm_vm_free(vm);
> +
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	if (!is_tdx_enabled()) {
> +		printf("TDX is not supported by the KVM\n"
> +		       "Skipping the TDX tests.\n");
> +		return 0;
> +	}
> +
> +	return verify_shared_mem();
> +}
> --
> 2.43.0.472.g3155946c3a-goog
> 

