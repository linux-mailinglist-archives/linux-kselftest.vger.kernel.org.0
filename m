Return-Path: <linux-kselftest+bounces-44116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC463C0F743
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E65F34FAC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB92B3148D0;
	Mon, 27 Oct 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Omw7nVjx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172C30F92F
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583891; cv=none; b=ISPR6/fwjN7PRXoJG9Q15WcSkCoS0PCP9fXaPcvowxqem4zii8Mly5+MmgNuGfIC5QatpFYA/U6gahGsqOoDw3QhkUIbxRdOtBvMIUJOJKIQHuB8p+xn/hUlkyj7yerz5LWYPZLCmaO02E2bmcn9w6A2Z8IPAxZP3xKB2BX2JIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583891; c=relaxed/simple;
	bh=BpWkwcvk+ttbEIODEe3Jc2OawoiRUJhFdv7D7duHz60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRMKeOGlYav34BTsnG5yZ0Oae5ZPaQwSDWuhRDukECIa7oZXWeajrD1erUGoULnVUIosHUB50iw38RUIbUi3R844T7sHZloEnlU+hOvwKpRV8UqdDwoViltyaJxDrsJwlgtsIALLA55t4FFoA4C9LxAOixu7krWwbOY1RerWDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Omw7nVjx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ecfafb92bcso7391cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761583888; x=1762188688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vt6j/nV+hL/aatsW20+tI1ruqJfiHv93rNFzUtULteA=;
        b=Omw7nVjxAia2dKz+vOOhXXlGy3ws+2gamc9i7ruBp6nMV+clPdiFgsRXvva0oOuICz
         /hbZhuZZzP0GqfA2HzRQRBqleDOmv5kAmFvzogygXVvnvG6k/uXDBjmHfpMnOHoBaLKd
         S210xkHwvKEstkRDWKmwrTK01ZIKDhVyYHhsrPASHWTXBKGVeuw3EIQhSZxrxTfUWKo7
         Z8QmUM6wW97JN1ljJHkwU7Rj/+icRf5mJzRqDlCqm0hh6+/6EGMP8Lt+TpVzesCsfiN0
         cPO3zcfo8yDLy747M3WgpwV0u0JZeYbMS0wB9W58l9fwIwo0lPFu3fC/Eb5gKyHAOVSw
         dBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583888; x=1762188688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vt6j/nV+hL/aatsW20+tI1ruqJfiHv93rNFzUtULteA=;
        b=QsBAPEADCfO36w3T6AAjxO9SSW4s5gsz+NtYJeLJsaHEimTB/MLGid9+SGdLOlSQf1
         niddsuPBZ1llDsLtHW9v8e31Pi/vxDc4gkAAY4OGghkqWg92ykZWkrZICqt+/Ex3w52A
         gAudaQ963CYCHrNLFO7qTkZlqFvLK1gzMGtXY1H8mPJ7SXPNyzZsTkDsDhvSm9WUN0Pw
         jVyPcoNogXxqpRsesj9PWn/wmtbL+Rm+HZn71JYSZJq4XDM+TN16EunuW7tb5T4uo7/2
         GjVZk36MUjys6PQSY8SQaADMCbC/zjSlLbO5fG1g/n+BDb/DQnXWnNKzLCFXGl6rRDXz
         T4vw==
X-Forwarded-Encrypted: i=1; AJvYcCVcULt7yhAW+K2YMuS0CvKwBCuhvMCxC2ZUeeWcHgX+qZ3nx0b7xuL9QrAGBFSt4HD9HGWrbRLv9TYdA3PJ+fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyOGwnvfVyeYFftKka46vH5iq6Pp6sIMjtpTUlWpvp8NYx0Zg
	nHdBPEHt/1iHdzChIrn27FxPR9fnxpL65tURHVXUSnMTn/XT0DADoUkk1cU3EXOu5t3L3f07Re4
	FdlbBBiHcp27P+UnCyXwMExep2P18jDK2FoetWevu
X-Gm-Gg: ASbGncuMcby2f8+2f2/9hU8SeXN+QCHJyH7zxIqCFvw2VEX5a8Fm3AJzilJsJz/BRcz
	nLzNzlwnMrUL6imYNoiABic4h2QN8V+gYZFPn2MewzF3kwO5ldCJ6cNW0KVlHu8RmNnP1fU7I4i
	QZYTJfx+iurEiOihVKYef2gdkJ3FcThJCTvpZGPiMf1IjQhgMUWUb/36/zXoIjbzMVUXKzrO4xV
	sPUo1ydAfSYePi4ykM5jF2sNudgD9wNZqjfPdDmdHe/WFRrJHJV2B3F8fbOJv/IurAOvz2NjbxA
	fQZWP4/dj1UWD/cdSLJnSkRgJQ==
X-Google-Smtp-Source: AGHT+IHSf6XBB13zoI4VmxW32VJTBDOaDjvKRIRZqFXtSwyDht+a+iclLHapLQWD5ps6mgchrQFlzxXZLRPkueBpaF8=
X-Received: by 2002:ac8:5f84:0:b0:4e8:b4dc:4c58 with SMTP id
 d75a77b69052e-4eba229dfc9mr12906661cf.12.1761583888008; Mon, 27 Oct 2025
 09:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <5-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <5-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 27 Oct 2025 09:51:16 -0700
X-Gm-Features: AWmQ_bk-2Q_pdXrZkw1tD93f2ALLMLAZxHMjv2ygRXcaD9JlPPU-k11kjCl7bDI
Message-ID: <CAAywjhTkm89boLCLibkhvsa3qJ0n4p37VF+e9sYdW0rvhTCnEw@mail.gmail.com>
Subject: Re: [PATCH v7 05/15] iommupt: Add iova_to_phys op
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
> iova_to_phys is a performance path for the DMA API and iommufd, implement
> it using an unrolled get_user_pages() like function waterfall scheme.
>
> The implementation itself is fairly trivial.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 105 ++++++++++++++++++++++++++++
>  include/linux/generic_pt/iommu.h    |  19 +++--
>  2 files changed, 119 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_=
pt/iommu_pt.h
> index 564f2d3a6e11e1..5ff1b887928a46 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -17,6 +17,111 @@
>
>  #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
>
> +static int make_range_ul(struct pt_common *common, struct pt_range *rang=
e,
> +                        unsigned long iova, unsigned long len)
> +{
> +       unsigned long last;
> +
> +       if (unlikely(len =3D=3D 0))
> +               return -EINVAL;
> +
> +       if (check_add_overflow(iova, len - 1, &last))
> +               return -EOVERFLOW;
> +
> +       *range =3D pt_make_range(common, iova, last);
> +       if (sizeof(iova) > sizeof(range->va)) {
> +               if (unlikely(range->va !=3D iova || range->last_va !=3D l=
ast))
> +                       return -EOVERFLOW;
> +       }
> +       return 0;
> +}
> +
> +static __maybe_unused int make_range_u64(struct pt_common *common,
> +                                        struct pt_range *range, u64 iova=
,
> +                                        u64 len)
> +{
> +       if (unlikely(iova > ULONG_MAX || len > ULONG_MAX))
> +               return -EOVERFLOW;
> +       return make_range_ul(common, range, iova, len);
> +}
> +
> +/*
> + * Some APIs use unsigned long, while othersuse dma_addr_t as the type. =
Dispatch
> + * to the correct validation based on the type.
> + */
> +#define make_range_no_check(common, range, iova, len)                   =
\
> +       ({                                                              \
> +               int ret;                                                \
> +               if (sizeof(iova) > sizeof(unsigned long) ||             \
> +                   sizeof(len) > sizeof(unsigned long))                \
> +                       ret =3D make_range_u64(common, range, iova, len);=
 \
> +               else                                                    \
> +                       ret =3D make_range_ul(common, range, iova, len); =
 \
> +               ret;                                                    \
> +       })
> +
> +#define make_range(common, range, iova, len)                            =
 \
> +       ({                                                               =
\
> +               int ret =3D make_range_no_check(common, range, iova, len)=
; \
> +               if (!ret)                                                =
\
> +                       ret =3D pt_check_range(range);                   =
  \
> +               ret;                                                     =
\
> +       })
> +
> +static __always_inline int __do_iova_to_phys(struct pt_range *range, voi=
d *arg,
> +                                            unsigned int level,
> +                                            struct pt_table_p *table,
> +                                            pt_level_fn_t descend_fn)
> +{
> +       struct pt_state pts =3D pt_init(range, level, table);
> +       pt_oaddr_t *res =3D arg;
> +
> +       switch (pt_load_single_entry(&pts)) {
> +       case PT_ENTRY_EMPTY:
> +               return -ENOENT;
> +       case PT_ENTRY_TABLE:
> +               return pt_descend(&pts, arg, descend_fn);
> +       case PT_ENTRY_OA:
> +               *res =3D pt_entry_oa_exact(&pts);
> +               return 0;
> +       }
> +       return -ENOENT;
> +}
> +PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
> +
> +/**
> + * iova_to_phys() - Return the output address for the given IOVA
> + * @iommu_table: Table to query
> + * @iova: IO virtual address to query
> + *
> + * Determine the output address from the given IOVA. @iova may have any
> + * alignment, the returned physical will be adjusted with any sub page o=
ffset.
> + *
> + * Context: The caller must hold a read range lock that includes @iova.
> + *
> + * Return: 0 if there is no translation for the given iova.
> + */
> +phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
> +                                   dma_addr_t iova)
> +{
> +       struct pt_iommu *iommu_table =3D
> +               container_of(domain, struct pt_iommu, domain);
> +       struct pt_range range;
> +       pt_oaddr_t res;
> +       int ret;
> +
> +       ret =3D make_range(common_from_iommu(iommu_table), &range, iova, =
1);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D pt_walk_range(&range, __iova_to_phys, &res);
> +       /* PHYS_ADDR_MAX would be a better error code */
> +       if (ret)
> +               return 0;
> +       return res;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
> +
>  struct pt_iommu_collect_args {
>         struct iommu_pages_list free_list;
>  };
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/=
iommu.h
> index dc731fe003d153..5622856e199881 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -116,11 +116,13 @@ struct pt_iommu_cfg {
>  };
>
>  /* Generate the exported function signatures from iommu_pt.h */
> -#define IOMMU_PROTOTYPES(fmt)                                           =
  \
> -       int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,          =
 \
> -                                 const struct pt_iommu_##fmt##_cfg *cfg,=
 \
> -                                 gfp_t gfp);                            =
 \
> -       void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,      =
 \
> +#define IOMMU_PROTOTYPES(fmt)                                           =
       \
> +       phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *do=
main, \
> +                                                 dma_addr_t iova);      =
      \
> +       int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,          =
      \
> +                                 const struct pt_iommu_##fmt##_cfg *cfg,=
      \
> +                                 gfp_t gfp);                            =
      \
> +       void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,      =
      \
>                                       struct pt_iommu_##fmt##_hw_info *in=
fo)
>  #define IOMMU_FORMAT(fmt, member)       \
>         struct pt_iommu_##fmt {         \
> @@ -129,6 +131,13 @@ struct pt_iommu_cfg {
>         };                              \
>         IOMMU_PROTOTYPES(fmt)
>
> +/*
> + * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops fo=
r the
> + * iommu_pt
> + */
> +#define IOMMU_PT_DOMAIN_OPS(fmt) \
> +       .iova_to_phys =3D &pt_iommu_##fmt##_iova_to_phys,
> +
>  /*
>   * The driver should setup its domain struct like
>   *     union {
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

