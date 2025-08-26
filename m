Return-Path: <linux-kselftest+bounces-39929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB6DB3572D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 10:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812C87C07F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCC62FA0F5;
	Tue, 26 Aug 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGxx9teU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65332F999A;
	Tue, 26 Aug 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197375; cv=none; b=JbqdNRaaekXXEqOrYDrLUXN4LIi1Q4LPrnusylWScEh4hel1Pc+YaujBdcsb4U15s14xJmBfuE8lZoH53Bs+JKmQyTmoTco13m1ovKZQcEsL16W1qISbXE+EQwRArPpyXqygVDKE5Sx1Y1B4z93pemmG7Thkvp5WKfnXlkd6ugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197375; c=relaxed/simple;
	bh=EbLQ97b8PErNSuIZFoGI4dV9QmzWKG+TQPnk+dkI9AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DP4xo6RMMkgPx/yQKeF4VWzZQyZviUrWJfIcAUwaGzacsHj3BIi0IlBx64GDjMFNmd7fvX24i2lmCDv4tVKvVzL9mepIhT5wxRscFj8nzwVvzz/f1+UjSFRBu7MBrnHhAmf1XoSEHes8+g4x2ZwDAZYGyg6KM9KW2LfGP2W52jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGxx9teU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756197374; x=1787733374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EbLQ97b8PErNSuIZFoGI4dV9QmzWKG+TQPnk+dkI9AU=;
  b=YGxx9teU74CU/qux7pB/7hQqtGq6GSdT+qx0bOjPKKbQOBUKjpsqSObv
   3BU2L7pU1Lbm3RE5pkRTDEMyIOEnoAdRf+vdsj/d3F9F+6QKekEKQHj6l
   2L74Bkj/AHGtTO6aH/QpbjTYIOLVl2xoszRT3YDT1V+qURwzJviufdqA+
   YkOyjF0HL7y1xMed0ixmjE4k/nOHTVws4lL+t7pR5waiFDdo/Kxr+qJgI
   qz/CvsndNjzuQrb4xlx5gMPs9I1EuwtqWQUw8aH+LOgEGIcFFqUd4O8EA
   xRvWxX8LkHxmWq+W/L/UB6+D7s5Ax8O6c228Grkdr87G19/OQP4CTgiM+
   w==;
X-CSE-ConnectionGUID: PQ8Rwg/TQoKml6frNFLkLw==
X-CSE-MsgGUID: MDsfeYwqS+e+UNs1gQRFUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="76024764"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="76024764"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 01:36:08 -0700
X-CSE-ConnectionGUID: NgwgneslRjSkYUViKKazFw==
X-CSE-MsgGUID: qNFBfAs3Sfezqno7284PLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="193189796"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 01:36:03 -0700
Message-ID: <8437255a-635d-4712-834a-fc8c02890d00@linux.intel.com>
Date: Tue, 26 Aug 2025 16:36:00 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/19] KVM: selftests: Set up TDX boot parameters
 region
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
 <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-12-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250821042915.3712925-12-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> Allocate memory for TDX boot parameters and define the utility functions
> necessary to fill this memory with the boot parameters.
>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  4 +
>   .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 73 +++++++++++++++++++
>   2 files changed, 77 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> index ec05bcd59145..dafdc7e46abe 100644
> --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -12,5 +12,9 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
>   }
>   
>   void vm_tdx_setup_boot_code_region(struct kvm_vm *vm);
> +void vm_tdx_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t nr_runnable_vcpus);
> +void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
> +void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
> +void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
>   
>   #endif // SELFTESTS_TDX_TDX_UTIL_H
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 15833b9eb5d5..52dc25e0cce4 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -5,10 +5,12 @@
>   #include "kvm_util.h"
>   #include "processor.h"
>   #include "tdx/td_boot.h"
> +#include "tdx/td_boot_asm.h"
>   #include "tdx/tdx_util.h"
>   
>   /* Arbitrarily selected to avoid overlaps with anything else */
>   #define TD_BOOT_CODE_SLOT	20
> +#define TD_BOOT_PARAMETERS_SLOT	21
>   
>   #define X86_RESET_VECTOR	0xfffffff0ul
>   #define X86_RESET_VECTOR_SIZE	16
> @@ -52,3 +54,74 @@ void vm_tdx_setup_boot_code_region(struct kvm_vm *vm)
>   	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;
>   	hva[2] = 0xcc;
>   }
> +
> +void vm_tdx_setup_boot_parameters_region(struct kvm_vm *vm, uint32_t nr_runnable_vcpus)
> +{
> +	size_t boot_params_size =
> +		sizeof(struct td_boot_parameters) +
> +		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
> +	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
> +	vm_paddr_t gpa;
> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +				    TD_BOOT_PARAMETERS_GPA,
> +				    TD_BOOT_PARAMETERS_SLOT, npages,
> +				    KVM_MEM_GUEST_MEMFD);
> +	gpa = vm_phy_pages_alloc(vm, npages, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_SLOT);
> +	TEST_ASSERT(gpa == TD_BOOT_PARAMETERS_GPA, "Failed vm_phy_pages_alloc\n");
> +
> +	virt_map(vm, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_GPA, npages);
> +}
> +
> +void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm)
> +{
> +	struct td_boot_parameters *params =
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	uint32_t cr4;
> +
> +	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
> +
> +	cr4 = kvm_get_default_cr4();
> +
> +	/* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
> +	cr4 |= X86_CR4_MCE;
> +
> +	/* Set this because UEFI also sets this up, to handle XMM exceptions */
> +	cr4 |= X86_CR4_OSXMMEXCPT;
> +
> +	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
> +	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
> +
> +	/* Set parameters! */
> +	params->cr0 = kvm_get_default_cr0();
> +	params->cr3 = vm->pgd;
> +	params->cr4 = cr4;
> +	params->idtr.base = vm->arch.idt;
> +	params->idtr.limit = kvm_get_default_idt_limit();
> +	params->gdtr.base = vm->arch.gdt;
> +	params->gdtr.limit = kvm_get_default_gdt_limit();
> +
> +	TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
> +	TEST_ASSERT(params->cr3 != 0, "cr3 should not be 0");
> +	TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");
> +	TEST_ASSERT(params->gdtr.base != 0, "gdt base address should not be 0");
> +	TEST_ASSERT(params->idtr.base != 0, "idt base address should not be 0");
> +}
> +
> +void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct td_boot_parameters *params =
> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
> +	struct td_per_vcpu_parameters *vcpu_params =
> +		&params->per_vcpu[vcpu->id];

Nit: Better to align the style on whether wrap or not due to max characters per
line

> +
> +	vcpu_params->esp_gva = kvm_allocate_vcpu_stack(vm);
> +}
> +
> +void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
> +{
> +	struct td_boot_parameters *params = addr_gpa2hva(vcpu->vm, TD_BOOT_PARAMETERS_GPA);
> +	struct td_per_vcpu_parameters *vcpu_params = &params->per_vcpu[vcpu->id];
> +
> +	vcpu_params->guest_code = (uint64_t)guest_code;
> +}


