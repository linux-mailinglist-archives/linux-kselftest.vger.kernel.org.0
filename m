Return-Path: <linux-kselftest+bounces-14095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B380493A7DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 21:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC8E284462
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2FD146A9A;
	Tue, 23 Jul 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyAvZC5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06B1428F9
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764552; cv=none; b=lv9bxuvEXcLel5za1ZB2vWzOSmP4M14et4DoHHyOsfJr3Bv1kNBEcI3icRTxDtPjERsAGyqxfszcsL6hEnhX1l8yzNEsGXT8EPUeVWBzP1/z+K0PFPjbZnE6dA5h81CtbgjG6zL7qEiwijbCVJKpGAj5FHymTrvhty3B6tpJc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764552; c=relaxed/simple;
	bh=N/VSqw2RCaG6rK52saYhgy4CiAO1VKN8Pn9v0JbVZx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVvkbMQgrCc0zqDZYc00qQpL/ERIO5GvglkW4Ezdr2e0+3TlvHQk0mUu8zZ+/m9+WTPbz8MAZzYs5OvIsIsuoIj2LRn0HADYIR+5/Dtdl9m4kHQL/LbYYyr9tOfLxRurcxXvDUXKfnBAHwNt1s6uZUxZ5LrZkLBAjjScfS1WXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jyAvZC5I; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso3304114276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721764549; x=1722369349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE6e5fzPeKFIlBMmG5gJlxWybIkbfxBFCodCMXGx1jQ=;
        b=jyAvZC5II/8jS5GrwWV/OMSe6jDIqq99mrfbXhHfmnhuc+NUKYqEIa6+x+IcOPTGvX
         9DCi6jx3ori/nBWph05tJtqg/VZHFtZPSLylopBtwbGkQveZOp1ASBnxLOOqto29/g3/
         f57ukFazOQ3NtTl8JLU71AAsQG3j2nGPV2aqTpHUWmeut28MiSi5cRY8jIBv/twxP0jV
         xmq/jvxlNqwI4oWn6u9ESXcKc76TQJFg/ALVisxarLo/uiVPDUQpuY+6H4MQWAU6cCm6
         9+QRTy7CWTFKj6Q9a0rsaL4YPwuzTfwOB8Hqh8WK/j7LE4Jx6FwNmcCDZeCgfGol3jCS
         psCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721764549; x=1722369349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE6e5fzPeKFIlBMmG5gJlxWybIkbfxBFCodCMXGx1jQ=;
        b=SFtZLb13vQcejcTnyETqI5c/hDWyuEjwVcsdNmVElcgMFXMW6OavEGd9zx8XS4Q8EG
         6CxQYJWh4nPhsZiiOuOML9FmNxRWxAVIwVwEw2vN1lwnZPNenCP5OcvW0LvDHY8kNT+b
         X+g10tQIYxEJWusHBIk6JyB/FnZcNoLN03DI9NzbOYCiaKmgPFhcyFQ5pDLDAOOD7oH5
         n9U2AqWvdO+mMyL5RDU+4gpPBtljAFChxtFhB8Xx7CgPU3kQm0DVcjLKK3DDaULzpSg9
         idb72jcQJ7UrzDhLqeV1O1H18NMhH5tEaC8AeQuHp9iPcxyWFXzzVbCqa5gxjS4vRw6j
         UlmA==
X-Gm-Message-State: AOJu0Yybz+UiuHf+uO5VPubXtdwrkOI+OFvqbMwXWuC6RHhMz4wan3AA
	NsglVk/1IBy/q73QaYuTAt14MDGIolrV0Eew9Wvy2jP1SOach1qbNdGiwvD0FhYMxLlLPKwt8uB
	Kn6KKP/8zZYpvSJ1+42Cjdsx0JvJES76OFvNV
X-Google-Smtp-Source: AGHT+IFVIQx8k5pKeQbxna0tg4qcoy/15wSfpoaLxbaPj5khP8+jMjSrXVK0+kifV00saP01V2Gg6z43TEQy033MIoY=
X-Received: by 2002:a05:6902:2d05:b0:e03:a70d:c12e with SMTP id
 3f1490d57ef6-e087017fdd3mr13368632276.15.1721764549380; Tue, 23 Jul 2024
 12:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <20231212204647.2170650-2-sagis@google.com>
 <516247d2-7ba8-4b3e-8325-8c6dd89b929e@linux.intel.com>
In-Reply-To: <516247d2-7ba8-4b3e-8325-8c6dd89b929e@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 23 Jul 2024 14:55:37 -0500
Message-ID: <CAAhR5DH9UJ+fFbePPbKsdUiyk63dhE6-f-uazu-s60dPe_Rfrg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 01/29] KVM: selftests: Add function to allow
 one-to-one GVA to GPA mappings
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Erdem Aktas <erdemaktas@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Ryan Afranji <afranji@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>, 
	Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 7:43=E2=80=AFPM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
>
>
> On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > One-to-one GVA to GPA mappings can be used in the guest to set up boot
> > sequences during which paging is enabled, hence requiring a transition
> > from using physical to virtual addresses in consecutive instructions.
> >
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ryan Afranji <afranji@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/include/kvm_util_base.h     |  2 +
> >   tools/testing/selftests/kvm/lib/kvm_util.c    | 63 ++++++++++++++++--=
-
> >   2 files changed, 55 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tool=
s/testing/selftests/kvm/include/kvm_util_base.h
> > index 1426e88ebdc7..c2e5c5f25dfc 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > @@ -564,6 +564,8 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t=
 sz, vm_vaddr_t vaddr_min);
> >   vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t =
vaddr_min,
> >                           enum kvm_mem_region_type type);
> >   vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vad=
dr_t vaddr_min);
> > +vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
> > +                            vm_vaddr_t vaddr_min, uint32_t data_memslo=
t);
> >   vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
> >   vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
> >                                enum kvm_mem_region_type type);
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing=
/selftests/kvm/lib/kvm_util.c
> > index febc63d7a46b..4f1ae0f1eef0 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -1388,17 +1388,37 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *v=
m, size_t sz,
> >       return pgidx_start * vm->page_size;
> >   }
> >
> > +/*
> > + * VM Virtual Address Allocate Shared/Encrypted
> > + *
> > + * Input Args:
> > + *   vm - Virtual Machine
> > + *   sz - Size in bytes
> > + *   vaddr_min - Minimum starting virtual address
> > + *   paddr_min - Minimum starting physical address
> > + *   data_memslot - memslot number to allocate in
> > + *   encrypt - Whether the region should be handled as encrypted
> > + *
> > + * Output Args: None
> > + *
> > + * Return:
> > + *   Starting guest virtual address
> > + *
> > + * Allocates at least sz bytes within the virtual address space of the=
 vm
> > + * given by vm.  The allocated bytes are mapped to a virtual address >=
=3D
> > + * the address given by vaddr_min.  Note that each allocation uses a
> > + * a unique set of pages, with the minimum real allocation being at le=
ast
> > + * a page.
> > + */
> >   static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> > -                                  vm_vaddr_t vaddr_min,
> > -                                  enum kvm_mem_region_type type,
> > -                                  bool encrypt)
> > +                                  vm_vaddr_t vaddr_min, vm_paddr_t pad=
dr_min,
> > +                                  uint32_t data_memslot, bool encrypt)
> >   {
> >       uint64_t pages =3D (sz >> vm->page_shift) + ((sz % vm->page_size)=
 !=3D 0);
> >
> >       virt_pgd_alloc(vm);
> > -     vm_paddr_t paddr =3D _vm_phy_pages_alloc(vm, pages,
> > -                                           KVM_UTIL_MIN_PFN * vm->page=
_size,
> > -                                           vm->memslots[type], encrypt=
);
> > +     vm_paddr_t paddr =3D _vm_phy_pages_alloc(vm, pages, paddr_min,
> > +                                            data_memslot, encrypt);
> >
> >       /*
> >        * Find an unused range of virtual page addresses of at least
> > @@ -1408,8 +1428,7 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_v=
m *vm, size_t sz,
> >
> >       /* Map the virtual pages. */
> >       for (vm_vaddr_t vaddr =3D vaddr_start; pages > 0;
> > -             pages--, vaddr +=3D vm->page_size, paddr +=3D vm->page_si=
ze) {
> > -
> > +          pages--, vaddr +=3D vm->page_size, paddr +=3D vm->page_size)=
 {
> >               virt_pg_map(vm, vaddr, paddr);
> >
> >               sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift)=
;
> > @@ -1421,12 +1440,16 @@ static vm_vaddr_t ____vm_vaddr_alloc(struct kvm=
_vm *vm, size_t sz,
> >   vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t =
vaddr_min,
> >                           enum kvm_mem_region_type type)
> >   {
> > -     return ____vm_vaddr_alloc(vm, sz, vaddr_min, type, vm->protected)=
;
> > +     return ____vm_vaddr_alloc(vm, sz, vaddr_min,
> > +                               KVM_UTIL_MIN_PFN * vm->page_size,
> > +                               vm->memslots[type], vm->protected);
> >   }
> >
> >   vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vad=
dr_t vaddr_min)
> >   {
> > -     return ____vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA=
, false);
> > +     return ____vm_vaddr_alloc(vm, sz, vaddr_min,
> > +                               KVM_UTIL_MIN_PFN * vm->page_size,
> > +                               vm->memslots[MEM_REGION_TEST_DATA], fal=
se);
> >   }
> >
> >   /*
> > @@ -1453,6 +1476,26 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, siz=
e_t sz, vm_vaddr_t vaddr_min)
> >       return __vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA);
> >   }
> >
> > +/**
> > + * Allocate memory in @vm of size @sz in memslot with id @data_memslot=
,
> > + * beginning with the desired address of @vaddr_min.
> > + *
> > + * If there isn't enough memory at @vaddr_min, find the next possible =
address
> > + * that can meet the requested size in the given memslot.
> > + *
> > + * Return the address where the memory is allocated.
> > + */
> > +vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
> > +                            vm_vaddr_t vaddr_min, uint32_t data_memslo=
t)
> > +{
> > +     vm_vaddr_t gva =3D ____vm_vaddr_alloc(vm, sz, vaddr_min,
> > +                                         (vm_paddr_t)vaddr_min, data_m=
emslot,
> > +                                         vm->protected);
> > +     TEST_ASSERT_EQ(gva, addr_gva2gpa(vm, gva));
>
> How can this be guaranteed?
> For ____vm_vaddr_alloc(), generically there is no enforcement about the
> identity of virtual and physical address.

The problem is that if the allocation won't be 1-to-1 the tests won't
work. So we figured it's better to fail early.
The way this is used in practice generally guarantees that the mapping
can be 1-to-1 since we create these mappings at an early stage.
>
> > +
> > +     return gva;
> > +}
> > +
> >   /*
> >    * VM Virtual Address Allocate Pages
> >    *
>
>

