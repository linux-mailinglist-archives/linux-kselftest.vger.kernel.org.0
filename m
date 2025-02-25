Return-Path: <linux-kselftest+bounces-27533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB28AA44F88
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 23:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDFF176F21
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C334210F58;
	Tue, 25 Feb 2025 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrBJa3BG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E51C84A2
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521249; cv=none; b=egcxm97dkq8nktfaXov/aRcaqbY78qXiW1s3sEA3dqzb1ZBDBGNRPbfC5OJ3Oir1K5ngL3m/ClO0VhQWLsnLVjtAIFATa7Cnp5qt0l/RaLLUAnU56GFPiIoUp7WSLBNxOtyrgkYT3p4HTbtB8QDq7gw89eBwtHSpcy00iKj1lgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521249; c=relaxed/simple;
	bh=0OIYTsbCg/LvdsznxXoKOsB/2e7mIuw+BLE+veOVvf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YZYs4hdQhsg9vftehGKYwn1gQdJenp8zzM8xgTA1JFTGSlxpNZNzyVNyqv8a0Mj/pGT9mC7DA/oVMO1cke2sT5L4FR1J2uzkxPMH17MUQW5RDHDe0dlniI/WOG6WyTM9S2RtQ7Um8V5Ij+C4GPK+aXcKlwBePMyHAyoLHVPsoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrBJa3BG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so12552313a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 14:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740521247; x=1741126047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ucrLOyqpwJ7eq8fO487D5FwKU73mYeF5BxoKf8/VEw=;
        b=VrBJa3BGZh3p7vSU3FawkSlQqTcLlzX6S1luMnVt6LXD3L3KIt+vInudXUoSgS7MnF
         swBvY6BbBSfWA7NAwKWd3u2Gjsx+6lyCfQTdzmqOTqA6+ySJ72xVUd/lkVAkrn9YTrav
         AU5TvPIYOirpWQ3UVKnyBZQob/PsrlsbR8yxb47Q0uB4RaBRa19udu7zwGa4/lcDtWJh
         XI9QBJZ57A4zskcbxtUPAws5fXRp6hMbcRh1UHufLJs5sLamwyrROWlBzJcGsY+D8vIN
         iDs7vgYHeJ4xHpFFKxKqq2RcRu5S78I1Us4OsMaywbwfOla8AG0iF8LWiGJpdU3dCaqI
         cNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521247; x=1741126047;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ucrLOyqpwJ7eq8fO487D5FwKU73mYeF5BxoKf8/VEw=;
        b=JK3h5s6dJM9iFB4XLB7Us6P6D/0xOyPbosApxbG89O7nOcOOXSBR+/hjpsky7ELU+b
         4wE2ub8WYopie7M20WERujeX7X1Tl4kJZsP3t86h3QscpzzstaMFwREHDenfdOKynXvq
         ZOJ7nJRxI/5Y6IOBpWSZrcdYkcGEi0kjQZYPTX1M5BpEjwZcS3efToCdelPeoLpGvvnS
         xpIumWpUXNY6+wHLr4LxQdeIexxUZXw504sywXx57fJCltr2Tgpb5KZdwN9kZq3SnCsg
         2wjnIi2lIKXYsXl7sz9/3YdVlg1pTVji4L3YGLMmAEPcO8qLLngH+L5oj/3Srk6hfuEq
         F2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW5LWKUQY8GFFmpnl8ol8ilZiC/4mMVSLExz1bADvsztZvZgvy6k7z/m9v1Y1FCDpwzPZXUEKSZ34eV2bqGNLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkvvH6aaV+DC0TlwKTDjiyqT+DjgtdPGK5L5uhY7FVjBueLqh/
	qZJvWR1v3hTznENi1086B3aKd3FoU/MHZIkoFf/rcATLGxe5WeylSqvQIb2xygxs9KrE7OrTvX4
	+hw==
X-Google-Smtp-Source: AGHT+IEZZKgDGNI4Pw+k/j63UO1IX2t6ZTOTBw7g5OEtTofB5yQ2S2Opb52Oihz8rD3RNpMUYxtczAgs9iI=
X-Received: from pjbsn14.prod.google.com ([2002:a17:90b:2e8e:b0:2fc:15bf:92f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1806:b0:2ee:db8a:29d0
 with SMTP id 98e67ed59e1d1-2fce873aef4mr26128383a91.26.1740521247115; Tue, 25
 Feb 2025 14:07:27 -0800 (PST)
Date: Tue, 25 Feb 2025 14:07:25 -0800
In-Reply-To: <20250128124812.7324-3-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250128124812.7324-1-manali.shukla@amd.com> <20250128124812.7324-3-manali.shukla@amd.com>
Message-ID: <Z74_HQaQ1jY4eKBB@google.com>
Subject: Re: [PATCH v6 2/3] KVM: SVM: Add Idle HLT intercept support
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com, 
	neeraj.upadhyay@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
>=20
> The hypervisor can intercept the HLT instruction by setting the
> HLT-Intercept Bit in VMCB, causing a VMEXIT. This can be wasteful if
> there are pending V_INTR and V_NMI events, as the hypervisor must then
> initiate a VMRUN to handle them.
>=20
> If the HLT-Intercept Bit is cleared and the vCPU executes HLT while
> there are pending V_INTR and V_NMI events, the hypervisor won=E2=80=99t d=
etect
> them, potentially causing indefinite suspension of the vCPU. This poses
> a problem for enlightened guests who  wish to securely handle the
> events.
>=20
> For Secure AVIC scenarios, if a guest does a HLT while an interrupt is
> pending (in IRR), the hypervisor does not have a way to figure out
> whether the guest needs to be re-entered, as it cannot read the guest
> backing page.  The Idle HLT intercept feature allows the hypervisor to
> intercept HLT execution only if there are no pending V_INTR and V_NMI
> events.
>=20
> There are two use cases for the Idle HLT intercept feature:
> - Secure VMs that wish to handle pending events securely without exiting
>   to the hypervisor on HLT (Secure AVIC).

I honestly don't see any reason to talk about Secure AVIC.  It takes a *lot=
* of
background reading to understand how Secure AVIC actually works with Idle H=
LT.
Critically, it requires a *reduction* in acceleration relative to what the =
APM
calls "legacy" AVIC (lol), in that cross-vCPU IPIs are *never* accelerated.
Ignoring device posted interrupts, lack of IPI virtualization means that KV=
M
always has visibility into *new* interrupts.  The only blind spot is self-I=
PI and
interrupts that were already made pending by KVM.

> - Optimization for all the VMs to avoid a wasteful VMEXIT during HLT
>   when there are pending events.
>=20
> On discovering the Idle HLT Intercept, the KVM hypervisor,
> Sets the Idle HLT Intercept bit (bit (6), offset 0x14h) in the VMCB.
> When the Idle HLT Intercept bit is set, HLT Intercept bit (bit (0),
> offset 0xFh) should be cleared.
>=20
> Before entering the HLT state, the HLT instruction performs checks in
> following order:
> - The HLT intercept check, if set, it unconditionally triggers
>   SVM_EXIT_HLT (0x78).
> - The Idle HLT intercept check, if set and there are no pending V_INTR
>   or V_NMI events, triggers SVM_EXIT_IDLE_HLT (0xA6).
>=20
> Details about the Idle HLT intercept feature can be found in AMD APM [1].

This is not a useful changelog.  While I do care about AMD's motivation for=
 adding
Idle HLT, it's far, far more important that the changelog cover (a) what is=
 (and
isn't) being changed in KVM, (b) what edge cases are (or aren't) being hand=
led,
and (c) why the KVM implementation is correct.

>=20
> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April
>      2024, Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>      https://bugzilla.kernel.org/attachment.cgi?id=3D306250

*sigh*

The inscrutable reference to the APM is longer than the table entry.  Just =
copy
the table entry.

  When both HLT and Idle HLT intercepts are active at the same time, the HL=
T
  intercept takes priority. This intercept occurs only if a virtual interru=
pt
  is not pending (V_INTR or V_NMI).

> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>  arch/x86/include/asm/svm.h      |  1 +
>  arch/x86/include/uapi/asm/svm.h |  2 ++
>  arch/x86/kvm/svm/svm.c          | 13 ++++++++++---
>  3 files changed, 13 insertions(+), 3 deletions(-)

...

> @@ -5225,6 +5230,8 @@ static __init void svm_set_cpu_caps(void)
>  		if (vnmi)
>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
> =20
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_IDLE_HLT);

I am 99% certain this is wrong.  Or at the very least, severly lacking an
explanation of why it's correct.  If L1 enables Idle HLT but not HLT interc=
eption,
then it is KVM's responsibility to NOT exit to L1 if there is a pending V_I=
RQ or
V_NMI.

Yeah, it's buggy.  But, it's buggy in part because *existing* KVM support i=
s buggy.
If L1 disables HLT exiting, but it's enabled in KVM, then KVM will run L2 w=
ith
HLT exiting and so it becomes KVM's responsibility to check for valid L2 wa=
ke events
prior to scheduling out the vCPU if L2 executes HLT.  E.g. nVMX handles thi=
s by
reading vmcs02.GUEST_INTERRUPT_STATUS.RVI as part of vmx_has_nested_events(=
).  I
don't see the equivalent in nSVM.

Amusingly, that means Idle HLT is actually a bug fix to some extent.  E.g. =
if there
is a pending V_IRQ/V_NMI in vmcb02, then running with Idle HLT will natural=
ly do
the right thing, i.e. not hang the vCPU.

Anyways, for now, I think the easiest and best option is to simply skip ful=
l nested
support for the moment.

I rewrote the changelog as I was going (I didn't expect to go down so many =
rabbit
holes), and ended up with the below.  Please review and let me know if I mi=
ssed
any wrinkles and/or got anything wrong.

---
From 05281b3782b7f880b3afd68e0074bf3abf6d55a7 Mon Sep 17 00:00:00 2001
From: Manali Shukla <Manali.Shukla@amd.com>
Date: Tue, 28 Jan 2025 12:48:11 +0000
Subject: [PATCH] KVM: SVM: Add Idle HLT intercept support

Add support for "Idle HLT" interception on AMD CPUs, and enable Idle HLT
interception instead of "normal" HLT interception for all VMs for which
HLT-exiting is enabled.  Idle HLT provides a mild performance boost for
all VM types, by avoiding a VM-Exit in the scenario where KVM would
immediately "wake" and resume the vCPU.

Idle HLT makes HLT-exiting conditional on the vCPU not having a valid,
unmasked interrupt.  Specifically, a VM-Exit occurs on execution of HLT
if and only if there are no pending V_IRQ or V_NMI events.  Note, Idle
is a replacement for full HLT interception, i.e. enabling HLT interception
would result in all HLT instructions causing unconditional VM-Exits.  Per
the APM:

 When both HLT and Idle HLT intercepts are active at the same time, the
 HLT intercept takes priority. This intercept occurs only if a virtual
 interrupt is not pending (V_INTR or V_NMI).

For KVM's use of V_IRQ (also called V_INTR in the APM) to detect interrupt
windows, the net effect of enabling Idle HLT is that, if a virtual
interupt is pending and unmasked at the time of HLT, the vCPU will take
a V_IRQ intercept instead of a HLT intercept.

When AVIC is enabled, Idle HLT works as intended: the vCPU continues
unimpeded and services the pending virtual interrupt.

Note, the APM's description of V_IRQ interaction with AVIC is quite
confusing, and requires piecing together implied behavior.  Per the APM,
when AVIC is enabled, V_IRQ *from the VMCB* is ignored:

  When AVIC mode is enabled for a virtual processor, the V_IRQ, V_INTR_PRIO=
,
  V_INTR_VECTOR, and V_IGN_TPR fields in the VMCB are ignored.

Which seems to contradict the behavior of Idle HLT:

  This intercept occurs only if a virtual interrupt is not pending (V_INTR
  or V_NMI).

What's not explicitly stated is that hardware's internal copy of V_IRQ
(and related fields) *are* still active, i.e. are presumably used to cache
information from the virtual APIC.

Handle Idle HLT exits as if they were normal HLT exits, e.g. don't try to
optimize the handling under the assumption that there isn't a pending IRQ.
Irrespective of AVIC, Idle HLT is inherently racy with respect to the vIRR,
as KVM can set vIRR bits asychronously.

No changes are required to support KVM's use Idle HLT while running
L2.  In fact, supporting Idle HLT is actually a bug fix to some extent.
If L1 wants to intercept HLT, recalc_intercepts() will enable HLT
interception in vmcb02 and forward the intercept to L1 as normal.

But if L1 does not want to intercept HLT, then KVM will run L2 with Idle
HLT enabled and HLT interception disabled.  If a V_IRQ or V_NMI for L2
becomes pending and L2 executes HLT, then use of Idle HLT will do the
right thing, i.e. not #VMEXIT and instead deliver the virtual event.  KVM
currently doesn't handle this scenario correctly, e.g. doesn't check V_IRQ
or V_NMI in vmcs02 as part of kvm_vcpu_has_events().

Do not expose Idle HLT to L1 at this time, as supporting nested Idle HLT is
more complex than just enumerating the feature, e.g. requires KVM to handle
the aforementioned scenarios of V_IRQ and V_NMI at the time of exit.

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Link: https://bugzilla.kernel.org/attachment.cgi?id=3D306250
Link: https://lore.kernel.org/r/20250128124812.7324-3-manali.shukla@amd.com
[sean: rewrite changelog, drop nested "support"]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/svm.h      |  1 +
 arch/x86/include/uapi/asm/svm.h |  2 ++
 arch/x86/kvm/svm/svm.c          | 11 ++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index e2fac21471f5..12a9dde1e842 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -116,6 +116,7 @@ enum {
 	INTERCEPT_INVPCID,
 	INTERCEPT_MCOMMIT,
 	INTERCEPT_TLBSYNC,
+	INTERCEPT_IDLE_HLT =3D 166,
 };
=20
=20
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/sv=
m.h
index 1814b413fd57..ec1321248dac 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -95,6 +95,7 @@
 #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
 #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
 #define SVM_EXIT_INVPCID       0x0a2
+#define SVM_EXIT_IDLE_HLT      0x0a6
 #define SVM_EXIT_NPF           0x400
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
@@ -224,6 +225,7 @@
 	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
 	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
 	{ SVM_EXIT_INVPCID,     "invpcid" }, \
+	{ SVM_EXIT_IDLE_HLT,     "idle-halt" }, \
 	{ SVM_EXIT_NPF,         "npf" }, \
 	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
 	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7640a84e554a..37e83bde8f9f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1297,8 +1297,12 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		svm_set_intercept(svm, INTERCEPT_MWAIT);
 	}
=20
-	if (!kvm_hlt_in_guest(vcpu->kvm))
-		svm_set_intercept(svm, INTERCEPT_HLT);
+	if (!kvm_hlt_in_guest(vcpu->kvm)) {
+		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
+			svm_set_intercept(svm, INTERCEPT_IDLE_HLT);
+		else
+			svm_set_intercept(svm, INTERCEPT_HLT);
+	}
=20
 	control->iopm_base_pa =3D iopm_base;
 	control->msrpm_base_pa =3D __sme_set(__pa(svm->msrpm));
@@ -3342,6 +3346,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vc=
pu *vcpu) =3D {
 	[SVM_EXIT_CR4_WRITE_TRAP]		=3D cr_trap,
 	[SVM_EXIT_CR8_WRITE_TRAP]		=3D cr_trap,
 	[SVM_EXIT_INVPCID]                      =3D invpcid_interception,
+	[SVM_EXIT_IDLE_HLT]			=3D kvm_emulate_halt,
 	[SVM_EXIT_NPF]				=3D npf_interception,
 	[SVM_EXIT_RSM]                          =3D rsm_interception,
 	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		=3D avic_incomplete_ipi_interception,
@@ -3504,7 +3509,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u6=
4 exit_code)
 		return interrupt_window_interception(vcpu);
 	else if (exit_code =3D=3D SVM_EXIT_INTR)
 		return intr_interception(vcpu);
-	else if (exit_code =3D=3D SVM_EXIT_HLT)
+	else if (exit_code =3D=3D SVM_EXIT_HLT || exit_code =3D=3D SVM_EXIT_IDLE_=
HLT)
 		return kvm_emulate_halt(vcpu);
 	else if (exit_code =3D=3D SVM_EXIT_NPF)
 		return npf_interception(vcpu);

base-commit: b9cd96a7ff9cc9ddf95de59d69afb174a9e90c6e
--=20

