Return-Path: <linux-kselftest+bounces-44119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0285DC0F84B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DF7E4E385C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04B43126A2;
	Mon, 27 Oct 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQjHH5vd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC2301474
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584619; cv=none; b=TsPZ/Nu2c0ihmGX8Q2E+Pzgat1OZkjsbuscA7TaQI8Shp9PrWaUwgyLrTUQol9Z8nECm7to/6tiIjionk9sbUrMQXiy4yW2MXTk6E017X9X/VG/uvHryZ3kfGhztVluFteCwWCcAg1DqSLHM0oJDtQ/BjVJ+hOJ8aJQ99iJPHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584619; c=relaxed/simple;
	bh=76P57XRKfuzAKY1ciduC9CmiJBUvwKTZtkz3qwhdReE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWArevUs/12vAlOncr+AdmSJ+jv91RgoL5Sw6qxa7TsG1vs25+ClY/8JyTyPpl628PLkAVkh773S2xbppZ6ylSOwtABQRcHHKnlXT2CyzHNpa2U55souj3uaRVhqugIXpq1MaPAOdGDeftjh6K7pPivmKLP5P5UE12Mdbj2QhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQjHH5vd; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eccff716f4so17801cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761584616; x=1762189416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuBWyV8t5IpeOQdEx4tKo7eHcJ5gDZZkmJ8Q6d4IQxs=;
        b=SQjHH5vdDfQrMcEvDSkfF0LOtLgrZVCRUKP/U4O8kiZvO7EpTb6XRBJAWE4Vvo8b6u
         aX3DemEBulu2gHUjTQ2ULYdZObIOLCRU95liZWcHosEGbWLuhaPRXxydNOXuKaQLuycD
         TzTpqZcJ5IJTqppptW9RyFKAazVhIJkWHrdmjNzc5JyFHDv+E5BE7ZajMI9kO+AV7JW4
         VYGByQf9gXeAHjzbzHdI9pNufrt5IiapZsaBHzDGK3s2JT3dM7yzv8qhKNhgsj3OeSSI
         FnO5TEama3lm7wMQsW+NxID6epmKrDPY2l7AtcdR5eDOVTww2Jka7IeECPVzw2gtdJOv
         Z7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584616; x=1762189416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuBWyV8t5IpeOQdEx4tKo7eHcJ5gDZZkmJ8Q6d4IQxs=;
        b=FBPGxf8PdXdWJ0qLpZdnUVbYO1fZpdrRWA+1PvbR8mEfUF6hMz/ETQGYflZIlg2kQq
         Oe5RMkN2GdMgRMuO8ns28cUfTd82CJQO3+uLVzBvq37e40Qykh7g8Wg1l1ZlFR9Tq1r5
         McPnUw3louZhEQYCXlutk4mcNjj2XfjimPfhoNcgK3Jof3VSOnDofDllOnXcc5U+ExkW
         B6BSu+w/hU+/F1lsK8l6jjVKtEbH8A9UChZnPlALUOFDTgwBc/y1DsL/7YbPEFh08H53
         AT2PpV1uua9Tz+MIrrjNfv5VcQcjGGrF/nz3BS9I3426FdMUUUqmnQpwDPQbGJrmFqhk
         +/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVVKrgz/mtduwC7fcOH/SuOB/s9BrIErQiR9tF6XHHajTmvtAskfyRFqs2n+jZd6L8ibOrLCdcFmSeHPQ2eYu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1jPun++oAxvwxl7J9wa0p3G/b50aZr4V6FnDETyipbOzCYIh6
	9zOeTnxD6u2CiTsz9mzL3hsiIocN3LnfORwF6jT8oG8CVgwP8IKIVirYOMhpohIjRogHgiupyKz
	0/aZWgqa+wd9TR9c7KfnaZEt7tTHNDVDMPVRZK97v
X-Gm-Gg: ASbGnct7R6cADmx2W82RDpEsedeEJtmCC0yOjlLA23mtLtO6HxjFku2UItC5kiJhn2n
	yXZtTbIQG4YxaXHLIUgQyqqJaiHa2EH+QY5wjXFiK6mJinaIK2QSoMwf6rmVG7ciIyK8S3Z9Y3W
	Ym0MkrEaU7GE4ac0D3c/gb4Ag7WDk9etP9UCLEL9+2osd9peuMKhsF75DEhbCcgimRpVEZyU51m
	XsXP47aAJGIAAjhEt9CZQpM/0fkZOzDSBgUE+x8rQN2EWU5txVK6kTkoW/BlYmIedtd7f2vm5Iq
	Q6vQ026ON78YskE=
X-Google-Smtp-Source: AGHT+IFN9TFkidqfzRB2fPd/REPEcFZal1bmTvuVA0pkE0hW3jE0igGvK+Re1w0TU5MjhMypj3WmJMEqZCFYaAXuhjI=
X-Received: by 2002:a05:622a:1b20:b0:4e8:85ac:f7a7 with SMTP id
 d75a77b69052e-4ed06edaa9cmr1797841cf.9.1761584616175; Mon, 27 Oct 2025
 10:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <6-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <6-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 27 Oct 2025 10:03:24 -0700
X-Gm-Features: AWmQ_bkzqL1J7Dno0EwBGFLGJfK57ZidX1YETIjkkxZGoaq69GR5cYhgBr0TIiw
Message-ID: <CAAywjhQRTuXHGOmK90yL4iefVWCaUs_QgL6itgEy2n0fCzMYUw@mail.gmail.com>
Subject: Re: [PATCH v7 06/15] iommupt: Add unmap_pages op
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
> unmap_pages removes mappings and any fully contained interior tables from
> the given range. This follows the now-standard iommu_domain API definitio=
n
> where it does not split up larger page sizes into smaller. The caller mus=
t
> perform unmap only on ranges created by map or it must have somehow
> otherwise determined safe cut points (eg iommufd/vfio use iova_to_phys to
> scan for them)
>
> A future work will provide 'cut' which explicitly does the page size spli=
t
> if the HW can support it.
>
> unmap is implemented with a recursive descent of the tree. If the caller
> provides a VA range that spans an entire table item then the table memory
> can be freed as well.
>
> If an entire table item can be freed then this version will also check th=
e
> leaf-only level of the tree to ensure that all entries are present to
> generate -EINVAL. Many of the existing drivers don't do this extra check.
>
> This version sits under the iommu_domain_ops as unmap_pages() but does no=
t
> require the external page size calculation. The implementation is actuall=
y
> unmap_range() and can do arbitrary ranges, internally handling all the
> validation and supporting any arrangment of page sizes. A future series
> can optimize __iommu_unmap() to take advantage of this.
>
> Freed page table memory is batched up in the gather and will be freed in
> the driver's iotlb_sync() callback after the IOTLB flush completes.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 156 ++++++++++++++++++++++++++++
>  include/linux/generic_pt/iommu.h    |  10 +-
>  2 files changed, 164 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_=
pt/iommu_pt.h
> index 5ff1b887928a46..e3d1b272723db0 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -14,6 +14,29 @@
>  #include <linux/export.h>
>  #include <linux/iommu.h>
>  #include "../iommu-pages.h"
> +#include <linux/cleanup.h>
> +#include <linux/dma-mapping.h>
> +
> +static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
> +                              struct pt_iommu *iommu_table, pt_vaddr_t i=
ova,
> +                              pt_vaddr_t len,
> +                              struct iommu_pages_list *free_list)
> +{
> +       struct pt_common *common =3D common_from_iommu(iommu_table);
> +
> +       if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
> +           iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
> +               iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
> +               /*
> +                * Note that the sync frees the gather's free list, so we=
 must
> +                * not have any pages on that list that are covered by io=
va/len
> +                */
> +       } else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
> +               iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
> +       }
> +
> +       iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
> +}
>
>  #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
>
> @@ -164,6 +187,139 @@ static inline struct pt_table_p *table_alloc_top(st=
ruct pt_common *common,
>                 log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
>  }
>
> +struct pt_unmap_args {
> +       struct iommu_pages_list free_list;
> +       pt_vaddr_t unmapped;
> +};
> +
> +static __maybe_unused int __unmap_range(struct pt_range *range, void *ar=
g,
> +                                       unsigned int level,
> +                                       struct pt_table_p *table)
> +{
> +       struct pt_state pts =3D pt_init(range, level, table);
> +       struct pt_unmap_args *unmap =3D arg;
> +       unsigned int num_oas =3D 0;
> +       unsigned int start_index;
> +       int ret =3D 0;
> +
> +       _pt_iter_first(&pts);
> +       start_index =3D pts.index;
> +       pts.type =3D pt_load_entry_raw(&pts);
> +       /*
> +        * A starting index is in the middle of a contiguous entry
> +        *
> +        * The IOMMU API does not require drivers to support unmapping pa=
rts of
> +        * large pages. Long ago VFIO would try to split maps but the cur=
rent
> +        * version never does.
> +        *
> +        * Instead when unmap reaches a partial unmap of the start of a l=
arge
> +        * IOPTE it should remove the entire IOPTE and return that size t=
o the
> +        * caller.
> +        */
> +       if (pts.type =3D=3D PT_ENTRY_OA) {
> +               if (log2_mod(range->va, pt_entry_oa_lg2sz(&pts)))
> +                       return -EINVAL;
> +               /* Micro optimization */
> +               goto start_oa;
> +       }
> +
> +       do {
> +               if (pts.type !=3D PT_ENTRY_OA) {
> +                       bool fully_covered;
> +
> +                       if (pts.type !=3D PT_ENTRY_TABLE) {
> +                               ret =3D -EINVAL;
> +                               break;
> +                       }
> +
> +                       if (pts.index !=3D start_index)
> +                               pt_index_to_va(&pts);
> +                       pts.table_lower =3D pt_table_ptr(&pts);
> +
> +                       fully_covered =3D pt_entry_fully_covered(
> +                               &pts, pt_table_item_lg2sz(&pts));
> +
> +                       ret =3D pt_descend(&pts, arg, __unmap_range);
> +                       if (ret)
> +                               break;
> +
> +                       /*
> +                        * If the unmapping range fully covers the table =
then we
> +                        * can free it as well. The clear is delayed unti=
l we
> +                        * succeed in clearing the lower table levels.
> +                        */
> +                       if (fully_covered) {
> +                               iommu_pages_list_add(&unmap->free_list,
> +                                                    pts.table_lower);
> +                               pt_clear_entries(&pts, ilog2(1));
> +                       }
> +                       pts.index++;
> +               } else {
> +                       unsigned int num_contig_lg2;
> +start_oa:
> +                       /*
> +                        * If the caller requested an last that falls wit=
hin a
> +                        * single entry then the entire entry is unmapped=
 and
> +                        * the length returned will be larger than reques=
ted.
> +                        */
> +                       num_contig_lg2 =3D pt_entry_num_contig_lg2(&pts);
> +                       pt_clear_entries(&pts, num_contig_lg2);
> +                       num_oas +=3D log2_to_int(num_contig_lg2);
> +                       pts.index +=3D log2_to_int(num_contig_lg2);
> +               }
> +               if (pts.index >=3D pts.end_index)
> +                       break;
> +               pts.type =3D pt_load_entry_raw(&pts);
> +       } while (true);
> +
> +       unmap->unmapped +=3D log2_mul(num_oas, pt_table_item_lg2sz(&pts))=
;
> +       return ret;
> +}
> +
> +/**
> + * unmap_pages() - Make a range of IOVA empty/not present
> + * @domain: Domain to manipulate
> + * @iova: IO virtual address to start
> + * @pgsize: Length of each page
> + * @pgcount: Length of the range in pgsize units starting from @iova
> + * @iotlb_gather: Gather struct that must be flushed on return
> + *
> + * unmap_pages() will remove a translation created by map_pages(). It ca=
nnot
> + * subdivide a mapping created by map_pages(), so it should be called wi=
th IOVA
> + * ranges that match those passed to map_pages(). The IOVA range can agg=
regate
> + * contiguous map_pages() calls so long as no individual range is split.
> + *
> + * Context: The caller must hold a write range lock that includes
> + * the whole range.
> + *
> + * Returns: Number of bytes of VA unmapped. iova + res will be the point
> + * unmapping stopped.
> + */
> +size_t DOMAIN_NS(unmap_pages)(struct iommu_domain *domain, unsigned long=
 iova,
> +                             size_t pgsize, size_t pgcount,
> +                             struct iommu_iotlb_gather *iotlb_gather)
> +{
> +       struct pt_iommu *iommu_table =3D
> +               container_of(domain, struct pt_iommu, domain);
> +       struct pt_unmap_args unmap =3D { .free_list =3D IOMMU_PAGES_LIST_=
INIT(
> +                                              unmap.free_list) };
> +       pt_vaddr_t len =3D pgsize * pgcount;
> +       struct pt_range range;
> +       int ret;
> +
> +       ret =3D make_range(common_from_iommu(iommu_table), &range, iova, =
len);
> +       if (ret)
> +               return 0;
> +
> +       pt_walk_range(&range, __unmap_range, &unmap);
> +
> +       gather_range_pages(iotlb_gather, iommu_table, iova, len,
> +                          &unmap.free_list);
> +
> +       return unmap.unmapped;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unmap_pages), "GENERIC_PT_IOMMU");
> +
>  static void NS(get_info)(struct pt_iommu *iommu_table,
>                          struct pt_iommu_info *info)
>  {
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/=
iommu.h
> index 5622856e199881..ceb6bc9cea37cd 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -9,6 +9,7 @@
>  #include <linux/iommu.h>
>  #include <linux/mm_types.h>
>
> +struct iommu_iotlb_gather;
>  struct pt_iommu_ops;
>
>  /**
> @@ -119,6 +120,10 @@ struct pt_iommu_cfg {
>  #define IOMMU_PROTOTYPES(fmt)                                           =
       \
>         phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *do=
main, \
>                                                   dma_addr_t iova);      =
      \
> +       size_t pt_iommu_##fmt##_unmap_pages(                             =
      \
> +               struct iommu_domain *domain, unsigned long iova,         =
      \
> +               size_t pgsize, size_t pgcount,                           =
      \
> +               struct iommu_iotlb_gather *iotlb_gather);                =
      \
>         int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,          =
      \
>                                   const struct pt_iommu_##fmt##_cfg *cfg,=
      \
>                                   gfp_t gfp);                            =
      \
> @@ -135,8 +140,9 @@ struct pt_iommu_cfg {
>   * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops fo=
r the
>   * iommu_pt
>   */
> -#define IOMMU_PT_DOMAIN_OPS(fmt) \
> -       .iova_to_phys =3D &pt_iommu_##fmt##_iova_to_phys,
> +#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
> +       .iova_to_phys =3D &pt_iommu_##fmt##_iova_to_phys, \
> +       .unmap_pages =3D &pt_iommu_##fmt##_unmap_pages
>
>  /*
>   * The driver should setup its domain struct like
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

