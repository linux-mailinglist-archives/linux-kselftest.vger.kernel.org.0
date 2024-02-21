Return-Path: <linux-kselftest+bounces-5115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A9885CDDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE3D283240
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978251079D;
	Wed, 21 Feb 2024 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hM4eSww1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77105232;
	Wed, 21 Feb 2024 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481931; cv=none; b=jgdC9JmQ3wo4FXtKqxl41gSzUtg08mLO8aosUg4bwoAXRqxo6Ekc0B+Y6IFwYi/ee7zI6s8a825HKn2W9BR6f20VPkrnk/UjQF1dZUOeQu3zBR8KshiqPlVaLoRIwfmK4Q39UXwD41PRFj+oJkwG/fsO2SA0C5LnKmEAnclQAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481931; c=relaxed/simple;
	bh=HOY/ZKR3UxnM/lO9pCRb72aBDqSC44CZ4roDqmw4AiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvUahDKMskmAq0LPbTS6ALJ5RrEkb6b2wEUjvqZ5SWgYilH3KhVekjwPxwDBvSg1sVDRx9EECL1lBPq4edTUa+5rlzZOKkVOKOGdDteGxB6kvELZZaNk7S7PWW9EOHC7m2TRMOLmauASeZcdtuYS4qnUJA11gkXnHjGiHpquoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hM4eSww1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708481930; x=1740017930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HOY/ZKR3UxnM/lO9pCRb72aBDqSC44CZ4roDqmw4AiQ=;
  b=hM4eSww1N2foJKB5WRjXAUcDLWocqk1RblT4Rdw/BK35WkJwknWfC+xx
   Xnwy7kWSqCH15T3LsESqbnLCIZbhKgirj65AuIK+2LgU6d3bgaZVV/oIx
   mm0YZE20ruxc+rrZ0HO0GFmT9N+B8r76xJk2rwejusYXcnIM2mP79lDYJ
   WxGOKF1RItvuKF6kZIH3LvoAtv3BhnB0zCNYZs8eQE3xeICBdn5JVcrx6
   RlLzkAFPXAAnl7i7EIP/vVgS2y+V183jXi+C+yxpB7zDnFR+1weok12QM
   +YhQmwYSe6TMsLIy0E+zemTK8GQ+7ZD2atmHhQLAfxi1+ttLijmBB0+Fb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="25085316"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="25085316"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:18:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4881566"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.18.46]) ([10.93.18.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:18:45 -0800
Message-ID: <06b200d8-e432-478f-b564-b799da778c41@linux.intel.com>
Date: Wed, 21 Feb 2024 10:18:43 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 02/29] KVM: selftests: Expose function that sets up
 sregs based on VM's mode
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Ryan Afranji
 <afranji@google.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-3-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-3-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> This allows initializing sregs without setting vCPU registers in
> KVM.
>
> No functional change intended.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   .../selftests/kvm/include/x86_64/processor.h  |  2 +
>   .../selftests/kvm/lib/x86_64/processor.c      | 39 ++++++++++---------
>   2 files changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 35fcf4d78dfa..0b8855d68744 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -958,6 +958,8 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
>   void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
>   void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu);
>   
> +void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs);
> +
>   static inline struct kvm_cpuid_entry2 *__vcpu_get_cpuid_entry(struct kvm_vcpu *vcpu,
>   							      uint32_t function,
>   							      uint32_t index)
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index aef1c021c4bb..f130f78a4974 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -543,36 +543,39 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
>   	kvm_seg_fill_gdt_64bit(vm, segp);
>   }
>   
> -static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs)
>   {
> -	struct kvm_sregs sregs;
> -
> -	/* Set mode specific system register values. */
> -	vcpu_sregs_get(vcpu, &sregs);
> -
> -	sregs.idt.limit = 0;
> +	sregs->idt.limit = 0;
>   
> -	kvm_setup_gdt(vm, &sregs.gdt);
> +	kvm_setup_gdt(vm, &sregs->gdt);
>   
>   	switch (vm->mode) {
>   	case VM_MODE_PXXV48_4K_SEV:
>   	case VM_MODE_PXXV48_4K:
> -		sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> -		sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> -		sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
> -
> -		kvm_seg_set_unusable(&sregs.ldt);
> -		kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs.cs);
> -		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.ds);
> -		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.es);
> -		kvm_setup_tss_64bit(vm, &sregs.tr, 0x18);
> +		sregs->cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
> +		sregs->cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
> +		sregs->efer |= (EFER_LME | EFER_LMA | EFER_NX);
> +
> +		kvm_seg_set_unusable(&sregs->ldt);
> +		kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs->cs);
> +		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs->ds);
> +		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs->es);
> +		kvm_setup_tss_64bit(vm, &sregs->tr, 0x18);
>   		break;
>   
>   	default:
>   		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
>   	}
>   
> -	sregs.cr3 = vm->pgd;
> +	sregs->cr3 = vm->pgd;
> +}
> +
> +static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sregs sregs;
> +
> +	vcpu_sregs_get(vcpu, &sregs);
> +	vcpu_setup_mode_sregs(vm, &sregs);
>   	vcpu_sregs_set(vcpu, &sregs);
>   }
>   


