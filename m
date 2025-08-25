Return-Path: <linux-kselftest+bounces-39879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10093B34ABC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0AE1B20A65
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C3B21CC44;
	Mon, 25 Aug 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1AxCg8g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75729CE1
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148535; cv=none; b=uR5OyTsgHI56PkEE0eFfDV9ZsjgPOp+cRYub3NMNTPhN/V1mIKrdp4f62umndGisaIexVwg4Q9tUxhOWmM+V9ng0vXyjgG12lA7ajBimNIEkbDKQ5Fpgpw9lAMgf1WnvvJpuTesYXJ+3VadfeRCzgy62LMSrcuM0Z3jOVZotIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148535; c=relaxed/simple;
	bh=sYYC0iVdbanWE7GDCqzygjBZmZhvkcgt/dDA7jE4oK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1xDgyhhvMPwsUiIGMOcBaeuCUXnditzLML6z2vuhDWJQmDg9LLalhnrts/fhm2Bewz6bt81BHa50uDEl7PSWYXnzzNQBCtC1/ldhPtjBSN2cCZKT+caGzItZ8uA1cuVH6+jVy/tqzNapStElsmgWZcYIllX3L7kjx3+3Q2ozUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1AxCg8g; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b29b714f8cso53181cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756148533; x=1756753333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaQqo74RcW2JwMwPTXCT7AWCzpKJ0O5c0t8MVHlmC8g=;
        b=H1AxCg8gXWjC7rOplmxO6nnijCzO6mTT5YF90GDB/4t7W5Su4rndvA3BW4QE7p9iOV
         o/VijxGbjCMz8Hwv9dj08LANHchQL+y8KvX9YwwMaE31OH7BCey7zGgnk2mTTCxfkPk5
         bJF+Bs2m39w8DcV3ZEsIUntjzGKXJIR7TpOAXsc+bHdnp9F12e0abBM1kBl08rWxYqgo
         CwsRejgEqnE1r2HBfr94kUZjJKO1om8EeGY1APJyURKGS25FbKJPHdT82V5kSjzRXJV4
         92fHUMCDK1Km3SJTkdxX34Ow6ONqkgXjZouJQPO425MpecFBXWqwLIzIU4yqJZma0H9Z
         Vy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148533; x=1756753333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaQqo74RcW2JwMwPTXCT7AWCzpKJ0O5c0t8MVHlmC8g=;
        b=SqqaSNL0PlXIHAt3MlAug4GNqMLUQpp/8rxw7Xpbs90PqVDLOtt4uxGJ1xhqpKnP4e
         ATqKp+yyMgapyiODDUIF4oy8j5UD8q2Y2fVMZLxVp8flQ7FgfTXlQwRbdAp0NZ4n9BQ6
         s5KwuW3yu5GxXoOVvK0CD2ou9NE1XOxnMx+Fo1tYsau+4vx6sNUftZVppXhONgNQEIB7
         N/xLXT5BWSHcnbir9kUG3AuKwkm+1NERai6B77jPQm+crDGTmjsa0z//r1dYg8DM2QeS
         ZzrTFj1dc0TQEHNRlr2P4aiu2mMm8zhQ7hnFOYvU53B9OLpsNRa6dTJ4Mtt5W30tMtuz
         Y02A==
X-Gm-Message-State: AOJu0YwVmKuQ6KyfnqGIMM0yTQ+OSmXR/jMGtJDVykwvB2iBEvj//PuE
	ZYYYr6BnJgbHqK6grwGsN4rLCnP3MP2jovCtIxV1oCcxaRELpnvCeCAax7V7bhp9jbFVRX2COxQ
	C6py6eVur4uVwu7t+DiarVTapmUbp7B3vwGrsh45Q
X-Gm-Gg: ASbGncsgs5NCIv6dIRx3G4vKKg/3NBHMLw8EE8oheL28eTndL79R+oQDBUu5oVqHZUa
	u7NdB/ohpwNpYgLNJI7mZ30/Wrk2WbwZbytjpdGZZOjkXgUJTE1Vr43aK+Zljpg8CEi4ishvfD0
	0WfD3mvswFRbcSHO/wSett+kfXlDX51prWHMcHbLiUhIobv3KdVJwGkRqhW8n7V2TM8Q4Sc+Ey7
	teCZy6wxdE8/RzMT0rfueIADAeNX00VbTTlZG8Ols/byB5psa4nQFiQXq0lW4zOlDQy
X-Google-Smtp-Source: AGHT+IG37Fpm8pmS0cYjnY1zdEIsH2AvZlMaGDSJAsScgM0WNtuFkJEb/GM+J22/j3DUH8fA/on5QCRXgh9ENMNDfEc=
X-Received: by 2002:a05:622a:2a08:b0:4ae:d2cc:ad51 with SMTP id
 d75a77b69052e-4b2e1d7275dmr521981cf.1.1756148532292; Mon, 25 Aug 2025
 12:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-15-sagis@google.com>
 <aKwhchKBV1ts+Jhm@yzhao56-desk.sh.intel.com>
In-Reply-To: <aKwhchKBV1ts+Jhm@yzhao56-desk.sh.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Mon, 25 Aug 2025 14:02:00 -0500
X-Gm-Features: Ac12FXzQbW3pU8ZuEpWVL71xnL6eIme2KZ_bnlMVjeOEZcTPvuL4Zc2kOAnffUI
Message-ID: <CAAhR5DGZnrpW8u9Y0O+EFLJJsbTVO6mdrh4jbG4CrFgR13Y60g@mail.gmail.com>
Subject: Re: [PATCH v9 14/19] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 3:41=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> On Wed, Aug 20, 2025 at 09:29:07PM -0700, Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > TDX protected memory needs to be measured and encrypted before it can b=
e
> > used by the guest. Traverse the VM's memory regions and initialize all
> > the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
> >
> > Once all the memory is initialized, the VM can be finalized by calling
> > KVM_TDX_FINALIZE_VM.
> >
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > Co-developed-by: Sagi Shahar <sagis@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >  .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
> >  .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 97 +++++++++++++++++++
> >  2 files changed, 99 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/t=
ools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > index a2509959c7ce..2467b6c35557 100644
> > --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > @@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm=
 *vm);
> >  void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vc=
pu *vcpu);
> >  void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_co=
de);
> >
> > +void vm_tdx_finalize(struct kvm_vm *vm);
> > +
> >  #endif // SELFTESTS_TDX_TDX_UTIL_H
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools=
/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > index d8eab99d9333..4024587ed3c2 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > @@ -274,3 +274,100 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t a=
ttributes)
> >
> >       free(init_vm);
> >  }
> > +
> > +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
> > +                             uint64_t gpa, uint64_t size)
> > +{
> > +     uint32_t metadata =3D KVM_TDX_MEASURE_MEMORY_REGION;
> > +     struct kvm_tdx_init_mem_region mem_region =3D {
> > +             .source_addr =3D (uint64_t)source_pages,
> > +             .gpa =3D gpa,
> > +             .nr_pages =3D size / PAGE_SIZE,
> > +     };
> > +     struct kvm_vcpu *vcpu;
> > +
> > +     vcpu =3D list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, li=
st);
> > +
> > +     TEST_ASSERT((mem_region.nr_pages > 0) &&
> > +                 ((mem_region.nr_pages * PAGE_SIZE) =3D=3D size),
> > +                 "Cannot add partial pages to the guest memory.\n");
> > +     TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) =3D=3D 0,
> > +                 "Source memory buffer is not page aligned\n");
> > +     vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, metadata, &mem_r=
egion);
> > +}
> > +
> > +static void tdx_init_pages(struct kvm_vm *vm, void *hva, uint64_t gpa,
> > +                        uint64_t size)
> > +{
> > +     void *scratch_page =3D calloc(1, PAGE_SIZE);
> > +     uint64_t nr_pages =3D size / PAGE_SIZE;
> > +     int i;
> > +
> > +     TEST_ASSERT(scratch_page,
> > +                 "Could not allocate memory for loading memory region"=
);
> > +
> > +     for (i =3D 0; i < nr_pages; i++) {
> > +             memcpy(scratch_page, hva, PAGE_SIZE);
> > +
> > +             tdx_init_mem_region(vm, scratch_page, gpa, PAGE_SIZE);
> > +
> > +             hva +=3D PAGE_SIZE;
> > +             gpa +=3D PAGE_SIZE;
> > +     }
> > +
> > +     free(scratch_page);
> > +}
> > +
> > +static void load_td_private_memory(struct kvm_vm *vm)
> > +{
> > +     struct userspace_mem_region *region;
> > +     int ctr;
> > +
> > +     hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
> > +             const struct sparsebit *protected_pages =3D region->prote=
cted_phy_pages;
> > +             const vm_paddr_t gpa_base =3D region->region.guest_phys_a=
ddr;
> > +             const uint64_t hva_base =3D region->region.userspace_addr=
;
> > +             const sparsebit_idx_t lowest_page_in_region =3D gpa_base =
>> vm->page_shift;
> > +
> > +             sparsebit_idx_t i;
> > +             sparsebit_idx_t j;
> > +
> > +             if (!sparsebit_any_set(protected_pages))
> > +                     continue;
> > +
> > +             sparsebit_for_each_set_range(protected_pages, i, j) {
> > +                     const uint64_t size_to_load =3D (j - i + 1) * vm-=
>page_size;
> > +                     const uint64_t offset =3D
> > +                             (i - lowest_page_in_region) * vm->page_si=
ze;
> > +                     const uint64_t hva =3D hva_base + offset;
> > +                     const uint64_t gpa =3D gpa_base + offset;
> > +
> > +                     vm_set_memory_attributes(vm, gpa, size_to_load,
> > +                                              KVM_MEMORY_ATTRIBUTE_PRI=
VATE);
> > +
> > +                     /*
> > +                      * Here, memory is being loaded from hva to gpa. =
If the memory
> > +                      * mapped to hva is also used to back gpa, then a=
 copy has to be
> > +                      * made just for loading, since KVM_TDX_INIT_MEM_=
REGION ioctl
> > +                      * cannot encrypt memory in place.
> > +                      *
> > +                      * To determine if memory mapped to hva is also u=
sed to back
> > +                      * gpa, use a heuristic:
> > +                      *
> > +                      * If this memslot has guest_memfd, then this mem=
slot should
> > +                      * have memory backed from two sources: hva for s=
hared memory
> > +                      * and gpa will be backed by guest_memfd.
> > +                      */
> > +                     if (region->region.guest_memfd =3D=3D -1)
> Why to pass !guest_memfd region to tdx_init_mem_region()?
>

Not sure I understand your comment.

>
> > +                             tdx_init_pages(vm, (void *)hva, gpa, size=
_to_load);
> > +                     else
> > +                             tdx_init_mem_region(vm, (void *)hva, gpa,=
 size_to_load);
> > +             }
> > +     }
> > +}
> > +
> > +void vm_tdx_finalize(struct kvm_vm *vm)
> > +{
> > +     load_td_private_memory(vm);
> > +     vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> > +}
> > --
> > 2.51.0.rc1.193.gad69d77794-goog
> >
> >

