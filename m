Return-Path: <linux-kselftest+bounces-14096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9806693A7EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 21:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53419285EB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747D148301;
	Tue, 23 Jul 2024 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRUA/eY5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D31442ED
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764613; cv=none; b=Kr56sBwNRX2M4oChKmxeoBBXRriidEG6uJh2v75OkrvZe4SWNwC8+9jScjNooW1Xb6EWRp5vsvJg1xDz7cYq+cJbHFc4ztpGNf8g3FHeUveHWscv1MJe3sj4UQHSMV0TH2zulSkDw1gr3SVhO+3eTSuNuKLZC+0SkGAClv3ZG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764613; c=relaxed/simple;
	bh=w1yiFjHCdqLJJArQszIJSGLgVCFAk20EVpIzc9McI/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3I8kqUqcJWXK0PQNnOcouKlwE0fTdek/h1pa59vKE4ppEYLd0RPXK7rT2xN4hJCbGw7OuefHQDr5ijjrDsjVXgGZtgwjwHHlq6AlupjDXsYg9fqv2SJoq9Q7/JdkTcIJFStezWiOXsfC00C6ylEx5CjtpwPzfUwJEOe2GZCx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRUA/eY5; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e087c7ef68bso3091932276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721764610; x=1722369410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ8gVf5B0wPtEoet4zm24rxnx8GgSxUPU5gw6kjX2ns=;
        b=nRUA/eY5cbBr+AFy7FQKi6I/p1dSmogE6vI3BGtScaD5NgwrM/XSmfx0yWoufZiKZj
         SXUteZeuuB8ZsnUuyw6c6Hhll4i1C0ehrcmtl9k5wQVIYdAadNZm4w0AVDIl2NoMItB9
         XjZrCuJ703/hKr4MhJsrm8mT1D84VVUuZKrOGoMxk0Ue7WmhAgpViiR2S4bW0yO3YcQ+
         f/Vm1+BmRr4ubacCXDb0rNTTyKnh8znMKAmQs5GFsR0VsWKXkx7aWBhp6mZLu9U/8fGg
         jwJKQItzxKEoof5GuZRGQkQ+oEulHZPeYjsZ6oNRc8fkt+P5XvcoBNixpQBlew8i2ixy
         UWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721764610; x=1722369410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ8gVf5B0wPtEoet4zm24rxnx8GgSxUPU5gw6kjX2ns=;
        b=HPFpieg7hRwntmQ/diPGhN4uRzyMW9c/lVH+a+oZ5e71CPOqeOix/ej8/KjhCjFz28
         v7isibZbnAQqKqdx32/qCinENlWakvX+qc5O6WOybtnPRTS9rCXFqO1uc+/MnqOKBYox
         q5/YbxPgX4roNxw02fsI0OEsONQBT5fIZee3TGafhqYoI1gKs7OT2B2z/rQPEDEyglMY
         BIGJ7knVdzxjl3JwCKiOhLOlU+ogKRA2PeeB9MgDgKJnVNwIfEXbu89wyDk5Yi0m3Tku
         XLftj5BaBVZUgOEawlOU9yfbwJAC28snsastOU98WNWO1e1bMnxiMs3lby8t513rjrXn
         gczg==
X-Gm-Message-State: AOJu0YxgVzGMDAUOHt1fc4KleBHI+2R2p8VLKl44byPep7PHFnX+Viij
	zJ/amhTet5i/7fyagyhbOlHnynH6nCZPxo4y/fUHsiGd2xAZ8SAdGYb1/+QLvegiZh6a/Gn+jf9
	ySN+qBYk1oVFUuA9IjIifXsDFdSAlb8WHq2G/
X-Google-Smtp-Source: AGHT+IGDERizmWaRZSYrEeosGY/RVvaTx8fAfVuWpYPQS52G6odr3z9alx6euwKiIoGuRdU+jKSkuTTpA0Br5WZBQTo=
X-Received: by 2002:a05:6902:a07:b0:e05:ae3f:7ae8 with SMTP id
 3f1490d57ef6-e087b9e574emr13923095276.52.1721764610048; Tue, 23 Jul 2024
 12:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <20231212204647.2170650-2-sagis@google.com>
 <797bfae3-6419-4a7a-991a-1d203691d2cb@intel.com>
In-Reply-To: <797bfae3-6419-4a7a-991a-1d203691d2cb@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 23 Jul 2024 14:56:39 -0500
Message-ID: <CAAhR5DGQDWdzizHHmG9yEQej0i5Ovn=RaXF_QkpdFT6Vragnww@mail.gmail.com>
Subject: Re: [RFC PATCH v5 01/29] KVM: selftests: Add function to allow
 one-to-one GVA to GPA mappings
To: "Zhang, Dongsheng X" <dongsheng.x.zhang@intel.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>, 
	Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:29=E2=80=AFPM Zhang, Dongsheng X
<dongsheng.x.zhang@intel.com> wrote:
>
>
>
> On 12/12/2023 12:46 PM, Sagi Shahar wrote:
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
> >  .../selftests/kvm/include/kvm_util_base.h     |  2 +
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 63 ++++++++++++++++---
> >  2 files changed, 55 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tool=
s/testing/selftests/kvm/include/kvm_util_base.h
> > index 1426e88ebdc7..c2e5c5f25dfc 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > @@ -564,6 +564,8 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t=
 sz, vm_vaddr_t vaddr_min);
> >  vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t v=
addr_min,
> >                           enum kvm_mem_region_type type);
> >  vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vadd=
r_t vaddr_min);
> > +vm_vaddr_t vm_vaddr_alloc_1to1(struct kvm_vm *vm, size_t sz,
> > +                            vm_vaddr_t vaddr_min, uint32_t data_memslo=
t);
> >  vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
> >  vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
> >                                enum kvm_mem_region_type type);
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing=
/selftests/kvm/lib/kvm_util.c
> > index febc63d7a46b..4f1ae0f1eef0 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -1388,17 +1388,37 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *v=
m, size_t sz,
> >       return pgidx_start * vm->page_size;
> >  }
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
> >  static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
> > -                                  vm_vaddr_t vaddr_min,
> > -                                  enum kvm_mem_region_type type,
> > -                                  bool encrypt)
> > +                                  vm_vaddr_t vaddr_min, vm_paddr_t pad=
dr_min,
> > +                                  uint32_t data_memslot, bool encrypt)
> >  {
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
> >  vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t v=
addr_min,
> >                           enum kvm_mem_region_type type)
> >  {
> > -     return ____vm_vaddr_alloc(vm, sz, vaddr_min, type, vm->protected)=
;
> > +     return ____vm_vaddr_alloc(vm, sz, vaddr_min,
> > +                               KVM_UTIL_MIN_PFN * vm->page_size,
> > +                               vm->memslots[type], vm->protected);
> >  }
> >
> >  vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vadd=
r_t vaddr_min)
> >  {
> > -     return ____vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA=
, false);
> > +     return ____vm_vaddr_alloc(vm, sz, vaddr_min,
> > +                               KVM_UTIL_MIN_PFN * vm->page_size,
> > +                               vm->memslots[MEM_REGION_TEST_DATA], fal=
se);
> >  }
> >
> >  /*
> > @@ -1453,6 +1476,26 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, siz=
e_t sz, vm_vaddr_t vaddr_min)
> >       return __vm_vaddr_alloc(vm, sz, vaddr_min, MEM_REGION_TEST_DATA);
> >  }
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
> By 1to1, do you mean virtual address=3Dphysical address?, community tends=
 to call this identity mapping.
> Examples (function name):
> create_identity_mapping_pagetables()
> hellcreek_setup_tc_identity_mapping()
> identity_mapping_add()

Thanks for the input. Will switch to vm_vaddr_identity_alloc()
>
> > +
> > +     return gva;
> > +}
> > +
> >  /*
> >   * VM Virtual Address Allocate Pages
> >   *
>

