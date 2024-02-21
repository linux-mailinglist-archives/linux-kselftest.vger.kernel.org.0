Return-Path: <linux-kselftest+bounces-5116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E04F85CE05
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9431F1F25E81
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4700F9FF;
	Wed, 21 Feb 2024 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICs169in"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476023C29;
	Wed, 21 Feb 2024 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482564; cv=none; b=t7BN7WfQNgcp2eY2zMvxv8bQJeeQGx1itHQ+ciWtsQCIj50PypzysQULidshPaiVBYJdPMvTUF862xde80UPvdKz3UdGCOSDfGKmyhodMkEVX3c69M1LzQMD8Cl4hKsmJqYb+AugUINuHb/pdJkgNTKzClsE10j5JTXAmanDVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482564; c=relaxed/simple;
	bh=gPPbnQYj1+eq6sPOlu7HUtlfxwyArBDBxuXKAwgAUJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2eVS4gX5hpvJTj1bu6pJQwDI4zMSaYgUEC73nZs/BgsMRAle+jpK9U+VHn1qFa75Iu5D8EBJGBh6FLopq7wUhBLntnz5WNn932DiFeJoroHDPkLd0jz2v6S9vB9omQVSOxU1hHJGHTH14wTTgFDpz2nSseObmh0fuoQDlNcCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICs169in; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708482563; x=1740018563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gPPbnQYj1+eq6sPOlu7HUtlfxwyArBDBxuXKAwgAUJw=;
  b=ICs169inoE63OF7XBCBD2/T9gUaF+t89+Y9PtwtKycRLMs/mmNcD1qpB
   Z7e4gh3lFwwTbGGr8bWmAnb7WWKYhZDsz7KpPGx/OytNT6UTZwLFDGPYW
   zrMTTaVhBypqJnBNMzXFjotm08WfBxWgOzAU7+WaPZGvoAcEj9vNCkTcN
   4IrPcjnHYG6Glrq66HoXflIR+pgn1KsSNTKpEJBb6ZgKk/8rBcfNtVkN3
   n+U4uexGlvP1Ntxu7cYlZBnlKAhTArNrtNUFN2VRbTEi54c7zct74zFhB
   3zbRWweL/9A8tEAed/0sFp/puacde5RxtmiS5URk0tU6oW2hKhYJ/4mu4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2533262"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2533262"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5333435"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.18.46]) ([10.93.18.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:29:18 -0800
Message-ID: <e6dd174c-e6db-487e-8e0c-abb5bdf1b9b0@linux.intel.com>
Date: Wed, 21 Feb 2024 10:29:15 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 03/29] KVM: selftests: Store initial stack address
 in struct kvm_vcpu
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>,
 Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>,
 Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <20231212204647.2170650-1-sagis@google.com>
 <20231212204647.2170650-4-sagis@google.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20231212204647.2170650-4-sagis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
>
> TDX guests' registers cannot be initialized directly using
> vcpu_regs_set(), hence the stack pointer needs to be initialized by
> the guest itself, running boot code beginning at the reset vector.
>
> We store the stack address as part of struct kvm_vcpu so that it can
> be accessible later to be passed to the boot code for rsp
> initialization.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ryan Afranji <afranji@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>   tools/testing/selftests/kvm/include/kvm_util_base.h | 1 +
>   tools/testing/selftests/kvm/lib/x86_64/processor.c  | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index c2e5c5f25dfc..b353617fcdd1 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -68,6 +68,7 @@ struct kvm_vcpu {
>   	int fd;
>   	struct kvm_vm *vm;
>   	struct kvm_run *run;
> +	vm_vaddr_t initial_stack_addr;
>   #ifdef __x86_64__
>   	struct kvm_cpuid2 *cpuid;
>   #endif
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index f130f78a4974..b6b9438e0a33 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -621,10 +621,12 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>   	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
>   	vcpu_setup(vm, vcpu);
>   
> +	vcpu->initial_stack_addr = stack_vaddr;
> +
>   	/* Setup guest general purpose registers */
>   	vcpu_regs_get(vcpu, &regs);
>   	regs.rflags = regs.rflags | 0x2;
> -	regs.rsp = stack_vaddr;
> +	regs.rsp = vcpu->initial_stack_addr;

Nit: No need to do this change.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

>   	regs.rip = (unsigned long) guest_code;
>   	vcpu_regs_set(vcpu, &regs);
>   


