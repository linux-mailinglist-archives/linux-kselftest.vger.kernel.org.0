Return-Path: <linux-kselftest+bounces-40036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9900BB37B5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 09:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FF36815AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 07:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C9315778;
	Wed, 27 Aug 2025 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VK12wmI6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68127314A94;
	Wed, 27 Aug 2025 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279149; cv=none; b=TeCUj+PitcMycXC0JWU07xg1ezovVUN6Pv0oMFWtPJGQgZdGY4PdEN9yWej0HFOwgVpg4S8tFGytMvBqbXLqS6gESILNoV6eBGdMyzW6SROIgDZW2Yh1P2GVJX0UH6lnnU4PrKE0YBZOgApBfEIajCqe81QUhGQiVH9By1zoW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279149; c=relaxed/simple;
	bh=pyXNCvi2+BTpMVNvJoe5iugsuGx0lvzVR43BUujIPUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8ht0edgrzYBedv+tVXVh6H4rgcC4olPzpGatvRu+GhnHED3/x3o0KiQxJ3yM74YgUJHzvuuHx8E4vKsO3ciVO4QeuUNuxJGxyQ0odCdPj+sGqzuTokRFVDUboG5V0/M1dACeninlKpyBBrgH4doIpLRZ0QkaOAS7eKncZvCwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VK12wmI6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756279148; x=1787815148;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pyXNCvi2+BTpMVNvJoe5iugsuGx0lvzVR43BUujIPUM=;
  b=VK12wmI6bZt7y3OmzkPbqU8m0aQ55AmuYXjIpY6t9SLZKH1F0bNhiKMs
   pFVck8Vm0cSp5Ut8AFe9+2Aj+GrNu/+BdWvo+827r9OREnuY5idc3nQP6
   6oEKJ2dLTr0vBUjFhmb0wbTDSLScOkc36+5y/i0w5uBwPxxTVlq5czBN7
   yIpZvM13MjwUyHMB4IadvJIJrn6dbelnMqMF8LMd4/XdiQpIARG0hfZjR
   0qa6tc0F26+ZNRVzhODUtYet/Cm5cKd5id9j5sj7cmwEq9eg8uF2dfYjo
   j0C2qYu970TkzCsKBoISbF8OiwvgQTsP5/oUVi6Q7HKQOMk6NCioLOcqE
   A==;
X-CSE-ConnectionGUID: ePwwIjGsS7KqsXQFsGNdIg==
X-CSE-MsgGUID: ZZc6VYyPSmuvDjmkqRhBDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69119089"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69119089"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 00:19:07 -0700
X-CSE-ConnectionGUID: 1yXDBsg9R+iWL2rie3XX8g==
X-CSE-MsgGUID: gn/OOxSCQX2rQt8a9eTE+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169380696"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.233.111]) ([10.124.233.111])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 00:19:01 -0700
Message-ID: <18bf858c-e135-4a9b-bda8-a70be3b3720e@linux.intel.com>
Date: Wed, 27 Aug 2025 15:18:58 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/19] KVM: selftests: Add ucall support for TDX
To: Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
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
 <20250821042915.3712925-19-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250821042915.3712925-19-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> ucalls for non-Coco VMs work by having the guest write to the rdi
> register, then perform an io instruction to exit to the host. The host
> then reads rdi using kvm_get_regs().
>
> CPU registers can't be read using kvm_get_regs() for TDX, so TDX
> guests use MMIO to pass the struct ucall's hva to the host. MMIO was
> chosen because it is one of the simplest (hence unlikely to fail)
> mechanisms that support passing 8 bytes from guest to host.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../testing/selftests/kvm/include/x86/ucall.h |  4 +-
>   tools/testing/selftests/kvm/lib/x86/ucall.c   | 45 ++++++++++++++++---
>   2 files changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
> index d3825dcc3cd9..0494a4a21557 100644
> --- a/tools/testing/selftests/kvm/include/x86/ucall.h
> +++ b/tools/testing/selftests/kvm/include/x86/ucall.h
> @@ -6,8 +6,6 @@
>   
>   #define UCALL_EXIT_REASON       KVM_EXIT_IO
>   
> -static inline void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
> -{
> -}
> +void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
>   
>   #endif
> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
> index 1265cecc7dd1..0ad24baaa3c4 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> @@ -5,11 +5,34 @@
>    * Copyright (C) 2018, Red Hat, Inc.
>    */
>   #include "kvm_util.h"
> +#include "tdx/tdx.h"
>   
>   #define UCALL_PIO_PORT ((uint16_t)0x1000)
>   
> +static uint8_t vm_type;
> +static vm_paddr_t host_ucall_mmio_gpa;
> +static vm_paddr_t ucall_mmio_gpa;
> +
> +void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
> +{
> +	vm_type = vm->type;
> +	sync_global_to_guest(vm, vm_type);
> +
> +	host_ucall_mmio_gpa = ucall_mmio_gpa = mmio_gpa;
> +
> +	if (vm_type == KVM_X86_TDX_VM)
> +		ucall_mmio_gpa |= vm->arch.s_bit;
> +
> +	sync_global_to_guest(vm, ucall_mmio_gpa);
> +}
> +
>   void ucall_arch_do_ucall(vm_vaddr_t uc)
>   {
> +	if (vm_type == KVM_X86_TDX_VM) {
> +		tdg_vp_vmcall_ve_request_mmio_write(ucall_mmio_gpa, 8, uc);
> +		return;
> +	}
> +
>   	/*
>   	 * FIXME: Revert this hack (the entire commit that added it) once nVMX
>   	 * preserves L2 GPRs across a nested VM-Exit.  If a ucall from L2, e.g.
> @@ -46,11 +69,23 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_run *run = vcpu->run;
>   
> -	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
> -		struct kvm_regs regs;
> +	switch (vm_type) {
> +	case KVM_X86_TDX_VM:
> +		if (vcpu->run->exit_reason == KVM_EXIT_MMIO &&
> +		    vcpu->run->mmio.phys_addr == host_ucall_mmio_gpa &&
> +		    vcpu->run->mmio.len == 8 && vcpu->run->mmio.is_write) {
> +			uint64_t data = *(uint64_t *)vcpu->run->mmio.data;
> +
> +			return (void *)data;
> +		}
> +		return NULL;

My first thought was how did SEV_ES or SNP work for this since they are not
able to get RDI neither.
Then I had a check in sev_smoke_test.c, both guest_sev_es_code() and
guest_snp_code() call GUEST_ASSERT(), which finally calls ucall_assert(), but
in test_sev(), the code doesn't handle ucall for SEV_ES or SNP.
Does it mean GUEST_ASSERT() is currently not working and ignored for SEV_ES
and SNP? Or did I miss anything?

> +	default:
> +		if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
> +			struct kvm_regs regs;
>   
> -		vcpu_regs_get(vcpu, &regs);
> -		return (void *)regs.rdi;
> +			vcpu_regs_get(vcpu, &regs);
> +			return (void *)regs.rdi;
> +		}
> +		return NULL;
>   	}
> -	return NULL;
>   }


