Return-Path: <linux-kselftest+bounces-31667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91DA9D5D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 00:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4F21BA764D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 22:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9BC2957C7;
	Fri, 25 Apr 2025 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nj5kVxPf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF5241674
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621124; cv=none; b=i9VgbdmROK2HiYkxm0/6VgsU1BL25mJ8nErOsp3hHu5xTu+6aw70PAK0JYamX10npxHXvqJvDYGFLSpGhSvvw1kNzvd6/Ol6p72AMu+OKHK4SrqHel11rXlnz+4sJU2gvoXunxyXwt5WiH1z0AQ5OD4MXOfbFfxGrW+A0O+tw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621124; c=relaxed/simple;
	bh=DxjFR1cfA5b/PMiVtDs1ZU6V7y+Bn41BSCBzUEdn1eA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QSRGIifxJItkpCzWWjT1tK3xQcEJZX0QjwfyLQRptHsixbXs/eWXwhSznTY0qOZTjCWUJprAqVf2lbNtNVc5EIkV4b5EQ9MDu4+n3pZhoHClFDmqpE/zD+gbl3VjZpjbsxIY2aQctmtbGYunL5Bg7q+XayPFnW7Etx63HZMYjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nj5kVxPf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c7df9b6cso3703922b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745621122; x=1746225922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkZO4mi4lxG/wlqj2CFwXmhdIEjDtuyovfVkgLxS/v0=;
        b=nj5kVxPfkMKgTF7dr8aD9uMz5x8dB+me4BVEf7aO6gtx0OTQWZKKo9Ll+DawLvl7sb
         ZHhw3xGQyi4Ax1a923kjBOe9BQM1DVpwkG76ZtB9jr6YGWAmB/IXBMLOr4ezFgWLGPmD
         HCnhuY7bmIczJSh01yZBUVJylwkyT5UFZD7ox+RcmGL6OpnZQ1ytqTGdveobQQ9LBwHK
         vjJqX/fkE4Viifz5sJG6pk8hvXIdjQMxsH15bts1HYI99Kv0qZLb+UWU3qgrkLZyDisO
         RRlzucWMmHaQDdtuzU49c84aMbLnEJqKaMCVcclbEfNietiJgTGovWhHXWiUDZVL7lUh
         TgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745621122; x=1746225922;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PkZO4mi4lxG/wlqj2CFwXmhdIEjDtuyovfVkgLxS/v0=;
        b=f/pEKaJy7Fa2s44+JK1SOoeKh+XYUdKAh9DhcXK/ybyIrLDh/MYP34QAr/OjEHEchF
         Si9RoUtnKuau7P5/ToeCTBobcsCqzjobVHOlQbl7HzoihmC5aPUBsvi04pU445wNotBP
         eLs+/NL1rQnGmRqSuHlUjxk/F/7PDubnpkP3I303FsxQveCdjgTc7OpsEm5/u/uj3eMO
         WgOGQaOKSW7Mn/9un70vy+OXF57/XdDPbzf97KJJb6KPRIeHWip/U4pGH0+xpsV15tGe
         TmL2lD3MWRzjhul7vdvMXe3epLQl6mPCYVfD4LtT8uDhzYUHK6p7Ozsv+GDfOUcg/Jqm
         EiLA==
X-Forwarded-Encrypted: i=1; AJvYcCVt/j50MeQePTHoou2E+/TkjH9XEQV5n11Oe6FQzpj5E4/W6uwfmXiuOVEOXroR68YgP4JO/MvWFQ5pg/mRaiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bx3HqqWBJOAAHWBjSZeUvUo0VQ9Itr8ag1hrUhA7xJz/iBK/
	1QH2jWkrriMuuLhIB5KDHI5ukOORnCMm2AcotYOqJNOo1HD8IjZ9zxrfsMl8u0hlDUDc5x7Qi7p
	n7Cfw8ZlIMoMasjVK0qPYKQ==
X-Google-Smtp-Source: AGHT+IGmnJ65gmKyA3VF08u0JIu1lEdKstgsWN4dMP/m3HjVmCFFs4RaXPIOere/UVmxFSjxhjf6/nl08qkJgAlx8w==
X-Received: from pfbky4.prod.google.com ([2002:a05:6a00:6f44:b0:73e:1a21:4bb9])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:228a:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-73ff72e4055mr1450296b3a.14.1745621122037;
 Fri, 25 Apr 2025 15:45:22 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:45:20 -0700
In-Reply-To: <aAsJZuLjOAYriz8v@yzhao56-desk.sh.intel.com>
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
 <diqz7c39zas0.fsf@ackerleytng-ctop.c.googlers.com> <aAsJZuLjOAYriz8v@yzhao56-desk.sh.intel.com>
Message-ID: <diqzwmb7yi67.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically split/reconstruct
 HugeTLB page
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, Chenyi Qiang <chenyi.qiang@intel.com>, tabba@google.com, 
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

> On Thu, Apr 24, 2025 at 11:15:11AM -0700, Ackerley Tng wrote:
>> Vishal Annapurve <vannapurve@google.com> writes:
>>=20
>> > On Thu, Apr 24, 2025 at 1:15=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com=
> wrote:
>> >>
>> >> On Thu, Apr 24, 2025 at 01:55:51PM +0800, Chenyi Qiang wrote:
>> >> >
>> >> >
>> >> > On 4/24/2025 12:25 PM, Yan Zhao wrote:
>> >> > > On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
>> >> > >> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
>> >> > >>> Yan Zhao <yan.y.zhao@intel.com> writes:
>> >> > >>>
>> >> > >>>> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
>> >> > >>>>> +/*
>> >> > >>>>> + * Allocates and then caches a folio in the filemap. Returns=
 a folio with
>> >> > >>>>> + * refcount of 2: 1 after allocation, and 1 taken by the fil=
emap.
>> >> > >>>>> + */
>> >> > >>>>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(=
struct inode *inode,
>> >> > >>>>> +                                                           p=
goff_t index)
>> >> > >>>>> +{
>> >> > >>>>> +       struct kvm_gmem_hugetlb *hgmem;
>> >> > >>>>> +       pgoff_t aligned_index;
>> >> > >>>>> +       struct folio *folio;
>> >> > >>>>> +       int nr_pages;
>> >> > >>>>> +       int ret;
>> >> > >>>>> +
>> >> > >>>>> +       hgmem =3D kvm_gmem_hgmem(inode);
>> >> > >>>>> +       folio =3D kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgme=
m->spool);
>> >> > >>>>> +       if (IS_ERR(folio))
>> >> > >>>>> +               return folio;
>> >> > >>>>> +
>> >> > >>>>> +       nr_pages =3D 1UL << huge_page_order(hgmem->h);
>> >> > >>>>> +       aligned_index =3D round_down(index, nr_pages);
>> >> > >>>> Maybe a gap here.
>> >> > >>>>
>> >> > >>>> When a guest_memfd is bound to a slot where slot->base_gfn is =
not aligned to
>> >> > >>>> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G ali=
gned, the
>> >> > >>>> corresponding GFN is not 2M/1G aligned.
>> >> > >>>
>> >> > >>> Thanks for looking into this.
>> >> > >>>
>> >> > >>> In 1G page support for guest_memfd, the offset and size are alw=
ays
>> >> > >>> hugepage aligned to the hugepage size requested at guest_memfd =
creation
>> >> > >>> time, and it is true that when binding to a memslot, slot->base=
_gfn and
>> >> > >>> slot->npages may not be hugepage aligned.
>> >> > >>>
>> >> > >>>>
>> >> > >>>> However, TDX requires that private huge pages be 2M aligned in=
 GFN.
>> >> > >>>>
>> >> > >>>
>> >> > >>> IIUC other factors also contribute to determining the mapping l=
evel in
>> >> > >>> the guest page tables, like lpage_info and .private_max_mapping=
_level()
>> >> > >>> in kvm_x86_ops.
>> >> > >>>
>> >> > >>> If slot->base_gfn and slot->npages are not hugepage aligned, lp=
age_info
>> >> > >>> will track that and not allow faulting into guest page tables a=
t higher
>> >> > >>> granularity.
>> >> > >>
>> >> > >> lpage_info only checks the alignments of slot->base_gfn and
>> >> > >> slot->base_gfn + npages. e.g.,
>> >> > >>
>> >> > >> if slot->base_gfn is 8K, npages is 8M, then for this slot,
>> >> > >> lpage_info[2M][0].disallow_lpage =3D 1, which is for GFN [4K, 2M=
+8K);
>> >> > >> lpage_info[2M][1].disallow_lpage =3D 0, which is for GFN [2M+8K,=
 4M+8K);
>> >> > >> lpage_info[2M][2].disallow_lpage =3D 0, which is for GFN [4M+8K,=
 6M+8K);
>> >> > >> lpage_info[2M][3].disallow_lpage =3D 1, which is for GFN [6M+8K,=
 8M+8K);
>> >> >
>> >> > Should it be?
>> >> > lpage_info[2M][0].disallow_lpage =3D 1, which is for GFN [8K, 2M);
>> >> > lpage_info[2M][1].disallow_lpage =3D 0, which is for GFN [2M, 4M);
>> >> > lpage_info[2M][2].disallow_lpage =3D 0, which is for GFN [4M, 6M);
>> >> > lpage_info[2M][3].disallow_lpage =3D 0, which is for GFN [6M, 8M);
>> >> > lpage_info[2M][4].disallow_lpage =3D 1, which is for GFN [8M, 8M+8K=
);
>> >> Right. Good catch. Thanks!
>> >>
>> >> Let me update the example as below:
>> >> slot->base_gfn is 2 (for GPA 8KB), npages 2000 (for a 8MB range)
>> >>
>> >> lpage_info[2M][0].disallow_lpage =3D 1, which is for GPA [8KB, 2MB);
>> >> lpage_info[2M][1].disallow_lpage =3D 0, which is for GPA [2MB, 4MB);
>> >> lpage_info[2M][2].disallow_lpage =3D 0, which is for GPA [4MB, 6MB);
>> >> lpage_info[2M][3].disallow_lpage =3D 0, which is for GPA [6MB, 8MB);
>> >> lpage_info[2M][4].disallow_lpage =3D 1, which is for GPA [8MB, 8MB+8K=
B);
>> >>
>> >> lpage_info indicates that a 2MB mapping is alllowed to cover GPA 4MB =
and GPA
>> >> 4MB+16KB. However, their aligned_index values lead guest_memfd to all=
ocate two
>> >> 2MB folios, whose physical addresses may not be contiguous.
>> >>
>> >> Additionally, if the guest accesses two GPAs, e.g., GPA 2MB+8KB and G=
PA 4MB,
>> >> KVM could create two 2MB mappings to cover GPA ranges [2MB, 4MB), [4M=
B, 6MB).
>> >> However, guest_memfd just allocates the same 2MB folio for both fault=
s.
>> >>
>> >>
>> >> >
>> >> > >>
>> >> > >>   ---------------------------------------------------------
>> >> > >>   |          |  |          |  |          |  |          |  |
>> >> > >>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K
>> >> > >>
>> >> > >> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][=
2], huge
>> >> > >> page is allowed. Also, they have the same aligned_index 2 in gue=
st_memfd.
>> >> > >> So, guest_memfd allocates the same huge folio of 2M order for th=
em.
>> >> > > Sorry, sent too fast this morning. The example is not right. The =
correct
>> >> > > one is:
>> >> > >
>> >> > > For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is allowe=
d. So,
>> >> > > KVM will create a 2M mapping for them.
>> >> > >
>> >> > > However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspond =
to the
>> >> > > same 2M folio and physical addresses may not be contiguous.
>> >
>> > Then during binding, guest memfd offset misalignment with hugepage
>> > should be same as gfn misalignment. i.e.
>> >
>> > (offset & ~huge_page_mask(h)) =3D=3D ((slot->base_gfn << PAGE_SHIFT) &
>> > ~huge_page_mask(h));
>> >
>> > For non guest_memfd backed scenarios, KVM allows slot gfn ranges that
>> > are not hugepage aligned, so guest_memfd should also be able to
>> > support non-hugepage aligned memslots.
>> >
>>=20
>> I drew up a picture [1] which hopefully clarifies this.
>>=20
>> Thanks for pointing this out, I understand better now and we will add an
>> extra constraint during memslot binding of guest_memfd to check that gfn
>> offsets within a hugepage must be guest_memfd offsets.
> I'm a bit confused.
>
> As "index =3D gfn - slot->base_gfn + slot->gmem.pgoff", do you mean you a=
re going
> to force "slot->base_gfn =3D=3D slot->gmem.pgoff" ?
>
> For some memory region, e.g., "pc.ram", it's divided into 2 parts:
> - one with offset 0, size 0x80000000(2G),
>   positioned at GPA 0, which is below GPA 4G;
> - one with offset 0x80000000(2G), size 0x80000000(2G),
>   positioned at GPA 0x100000000(4G), which is above GPA 4G.
>
> For the second part, its slot->base_gfn is 0x100000000, while slot->gmem.=
pgoff
> is 0x80000000.
>

Nope I don't mean to enforce that they are equal, we just need the
offsets within the page to be equal.

I edited Vishal's code snippet, perhaps it would help explain better:

page_size is the size of the hugepage, so in our example,

  page_size =3D SZ_2M;
  page_mask =3D ~(page_size - 1);
  offset_within_page =3D slot->gmem.pgoff & page_mask;
  gfn_within_page =3D (slot->base_gfn << PAGE_SHIFT) & page_mask;

We will enforce that

  offset_within_page =3D=3D gfn_within_page;

>> Adding checks at binding time will allow hugepage-unaligned offsets (to
>> be at parity with non-guest_memfd backing memory) but still fix this
>> issue.
>>=20
>> lpage_info will make sure that ranges near the bounds will be
>> fragmented, but the hugepages in the middle will still be mappable as
>> hugepages.
>>=20
>> [1] https://lpc.events/event/18/contributions/1764/attachments/1409/3706=
/binding-must-have-same-alignment.svg

