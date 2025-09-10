Return-Path: <linux-kselftest+bounces-41108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A15B50FDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 09:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2847C7A1AEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 07:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202CA30ACF6;
	Wed, 10 Sep 2025 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrT4ieTt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB925D218;
	Wed, 10 Sep 2025 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490372; cv=none; b=p7N8YwDUM3jpA09g7BZUcXy0R60IHTc7/dNujPvUdnQdR3eviRlJP4JBEOrC7vXcccJNVV1a4ZgsCUj6mV1Wze9sJVtkvJbMi0xktJ+LoNB0HJwTT79S4P3DxfitGSlt5WqsrspLOoRHgpv6kbb5etJQwT16xIdUnaZltaA9pwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490372; c=relaxed/simple;
	bh=a3PrR//qxp7Ywbw0ah2IhyTG8FHH1p9QljBrCn/jMvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wmc6TPK8xCSqXVPpPqsWmcEd04bKWvriaT+9ueZXBjGjgoYJldH4suP7gnWEJZnjRgLgn9KOTjg6OzZx4TRGXb+/f+QGQr8eKrty3IOvm5E1w/ngbIRBkc9ExKgFhd0jL1II8BkMKrKeWXDqyTpi2WhUs55BXnte4+Dp6r+3h2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrT4ieTt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757490371; x=1789026371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a3PrR//qxp7Ywbw0ah2IhyTG8FHH1p9QljBrCn/jMvE=;
  b=HrT4ieTtHdFvtAtwFhMY6k5xoBP/ai2CRzdUkm/UhHN3lLASDBvrbPqy
   PAQ710phlmQVizNkZAePQy0Mkb8TFzIrj4DDJUtOfxMOa1BBSn5OCKDHX
   stli15OgJEGIgrnooNNgvPGjN55GrgFZEpM4vuxtVpaI7mPyg2ai3IQtD
   3dWK6Eb0V3HJN4mJmnhh52ltZxLz68RXdSxtLfO1ShimXco7xmhMDAPfs
   7NQCE5LoUlat/N6FaQCbeAyTM/5GbFk8k3m5GqJho5eVxpIBl+c0+H94y
   wIoAgX2+ULNYrx6gM3tm3FwP/4zma5UXOzhTsPrg+QJyjo/ejMBWeGM2l
   A==;
X-CSE-ConnectionGUID: db2pRuZ+TT6BXXdt5RG6NA==
X-CSE-MsgGUID: EmTTdH02SvKD1MIgLRrxSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59485499"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="59485499"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 00:46:10 -0700
X-CSE-ConnectionGUID: Rel6eZKfS+m2Gegfel2PNw==
X-CSE-MsgGUID: cmEvQ3VPQ+mcH/+yZKy4EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="178533882"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 00:46:05 -0700
Message-ID: <46946d39-c980-42a5-9f67-1642fa7f0beb@linux.intel.com>
Date: Wed, 10 Sep 2025 15:46:02 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/21] KVM: selftests: Add ucall support for TDX
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
References: <20250904065453.639610-1-sagis@google.com>
 <20250904065453.639610-21-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-21-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
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

It has been declared in ucall_common.h,  this should be removed here?

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
Nit: is_tdx_vm(vm)

Also, maybe it can skip the initialization of mmio info for non TDX case to tell
that the info is only used by TDX?

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


