Return-Path: <linux-kselftest+bounces-22034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADC29C8EB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A08F287D63
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F551925A8;
	Thu, 14 Nov 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FF4cVJKH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D6192592
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599144; cv=none; b=iCuPMfEpNvbi144dEc4GD5WfildN2oluZtfyOQpzhFqeXSi4oUwWuOip2cQzSZuZJiS/w+USnDFLTYlzGOiGf6hKuok5qY7wuC7PgQ40QsIJU6+sEB7h9i8QPOg+xNIVvM23g8M4crxbaHfFg68Ogbo4u4GbOMhkZ7wjUfDvt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599144; c=relaxed/simple;
	bh=C+NJkcPv7s9qGuiJ2I1jqbMGVje+MrpjNFUlGrq1fv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDWVFJubmPXmq9cGphApiLcaxD1aSDQTDZ9UGr9Bs+0YJJYzdl1FUJxK/A/pU3krhtwneh4BhbF3lh0d4GKAARa6zVxm4c3SriLlwXFyrswBT18JND/ETYd8rBwUbLavaLutmkelH8c2nSNfoWha4o1xxg7kNztUnLDsAFCEG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FF4cVJKH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso115017466b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 07:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731599141; x=1732203941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKhWvCprXhPOjYwjhQw1HJAKTwxj5xU1ykGVF5JlDIo=;
        b=FF4cVJKH0Pu+jY9+EOPBcL9wipK1GLPEgtedQ6nN/edCQKJTRH8Dd8yAygDgSYCFru
         NL65jOYPy+5eDTcM8d6qfyNO2b+5AZDaucpHb/tS5OAUaQz/Xee+fKasIXOVsSVtgPyD
         ejFdpDPZ63wwLxU1+20hiJD8pCF0nkFtZM18M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731599141; x=1732203941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKhWvCprXhPOjYwjhQw1HJAKTwxj5xU1ykGVF5JlDIo=;
        b=pDGPhcDscWBLZsJBujSfUGW4Ik/RXO0A16vBw4TUM+wGn1db9xb9HItJ4xFzUr2mY1
         +8ZYgVuE1wW4i8ynYayYfIftQtvF4q/JOI6LsS4ldjbUAPHruNXWAIwT24DqLmxdonBx
         yQYAiqSK2X6ukY1Ka7ZXe+fcJL7gLP8MFgW8xCmRhInSMbCbdmE6IEkZTBIRWFzFx1tS
         elRb8y4SIe9KWTM89MO6oYTX64g/ewsHjG9vmwmAZP6w25JNceELrS1MDalbHyNRarSk
         AU28CwEyo8Lme9ftHsWDlGZ3Q1o9w9gh+QnGzMMqmCiGvhnvg1Mh/6Y3hHwxgEl+xDMa
         C19g==
X-Forwarded-Encrypted: i=1; AJvYcCW8dzvI9LnS8uXB3T3iWS7Hba1GV5KshsRf2/IOmrIgd5kZPPeidny78rzek2q+5gqTqFDFuuaRVDMQ3Sv+eYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQqvHRsRC2zvaKfoLecnL2Kn+TsrNsc9kznNAA5pGF3aAvk0bf
	LpP5UOU+yvAq73I/9de9cJ0JEb42+ZF7GhedURLESss1gE8wyYcESmg5cRuqZDIbc4rxb7FGxnY
	G3N1ve7gZ1aEEjVNmxadR4s7ZpuaLU4xtOKc9XwDyz6Kc6FtIZSPQjZzhGKxeHyE9AW5F7k/SRw
	UUzJrftX5kMuEvjZUhAkdu11/5/3PUNA==
X-Google-Smtp-Source: AGHT+IGd29LWPGgR9UGCBpZLeV1KN1xw7zia+tlGYRvOw3VgRosrdVlpnWlGMcVf2f8cgT32vDKorJyyGy8zpUnCyzE=
X-Received: by 2002:a17:907:6ea5:b0:a8d:4631:83b0 with SMTP id
 a640c23a62f3a-a9eefe9bb4fmr2392506366b.5.1731599141117; Thu, 14 Nov 2024
 07:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030033514.1728937-1-zack.rusin@broadcom.com>
 <20241030033514.1728937-3-zack.rusin@broadcom.com> <CABgObfaRP6zKNhrO8_atGDLcHs=uvE0aT8cPKnt_vNHHM+8Nxg@mail.gmail.com>
 <CABQX2QMR=Nsn23zojFdhemR7tvGUz6_UM8Rgf6WLsxwDqoFtxg@mail.gmail.com>
 <Zy0__5YB9F5d0eZn@google.com> <CABQX2QNxFDhH1frsGpSQjSs3AWSdTibkxPrjq1QC7FGZC8Go-Q@mail.gmail.com>
 <e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com> <CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com>
 <c3026876-8061-4ab2-9321-97cc05bad510@redhat.com> <CADH9ctBivnvP1tNcatLKzd8EDz8Oo6X65660j8ccxYzk3aFzCA@mail.gmail.com>
 <CABgObfZEyCQMiq6CKBOE7pAVzUDkWjqT2cgfbwjW-RseH8VkLw@mail.gmail.com>
 <CADH9ctA_C1dAOus1K+wOH_SOKTb=-X1sVawt5R=dkH1iGt8QUg@mail.gmail.com>
 <CABgObfZrTyft-3vqMz5w0ZiAhp-v6c32brgftynZGJO8OafrdA@mail.gmail.com>
 <CADH9ctBYp-LMbW4hm3+QwNoXvAc5ryVeB0L1jLY0uDWSe3vbag@mail.gmail.com> <b1ddb439-9e28-4a58-ba86-0395bfc081e0@redhat.com>
In-Reply-To: <b1ddb439-9e28-4a58-ba86-0395bfc081e0@redhat.com>
From: Doug Covelli <doug.covelli@broadcom.com>
Date: Thu, 14 Nov 2024 10:45:30 -0500
Message-ID: <CADH9ctCFYtNfhn3SSp2jp0fzxu6s_X1A+wBNnzvHZVb8qXPk=g@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, Sean Christopherson <seanjc@google.com>, 
	kvm <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Joel Stanley <joel@jms.id.au>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 12:59=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 11/13/24 17:24, Doug Covelli wrote:
> >> No worries, you're not hijacking :) The only reason is that it would
> >> be more code for a seldom used feature and anyway with worse performan=
ce.
> >> (To be clear, CR8 based accesses are allowed, but stores cause an exit
> >> in order to check the new TPR against IRR. That's because KVM's API
> >> does not have an equivalent of the TPR threshold as you point out belo=
w).
> >
> > I have not really looked at the code but it seems like it could also
> > simplify things as CR8 would be handled more uniformly regardless of
> > who is virtualizing the local APIC.
>
> Not much because CR8 basically does not exist at all (it's just a byte
> in memory) with userspace APIC.  So it's not easy to make it simpler, eve=
n
> though it's less uniform.
>
> That said, there is an optimization: you only get KVM_EXIT_SET_TPR if
> CR8 decreases.
>
> >>> Also I could not find these documented anywhere but with MSFT's APIC =
our monitor
> >>> relies on extensions for trapping certain events such as INIT/SIPI pl=
us LINT0
> >>> and SVR writes:
> >>>
> >>> UINT64 X64ApicInitSipiExitTrap    : 1; // WHvRunVpExitReasonX64ApicIn=
itSipiTrap
> >>> UINT64 X64ApicWriteLint0ExitTrap  : 1; // WHvRunVpExitReasonX64ApicWr=
iteTrap
> >>> UINT64 X64ApicWriteLint1ExitTrap  : 1; // WHvRunVpExitReasonX64ApicWr=
iteTrap
> >>> UINT64 X64ApicWriteSvrExitTrap    : 1; // WHvRunVpExitReasonX64ApicWr=
iteTrap
> >>
> >> There's no need for this in KVM's in-kernel APIC model. INIT and
> >> SIPI are handled in the hypervisor and you can get the current
> >> state of APs via KVM_GET_MPSTATE. LINT0 and LINT1 are injected
> >> with KVM_INTERRUPT and KVM_NMI respectively, and they obey IF/PPR
> >> and NMI blocking respectively, plus the interrupt shadow; so
> >> there's no need for userspace to know when LINT0/LINT1 themselves
> >> change. The spurious interrupt vector register is also handled
> >> completely in kernel.
> >
> > I realize that KVM can handle LINT0/SVR updates themselves but our
> > interrupt subsystem relies on knowing the current values of these
> > registers even when not virtualizing the local APIC.  I suppose we
> > could use KVM_GET_LAPIC to sync things up on demand but that seems
> > like it might nor be great from a performance point of view.
>
> Ah no, you're right---you want to track the CPU that has ExtINT enabled
> and send KVM_INTERRUPT to that one, I guess?  And you need the spurious
> vector registers because writes can set the mask bit in LINTx, but
> essentially you want to trap LINT0 changes.
>
> Something like this (missing the KVM_ENABLE_CAP and KVM_CHECK_EXTENSION
> code) is good, feel free to include it in your v2 (Co-developed-by
> and Signed-off-by me):
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 5fb29ca3263b..b7dd89c99613 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -122,6 +122,7 @@
>   #define KVM_REQ_HV_TLB_FLUSH \
>         KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>   #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE  KVM_ARCH_REQ(34)
> +#define KVM_REQ_REPORT_LINT0_ACCESS    KVM_ARCH_REQ(35)
>
>   #define CR0_RESERVED_BITS                                              =
 \
>         (~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_=
TS \
> @@ -775,6 +776,7 @@ struct kvm_vcpu_arch {
>         u64 smi_count;
>         bool at_instruction_boundary;
>         bool tpr_access_reporting;
> +       bool lint0_access_reporting;
>         bool xfd_no_write_intercept;
>         u64 ia32_xss;
>         u64 microcode_version;
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 88dc43660d23..0e070f447aa2 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1561,6 +1561,21 @@ static u32 apic_get_tmcct(struct kvm_lapic *apic)
>                               apic->divide_count));
>   }
>
> +static void __report_lint0_access(struct kvm_lapic *apic, u32 value)
> +{
> +       struct kvm_vcpu *vcpu =3D apic->vcpu;
> +       struct kvm_run *run =3D vcpu->run;
> +
> +       kvm_make_request(KVM_REQ_REPORT_LINT0_ACCESS, vcpu);
> +       run->lint0_access.value =3D value;
> +}
> +
> +static inline void report_lint0_access(struct kvm_lapic *apic, u32 value=
)
> +{
> +       if (apic->vcpu->arch.lint0_access_reporting)
> +               __report_lint0_access(apic, value);
> +}
> +
>   static void __report_tpr_access(struct kvm_lapic *apic, bool write)
>   {
>         struct kvm_vcpu *vcpu =3D apic->vcpu;
> @@ -2312,8 +2327,10 @@ static int kvm_lapic_reg_write(struct kvm_lapic *a=
pic, u32 reg, u32 val)
>                         int i;
>
>                         for (i =3D 0; i < apic->nr_lvt_entries; i++) {
> -                               kvm_lapic_set_reg(apic, APIC_LVTx(i),
> -                                       kvm_lapic_get_reg(apic, APIC_LVTx=
(i)) | APIC_LVT_MASKED);
> +                               u32 old =3D kvm_lapic_get_reg(apic, APIC_=
LVTx(i));
> +                               kvm_lapic_set_reg(apic, APIC_LVTx(i), old=
 | APIC_LVT_MASKED);
> +                               if (i =3D=3D 0 && !(old & APIC_LVT_MASKED=
))
> +                                       report_lint0_access(apic, old | A=
PIC_LVT_MASKED);
>                         }
>                         apic_update_lvtt(apic);
>                         atomic_set(&apic->lapic_timer.pending, 0);
> @@ -2352,6 +2369,8 @@ static int kvm_lapic_reg_write(struct kvm_lapic *ap=
ic, u32 reg, u32 val)
>                 if (!kvm_apic_sw_enabled(apic))
>                         val |=3D APIC_LVT_MASKED;
>                 val &=3D apic_lvt_mask[index];
> +               if (index =3D=3D 0 && val !=3D kvm_lapic_get_reg(apic, re=
g))
> +                       report_lint0_access(apic, val);
>                 kvm_lapic_set_reg(apic, reg, val);
>                 break;
>         }
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d0d3dc3b7ef6..2b039b372c3f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10879,6 +10879,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcp=
u)
>                         kvm_vcpu_flush_tlb_guest(vcpu);
>   #endif
>
> +               if (kvm_check_request(KVM_REQ_REPORT_LINT0_ACCESS, vcpu))=
 {
> +                       vcpu->run->exit_reason =3D KVM_EXIT_LINT0_ACCESS;
> +                       r =3D 0;
> +                       goto out;
> +               }
>                 if (kvm_check_request(KVM_REQ_REPORT_TPR_ACCESS, vcpu)) {
>                         vcpu->run->exit_reason =3D KVM_EXIT_TPR_ACCESS;
>                         r =3D 0;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 637efc055145..ec97727f9de4 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -178,6 +178,7 @@ struct kvm_xen_exit {
>   #define KVM_EXIT_NOTIFY           37
>   #define KVM_EXIT_LOONGARCH_IOCSR  38
>   #define KVM_EXIT_MEMORY_FAULT     39
> +#define KVM_EXIT_LINT0_ACCESS     40
>
>   /* For KVM_EXIT_INTERNAL_ERROR */
>   /* Emulate instruction failed. */
> @@ -283,6 +284,10 @@ struct kvm_run {
>                                 __u64 flags;
>                         };
>                 } hypercall;
> +               /* KVM_EXIT_LINT0_ACCESS */
> +               struct {
> +                       __u32 value;
> +               } lint0_access;
>                 /* KVM_EXIT_TPR_ACCESS */
>                 struct {
>                         __u64 rip;
>
>
> For LINT1, it should be less performance critical; if it's possible
> to just go through all vCPUs, and do KVM_GET_LAPIC to check who you
> should send a KVM_NMI to, then I'd do that.  I'd also accept a patch
> that adds a VM-wide KVM_NMI ioctl that does the same in the hypervisor
> if it's useful for you.

Thanks for the patch - I'll get it a try but it might not be right away.

> And since I've been proven wrong already, what do you need INIT/SIPI for?

I don't think this one is as critical.  I believe the reason it was
added was so that we can synchronize startup of the APs with execution
of the BSP for guests that do not do a good job of that (Windows).

Doug

> Paolo
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

