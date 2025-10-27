Return-Path: <linux-kselftest+bounces-44113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 289AEC0F626
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D461346600
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B2D30AD05;
	Mon, 27 Oct 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjH6zRtS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A11A0BD0
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583263; cv=none; b=sQcGr8Lvby8gt22ZDQmwL/YPM5wfQLZiSXpJQuUw72hQSuL6slMHxQL/UpTgXS9HrKegd4EkEgxXuzjVOlIcHFFIJEf0+HYro0MrKn6ePo8mqz3O+Upf8ypUdXSQwFCyeK361HK9VCCS0tYlqYrOLEKHLv7QWBGaZafpyFGKfOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583263; c=relaxed/simple;
	bh=D8UPoMBwKMkQOuaWIzAtC142JZ62C6YLuEivCxvON6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRXdYLx89nnKVvxaeMMZnrBKczWlksc+Sw6JWCwmQB0SqZGOlywTMzxGZn11tRf7XCslaHb+jQL/AT/xvaPJfK8iayJi4YyA3DCAkKLAdAuV5sxkYblXWiTgvrBd2NRNOf1aEWn+K3oVLemspwzYKvaMrrOLfTvG8Vu4VDEAiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jjH6zRtS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ea12242d2eso768491cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761583260; x=1762188060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjyLAjxO5hHO7ixMNIg9+bv9DOY+PUgT/+rZoJKCGaU=;
        b=jjH6zRtSb88ex63trPN1t0iAT6afatqGvJ2gs7RBIVfS/+koNmdLcg6yLSOpgh6Bir
         4wNfmNGF+SBpMESHP17ECnpn2n2ocAI59dFx96Oj+/BAWkMx+QtOFHOu7hXBfBjun9o/
         vPDirrDZGUcIeHxAUx1f/3yXygEkIZz6k7VBVFbJXM2yJ+fkmHF7w8Zxo93xIU9Tb1Xk
         81Lxk+2p+KfJDRjqXB20Y/4o9dqkJOpgPzqnW30TH2GVHiu06L3zQAEjd1j5g5zvRFUt
         Cf4Uq6Ub4VL7Poq/q/9L3YSBI0pXHMlhml7svKPDRAvXZDBYgzoOiTyOJrG8Wsw+NHvk
         yFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583260; x=1762188060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjyLAjxO5hHO7ixMNIg9+bv9DOY+PUgT/+rZoJKCGaU=;
        b=EW1KSKz6qGDQergVPoRGs1nCfg3oCMNWcDctLKZTMfEmiezSepiSRIxwHmWIKTilUh
         z+DZxqhhi3utvn0Q1pEXKLn3xNMw82HF/5Fxx6mtx3q56sLF1dj/9OE2dhCuiDwaUAf7
         mPJ6kJFaE3Eyf62zBhuQ6oTXHEzJQEdT1MahkcND+NJSa9KXkflMPA2w2qbuFxi0oPV9
         HteJpyvgnOYkcCg9JtAZIprZJjvXCI8Z4Uya/RvIsOlymxnyv5Opiw+I4BXqUWJvDMUh
         vLYBJzV8mOrf4iybpvZ3K9Sxkn5tCDTcNN9W9uydlevMCzy3OYuBPhBNXCAdHEtWs5Ou
         j1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCX+sOvdC7JwKIeoes0E1pHKMhaXAI6DgvYkuCNWgyhiY+9KJt5HJInqIEhtPXpoxYf2J78PcEJfT636IxhMJtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzEnhO1tBAnqGvQ7zAh+u/r50KeyTHLbkjVrPR0oFQXhfMuDM
	rJtunEiPd2c+xX+5YSTF6WSRRsXUPioTGEMK0+iQGxYOAC7wbxFjgX01biDMgbAaNqJeGCbp5Lh
	IzzUfxDZBImU5dC1Snazu2DU4OH229QZiLnhFLqt2
X-Gm-Gg: ASbGncta5eXwfEExajxxKHJLiG5uO9waN7M40uvE2Aw+HhKBaglaATK04ICQy6mFru7
	HUJqrezCCHeGfWs8vV684ooCFEb9/QJXVzDEiT2brWOGZLyxSo0oBOtnh7OEEI7jsueenwGA7SU
	aY0ss1H1tCsPzb7Mvfic439AeVlQJHNue5ivUTv5HSmuf59H/feVQBLJ16eidVh+WoLtAwXjV6W
	ZztKwX9XJor8KN/a72yE4bxyoJ+wuneT7JPsSMuSdRb8MlwPGfhaM0KBMDVgcUG5LK6665GjqH3
	98Bq73ef8J8txqSHITBQ+NCxMg==
X-Google-Smtp-Source: AGHT+IGPh7EG1rpqd7n2qUyVKQ2wi4WO29+UH2FJVEt712groOxKuJiscnTbDVpqQmrbeasERumfWJ5zFJyny1Y4PhQ=
X-Received: by 2002:a05:622a:2ca:b0:4eb:75cb:a267 with SMTP id
 d75a77b69052e-4eba22f2116mr11509791cf.12.1761583259316; Mon, 27 Oct 2025
 09:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <3-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <3-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 27 Oct 2025 09:40:48 -0700
X-Gm-Features: AWmQ_bkjs7VT7cxewkjW7D6lOVADSh57SY4ZJ9RmZRxSGpqm1mvc_AdNM4QWKR0
Message-ID: <CAAywjhQSkmN-jG-ephdWpFh5+r1uMu86PY4XWRm+ngbSTXX=hw@mail.gmail.com>
Subject: Re: [PATCH v7 03/15] iommupt: Add the basic structure of the iommu implementation
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
> The existing IOMMU page table implementations duplicate all of the workin=
g
> algorithms for each format. By using the generic page table API a single =
C
> version of the IOMMU algorithms can be created and re-used for all of the
> different formats used in the drivers. The implementation will provide a
> single C version of the iommu domain operations: iova_to_phys, map, unmap=
,
> and read_and_clear_dirty.
>
> Further, adding new algorithms and techniques becomes easy to do across
> the entire fleet of drivers and formats.
>
> The C functions are drop in compatible with the existing iommu_domain_ops
> using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
> compilation unit will produce exported symbols following the pattern
> pt_iommu_FMT_map_pages() which the macro directly maps to the
> iommu_domain_ops members. This avoids the additional function pointer
> indirection like io-pgtable has.
>
> The top level struct used by the drivers is pt_iommu_table_FMT. It
> contains the other structs to allow container_of() to move between the
> driver, iommu page table, generic page table, and generic format layers.
>
>    struct pt_iommu_table_amdv1 {
>        struct pt_iommu {
>               struct iommu_domain domain;
>        } iommu;
>        struct pt_amdv1 {
>               struct pt_common common;
>        } amdpt;
>    };
>
> The driver is expected to union the pt_iommu_table_FMT with its own
> existing domain struct:
>
>    struct driver_domain {
>        union {
>                struct iommu_domain domain;
>                struct pt_iommu_table_amdv1 amdv1;
>        };
>    };
>    PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);
>
> To create an alias to avoid renaming 'domain' in a lot of driver code.
>
> This allows all the layers to access all the necessary functions to
> implement their different roles with no change to any of the existing
> iommu core code.
>
> Implement the basic starting point: pt_iommu_init(), get_info() and
> deinit().
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/Kconfig              |  13 +
>  drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
>  drivers/iommu/generic_pt/iommu_pt.h           | 259 ++++++++++++++++++
>  include/linux/generic_pt/iommu.h              | 150 ++++++++++
>  4 files changed, 461 insertions(+)
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
>  create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
>  create mode 100644 include/linux/generic_pt/iommu.h
>
> diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/=
Kconfig
> index fb0f431ddba0a8..a81dfdd72ca016 100644
> --- a/drivers/iommu/generic_pt/Kconfig
> +++ b/drivers/iommu/generic_pt/Kconfig
> @@ -17,4 +17,17 @@ config DEBUG_GENERIC_PT
>           kernels.
>
>           The kunit tests require this to be enabled to get full coverage=
.
> +
> +config IOMMU_PT
> +       tristate "IOMMU Page Tables"
> +       select IOMMU_API
> +       depends on IOMMU_SUPPORT
> +       depends on GENERIC_PT
> +       help
> +         Generic library for building IOMMU page tables
> +
> +         IOMMU_PT provides an implementation of the page table operation=
s
> +         related to struct iommu_domain using GENERIC_PT. It provides a =
single
> +         implementation of the page table operations that can be shared =
by
> +         multiple drivers.
>  endif
> diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iomm=
u/generic_pt/fmt/iommu_template.h
> new file mode 100644
> index 00000000000000..5b631bc07cbc16
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * Template to build the iommu module and kunit from the format and
> + * implementation headers.
> + *
> + * The format should have:
> + *  #define PT_FMT <name>
> + *  #define PT_SUPPORTED_FEATURES (BIT(PT_FEAT_xx) | BIT(PT_FEAT_yy))
> + * And optionally:
> + *  #define PT_FORCE_ENABLED_FEATURES ..
> + *  #define PT_FMT_VARIANT <suffix>
> + */
> +#include <linux/args.h>
> +#include <linux/stringify.h>
> +
> +#ifdef PT_FMT_VARIANT
> +#define PTPFX_RAW \
> +       CONCATENATE(CONCATENATE(PT_FMT, _), PT_FMT_VARIANT)
> +#else
> +#define PTPFX_RAW PT_FMT
> +#endif
> +
> +#define PTPFX CONCATENATE(PTPFX_RAW, _)
> +
> +#define _PT_FMT_H PT_FMT.h
> +#define PT_FMT_H __stringify(_PT_FMT_H)
> +
> +#define _PT_DEFS_H CONCATENATE(defs_, _PT_FMT_H)
> +#define PT_DEFS_H __stringify(_PT_DEFS_H)
> +
> +#include <linux/generic_pt/common.h>
> +#include PT_DEFS_H
> +#include "../pt_defs.h"
> +#include PT_FMT_H
> +#include "../pt_common.h"
> +
> +#include "../iommu_pt.h"
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_=
pt/iommu_pt.h
> new file mode 100644
> index 00000000000000..564f2d3a6e11e1
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -0,0 +1,259 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * "Templated C code" for implementing the iommu operations for page tab=
les.
> + * This is compiled multiple times, over all the page table formats to p=
ick up
> + * the per-format definitions.
> + */
> +#ifndef __GENERIC_PT_IOMMU_PT_H
> +#define __GENERIC_PT_IOMMU_PT_H
> +
> +#include "pt_iter.h"
> +
> +#include <linux/export.h>
> +#include <linux/iommu.h>
> +#include "../iommu-pages.h"
> +
> +#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
> +
> +struct pt_iommu_collect_args {
> +       struct iommu_pages_list free_list;
> +};
> +
> +static int __collect_tables(struct pt_range *range, void *arg,
> +                           unsigned int level, struct pt_table_p *table)
> +{
> +       struct pt_state pts =3D pt_init(range, level, table);
> +       struct pt_iommu_collect_args *collect =3D arg;
> +       int ret;
> +
> +       if (!pt_can_have_table(&pts))
> +               return 0;
> +
> +       for_each_pt_level_entry(&pts) {
> +               if (pts.type =3D=3D PT_ENTRY_TABLE) {
> +                       iommu_pages_list_add(&collect->free_list, pts.tab=
le_lower);
> +                       ret =3D pt_descend(&pts, arg, __collect_tables);
> +                       if (ret)
> +                               return ret;
> +                       continue;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static inline struct pt_table_p *table_alloc_top(struct pt_common *commo=
n,
> +                                                uintptr_t top_of_table,
> +                                                gfp_t gfp)
> +{
> +       struct pt_iommu *iommu_table =3D iommu_from_common(common);
> +
> +       /*
> +        * Top doesn't need the free list or otherwise, so it technically
> +        * doesn't need to use iommu pages. Use the API anyhow as the top=
 is
> +        * usually not smaller than PAGE_SIZE to keep things simple.
> +        */
> +       return iommu_alloc_pages_node_sz(
> +               iommu_table->nid, gfp,
> +               log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
> +}
> +
> +static void NS(get_info)(struct pt_iommu *iommu_table,
> +                        struct pt_iommu_info *info)
> +{
> +       struct pt_common *common =3D common_from_iommu(iommu_table);
> +       struct pt_range range =3D pt_top_range(common);
> +       struct pt_state pts =3D pt_init_top(&range);
> +       pt_vaddr_t pgsize_bitmap =3D 0;
> +
> +       if (pt_feature(common, PT_FEAT_DYNAMIC_TOP)) {
> +               for (pts.level =3D 0; pts.level <=3D PT_MAX_TOP_LEVEL;
> +                    pts.level++) {
> +                       if (pt_table_item_lg2sz(&pts) >=3D common->max_va=
sz_lg2)
> +                               break;
> +                       pgsize_bitmap |=3D pt_possible_sizes(&pts);
> +               }
> +       } else {
> +               for (pts.level =3D 0; pts.level <=3D range.top_level; pts=
.level++)
> +                       pgsize_bitmap |=3D pt_possible_sizes(&pts);
> +       }
> +
> +       /* Hide page sizes larger than the maximum OA */
> +       info->pgsize_bitmap =3D oalog2_mod(pgsize_bitmap, common->max_oas=
z_lg2);
> +}
> +
> +static void NS(deinit)(struct pt_iommu *iommu_table)
> +{
> +       struct pt_common *common =3D common_from_iommu(iommu_table);
> +       struct pt_range range =3D pt_all_range(common);
> +       struct pt_iommu_collect_args collect =3D {
> +               .free_list =3D IOMMU_PAGES_LIST_INIT(collect.free_list),
> +       };
> +
> +       iommu_pages_list_add(&collect.free_list, range.top_table);
> +       pt_walk_range(&range, __collect_tables, &collect);
> +
> +       /*
> +        * The driver has to already have fenced the HW access to the pag=
e table
> +        * and invalidated any caching referring to this memory.
> +        */
> +       iommu_put_pages_list(&collect.free_list);
> +}
> +
> +static const struct pt_iommu_ops NS(ops) =3D {
> +       .get_info =3D NS(get_info),
> +       .deinit =3D NS(deinit),
> +};
> +
> +static int pt_init_common(struct pt_common *common)
> +{
> +       struct pt_range top_range =3D pt_top_range(common);
> +
> +       if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
> +               return -EINVAL;
> +
> +       if (top_range.top_level =3D=3D PT_MAX_TOP_LEVEL ||
> +           common->max_vasz_lg2 =3D=3D top_range.max_vasz_lg2)
> +               common->features &=3D ~BIT(PT_FEAT_DYNAMIC_TOP);
> +
> +       if (top_range.max_vasz_lg2 =3D=3D PT_VADDR_MAX_LG2)
> +               common->features |=3D BIT(PT_FEAT_FULL_VA);
> +
> +       /* Requested features must match features compiled into this form=
at */
> +       if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
> +           (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
> +            (common->features & PT_FORCE_ENABLED_FEATURES) !=3D
> +                    PT_FORCE_ENABLED_FEATURES))
> +               return -EOPNOTSUPP;
> +
> +       if (common->max_oasz_lg2 =3D=3D 0)
> +               common->max_oasz_lg2 =3D pt_max_oa_lg2(common);
> +       else
> +               common->max_oasz_lg2 =3D min(common->max_oasz_lg2,
> +                                          pt_max_oa_lg2(common));
> +       return 0;
> +}
> +
> +static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
> +                               struct iommu_domain *domain)
> +{
> +       struct pt_common *common =3D common_from_iommu(iommu_table);
> +       struct pt_iommu_info info;
> +       struct pt_range range;
> +
> +       NS(get_info)(iommu_table, &info);
> +
> +       domain->type =3D __IOMMU_DOMAIN_PAGING;
> +       domain->pgsize_bitmap =3D info.pgsize_bitmap;
> +
> +       if (pt_feature(common, PT_FEAT_DYNAMIC_TOP))
> +               range =3D _pt_top_range(common,
> +                                     _pt_top_set(NULL, PT_MAX_TOP_LEVEL)=
);
> +       else
> +               range =3D pt_top_range(common);
> +
> +       /* A 64-bit high address space table on a 32-bit system cannot wo=
rk. */
> +       domain->geometry.aperture_start =3D (unsigned long)range.va;
> +       if ((pt_vaddr_t)domain->geometry.aperture_start !=3D range.va)
> +               return -EOVERFLOW;
> +
> +       /*
> +        * The aperture is limited to what the API can do after consideri=
ng all
> +        * the different types dma_addr_t/unsigned long/pt_vaddr_t that a=
re used
> +        * to store a VA. Set the aperture to something that is valid for=
 all
> +        * cases. Saturate instead of truncate the end if the types are s=
maller
> +        * than the top range. aperture_end should be called aperture_las=
t.
> +        */
> +       domain->geometry.aperture_end =3D (unsigned long)range.last_va;
> +       if ((pt_vaddr_t)domain->geometry.aperture_end !=3D range.last_va)=
 {
> +               domain->geometry.aperture_end =3D ULONG_MAX;
> +               domain->pgsize_bitmap &=3D ULONG_MAX;
> +       }
> +       domain->geometry.force_aperture =3D true;
> +
> +       return 0;
> +}
> +
> +static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
> +{
> +       struct pt_iommu *iommu_table =3D &fmt_table->iommu;
> +       struct pt_iommu cfg =3D *iommu_table;
> +
> +       static_assert(offsetof(struct pt_iommu_table, iommu.domain) =3D=
=3D 0);
> +       memset_after(fmt_table, 0, iommu.domain);
> +
> +       /* The caller can initialize some of these values */
> +       iommu_table->nid =3D cfg.nid;
> +}
> +
> +#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
> +#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)
> +
> +int pt_iommu_init(struct pt_iommu_table *fmt_table,
> +                 const struct pt_iommu_table_cfg *cfg, gfp_t gfp)
> +{
> +       struct pt_iommu *iommu_table =3D &fmt_table->iommu;
> +       struct pt_common *common =3D common_from_iommu(iommu_table);
> +       struct pt_table_p *table_mem;
> +       int ret;
> +
> +       if (cfg->common.hw_max_vasz_lg2 > PT_MAX_VA_ADDRESS_LG2 ||
> +           !cfg->common.hw_max_vasz_lg2 || !cfg->common.hw_max_oasz_lg2)
> +               return -EINVAL;
> +
> +       pt_iommu_zero(fmt_table);
> +       common->features =3D cfg->common.features;
> +       common->max_vasz_lg2 =3D cfg->common.hw_max_vasz_lg2;
> +       common->max_oasz_lg2 =3D cfg->common.hw_max_oasz_lg2;
> +       ret =3D pt_iommu_fmt_init(fmt_table, cfg);
> +       if (ret)
> +               return ret;
> +
> +       if (cfg->common.hw_max_oasz_lg2 > pt_max_oa_lg2(common))
> +               return -EINVAL;
> +
> +       ret =3D pt_init_common(common);
> +       if (ret)
> +               return ret;
> +
> +       if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
> +           (pt_feature(common, PT_FEAT_FULL_VA) ||
> +            pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
> +               return -EINVAL;
> +
> +       ret =3D pt_iommu_init_domain(iommu_table, &iommu_table->domain);
> +       if (ret)
> +               return ret;
> +
> +       table_mem =3D table_alloc_top(common, common->top_of_table, gfp);
> +       if (IS_ERR(table_mem))
> +               return PTR_ERR(table_mem);
> +       pt_top_set(common, table_mem, pt_top_get_level(common));
> +
> +       /* Must be last, see pt_iommu_deinit() */
> +       iommu_table->ops =3D &NS(ops);
> +       return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(pt_iommu_init, "GENERIC_PT_IOMMU");
> +
> +#ifdef pt_iommu_fmt_hw_info
> +#define pt_iommu_table_hw_info CONCATENATE(pt_iommu_table, _hw_info)
> +#define pt_iommu_hw_info CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), hw_i=
nfo)
> +void pt_iommu_hw_info(struct pt_iommu_table *fmt_table,
> +                     struct pt_iommu_table_hw_info *info)
> +{
> +       struct pt_iommu *iommu_table =3D &fmt_table->iommu;
> +       struct pt_common *common =3D common_from_iommu(iommu_table);
> +       struct pt_range top_range =3D pt_top_range(common);
> +
> +       pt_iommu_fmt_hw_info(fmt_table, &top_range, info);
> +}
> +EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
> +#endif
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PT=
PFX_RAW));
> +MODULE_IMPORT_NS("GENERIC_PT");
> +
> +#endif  /* __GENERIC_PT_IOMMU_PT_H */
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/=
iommu.h
> new file mode 100644
> index 00000000000000..defa96abc49781
> --- /dev/null
> +++ b/include/linux/generic_pt/iommu.h
> @@ -0,0 +1,150 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + */
> +#ifndef __GENERIC_PT_IOMMU_H
> +#define __GENERIC_PT_IOMMU_H
> +
> +#include <linux/generic_pt/common.h>
> +#include <linux/iommu.h>
> +#include <linux/mm_types.h>
> +
> +struct pt_iommu_ops;
> +
> +/**
> + * DOC: IOMMU Radix Page Table
> + *
> + * The IOMMU implementation of the Generic Page Table provides an ops st=
ruct
> + * that is useful to go with an iommu_domain to serve the DMA API, IOMMU=
FD and
> + * the generic map/unmap interface.
> + *
> + * This interface uses a caller provided locking approach. The caller mu=
st have
> + * a VA range lock concept that prevents concurrent threads from calling=
 ops on
> + * the same VA. Generally the range lock must be at least as large as a =
single
> + * map call.
> + */
> +
> +/**
> + * struct pt_iommu - Base structure for IOMMU page tables
> + *
> + * The format-specific struct will include this as the first member.
> + */
> +struct pt_iommu {
> +       /**
> +        * @domain: The core IOMMU domain. The driver should use a union =
to
> +        * overlay this memory with its previously existing domain struct=
 to
> +        * create an alias.
> +        */
> +       struct iommu_domain domain;
> +
> +       /**
> +        * @ops: Function pointers to access the API
> +        */
> +       const struct pt_iommu_ops *ops;
> +
> +       /**
> +        * @nid: Node ID to use for table memory allocations. The IOMMU d=
river
> +        * may want to set the NID to the device's NID, if there are mult=
iple
> +        * table walkers.
> +        */
> +       int nid;
> +};
> +
> +/**
> + * struct pt_iommu_info - Details about the IOMMU page table
> + *
> + * Returned from pt_iommu_ops->get_info()
> + */
> +struct pt_iommu_info {
> +       /**
> +        * @pgsize_bitmap: A bitmask where each set bit indicates
> +        * a page size that can be natively stored in the page table.
> +        */
> +       u64 pgsize_bitmap;
> +};
> +
> +struct pt_iommu_ops {
> +       /**
> +        * @get_info: Return the pt_iommu_info structure
> +        * @iommu_table: Table to query
> +        *
> +        * Return some basic static information about the page table.
> +        */
> +       void (*get_info)(struct pt_iommu *iommu_table,
> +                        struct pt_iommu_info *info);
> +
> +       /**
> +        * @deinit: Undo a format specific init operation
> +        * @iommu_table: Table to destroy
> +        *
> +        * Release all of the memory. The caller must have already remove=
d the
> +        * table from all HW access and all caches.
> +        */
> +       void (*deinit)(struct pt_iommu *iommu_table);
> +};
> +
> +static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
> +{
> +       /*
> +        * It is safe to call pt_iommu_deinit() before an init, or if ini=
t
> +        * fails. The ops pointer will only become non-NULL if deinit nee=
ds to be
> +        * run.
> +        */
> +       if (iommu_table->ops)
> +               iommu_table->ops->deinit(iommu_table);
> +}
> +
> +/**
> + * struct pt_iommu_cfg - Common configuration values for all formats
> + */
> +struct pt_iommu_cfg {
> +       /**
> +        * @features: Features required. Only these features will be turn=
ed on.
> +        * The feature list should reflect what the IOMMU HW is capable o=
f.
> +        */
> +       unsigned int features;
> +       /**
> +        * @hw_max_vasz_lg2: Maximum VA the IOMMU HW can support. This wi=
ll
> +        * imply the top level of the table.
> +        */
> +       u8 hw_max_vasz_lg2;
> +       /**
> +        * @hw_max_oasz_lg2: Maximum OA the IOMMU HW can support. The for=
mat
> +        * might select a lower maximum OA.
> +        */
> +       u8 hw_max_oasz_lg2;
> +};
> +
> +/* Generate the exported function signatures from iommu_pt.h */
> +#define IOMMU_PROTOTYPES(fmt)                                           =
  \
> +       int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,          =
 \
> +                                 const struct pt_iommu_##fmt##_cfg *cfg,=
 \
> +                                 gfp_t gfp);                            =
 \
> +       void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,      =
 \
> +                                     struct pt_iommu_##fmt##_hw_info *in=
fo)
> +#define IOMMU_FORMAT(fmt, member)       \
> +       struct pt_iommu_##fmt {         \
> +               struct pt_iommu iommu;  \
> +               struct pt_##fmt member; \
> +       };                              \
> +       IOMMU_PROTOTYPES(fmt)
> +
> +/*
> + * The driver should setup its domain struct like
> + *     union {
> + *             struct iommu_domain domain;
> + *             struct pt_iommu_xxx xx;
> + *     };
> + * PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, xx.iommu, domain);
> + *
> + * Which creates an alias between driver_domain.domain and
> + * driver_domain.xx.iommu.domain. This is to avoid a mass rename of exis=
ting
> + * driver_domain.domain users.
> + */
> +#define PT_IOMMU_CHECK_DOMAIN(s, pt_iommu_memb, domain_memb) \
> +       static_assert(offsetof(s, pt_iommu_memb.domain) =3D=3D   \
> +                     offsetof(s, domain_memb))
> +
> +#undef IOMMU_PROTOTYPES
> +#undef IOMMU_FORMAT
> +#endif
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

