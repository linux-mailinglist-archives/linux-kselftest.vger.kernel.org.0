Return-Path: <linux-kselftest+bounces-44203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3BFC162EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0353BBB16
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470D3469FE;
	Tue, 28 Oct 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SEZOAHHD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8819F115
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672822; cv=none; b=Q3Q6uVHo8876Y1vBNDkTsK7O3WQ5Pun7v+AcxfrOeHzkLtV0T6XY+WcQTSOnSRlTOi4CGALP2p8lJZEDTq3OMFnmXBD39M9/6EdcH+TGvi/5+mIfdXSuVXiHV/QPokuATys4KUHXNomaNfd2DMtRFSkDSkad+8gVTsB5Ouqhoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672822; c=relaxed/simple;
	bh=0d83xKYl1wQDmuK5SOzlObBg7g6kLf+TuqQJprxbfYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a61m1PuZBpikcZr72YrbeZNb3JdTdJCrxBOqhKw2sYlI/Ht7tSWEbRXBERvCof6Hbyt1TXTHKChsEDOGv1f0CwfrPHtR2MfJIX9qk3FzRqCfHgmWbaPjB0aT5ryS52V5j5s/yYHIS/YA7s1YkgjHO0xX8xFLFFSK8TlVNqVbx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SEZOAHHD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eccff716f4so27631cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761672819; x=1762277619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiMvzBWe7SjDMscpj3l62WNAaYy0ZgC7K7y+gnKoTyk=;
        b=SEZOAHHDKqGl8CNSr9ukLSBa6S1zr5Nz1RLTihq1AVImgDY/E79DVdcKPL1N+ww4QI
         LjZIa+LcpJbboLjMoK8pZXLFjVtXXjnVdC8euJK96eCbMDPUBuxk53xy5LryFtcNA8/3
         bLMfIi+ohYfZQtsLePFessM6wJ0+n0v3tOrydHimpchZovsdu4kIfy8rvi5H9ukv+Xk5
         HoDDI4+WJOYhJ/OYvOh/LcjB81srwpTMG4hm170+JWqddSQ6PT3OG5CdifzeKOUwB+0x
         budy6eU6ZxkZ/zSO/Jo4ku+t7rX7uaGEU245uWlODUA52J6UW+5eUktttEixYWv0e8TR
         w7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672819; x=1762277619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiMvzBWe7SjDMscpj3l62WNAaYy0ZgC7K7y+gnKoTyk=;
        b=vxEHQ09LV8r6JWeKikjImu78UD3kZ8GC2/U1XkNwMQXPTIMbn6KHL6Qmu0J1grorU9
         ElQHK+5174FHSseclVMnGnfYYKYTEsv4Tzzcy0P/PoBd3hbpRyfWwZ1ulUaNihd+ZwgL
         v4iqZwHs21AG4g9rFkOf2D408qTRbeI8PJs037gonRwx23D8nRy1HwDV+qAymFCq02N8
         WVxoCwuGJWTrRoBqVCySjEmRIUOBbcoD4bjBhpsw47Uwdyz2M3yRf7Q1fSS2z1EmO4iv
         wQIzY+TTjmR4AspggeRvQD0lIr9+rqWWqPfI2rMIVVmkLfbOuitMb2K2FDeaNcoSCfoV
         bO8w==
X-Forwarded-Encrypted: i=1; AJvYcCUTYOb/PA2jTfR7k9rXF/MU01ieSABdO1TywAjlJ5NfH/ZanK8oJXfd5HNoEclbzXXYYU0l+PlNM/lO7507T+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvFGd7/Gk3mQ8+nzNS2zD42AhFEhp46JOCe5EjcF7M9S1IR6X
	pSIxER8BmXJG96oe6pIpKpOrxA1j+LjuaBdel0r+HjXkPonIsEpD4X4wfanTs06+ULOyG6Gwjoq
	xIsYv+v5pj71RTfa3xaVWZ2Bipb4X6YrMy6EVCyKp
X-Gm-Gg: ASbGncv7NkeGNo+VVQoFSwPNPTvV7pQaiNficf6Qt9eXfu2Fcqf4g7nKEFQ8SRJ2Jlk
	moacr9Op4dw7/e4bOt3PoFtW6SZQqKQBOrMUMMUW4wEL7aSVxlptTLKYWIku1l8rzDfFQZ9fxA9
	o7RRj5qJe//hq5ZOHcG4QaZg1MItX7nc2078I4hKlE2xu0wB2pXEwr7iHVuO50+EdkxGh5reTD8
	1AwbR8tRsBM0MmF5BP0yzNm/XIu28UDYmB1Ciy1uOFGTHUf0L5w5aIT4kXbLgqYF/Q6hg2iDwxr
	EzvFmS7iw67VvZfE45l6K6nkxQ==
X-Google-Smtp-Source: AGHT+IEcICpr72thqlfGJHuQJHhO8Hak7s/s7V/6QRLg8bFH/QzOWFBGk0kFrXpHpcF0fPpQ/nWmsdRzlRZYsmt/giY=
X-Received: by 2002:a05:622a:1b20:b0:4eb:7681:d90 with SMTP id
 d75a77b69052e-4ed158ac668mr348861cf.16.1761672818575; Tue, 28 Oct 2025
 10:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <7-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <7-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 28 Oct 2025 10:33:26 -0700
X-Gm-Features: AWmQ_bnwc9wY_U0rvFSmlqfR3lhj-c_ni0ioHeLq90Ikj-KCeZjIcMtyHKyqPxA
Message-ID: <CAAywjhS+-CNXTR3_EpVjsie3bmz_2szBR7nh53hA-dWCm5j1kA@mail.gmail.com>
Subject: Re: [PATCH v7 07/15] iommupt: Add map_pages op
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:21=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> map is slightly complicated because it has to handle a number of special
> edge cases:
>  - Overmapping a previously shared, but now empty, table level with an OA=
.
>    Requries validating and freeing the possibly empty tables
>  - Doing the above across an entire to-be-created contiguous entry
>  - Installing a new shared table level concurrently with another thread
>  - Expanding the table by adding more top levels
>
> Table expansion is a unique feature of AMDv1, this version is quite
> similar except we handle racing concurrent lockless map. The table top
> pointer and starting level are encoded in a single uintptr_t which ensure=
s
> we can READ_ONCE() without tearing. Any op will do the READ_ONCE() and us=
e
> that fixed point as its starting point. Concurrent expansion is handled
> with a table global spinlock.
>
> When inserting a new table entry map checks that the entire portion of th=
e
> table is empty. This includes freeing any empty lower tables that will be
> overwritten by an OA. A separate free list is used while checking and
> collecting all the empty lower tables so that writing the new entry is
> uninterrupted, either the new entry fully writes or nothing changes.
>
> A special fast path for PAGE_SIZE is implemented that does a direct walk
> to the leaf level and installs a single entry. This gives ~15% improvemen=
t
> for iommu_map() when mapping lists of single pages.
>
> This version sits under the iommu_domain_ops as map_pages() but does not
> require the external page size calculation. The implementation is actuall=
y
> map_range() and can do arbitrary ranges, internally handling all the
> validation and supporting any arrangment of page sizes. A future series
> can optimize iommu_map() to take advantage of this.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 501 +++++++++++++++++++++++++++-
>  drivers/iommu/generic_pt/pt_iter.h  |   2 +-
>  include/linux/generic_pt/iommu.h    |  59 ++++
>  3 files changed, 560 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_=
pt/iommu_pt.h
> index e3d1b272723db0..f32e81509f4f09 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -91,6 +91,23 @@ static __maybe_unused int make_range_u64(struct pt_com=
mon *common,
>                 ret;                                                     =
\
>         })
>
> +static inline unsigned int compute_best_pgsize(struct pt_state *pts,
> +                                              pt_oaddr_t oa)
> +{
> +       struct pt_iommu *iommu_table =3D iommu_from_common(pts->range->co=
mmon);
> +
> +       if (!pt_can_have_leaf(pts))
> +               return 0;
> +
> +       /*
> +        * The page size is limited by the domain's bitmap. This allows t=
he core
> +        * code to reduce the supported page sizes by changing the bitmap=
.
> +        */
> +       return pt_compute_best_pgsize(pt_possible_sizes(pts) &
> +                                             iommu_table->domain.pgsize_=
bitmap,
> +                                     pts->range->va, pts->range->last_va=
, oa);
> +}
> +
>  static __always_inline int __do_iova_to_phys(struct pt_range *range, voi=
d *arg,
>                                              unsigned int level,
>                                              struct pt_table_p *table,
> @@ -147,6 +164,8 @@ EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERI=
C_PT_IOMMU");
>
>  struct pt_iommu_collect_args {
>         struct iommu_pages_list free_list;
> +       /* Fail if any OAs are within the range */
> +       u8 check_mapped : 1;
>  };
>
>  static int __collect_tables(struct pt_range *range, void *arg,
> @@ -156,7 +175,7 @@ static int __collect_tables(struct pt_range *range, v=
oid *arg,
>         struct pt_iommu_collect_args *collect =3D arg;
>         int ret;
>
> -       if (!pt_can_have_table(&pts))
> +       if (!collect->check_mapped && !pt_can_have_table(&pts))
>                 return 0;
>
>         for_each_pt_level_entry(&pts) {
> @@ -167,6 +186,8 @@ static int __collect_tables(struct pt_range *range, v=
oid *arg,
>                                 return ret;
>                         continue;
>                 }
> +               if (pts.type =3D=3D PT_ENTRY_OA && collect->check_mapped)
> +                       return -EADDRINUSE;
>         }
>         return 0;
>  }
> @@ -187,6 +208,477 @@ static inline struct pt_table_p *table_alloc_top(st=
ruct pt_common *common,
>                 log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
>  }
>
> +/* Allocate an interior table */
> +static inline struct pt_table_p *table_alloc(const struct pt_state *pare=
nt_pts,
> +                                            gfp_t gfp)
> +{
> +       struct pt_iommu *iommu_table =3D
> +               iommu_from_common(parent_pts->range->common);
> +       struct pt_state child_pts =3D
> +               pt_init(parent_pts->range, parent_pts->level - 1, NULL);
> +
> +       return iommu_alloc_pages_node_sz(
> +               iommu_table->nid, gfp,
> +               log2_to_int(pt_num_items_lg2(&child_pts) +
> +                           ilog2(PT_ITEM_WORD_SIZE)));
> +}
> +
> +static inline int pt_iommu_new_table(struct pt_state *pts,
> +                                    struct pt_write_attrs *attrs)
> +{
> +       struct pt_table_p *table_mem;
> +       phys_addr_t phys;
> +
> +       /* Given PA/VA/length can't be represented */
> +       if (PT_WARN_ON(!pt_can_have_table(pts)))
> +               return -ENXIO;
> +
> +       table_mem =3D table_alloc(pts, attrs->gfp);
> +       if (IS_ERR(table_mem))
> +               return PTR_ERR(table_mem);
> +
> +       phys =3D virt_to_phys(table_mem);
> +       if (!pt_install_table(pts, phys, attrs)) {
> +               iommu_free_pages(table_mem);
> +               return -EAGAIN;
> +       }
> +
> +       if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
> +               /*
> +                * The underlying table can't store the physical table ad=
dress.
> +                * This happens when kunit testing tables outside their n=
ormal
> +                * environment where a CPU might be limited.
> +                */
> +               pt_load_single_entry(pts);
> +               if (PT_WARN_ON(pt_table_pa(pts) !=3D phys)) {
> +                       pt_clear_entries(pts, ilog2(1));
> +                       iommu_free_pages(table_mem);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       pts->table_lower =3D table_mem;
> +       return 0;
> +}
> +
> +struct pt_iommu_map_args {
> +       struct iommu_iotlb_gather *iotlb_gather;
> +       struct pt_write_attrs attrs;
> +       pt_oaddr_t oa;
> +       unsigned int leaf_pgsize_lg2;
> +       unsigned int leaf_level;
> +};
> +
> +/*
> + * This will recursively check any tables in the block to validate they =
are
> + * empty and then free them through the gather.
> + */
> +static int clear_contig(const struct pt_state *start_pts,
> +                       struct iommu_iotlb_gather *iotlb_gather,
> +                       unsigned int step, unsigned int pgsize_lg2)
> +{
> +       struct pt_iommu *iommu_table =3D
> +               iommu_from_common(start_pts->range->common);
> +       struct pt_range range =3D *start_pts->range;
> +       struct pt_state pts =3D
> +               pt_init(&range, start_pts->level, start_pts->table);
> +       struct pt_iommu_collect_args collect =3D { .check_mapped =3D true=
 };
> +       int ret;
> +
> +       pts.index =3D start_pts->index;
> +       pts.end_index =3D start_pts->index + step;
> +       for (; _pt_iter_load(&pts); pt_next_entry(&pts)) {
> +               if (pts.type =3D=3D PT_ENTRY_TABLE) {
> +                       collect.free_list =3D
> +                               IOMMU_PAGES_LIST_INIT(collect.free_list);
> +                       ret =3D pt_walk_descend_all(&pts, __collect_table=
s,
> +                                                 &collect);
> +                       if (ret)
> +                               return ret;
> +
> +                       /*
> +                        * The table item must be cleared before we can u=
pdate
> +                        * the gather
> +                        */
> +                       pt_clear_entries(&pts, ilog2(1));
> +
> +                       iommu_pages_list_add(&collect.free_list,
> +                                            pt_table_ptr(&pts));
> +                       gather_range_pages(
> +                               iotlb_gather, iommu_table, range.va,
> +                               log2_to_int(pt_table_item_lg2sz(&pts)),
> +                               &collect.free_list);
> +               } else if (pts.type !=3D PT_ENTRY_EMPTY) {
> +                       return -EADDRINUSE;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int __map_range_leaf(struct pt_range *range, void *arg,
> +                           unsigned int level, struct pt_table_p *table)
> +{
> +       struct pt_state pts =3D pt_init(range, level, table);
> +       struct pt_iommu_map_args *map =3D arg;
> +       unsigned int leaf_pgsize_lg2 =3D map->leaf_pgsize_lg2;
> +       unsigned int start_index;
> +       pt_oaddr_t oa =3D map->oa;
> +       unsigned int step;
> +       bool need_contig;
> +       int ret =3D 0;
> +
> +       PT_WARN_ON(map->leaf_level !=3D level);
> +       PT_WARN_ON(!pt_can_have_leaf(&pts));
> +
> +       step =3D log2_to_int_t(unsigned int,
> +                            leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts))=
;
> +       need_contig =3D leaf_pgsize_lg2 !=3D pt_table_item_lg2sz(&pts);
> +
> +       _pt_iter_first(&pts);
> +       start_index =3D pts.index;
> +       do {
> +               pts.type =3D pt_load_entry_raw(&pts);
> +               if (pts.type !=3D PT_ENTRY_EMPTY || need_contig) {
> +                       if (pts.index !=3D start_index)
> +                               pt_index_to_va(&pts);
> +                       ret =3D clear_contig(&pts, map->iotlb_gather, ste=
p,
> +                                          leaf_pgsize_lg2);
> +                       if (ret)
> +                               break;
> +               }
> +
> +               if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
> +                       pt_index_to_va(&pts);
> +                       PT_WARN_ON(compute_best_pgsize(&pts, oa) !=3D
> +                                  leaf_pgsize_lg2);
> +               }
> +               pt_install_leaf_entry(&pts, oa, leaf_pgsize_lg2, &map->at=
trs);
> +
> +               oa +=3D log2_to_int(leaf_pgsize_lg2);
> +               pts.index +=3D step;
> +       } while (pts.index < pts.end_index);
> +
> +       map->oa =3D oa;
> +       return ret;
> +}
> +
> +static int __map_range(struct pt_range *range, void *arg, unsigned int l=
evel,
> +                      struct pt_table_p *table)
> +{
> +       struct pt_state pts =3D pt_init(range, level, table);
> +       struct pt_iommu_map_args *map =3D arg;
> +       int ret;
> +
> +       PT_WARN_ON(map->leaf_level =3D=3D level);
> +       PT_WARN_ON(!pt_can_have_table(&pts));
> +
> +       _pt_iter_first(&pts);
> +
> +       /* Descend to a child table */
> +       do {
> +               pts.type =3D pt_load_entry_raw(&pts);
> +
> +               if (pts.type !=3D PT_ENTRY_TABLE) {
> +                       if (pts.type !=3D PT_ENTRY_EMPTY)
> +                               return -EADDRINUSE;
> +                       ret =3D pt_iommu_new_table(&pts, &map->attrs);
> +                       if (ret) {
> +                               /*
> +                                * Racing with another thread installing =
a table
> +                                */
> +                               if (ret =3D=3D -EAGAIN)
> +                                       continue;
> +                               return ret;
> +                       }
> +               } else {
> +                       pts.table_lower =3D pt_table_ptr(&pts);
> +               }
> +
> +               /*
> +                * The already present table can possibly be shared with =
another
> +                * concurrent map.
> +                */
> +               if (map->leaf_level =3D=3D level - 1)
> +                       ret =3D pt_descend(&pts, arg, __map_range_leaf);
> +               else
> +                       ret =3D pt_descend(&pts, arg, __map_range);
> +               if (ret)
> +                       return ret;
> +
> +               pts.index++;
> +               pt_index_to_va(&pts);
> +               if (pts.index >=3D pts.end_index)
> +                       break;
> +       } while (true);
> +       return 0;
> +}
> +
> +/*
> + * Fast path for the easy case of mapping a 4k page to an already alloca=
ted
> + * table. This is a common workload. If it returns EAGAIN run the full a=
lgorithm
> + * instead.
> + */
> +static __always_inline int __do_map_single_page(struct pt_range *range,
> +                                               void *arg, unsigned int l=
evel,
> +                                               struct pt_table_p *table,
> +                                               pt_level_fn_t descend_fn)
> +{
> +       struct pt_state pts =3D pt_init(range, level, table);
> +       struct pt_iommu_map_args *map =3D arg;
> +
> +       pts.type =3D pt_load_single_entry(&pts);
> +       if (level =3D=3D 0) {
> +               if (pts.type !=3D PT_ENTRY_EMPTY)
> +                       return -EADDRINUSE;
> +               pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
> +                                     &map->attrs);
> +               map->oa +=3D PAGE_SIZE;
> +               return 0;
> +       }
> +       if (pts.type =3D=3D PT_ENTRY_TABLE)
> +               return pt_descend(&pts, arg, descend_fn);
> +       /* Something else, use the slow path */
> +       return -EAGAIN;
> +}
> +PT_MAKE_LEVELS(__map_single_page, __do_map_single_page);
> +
> +/*
> + * Add a table to the top, increasing the top level as much as necessary=
 to
> + * encompass range.
> + */
> +static int increase_top(struct pt_iommu *iommu_table, struct pt_range *r=
ange,
> +                       struct pt_iommu_map_args *map)
> +{
> +       struct iommu_pages_list free_list =3D IOMMU_PAGES_LIST_INIT(free_=
list);
> +       struct pt_common *common =3D common_from_iommu(iommu_table);
> +       uintptr_t top_of_table =3D READ_ONCE(common->top_of_table);
> +       uintptr_t new_top_of_table =3D top_of_table;
> +       struct pt_table_p *table_mem;
> +       unsigned int new_level;
> +       spinlock_t *domain_lock;
> +       unsigned long flags;
> +       int ret;
> +
> +       while (true) {
> +               struct pt_range top_range =3D
> +                       _pt_top_range(common, new_top_of_table);
> +               struct pt_state pts =3D pt_init_top(&top_range);
> +
> +               top_range.va =3D range->va;
> +               top_range.last_va =3D range->last_va;
> +
> +               if (!pt_check_range(&top_range) && map->leaf_level <=3D p=
ts.level)
> +                       break;
> +
> +               pts.level++;
> +               if (pts.level > PT_MAX_TOP_LEVEL ||
> +                   pt_table_item_lg2sz(&pts) >=3D common->max_vasz_lg2) =
{
> +                       ret =3D -ERANGE;
> +                       goto err_free;
> +               }
> +
> +               new_level =3D pts.level;
> +               table_mem =3D table_alloc_top(
> +                       common, _pt_top_set(NULL, pts.level), map->attrs.=
gfp);
> +               if (IS_ERR(table_mem))
> +                       return PTR_ERR(table_mem);
> +               iommu_pages_list_add(&free_list, table_mem);
> +
> +               /* The new table links to the lower table always at index=
 0 */
> +               top_range.va =3D 0;
> +               top_range.top_level =3D new_level;
> +               pts.table_lower =3D pts.table;
> +               pts.table =3D table_mem;
> +               pt_load_single_entry(&pts);
> +               PT_WARN_ON(pts.index !=3D 0);
> +               pt_install_table(&pts, virt_to_phys(pts.table_lower),
> +                                &map->attrs);
> +               new_top_of_table =3D _pt_top_set(pts.table, pts.level);
> +       }
> +
> +       /*
> +        * top_of_table is write locked by the spinlock, but readers can =
use
> +        * READ_ONCE() to get the value. Since we encode both the level a=
nd the
> +        * pointer in one quanta the lockless reader will always see some=
thing
> +        * valid. The HW must be updated to the new level under the spinl=
ock
> +        * before top_of_table is updated so that concurrent readers don'=
t map
> +        * into the new level until it is fully functional. If another th=
read
> +        * already updated it while we were working then throw everything=
 away
> +        * and try again.
> +        */
> +       domain_lock =3D iommu_table->driver_ops->get_top_lock(iommu_table=
);
> +       spin_lock_irqsave(domain_lock, flags);
> +       if (common->top_of_table !=3D top_of_table) {
> +               spin_unlock_irqrestore(domain_lock, flags);
> +               ret =3D -EAGAIN;
> +               goto err_free;
> +       }
> +
> +       /*
> +        * We do not issue any flushes for change_top on the expectation =
that
> +        * any walk cache will not become a problem by adding another lay=
er to
> +        * the tree. Misses will rewalk from the updated top pointer, hit=
s
> +        * continue to be correct. Negative caching is fine too since all=
 the
> +        * new IOVA added by the new top is non-present.
> +        */
> +       iommu_table->driver_ops->change_top(
> +               iommu_table, virt_to_phys(table_mem), new_level);
> +       WRITE_ONCE(common->top_of_table, new_top_of_table);
> +       spin_unlock_irqrestore(domain_lock, flags);
> +       return 0;
> +
> +err_free:
> +       iommu_put_pages_list(&free_list);
> +       return ret;
> +}
> +
> +static int check_map_range(struct pt_iommu *iommu_table, struct pt_range=
 *range,
> +                          struct pt_iommu_map_args *map)
> +{
> +       struct pt_common *common =3D common_from_iommu(iommu_table);
> +       int ret;
> +
> +       do {
> +               ret =3D pt_check_range(range);
> +               if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
> +                       return ret;
> +
> +               if (!ret && map->leaf_level <=3D range->top_level)
> +                       break;
> +
> +               ret =3D increase_top(iommu_table, range, map);
> +               if (ret && ret !=3D -EAGAIN)
> +                       return ret;
> +
> +               /* Reload the new top */
> +               *range =3D pt_make_range(common, range->va, range->last_v=
a);
> +       } while (ret);
> +       PT_WARN_ON(pt_check_range(range));
> +       return 0;
> +}
> +
> +static int do_map(struct pt_range *range, bool single_page,
> +                 struct pt_iommu_map_args *map)
> +{
> +       if (single_page) {
> +               int ret;
> +
> +               ret =3D pt_walk_range(range, __map_single_page, map);
> +               if (ret !=3D -EAGAIN)
> +                       return ret;
> +               /* EAGAIN falls through to the full path */
> +       }
> +
> +       if (map->leaf_level =3D=3D range->top_level)
> +               return pt_walk_range(range, __map_range_leaf, map);
> +       return pt_walk_range(range, __map_range, map);
> +}
> +
> +/**
> + * map_pages() - Install translation for an IOVA range
> + * @domain: Domain to manipulate
> + * @iova: IO virtual address to start
> + * @paddr: Physical/Output address to start
> + * @pgsize: Length of each page
> + * @pgcount: Length of the range in pgsize units starting from @iova
> + * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
> + * @gfp: GFP flags for any memory allocations
> + * @mapped: Total bytes successfully mapped
> + *
> + * The range starting at IOVA will have paddr installed into it. The cal=
ler
> + * must specify a valid pgsize and pgcount to segment the range into com=
patible
> + * blocks.
> + *
> + * On error the caller will probably want to invoke unmap on the range f=
rom iova
> + * up to the amount indicated by @mapped to return the table back to an
> + * unchanged state.
> + *
> + * Context: The caller must hold a write range lock that includes the wh=
ole
> + * range.
> + *
> + * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA t=
hat were
> + * mapped are added to @mapped, @mapped is not zerod first.
> + */
> +int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova=
,
> +                        phys_addr_t paddr, size_t pgsize, size_t pgcount=
,
> +                        int prot, gfp_t gfp, size_t *mapped)
> +{
> +       struct pt_iommu *iommu_table =3D
> +               container_of(domain, struct pt_iommu, domain);
> +       pt_vaddr_t pgsize_bitmap =3D iommu_table->domain.pgsize_bitmap;
> +       struct pt_common *common =3D common_from_iommu(iommu_table);
> +       struct iommu_iotlb_gather iotlb_gather;
> +       pt_vaddr_t len =3D pgsize * pgcount;
> +       struct pt_iommu_map_args map =3D {
> +               .iotlb_gather =3D &iotlb_gather,
> +               .oa =3D paddr,
> +               .leaf_pgsize_lg2 =3D vaffs(pgsize),
> +       };
> +       bool single_page =3D false;
> +       struct pt_range range;
> +       int ret;
> +
> +       iommu_iotlb_gather_init(&iotlb_gather);
> +
> +       if (WARN_ON(!(prot & (IOMMU_READ | IOMMU_WRITE))))
> +               return -EINVAL;
> +
> +       /* Check the paddr doesn't exceed what the table can store */
> +       if ((sizeof(pt_oaddr_t) < sizeof(paddr) &&
> +            (pt_vaddr_t)paddr > PT_VADDR_MAX) ||
> +           (common->max_oasz_lg2 !=3D PT_VADDR_MAX_LG2 &&
> +            oalog2_div(paddr, common->max_oasz_lg2)))
> +               return -ERANGE;
> +
> +       ret =3D pt_iommu_set_prot(common, &map.attrs, prot);
> +       if (ret)
> +               return ret;
> +       map.attrs.gfp =3D gfp;
> +
> +       ret =3D make_range_no_check(common, &range, iova, len);
> +       if (ret)
> +               return ret;
> +
> +       /* Calculate target page size and level for the leaves */
> +       if (pt_has_system_page_size(common) && pgsize =3D=3D PAGE_SIZE &&
> +           pgcount =3D=3D 1) {
> +               PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
> +               if (log2_mod(iova | paddr, PAGE_SHIFT))
> +                       return -ENXIO;
> +               map.leaf_pgsize_lg2 =3D PAGE_SHIFT;
> +               map.leaf_level =3D 0;
> +               single_page =3D true;
> +       } else {
> +               map.leaf_pgsize_lg2 =3D pt_compute_best_pgsize(
> +                       pgsize_bitmap, range.va, range.last_va, paddr);
> +               if (!map.leaf_pgsize_lg2)
> +                       return -ENXIO;
> +               map.leaf_level =3D
> +                       pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2)=
;
> +       }
> +
> +       ret =3D check_map_range(iommu_table, &range, &map);
> +       if (ret)
> +               return ret;
> +
> +       PT_WARN_ON(map.leaf_level > range.top_level);
> +
> +       ret =3D do_map(&range, single_page, &map);
> +
> +       /*
> +        * Table levels were freed and replaced with large items, flush a=
ny walk
> +        * cache that may refer to the freed levels.
> +        */
> +       if (!iommu_pages_list_empty(&iotlb_gather.freelist))
> +               iommu_iotlb_sync(&iommu_table->domain, &iotlb_gather);
> +
> +       /* Bytes successfully mapped */
> +       PT_WARN_ON(!ret && map.oa - paddr !=3D len);
> +       *mapped +=3D map.oa - paddr;
> +       return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
> +
>  struct pt_unmap_args {
>         struct iommu_pages_list free_list;
>         pt_vaddr_t unmapped;
> @@ -445,6 +937,7 @@ static void pt_iommu_zero(struct pt_iommu_table *fmt_=
table)
>         memset_after(fmt_table, 0, iommu.domain);
>
>         /* The caller can initialize some of these values */
> +       iommu_table->driver_ops =3D cfg.driver_ops;
>         iommu_table->nid =3D cfg.nid;
>  }
>
> @@ -478,6 +971,12 @@ int pt_iommu_init(struct pt_iommu_table *fmt_table,
>         if (ret)
>                 return ret;
>
> +       if (pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
> +           WARN_ON(!iommu_table->driver_ops ||
> +                   !iommu_table->driver_ops->change_top ||
> +                   !iommu_table->driver_ops->get_top_lock))
> +               return -EINVAL;
> +
>         if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
>             (pt_feature(common, PT_FEAT_FULL_VA) ||
>              pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
> diff --git a/drivers/iommu/generic_pt/pt_iter.h b/drivers/iommu/generic_p=
t/pt_iter.h
> index 87f4a26c1a417a..c0d8617cce2928 100644
> --- a/drivers/iommu/generic_pt/pt_iter.h
> +++ b/drivers/iommu/generic_pt/pt_iter.h
> @@ -612,7 +612,7 @@ static inline int __pt_make_level_fn_err(struct pt_ra=
nge *range, void *arg,
>   * This builds a function call tree that can be fully inlined.
>   * The caller must provide a function body in an __always_inline functio=
n::
>   *
> - *  static __always_inline int do(struct pt_range *range, void *arg,
> + *  static __always_inline int do_fn(struct pt_range *range, void *arg,
>   *         unsigned int level, struct pt_table_p *table,
>   *         pt_level_fn_t descend_fn)
>   *
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/=
iommu.h
> index ceb6bc9cea37cd..0d59423024d57f 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -11,6 +11,7 @@
>
>  struct iommu_iotlb_gather;
>  struct pt_iommu_ops;
> +struct pt_iommu_driver_ops;
>
>  /**
>   * DOC: IOMMU Radix Page Table
> @@ -43,6 +44,12 @@ struct pt_iommu {
>          */
>         const struct pt_iommu_ops *ops;
>
> +       /**
> +        * @driver_ops: Function pointers provided by the HW driver to he=
lp
> +        * manage HW details like caches.
> +        */
> +       const struct pt_iommu_driver_ops *driver_ops;
> +
>         /**
>          * @nid: Node ID to use for table memory allocations. The IOMMU d=
river
>          * may want to set the NID to the device's NID, if there are mult=
iple
> @@ -84,6 +91,53 @@ struct pt_iommu_ops {
>         void (*deinit)(struct pt_iommu *iommu_table);
>  };
>
> +/**
> + * struct pt_iommu_driver_ops - HW IOTLB cache flushing operations
> + *
> + * The IOMMU driver should implement these using container_of(iommu_tabl=
e) to
> + * get to it's iommu_domain derived structure. All ops can be called in =
atomic
> + * contexts as they are buried under DMA API calls.
> + */
> +struct pt_iommu_driver_ops {
> +       /**
> +        * @change_top: Update the top of table pointer
> +        * @iommu_table: Table to operate on
> +        * @top_paddr: New CPU physical address of the top pointer
> +        * @top_level: IOMMU PT level of the new top
> +        *
> +        * Called under the get_top_lock() spinlock. The driver must upda=
te all
> +        * HW references to this domain with a new top address and
> +        * configuration. On return mappings placed in the new top must b=
e
> +        * reachable by the HW.
> +        *
> +        * top_level encodes the level in IOMMU PT format, level 0 is the
> +        * smallest page size increasing from there. This has to be trans=
lated
> +        * to any HW specific format. During this call the new top will n=
ot be
> +        * visible to any other API.
> +        *
> +        * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required i=
f
> +        * enabled.
> +        */
> +       void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t top_=
paddr,
> +                          unsigned int top_level);
> +
> +       /**
> +        * @get_top_lock: lock to hold when changing the table top
> +        * @iommu_table: Table to operate on
> +        *
> +        * Return a lock to hold when changing the table top page table f=
rom
> +        * being stored in HW. The lock will be held prior to calling
> +        * change_top() and released once the top is fully visible.
> +        *
> +        * Typically this would be a lock that protects the iommu_domain'=
s
> +        * attachment list.
> +        *
> +        * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required i=
f
> +        * enabled.
> +        */
> +       spinlock_t *(*get_top_lock)(struct pt_iommu *iommu_table);
> +};
> +
>  static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
>  {
>         /*
> @@ -120,6 +174,10 @@ struct pt_iommu_cfg {
>  #define IOMMU_PROTOTYPES(fmt)                                           =
       \
>         phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *do=
main, \
>                                                   dma_addr_t iova);      =
      \
> +       int pt_iommu_##fmt##_map_pages(struct iommu_domain *domain,      =
      \
> +                                      unsigned long iova, phys_addr_t pa=
ddr,  \
> +                                      size_t pgsize, size_t pgcount,    =
      \
> +                                      int prot, gfp_t gfp, size_t *mappe=
d);   \
>         size_t pt_iommu_##fmt##_unmap_pages(                             =
      \
>                 struct iommu_domain *domain, unsigned long iova,         =
      \
>                 size_t pgsize, size_t pgcount,                           =
      \
> @@ -142,6 +200,7 @@ struct pt_iommu_cfg {
>   */
>  #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
>         .iova_to_phys =3D &pt_iommu_##fmt##_iova_to_phys, \
> +       .map_pages =3D &pt_iommu_##fmt##_map_pages,       \
>         .unmap_pages =3D &pt_iommu_##fmt##_unmap_pages
>
>  /*
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

