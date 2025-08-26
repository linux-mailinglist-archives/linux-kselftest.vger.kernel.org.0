Return-Path: <linux-kselftest+bounces-39957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13223B36F28
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26CD7B13B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD1277CA6;
	Tue, 26 Aug 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urGAJ8vo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352AE30FC19
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224033; cv=none; b=ZdnWMYOQJt/uP8zpxKcy6HmogD4gVyc8HxQVVj9QpjTyTG1C+W1rq6nY+cP74jSIkJB0I3oeWQGWSuzTUB0WuqDumKKB5r3cwptVxgl8P29EqGriybh2PPOLo/qXxYovNckej5V2v0BTc5uCeS8u+EHyxQgR6QH+U8ikqPuK74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224033; c=relaxed/simple;
	bh=5n9iNVjakjoJqt2gYftBUpMg4XD/CmiSEh3983ISjDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl5y7fzHRCSzm0vMaxwlFvomKl2YwljpulqCRi+kZexAtPRpI2rFHgtwna302tvOJjI1QzS3w5qnwII1zdCMKrKBibm+cLVt8gekMhxPgseMjjHyU5jW7jkyNthxvbs/HjsMxA8+x36V2ex5WuFycPBdEZwU+Z036tYvEAJCI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urGAJ8vo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b2dc20aebbso524361cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756224031; x=1756828831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wtM7DRL0HexzXSRpXdyswW9NJxzA03GjvZK/WV7kco=;
        b=urGAJ8voOcjB+V8Jb738eDsl/Z9l6DQEyyL6hPE57Qi3ufhpDDvv405XoFU7B/td0U
         bXUr5Vlx1z2diORjYpNpc+hGwwXdIQNaBUZbd/ackI/V2vW24rSLuBr7khTFVRBMrTJm
         SwKrtrNkgXV1FBNsU+Mv1LTGTBAT/xhM3KBRxyAI++8guxSSkHJLd7IyqY0FJrvnE4OK
         EOBxP3nUWrpzaustySo9ANY382x5v7xBAfIcu4+u0jFI5OW95bPQPCr8ixy8FFZCZGjl
         G4mjRK7o65NWJA+8MZKj8qP39Rjo9SMZzU+xLh0WenA3LD8cSkd5zZ5apZ+i2rcB2SOf
         6PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224031; x=1756828831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wtM7DRL0HexzXSRpXdyswW9NJxzA03GjvZK/WV7kco=;
        b=opRQbWG5c5Idm0M+6IdBdRgQRLB3/VzuOxj9w+6B5u7nsGYXWd8XiNJXMgbWJ8bfCZ
         PjsHr4IBhjyIfAxkOuGVLzwJCFb31k/JbNt7IudzP8i57QGfPuREG4eeSpg3G3/JFzY8
         ugeLbvd0tuG5+n6fQ53LsO4gT8qvudg7LsIdOVmjaKsohDK2M8MOspueBxdgR59frHNe
         ObKA772z9yiSwzcddYZBXqjD/hS/BXoJbBts6RKhVOBgu8NWiCsiOt8bTHi8KQANBFTu
         lDt2i3e3X3IAKgQx3ryTeUR7k2WTHWGFO/MSZNXBEp921mp7VByRLP1xNQUjxzWHyDxr
         u9hQ==
X-Gm-Message-State: AOJu0YwExAD4HJH0nxZPhXqw/9I2mqRRFLQKbGDvz5otu0wNL/+o4tx0
	CSQ3pgja6hZ4PR4+8xmwLJpGYg6zMqD9CqfqdRwTSR4tgZR6IRried2uk6tJ3HRSmXcWTCKd5El
	SY5eufyKL85d95Q3uTrX5uzaavTr4RjqxlpJIn01l
X-Gm-Gg: ASbGncsiKN5cg8Rebw0hJ3PU7BqYezTfIQmPaGfghDFS5iJu3TjZL+CZ+d6BRF91b8d
	LbBL55GBh/fDFnokcNXPPccV2ke+UxicqDZ0KTOcDaEWGBP4gc265dPaTJQPflWcsuEt2GSTuAh
	ZRwHf8DDVdclutGedJ+3I5AA0Nw/mKSUBKJcp9MxS8/lMBOng2xnHyFnjRy7wPGvtpCts7OABeM
	KqrgCC5DgUw83WfVKlm7MKhiqmEaw/4Fat5otAxUQ+XaRB+H20Poh9T
X-Google-Smtp-Source: AGHT+IFeiDU2Yx1zX1pIKcd7rsJ5GF5GQL74GdLUz16527dkwe2MqDmHOj4uVoOAk2edU90WczcIgsoTzbpig7ivJ6g=
X-Received: by 2002:a05:622a:311:b0:4a7:1743:106b with SMTP id
 d75a77b69052e-4b2e1c96dbcmr6023551cf.6.1756224030274; Tue, 26 Aug 2025
 09:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-5-sagis@google.com>
 <9ef0d1f4-3257-4821-8241-aedae0957c6a@linux.intel.com>
In-Reply-To: <9ef0d1f4-3257-4821-8241-aedae0957c6a@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 26 Aug 2025 11:00:19 -0500
X-Gm-Features: Ac12FXwQGfxwaB2ml-48qLvGsftNie172WLdVXPodk6Eig8wP3GzganRX92BXkY
Message-ID: <CAAhR5DG8EFds6GrMkv3YL0M8J1BuyzoXF9ZZn1YHFJ8arhyYLA@mail.gmail.com>
Subject: Re: [PATCH v9 04/19] KVM: selftests: Expose function to allocate
 guest vCPU stack
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:39=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.c=
om> wrote:
>
>
>
> On 8/21/2025 12:28 PM, Sagi Shahar wrote:
> > TDX guests' registers cannot be initialized directly using
> > vcpu_regs_set(), hence the stack pointer needs to be initialized by
> > the guest itself, running boot code beginning at the reset vector.
> >
> > Expose the function to allocate the guest stack so that TDX
> > initialization code can allocate it itself and skip the allocation in
> > vm_arch_vcpu_add() in that case.
> >
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/include/x86/processor.h       |  2 ++
> >   tools/testing/selftests/kvm/lib/x86/processor.c | 17 ++++++++++++----=
-
> >   2 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tool=
s/testing/selftests/kvm/include/x86/processor.h
> > index 5c16507f9b2d..8fcc5118683e 100644
> > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > @@ -1111,6 +1111,8 @@ static inline void vcpu_clear_cpuid_feature(struc=
t kvm_vcpu *vcpu,
> >       vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
> >   }
> >
> > +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
> > +
> >   uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
> >   int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t=
 msr_value);
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/te=
sting/selftests/kvm/lib/x86/processor.c
> > index b2a4b11ac8c0..1eae92957456 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -687,12 +687,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vc=
pu, void *guest_code)
> >       vcpu_regs_set(vcpu, &regs);
> >   }
> >
> > -struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> > +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
> >   {
> > -     struct kvm_mp_state mp_state;
> > -     struct kvm_regs regs;
> >       vm_vaddr_t stack_vaddr;
> > -     struct kvm_vcpu *vcpu;
> >
> >       stack_vaddr =3D __vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpages=
ize(),
> >                                      DEFAULT_GUEST_STACK_VADDR_MIN,
> > @@ -713,6 +710,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *v=
m, uint32_t vcpu_id)
> >                   "__vm_vaddr_alloc() did not provide a page-aligned ad=
dress");
> >       stack_vaddr -=3D 8;
> >
> > +     return stack_vaddr;
> > +}
> > +
> > +struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> > +{
> > +     struct kvm_mp_state mp_state;
> > +     struct kvm_regs regs;
> > +     struct kvm_vcpu *vcpu;
> > +
> >       vcpu =3D __vm_vcpu_add(vm, vcpu_id);
> >       vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> >       vcpu_init_sregs(vm, vcpu);
> > @@ -721,7 +727,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm=
, uint32_t vcpu_id)
> >       /* Setup guest general purpose registers */
> >       vcpu_regs_get(vcpu, &regs);
> >       regs.rflags =3D regs.rflags | 0x2;
> > -     regs.rsp =3D stack_vaddr;
> > +     if (vm->type !=3D KVM_X86_TDX_VM)
> > +             regs.rsp =3D kvm_allocate_vcpu_stack(vm);
>
> I am wondering if this could be more generic.
> I.e, make vcpu_regs_get() return the error code.
> If vcpu_regs_get() failed (for TDX, since it's guest state is protected, =
the
> ioctl will return -EINVAL), the vcpu_regs_set(), including the allocation=
 for
> the vcpu stack, could be skipped.
>

I'm dropping this check and only keeping the check from "KVM:
selftests: Hook TDX support to vm and vcpu creation" which looks like
this:

if (is_tdx_vm(vm)) {
        vm_tdx_vcpu_add(vm, vcpu);
} else {
        vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());

        vcpu_init_sregs(vm, vcpu);
        vcpu_init_xcrs(vm, vcpu);

        /* Setup guest general purpose registers */
        vcpu_regs_get(vcpu, &regs);
        regs.rflags =3D regs.rflags | 0x2;
        regs.rsp =3D kvm_allocate_vcpu_stack(vm);
        vcpu_regs_set(vcpu, &regs);
}

Since there are other differences specific to TDX I think this is
cleaner than trying to handle kvm_allocate_vcpu_stack() individually.

> >       vcpu_regs_set(vcpu, &regs);
> >
> >       /* Setup the MP state */
>

