Return-Path: <linux-kselftest+bounces-44120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ADAC0F8ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F5FB4F5C78
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACC53128A1;
	Mon, 27 Oct 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddygaZdy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2432F693F
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585091; cv=none; b=dcs7GkgZArox/r6ZboPtXzIa56sBCMnvy0RcIEBBjwh3kBzmDgzL4/4J341at7hFxHSzwCqiD/eDFXfo8IiF6DXpAGwDPVDACs+XANFqyBdLx9z/2kZhuy1QSdNXGb9NlAYwKnga06XZM6OfT1Dk4y3dqyvtzf/Zc+Qs8jCtMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585091; c=relaxed/simple;
	bh=J8ivzbU1Pp2OqalBPHzvW+ZBqRiBVxCwIlkRKZYdfyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VB0koEKOvqxsUcljZPeQnBRQlOvAKJzzenHTHZOBfXXXu7+dv29pVgNkzob9dy/mIYhpEeeNhForyyd/ucOYq68rjMgJqEQsneU9PttLEAqv1EAdilriIa5906f48WRjZtytWyekAPYVjJS/7HXyVmzHFvNWlsWhHk3ZtQm3Aqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddygaZdy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ecfd66059eso24531cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761585088; x=1762189888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkZmSx8dpTjoJY0itRm1I8yyUutbM3HifAA470MzOBE=;
        b=ddygaZdy2d8znzeSKb/+/fUZFjXezai7bBTLZ8L2CV+tknpPFUtnUFH/1+i3fUKif+
         jvBczY7pYOFA3mZLdAiQpa5ewDvHbSV/GDdbzLSSo3gQPnFbfAbvhdk8LGGpfBGK/khB
         S4Kmo6pcLeshLfgVFxkn3ry6cTWFekVRG9gRAK8bwcGyJzoWMYgzYo+q149T6iXX2H3J
         BfoKsL/d22PF8kSj/CvwoagVqG5Y38f4uglTrs5Zajow35dezrjnQGDbWhPY4l4Z3+p6
         Fbv1hJXxnoAnEid9kjwnbZdBQeRqunDAzcwCswrlxrFFmhpox6Su28d7a4H+jkZFTbml
         VBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585088; x=1762189888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkZmSx8dpTjoJY0itRm1I8yyUutbM3HifAA470MzOBE=;
        b=wT9kJd77w7uRLEtkJ9gNWt6VGSoGQFE2MO4z2aVBi7qETcHiaO/7yF2ZwECfmT3NKy
         3jwRn2A19ekKCAyJ+B0iSXdvbaqP98B1UMJk/k/dQ9iIo09WvevzLRcqp3zJ783ZnVgI
         mGkBaJi4+kfHNZ0ZceAm2/+9KUfgVpH0AHDu4rV4pwDt4LYZ2E1wd+N+1hXz06zrb8GP
         FEUPo/7NiHqc7pYJg/Fk2t7QLu1yi5LaEc7fkRI1Bh+uePfal32VZuiG6N6vlcHWqPkq
         MFQrkpEkOAkeQQIh8wYwclf+zm0q/sP4wnCK9HzXWQvnfAplUdF/VVpbP5G7xShCTQD0
         MTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkXIUqvPO11o/sC7iG9Yv6KJ0qm43EppYCP7wf7USqUbZ0aM43jRRgEI/Q4nk6m69QL/oXfiwIy6kvGksSZAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrIw28uuxDfDVlg//1RRT5s0svW2DjoFNqbPXYffx6AThiqD6
	ksijXEkxhN7yevd9f1mqT7glH1/ey2l+WxoLj6M/VYbYcjOly5gNR51myP7cMpEV/laHbRB6uFo
	PNT7eTkiBHNxvV8lT1z5C3JbB9s3QjxTfUme2I+b8
X-Gm-Gg: ASbGncto7tl+q2RVsGi5bLYHFiQMwubElfvReXUglYUVhGRlxlbl/sFVCHxlEL8V8FO
	npKMjyKBdvf6tKaNhJbdmllQzirEL6YZ63lPrg0K0oPz/KibOlHRGVPVOkKWzmqN0jZQhLNUv+f
	Gf0OGRMkR6JprKr91pUiMKJyONtXTNfwwryFA96TsyGw2xR4hAnCIHC50dP8IGF/DOxXZ4VQLI1
	XkCe/1de32YjXcyZD1uagjUPmAqFzxBI5cK786V0QLNn8w6pZ8yuKtZH5afs20cAz2hcQtRupQd
	4Qhuan1GMVTzvLgcI7t1e37rAw==
X-Google-Smtp-Source: AGHT+IFYZFQvUUcOg+pB8HvVWH4METdpuXNt2gqGTWS3aevv4uQCk/iv6mG/Y5YaeTAZw131jeBvrYZDxbIfiMD4pj0=
X-Received: by 2002:a05:622a:145:b0:4eb:75cb:a267 with SMTP id
 d75a77b69052e-4ed08f87205mr57611cf.12.1761585087737; Mon, 27 Oct 2025
 10:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <8-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <8-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 27 Oct 2025 10:11:16 -0700
X-Gm-Features: AWmQ_bnmBAjgowi7K5xJWke3P6tJnKzVPZ6u-N_-kXDu3goD3x7x_3nGpXOFItM
Message-ID: <CAAywjhREjVt00WeMXV=VDfdFCLh4YhGQQM3TJOU9sbzXeiX3zQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/15] iommupt: Add read_and_clear_dirty op
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
> IOMMU HW now supports updating a dirty bit in an entry when a DMA writes
> to the entry's VA range. iommufd has a uAPI to read and clear the dirty
> bits from the tables.
>
> This is a trivial recursive descent algorithm to read and optionally clea=
r
> the dirty bits. The format needs a function to tell if a contiguous entry
> is dirty, and a function to clear a contiguous entry back to clean.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 104 ++++++++++++++++++++++++++++
>  include/linux/generic_pt/iommu.h    |   6 ++
>  2 files changed, 110 insertions(+)
>
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_=
pt/iommu_pt.h
> index f32e81509f4f09..448c5796d4a861 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -162,6 +162,108 @@ phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_do=
main *domain,
>  }
>  EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
>
> +struct pt_iommu_dirty_args {
> +       struct iommu_dirty_bitmap *dirty;
> +       unsigned int flags;
> +};
> +
> +static void record_dirty(struct pt_state *pts,
> +                        struct pt_iommu_dirty_args *dirty,
> +                        unsigned int num_contig_lg2)
> +{
> +       pt_vaddr_t dirty_len;
> +
> +       if (num_contig_lg2 !=3D ilog2(1)) {
> +               unsigned int index =3D pts->index;
> +               unsigned int end_index =3D log2_set_mod_max_t(
> +                       unsigned int, pts->index, num_contig_lg2);
> +
> +               /* Adjust for being contained inside a contiguous page */
> +               end_index =3D min(end_index, pts->end_index);
> +               dirty_len =3D (end_index - index) *
> +                               log2_to_int(pt_table_item_lg2sz(pts));
> +       } else {
> +               dirty_len =3D log2_to_int(pt_table_item_lg2sz(pts));
> +       }
> +
> +       if (dirty->dirty->bitmap)
> +               iova_bitmap_set(dirty->dirty->bitmap, pts->range->va,
> +                               dirty_len);
> +
> +       if (!(dirty->flags & IOMMU_DIRTY_NO_CLEAR)) {
> +               pt_entry_make_write_clean(pts);
> +               iommu_iotlb_gather_add_range(dirty->dirty->gather,
> +                                            pts->range->va, dirty_len);
> +       }
> +}
> +
> +static inline int __read_and_clear_dirty(struct pt_range *range, void *a=
rg,
> +                                        unsigned int level,
> +                                        struct pt_table_p *table)
> +{
> +       struct pt_state pts =3D pt_init(range, level, table);
> +       struct pt_iommu_dirty_args *dirty =3D arg;
> +       int ret;
> +
> +       for_each_pt_level_entry(&pts) {
> +               if (pts.type =3D=3D PT_ENTRY_TABLE) {
> +                       ret =3D pt_descend(&pts, arg, __read_and_clear_di=
rty);
> +                       if (ret)
> +                               return ret;
> +                       continue;
> +               }
> +               if (pts.type =3D=3D PT_ENTRY_OA && pt_entry_is_write_dirt=
y(&pts))
> +                       record_dirty(&pts, dirty,
> +                                    pt_entry_num_contig_lg2(&pts));
> +       }
> +       return 0;
> +}
> +
> +/**
> + * read_and_clear_dirty() - Manipulate the HW set write dirty state
> + * @domain: Domain to manipulate
> + * @iova: IO virtual address to start
> + * @size: Length of the IOVA
> + * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
> + * @dirty: Place to store the dirty bits
> + *
> + * Iterate over all the entries in the mapped range and record their wri=
te dirty
> + * status in iommu_dirty_bitmap. If IOMMU_DIRTY_NO_CLEAR is not specifie=
d then
> + * the entries will be left dirty, otherwise they are returned to being =
not
> + * write dirty.
> + *
> + * Context: The caller must hold a read range lock that includes @iova.
> + *
> + * Returns: -ERRNO on failure, 0 on success.
> + */
> +int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
> +                                   unsigned long iova, size_t size,
> +                                   unsigned long flags,
> +                                   struct iommu_dirty_bitmap *dirty)
> +{
> +       struct pt_iommu *iommu_table =3D
> +               container_of(domain, struct pt_iommu, domain);
> +       struct pt_iommu_dirty_args dirty_args =3D {
> +               .dirty =3D dirty,
> +               .flags =3D flags,
> +       };
> +       struct pt_range range;
> +       int ret;
> +
> +#if !IS_ENABLED(CONFIG_IOMMUFD_DRIVER) || !defined(pt_entry_is_write_dir=
ty)
> +       return -EOPNOTSUPP;
> +#endif
> +
> +       ret =3D make_range(common_from_iommu(iommu_table), &range, iova, =
size);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D pt_walk_range(&range, __read_and_clear_dirty, &dirty_args=
);
> +       PT_WARN_ON(ret);
> +       return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(read_and_clear_dirty), "GENERIC_PT_IOMMU"=
);
> +
>  struct pt_iommu_collect_args {
>         struct iommu_pages_list free_list;
>         /* Fail if any OAs are within the range */
> @@ -1015,5 +1117,7 @@ EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_=
IOMMU");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PT=
PFX_RAW));
>  MODULE_IMPORT_NS("GENERIC_PT");
> +/* For iommu_dirty_bitmap_record() */
> +MODULE_IMPORT_NS("IOMMUFD");
>
>  #endif  /* __GENERIC_PT_IOMMU_PT_H */
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/=
iommu.h
> index 0d59423024d57f..03a906fbe12a83 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -12,6 +12,7 @@
>  struct iommu_iotlb_gather;
>  struct pt_iommu_ops;
>  struct pt_iommu_driver_ops;
> +struct iommu_dirty_bitmap;
>
>  /**
>   * DOC: IOMMU Radix Page Table
> @@ -182,6 +183,9 @@ struct pt_iommu_cfg {
>                 struct iommu_domain *domain, unsigned long iova,         =
      \
>                 size_t pgsize, size_t pgcount,                           =
      \
>                 struct iommu_iotlb_gather *iotlb_gather);                =
      \
> +       int pt_iommu_##fmt##_read_and_clear_dirty(                       =
      \
> +               struct iommu_domain *domain, unsigned long iova, size_t s=
ize,  \
> +               unsigned long flags, struct iommu_dirty_bitmap *dirty);  =
      \
>         int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,          =
      \
>                                   const struct pt_iommu_##fmt##_cfg *cfg,=
      \
>                                   gfp_t gfp);                            =
      \
> @@ -202,6 +206,8 @@ struct pt_iommu_cfg {
>         .iova_to_phys =3D &pt_iommu_##fmt##_iova_to_phys, \
>         .map_pages =3D &pt_iommu_##fmt##_map_pages,       \
>         .unmap_pages =3D &pt_iommu_##fmt##_unmap_pages
> +#define IOMMU_PT_DIRTY_OPS(fmt) \
> +       .read_and_clear_dirty =3D &pt_iommu_##fmt##_read_and_clear_dirty
>
>  /*
>   * The driver should setup its domain struct like
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

