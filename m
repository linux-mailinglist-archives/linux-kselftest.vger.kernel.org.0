Return-Path: <linux-kselftest+bounces-11805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A48A905EC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 00:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C1EB21A99
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 22:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3F612C550;
	Wed, 12 Jun 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRPsHtDf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AF129A7B
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232743; cv=none; b=gVPRl5Kbhsc36VZL2MKkVewYRrWV50C1o/jCqPu5lSmKXWDJuBaPgTmdFu0UExGb+n92/+WylPXPouH+4i4WjgxbKLkllvQIfJd5DejWHZ77sizbc582teY5CKvw2sZGExy7DDbbOZ/MpNO1etfHoCHpnNoBm5SDyRYbXSyZ09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232743; c=relaxed/simple;
	bh=9PhuIo3IyQcw4P814d2ZMnmgCFWhfOyk4PBN98JGULk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LePo/HeZ2/X/qVJBXnb9vP5mfwOrZBwZfK//K0lJnf45MNpf1Ndgmi+dVIctR964IxDW96Q8vtgEqG/ydlXzh7p8ezZihYuyPbM7PrtCUo91Oc7noI2nm++Dku06tYBocLgk4edU6aLFD09pvAIzxpPlLd9kUPaqjKiZ+Z4Czp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gRPsHtDf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c24109ad3fso271110a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2024 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718232740; x=1718837540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIMdKxazuAYEMA3ljsiIyftbOZIGg9iFuuIIcdrawL4=;
        b=gRPsHtDfrTBjQEBqcQ1gFhMBD6QElhzLJRL5nfJ1bhGAcXrtbzJFd8fETBP+NCoD2B
         cHKeO3xW8m7natSTX7GkDXf8dfZArO8Zwulw9axQ5aMSYx7jNmdBCdCRsIPwwAgLM+af
         s+es2dmYhvZ+PIlVH579GX+JC5unx+YUq17V4ybR9DgDQo3cL/r0vtJH8UHI+UMGiHbl
         kLK92MT1adTxKU1sxAeszcDsj9pLg1968Z6CdBIegZ+0GbVYvhT5dgDH91LCpRAesKpj
         Vz6auP8qaa80nHKGmKLh73DsFhNN9OGo/si1QJmLSo8LWUw2FMxlGLozw9bvOnobufji
         HYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232740; x=1718837540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIMdKxazuAYEMA3ljsiIyftbOZIGg9iFuuIIcdrawL4=;
        b=s72QkzbqYUaeY6qdNLTV5e16hZlbTED76skbnaU1JIESvr3ci0KTJcYmBAOQMQZaJ5
         tWkG8/CLJP8nUAR5nAwScy/ufq+uCsHPbG0Twa2tVjkj8whOU4yiFiCnlpgaYPZAyrCy
         KatkxhLJgSHAL2yfoJ5FoI0qF3SO34fXUIlsZe7QiCIeW9Zv7a9NU7ObeDDqE7oacC0u
         YRJU6Gn/7iW4A/bAvVRAIBJ9muehJggTaTepnN1RbS0cc9cKNN39+xQDusvYLDby5XDc
         D3l1+JqijHaIXN4J3Fgd/vol0IPsuLJr5dVv/ENMe1CHDvKyR0punu43ckSVNk+HTU/O
         pk5g==
X-Forwarded-Encrypted: i=1; AJvYcCWNSPwtciaVbzEP6+BHAi2ZPKJ0eAtwfd8CpBPSHBVVeBHIDyoqMFpbbdIOaT1/mkylZQEs9E9EXTHMVEj60NGaM5jWCQPrkcT9OHryEzE7
X-Gm-Message-State: AOJu0YwZgUA5ZR+t1LSkPgDnprEXO/75u3+CdAJc1OT4HOMg2JOHDiuy
	wPOYjLnP+Qzi7m3bLPLNE3yHWoOxOv43Skk1dK4yOVwoxtQDl7IGN7fQECVWZYsH/SRo/r7twmL
	oiQ==
X-Google-Smtp-Source: AGHT+IGCAHPANQ/LEowM3vH0tyHfCNdFfhePy3s7fIN6woZGNNV+qREcLXSH6cGMz5j2YasglzwODR04zqY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fb4a:b0:2c2:dffd:1d9e with SMTP id
 98e67ed59e1d1-2c4a7606ed2mr8825a91.1.1718232740203; Wed, 12 Jun 2024 15:52:20
 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:52:18 -0700
In-Reply-To: <20240207172646.3981-13-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-13-xin3.li@intel.com>
Message-ID: <Zmomoj-PngmXHlxQ@google.com>
Subject: Re: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
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
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 4889754415b5..6b796c5c9c2b 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -256,8 +256,12 @@ enum vmcs_field {
>  	PID_POINTER_TABLE_HIGH		= 0x00002043,
>  	SECONDARY_VM_EXIT_CONTROLS	= 0x00002044,
>  	SECONDARY_VM_EXIT_CONTROLS_HIGH	= 0x00002045,
> +	INJECTED_EVENT_DATA		= 0x00002052,
> +	INJECTED_EVENT_DATA_HIGH	= 0x00002053,
>  	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
>  	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
> +	ORIGINAL_EVENT_DATA		= 0x00002404,
> +	ORIGINAL_EVENT_DATA_HIGH	= 0x00002405,

Are these the actual names from the SDM?  E.g. is there no FRED_ prefix to clue
in readers that they are FRED specific? (unless they aren't FRED specific?)

>  	VMCS_LINK_POINTER               = 0x00002800,
>  	VMCS_LINK_POINTER_HIGH          = 0x00002801,
>  	GUEST_IA32_DEBUGCTL             = 0x00002802,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ee61d2c25cb0..f622fb90a098 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1871,9 +1871,29 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
>  		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
>  			     vmx->vcpu.arch.event_exit_inst_len);
>  		intr_info |= INTR_TYPE_SOFT_EXCEPTION;
> -	} else
> +	} else {
>  		intr_info |= INTR_TYPE_HARD_EXCEPTION;
>  
> +		if (kvm_is_fred_enabled(vcpu)) {
> +			u64 event_data = 0;
> +
> +			if (is_debug(intr_info))
> +				/*
> +				 * Compared to DR6, FRED #DB event data saved on
> +				 * the stack frame have bits 4 ~ 11 and 16 ~ 31
> +				 * inverted, i.e.,
> +				 *   fred_db_event_data = dr6 ^ 0xFFFF0FF0UL
> +				 */
> +				event_data = vcpu->arch.dr6 ^ DR6_RESERVED;
> +			else if (is_page_fault(intr_info))
> +				event_data = vcpu->arch.cr2;
> +			else if (is_nm_fault(intr_info))
> +				event_data = to_vmx(vcpu)->fred_xfd_event_data;
> +
> +			vmcs_write64(INJECTED_EVENT_DATA, event_data);
> +		}
> +	}
> +
>  	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
>  
>  	vmx_clear_hlt(vcpu);
> @@ -7082,8 +7102,11 @@ static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
>  	 *
>  	 * Queuing exception is done in vmx_handle_exit. See comment there.
>  	 */
> -	if (vcpu->arch.guest_fpu.fpstate->xfd)
> +	if (vcpu->arch.guest_fpu.fpstate->xfd) {
>  		rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
> +		to_vmx(vcpu)->fred_xfd_event_data = vcpu->arch.cr0 & X86_CR0_TS

kvm_is_cr0_bit_set(), don't read vcpu->arch.cr0 directly.

> +			? 0 : vcpu->arch.guest_fpu.xfd_err;

Maybe this?

		if (kvm_is_cr0_bit_set(vcpu, X86_CR0_TS))
			to_vmx(vcpu)->fred_xfd_event_data = 0;
		else
			to_vmx(vcpu)->fred_xfd_event_data = vcpu->arch.guest_fpu.xfd_err;

Hmm, but why does this need to be cached _now_?  I.e. why does fred_xfd_event_data
need to exist?  Wouldn't it be simpler and more robust to use vcpu->arch.guest_fpu.xfd_err
directly in vmx_inject_exception()?

> +	}
>  }
>  
>  static void handle_exception_irqoff(struct vcpu_vmx *vmx)
> @@ -7199,29 +7222,28 @@ static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
>  					      vmx->loaded_vmcs->entry_time));
>  }
>  
> -static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
> -				      u32 idt_vectoring_info,
> -				      int instr_len_field,
> -				      int error_code_field)
> +static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu, bool vectoring)
>  {
> -	u8 vector;
> -	int type;
> -	bool idtv_info_valid;
> -
> -	idtv_info_valid = idt_vectoring_info & VECTORING_INFO_VALID_MASK;
> +	u32 event_id = vectoring ? to_vmx(vcpu)->idt_vectoring_info
> +				 : vmcs_read32(VM_ENTRY_INTR_INFO_FIELD);


Preferred style for ternary operators is:

	u32 event_id = vectoring ? to_vmx(vcpu)->idt_vectoring_info :
				   vmcs_read32(VM_ENTRY_INTR_INFO_FIELD);

That said, I don't think this is a net positive versus passing in all params.
The bare true/false is somewhat inscrutable, and in this code, it's hard to
understand why KVM looks at X instead of Y without the conext of the caller.

> +	int instr_len_field = vectoring ? VM_EXIT_INSTRUCTION_LEN
> +					: VM_ENTRY_INSTRUCTION_LEN;
> +	int error_code_field = vectoring ? IDT_VECTORING_ERROR_CODE
> +					 : VM_ENTRY_EXCEPTION_ERROR_CODE;
> +	int event_data_field = vectoring ? ORIGINAL_EVENT_DATA
> +					 : INJECTED_EVENT_DATA;
> +	u8 vector = event_id & INTR_INFO_VECTOR_MASK;
> +	int type = event_id & INTR_INFO_INTR_TYPE_MASK;
>  
>  	vcpu->arch.nmi_injected = false;
>  	kvm_clear_exception_queue(vcpu);
>  	kvm_clear_interrupt_queue(vcpu);
>  
> -	if (!idtv_info_valid)
> +	if (!(event_id & INTR_INFO_VALID_MASK))
>  		return;
>  
>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
>  
> -	vector = idt_vectoring_info & VECTORING_INFO_VECTOR_MASK;
> -	type = idt_vectoring_info & VECTORING_INFO_TYPE_MASK;
> -
>  	switch (type) {
>  	case INTR_TYPE_NMI_INTR:
>  		vcpu->arch.nmi_injected = true;
> @@ -7236,10 +7258,31 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
>  		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
>  		fallthrough;
>  	case INTR_TYPE_HARD_EXCEPTION:
> -		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK) {
> -			u32 err = vmcs_read32(error_code_field);
> -			kvm_requeue_exception_e(vcpu, vector, err);
> -		} else
> +		if (kvm_is_fred_enabled(vcpu)) {
> +			/* Save event data for being used as injected-event data */
> +			u64 event_data = vmcs_read64(event_data_field);
> +
> +			switch (vector) {
> +			case DB_VECTOR:
> +				/* %dr6 should be equal to (event_data ^ DR6_RESERVED) */

DR6, no need to use assembly syntax, but I'd just drop this comment, as well as
the CR2 comment.  They add no insight beyond what the code literally does.

> +				vcpu->arch.dr6 = event_data ^ DR6_RESERVED;
> +				break;
> +			case NM_VECTOR:
> +				to_vmx(vcpu)->fred_xfd_event_data = event_data;
> +				break;
> +			case PF_VECTOR:
> +				/* %cr2 should be equal to event_data */
> +				vcpu->arch.cr2 = event_data;
> +				break;
> +			default:
> +				WARN_ON(event_data != 0);
> +				break;
> +			}
> +		}

