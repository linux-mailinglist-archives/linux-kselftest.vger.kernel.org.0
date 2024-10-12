Return-Path: <linux-kselftest+bounces-19577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C0499AF99
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 02:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5FCB21567
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 00:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9064A;
	Sat, 12 Oct 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYsqXDvh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D618D
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728691538; cv=none; b=o4ZnPm28+Rt524NjeisH69biTImwPnf3WP4wuNwDBt+fZAUYKPVgVmENRU746QBbV4eEmK4eUw7aUm+4FuX7prPXlk+1PbHxECe/nmCfnct+4Ek1qgGsbjTLcyn8zz5Y7NpcTvjventlxazQiw0dgKy5SOeUZH+qZdX7H7AM7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728691538; c=relaxed/simple;
	bh=J1/gIlnPqkAFa2JKddAUunvH65A+Jirv9gFzcapIMUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bBxOTKteWSlf9aLqpfMoA/BxRGqfpzqDVH9zo46UxYZB6U37X5bMD3X4zwIo+NGhLiulDaf4KavUjuxPPqJndx1RlX7LyZLOm92uG22enCSutVUxD3bMno+3Yvtkt1j8ClFlxcC5RYELt4EqNCPGAaaKs3/k/ic3wQa+jKg+yPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYsqXDvh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-205425b7e27so23072395ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728691536; x=1729296336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vaIfiXpBLc9u/MuKbPyqCzVD1xIl1tw18RigZRtR3Eo=;
        b=zYsqXDvhlx1MRXwjn2oaYCZZIXkq7K4PNpv0avBfkMBG9l19f41gtYvCCGV2Xglhut
         pJDuKgJxzeQizge93orX6d1OpFB/vC6m2JreBlBaXC4lxqfSwaR4pRf27HMl62BOFNkY
         kqiHg2eoSCXVwHFAGWKMeFX/gL2mJqX0NHFwximkFY3/PoQJpGn/vqUCBMQRFZTRjt9w
         Q+5Dp/ZupoyL46A3nnllg90dsTdD2hRNEtM8xLnlWRLHbWZ/QsDENLxXp/J3uIGhDi8e
         P8ovoEPhoAg8ZWxFd2YcwBnIr70W5aKnC2sRjtdoynMUP175zUN9mfnifUXmrxInT1vr
         wHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728691536; x=1729296336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaIfiXpBLc9u/MuKbPyqCzVD1xIl1tw18RigZRtR3Eo=;
        b=tRh+SFyP2CQNsnAqZiDnHS0DUqvq9GLFMOzz8fPL+BfrhZ+BA0yq74WpVRnbp8qPKB
         51JKoGK0dPk3REutfQSjNtxVFl/tkJzeoKNUyZ5CzeKhfT7Pk+TQe45CQ9iDkIq8kdMj
         4irD/FlWwcO/Ay+/4R01FKy/3SOlSEKJziwesr5FVAk4CIFrTakCV/njwF4cPU9jsheE
         M/TdYgwcHWbiqB3iWXlt0E45y753usULs1soCqBFeAHKXKIWhUf2wA7T9SAIm0Ub4GI7
         u7A6MDv2YvHNjvoV+PS/YvemID3s/7NG8OFNFImTtu5YZJirriQU9q4+nSVA1MzDNGQ0
         6UZg==
X-Forwarded-Encrypted: i=1; AJvYcCVE1Y2ZVVdrbCcMchJGzaDhRCsnVYpP10ZnXCXSu3UyGpfCuQzqKyjDydN635cFotLf1wTvw1mOSIwHkxHy0cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgv3zhQtTblwB6eRW9P8QdTwyZrJGVsoCDyo5+ZXh/3Wojklfi
	rRrBt/FLhUhZWMSQJATN9xAcCRQkkDR12+9GrCkgHThZneBpZ5sn5EiilmliX2oFsbpsPVWCl7J
	jgQ==
X-Google-Smtp-Source: AGHT+IEONpztJtQQzujsGLaZI7XjAb11Kqu/17PUrTuU9XC+36iBPMoHovX1hzYS5G9JC/gUHUDhoy/Egws=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5ca:b0:20c:9821:69b8 with SMTP id
 d9443c01a7336-20ca16c1c45mr152615ad.7.1728691536144; Fri, 11 Oct 2024
 17:05:36 -0700 (PDT)
Date: Fri, 11 Oct 2024 17:05:34 -0700
In-Reply-To: <20240927161657.68110-3-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240927161657.68110-1-iorlov@amazon.com> <20240927161657.68110-3-iorlov@amazon.com>
Message-ID: <Zwm9TmRpNY6EeGKu@google.com>
Subject: Re: [PATCH 2/3] KVM: vmx, svm, mmu: Process MMIO during event delivery
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, jalliste@amazon.com, 
	nh-open-source@amazon.com, pdurrant@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

Same complaints on the shortlog scope.

On Fri, Sep 27, 2024, Ivan Orlov wrote:
> Currently, the situation when guest accesses MMIO during event delivery
> is handled differently in VMX and SVM: on VMX KVM returns internal error
> with suberror = KVM_INTERNAL_ERROR_DELIVERY_EV, when SVM simply goes
> into infinite loop trying to deliver an event again and again.
> 
> Such a situation could happen when the exception occurs with guest IDTR
> (or GDTR) descriptor base pointing to an MMIO address.
> 
> Even with fixes for infinite loops on TDP failures applied, the problem
> still exists on SVM.
> 
> Eliminate the SVM/VMX difference by returning a KVM internal error with
> suberror = KVM_INTERNAL_ERROR_DELIVERY_EV for both SVM and VMX. As we
> don't have a reliable way to detect MMIO operation on SVM before
> actually looking at the GPA, move the problem detection into the common
> KVM x86 layer (into the kvm_mmu_page_fault function) and add the
> PFERR_EVT_DELIVERY flag which gets set in the SVM/VMX specific vmexit
> handler to signal that we are in the middle of the event delivery.
> 
> This way we won't introduce much overhead for VMX platform either, as
> the situation when the guest accesses MMIO during event delivery is
> quite rare and shouldn't happen frequently.
> 
> Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  6 ++++++
>  arch/x86/kvm/mmu/mmu.c          | 15 ++++++++++++++-
>  arch/x86/kvm/svm/svm.c          |  4 ++++
>  arch/x86/kvm/vmx/vmx.c          | 21 +++++++++------------
>  4 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 348daba424dd..a1088239c9f5 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -282,6 +282,12 @@ enum x86_intercept_stage;
>  #define PFERR_PRIVATE_ACCESS   BIT_ULL(49)
>  #define PFERR_SYNTHETIC_MASK   (PFERR_IMPLICIT_ACCESS | PFERR_PRIVATE_ACCESS)
>  
> +/*
> + * EVT_DELIVERY is a KVM-defined flag used to indicate that a fault occurred
> + * during event delivery.
> + */
> +#define PFERR_EVT_DELIVERY     BIT_ULL(50)

This is very clearly a synthetic flag.  See the mask above, and the warnings
that fire.  I think it's a moot point though (see below).

> +
>  /* apic attention bits */
>  #define KVM_APIC_CHECK_VAPIC	0
>  /*
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e081f785fb23..36e25a6ba364 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6120,8 +6120,21 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
>  			return -EFAULT;
>  
>  		r = handle_mmio_page_fault(vcpu, cr2_or_gpa, direct);
> -		if (r == RET_PF_EMULATE)
> +		if (r == RET_PF_EMULATE) {
> +			/*
> +			 * Check if the guest is accessing MMIO during event delivery. For
> +			 * instance, it could happen if the guest sets IDT / GDT descriptor
> +			 * base to point to an MMIO address. We can't deliver such an event

Too many pronouns.

> +			 * without VMM intervention, so return a corresponding internal error
> +			 * instead (otherwise, vCPU will fall into infinite loop trying to
> +			 * deliver the event again and again).
> +			 */
> +			if (error_code & PFERR_EVT_DELIVERY) {

Hmm, I'm 99% certain handling error in this location is wrong, and I'm also pretty
sure it's unnecessary.  Or rather, the synthetic error code is unnecessary.

It's wrong because this path specifically handles "cached" MMIO, i.e. emulated
MMIO that is triggered by a special MMIO SPTE.  KVM should punt to userspace on
_any_ MMIO emulation.  KVM has gotten away with the flaw because SVM is completely
broken, and VMX can always generate reserved EPTEs.  But with SVM, on CPUs with
MAXPHYADDR=52, KVM can't generate a reserved #PF, i.e. can't do cached MMIO, and
so I'm pretty sure your test would fail on those CPUs since they'll never come
down this path.

Heh, though I bet the introduction of RET_PF_WRITE_PROTECTED has regressed shadow
paging on CPUs with PA52.

Anyways, the synthetic PFERR flag is unnecessary because the information is readily
available to {vmx,svm}_check_emulate_instruction().  Ha!  And EMULTYPE_WRITE_PF_TO_SP
means vendor code can even precisely identify MMIO.

I think another X86EMUL_* return type is needed, but that's better than a synthetic
#PF error code flag.

> +				kvm_prepare_ev_delivery_failure_exit(vcpu, cr2_or_gpa, true);
> +				return 0;
> +			}
>  			goto emulate;
> +		}
>  	}
>  
>  	if (r == RET_PF_INVALID) {
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 9df3e1e5ae81..93ce8c3d02f3 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2059,6 +2059,10 @@ static int npf_interception(struct kvm_vcpu *vcpu)
>  	u64 fault_address = svm->vmcb->control.exit_info_2;
>  	u64 error_code = svm->vmcb->control.exit_info_1;
>  
> +	/* Check if we have events awaiting delivery */

No "we".  And this is inaccurate.  The event isn't _awaiting_ delivery, the CPU
was smack dab in the middle of delivering the event.

> +	if (svm->vmcb->control.exit_int_info & SVM_EXITINTINFO_TYPE_MASK)
> +		error_code |= PFERR_EVT_DELIVERY;
> +
>  	/*
>  	 * WARN if hardware generates a fault with an error code that collides
>  	 * with KVM-defined sythentic flags.  Clear the flags and continue on,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index afd785e7f3a3..bbe1126c3c7d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5828,6 +5828,11 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
>  static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
>  {
>  	gpa_t gpa;
> +	u64 error_code = PFERR_RSVD_MASK;
> +
> +	/* Do we have events awaiting delivery? */
> +	error_code |= (to_vmx(vcpu)->idt_vectoring_info & VECTORING_INFO_VALID_MASK)
> +		     ? PFERR_EVT_DELIVERY : 0;
>  
>  	if (vmx_check_emulate_instruction(vcpu, EMULTYPE_PF, NULL, 0))
>  		return 1;
> @@ -5843,7 +5848,7 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
>  		return kvm_skip_emulated_instruction(vcpu);
>  	}
>  
> -	return kvm_mmu_page_fault(vcpu, gpa, PFERR_RSVD_MASK, NULL, 0);
> +	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
>  }
>  
>  static int handle_nmi_window(struct kvm_vcpu *vcpu)
> @@ -6536,24 +6541,16 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  		return 0;
>  	}
>  
> -	/*
> -	 * Note:
> -	 * Do not try to fix EXIT_REASON_EPT_MISCONFIG if it caused by
> -	 * delivery event since it indicates guest is accessing MMIO.
> -	 * The vm-exit can be triggered again after return to guest that
> -	 * will cause infinite loop.
> -	 */
>  	if ((vectoring_info & VECTORING_INFO_VALID_MASK) &&
>  	    (exit_reason.basic != EXIT_REASON_EXCEPTION_NMI &&
>  	     exit_reason.basic != EXIT_REASON_EPT_VIOLATION &&
>  	     exit_reason.basic != EXIT_REASON_PML_FULL &&
>  	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
>  	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
> -	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
> +	     exit_reason.basic != EXIT_REASON_NOTIFY &&
> +	     exit_reason.basic != EXIT_REASON_EPT_MISCONFIG)) {

Changing the behavior of EPT_MISCONFIG belongs in a separate commit.

Huh, and that's technically a bug fix.  If userspace _creates_ a memslot, KVM
doesn't eagerly zap MMIO SPTEs and instead relies on vcpu_match_mmio_gen() to
force kvm_mmu_page_fault() down the actual page fault path.  If the guest somehow
manages to generate an access to the new page while vectoring an event, KVM will
spuriously exit to userspace instead of trying to fault-in the new page.

It's _ridiculously_ contrived, but technically a bug.

Ugh, and the manual call to vmx_check_emulate_instruction() in handle_ept_misconfig()
is similarly flawed, though encountering that is even more contrived as that only
affects accesses from SGX enclaves.

Hmm, and looking at all of this, SVM doesn't take advantage of KVM_FAST_MMIO_BUS.
Unless I'm forgetting some fundamental incompatibility, SVM can do fast MMIO so
long as next_rip is valid.

Anyways, no need to deal with vmx_check_emulate_instruction() or fast MMIO, I'll
tackle that in a separate series.  But for this series, please do the EPT misconfig
in a separate patch from fixing SVM.  E.g. extract the helper, convert VMX to the
new flow, and then teach SVM to do the same.

>  		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> -		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
> -

Blank newline after variable declarations.

> -		kvm_prepare_ev_delivery_failure_exit(vcpu, gpa, is_mmio);
> +		kvm_prepare_ev_delivery_failure_exit(vcpu, gpa, false);
>  		return 0;
>  	}

All in all, I think this is the basic gist?  Definitely feel free to propose a
better name than X86EMUL_UNHANDLEABLE_VECTORING.

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9df3e1e5ae81..7a96bf5af015 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4800,6 +4800,10 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
        bool smep, smap, is_user;
        u64 error_code;
 
+       if (svm->vmcb->control.exit_int_info & SVM_EXITINTINFO_TYPE_MASK &&
+           is_emul_type_mmio(emul_type))
+               return X86EMUL_UNHANDLEABLE_VECTORING;
+
        /* Emulation is always possible when KVM has access to all guest state. */
        if (!sev_guest(vcpu->kvm))
                return X86EMUL_CONTINUE;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1b9cc1032010..43bc73b60c2b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1693,6 +1693,10 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
                                  void *insn, int insn_len)
 {
+       if (to_vmx(vcpu)->idt_vectoring_info & VECTORING_INFO_VALID_MASK &&
+           is_emul_type_mmio(emul_type))
+               return X86EMUL_UNHANDLEABLE_VECTORING;
+
        /*
         * Emulation of instructions in SGX enclaves is impossible as RIP does
         * not point at the failing instruction, and even if it did, the code
@@ -6536,13 +6540,6 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
                return 0;
        }
 
-       /*
-        * Note:
-        * Do not try to fix EXIT_REASON_EPT_MISCONFIG if it caused by
-        * delivery event since it indicates guest is accessing MMIO.
-        * The vm-exit can be triggered again after return to guest that
-        * will cause infinite loop.
-        */
        if ((vectoring_info & VECTORING_INFO_VALID_MASK) &&
            (exit_reason.basic != EXIT_REASON_EXCEPTION_NMI &&
             exit_reason.basic != EXIT_REASON_EPT_VIOLATION &&
@@ -6550,10 +6547,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
             exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
             exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
             exit_reason.basic != EXIT_REASON_NOTIFY)) {
-               gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
-               bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
-
-               kvm_prepare_ev_delivery_failure_exit(vcpu, gpa, is_mmio);
+               kvm_prepare_ev_delivery_failure_exit(vcpu, INVALID_GPA);
                return 0;
        }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8ee67fc23e5d..d5cd254aaca7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9122,6 +9122,11 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
                if (r == X86EMUL_RETRY_INSTR || r == X86EMUL_PROPAGATE_FAULT)
                        return 1;
 
+               if (r == X86EMUL_UNHANDLEABLE_EVENT_VECTORING) {
+                       kvm_prepare_event_vectoring_exit(vcpu, cr2_or_gpa);
+                       return 0;
+               }
+
                WARN_ON_ONCE(r != X86EMUL_UNHANDLEABLE);
                return handle_emulation_failure(vcpu, emulation_type);
        }

