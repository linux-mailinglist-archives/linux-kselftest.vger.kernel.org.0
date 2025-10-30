Return-Path: <linux-kselftest+bounces-44387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB59C1E867
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 07:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8A03B7000
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 06:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB8F239086;
	Thu, 30 Oct 2025 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIs8y6JU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C182EA48F;
	Thu, 30 Oct 2025 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804911; cv=none; b=gpEm1ZePjKIL2PgEjtByARj4Yvdp1uHvaGxAgK2Nd1cNhAUP0P+qE/w5l5TbT1AixSwaoib2uBkCr2iYradvgACdStdcd4tkpFsyiZiCkag/3npbjE5w9YPpcd+CiswBImNxHhMNydwIjcH3rM5/LOk2A81N30FNEdA/dGyhX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804911; c=relaxed/simple;
	bh=krbFrkVMXm7p51EYFhLIkyy0cwGkTFQDJkzyAdJkSb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJtVkk4pHL4XkIIoxGd4kluoUc7DDkiikiuJmk8glNLxd2ZyD6MGi2GAf7DIFCkgxBIFQ7DokWdVsEtiIKXjP2sZQPGyOjVxU0xU3r4kGQO5NQt9J5ZA98Tjx7KQYz8EIQ7dTBhgBf/9fcD9m+JtWYF/3uTe9qag7Ih5j9C0te0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIs8y6JU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761804910; x=1793340910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=krbFrkVMXm7p51EYFhLIkyy0cwGkTFQDJkzyAdJkSb8=;
  b=TIs8y6JU3alIS1oQYr5IqODYSKw/Toxr385fuaY9zjtznfSx8uhs+k8S
   iK2RjFauc4re/hiLH2mHy3BsoI1jvdpws2xRkgHGl9nJBrkkO0Tsqwhra
   nEqJKTSipWBK9ldpfGBxBrVi0sAr/b9CRJyWGwIecXyO5CVckYmA8HaUZ
   2nOcfM0laf4EdeqWvvXvvNUpFTDo/2CesRuz9oMnWTUVwH+/9b8x+cIax
   PCl/HAWCot8nz07XgrHof0x/+X3Dc+AkvVJRlzOI0VofjjQoStAXfwQDj
   PtVFL99HC1cw/hu8BG0IS5UnYnMhCqGQHfAX5gUfYlpDv0cqZ7kQOY2NA
   w==;
X-CSE-ConnectionGUID: PxLYFthzTBe7BfQY1jeX9g==
X-CSE-MsgGUID: 5iWuXWTwQgu2I64/n+UJlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63822406"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="63822406"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 23:15:08 -0700
X-CSE-ConnectionGUID: hYvlWN5XTwuMZgnhYyqUWw==
X-CSE-MsgGUID: NhhmkBpUQdK0Alu9/p/HKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185123938"
Received: from yinghaoj-desk.ccr.corp.intel.com (HELO [10.238.1.225]) ([10.238.1.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 23:15:03 -0700
Message-ID: <f55516ea-b8de-4d77-a2c5-dffef2f66d7c@linux.intel.com>
Date: Thu, 30 Oct 2025 14:15:01 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/23] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
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
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-18-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20251028212052.200523-18-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/29/2025 5:20 AM, Sagi Shahar wrote:
> TDX VMs need to issue the KVM_TDX_INIT_VCPU ioctl for each vcpu after
> vcpu creation.
>
> Since the cpuids for TD are managed by the TDX module, read the values
> virtualized for the TD using KVM_TDX_GET_CPUID and set them in kvm using
> KVM_SET_CPUID2 so that kvm has an accurate view of the VM cpuid values.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../testing/selftests/kvm/lib/x86/processor.c | 35 ++++++++++++++-----
>   1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 990f2769c5d8..036875fe140f 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -722,6 +722,19 @@ vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
>   	return stack_vaddr;
>   }
>   
> +static void vm_tdx_vcpu_add(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_cpuid2 *cpuid;
> +
> +	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
> +	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_GET_CPUID, 0, cpuid);
> +	vcpu_init_cpuid(vcpu, cpuid);
> +	free(cpuid);
> +	vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
> +
> +	vm_tdx_load_vcpu_boot_parameters(vm, vcpu);
> +}
> +
>   struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>   {
>   	struct kvm_mp_state mp_state;
> @@ -729,15 +742,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
>   	struct kvm_vcpu *vcpu;
>   
>   	vcpu = __vm_vcpu_add(vm, vcpu_id);
> -	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> -	vcpu_init_sregs(vm, vcpu);
> -	vcpu_init_xcrs(vm, vcpu);
>   
> -	/* Setup guest general purpose registers */
> -	vcpu_regs_get(vcpu, &regs);
> -	regs.rflags = regs.rflags | 0x2;
> -	regs.rsp = kvm_allocate_vcpu_stack(vm);
> -	vcpu_regs_set(vcpu, &regs);
> +	if (is_tdx_vm(vm)) {
> +		vm_tdx_vcpu_add(vm, vcpu);
Nit:
Since vcpu is added by  __vm_vcpu_add() above, using 'init' instead of 'add' in
the function name makes it more clear.

> +	} else {
> +		vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> +
> +		vcpu_init_sregs(vm, vcpu);
> +		vcpu_init_xcrs(vm, vcpu);
> +
> +		/* Setup guest general purpose registers */
> +		vcpu_regs_get(vcpu, &regs);
> +		regs.rflags = regs.rflags | 0x2;
> +		regs.rsp = kvm_allocate_vcpu_stack(vm);
> +		vcpu_regs_set(vcpu, &regs);
> +	}
>   
>   	/* Setup the MP state */
>   	mp_state.mp_state = 0;


