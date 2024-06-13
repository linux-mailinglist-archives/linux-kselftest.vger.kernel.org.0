Return-Path: <linux-kselftest+bounces-11895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E052B907B49
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41BB1C22CC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B814B090;
	Thu, 13 Jun 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BT3/a0o8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81E14A623
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303379; cv=none; b=Jj7B0lSDGt5rhCnJVps3U4uqND2p6JkHvWOqYiyQY8URYKGCpXzbAIYlqpjqt4JEcb7UsYWOyXMnuzT4aaju3+KYF0RtweleGTQKniaYD6ipLVdIcvksnmX0Rqr0pVABLNeN6JGQIFnyVbxCytRnuUKEmCwzo7N4B7KQ3WwXLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303379; c=relaxed/simple;
	bh=GZUo36Np0gui5iMC3kWaWJvqb8+ie9cBFLRdcmIQb2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O8bBeRH9zaK610JcjqRFZsMZzNoRKWLat//pEN1/cwCo0rXDZrO/KJV+yWUR2RAoCZi4CrglI06UMaOiUKJ6UJVmwnOkCfgKmUT8EGd61Ym6TrzibIBcSCTWUsBnoMUNCqSEUJ8sz90ZDLcQ2ddi6bvQNHjLzSvPnvtRylY2fE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BT3/a0o8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-631278f3b19so16838287b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718303376; x=1718908176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xow6eF8EcU1B/jVaJ9RrJxjk/wXRNzAI1C7xG3uJG5s=;
        b=BT3/a0o8kiFR3KS6Jw+JNm1v4tsfs31+bLWpuKqiuvTodoNvmFwEQdlRLj+92K7je4
         okcIuYGwxsSjSsNhJjHSEypbJR8wbZymYZg3iI4kIx2kh1/PuNmdkwJoewkh9Vqk0ksE
         lWTAe/S1dBPD6rz92JTN/zJpFso2bEYdGIKQUztFMmK22dLvV25CmWEaNHIcEae4DuK/
         rr+kwhvxBpnvnGXt4l42J3CGe1qc+vHPClhcQcEYVW26EcBoVsmiH6bt6l2YxIydgZeQ
         0GHrDoYqRNYzTlY/czTNV0H4aSM4MvAO4aJW5liIdSRhI/UkXmXr3AOBsOoPi4uTAbzv
         LkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303376; x=1718908176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xow6eF8EcU1B/jVaJ9RrJxjk/wXRNzAI1C7xG3uJG5s=;
        b=pM1Cbn8Z0f9ONehHoRphD5Mb3PyQix7XExG1G4jojFlwGUu80I9GUHxevnciatf0nM
         aURSjbeOkE5OApAu9dm0YUkKr6RhM7IAdOOb/16dbzuxk2Wt0o9N/sT68QIUA1lMRwom
         jKp5TfGjLwwX7lDHckYaUF3J4PQQwRPOcfKb6YzusedoRRyxK+Vd+V5Y6Qyjm0Cxb/mO
         mVxQ8RpzNaIQJbV07G1IC8vNI+xB4t06gnVh1w2811iFtKjpmko9Lhr4xpoiwvICB8dp
         ZSnCa/tienwYmI6WpisGXXS+HAK514+41Fq8WsHuVpaWKr+UPP4n8RK/sGUzIeomL5v4
         ksUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3+hmCB/ypT29WBkiyls/KPCZjb3kBR5Ezs9/RibhoWuIhhur0g2N85bYHdH/W6HIp/DKjzjxTngRiGxyVBCo0G3vJldb4+yecCW+eWbOx
X-Gm-Message-State: AOJu0Yz1uhRhy9fTmoKDsu1SxYxqjbanR05wvcGcn02Cj6qV7gR5ZVXz
	O+br5ke5wrCz0kkd1cP1qg6Souy26+HL6MuhH4esCSKl/VmMv2QI4YhAEIPHk5vs+HBA77T7k4F
	dXQ==
X-Google-Smtp-Source: AGHT+IG91HpLCnnwC8Q/bXtEbXPRdHVg8w/5EMMy6Rwz3/ZrZ8oSfH4Lia4V0jH/RUzaGYDn5LN4B1K1TeA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:e89:b0:dff:9dc:7e41 with SMTP id
 3f1490d57ef6-dff154ac5fcmr12681276.11.1718303376176; Thu, 13 Jun 2024
 11:29:36 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:29:34 -0700
In-Reply-To: <20240207172646.3981-20-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-20-xin3.li@intel.com>
Message-ID: <Zms6jkwA9PfvXCGv@google.com>
Subject: Re: [PATCH v2 19/25] KVM: nVMX: Add FRED VMCS fields
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 07, 2024, Xin Li wrote:
> Add FRED VMCS fields to nested VMX context management.
> 
> Todo: change VMCS12_REVISION, as struct vmcs12 is changed.

It actually doesn't, the comment is just stale.  At this point, KVM must _never_
change VMCS12_REVISION as doing so will break backwards compatibility.

I'll post this once I've written a changelog:

---
 arch/x86/kvm/vmx/vmcs12.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
index edf7fcef8ccf..d67bebb9f1c2 100644
--- a/arch/x86/kvm/vmx/vmcs12.h
+++ b/arch/x86/kvm/vmx/vmcs12.h
@@ -207,11 +207,9 @@ struct __packed vmcs12 {
 };
 
 /*
- * VMCS12_REVISION is an arbitrary id that should be changed if the content or
- * layout of struct vmcs12 is changed. MSR_IA32_VMX_BASIC returns this id, and
- * VMPTRLD verifies that the VMCS region that L1 is loading contains this id.
+ * VMCS12_REVISION is KVM's arbitrary id for the layout of struct vmcs12.
  *
- * IMPORTANT: Changing this value will break save/restore compatibility with
+ * DO NOT change this value, as it will break save/restore compatibility with
  * older kvm releases.
  */
 #define VMCS12_REVISION 0x11e57ed0
@@ -225,7 +223,8 @@ struct __packed vmcs12 {
 #define VMCS12_SIZE		KVM_STATE_NESTED_VMX_VMCS_SIZE
 
 /*
- * For save/restore compatibility, the vmcs12 field offsets must not change.
+ * For save/restore compatibility, the vmcs12 field offsets must not change,
+ * although appending fields and/or filling gaps is obviously allowed.
  */
 #define CHECK_OFFSET(field, loc) \
 	ASSERT_STRUCT_OFFSET(struct vmcs12, field, loc)

base-commit: 878fe4c2f7eead383f2b306cbafd300006dd518c
-- 

> Signed-off-by: Xin Li <xin3.li@intel.com>
> Tested-by: Shan Kang <shan.kang@intel.com>
> ---
> 
> Change since v1:
> * Remove hyperv TLFS related changes (Jeremi Piotrowski).
> * Use kvm_cpu_cap_has() instead of cpu_feature_enabled() (Chao Gao).
> ---
>  Documentation/virt/kvm/x86/nested-vmx.rst | 18 +++++
>  arch/x86/kvm/vmx/nested.c                 | 91 +++++++++++++++++++----
>  arch/x86/kvm/vmx/vmcs12.c                 | 18 +++++
>  arch/x86/kvm/vmx/vmcs12.h                 | 36 +++++++++
>  arch/x86/kvm/vmx/vmcs_shadow_fields.h     |  4 +
>  5 files changed, 152 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/x86/nested-vmx.rst b/Documentation/virt/kvm/x86/nested-vmx.rst
> index e64ef231f310..87fa9f3877ab 100644
> --- a/Documentation/virt/kvm/x86/nested-vmx.rst
> +++ b/Documentation/virt/kvm/x86/nested-vmx.rst
> @@ -218,6 +218,24 @@ struct shadow_vmcs is ever changed.
>  		u16 host_gs_selector;
>  		u16 host_tr_selector;
>  		u64 secondary_vm_exit_controls;
> +		u64 guest_ia32_fred_config;
> +		u64 guest_ia32_fred_rsp1;
> +		u64 guest_ia32_fred_rsp2;
> +		u64 guest_ia32_fred_rsp3;
> +		u64 guest_ia32_fred_stklvls;
> +		u64 guest_ia32_fred_ssp1;
> +		u64 guest_ia32_fred_ssp2;
> +		u64 guest_ia32_fred_ssp3;
> +		u64 host_ia32_fred_config;
> +		u64 host_ia32_fred_rsp1;
> +		u64 host_ia32_fred_rsp2;
> +		u64 host_ia32_fred_rsp3;
> +		u64 host_ia32_fred_stklvls;
> +		u64 host_ia32_fred_ssp1;
> +		u64 host_ia32_fred_ssp2;
> +		u64 host_ia32_fred_ssp3;
> +		u64 injected_event_data;
> +		u64 original_event_data;
>  	};
>  
>  
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 94da6a0a2f81..f9c1fbeac302 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -686,6 +686,9 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>  
>  	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
>  					 MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_FRED_RSP0, MSR_TYPE_RW);
>  #endif
>  	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
>  					 MSR_IA32_SPEC_CTRL, MSR_TYPE_RW);
> @@ -2498,6 +2501,8 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
>  			     vmcs12->vm_entry_instruction_len);
>  		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
>  			     vmcs12->guest_interruptibility_info);
> +		if (kvm_cpu_cap_has(X86_FEATURE_FRED))

This is wrong, vmcs02 should be set from vmcs12 if and only if the field is enabled
in L1's VMX configuration, i.e. iff nested_cpu_has(vmcs12, ???).

Note, the ??? should be tied to whatever VMX MSR feature flag enumerates
INJECTED_EVENT_DATA.  KVM's clearing of X86_FEATURE_FRED when one or more pieces
is missing is a software decision, i.e. not archictectural.

> +			vmcs_write64(INJECTED_EVENT_DATA, vmcs12->injected_event_data);
>  		vmx->loaded_vmcs->nmi_known_unmasked =
>  			!(vmcs12->guest_interruptibility_info & GUEST_INTR_STATE_NMI);
>  	} else {
> @@ -2548,6 +2553,17 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  		vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
>  		vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
>  
> +		if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {

Same thing here.

> +			vmcs_write64(GUEST_IA32_FRED_CONFIG, vmcs12->guest_ia32_fred_config);
> +			vmcs_write64(GUEST_IA32_FRED_RSP1, vmcs12->guest_ia32_fred_rsp1);
> +			vmcs_write64(GUEST_IA32_FRED_RSP2, vmcs12->guest_ia32_fred_rsp2);
> +			vmcs_write64(GUEST_IA32_FRED_RSP3, vmcs12->guest_ia32_fred_rsp3);
> +			vmcs_write64(GUEST_IA32_FRED_STKLVLS, vmcs12->guest_ia32_fred_stklvls);
> +			vmcs_write64(GUEST_IA32_FRED_SSP1, vmcs12->guest_ia32_fred_ssp1);
> +			vmcs_write64(GUEST_IA32_FRED_SSP2, vmcs12->guest_ia32_fred_ssp2);
> +			vmcs_write64(GUEST_IA32_FRED_SSP3, vmcs12->guest_ia32_fred_ssp3);
> +		}
> +
>  		vmx->segment_cache.bitmask = 0;
>  	}
>  
> @@ -3835,6 +3851,22 @@ vmcs12_guest_cr4(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
>  			vcpu->arch.cr4_guest_owned_bits));
>  }
>  
> +static inline unsigned long
> +nested_vmx_get_event_data(struct kvm_vcpu *vcpu, bool for_ex_vmexit)

Heh, two form letters for the price of one:

#1
Do not use "inline" for functions that are visible only to the local compilation
unit.  "inline" is just a hint, and modern compilers are smart enough to inline
functions when appropriate without a hint.

A longer explanation/rant here: https://lore.kernel.org/all/ZAdfX+S323JVWNZC@google.com

#2
Do not wrap before the function name.  Linus has a nice explanation/rant on this[*].

[*] https://lore.kernel.org/all/CAHk-=wjoLAYG446ZNHfg=GhjSY6nFmuB_wA8fYd5iLBNXjo9Bw@mail.gmail.com

> +{
> +	struct kvm_queued_exception *ex = for_ex_vmexit ?
> +		&vcpu->arch.exception_vmexit : &vcpu->arch.exception;
> +
> +	if (ex->has_payload)
> +		return ex->payload;
> +	else if (ex->vector == PF_VECTOR)
> +		return vcpu->arch.cr2;
> +	else if (ex->vector == DB_VECTOR)
> +		return (vcpu->arch.dr6 & ~DR6_BT) ^ DR6_ACTIVE_LOW;
> +	else
> +		return 0;

I'll circle back to this on the next version, i.e. after it's reworked to account
for the suggested payload changes.  I highly doubt it's correct as-is.

>  static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
>  				      struct vmcs12 *vmcs12,
>  				      u32 vm_exit_reason, u32 exit_intr_info)
> @@ -3842,6 +3874,8 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
>  	u32 idt_vectoring;
>  	unsigned int nr;
>  
> +	vmcs12->original_event_data = 0;
> +
>  	/*
>  	 * Per the SDM, VM-Exits due to double and triple faults are never
>  	 * considered to occur during event delivery, even if the double/triple
> @@ -3880,6 +3914,12 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
>  				vcpu->arch.exception.error_code;
>  		}
>  
> +		idt_vectoring |= vcpu->arch.exception.nested ?
> +				INTR_INFO_NESTED_EXCEPTION_MASK : 0;

Please stop using ternary operators this way.  It's less readable and the same
number of lines as:

		if (vcpu->arch.exception.nested)
			idt_vectoring |= INTR_INFO_NESTED_EXCEPTION_MASK;

> +
> +		vmcs12->original_event_data =
> +			nested_vmx_get_event_data(vcpu, false);
> +
>  		vmcs12->idt_vectoring_info_field = idt_vectoring;
>  	} else if (vcpu->arch.nmi_injected) {
>  		vmcs12->idt_vectoring_info_field =
> @@ -3970,19 +4010,7 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu)
>  	struct kvm_queued_exception *ex = &vcpu->arch.exception_vmexit;
>  	u32 intr_info = ex->vector | INTR_INFO_VALID_MASK;
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> -	unsigned long exit_qual;
> -
> -	if (ex->has_payload) {
> -		exit_qual = ex->payload;
> -	} else if (ex->vector == PF_VECTOR) {
> -		exit_qual = vcpu->arch.cr2;
> -	} else if (ex->vector == DB_VECTOR) {
> -		exit_qual = vcpu->arch.dr6;
> -		exit_qual &= ~DR6_BT;
> -		exit_qual ^= DR6_ACTIVE_LOW;
> -	} else {
> -		exit_qual = 0;
> -	}
> +	unsigned long exit_qual = nested_vmx_get_event_data(vcpu, true);

This can't possibly be correct, EXIT_QUAL and EVENT_DATA aren't equivalent, e.g.
the former doesn't have XFD_ERR, but the latter does.

>  	/*
>  	 * Unlike AMD's Paged Real Mode, which reports an error code on #PF
> @@ -4003,10 +4031,12 @@ static void nested_vmx_inject_exception_vmexit(struct kvm_vcpu *vcpu)
>  		intr_info |= INTR_INFO_DELIVER_CODE_MASK;
>  	}
>  
> -	if (kvm_exception_is_soft(ex->vector))
> +	if (kvm_exception_is_soft(ex->vector)) {
>  		intr_info |= INTR_TYPE_SOFT_EXCEPTION;
> -	else
> +	} else {
>  		intr_info |= INTR_TYPE_HARD_EXCEPTION;
> +		intr_info |= ex->nested ? INTR_INFO_NESTED_EXCEPTION_MASK : 0;

Again,

		if (ex->nested)
			intr_info |= INTR_INFO_NESTED_EXCEPTION_MASK;

> +	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {

And here

> +		vmcs12->guest_ia32_fred_config = vmcs_read64(GUEST_IA32_FRED_CONFIG);
> +		vmcs12->guest_ia32_fred_rsp1 = vmcs_read64(GUEST_IA32_FRED_RSP1);
> +		vmcs12->guest_ia32_fred_rsp2 = vmcs_read64(GUEST_IA32_FRED_RSP2);
> +		vmcs12->guest_ia32_fred_rsp3 = vmcs_read64(GUEST_IA32_FRED_RSP3);
> +		vmcs12->guest_ia32_fred_stklvls = vmcs_read64(GUEST_IA32_FRED_STKLVLS);
> +		vmcs12->guest_ia32_fred_ssp1 = vmcs_read64(GUEST_IA32_FRED_SSP1);
> +		vmcs12->guest_ia32_fred_ssp2 = vmcs_read64(GUEST_IA32_FRED_SSP2);
> +		vmcs12->guest_ia32_fred_ssp3 = vmcs_read64(GUEST_IA32_FRED_SSP3);
> +	}
> +
>  	vmcs12->guest_pending_dbg_exceptions =
>  		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
>  
> @@ -4625,6 +4675,17 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
>  	vmcs_write32(GUEST_IDTR_LIMIT, 0xFFFF);
>  	vmcs_write32(GUEST_GDTR_LIMIT, 0xFFFF);
>  
> +	if (kvm_cpu_cap_has(X86_FEATURE_FRED)) {

And here

