Return-Path: <linux-kselftest+bounces-38713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75769B21709
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758E046473F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 21:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750062E2DE9;
	Mon, 11 Aug 2025 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/zKY0Dy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30202E2830
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946418; cv=none; b=LfnketXBKfAstXR2futJVTHTTQzURHUCT/5iLscuXE66jRWqizEhCk1bshqQLNpmdhiA/8WqJyMjrdtLygzmXpFCFjH457hMO2xoQnWl9DDWiND6KU+GAnOaNhyyq+LNyveyWAnYAjM9/J6mcngJ1Dctv8lnLffAmenzxIsWmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946418; c=relaxed/simple;
	bh=Cx4n43N5rT7tm26Zi/Wl9s0WML/Y54o9a9g7SG7hNi8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JVav0c1Yr2YxnG7QOjieH59rAEWfrJvgaflrDF1ZpKztXiKzZx/HdstG99a4Hv7kij7YnE5ENLXHw1mSCpBzlTn10n/ldeR+QTT7dYbHiHkTbnCx+gC/yA/2d48iTNT7r/FY9HFLKkNyf7x9wciizFceqipWvJ6xms69IHBl5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/zKY0Dy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31eac278794so4576450a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754946416; x=1755551216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hA2AeNbIBZstfZYB1c7+ojqp0Nun86T8R6LZcf4kSAI=;
        b=p/zKY0DyH1xx5VnMrlT3w59pKjjaKJwF50i7zNGMsRW71kQhibFV71HG6/Z+kbIATc
         5USWmiO+EM76vu2lhZHlPssI34prr/jM3xK5yKQyzFA13L39QiJueE7MkHeHEqG+Yrfn
         U0xALIKm9oDH7a/hGbYAKCGbIqvy2QUzb3OmkRhomPIJQQgKTYaCRqrz+akfrXNudISc
         7T6CIIa27GbIDHSXjwZR0QIg5HFRmQlP6S9pjKYGkme+jSUO2hshnaVeMI2F9SZKDtHZ
         0d+Ixe9SDiPo0YrXSU2ExZVo9fPPOzRoIgALD/ZbXXH2xbUPxllB97jWcWShWCK1UjN4
         +VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946416; x=1755551216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hA2AeNbIBZstfZYB1c7+ojqp0Nun86T8R6LZcf4kSAI=;
        b=cRKgyQpu5IOmadcUzFt+DHLOtVYkyLOS/zDwfFAKiLR3BdbTZdtfrnGeSeiP6uaBOD
         8E6iGLXJ+AIc/rBHA/Az6RN3SZRyIYUWak8V9awz0rv4E20keiAi1kd29y0tkOhN9GX9
         XEvpVB8i5kS0L+BR14/O3AB8pnrtZD8bQETucCd0BgC0gjhvb7O0cTmlVC9fGajankcN
         aXqjFpf8+PxGFhoEa9gAFIFqpdIgm95mXLr15QMiLkflZi0zMjwyvInMZer9Un0/e54F
         5ZWxiz6CL7wAIlpzeYaPVEvZoIJLgAebwwHBw2yCV4/guT8Se2wa0e88lYjPqtX3Ekr+
         x4ng==
X-Gm-Message-State: AOJu0YwktslCCfTLOqvpVrOSQB/msUVhIZyuiZqHR0EaDqipWzbcZ2g6
	eC0aprA4DVcwVdfJsRa4jUrnwOhoV2zCYyuRSSNJn9F4uWWsi1rgc97Nyl/+1svstIGX5pE0eiv
	m/IjnyQ==
X-Google-Smtp-Source: AGHT+IHb7VuPqjPmQofVIr8Tq+0i5bRZmt7Sf17RzX2nxgD/7A0XMQXoX3ALWil3/vaD1rDqddzVRDvIBn8=
X-Received: from pjph9.prod.google.com ([2002:a17:90a:9c09:b0:320:e3e2:6877])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48ce:b0:31e:d643:6cb9
 with SMTP id 98e67ed59e1d1-321c0a67decmr1163778a91.1.1754946415981; Mon, 11
 Aug 2025 14:06:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:06:54 -0700
In-Reply-To: <20250807201628.1185915-25-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-25-sagis@google.com>
Message-ID: <aJpbbqsW_LIu2exc@google.com>
Subject: Re: [PATCH v8 24/30] KVM: selftests: TDX: Add shared memory test
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 07, 2025, Sagi Shahar wrote:
> @@ -189,3 +199,19 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
>  
>  	return ret;
>  }
> +
> +uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r11 = TDG_VP_VMCALL_MAP_GPA,
> +		.r12 = address,
> +		.r13 = size
> +	};
> +	uint64_t ret;
> +
> +	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	if (data_out)
> +		*data_out = args.r11;
> +	return ret;

Assert instead of returning the error.  If there's a use for negative tests, then
add a double-underscores variant.  And drop @data_out, IIUC, it's only relevant
on failure.

> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 5e4455be828a..c5bee67099c5 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -608,4 +608,36 @@ void td_finalize(struct kvm_vm *vm)
>  void td_vcpu_run(struct kvm_vcpu *vcpu)
>  {
>  	vcpu_run(vcpu);
> +
> +	/* Handle TD VMCALLs that require userspace handling. */
> +	if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL &&
> +	    vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE) {

Unnecessary curly braces.

> +		handle_userspace_map_gpa(vcpu);
> +	}
> +}
> +
> +/*
> + * Handle conversion of memory with @size beginning @gpa for @vm. Set
> + * @shared_to_private to true for shared to private conversions and false
> + * otherwise.
> + *
> + * Since this is just for selftests, just keep both pieces of backing
> + * memory allocated and not deallocate/allocate memory; just do the
> + * minimum of calling KVM_MEMORY_ENCRYPT_REG_REGION and
> + * KVM_MEMORY_ENCRYPT_UNREG_REGION.
> + */
> +void handle_memory_conversion(struct kvm_vm *vm, uint32_t vcpu_id, uint64_t gpa,
> +			      uint64_t size, bool shared_to_private)

So, vm_set_memory_attributes()?

> +{
> +	struct kvm_memory_attributes range;
> +
> +	range.address = gpa;
> +	range.size = size;
> +	range.attributes = shared_to_private ? KVM_MEMORY_ATTRIBUTE_PRIVATE : 0;
> +	range.flags = 0;
> +
> +	pr_debug("\t... call KVM_SET_MEMORY_ATTRIBUTES ioctl from vCPU %u with gpa=%#lx, size=%#lx, attributes=%#llx\n",
> +		 vcpu_id, gpa, size, range.attributes);

Drop these types of prints.  strace can probably do the job 99% of the time, and
for the remaining 1%, I doubt this help all that much.

> +
> +	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &range);
>  }
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
> +					   PORT_WRITE, &placeholder);
> +	if (ret)

GUEST_ASSERT().  Don't use TDX's "fatal error" crud to report test failures.

> +		tdx_test_fatal_with_data(ret, __LINE__);
> +
> +	/* Read value written by host and send it back out for verification */
> +	ret = tdg_vp_vmcall_instruction_io(TDX_SHARED_MEM_TEST_INFO_PORT, 4,
> +					   PORT_WRITE,
> +					   (uint64_t *)test_mem_shared_gva);
> +	if (ret)
> +		tdx_test_fatal_with_data(ret, __LINE__);
> +}
> +
> +int verify_shared_mem(void)
> +{
> +	vm_vaddr_t test_mem_private_gva;
> +	uint64_t test_mem_private_gpa;
> +	uint32_t *test_mem_hva;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
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
> +	TEST_ASSERT(test_mem_hva,
> +		    "Guest address not found in guest memory regions\n");
> +
> +	test_mem_private_gpa = addr_gva2gpa(vm, test_mem_private_gva);
> +	virt_map_shared(vm, TDX_SHARED_MEM_TEST_SHARED_GVA, test_mem_private_gpa, 1);
> +
> +	test_mem_shared_gpa = test_mem_private_gpa | vm->arch.s_bit;
> +	sync_global_to_guest(vm, test_mem_shared_gpa);
> +
> +	td_finalize(vm);
> +
> +	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, BIT_ULL(KVM_HC_MAP_GPA_RANGE));
> +
> +	printf("Verifying shared memory accesses for TDX\n");
> +
> +	/* Begin guest execution; guest writes to shared memory. */
> +	printf("\t ... Starting guest execution\n");
> +
> +	/* Handle map gpa as shared */
> +	tdx_run(vcpu);
> +
> +	tdx_run(vcpu);
> +	tdx_test_assert_io(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4, PORT_WRITE);

AFAICT, there's nothing TDX-specific about these assert helpers.  And I would
prefer they be macros; while ugly, macros provide precise file+line information,
i.e. don't require a stack trace.

Maybe TEST_ASSERT_EXIT_IO() and TEST_ASSERT_EXIT_MMIO()?

> +	TEST_ASSERT_EQ(*test_mem_hva, TDX_SHARED_MEM_TEST_GUEST_WRITE_VALUE);
> +
> +	*test_mem_hva = TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE;
> +	tdx_run(vcpu);
> +	tdx_test_assert_io(vcpu, TDX_SHARED_MEM_TEST_INFO_PORT, 4, PORT_WRITE);
> +	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
> +		       TDX_SHARED_MEM_TEST_HOST_WRITE_VALUE);
> +
> +	printf("\t ... PASSED\n");

No.  Printing PASSED is worse than useless.  Exit codes exist for a reason; this
is pure spam.  pr_debug() if necessary, but all of these printfs can probably be
dropped.

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

TEST_REQUIRE()

> +	}
> +
> +	return verify_shared_mem();
> +}
> -- 
> 2.51.0.rc0.155.g4a0f42376b-goog
> 

