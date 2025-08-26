Return-Path: <linux-kselftest+bounces-40002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D2EB373D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 22:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEA27C4965
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAE334F463;
	Tue, 26 Aug 2025 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6kmtMzm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191234A30E
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240182; cv=none; b=SFqoQDb3x6BmYiL2gbRNcE8+p7ALFWd8QBd5BQo6mV4v+CCRD4QIZ6wkhQKrYGszghAo/cbfWMXpzXhotrh/vF3QIlOPzwGJxfqDnm6/jEfBqCn+DVIzi6yR1k2zYzsJTax4EAdaTF8xZGhyn03WuF+ZXiCgtBdXJ2NR75O1Yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240182; c=relaxed/simple;
	bh=H0meGH/ZSIq+QjBVPczsfuW+8V+2uGvtAWeNY4II8fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDmE1ZhotVZuOCYJM3vaK6UGrjjyPBuW61h5LOa2EJiA+JyROhGjdUW9X5O5V8SsKN6m3RtphYmjng6UOnVmxER5dMI3SZ8OdoA1E6pUqw+6Hp0j2awh88sEKYmgEdciC+XKqilb9HCHY/R5axPqY/StBXIiNcmxfLwanbBp8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6kmtMzm; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b2dc20aebbso124201cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756240180; x=1756844980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGklcsckZnycLXQ8v59Q73d4XcLOGz3ZB2f2pW6BmqM=;
        b=R6kmtMzm/To+8rTSoaM0n9UE2N3mMt5aWWYQ9o5wNf64KlXAQqN/D13kGylfj9D1xT
         pyBmXhC9F8b6J12ppZ2nU+o+QWEeExOlZGmuy9G3swkQQkmzp/4KOZwCKRIUtYazLdz+
         L8WAlKmPMeGiMvSJ9vttosXY+u4uGM9Kuxp3juF0nr0u8jdnV07/i2HsLCxFH402M2Q6
         pooBEFTyt++ME0Jpj2FdyN1xG+rh5SgAa0Kqd+eE2PqTC1u7v5UI2ONy8ySW3OnMc3cU
         t4+bBawYlNTIj/9/z4vL9xGSAKSzXwchhwGB4kW9fJxt+V7/BlqbPzlyt4Eqh6M5/EF3
         oQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240180; x=1756844980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGklcsckZnycLXQ8v59Q73d4XcLOGz3ZB2f2pW6BmqM=;
        b=edsOUSVsBAZas5dxIh2CCRHy5tESX6xck3jVeTKLb5EBsYMgD8Ea30CgCH6vi9Lb8a
         I3jIbgN5gJSuO8Ft05O3yaJYyvsbyWYFUDxmlDZCXP9Q9BgWOycsu6GDtYExwZmVTQlW
         aRBq6uxvDIF8QJQ0pycR6+NdrvsP4nrXGsuCGy53u3U8sIoQk1UHio9/6WiTOXUClioG
         SZFY9ekFgYNiKnUKnh2iNN5/hX9I4//NUolEIUuaHsDtQylKHRTUmxBcXawcpbrl1lPN
         mPa/kcjM/3zdNLX+nDw4a57xCq/Kdka8TO7gR92jMfetm25+Eus44AQ+np/8Uqo216cC
         Wixw==
X-Forwarded-Encrypted: i=1; AJvYcCVB79LW5aiXw47Iw/hJezvATYO/26cm7CMVV66IOGVM6e+dp+n4Ydr0RuKcjARgNTHQD62HqFufQ+d5deltloQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Kr3EjghOVbaqt9dh9u+BTQlRV8IDbYKyyeyVTP40uuVCh1p6
	cMst4q8eJ6XI0lSPABZSSh1tzVjouATXv2ySLgpU8xCJSBvvIBd3bfStzJovi9dyUrKnHUD9jFe
	kDUw9S0peJDQZ2nPH40BsCZ3MjG+HZFEwW/09kGpX
X-Gm-Gg: ASbGnctmR0vOuWk9JWGJobI8tbBRUu8wdXe7l/uA6Aa5zcSCIMBVoydEWvhRh7aNMR+
	7JbZ2B3O3T7qjg6g/wqDho0pDTI8EZALy+nLi8jjQd5lqlUsBJElNXsa0BInAWzAqmQ/HaXUfam
	f7mIpKyqr17iWsoSftJSQ+VdZeOLlhrjApLyqB8drjLDdB1na6kcwPnJjrGH1JdeAoyNeyMZVn1
	HKI62+lBYrnBBs/CoUio3IsMc2z+DxJHUuZvUxR2fTeSZ1td5FGjXKoPA==
X-Google-Smtp-Source: AGHT+IEHOQk1sWwHD1cKD8+QqW+nxWvNVN9mCzhggckX5n0gDLLPC/qrllBed/EbQv8l6hMELcCbF6ojKTW9CqC7xro=
X-Received: by 2002:a05:622a:4d97:b0:4b2:ecb6:e6dd with SMTP id
 d75a77b69052e-4b2ecb6edecmr2721281cf.1.1756240179507; Tue, 26 Aug 2025
 13:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-16-sagis@google.com>
 <aK3vZ5HuKKeFuuM4@google.com> <68ae1604a387c_300e8f2947e@iweiny-mobl.notmuch>
In-Reply-To: <68ae1604a387c_300e8f2947e@iweiny-mobl.notmuch>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 26 Aug 2025 15:29:28 -0500
X-Gm-Features: Ac12FXz22mzFl3kMkPztCJvbyJO0AnvzFVkaIOQ3_J07KFwMWuTK-i8q7O91CqI
Message-ID: <CAAhR5DHPMPOb2XCJodyNMf2RTQfTZpAaCGMg6WeWxSWPLtkO4Q@mail.gmail.com>
Subject: Re: [PATCH v9 15/19] KVM: selftests: Hook TDX support to vm and vcpu creation
To: Ira Weiny <ira.weiny@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:14=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Sean Christopherson wrote:
> > On Wed, Aug 20, 2025, Sagi Shahar wrote:
> > > TDX require special handling for VM and VCPU initialization for vario=
us
> > > reasons:
> > > - Special ioctlss for creating VM and VCPU.
> > > - TDX registers are inaccessible to KVM.
> > > - TDX require special boot code trampoline for loading parameters.
> > > - TDX only supports KVM_CAP_SPLIT_IRQCHIP.
> >
> > Please split this up and elaborate at least a little bit on why each fl=
ow needs
> > special handling for TDX.  Even for someone like me who is fairly famil=
iar with
> > TDX, there's too much "Trust me bro" and not enough explanation of why =
selftests
> > really need all of these special paths for TDX.
> >
> > At least four patches, one for each of your bullet points.  Probably 5 =
or 6, as
> > I think the CPUID handling warrants its own patch.
> >
> > > Hook this special handling into __vm_create() and vm_arch_vcpu_add()
> > > using the utility functions added in previous patches.
> > >
> > > Signed-off-by: Sagi Shahar <sagis@google.com>
> > > ---
> > >  tools/testing/selftests/kvm/lib/kvm_util.c    | 24 ++++++++-
> > >  .../testing/selftests/kvm/lib/x86/processor.c | 49 ++++++++++++++---=
--
> > >  2 files changed, 61 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testi=
ng/selftests/kvm/lib/kvm_util.c
> > > index b4c8702ba4bd..d9f0ff97770d 100644
> > > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > > @@ -4,6 +4,7 @@
> > >   *
> > >   * Copyright (C) 2018, Google LLC.
> > >   */
> > > +#include "tdx/tdx_util.h"
> > >  #include "test_util.h"
> > >  #include "kvm_util.h"
> > >  #include "processor.h"
> > > @@ -465,7 +466,7 @@ void kvm_set_files_rlimit(uint32_t nr_vcpus)
> > >  static bool is_guest_memfd_required(struct vm_shape shape)
> > >  {
> > >  #ifdef __x86_64__
> > > -   return shape.type =3D=3D KVM_X86_SNP_VM;
> > > +   return (shape.type =3D=3D KVM_X86_SNP_VM || shape.type =3D=3D KVM=
_X86_TDX_VM);
> > >  #else
> > >     return false;
> > >  #endif
> > > @@ -499,6 +500,12 @@ struct kvm_vm *__vm_create(struct vm_shape shape=
, uint32_t nr_runnable_vcpus,
> > >     for (i =3D 0; i < NR_MEM_REGIONS; i++)
> > >             vm->memslots[i] =3D 0;
> > >
> > > +   if (is_tdx_vm(vm)) {
> > > +           /* Setup additional mem regions for TDX. */
> > > +           vm_tdx_setup_boot_code_region(vm);
> > > +           vm_tdx_setup_boot_parameters_region(vm, nr_runnable_vcpus=
);
> > > +   }
> > > +
> > >     kvm_vm_elf_load(vm, program_invocation_name);
> > >
> > >     /*
> > > @@ -1728,11 +1735,26 @@ void *addr_gpa2alias(struct kvm_vm *vm, vm_pa=
ddr_t gpa)
> > >     return (void *) ((uintptr_t) region->host_alias + offset);
> > >  }
> > >
> > > +static bool is_split_irqchip_required(struct kvm_vm *vm)
> > > +{
> > > +#ifdef __x86_64__
> > > +   return is_tdx_vm(vm);
> > > +#else
> > > +   return false;
> > > +#endif
> > > +}
> > > +
> > >  /* Create an interrupt controller chip for the specified VM. */
> > >  void vm_create_irqchip(struct kvm_vm *vm)
> > >  {
> > >     int r;
> > >
> > > +   if (is_split_irqchip_required(vm)) {
> > > +           vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
> > > +           vm->has_irqchip =3D true;
> > > +           return;
> > > +   }
> >
> > Ugh.  IMO, this is a KVM bug.  Allowing KVM_CREATE_IRQCHIP for a TDX VM=
 is simply
> > wrong.  It _can't_ work.  Waiting until KVM_CREATE_VCPU to fail setup i=
s terrible
> > ABI.
> >
> > If we stretch the meaning of ENOTTY a bit and return that when trying t=
o create
> > a fully in-kernel IRQCHIP for a TDX VM, then the selftests code Just Wo=
rks thanks
> > to the code below, which handles the scenario where KVM was be built wi=
thout
>          ^^^^^^^^^^
>
> I'm not following.  Was there supposed to be a patch attached?
>

I think Sean refers to the original implementation which was out of
the scope for the git diff so it was left out of the patch:

/*
 * Allocate a fully in-kernel IRQ chip by default, but fall back to a
 * split model (x86 only) if that fails (KVM x86 allows compiling out
 * support for KVM_CREATE_IRQCHIP).
 */
r =3D __vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL);
if (r && errno =3D=3D ENOTTY && kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP))
        vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
else
        TEST_ASSERT_VM_VCPU_IOCTL(!r, KVM_CREATE_IRQCHIP, r, vm);

/*
 * Allocate a fully in-kernel IRQ chip by default, but fall back to a
 * split model (x86 only) if that fails (KVM x86 allows compiling out
 * support for KVM_CREATE_IRQCHIP).
 */
r =3D __vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL);
if (r && errno =3D=3D ENOTTY && kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP))
vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
else
TEST_ASSERT_VM_VCPU_IOCTL(!r, KVM_CREATE_IRQCHIP, r, vm);
/*
* Allocate a fully in-kernel IRQ chip by default, but fall back to a
* split model (x86 only) if that fails (KVM x86 allows compiling out
* support for KVM_CREATE_IRQCHIP).
*/
r =3D __vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL);
if (r && errno =3D=3D ENOTTY && kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP))
vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
else
TEST_ASSERT_VM_VCPU_IOCTL(!r, KVM_CREATE_IRQCHIP, r, vm);

> Ira
>
> > support for in-kernel I/O APIC (and PIC and PIT).
>
>

