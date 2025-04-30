Return-Path: <linux-kselftest+bounces-32046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB514AA5559
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 22:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D71A00515
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 20:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918AC289E04;
	Wed, 30 Apr 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8SX3GzO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8728468E
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043777; cv=none; b=fYTtFGHXv/Enk9boryfnL4NmlJpVV8SF0OnxXt3xk5plepD8i+38X0dNrVOgvMCf+hKILRfwqma7F8IGFOnmODg1fxbavobxGDmazV8yYw32ugZMaXpqnalvAg96LNICGY2areCasnzwg1wm6ntuEZ0Qf+i80NkQe2s6m9lLpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043777; c=relaxed/simple;
	bh=CthprGmrXS/ON0Pq0rm8yyd9RyM7waXfOJ/Qs2aNTbI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rcmt1bOiuUm0EDLl9xH8pdetr8ZR5B6hBB17vslNrigp2Lb0oDcOHo3T8xalcJPs4UTwNzdWXHzpGNkyC4MIHWQlT1Jgd5kRYOh9VnhIanlLZZlMFghQNJcHATXjEvzTAue8XzQshBunyLNGNJYZePYYQHWH/buG/09AqBxAmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8SX3GzO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00ce246e38so213866a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746043775; x=1746648575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roo9VbEUeuTY1fPaSMGBkZlZZtsYBcMbMprjUdRSI8w=;
        b=m8SX3GzOKDw8pEyl6NqsAO/yG/qoAqI8XzEIYOwBncOGkyO6J0N7K6C1HscJNLjqII
         wGgTP907TOdnLiAn55B6fFksdkJS28TWJuEnFaUQXoFEULERDx2wEwrnyPntYnkStVAT
         9s79m1/6bR2INMDGwGGpvb8KYWzKyeoRt5tpUqp0XRYi2v1cZygzl7AJTvK96IGCkK3O
         Q7Cmz/iouECf+qwttnQ5mzvwwj8GieMa/5QjMav232oV8Xf54GrLl+JXSPOQZkkHT1wP
         uC8zeF4ACxnemyZaRqG73NzFmVRUjYA+fTfs6uMHJ9lRFm+Gulz91a4c0ppZV0z0DdIY
         sW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746043775; x=1746648575;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=roo9VbEUeuTY1fPaSMGBkZlZZtsYBcMbMprjUdRSI8w=;
        b=sXWPRQUSGOKh5zO5o0mlSQtxvnhx45J1eDTOS2kHt9yZ8uBC+0TcljmnbXxzUzcyx5
         OzNjcvjMOijx6qRlC0Vxj6fBk4ts4K/dDGGI5qBOYr3IUHeQVroD76tyVws2osKctGD1
         RbVi7Dj6eNaA40rv8MgVzvujipnv4YkURs5X1HjIA/iHziYRCsgT5PLfhgBQxKWUmKOo
         QMLXUFTSnWXlhHfCAcVrwOVKiSufBmofXwdTKQVkqmZtzO1a6wulXGxwrQEO6DeVDKEk
         Mziub1KoZSHwznAuGgFJ/RCgRBW8w9K7VKgfvLef/eBC81GxqBe8O22fxeZFZCeA2KxR
         NCzg==
X-Forwarded-Encrypted: i=1; AJvYcCUaKTZnMNDan6+0BRYY6hbpDV/VctUW0OQXOtzb/P/l41hnbVzbjSF5HIuTLpQchrruC9kri6Be2t/aEOywRio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5jo8VgkY0jTVYeKvDqjruBREzADFZFNfvvkSg1qtANi8SudKU
	SdX2FWVMl42s51O2I7JdYILknUOLNTSjTJqp7dGgWU3kfrzEHGs2rcX33T9CrDba5eJClsg0/HW
	UWKU1bJF51uFXbS95pdc3AA==
X-Google-Smtp-Source: AGHT+IFBFEey+jz79g0x/N2Y9iwsRGWFSszUVDcZKaPJ2VRwyywiCnN6mK3lLG1CvDJudH65ioUy3VFbaqS30NNXvw==
X-Received: from pfjq6.prod.google.com ([2002:a05:6a00:886:b0:736:aaee:120e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a44:b0:1fe:90c5:7cee with SMTP id adf61e73a8af0-20aa438094emr6214425637.28.1746043774762;
 Wed, 30 Apr 2025 13:09:34 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:09:33 -0700
In-Reply-To: <aA7UXI0NB7oQQrL2@yzhao56-desk.sh.intel.com> (message from Yan
 Zhao on Mon, 28 Apr 2025 09:05:32 +0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqz4iy5xvgi.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically split/reconstruct
 HugeTLB page
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: vannapurve@google.com, chenyi.qiang@intel.com, tabba@google.com, 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Fri, Apr 25, 2025 at 03:45:20PM -0700, Ackerley Tng wrote:
>> Yan Zhao <yan.y.zhao@intel.com> writes:
>>=20
>> > On Thu, Apr 24, 2025 at 11:15:11AM -0700, Ackerley Tng wrote:
>> >> Vishal Annapurve <vannapurve@google.com> writes:
>> >>=20
>> >> > On Thu, Apr 24, 2025 at 1:15=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.=
com> wrote:
>> >> >>
>> >> >> On Thu, Apr 24, 2025 at 01:55:51PM +0800, Chenyi Qiang wrote:
>> >> >> >
>> >> >> >
>> >> >> > On 4/24/2025 12:25 PM, Yan Zhao wrote:
>> >> >> > > On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
>> >> >> > >> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
>> >> >> > >>> Yan Zhao <yan.y.zhao@intel.com> writes:
>> >> >> > >>>
>> >> >> > >>>> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrot=
e:
>> >> >> > >>>>> +/*
>> >> >> > >>>>> + * Allocates and then caches a folio in the filemap. Retu=
rns a folio with
>> >> >> > >>>>> + * refcount of 2: 1 after allocation, and 1 taken by the =
filemap.
>> >> >> > >>>>> + */
>> >> >> > >>>>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_fol=
io(struct inode *inode,
>> >> >> > >>>>> +                                                         =
  pgoff_t index)
>> >> >> > >>>>> +{
>> >> >> > >>>>> +       struct kvm_gmem_hugetlb *hgmem;
>> >> >> > >>>>> +       pgoff_t aligned_index;
>> >> >> > >>>>> +       struct folio *folio;
>> >> >> > >>>>> +       int nr_pages;
>> >> >> > >>>>> +       int ret;
>> >> >> > >>>>> +
>> >> >> > >>>>> +       hgmem =3D kvm_gmem_hgmem(inode);
>> >> >> > >>>>> +       folio =3D kvm_gmem_hugetlb_alloc_folio(hgmem->h, h=
gmem->spool);
>> >> >> > >>>>> +       if (IS_ERR(folio))
>> >> >> > >>>>> +               return folio;
>> >> >> > >>>>> +
>> >> >> > >>>>> +       nr_pages =3D 1UL << huge_page_order(hgmem->h);
>> >> >> > >>>>> +       aligned_index =3D round_down(index, nr_pages);
>> >> >> > >>>> Maybe a gap here.
>> >> >> > >>>>
>> >> >> > >>>> When a guest_memfd is bound to a slot where slot->base_gfn =
is not aligned to
>> >> >> > >>>> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G =
aligned, the
>> >> >> > >>>> corresponding GFN is not 2M/1G aligned.
>> >> >> > >>>
>> >> >> > >>> Thanks for looking into this.
>> >> >> > >>>
>> >> >> > >>> In 1G page support for guest_memfd, the offset and size are =
always
>> >> >> > >>> hugepage aligned to the hugepage size requested at guest_mem=
fd creation
>> >> >> > >>> time, and it is true that when binding to a memslot, slot->b=
ase_gfn and
>> >> >> > >>> slot->npages may not be hugepage aligned.
>> >> >> > >>>
>> >> >> > >>>>
>> >> >> > >>>> However, TDX requires that private huge pages be 2M aligned=
 in GFN.
>> >> >> > >>>>
>> >> >> > >>>
>> >> >> > >>> IIUC other factors also contribute to determining the mappin=
g level in
>> >> >> > >>> the guest page tables, like lpage_info and .private_max_mapp=
ing_level()
>> >> >> > >>> in kvm_x86_ops.
>> >> >> > >>>
>> >> >> > >>> If slot->base_gfn and slot->npages are not hugepage aligned,=
 lpage_info
>> >> >> > >>> will track that and not allow faulting into guest page table=
s at higher
>> >> >> > >>> granularity.
>> >> >> > >>
>> >> >> > >> lpage_info only checks the alignments of slot->base_gfn and
>> >> >> > >> slot->base_gfn + npages. e.g.,
>> >> >> > >>
>> >> >> > >> if slot->base_gfn is 8K, npages is 8M, then for this slot,
>> >> >> > >> lpage_info[2M][0].disallow_lpage =3D 1, which is for GFN [4K,=
 2M+8K);
>> >> >> > >> lpage_info[2M][1].disallow_lpage =3D 0, which is for GFN [2M+=
8K, 4M+8K);
>> >> >> > >> lpage_info[2M][2].disallow_lpage =3D 0, which is for GFN [4M+=
8K, 6M+8K);
>> >> >> > >> lpage_info[2M][3].disallow_lpage =3D 1, which is for GFN [6M+=
8K, 8M+8K);
>> >> >> >
>> >> >> > Should it be?
>> >> >> > lpage_info[2M][0].disallow_lpage =3D 1, which is for GFN [8K, 2M=
);
>> >> >> > lpage_info[2M][1].disallow_lpage =3D 0, which is for GFN [2M, 4M=
);
>> >> >> > lpage_info[2M][2].disallow_lpage =3D 0, which is for GFN [4M, 6M=
);
>> >> >> > lpage_info[2M][3].disallow_lpage =3D 0, which is for GFN [6M, 8M=
);
>> >> >> > lpage_info[2M][4].disallow_lpage =3D 1, which is for GFN [8M, 8M=
+8K);
>> >> >> Right. Good catch. Thanks!
>> >> >>
>> >> >> Let me update the example as below:
>> >> >> slot->base_gfn is 2 (for GPA 8KB), npages 2000 (for a 8MB range)
>> >> >>
>> >> >> lpage_info[2M][0].disallow_lpage =3D 1, which is for GPA [8KB, 2MB=
);
>> >> >> lpage_info[2M][1].disallow_lpage =3D 0, which is for GPA [2MB, 4MB=
);
>> >> >> lpage_info[2M][2].disallow_lpage =3D 0, which is for GPA [4MB, 6MB=
);
>> >> >> lpage_info[2M][3].disallow_lpage =3D 0, which is for GPA [6MB, 8MB=
);
>> >> >> lpage_info[2M][4].disallow_lpage =3D 1, which is for GPA [8MB, 8MB=
+8KB);
>> >> >>
>> >> >> lpage_info indicates that a 2MB mapping is alllowed to cover GPA 4=
MB and GPA
>> >> >> 4MB+16KB. However, their aligned_index values lead guest_memfd to =
allocate two
>> >> >> 2MB folios, whose physical addresses may not be contiguous.
>> >> >>
>> >> >> Additionally, if the guest accesses two GPAs, e.g., GPA 2MB+8KB an=
d GPA 4MB,
>> >> >> KVM could create two 2MB mappings to cover GPA ranges [2MB, 4MB), =
[4MB, 6MB).
>> >> >> However, guest_memfd just allocates the same 2MB folio for both fa=
ults.
>> >> >>
>> >> >>
>> >> >> >
>> >> >> > >>
>> >> >> > >>   ---------------------------------------------------------
>> >> >> > >>   |          |  |          |  |          |  |          |  |
>> >> >> > >>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+=
8K
>> >> >> > >>
>> >> >> > >> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2=
M][2], huge
>> >> >> > >> page is allowed. Also, they have the same aligned_index 2 in =
guest_memfd.
>> >> >> > >> So, guest_memfd allocates the same huge folio of 2M order for=
 them.
>> >> >> > > Sorry, sent too fast this morning. The example is not right. T=
he correct
>> >> >> > > one is:
>> >> >> > >
>> >> >> > > For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is all=
owed. So,
>> >> >> > > KVM will create a 2M mapping for them.
>> >> >> > >
>> >> >> > > However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspo=
nd to the
>> >> >> > > same 2M folio and physical addresses may not be contiguous.
>> >> >
>> >> > Then during binding, guest memfd offset misalignment with hugepage
>> >> > should be same as gfn misalignment. i.e.
>> >> >
>> >> > (offset & ~huge_page_mask(h)) =3D=3D ((slot->base_gfn << PAGE_SHIFT=
) &
>> >> > ~huge_page_mask(h));
>> >> >
>> >> > For non guest_memfd backed scenarios, KVM allows slot gfn ranges th=
at
>> >> > are not hugepage aligned, so guest_memfd should also be able to
>> >> > support non-hugepage aligned memslots.
>> >> >
>> >>=20
>> >> I drew up a picture [1] which hopefully clarifies this.
>> >>=20
>> >> Thanks for pointing this out, I understand better now and we will add=
 an
>> >> extra constraint during memslot binding of guest_memfd to check that =
gfn
>> >> offsets within a hugepage must be guest_memfd offsets.
>> > I'm a bit confused.
>> >
>> > As "index =3D gfn - slot->base_gfn + slot->gmem.pgoff", do you mean yo=
u are going
>> > to force "slot->base_gfn =3D=3D slot->gmem.pgoff" ?
>> >
>> > For some memory region, e.g., "pc.ram", it's divided into 2 parts:
>> > - one with offset 0, size 0x80000000(2G),
>> >   positioned at GPA 0, which is below GPA 4G;
>> > - one with offset 0x80000000(2G), size 0x80000000(2G),
>> >   positioned at GPA 0x100000000(4G), which is above GPA 4G.
>> >
>> > For the second part, its slot->base_gfn is 0x100000000, while slot->gm=
em.pgoff
>> > is 0x80000000.
>> >
>>=20
>> Nope I don't mean to enforce that they are equal, we just need the
>> offsets within the page to be equal.
>>=20
>> I edited Vishal's code snippet, perhaps it would help explain better:
>>=20
>> page_size is the size of the hugepage, so in our example,
>>=20
>>   page_size =3D SZ_2M;
>>   page_mask =3D ~(page_size - 1);
> page_mask =3D page_size - 1  ?
>

Yes, thank you!

>>   offset_within_page =3D slot->gmem.pgoff & page_mask;
>>   gfn_within_page =3D (slot->base_gfn << PAGE_SHIFT) & page_mask;
>>=20
>> We will enforce that
>>=20
>>   offset_within_page =3D=3D gfn_within_page;
> For "pc.ram", if it has 2.5G below 4G, it would be configured as follows
> - slot 1: slot->gmem.pgoff=3D0, base GPA 0, size=3D2.5G
> - slot 2: slot->gmem.pgoff=3D2.5G, base GPA 4G, size=3D1.5G
>
> When binding these two slots to the same guest_memfd created with flag
> KVM_GUEST_MEMFD_HUGE_1GB:=20
> - binding the 1st slot will succeed;
> - binding the 2nd slot will fail.
>
> What options does userspace have in this scenario?
> It can't reduce the flag to KVM_GUEST_MEMFD_HUGE_2MB. Adjusting the gmem.=
pgoff
> isn't ideal either.
>
> What about something similar as below?
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index d2feacd14786..87c33704a748 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1842,8 +1842,16 @@ __kvm_gmem_get_pfn(struct file *file, struct kvm_m=
emory_slot *slot,
>         }
>
>         *pfn =3D folio_file_pfn(folio, index);
> -       if (max_order)
> -               *max_order =3D folio_order(folio);
> +       if (max_order) {
> +               int order;
> +
> +               order =3D folio_order(folio);
> +
> +               while (order > 0 && ((slot->base_gfn ^ slot->gmem.pgoff) =
& ((1 << order) - 1)))
> +                       order--;
> +
> +               *max_order =3D order;
> +       }
>
>         *is_prepared =3D folio_test_uptodate(folio);
>         return folio;
>

Vishal was wondering how this is working before guest_memfd was
introduced, for other backing memory like HugeTLB.

I then poked around and found this [1]. I will be adding a similar check
for any slot where kvm_slot_can_be_private(slot).

Yan, that should work, right?

[1] https://github.com/torvalds/linux/blob/b6ea1680d0ac0e45157a819c41b46565=
f4616186/arch/x86/kvm/x86.c#L12996

>> >> Adding checks at binding time will allow hugepage-unaligned offsets (=
to
>> >> be at parity with non-guest_memfd backing memory) but still fix this
>> >> issue.
>> >>=20
>> >> lpage_info will make sure that ranges near the bounds will be
>> >> fragmented, but the hugepages in the middle will still be mappable as
>> >> hugepages.
>> >>=20
>> >> [1] https://lpc.events/event/18/contributions/1764/attachments/1409/3=
706/binding-must-have-same-alignment.svg

