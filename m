Return-Path: <linux-kselftest+bounces-43571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3039BF2B3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 19:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A93E1899F8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012B1330D34;
	Mon, 20 Oct 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hg22YaG+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889F32F74C
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981218; cv=none; b=E1dI5p4konPYtQt1ETm4m/PT0ZfYqyZGdp4BhEhQlZmFdg3EZnpVVQZ9HYM5ng3hD5itwBJWFyZipAof0+7UKWdlmfSbmfklqYwcMPjMZlUjGl7AB+nuwf759/Ix+pQPlpJ59o57LIP1+LE4iWHvvomVvCE3vmOMzhLMn88F278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981218; c=relaxed/simple;
	bh=WELJG3EefeS4+jZAAr3Y0erGnXwGX0GfmBf0DojCpvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT7OPDzsax/ANMLO3o3BxMibhEmWNCchw+i0ljVJchkQ6UaRzIGTzKkxkkIu1AmmZ5d4/x1wtNE0GpODODwdA3OTQ/jpZsu7hQIgaCcc2gdzAVLAXeig25ENvyU6EO2TTpMKb8ML6u2n99ZBKDCpEdu7wL0vkN7kWE247gvTKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hg22YaG+; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 20 Oct 2025 17:26:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BtZGkLKr3gOVteNjftvPjbbitGBqfKbhGDs2rAE/yFE=;
	b=hg22YaG+8MmAWS8RPCbEncbMck4iCNpkWOKiAoxHcUGULGrH3KubLz2kS8hDBB6/RYwtRX
	SjPElmlUNdvUiNykx30qP+UQb0WYT1nW6ABsobuG62MnbMq2hm2qiWfXOAPA2sW3pw5jwf
	jprnRmU0cMhSa7xNjh8vFL32tYsA35k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: selftests: Add a VMX test for LA57 nested state
Message-ID: <4owz4js4mvl4dohgkydcyrdhh2j2xblbwbo7zistocb4knjzdo@kvrzl7vmvg67>
References: <20250917215031.2567566-1-jmattson@google.com>
 <20250917215031.2567566-5-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917215031.2567566-5-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 17, 2025 at 02:48:40PM -0700, Jim Mattson wrote:
> Add a selftest that verifies KVM's ability to save and restore
> nested state when the L1 guest is using 5-level paging and the L2
> guest is using 4-level paging. Specifically, canonicality tests of
> the VMCS12 host-state fields should accept 57-bit virtual addresses.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../kvm/x86/vmx_la57_nested_state_test.c      | 137 ++++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 41b40c676d7f..f1958b88ec59 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -116,6 +116,7 @@ TEST_GEN_PROGS_x86 += x86/vmx_exception_with_invalid_guest_state
>  TEST_GEN_PROGS_x86 += x86/vmx_msrs_test
>  TEST_GEN_PROGS_x86 += x86/vmx_invalid_nested_guest_state
>  TEST_GEN_PROGS_x86 += x86/vmx_set_nested_state_test
> +TEST_GEN_PROGS_x86 += x86/vmx_la57_nested_state_test
>  TEST_GEN_PROGS_x86 += x86/vmx_tsc_adjust_test
>  TEST_GEN_PROGS_x86 += x86/vmx_nested_tsc_scaling_test
>  TEST_GEN_PROGS_x86 += x86/apic_bus_clock_test
> diff --git a/tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c b/tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c
> new file mode 100644
> index 000000000000..7c3c4c1c17f6
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/vmx_la57_nested_state_test.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vmx_la57_nested_state_test
> + *
> + * Copyright (C) 2025, Google LLC.
> + *
> + * Test KVM's ability to save and restore nested state when the L1 guest
> + * is using 5-level paging and the L2 guest is using 4-level paging.
> + *
> + * This test would have failed prior to commit 9245fd6b8531 ("KVM: x86:
> + * model canonical checks more precisely").
> + */
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "vmx.h"
> +
> +#define LA57_GS_BASE 0xff2bc0311fb00000ull
> +
> +static void l2_guest_code(void)
> +{
> +	/*
> +	 * Sync with L0 to trigger save/restore.  After
> +	 * resuming, execute VMCALL to exit back to L1.
> +	 */
> +	GUEST_SYNC(1);
> +	vmcall();
> +}
> +
> +static void l1_guest_code(struct vmx_pages *vmx_pages)
> +{
> +#define L2_GUEST_STACK_SIZE 64
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +	u64 guest_cr4;
> +	vm_paddr_t pml5_pa, pml4_pa;
> +	u64 *pml5;
> +	u64 exit_reason;
> +
> +	/* Set GS_BASE to a value that is only canonical with LA57. */
> +	wrmsr(MSR_GS_BASE, LA57_GS_BASE);
> +	GUEST_ASSERT(rdmsr(MSR_GS_BASE) == LA57_GS_BASE);
> +
> +	GUEST_ASSERT(vmx_pages->vmcs_gpa);
> +	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
> +	GUEST_ASSERT(load_vmcs(vmx_pages));
> +
> +	prepare_vmcs(vmx_pages, l2_guest_code,
> +		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +
> +	/*
> +	 * Set up L2 with a 4-level page table by pointing its CR3 to L1's
> +	 * PML4 table and clearing CR4.LA57. This creates the CR4.LA57
> +	 * mismatch that exercises the bug.
> +	 */
> +	pml5_pa = get_cr3() & PHYSICAL_PAGE_MASK;
> +	pml5 = (u64 *)pml5_pa;
> +	pml4_pa = pml5[0] & PHYSICAL_PAGE_MASK;
> +	vmwrite(GUEST_CR3, pml4_pa);

Clever :)

> +
> +	guest_cr4 = vmreadz(GUEST_CR4);
> +	guest_cr4 &= ~X86_CR4_LA57;
> +	vmwrite(GUEST_CR4, guest_cr4);
> +
> +	GUEST_ASSERT(!vmlaunch());
> +
> +	exit_reason = vmreadz(VM_EXIT_REASON);
> +	GUEST_ASSERT(exit_reason == EXIT_REASON_VMCALL);
> +}
> +
> +void guest_code(struct vmx_pages *vmx_pages)
> +{
> +	if (vmx_pages)
> +		l1_guest_code(vmx_pages);

I think none of the other tests do the NULL check. Seems like the test
will actually pass if we pass vmx_pages == NULL. I think it's better if
we let L1 crash if we mess up the setup.

> +
> +	GUEST_DONE();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	vm_vaddr_t vmx_pages_gva = 0;
> +	struct kvm_vm *vm;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_x86_state *state;
> +	struct ucall uc;
> +	int stage;
> +
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_LA57));
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> +
> +	vm = vm_create_shape_with_one_vcpu(VM_SHAPE(VM_MODE_PXXV57_4K), &vcpu,
> +					   guest_code);
> +
> +	/*
> +	 * L1 needs to read its own PML5 table to set up L2. Identity map
> +	 * the PML5 table to facilitate this.
> +	 */
> +	virt_map(vm, vm->pgd, vm->pgd, 1);
> +
> +	vcpu_alloc_vmx(vm, &vmx_pages_gva);
> +	vcpu_args_set(vcpu, 1, vmx_pages_gva);
> +
> +	for (stage = 1;; stage++) {
> +		vcpu_run(vcpu);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			/* NOT REACHED */
> +		case UCALL_SYNC:
> +			break;
> +		case UCALL_DONE:
> +			goto done;
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +		}
> +
> +		TEST_ASSERT(uc.args[1] == stage,
> +			    "Expected stage %d, got stage %lu", stage, (ulong)uc.args[1]);
> +		if (stage == 1) {
> +			pr_info("L2 is active; performing save/restore.\n");
> +			state = vcpu_save_state(vcpu);
> +
> +			kvm_vm_release(vm);
> +
> +			/* Restore state in a new VM. */
> +			vcpu = vm_recreate_with_one_vcpu(vm);
> +			vcpu_load_state(vcpu, state);
> +			kvm_x86_state_cleanup(state);

It seems like we only load the vCPU state but we don't actually run it
after restoring the nested state. Should we have another stage and run
L2 again after the restore? What is the current failure mode without
9245fd6b8531?

> +		}
> +	}
> +
> +done:
> +	kvm_vm_free(vm);
> +	return 0;
> +}
> -- 
> 2.51.0.470.ga7dc726c21-goog
> 

