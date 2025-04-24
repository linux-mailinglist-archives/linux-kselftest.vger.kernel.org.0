Return-Path: <linux-kselftest+bounces-31596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE45A9B60B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 20:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FAD465366
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB6228DEEB;
	Thu, 24 Apr 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpsJppya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5ED28934E
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518516; cv=none; b=eM9rWzHt3YwL03bF4nScM/Rj5meQVgQtzCc9qEOBO06hWg3ywGm+FjJHu4zwODW3Y7ejlrRsd4i2gih+l0+2Y0B2xoiuRjFbRyJcQO6OvSi5OWeAS5V/jJTMjNiU0KrLhaJWgNQq2tpkB/XVuNA5Z0PFJl8m01klUdwV4zSccP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518516; c=relaxed/simple;
	bh=PyuSdL80DbmXr9kGJoeGx6tq2St315/tjlTgqAsijBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=riTtS9a4tTJ2xW+4o2Lq+9pvd8QiANdZIf0EUeBN3qF77E1pRoXJNzqLwZCHuwzt+7OrEGuu+vXaI0GLuKQvwjGZe5Uy8WzUfiauVzJVbdiAO4yyJ5cAPjKcJhT4iKWtbx73JwtHZdZHhYx3isVuMyrrRLBlDKkEQVOx8Of0djc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpsJppya; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73bfc657aefso868503b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745518513; x=1746123313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5ca3BAG75clyx23dBcL2JDA6BjjGOPOYCSfGb5BdZc=;
        b=KpsJppyaBqeGD73Fhp64nHRcAbIUxbycAph9B2n5hD1uaBKbFYgl7a9dn144PajEKL
         h3NQxZlIP8oxHMIc5HS4I5l9oSG9qc39064QpAMgWM5y8qiaW1AOpFwnt+yNUpD+kQEA
         e7kPeyJ05KOhHX5DlvU55FIKLKbLLmXor+U0RFzFdWklkO61qPj8u0pLfoMT2zzuOkNF
         hW7BF2428+wCzzHLMcCi10WBc8fOahp7tYblrnSftXYB7zYCnyOhbVoYBrclKONh7uMK
         5Bm28nd5BLh+/+SxmTOG50U/HXKAoNlY63ozxiLBX/w5Yqt1tjyyaekwpDc3xr8lVjYy
         Gagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745518513; x=1746123313;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5ca3BAG75clyx23dBcL2JDA6BjjGOPOYCSfGb5BdZc=;
        b=eKM+Mj9MeQ3WHadrCF+iU2CpzXT0HGnZZfuuRleyCwIRGO2PZ7LjQHH1RTP8R/UGE9
         +tJCg34lv3Pu8BuJHckohwKbsUgASLS9BD0w5i/ZVnWrtiebdYLgKFBSDgRUU3Gu5ngQ
         tAUQwfpbTTpjScRD4wd3HUV20hrkSN6cTRcj4Oxdt3Olp0K5g2ETu2ZNeoKl3wVDEs+Q
         DVEeI2fRtDOTmmjcuc/9zjk7zuAyAS5ILcCjschuRN7yqgghXHb5nW9Jsl8TxF5O0Pq+
         HWLymeTdP70AclicIbfwZqUImSkKmWOFpkW/+qt8cRoGRY7yILlDqkFYIsPk024jVyId
         SHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1saBjr2gfe2jPKt3VvMKUN7Hnm9dH9GV9/+wwwJkw3WNMUQY+53TYq+Ee+LYbT8AF9TWUbH+cVmZDCzJipco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZl+ufQhRuRcyPC5HB3yN9R8MQ8LxIsN+KraLZAn1jaCKuzmWI
	ees6G8gOkDvbmDhL1JxnYrTu9d9YX9OhG5fttA09c6vXqx+HAliKYA89eZuBwcPgKG4gk/Sc9hs
	fT9nzJExIp4qKPGBRL4hXzg==
X-Google-Smtp-Source: AGHT+IEjHUImTvNW706XVptp79KSjxcaqI5ueQhopNSPDN6+zyHSYy4f+9kb3ZIp9FE3XNV/3Ks8SXHBhHpHnX8+oA==
X-Received: from pfbfe15.prod.google.com ([2002:a05:6a00:2f0f:b0:736:b063:5038])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4acb:b0:732:2923:b70f with SMTP id d2e1a72fcca58-73e32fda318mr943178b3a.11.1745518513546;
 Thu, 24 Apr 2025 11:15:13 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:15:11 -0700
In-Reply-To: <CAGtprH-Ana5A2hz_D+CQ0NYRVxfpR6e0Sojssym-UtUnYpOPqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
 <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com> <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
 <aAmPQssuN9Zba//b@yzhao56-desk.sh.intel.com> <aAm9OHGt6Ag7ztqs@yzhao56-desk.sh.intel.com>
 <c4dae65f-b5e6-44fa-b5ab-8614f1d47cb5@intel.com> <aAnytM/E6sIdvKNq@yzhao56-desk.sh.intel.com>
 <CAGtprH-Ana5A2hz_D+CQ0NYRVxfpR6e0Sojssym-UtUnYpOPqg@mail.gmail.com>
Message-ID: <diqz7c39zas0.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically split/reconstruct
 HugeTLB page
From: Ackerley Tng <ackerleytng@google.com>
To: Vishal Annapurve <vannapurve@google.com>, Yan Zhao <yan.y.zhao@intel.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, tabba@google.com, quic_eberman@quicinc.com, 
	roypat@amazon.co.uk, jgg@nvidia.com, peterx@redhat.com, david@redhat.com, 
	rientjes@google.com, fvdl@google.com, jthoughton@google.com, 
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com, 
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com, 
	muchun.song@linux.dev, erdemaktas@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Vishal Annapurve <vannapurve@google.com> writes:

> On Thu, Apr 24, 2025 at 1:15=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> w=
rote:
>>
>> On Thu, Apr 24, 2025 at 01:55:51PM +0800, Chenyi Qiang wrote:
>> >
>> >
>> > On 4/24/2025 12:25 PM, Yan Zhao wrote:
>> > > On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
>> > >> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
>> > >>> Yan Zhao <yan.y.zhao@intel.com> writes:
>> > >>>
>> > >>>> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
>> > >>>>> +/*
>> > >>>>> + * Allocates and then caches a folio in the filemap. Returns a =
folio with
>> > >>>>> + * refcount of 2: 1 after allocation, and 1 taken by the filema=
p.
>> > >>>>> + */
>> > >>>>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(str=
uct inode *inode,
>> > >>>>> +                                                           pgof=
f_t index)
>> > >>>>> +{
>> > >>>>> +       struct kvm_gmem_hugetlb *hgmem;
>> > >>>>> +       pgoff_t aligned_index;
>> > >>>>> +       struct folio *folio;
>> > >>>>> +       int nr_pages;
>> > >>>>> +       int ret;
>> > >>>>> +
>> > >>>>> +       hgmem =3D kvm_gmem_hgmem(inode);
>> > >>>>> +       folio =3D kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->=
spool);
>> > >>>>> +       if (IS_ERR(folio))
>> > >>>>> +               return folio;
>> > >>>>> +
>> > >>>>> +       nr_pages =3D 1UL << huge_page_order(hgmem->h);
>> > >>>>> +       aligned_index =3D round_down(index, nr_pages);
>> > >>>> Maybe a gap here.
>> > >>>>
>> > >>>> When a guest_memfd is bound to a slot where slot->base_gfn is not=
 aligned to
>> > >>>> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligne=
d, the
>> > >>>> corresponding GFN is not 2M/1G aligned.
>> > >>>
>> > >>> Thanks for looking into this.
>> > >>>
>> > >>> In 1G page support for guest_memfd, the offset and size are always
>> > >>> hugepage aligned to the hugepage size requested at guest_memfd cre=
ation
>> > >>> time, and it is true that when binding to a memslot, slot->base_gf=
n and
>> > >>> slot->npages may not be hugepage aligned.
>> > >>>
>> > >>>>
>> > >>>> However, TDX requires that private huge pages be 2M aligned in GF=
N.
>> > >>>>
>> > >>>
>> > >>> IIUC other factors also contribute to determining the mapping leve=
l in
>> > >>> the guest page tables, like lpage_info and .private_max_mapping_le=
vel()
>> > >>> in kvm_x86_ops.
>> > >>>
>> > >>> If slot->base_gfn and slot->npages are not hugepage aligned, lpage=
_info
>> > >>> will track that and not allow faulting into guest page tables at h=
igher
>> > >>> granularity.
>> > >>
>> > >> lpage_info only checks the alignments of slot->base_gfn and
>> > >> slot->base_gfn + npages. e.g.,
>> > >>
>> > >> if slot->base_gfn is 8K, npages is 8M, then for this slot,
>> > >> lpage_info[2M][0].disallow_lpage =3D 1, which is for GFN [4K, 2M+8K=
);
>> > >> lpage_info[2M][1].disallow_lpage =3D 0, which is for GFN [2M+8K, 4M=
+8K);
>> > >> lpage_info[2M][2].disallow_lpage =3D 0, which is for GFN [4M+8K, 6M=
+8K);
>> > >> lpage_info[2M][3].disallow_lpage =3D 1, which is for GFN [6M+8K, 8M=
+8K);
>> >
>> > Should it be?
>> > lpage_info[2M][0].disallow_lpage =3D 1, which is for GFN [8K, 2M);
>> > lpage_info[2M][1].disallow_lpage =3D 0, which is for GFN [2M, 4M);
>> > lpage_info[2M][2].disallow_lpage =3D 0, which is for GFN [4M, 6M);
>> > lpage_info[2M][3].disallow_lpage =3D 0, which is for GFN [6M, 8M);
>> > lpage_info[2M][4].disallow_lpage =3D 1, which is for GFN [8M, 8M+8K);
>> Right. Good catch. Thanks!
>>
>> Let me update the example as below:
>> slot->base_gfn is 2 (for GPA 8KB), npages 2000 (for a 8MB range)
>>
>> lpage_info[2M][0].disallow_lpage =3D 1, which is for GPA [8KB, 2MB);
>> lpage_info[2M][1].disallow_lpage =3D 0, which is for GPA [2MB, 4MB);
>> lpage_info[2M][2].disallow_lpage =3D 0, which is for GPA [4MB, 6MB);
>> lpage_info[2M][3].disallow_lpage =3D 0, which is for GPA [6MB, 8MB);
>> lpage_info[2M][4].disallow_lpage =3D 1, which is for GPA [8MB, 8MB+8KB);
>>
>> lpage_info indicates that a 2MB mapping is alllowed to cover GPA 4MB and=
 GPA
>> 4MB+16KB. However, their aligned_index values lead guest_memfd to alloca=
te two
>> 2MB folios, whose physical addresses may not be contiguous.
>>
>> Additionally, if the guest accesses two GPAs, e.g., GPA 2MB+8KB and GPA =
4MB,
>> KVM could create two 2MB mappings to cover GPA ranges [2MB, 4MB), [4MB, =
6MB).
>> However, guest_memfd just allocates the same 2MB folio for both faults.
>>
>>
>> >
>> > >>
>> > >>   ---------------------------------------------------------
>> > >>   |          |  |          |  |          |  |          |  |
>> > >>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K
>> > >>
>> > >> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][2],=
 huge
>> > >> page is allowed. Also, they have the same aligned_index 2 in guest_=
memfd.
>> > >> So, guest_memfd allocates the same huge folio of 2M order for them.
>> > > Sorry, sent too fast this morning. The example is not right. The cor=
rect
>> > > one is:
>> > >
>> > > For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is allowed. =
So,
>> > > KVM will create a 2M mapping for them.
>> > >
>> > > However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspond to =
the
>> > > same 2M folio and physical addresses may not be contiguous.
>
> Then during binding, guest memfd offset misalignment with hugepage
> should be same as gfn misalignment. i.e.
>
> (offset & ~huge_page_mask(h)) =3D=3D ((slot->base_gfn << PAGE_SHIFT) &
> ~huge_page_mask(h));
>
> For non guest_memfd backed scenarios, KVM allows slot gfn ranges that
> are not hugepage aligned, so guest_memfd should also be able to
> support non-hugepage aligned memslots.
>

I drew up a picture [1] which hopefully clarifies this.

Thanks for pointing this out, I understand better now and we will add an
extra constraint during memslot binding of guest_memfd to check that gfn
offsets within a hugepage must be guest_memfd offsets.

Adding checks at binding time will allow hugepage-unaligned offsets (to
be at parity with non-guest_memfd backing memory) but still fix this
issue.

lpage_info will make sure that ranges near the bounds will be
fragmented, but the hugepages in the middle will still be mappable as
hugepages.

[1] https://lpc.events/event/18/contributions/1764/attachments/1409/3706/bi=
nding-must-have-same-alignment.svg

>> > >
>> > >
>> > >> However, for TDX, GFN 6M and GFN 6M+4K should not belong to the sam=
e folio.
>> > >> It's also weird for a 2M mapping in KVM to stride across 2 huge fol=
ios.
>> > >>
>> > >>> Hence I think it is okay to leave it to KVM to fault pages into th=
e
>> > >>> guest correctly. For guest_memfd will just maintain the invariant =
that
>> > >>> offset and size are hugepage aligned, but not require that
>> > >>> slot->base_gfn and slot->npages are hugepage aligned. This behavio=
r will
>> > >>> be consistent with other backing memory for guests like regular sh=
mem or
>> > >>> HugeTLB.
>> > >>>
>> > >>>>> +       ret =3D kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapp=
ing, folio,
>> > >>>>> +                                                aligned_index,
>> > >>>>> +                                                htlb_alloc_mask=
(hgmem->h));
>> > >>>>> +       WARN_ON(ret);
>> > >>>>> +
>> > >>>>>         spin_lock(&inode->i_lock);
>> > >>>>>         inode->i_blocks +=3D blocks_per_huge_page(hgmem->h);
>> > >>>>>         spin_unlock(&inode->i_lock);
>> > >>>>>
>> > >>>>> -       return page_folio(requested_page);
>> > >>>>> +       return folio;
>> > >>>>> +}
>> > >
>> >

