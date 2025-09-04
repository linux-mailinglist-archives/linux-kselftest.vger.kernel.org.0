Return-Path: <linux-kselftest+bounces-40755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3C9B436F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 11:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EA71C2717A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109282EF669;
	Thu,  4 Sep 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6RV3lkL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA192EF662;
	Thu,  4 Sep 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977803; cv=none; b=tqxfYdDS11YtI1hYTsFdzBE67E3ksyPYg7pHD7PS99BYyLgVsV+kvcQGIIL/2qQSdlAB0uvQKxHAK/H5xAOTLqvCTQuVgC3H2+p/EC9XDg1r9KWfz1HBsSHQEwGdx9u8e9FsBc7W6Py1Ku8eupna5NnZeM1xSZOgts5hPgMjjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977803; c=relaxed/simple;
	bh=TDSln1mF3xgUP8nsTtJypSwko7BDQHldbUJU4u28Q5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TG5S2Npj/VRDhw4MKnO08e4bPSgo/q92U/VW9H6Z2098Z9DGH8xGbL9XYutNQGqcdeDxL4BCovgFg48obfNYz26tblIIHVtWiFFfBo6aX7QUN4CcuaBqVSdK2Ghsk/JtyfS35ezYiXDzt+tjM1+WdvM+SB33L9gcszL5Tj9PpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6RV3lkL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756977801; x=1788513801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TDSln1mF3xgUP8nsTtJypSwko7BDQHldbUJU4u28Q5k=;
  b=R6RV3lkL/WCPnDdBuWG0HDTGl/y5PLg65Y+Ew036cc6jT7jasfpJ193d
   ddP3dX8hPnIDI+hY7DHcCpe9amnXTkPI8ivlOUsKGvXJekQOwZexRxn4r
   goaD+8uWFBoNnpDnARxLyhtLf5Sj1iyUBTjmVUcvtla/Chtn9/fiiNg1B
   5sj4TSc5JjapEp2NfU3E92cvnsVDn7wjWWtZ12gRzhtcqKkOz6JfmfnT0
   qSX/0bBkJgt9zTeouIz+EvhWdCCiAtMpIJZOfs1jgoB0gqT/zuYSDZeeK
   8ecZTO9mvbUyct1HNBTYMeNNeRnQzsVt204XfN5nFa134+YFbG2McS0Mx
   w==;
X-CSE-ConnectionGUID: TmqzdbTsTMuTnmb/0+omPA==
X-CSE-MsgGUID: o2T1I4oKRI27u3qrrukXyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70683128"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="70683128"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 02:23:20 -0700
X-CSE-ConnectionGUID: z1dtnF/cQLmbmzzeQ1j0pA==
X-CSE-MsgGUID: 9JIJ4CuERhKgU/cdXTESqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="172209461"
Received: from unknown (HELO [10.238.0.107]) ([10.238.0.107])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 02:23:16 -0700
Message-ID: <41c87e38-4855-48da-bb7e-fd9b3c39a439@linux.intel.com>
Date: Thu, 4 Sep 2025 17:23:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/21] KVM: selftests: Expose functions to get default
 sregs values
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
 <20250904065453.639610-3-sagis@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20250904065453.639610-3-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2025 2:54 PM, Sagi Shahar wrote:
> TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
> default values of certain sregs used by TDX VMs so they can be set
> manually.
>
> Signed-off-by: Sagi Shahar <sagis@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One suggestion:
It's better to add change history so that reviewers can know the change quickly
without comparing b/t versions.

> ---
>   .../selftests/kvm/include/x86/processor.h     | 33 +++++++++++++++++++
>   .../testing/selftests/kvm/lib/x86/processor.c | 12 +++----
>   2 files changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 2efb05c2f2fb..f610c09cadf4 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -27,6 +27,10 @@ extern uint64_t guest_tsc_khz;
>   #define MAX_NR_CPUID_ENTRIES 100
>   #endif
>   
> +#ifndef NUM_INTERRUPTS
> +#define NUM_INTERRUPTS 256
> +#endif
> +
>   #define NONCANONICAL 0xaaaaaaaaaaaaaaaaull
>   
>   /* Forced emulation prefix, used to invoke the emulator unconditionally. */
> @@ -1456,4 +1460,33 @@ void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>   
>   bool sys_clocksource_is_based_on_tsc(void);
>   
> +static inline uint16_t kvm_get_default_idt_limit(void)
> +{
> +	return NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +}
> +
> +static inline uint16_t kvm_get_default_gdt_limit(void)
> +{
> +	return getpagesize() - 1;
> +}
> +
> +static inline uint64_t kvm_get_default_cr0(void)
> +{
> +	return X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> +}
> +
> +static inline uint64_t kvm_get_default_cr4(void)
> +{
> +	uint64_t cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
> +
> +	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> +		cr4 |= X86_CR4_OSXSAVE;
> +	return cr4;
> +}
> +
> +static inline uint64_t kvm_get_default_efer(void)
> +{
> +	return EFER_LME | EFER_LMA | EFER_NX;
> +}
> +
>   #endif /* SELFTEST_KVM_PROCESSOR_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index d4c19ac885a9..83efcf48faad 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -498,15 +498,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
>   	vcpu_sregs_get(vcpu, &sregs);
>   
>   	sregs.idt.base = vm->arch.idt;
> -	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> +	sregs.idt.limit = kvm_get_default_idt_limit();
>   	sregs.gdt.base = vm->arch.gdt;
> -	sregs.gdt.limit = getpagesize() - 1;
> +	sregs.gdt.limit = kvm_get_default_gdt_limit();
>   
> -	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> -	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> -	if (kvm_cpu_has(X86_FEATURE_XSAVE))
> -		sregs.cr4 |= X86_CR4_OSXSAVE;
> -	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
> +	sregs.cr0 = kvm_get_default_cr0();
> +	sregs.cr4 |= kvm_get_default_cr4();
> +	sregs.efer |= kvm_get_default_efer();
>   
>   	kvm_seg_set_unusable(&sregs.ldt);
>   	kvm_seg_set_kernel_code_64bit(&sregs.cs);


