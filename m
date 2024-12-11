Return-Path: <linux-kselftest+bounces-23186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E5D9ED486
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 19:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DBC16861B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1001FF1B2;
	Wed, 11 Dec 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7IyQ7jJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6421AA1E5
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940942; cv=none; b=vEQwSieYtAQxmwID9QROiKPd03K/VjIhcymPX6XEf8q974pD3ZBUtdI7oDra5z0ydj6XSXSRtWzcFYsyYP+wP4ik9yfhPz8C7MyfHdsj+O2xhdsbSqUf3EjW4ynf8/jBtX6J5Wau3h2x93gVdeNidBfuX7U21L3OfkMgd7sc9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940942; c=relaxed/simple;
	bh=FCdpSIc+69N04n0hxak9XuRclAR88h+kQwVsgNXe9Qk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gWi8qrwqSPWEBEKJZZtfi7xkCU8zfqQ89Q1b+JzmcbRbrj9/dedHHiTiPo9SnipzIjW1tczOwmrX7IQERx+eq7dszalILxoNqr8+rTFVLabIWM/meEVEt0zL8UYwrCVGcaLHXyasJ4OmGpbsGbLuFctUt6dA18YnoYKW2hbEyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y7IyQ7jJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so6221217a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 10:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733940940; x=1734545740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATfgSyR4JYqUn5qUKdglRen9QnDSA+hMhyyb2LNpigg=;
        b=Y7IyQ7jJYnbGauVjlZlmSA9P5oHs1Mu2yT8OLwgp2o2pCp1LEbUad8cxf+BeRsSlb4
         QbnaI7XSQJXP6NIeLmXquihGA01VndlJUS3bngsYyKVwUXAw+tCpVjR6gxOVZVVA3C9W
         4/nIWny6a1U7QEFyAuF1qtlCSn9BlahiNrKGmALV4z4fvo/16lplVrDat0LBAUAgHyh/
         pWx6KGsVCNwixyHj+dIGoUsFJ70ytYQNhNzgatzKnlFHe0Ha9WISqkQQydShO+MvaVjd
         /N0vE2PkN8cyT4xZDK1eVYMX2YrwbDJFbVCHxMvXc86WKz0UdtrRxQeTA509xsJ+6z7I
         YlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940940; x=1734545740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATfgSyR4JYqUn5qUKdglRen9QnDSA+hMhyyb2LNpigg=;
        b=Q1vGYDJz6StES53wy8DXg3T9ujv93cS1E6tEDAVO+3bAjUKK9/Du6c+SwA3bq6X3WF
         1P57i2S3KxshuEn3ekk6RLtmJ9cqoNtHf2FKaKtLywGRlQDbc6y3VociGqdOGspiiimo
         264bYcC9WbemyO19L2rBXPqTvBTSAFA/3YIvB4PkPYTftBIXv2WRvHSIjolymQLHDmz9
         yvX2FYuwtP08LovTn5WIbeuuo+OcaiowyjtgWXGFnk9nMiiUMLGW6PlWtb0bCVrPyf4p
         ImHZiX/AEQA05ADrDt9SrAmZ/ArFr+C/C1f4B+y7iLaOwV9Y1kYyvQQlZU7CRvJASSFv
         B94g==
X-Forwarded-Encrypted: i=1; AJvYcCWL4QAa8pNT/YQKrT28NCso7fduZwTeVJn2gIpjqWdOO2YB3/981IK83skEFQBDek96tCfiVZXJRM4lJK3L7mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBwmy46D4s0oAWmtaRuuSg/L7JggcydKnagCwdrUevpqatesWM
	dRtgjfMkTr6xKPkA3xvSZCxeuE4JbT+ze9qaaRbxv93TkUqoW7T3CHhmmXmcNGsNeMUa5RkFtby
	F0w==
X-Google-Smtp-Source: AGHT+IEgf5FQGhJLsrt+78ycGixAnyhGYJ7MCNOZtILxmDM+1RBryh7akh70wZTflop8wQFyJPZmS5+I2ho=
X-Received: from pjbtc7.prod.google.com ([2002:a17:90b:5407:b0:2ef:95f4:4619])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c04:b0:2ea:9ccb:d1f4
 with SMTP id 98e67ed59e1d1-2f127e07c25mr6607472a91.0.1733940940501; Wed, 11
 Dec 2024 10:15:40 -0800 (PST)
Date: Wed, 11 Dec 2024 10:15:38 -0800
In-Reply-To: <20241111102749.82761-4-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com> <20241111102749.82761-4-iorlov@amazon.com>
Message-ID: <Z1nWykQ3e4D5e2C-@google.com>
Subject: Re: [PATCH v2 3/6] KVM: VMX: Handle vectoring error in check_emulate_instruction
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 11, 2024, Ivan Orlov wrote:
> Move unhandleable vmexit due to MMIO during vectoring error detection
> into check_emulate_instruction. Implement a function which checks if
> emul_type indicates MMIO so it can be used for both VMX and SVM.
> 
> Fix the comment about EMULTYPE_PF as this flag doesn't necessarily
> mean MMIO anymore: it can also be set due to the write protection
> violation.
> 
> Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> ---
> V1 -> V2:
> - Detect the unhandleable vectoring error in vmx_check_emulate_instruction
> instead of handling it in the common MMU code (which is specific for
> cached MMIO)
> 
>  arch/x86/include/asm/kvm_host.h | 10 ++++++++--
>  arch/x86/kvm/vmx/vmx.c          | 25 ++++++++++++-------------
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index eb413079b7c6..3de9702a9135 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2017,8 +2017,8 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
>   *			VMware backdoor emulation handles select instructions
>   *			and reinjects the #GP for all other cases.
>   *
> - * EMULTYPE_PF - Set when emulating MMIO by way of an intercepted #PF, in which
> - *		 case the CR2/GPA value pass on the stack is valid.
> + * EMULTYPE_PF - Set when an intercepted #PF triggers the emulation, in which case
> + *		 the CR2/GPA value pass on the stack is valid.
>   *
>   * EMULTYPE_COMPLETE_USER_EXIT - Set when the emulator should update interruptibility
>   *				 state and inject single-step #DBs after skipping
> @@ -2053,6 +2053,12 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
>  #define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
>  #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
>  
> +static inline bool kvm_is_emul_type_mmio(int emul_type)

Hmm, this should probably be "pf_mmio", not just "mmio".  E.g. if KVM is emulating
large swaths of guest code because unrestricted guest is disabled, then can end up
emulating an MMIO access for "normal" emulation.

Hmm, actually, what if we go with this?

  static inline bool kvm_can_emulate_event_vectoring(int emul_type)
  {
	return !(emul_type & EMULTYPE_PF) ||
	       (emul_type & EMULTYPE_WRITE_PF_TO_SP);
  }

The MMIO aspect isn't unique to VMX or SVM, and the above would allow handling
other incompatible emulation types, should they ever arise (unlikely).

More importantly, it provides a single location to document (via comment) exactly
why KVM can't deal with MMIO emulation during event vectoring (and why KVM allows
emulation of write-protect page faults).

It would require using X86EMUL_UNHANDLEABLE_VECTORING instead of
X86EMUL_UNHANDLEABLE_VECTORING_IO, but I don't think that's necessarily a bad
thing.

> +{
> +	return (emul_type & EMULTYPE_PF) &&
> +		!(emul_type & EMULTYPE_WRITE_PF_TO_SP);
> +}
> +
>  int kvm_emulate_instruction(struct kvm_vcpu *vcpu, int emulation_type);
>  int kvm_emulate_instruction_from_buffer(struct kvm_vcpu *vcpu,
>  					void *insn, int insn_len);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f92740e7e107..a10f35d9704b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1693,6 +1693,8 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
>  int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
>  				  void *insn, int insn_len)
>  {
> +	bool is_vect;
> +
>  	/*
>  	 * Emulation of instructions in SGX enclaves is impossible as RIP does
>  	 * not point at the failing instruction, and even if it did, the code
> @@ -1704,6 +1706,13 @@ int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
>  		kvm_queue_exception(vcpu, UD_VECTOR);
>  		return X86EMUL_PROPAGATE_FAULT;
>  	}
> +
> +	is_vect = to_vmx(vcpu)->idt_vectoring_info & VECTORING_INFO_VALID_MASK;
> +
> +	/* Emulation is not possible when MMIO happens during event vectoring. */
> +	if (kvm_is_emul_type_mmio(emul_type) && is_vect)

I definitely prefer to omit the local variable.  

	if ((to_vmx(vcpu)->idt_vectoring_info & VECTORING_INFO_VALID_MASK) &&
	    !kvm_can_emulate_event_vectoring(emul_type))
		return X86EMUL_UNHANDLEABLE_VECTORING;

