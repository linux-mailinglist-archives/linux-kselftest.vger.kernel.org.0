Return-Path: <linux-kselftest+bounces-11881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC647907A63
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5D81C24E4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D5214A614;
	Thu, 13 Jun 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykWiSxmI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52314A0B5
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301477; cv=none; b=X2bJF1jUte72XKtzZQQXLq8AaCFBJyMxbPjW14OosyNynTCsI68E64qOKNF3T1ondvMS+NtQ4UkNm5KiZqrXFF85qZpoGpapOY1XTsQb/+DKBRuJh16W7paYZ2LkBT0fZ6jnx2wJdY94UGn15obHWFTW5Ylpe/RXJkBd4zEfOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301477; c=relaxed/simple;
	bh=lBlGfGoRJeskbbbyidHNkAcekEyRcBJYM2hxNdBVF8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VQcooX4VhuMS74mN/8JnlRc5mkyRWvvqmHZSmAJCyL8wQIuqG9PPTKGG1x7fs66LjLpvw52U0k0KS7cObSaBA1saHJRuxvOTXHr2gEfoKfe1bw6o74vsQsYGCrNr3gw4qk30zbl5XL8VqD1dYli6u/txzXBCuRMNjGt9XJUbX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykWiSxmI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6f85e92941aso965168a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718301473; x=1718906273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cC/W6+SSqcT9n7OPJpY2oZpb/gfAECzMqcQ6BsTvuhM=;
        b=ykWiSxmIBnQCEbrM/TpUOsnn3EgcaFO5V6FTqPqRZLqLdVOEIr0ZaBm73nysc2vpEo
         RuUVyTVaOtfBo3GQM6DfkVlKlY0XeHEHBlFwOAfBREUXmFhVOUDjPL/7D2QykVI4Rd76
         CfIj/fDvvdxuMXDDJZ9HBvQlgiT8rgUvD3rbjqWnxy0RCUoKJFVLY0vJnAO6eIyIqnOv
         pDoQGVowwmnBjW02cODGNNWPrKAI6Ypn+omPcu52uIXu4uYUdJg9sO6OSE9ZzOSBeZ78
         smPJT8T2RcZykPxVEZq0VW65gYITqeodBhzkr4k77igvwpHF+ICVBc8bxwmmj+4gLyeQ
         IfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718301473; x=1718906273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cC/W6+SSqcT9n7OPJpY2oZpb/gfAECzMqcQ6BsTvuhM=;
        b=spLNEf8HQKru2erekyolbr1HOQYS3LJpDcFtmcdcZaVd7CFundA3aBy1QSxxGN31eS
         oc384o11slxlootemtW/TrebdA9WV9DxQB8wdNfaU6TOYXj3gIWZEN5213fLyGEkyR7t
         VlnC6lAu4dwiRLk8I88mR9u49t2Kl66Ive1BoNt2ZiLhC8f0YbzphoBKISK4rhBL/Kt9
         IDWHyLC4w3kzu+av28XkiTG3RS4jiLl1dnWoudx+tHwFXXCm/yogMjzr+mmuwfbM+D/S
         rU44QD4OFEjbIiflD8j379iamksKhzjTWd2MhsgwWlIApnONN1kc84DIhMkElzEjzkj7
         FaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzfnyUcdGuyt5NjvgylpL6HzDyHi1JcU9hohdsOfcrtURugaBFBpClxHeXban9TMykabZL+AckP/oHNQTOg4XnW53097daOAocE78wbRG4
X-Gm-Message-State: AOJu0Yzd9UUaE5tBBX+vj3MrG6PufR9i+Xn90saXy7TGDhEfcaSGCIff
	qP0P0fGrUp88l8EJbWvlr8W5NGTMd0XRmsmJPuq1f1Y0vxBe8VFbx2H3QobE8LbKsNeIt+tq3e4
	r6w==
X-Google-Smtp-Source: AGHT+IGAe5sNyTkqCQPREtvVKYYBflX3N2CT0u3+/vXjbwQvZafr9ZLOt2TGiYGI6AXq7EWRd4OdyqlD26w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:8403:b0:2c2:cc96:a41c with SMTP id
 98e67ed59e1d1-2c4dbd339femr25984a91.6.1718301473399; Thu, 13 Jun 2024
 10:57:53 -0700 (PDT)
Date: Thu, 13 Jun 2024 10:57:52 -0700
In-Reply-To: <ZmqDp/dpCfT6qc3l@chao-email>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-13-xin3.li@intel.com>
 <ZjBiLDJ4SdQ0p5xm@chao-email> <SA1PR11MB6734740F9B6085E0997A4179A8E72@SA1PR11MB6734.namprd11.prod.outlook.com>
 <Zj7f+JWbVfIBIK8h@chao-email> <Zmov1x2KFtoMN3Vm@google.com> <ZmqDp/dpCfT6qc3l@chao-email>
Message-ID: <ZmszIOsGtNsvqbpI@google.com>
Subject: Re: [PATCH v2 12/25] KVM: VMX: Handle FRED event data
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xin3 Li <xin3.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	Ravi V Shankar <ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Content-Type: multipart/mixed; charset="UTF-8"; boundary="BjJMh3azNcbdNTca"


--BjJMh3azNcbdNTca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 13, 2024, Chao Gao wrote:
> On Wed, Jun 12, 2024 at 04:31:35PM -0700, Sean Christopherson wrote:
> >On Sat, May 11, 2024, Chao Gao wrote:
> >> On Fri, May 10, 2024 at 05:36:03PM +0800, Li, Xin3 wrote:
> >> >> >+               if (kvm_is_fred_enabled(vcpu)) {
> >> >> >+                       u64 event_data = 0;
> >> >> >+
> >> >> >+                       if (is_debug(intr_info))
> >> >> >+                               /*
> >> >> >+                                * Compared to DR6, FRED #DB event data saved on
> >> >> >+                                * the stack frame have bits 4 ~ 11 and 16 ~ 31
> >> >> >+                                * inverted, i.e.,
> >> >> >+                                *   fred_db_event_data = dr6 ^ 0xFFFF0FF0UL
> >> >> >+                                */
> >> >> >+                               event_data = vcpu->arch.dr6 ^ DR6_RESERVED;
> >> >> >+                       else if (is_page_fault(intr_info))
> >> >> >+                               event_data = vcpu->arch.cr2;
> >> >> >+                       else if (is_nm_fault(intr_info))
> >> >> >+                               event_data =
> >> >> >+ to_vmx(vcpu)->fred_xfd_event_data;
> >> >> >+
> >> >> 
> >> >> IMO, deriving an event_data from CR2/DR6 is a little short-sighted because the
> >> >> event_data and CR2/DR6 __can__ be different, e.g., L1 VMM __can__ set CR2 to A
> >> >> and event_data field to B (!=A) when injecting #PF.
> >> >
> >> >VMM should guarantee a FRED guest _sees_ consistent values in CR6/DR6
> >> >and event data. If not it's just a VMM bug that we need to fix.
> >> 
> >> I don't get why VMM should.
> >> 
> >> I know the hardware will guarantee this. And likely KVM will also do this.
> >> but I don't think it is necessary for KVM to assume L1 VMM will guarantee
> >> this. because as long as L2 guest is enlightened to read event_data from stack
> >> only, the ABI between L1 VMM and L2 guest can be: CR2/DR6 may be out of sync
> >> with the event_data. I am not saying it is good that L1 VMM deviates from the
> >> real hardware behavior. But how L1 VMM defines this ABI with L2 has nothing to
> >> do with KVM as L0. KVM shouldn't make assumptions on that.
> >
> >Right, but in that case the propagation of event_data would be from vmcs12 =>
> >vmcs02, which is handled by prepare_vmcs02_early().
> 
> Yes. But delivering this event to L2 may cause VM-exit. So, L0 KVM may need to
> re-inject this event ...
> 
> >
> >For this flow, it specifically handles exception injection from _L0 KVM_, in which
> >case KVM should always follow the architectural behavior.
> 
> ... and go through this exception injection flow. For such an event, there is no
> guarantee that the associated event data is consistent with the vCPU's
> DR6/CR2/XFD_ERR.
> 
> >
> >Ahh, but the code in with __vmx_complete_interrupts() is wrong.  Overwriting
> >vcpu->arch.{dr6,cr2} is wrong, because theres no telling what was in vmcs02.
> >And even if vmcs02 holds DR6/CR2 values, those might be L2 values, i.e. shouldn't
> >clobber the vCPU state.
> 
> Exactly.
> 
> >
> >It's not clear to me that we need to do anything new for FRED in
> >__vmx_complete_interrupts().  The relevant VMCS fields should already hold the
> >correct values, there's no reason to clobber vCPU state.  The reason KVM grabs
> 
> The whole point is to cache the ORIGINAL_EVENT_DATA VMCS field so that KVM can
> set it back to the INJECTED_EVENT_DATA VMCS field when reinjecting the pending
> event in IDT-vectoring information.

Hrm, right.  I was thinking INJECTED_EVENT_DATA would already hold the correct
data, but that's only true when the VM-Exit occurred on an injected event, i.e.
when KVM already set the relevant fields.  Ah, and not capturing the state would
lead to loss of data on migration.

I think the right way to handle this is to add kvm_queued_exception.event_data,
and then fill event_data during kvm_deliver_exception_payload() when injecting
an event for the first time, and set it directly when re-injecting an event.  The
event data is effectively the same thing as the payload, it just happens to be
deliver on the event stack frame, not via architectural register state.

And I think we should also rework kvm_requeue_exception() to open code stuffing
vcpu->arch.exception instead of using kvm_multiple_exception().  The two flows
(injection vs. re-injection) don't actually have that much in common, and the
common parts are the super duper simple things, e.g. actually setting values and
requested KVM_REQ_EVENT.

Aha!  And there is a pre-existing bug in handle_nm_fault_irqoff(), as it clobbers
guest XFD_ERR if CR0.TS=1.

Speaking of XFD_ERR, I think the best way to deal with that is to pass it along
as a payload, but then simply do nothing when delivering the payload... until
FRED comes along, and then kvm_deliver_exception_payload() can be responsible
for setting FRED's ex->event_data.

With that combination of tweaks, "normal" injection always sets event_data via
the payload, and because re-injected events never deliver payloads (already
delivered), KVM will naturally avoid clobbering ex->event_data with stale state
(and obviously doesn't need to overwrite CR2 or DR6).

Attached patches are compile-tested only.  They're a subset of the overall series,
hopefully it's fairly easy to understand where they slot in.

--BjJMh3azNcbdNTca
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-KVM-x86-Use-a-dedicated-flow-for-queueing-re-injecte.patch"

From 0cdb034adbcfcc11a584d0e16dddfa151afb36db Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Jun 2024 08:09:51 -0700
Subject: [PATCH 03/28] KVM: x86: Use a dedicated flow for queueing re-injected
 exceptions

Open code the filling of vcpu->arch.exception in kvm_requeue_exception()
instead of bouncing through kvm_multiple_exception(), as re-injection
doesn't actually share that much code with "normal" injection, e.g. the
VM-Exit interception check, payload delivery, and nested exception code
is all bypassed as those flows only apply during initial injection.

When FRED comes along, the special casing will only get worse, as FRED
explicitly tracks nested exceptions and essentially delivers the payload
on the stack frame, i.e. re-injection will need more inputs, and normal
injection will have yet more code that needs to be bypassed when KVM is
re-injecting an exception.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 +-
 arch/x86/kvm/svm/svm.c          | 15 +++---
 arch/x86/kvm/vmx/vmx.c          | 16 +++---
 arch/x86/kvm/x86.c              | 89 ++++++++++++++++-----------------
 4 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b5b2d0fde579..2cd08b8da3b3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2060,8 +2060,8 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
-void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr);
-void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
+void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
+			   bool has_error_code, u32 error_code);
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
 void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				    struct x86_exception *fault);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e90b429c84f1..cd2ed3329c01 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4048,20 +4048,23 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 		vcpu->arch.nmi_injected = true;
 		svm->nmi_l1_to_l2 = nmi_l1_to_l2;
 		break;
-	case SVM_EXITINTINFO_TYPE_EXEPT:
+	case SVM_EXITINTINFO_TYPE_EXEPT: {
+		u32 error_code = 0;
+
 		/*
 		 * Never re-inject a #VC exception.
 		 */
 		if (vector == X86_TRAP_VC)
 			break;
 
-		if (exitintinfo & SVM_EXITINTINFO_VALID_ERR) {
-			u32 err = svm->vmcb->control.exit_int_info_err;
-			kvm_requeue_exception_e(vcpu, vector, err);
+		if (exitintinfo & SVM_EXITINTINFO_VALID_ERR)
+			error_code = svm->vmcb->control.exit_int_info_err;
 
-		} else
-			kvm_requeue_exception(vcpu, vector);
+		kvm_requeue_exception(vcpu, vector,
+				      exitintinfo & SVM_EXITINTINFO_VALID_ERR,
+				      error_code);
 		break;
+	}
 	case SVM_EXITINTINFO_TYPE_INTR:
 		kvm_queue_interrupt(vcpu, vector, false);
 		break;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 581967d20659..8485fd1e28eb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7085,13 +7085,17 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 	case INTR_TYPE_SOFT_EXCEPTION:
 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
 		fallthrough;
-	case INTR_TYPE_HARD_EXCEPTION:
-		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK) {
-			u32 err = vmcs_read32(error_code_field);
-			kvm_requeue_exception_e(vcpu, vector, err);
-		} else
-			kvm_requeue_exception(vcpu, vector);
+	case INTR_TYPE_HARD_EXCEPTION: {
+		u32 error_code = 0;
+
+		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK)
+			error_code = vmcs_read32(error_code_field);
+
+		kvm_requeue_exception(vcpu, vector,
+				      idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK,
+				      error_code);
 		break;
+	}
 	case INTR_TYPE_SOFT_INTR:
 		vcpu->arch.event_exit_inst_len = vmcs_read32(instr_len_field);
 		fallthrough;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 363b1c080205..d1423e42b0c1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -643,9 +643,9 @@ static void kvm_leave_nested(struct kvm_vcpu *vcpu)
 	kvm_x86_ops.nested_ops->leave_nested(vcpu);
 }
 
-static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
-		unsigned nr, bool has_error, u32 error_code,
-	        bool has_payload, unsigned long payload, bool reinject)
+static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
+				   bool has_error, u32 error_code,
+				   bool has_payload, unsigned long payload)
 {
 	u32 prev_nr;
 	int class1, class2;
@@ -653,13 +653,10 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
 	/*
-	 * If the exception is destined for L2 and isn't being reinjected,
-	 * morph it to a VM-Exit if L1 wants to intercept the exception.  A
-	 * previously injected exception is not checked because it was checked
-	 * when it was original queued, and re-checking is incorrect if _L1_
-	 * injected the exception, in which case it's exempt from interception.
+	 * If the exception is destined for L2, morph it to a VM-Exit if L1
+	 * wants to intercept the exception.
 	 */
-	if (!reinject && is_guest_mode(vcpu) &&
+	if (is_guest_mode(vcpu) &&
 	    kvm_x86_ops.nested_ops->is_exception_vmexit(vcpu, nr, error_code)) {
 		kvm_queue_exception_vmexit(vcpu, nr, has_error, error_code,
 					   has_payload, payload);
@@ -668,28 +665,9 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 
 	if (!vcpu->arch.exception.pending && !vcpu->arch.exception.injected) {
 	queue:
-		if (reinject) {
-			/*
-			 * On VM-Entry, an exception can be pending if and only
-			 * if event injection was blocked by nested_run_pending.
-			 * In that case, however, vcpu_enter_guest() requests an
-			 * immediate exit, and the guest shouldn't proceed far
-			 * enough to need reinjection.
-			 */
-			WARN_ON_ONCE(kvm_is_exception_pending(vcpu));
-			vcpu->arch.exception.injected = true;
-			if (WARN_ON_ONCE(has_payload)) {
-				/*
-				 * A reinjected event has already
-				 * delivered its payload.
-				 */
-				has_payload = false;
-				payload = 0;
-			}
-		} else {
-			vcpu->arch.exception.pending = true;
-			vcpu->arch.exception.injected = false;
-		}
+		vcpu->arch.exception.pending = true;
+		vcpu->arch.exception.injected = false;
+
 		vcpu->arch.exception.has_error_code = has_error;
 		vcpu->arch.exception.vector = nr;
 		vcpu->arch.exception.error_code = error_code;
@@ -730,30 +708,53 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr)
 {
-	kvm_multiple_exception(vcpu, nr, false, 0, false, 0, false);
+	kvm_multiple_exception(vcpu, nr, false, 0, false, 0);
 }
 EXPORT_SYMBOL_GPL(kvm_queue_exception);
 
-void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr)
-{
-	kvm_multiple_exception(vcpu, nr, false, 0, false, 0, true);
-}
-EXPORT_SYMBOL_GPL(kvm_requeue_exception);
 
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr,
 			   unsigned long payload)
 {
-	kvm_multiple_exception(vcpu, nr, false, 0, true, payload, false);
+	kvm_multiple_exception(vcpu, nr, false, 0, true, payload);
 }
 EXPORT_SYMBOL_GPL(kvm_queue_exception_p);
 
 static void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
 				    u32 error_code, unsigned long payload)
 {
-	kvm_multiple_exception(vcpu, nr, true, error_code,
-			       true, payload, false);
+	kvm_multiple_exception(vcpu, nr, true, error_code, true, payload);
 }
 
+void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
+			   bool has_error_code, u32 error_code)
+{
+
+	/*
+	 * On VM-Entry, an exception can be pending if and only if event
+	 * injection was blocked by nested_run_pending.  In that case, however,
+	 * vcpu_enter_guest() requests an immediate exit, and the guest
+	 * shouldn't proceed far enough to need reinjection.
+	 */
+	WARN_ON_ONCE(kvm_is_exception_pending(vcpu));
+
+	/*
+	 * Do not check for interception when injecting an event for L2, as the
+	 * exception was checked for intercept when it was original queued, and
+	 * re-checking is incorrect if _L1_ injected the exception, in which
+	 * case it's exempt from interception.
+	 */
+	kvm_make_request(KVM_REQ_EVENT, vcpu);
+
+	vcpu->arch.exception.injected = true;
+	vcpu->arch.exception.has_error_code = has_error_code;
+	vcpu->arch.exception.vector = nr;
+	vcpu->arch.exception.error_code = error_code;
+	vcpu->arch.exception.has_payload = false;
+	vcpu->arch.exception.payload = 0;
+}
+EXPORT_SYMBOL_GPL(kvm_requeue_exception);
+
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err)
 {
 	if (err)
@@ -823,16 +824,10 @@ void kvm_inject_nmi(struct kvm_vcpu *vcpu)
 
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
 {
-	kvm_multiple_exception(vcpu, nr, true, error_code, false, 0, false);
+	kvm_multiple_exception(vcpu, nr, true, error_code, false, 0);
 }
 EXPORT_SYMBOL_GPL(kvm_queue_exception_e);
 
-void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
-{
-	kvm_multiple_exception(vcpu, nr, true, error_code, false, 0, true);
-}
-EXPORT_SYMBOL_GPL(kvm_requeue_exception_e);
-
 /*
  * Checks if cpl <= required_cpl; if true, return true.  Otherwise queue
  * a #GP and return false.
-- 
2.45.2.627.g7a2c4fd464-goog


--BjJMh3azNcbdNTca
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0004-KVM-VMX-Don-t-modify-guest-XFD_ERR-if-CR0.TS-1.patch"

From 64ff7eb90d0e3b044fb423c6d073b3966f866eb3 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Jun 2024 10:10:11 -0700
Subject: [PATCH 04/28] KVM: VMX: Don't modify guest XFD_ERR if CR0.TS=1

Don't update the guest's XFD_ERR MSR if CR0.TS is set; per the SDM,
XFD_ERR is not modified if CR0.TS=1.  Although it's not explicitly stated
in the SDM, conceptually it makes sense the CR0.TS check would be done
prior to the XFD_ERR check, e.g. CR0.TS=1 blocks all SIMD state, whereas
XFD blocks only XTILE state.

  Device-not-available exceptions that are not due to XFD - those
  resulting from setting CR0.TS to 1 - do not modify the IA32_XFD_ERR MSR.

Opportunistically update the comment to call out that XFD_ERR is updated
before the VM-Exit check occurs.  Nothing in the SDM explicitly calls out
this behavior, but logically it must be the behavior, otherwise reading
XFD_ERR in handle_nm_fault_irqoff() would return stale data, i.e. the
to-be-delivered XFD_ERR value would need to be saved in EXIT_QUALIFICATION,
a la DR6 for #DB and CR2 for #PF, so that software could capture the guest
value.

Fixes: ec5be88ab29f ("kvm: x86: Intercept #NM for saving IA32_XFD_ERR")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8485fd1e28eb..16c91a78fc2b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6923,16 +6923,16 @@ static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 	 * MSR value is not clobbered by the host activity before the guest
 	 * has chance to consume it.
 	 *
-	 * Do not blindly read xfd_err here, since this exception might
-	 * be caused by L1 interception on a platform which doesn't
-	 * support xfd at all.
+	 * Update the guest's XFD_ERR if and only if XFD is enabled, as the #NM
+	 * interception may have been caused by L1 interception.  Per the SDM,
+	 * XFD_ERR is not modified if CR0.TS=1.
 	 *
-	 * Do it conditionally upon guest_fpu::xfd. xfd_err matters
-	 * only when xfd contains a non-zero value.
-	 *
-	 * Queuing exception is done in vmx_handle_exit. See comment there.
+	 * Note, XFD_ERR is updated _before_ the #NM interception check, i.e.
+	 * unlike CR2 and DR6, the value is not a payload that is attached to
+	 * the #NM exception.
 	 */
-	if (vcpu->arch.guest_fpu.fpstate->xfd)
+	if (vcpu->arch.guest_fpu.fpstate->xfd &&
+	    !kvm_is_cr0_bit_set(vcpu, X86_CR0_TS))
 		rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 }
 
-- 
2.45.2.627.g7a2c4fd464-goog


--BjJMh3azNcbdNTca
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0013-KVM-x86-Add-a-helper-to-detect-if-FRED-is-enabled-fo.patch"

From f38dcc04e334cda572289f05f4be7702bebfc96a Mon Sep 17 00:00:00 2001
From: Xin Li <xin3.li@intel.com>
Date: Wed, 7 Feb 2024 09:26:31 -0800
Subject: [PATCH 13/28] KVM: x86: Add a helper to detect if FRED is enabled for
 a vCPU

Add is_fred_enabled() to detect if FRED is enabled on a vCPU.

Signed-off-by: Xin Li <xin3.li@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/kvm_cache_regs.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 75eae9c4998a..fe5546efd388 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -187,6 +187,21 @@ static __always_inline bool kvm_is_cr4_bit_set(struct kvm_vcpu *vcpu,
 	return !!kvm_read_cr4_bits(vcpu, cr4_bit);
 }
 
+/*
+ * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
+ * a vCPU is running with FRED enabled, because:
+ * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
+ * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
+ */
+static inline bool is_fred_enabled(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_X86_64
+	return kvm_is_cr4_bit_set(vcpu, X86_CR4_FRED);
+#else
+	return false;
+#endif
+}
+
 static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
-- 
2.45.2.627.g7a2c4fd464-goog


--BjJMh3azNcbdNTca
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0014-KVM-VMX-Pass-XFD_ERR-as-pseudo-payload-when-injectin.patch"

From d5ad36ae7d7aef4c6b97cf624bc38b3b0ec37515 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Jun 2024 10:28:29 -0700
Subject: [PATCH 14/28] KVM: VMX: Pass XFD_ERR as pseudo-payload when injecting
 #NM

Pass XFD_ERR via KVM's exception payload mechanism when injecting an #NM
after interception so that XFD_ERR can be propagated to FRED's event_data
field without needing a dedicated field (which would need to be migrated).

For non-FRED vCPUs, this is a glorified NOP as
kvm_deliver_exception_payload() will simply do nothing (which is desirable
and correct).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d916199f1e60..f0643aa1f4ef 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5316,6 +5316,12 @@ bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu)
 	       (kvm_get_rflags(vcpu) & X86_EFLAGS_AC);
 }
 
+static bool is_xfd_nm_fault(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.guest_fpu.fpstate->xfd &&
+	       !kvm_is_cr0_bit_set(vcpu, X86_CR0_TS);
+}
+
 static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -5342,7 +5348,8 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 	 * point.
 	 */
 	if (is_nm_fault(intr_info)) {
-		kvm_queue_exception(vcpu, NM_VECTOR);
+		kvm_queue_exception_p(vcpu, NM_VECTOR,
+				      is_xfd_nm_fault(vcpu) ? vcpu->arch.guest_fpu.xfd_err : 0);
 		return 1;
 	}
 
@@ -7075,14 +7082,13 @@ static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 	 *
 	 * Update the guest's XFD_ERR if and only if XFD is enabled, as the #NM
 	 * interception may have been caused by L1 interception.  Per the SDM,
-	 * XFD_ERR is not modified if CR0.TS=1.
+	 * XFD_ERR is not modified for non-XFD #NM, i.e. if CR0.TS=1.
 	 *
 	 * Note, XFD_ERR is updated _before_ the #NM interception check, i.e.
 	 * unlike CR2 and DR6, the value is not a payload that is attached to
 	 * the #NM exception.
 	 */
-	if (vcpu->arch.guest_fpu.fpstate->xfd &&
-	    !kvm_is_cr0_bit_set(vcpu, X86_CR0_TS))
+	if (is_xfd_nm_fault(vcpu))
 		rdmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 }
 
-- 
2.45.2.627.g7a2c4fd464-goog


--BjJMh3azNcbdNTca
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0015-KVM-VMX-Virtualize-FRED-event_data.patch"

From 6095c8428dc2b854cb19482832af59c348312527 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Jun 2024 09:07:46 -0700
Subject: [PATCH 15/28] KVM: VMX: Virtualize FRED event_data

---
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/include/asm/vmx.h      |  4 ++++
 arch/x86/kvm/svm/svm.c          |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 22 ++++++++++++++++++----
 arch/x86/kvm/x86.c              | 16 +++++++++++++++-
 5 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7268f90c3615..62eddd1369da 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -736,6 +736,7 @@ struct kvm_queued_exception {
 	u32 error_code;
 	unsigned long payload;
 	bool has_payload;
+	u64 event_data;
 };
 
 struct kvm_vcpu_arch {
@@ -2061,7 +2062,7 @@ void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
-			   bool has_error_code, u32 error_code);
+			   bool has_error_code, u32 error_code, u64 event_data);
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
 void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				    struct x86_exception *fault);
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 4889754415b5..6b796c5c9c2b 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -256,8 +256,12 @@ enum vmcs_field {
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
 	SECONDARY_VM_EXIT_CONTROLS	= 0x00002044,
 	SECONDARY_VM_EXIT_CONTROLS_HIGH	= 0x00002045,
+	INJECTED_EVENT_DATA		= 0x00002052,
+	INJECTED_EVENT_DATA_HIGH	= 0x00002053,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
+	ORIGINAL_EVENT_DATA		= 0x00002404,
+	ORIGINAL_EVENT_DATA_HIGH	= 0x00002405,
 	VMCS_LINK_POINTER               = 0x00002800,
 	VMCS_LINK_POINTER_HIGH          = 0x00002801,
 	GUEST_IA32_DEBUGCTL             = 0x00002802,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cd2ed3329c01..ce25e43b4ec3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4062,7 +4062,7 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 
 		kvm_requeue_exception(vcpu, vector,
 				      exitintinfo & SVM_EXITINTINFO_VALID_ERR,
-				      error_code);
+				      error_code, 0);
 		break;
 	}
 	case SVM_EXITINTINFO_TYPE_INTR:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f0643aa1f4ef..246230cf3e97 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1876,6 +1876,9 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
 
+	if (is_fred_enabled(vcpu))
+		vmcs_write64(INJECTED_EVENT_DATA, ex->event_data);
+
 	vmx_clear_hlt(vcpu);
 }
 
@@ -7208,7 +7211,8 @@ static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
 static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 				      u32 idt_vectoring_info,
 				      int instr_len_field,
-				      int error_code_field)
+				      int error_code_field,
+				      int event_data_field)
 {
 	u8 vector;
 	int type;
@@ -7243,13 +7247,17 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 		fallthrough;
 	case INTR_TYPE_HARD_EXCEPTION: {
 		u32 error_code = 0;
+		u64 event_data = 0;
 
 		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK)
 			error_code = vmcs_read32(error_code_field);
+		if (is_fred_enabled(vcpu))
+			event_data = vmcs_read64(event_data_field);
 
 		kvm_requeue_exception(vcpu, vector,
 				      idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK,
-				      error_code);
+				      error_code,
+				      event_data);
 		break;
 	}
 	case INTR_TYPE_SOFT_INTR:
@@ -7267,7 +7275,8 @@ static void vmx_complete_interrupts(struct vcpu_vmx *vmx)
 {
 	__vmx_complete_interrupts(&vmx->vcpu, vmx->idt_vectoring_info,
 				  VM_EXIT_INSTRUCTION_LEN,
-				  IDT_VECTORING_ERROR_CODE);
+				  IDT_VECTORING_ERROR_CODE,
+				  ORIGINAL_EVENT_DATA);
 }
 
 static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
@@ -7275,7 +7284,8 @@ static void vmx_cancel_injection(struct kvm_vcpu *vcpu)
 	__vmx_complete_interrupts(vcpu,
 				  vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
 				  VM_ENTRY_INSTRUCTION_LEN,
-				  VM_ENTRY_EXCEPTION_ERROR_CODE);
+				  VM_ENTRY_EXCEPTION_ERROR_CODE,
+				  INJECTED_EVENT_DATA);
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);
 }
@@ -7392,6 +7402,10 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	vmx_disable_fb_clear(vmx);
 
+	/*
+	 * Note, even though FRED delivers the faulting linear address via the
+	 * event data field on the stack, CR2 is still updated.
+	 */
 	if (vcpu->arch.cr2 != native_read_cr2())
 		native_write_cr2(vcpu->arch.cr2);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4e1517698e61..4a76d1ae0575 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -611,9 +611,22 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 		 * breakpoint), it is reserved and must be zero in DR6.
 		 */
 		vcpu->arch.dr6 &= ~BIT(12);
+
+		/*
+		 * FRED #DB event data matches DR6, but follows the polarity of
+		 * VMX's pending debug exceptions, not DR6.
+		 */
+		ex->event_data = ex->payload & ~BIT(12);
+		break;
+	case NM_VECTOR:
+		ex->event_data = ex->payload;
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = ex->payload;
+		ex->event_data = ex->payload;
+		break;
+	default:
+		ex->event_data = 0;
 		break;
 	}
 
@@ -727,7 +740,7 @@ static void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
 }
 
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
-			   bool has_error_code, u32 error_code)
+			   bool has_error_code, u32 error_code, u64 event_data)
 {
 
 	/*
@@ -752,6 +765,7 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 	vcpu->arch.exception.error_code = error_code;
 	vcpu->arch.exception.has_payload = false;
 	vcpu->arch.exception.payload = 0;
+	vcpu->arch.exception.event_data = event_data;
 }
 EXPORT_SYMBOL_GPL(kvm_requeue_exception);
 
-- 
2.45.2.627.g7a2c4fd464-goog


--BjJMh3azNcbdNTca
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0016-KVM-VMX-Virtualize-FRED-nested-exception-tracking.patch"

From d604b666e72ac747470dfef54f7b75cb5f8e93fe Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Jun 2024 09:48:43 -0700
Subject: [PATCH 16/28] KVM: VMX: Virtualize FRED nested exception tracking

---
 arch/x86/include/asm/kvm_host.h |  4 +++-
 arch/x86/include/asm/vmx.h      |  6 ++++--
 arch/x86/kvm/svm/svm.c          |  2 +-
 arch/x86/kvm/vmx/vmx.c          |  6 +++++-
 arch/x86/kvm/x86.c              | 14 +++++++++++++-
 arch/x86/kvm/x86.h              |  1 +
 6 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 62eddd1369da..ceb01114a509 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -736,6 +736,7 @@ struct kvm_queued_exception {
 	u32 error_code;
 	unsigned long payload;
 	bool has_payload;
+	bool nested;
 	u64 event_data;
 };
 
@@ -2062,7 +2063,8 @@ void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
-			   bool has_error_code, u32 error_code, u64 event_data);
+			   bool has_error_code, u32 error_code, bool nested,
+			   u64 event_data);
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
 void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				    struct x86_exception *fault);
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 6b796c5c9c2b..26879ea197a4 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -134,7 +134,7 @@
 #define VMX_BASIC_DUAL_MONITOR_TREATMENT	BIT_ULL(49)
 #define VMX_BASIC_INOUT				BIT_ULL(54)
 #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
-
+#define VMX_BASIC_NESTED_EXCEPTION		BIT_ULL(58)
 
 /* VMX_MISC bits and bitmasks */
 #define VMX_MISC_INTEL_PT			BIT_ULL(14)
@@ -407,13 +407,15 @@ enum vmcs_field {
 #define INTR_INFO_INTR_TYPE_MASK        0x700           /* 10:8 */
 #define INTR_INFO_DELIVER_CODE_MASK     0x800           /* 11 */
 #define INTR_INFO_UNBLOCK_NMI		0x1000		/* 12 */
+#define INTR_INFO_NESTED_EXCEPTION_MASK	0x2000		/* 13 */
 #define INTR_INFO_VALID_MASK            0x80000000      /* 31 */
-#define INTR_INFO_RESVD_BITS_MASK       0x7ffff000
+#define INTR_INFO_RESVD_BITS_MASK       0x7fffd000
 
 #define VECTORING_INFO_VECTOR_MASK           	INTR_INFO_VECTOR_MASK
 #define VECTORING_INFO_TYPE_MASK        	INTR_INFO_INTR_TYPE_MASK
 #define VECTORING_INFO_DELIVER_CODE_MASK    	INTR_INFO_DELIVER_CODE_MASK
 #define VECTORING_INFO_VALID_MASK       	INTR_INFO_VALID_MASK
+#define VECTORING_INFO_NESTED_EXCEPTION_MASK	INTR_INFO_NESTED_EXCEPTION_MASK
 
 #define INTR_TYPE_EXT_INTR		(EVENT_TYPE_EXTINT << 8)	/* external interrupt */
 #define INTR_TYPE_RESERVED		(EVENT_TYPE_RESERVED << 8)	/* reserved */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ce25e43b4ec3..2597b22648dd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4062,7 +4062,7 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 
 		kvm_requeue_exception(vcpu, vector,
 				      exitintinfo & SVM_EXITINTINFO_VALID_ERR,
-				      error_code, 0);
+				      error_code, false, 0);
 		break;
 	}
 	case SVM_EXITINTINFO_TYPE_INTR:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 246230cf3e97..1f017abf1403 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1871,8 +1871,11 @@ static void vmx_inject_exception(struct kvm_vcpu *vcpu)
 		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
 			     vmx->vcpu.arch.event_exit_inst_len);
 		intr_info |= INTR_TYPE_SOFT_EXCEPTION;
-	} else
+	} else {
 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
+		if (ex->nested)
+			intr_info |= INTR_INFO_NESTED_EXCEPTION_MASK;
+	}
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
 
@@ -7257,6 +7260,7 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 		kvm_requeue_exception(vcpu, vector,
 				      idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK,
 				      error_code,
+				      idt_vectoring_info & VECTORING_INFO_NESTED_EXCEPTION_MASK,
 				      event_data);
 		break;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4a76d1ae0575..905225a927ff 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -681,6 +681,11 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 		vcpu->arch.exception.pending = true;
 		vcpu->arch.exception.injected = false;
 
+		vcpu->arch.exception.nested = vcpu->arch.exception.nested ||
+					      (is_fred_enabled(vcpu) &&
+					       (vcpu->arch.nmi_injected ||
+					        vcpu->arch.interrupt.injected));
+
 		vcpu->arch.exception.has_error_code = has_error;
 		vcpu->arch.exception.vector = nr;
 		vcpu->arch.exception.error_code = error_code;
@@ -710,8 +715,13 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 		vcpu->arch.exception.injected = false;
 		vcpu->arch.exception.pending = false;
 
+		/* #DF is NOT a nested event, per its definition. */
+		vcpu->arch.exception.nested = false;
+
 		kvm_queue_exception_e(vcpu, DF_VECTOR, 0);
 	} else {
+		vcpu->arch.exception.nested = is_fred_enabled(vcpu);
+
 		/* replace previous exception with a new one in a hope
 		   that instruction re-execution will regenerate lost
 		   exception */
@@ -740,7 +750,8 @@ static void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
 }
 
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
-			   bool has_error_code, u32 error_code, u64 event_data)
+			   bool has_error_code, u32 error_code, bool nested,
+			   u64 event_data)
 {
 
 	/*
@@ -765,6 +776,7 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 	vcpu->arch.exception.error_code = error_code;
 	vcpu->arch.exception.has_payload = false;
 	vcpu->arch.exception.payload = 0;
+	vcpu->arch.exception.nested = nested;
 	vcpu->arch.exception.event_data = event_data;
 }
 EXPORT_SYMBOL_GPL(kvm_requeue_exception);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 9a52016ebf5a..c1f1d5696080 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -108,6 +108,7 @@ static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.exception.pending = false;
 	vcpu->arch.exception.injected = false;
+	vcpu->arch.exception.nested = false;
 	vcpu->arch.exception_vmexit.pending = false;
 }
 
-- 
2.45.2.627.g7a2c4fd464-goog


--BjJMh3azNcbdNTca--

