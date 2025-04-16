Return-Path: <linux-kselftest+bounces-30934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DAAA8AFF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 08:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150F33B948F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989C717A30B;
	Wed, 16 Apr 2025 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSECGaIu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45017BBF;
	Wed, 16 Apr 2025 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783218; cv=none; b=urNJCWYjD7O1DH9hdZ4sCaQx4qmQ0VMEBSYKWqtPOdfhbJ97oSNEXCl5MA0tL6pyAteexOj58cA0HVdYwl8HBNYu8IEiMqUmSveAL5It0R9hj6Bny5K93baZJdE96FsU7hLFtBr+8iQa7ZNUPHqV5mz9t9e7M6JT9Z7EdZYYfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783218; c=relaxed/simple;
	bh=s4UxyDETQsKRK+xGxxKZTuy1nqHiAyGquO+dfcf6cko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1+ARkzh/az7vtXYnXpbufIWLBroYLnPNfx6W3ENHPAcMpLH8EF8dxW8BObOGOV2THL7CRcAHSSyi2DNO3O2tMedWxL2ATajbS7nHaTbxqMc/90WVzZMgn7qvQhzNiy5Hj9pRjzo6xKl05xRrrHujfhuYAjUgC27qrFgJ07WcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSECGaIu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744783216; x=1776319216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s4UxyDETQsKRK+xGxxKZTuy1nqHiAyGquO+dfcf6cko=;
  b=YSECGaIufwYJdOaF2wj/FwEX4mPhB473kVQ+OcoiNldcwi3ktL8sKYz8
   sGhJnexsHjLJqbM1455KnuJJNh8c5OZTaYH32E4DIAyXd6dbhrh/S03ET
   E1I4Q2uacQNPl0E1ygTg/1svCaRPTEpl7chRvOcgcNkthMZNFlSTMbqpA
   fGdqpCnEEsI5rsQts6wCEjBG3sRtBbHiVxjqVML+vgivhSMkscrq/+4K3
   1AFzm9p9pXmQjwJTFiC40OHR870fl1/LxvRLqChyaoO3O0cLX29iHrJr1
   6ExyPjCni/T+h2zoeuV3uSt/AXnADFO5vC6zOY6pxH2zJ1pwBDJ3FQHSr
   A==;
X-CSE-ConnectionGUID: gmy9baRwQ3qsMpp5qSBPTA==
X-CSE-MsgGUID: p8iW/pk4TH66Nlu3MoB6Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="63720966"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="63720966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:00:15 -0700
X-CSE-ConnectionGUID: lY2MXMNaR22xDGLjFpRpQw==
X-CSE-MsgGUID: nrdZXgwFSlOtbpH+qdYmaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130875799"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1]) ([10.124.247.1])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:00:13 -0700
Message-ID: <b03f3593-e56b-4a98-8ddd-e54fe7885c81@intel.com>
Date: Wed, 16 Apr 2025 14:00:09 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] KVM: SVM: Enable Bus lock threshold exit
To: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, nikunj@amd.com,
 thomas.lendacky@amd.com, bp@alien8.de
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-4-manali.shukla@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250324130248.126036-4-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/2025 9:02 PM, Manali Shukla wrote:
> From: Nikunj A Dadhania <nikunj@amd.com>
> 
> Virtual machines can exploit bus locks to degrade the performance of
> the system. Bus locks can be caused by Non-WB(Write back) and
> misaligned locked RMW (Read-modify-Write) instructions and require
> systemwide synchronization among all processors which can result into
> significant performance penalties.
> 
> To address this issue, the Bus Lock Threshold feature is introduced to
> provide ability to hypervisor to restrict guests' capability of
> initiating mulitple buslocks, thereby preventing system slowdowns.
> 
> Support for the buslock threshold is indicated via CPUID function
> 0x8000000A_EDX[29].
> 
> On the processors that support the Bus Lock Threshold feature, the
> VMCB provides a Bus Lock Threshold enable bit and an unsigned 16-bit
> Bus Lock threshold count.
> 
> VMCB intercept bit
> VMCB Offset     Bits    Function
> 14h             5       Intercept bus lock operations
> 
> Bus lock threshold count
> VMCB Offset     Bits    Function
> 120h            15:0    Bus lock counter
> 
> When a VMRUN instruction is executed, the bus lock threshold count is
> loaded into an internal count register. Before the processor executes
> a bus lock in the guest, it checks the value of this register:
> 
>   - If the value is greater than '0', the processor successfully
>     executes the bus lock and decrements the count.
> 
>   - If the value is '0', the bus lock is not executed, and a #VMEXIT to
>     the VMM is taken.
> 
> The bus lock threshold #VMEXIT is reported to the VMM with the VMEXIT
> code A5h, SVM_EXIT_BUS_LOCK.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>   arch/x86/include/asm/svm.h      | 5 ++++-
>   arch/x86/include/uapi/asm/svm.h | 2 ++
>   arch/x86/kvm/svm/svm.c          | 8 ++++++++
>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 9b7fa99ae951..9dc54da1835a 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -116,6 +116,7 @@ enum {
>   	INTERCEPT_INVPCID,
>   	INTERCEPT_MCOMMIT,
>   	INTERCEPT_TLBSYNC,
> +	INTERCEPT_BUSLOCK,
>   	INTERCEPT_IDLE_HLT = 166,
>   };
>   
> @@ -159,7 +160,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>   	u64 avic_physical_id;	/* Offset 0xf8 */
>   	u8 reserved_7[8];
>   	u64 vmsa_pa;		/* Used for an SEV-ES guest */
> -	u8 reserved_8[720];
> +	u8 reserved_8[16];
> +	u16 bus_lock_counter;	/* Offset 0x120 */
> +	u8 reserved_9[702];
>   	/*
>   	 * Offset 0x3e0, 32 bytes reserved
>   	 * for use by hypervisor/software.
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index ec1321248dac..9c640a521a67 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -95,6 +95,7 @@
>   #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
>   #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
>   #define SVM_EXIT_INVPCID       0x0a2
> +#define SVM_EXIT_BUS_LOCK			0x0a5
>   #define SVM_EXIT_IDLE_HLT      0x0a6
>   #define SVM_EXIT_NPF           0x400
>   #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
> @@ -225,6 +226,7 @@
>   	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
>   	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
>   	{ SVM_EXIT_INVPCID,     "invpcid" }, \
> +	{ SVM_EXIT_BUS_LOCK,     "buslock" }, \
>   	{ SVM_EXIT_IDLE_HLT,     "idle-halt" }, \
>   	{ SVM_EXIT_NPF,         "npf" }, \
>   	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 8abeab91d329..244e099e7262 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1375,6 +1375,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>   		svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
>   	}
>   
> +	if (vcpu->kvm->arch.bus_lock_detection_enabled)
> +		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
> +
>   	if (sev_guest(vcpu->kvm))
>   		sev_init_vmcb(svm);
>   
> @@ -5299,6 +5302,11 @@ static __init void svm_set_cpu_caps(void)
>   		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>   	}
>   
> +	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD)) {
> +		pr_info("Bus Lock Threshold supported\n");

It will be printed every time kvm-amd.ko module gets loaded.

I think it's for your development and debug purpose. Comparing to the 
existing features in svm_set_cpu_caps(), nothing makes it special for 
BUS_LOCK_THRESHOLD to require a kernel message. So I think we can just 
remove it.

> +		kvm_caps.has_bus_lock_exit = true;

Besides, this patch doesn't ensure the bisectability. It allows 
userspace to enable KVM_BUS_LOCK_DETECTION_EXIT and set intercept of 
INTERCEPT_BUSLOCK but without providing the handler.

So either move next patch before it or just merge them.

> +	}
> +
>   	/* CPUID 0x80000008 */
>   	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>   	    boot_cpu_has(X86_FEATURE_AMD_SSBD))


