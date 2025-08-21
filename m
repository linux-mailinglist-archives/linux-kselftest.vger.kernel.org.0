Return-Path: <linux-kselftest+bounces-39611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76FB3092C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 00:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC607A65D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247342EA75F;
	Thu, 21 Aug 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcbWDMtK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D221765B
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815111; cv=none; b=fqyAjq08gTUcmp0bboOgAwylXZuKf8eVZYVAHRAP2C06EDw3K0Y1eOjEklr2ouk/V2/2jmPrj5iQ7U9gy3m+2ILyWApE3PeHK1RxIuslpQySEsxUZ0KjKyZJCxGsKksI7lEQ2aqsW3n3DRLMj3/tdL/pVCXx1bfXxvgGTjZ1hI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815111; c=relaxed/simple;
	bh=2QZ6zrGsjLlalDpBAkIdTyTLIFs2ej9WDspfuVcDGhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTFHS05YQzxXQFv715r2Uz6B3FYY6DWGjv8R+ZJQMDGySLBQ1ymDJatrFWWRQ1NFXruPs2H44KuSl8SAHLJych8mSGZt+R+TXN/pkK63xiMjJ01aDu8Z1TXRNHEigbCqDRpYvT4EE1cZKD2k0jLTDe7LFCp9lPVn849YJNhdhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcbWDMtK; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b12b123e48so114681cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755815107; x=1756419907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyJPOCeYTYQJhT7dlpclxs9aP7FdE4Az1oLgPLGKt4w=;
        b=hcbWDMtKcwCiAK2vEo72D+nw0t8h/2iq/28WxrJ6H/8jNDB3zkfjgPO+KUqd8SbI5Q
         I+l1OUpFc2TEU2nXcAb8Z2dtu1lBF9ocBZB5SVE2fabENmbtnZ2Pp8btxI2kE6JyiPZn
         SbahA16owkCCovCnLDeqpV7AZiF3vy9GUZf0D3zGo5B8sEtCzsA6WHO3GsNxTb8j5QRR
         vhfs8wcsqwrC93fpdgoShnxd2ORXBXD78EHVySSMOg4LpuvUi5R+pK0lTOkFuIEnCoBW
         lpch+TiRQm1U2ZO4WbDG3vWOKv7tP46nYmn4wMwDB9hmAmK7QR6Hi6U7EtDTvA3vmiS8
         0n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755815107; x=1756419907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyJPOCeYTYQJhT7dlpclxs9aP7FdE4Az1oLgPLGKt4w=;
        b=D8wmRcZFaFAX7CYVSIDAzfmj80Z2cr5lwtVFHqyC/tsxHlOTxmrvddzZewobKDYuE5
         Spa9pX9LjAOZPFeO98XpKS7AECCyAiuNHzRAmcQiROPTkFJkV2n7MyVSFqk4AEFg5iDh
         ursmwkIrtyO51O0O33pjHy3RgnP17XBtiuaH/k/lIELio9QgaZAeIKqcQllNaONcI1TZ
         wvw6M5YWOBYGnBAWqpjPfBMBL0mYnvYs/cQ4MZ9ljJmeGQSUpvPKvVCkok8GxFcnfXe+
         o4XnatA/JscsV8TQul71b2HrsgTIEOi2+jw1VSrUMuftEsB+uZ3I+NKCYOBXczpFhAtJ
         XNHQ==
X-Gm-Message-State: AOJu0YwHjjIbwtE8IKPVRgZyxm/FAAnzCxY2lr3PrOwTQEGwUX4tr2DV
	WS23XiQ+oazqzJAZd8w3UJCUzvrAU9+vSYLtCN9E7qLDydb+/Z0LfM05qkEAC3pjiNix0h9W7pU
	9qLXp4E9dNWCK7ypwcZ+kCdc0XZTZ0UaCNj6rLXoT
X-Gm-Gg: ASbGncsu2s0zcwUTL8pTLexc3ICw37jct+TRVqRhigJRE5pA1N/nrd74XZJqcF+HhVu
	cJ+pbE80I5cpt5Bk6/M24EMt285kaPZtJydexO7t5gZCopRVuDbe6dxeeoAqRVB0D1RUp3/L+xw
	27fmCwMD8genlRNgMbXxS8iCKuFFOqThDoyrnI+5SHiLNwYk0gczTG28MOAzqITn73nFVPM8puA
	wxqE46vPHU4Sfw/GpVNrcJti++2FSR4sByX6GFkVlWHIOk=
X-Google-Smtp-Source: AGHT+IEcy4+hFqm23pXRb+RvKPGCQLtlYExIO1aHI4T543x2s/ScIKdzGvuD9BdYomQcE7NRMDmcT74jIYHmn9egUfU=
X-Received: by 2002:ac8:7e93:0:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4b2aadb0202mr1614191cf.6.1755815107099; Thu, 21 Aug 2025
 15:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-5-sagis@google.com>
 <68a797031c5a6_2be23a29461@iweiny-mobl.notmuch>
In-Reply-To: <68a797031c5a6_2be23a29461@iweiny-mobl.notmuch>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 21 Aug 2025 17:24:56 -0500
X-Gm-Features: Ac12FXz2rEi3VHKQY81VoTu_wRJptAg-XMmMaS1bVIFyacnt7S54GNWkrdLENto
Message-ID: <CAAhR5DG6EDP=25-SrmBnbKYbrwH=bCP2f6OPO8KE=oXQxVBXbQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/19] KVM: selftests: Expose function to allocate
 guest vCPU stack
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 4:58=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Sagi Shahar wrote:
>
> [snip]
>
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/te=
sting/selftests/kvm/lib/x86/processor.c
> > index b2a4b11ac8c0..1eae92957456 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -687,12 +687,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vc=
pu, void *guest_code)
> >       vcpu_regs_set(vcpu, &regs);
> >  }
> >
> > -struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> > +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
> >  {
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
> At this point in the series vm->type can't be KVM_X86_TDX_VM correct?
>
> So that makes this safe during bisect?
>

I double checked and no one is creating VMs with KVM_X86_TDX_VM. The
first test that sets KVM_X86_TDX_VM is the last patch in the series.

> Ira
>
> >       vcpu_regs_set(vcpu, &regs);
> >
> >       /* Setup the MP state */
> > --
> > 2.51.0.rc1.193.gad69d77794-goog
> >
>
>

