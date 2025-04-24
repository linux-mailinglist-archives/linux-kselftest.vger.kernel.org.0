Return-Path: <linux-kselftest+bounces-31563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDAA9B03B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 16:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61EA37AD519
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E883E18A959;
	Thu, 24 Apr 2025 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tO0+FS0F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15A12CDA5
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503843; cv=none; b=A6rBerCvPn2IVeAQZL0honogY5Huo5eZ1NoobwFRVJobovAgJ6z11XaPg4+aLlP/U17JYnVQTcrvfEAY6J21Z+OkRydmU+/h6XOv0J+6RBENil9CiqTey13L5lE0o6weYYstsHSk8Q2YyCWPaf+aLEpVLY6vn0idvZddsWLnhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503843; c=relaxed/simple;
	bh=F+Wja2ADrz1zv00eM7+FHcJd4flj4VeWlpXuRLNxVCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmg6wzrVb1KqIM4wZFWS56q0jQQcbnO9/4gnYqkOIrTs+BEWLRaIlqh9ccwB46TBGpXZGusAzX4gupDzD+DCkhaMRj+3gudlOOoEHH9Go2wQJWthjmB09WLcRhLFZf/HcDGLGAqy/rECU5gC7ikg6nZ6Or3cd/qx46TvOWpDg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tO0+FS0F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2263428c8baso161745ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745503841; x=1746108641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMrvBQHRfYfkGh/Um2a6kp7PNJoeWsTC0p7ApqTxhJ4=;
        b=tO0+FS0FKIRYHGZ8PWrzhQywfXGvjj7t+Ahs4Ir8XMcJ8fmnVV51W6F9YSXfJw2gFy
         B9ydyVFoetFUCIbttukmOA2VXv+nN2n9g3BER2/pcx5RcUMYHsG3rfnKZ7G/47tgTJX3
         c3sHBmfQ823B+7c1GgqBJ1jG1jbOxI9BkYZPgla7rBqGu9qbok82AKIuOzpg8Bi4MM9Y
         94GzNZ2ezRzl6/OVUyN1X2TDSZjtWIqQYmQ9DZcfLHyO6XXVzmFGIPHRIXiT8zniSt5v
         KlBd+MZxvm63an9z2Y5pn1MPN0KO6U5tfsiCsjXX2RFx9XqWtPcITBDZuxF+Hbzd6L9Q
         b6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503841; x=1746108641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMrvBQHRfYfkGh/Um2a6kp7PNJoeWsTC0p7ApqTxhJ4=;
        b=AhHQ0E9zRTgHCnpWhtNXMo1RMqdF69d3BhQI0cwYcniNUxMnUp4xavtH4QE/NrTftA
         bTndhZx79GIr3MqO9dMn1dOY88C+64Rvqe4oq0+6fnVHQAQSL369stqlOSsSZbhvXU+F
         ZYFyWf0RtuQSTLHZzB635heTlSzTxRsNCcZx+P6h8/RG56KXtCaSsE2lkLaKpWoeDEt3
         jZW6s/eewg6GVLOqtUxUG7KxHhgjJPefP3ShjcjR4+/xcGyqISuDF0xvHuXbn4TInUFo
         xmzikB1oHbEbZKJBcgZu8JzIlQjkPKYMO6dk1HVFUjrDRrMdu37RMlqT0FfGDjcZ9+ds
         z47A==
X-Forwarded-Encrypted: i=1; AJvYcCWI6yQWAmIcksJ6jpSmiv3wQexaFI6/EVTW2wFJ+GBoaG+6vCy/6PucU7ml+8nbi2su5NGYX88J6eoIxHx0exc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6VyBdKfHMGEhvtR+/YSC5+5MIsiorTT/Tx3tNKQCttP/zxvF
	QlFOrwQb+FfoMo1fe72zbOQm3+rDUnNqZ6YZKSgl1BuJQrb6k9zZMaBmKN/YwYAmijMe1S6cpjq
	RDo4aBLOGDuPSAFzrwoH3FnALZg1CYL61eanC
X-Gm-Gg: ASbGncu87kvTM25XG6Z01+JETMd3t/wTC4JN5Jd2nt4e65hll9H+N/VxpMFsjgeW4MS
	DeE4ymtvf5zutlC+SUdNL9cciXu/3kLO/LtBoVSCE39PHALr7zFYfCZi6Z+mWYm+Ii/bq2m77Ox
	rsQ93SHMP8B72QiNAQbbF39GxK4t9vtRzY0DED2FU1cmeUehCtvvfNtg==
X-Google-Smtp-Source: AGHT+IFD9PMIDjYVZIu4XeDCEmXm5JJ9kqk0ET3qsJ1IGuscVnIeFyKraOFTxsj8pEhDs0FmSrqFKcRZTv0WGcRk6BM=
X-Received: by 2002:a17:903:190d:b0:223:7f8f:439b with SMTP id
 d9443c01a7336-22db331d4fcmr2342005ad.29.1745503840777; Thu, 24 Apr 2025
 07:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com> <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
 <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com> <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
 <aAmPQssuN9Zba//b@yzhao56-desk.sh.intel.com> <aAm9OHGt6Ag7ztqs@yzhao56-desk.sh.intel.com>
 <c4dae65f-b5e6-44fa-b5ab-8614f1d47cb5@intel.com> <aAnytM/E6sIdvKNq@yzhao56-desk.sh.intel.com>
In-Reply-To: <aAnytM/E6sIdvKNq@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 24 Apr 2025 07:10:28 -0700
X-Gm-Features: ATxdqUEQE_t-BEFR1W0udJMvfpqwrx52O_-L1cdq80rEE8HhadLoddGPwZuyCFg
Message-ID: <CAGtprH-Ana5A2hz_D+CQ0NYRVxfpR6e0Sojssym-UtUnYpOPqg@mail.gmail.com>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically split/reconstruct
 HugeTLB page
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Ackerley Tng <ackerleytng@google.com>, tabba@google.com, 
	quic_eberman@quicinc.com, roypat@amazon.co.uk, jgg@nvidia.com, 
	peterx@redhat.com, david@redhat.com, rientjes@google.com, fvdl@google.com, 
	jthoughton@google.com, seanjc@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, erdemaktas@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 1:15=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> On Thu, Apr 24, 2025 at 01:55:51PM +0800, Chenyi Qiang wrote:
> >
> >
> > On 4/24/2025 12:25 PM, Yan Zhao wrote:
> > > On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
> > >> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
> > >>> Yan Zhao <yan.y.zhao@intel.com> writes:
> > >>>
> > >>>> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
> > >>>>> +/*
> > >>>>> + * Allocates and then caches a folio in the filemap. Returns a f=
olio with
> > >>>>> + * refcount of 2: 1 after allocation, and 1 taken by the filemap=
.
> > >>>>> + */
> > >>>>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(stru=
ct inode *inode,
> > >>>>> +                                                           pgoff=
_t index)
> > >>>>> +{
> > >>>>> +       struct kvm_gmem_hugetlb *hgmem;
> > >>>>> +       pgoff_t aligned_index;
> > >>>>> +       struct folio *folio;
> > >>>>> +       int nr_pages;
> > >>>>> +       int ret;
> > >>>>> +
> > >>>>> +       hgmem =3D kvm_gmem_hgmem(inode);
> > >>>>> +       folio =3D kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->s=
pool);
> > >>>>> +       if (IS_ERR(folio))
> > >>>>> +               return folio;
> > >>>>> +
> > >>>>> +       nr_pages =3D 1UL << huge_page_order(hgmem->h);
> > >>>>> +       aligned_index =3D round_down(index, nr_pages);
> > >>>> Maybe a gap here.
> > >>>>
> > >>>> When a guest_memfd is bound to a slot where slot->base_gfn is not =
aligned to
> > >>>> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned=
, the
> > >>>> corresponding GFN is not 2M/1G aligned.
> > >>>
> > >>> Thanks for looking into this.
> > >>>
> > >>> In 1G page support for guest_memfd, the offset and size are always
> > >>> hugepage aligned to the hugepage size requested at guest_memfd crea=
tion
> > >>> time, and it is true that when binding to a memslot, slot->base_gfn=
 and
> > >>> slot->npages may not be hugepage aligned.
> > >>>
> > >>>>
> > >>>> However, TDX requires that private huge pages be 2M aligned in GFN=
.
> > >>>>
> > >>>
> > >>> IIUC other factors also contribute to determining the mapping level=
 in
> > >>> the guest page tables, like lpage_info and .private_max_mapping_lev=
el()
> > >>> in kvm_x86_ops.
> > >>>
> > >>> If slot->base_gfn and slot->npages are not hugepage aligned, lpage_=
info
> > >>> will track that and not allow faulting into guest page tables at hi=
gher
> > >>> granularity.
> > >>
> > >> lpage_info only checks the alignments of slot->base_gfn and
> > >> slot->base_gfn + npages. e.g.,
> > >>
> > >> if slot->base_gfn is 8K, npages is 8M, then for this slot,
> > >> lpage_info[2M][0].disallow_lpage =3D 1, which is for GFN [4K, 2M+8K)=
;
> > >> lpage_info[2M][1].disallow_lpage =3D 0, which is for GFN [2M+8K, 4M+=
8K);
> > >> lpage_info[2M][2].disallow_lpage =3D 0, which is for GFN [4M+8K, 6M+=
8K);
> > >> lpage_info[2M][3].disallow_lpage =3D 1, which is for GFN [6M+8K, 8M+=
8K);
> >
> > Should it be?
> > lpage_info[2M][0].disallow_lpage =3D 1, which is for GFN [8K, 2M);
> > lpage_info[2M][1].disallow_lpage =3D 0, which is for GFN [2M, 4M);
> > lpage_info[2M][2].disallow_lpage =3D 0, which is for GFN [4M, 6M);
> > lpage_info[2M][3].disallow_lpage =3D 0, which is for GFN [6M, 8M);
> > lpage_info[2M][4].disallow_lpage =3D 1, which is for GFN [8M, 8M+8K);
> Right. Good catch. Thanks!
>
> Let me update the example as below:
> slot->base_gfn is 2 (for GPA 8KB), npages 2000 (for a 8MB range)
>
> lpage_info[2M][0].disallow_lpage =3D 1, which is for GPA [8KB, 2MB);
> lpage_info[2M][1].disallow_lpage =3D 0, which is for GPA [2MB, 4MB);
> lpage_info[2M][2].disallow_lpage =3D 0, which is for GPA [4MB, 6MB);
> lpage_info[2M][3].disallow_lpage =3D 0, which is for GPA [6MB, 8MB);
> lpage_info[2M][4].disallow_lpage =3D 1, which is for GPA [8MB, 8MB+8KB);
>
> lpage_info indicates that a 2MB mapping is alllowed to cover GPA 4MB and =
GPA
> 4MB+16KB. However, their aligned_index values lead guest_memfd to allocat=
e two
> 2MB folios, whose physical addresses may not be contiguous.
>
> Additionally, if the guest accesses two GPAs, e.g., GPA 2MB+8KB and GPA 4=
MB,
> KVM could create two 2MB mappings to cover GPA ranges [2MB, 4MB), [4MB, 6=
MB).
> However, guest_memfd just allocates the same 2MB folio for both faults.
>
>
> >
> > >>
> > >>   ---------------------------------------------------------
> > >>   |          |  |          |  |          |  |          |  |
> > >>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K
> > >>
> > >> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][2], =
huge
> > >> page is allowed. Also, they have the same aligned_index 2 in guest_m=
emfd.
> > >> So, guest_memfd allocates the same huge folio of 2M order for them.
> > > Sorry, sent too fast this morning. The example is not right. The corr=
ect
> > > one is:
> > >
> > > For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is allowed. S=
o,
> > > KVM will create a 2M mapping for them.
> > >
> > > However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspond to t=
he
> > > same 2M folio and physical addresses may not be contiguous.

Then during binding, guest memfd offset misalignment with hugepage
should be same as gfn misalignment. i.e.

(offset & ~huge_page_mask(h)) =3D=3D ((slot->base_gfn << PAGE_SHIFT) &
~huge_page_mask(h));

For non guest_memfd backed scenarios, KVM allows slot gfn ranges that
are not hugepage aligned, so guest_memfd should also be able to
support non-hugepage aligned memslots.

> > >
> > >
> > >> However, for TDX, GFN 6M and GFN 6M+4K should not belong to the same=
 folio.
> > >> It's also weird for a 2M mapping in KVM to stride across 2 huge foli=
os.
> > >>
> > >>> Hence I think it is okay to leave it to KVM to fault pages into the
> > >>> guest correctly. For guest_memfd will just maintain the invariant t=
hat
> > >>> offset and size are hugepage aligned, but not require that
> > >>> slot->base_gfn and slot->npages are hugepage aligned. This behavior=
 will
> > >>> be consistent with other backing memory for guests like regular shm=
em or
> > >>> HugeTLB.
> > >>>
> > >>>>> +       ret =3D kvm_gmem_hugetlb_filemap_add_folio(inode->i_mappi=
ng, folio,
> > >>>>> +                                                aligned_index,
> > >>>>> +                                                htlb_alloc_mask(=
hgmem->h));
> > >>>>> +       WARN_ON(ret);
> > >>>>> +
> > >>>>>         spin_lock(&inode->i_lock);
> > >>>>>         inode->i_blocks +=3D blocks_per_huge_page(hgmem->h);
> > >>>>>         spin_unlock(&inode->i_lock);
> > >>>>>
> > >>>>> -       return page_folio(requested_page);
> > >>>>> +       return folio;
> > >>>>> +}
> > >
> >

