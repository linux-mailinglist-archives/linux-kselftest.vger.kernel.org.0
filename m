Return-Path: <linux-kselftest+bounces-44369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D4C1DFC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 02:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E501886452
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 01:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490D823D7FC;
	Thu, 30 Oct 2025 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqQ/SSvy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FF1FBEA8
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786415; cv=none; b=R1bH8wk5G8m7LiKu9Vc7ODj90zY07Z5Svp3Cp6Aq5swvz29USsgtpME0TgKzPfZaOmRxT9Kvq+HGOjc/xui8Odx4P2TBqmpi7KQXSDfunnWejTj/TmQzWwlG6KuP7GLySRCkhABPFX9WDet05cfDLw9Jn1T2qx4DOWpAfm7X9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786415; c=relaxed/simple;
	bh=szTkHDRCOniI3KdkyePi39n3aDLaXrWvNI90EcgpvFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j38+cFW1QUwhvslq8tkJd4PaMSZVR7b5nYVwdk1Uh7EiqTfcSEtVAk4YG17uopekVeYzENIE3sUq8z5zM32PzSonUeLgPzV+ldusiFC0qEG9N6+xbBXH/+6ADC0l6i8KW0Ai6zA9BL/Mu/QyMzsZx3GLc7FZWZfPGyLAzgf3XT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cqQ/SSvy; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ecfafb92bcso93521cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 18:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761786411; x=1762391211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0T3+TWFIfkeTj+Rk+rqHRkiiKweQsvwJP2CjsYyaYs=;
        b=cqQ/SSvypFde++/IMQ82MibzYCp/4YzaTCeP4Uh1cOyDsRgTXjP2+oPgd5gkKl8WLy
         SGqEricBRBAqGzKQNIMlidcuCR0JGxkzxTkD0MY6GW5HfgZN+Yo4q0jdAtItp5vLjI/p
         FYHtVw/+s1mAdBuGgOVBZZsIAvpWs0Od7DowjrpoPo68qN4EkhikqKseWr/TvBIhx4MA
         2M/pUV8a+r+V/aA1/v93j7NPdJYPoCbJLayOynyePC6D2fox4hVuy2pmgQtnH0E7WPe6
         237yMSwIW3a1y0QT3xlSKQ4+JBSn7Nx6iZshadd59km0+cA+Z3gShOz1TFlqceou20UJ
         cMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761786411; x=1762391211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0T3+TWFIfkeTj+Rk+rqHRkiiKweQsvwJP2CjsYyaYs=;
        b=sxJFV+YcN9vseIs6UXs/Hr4g6m5+Ruhge6tUAy6jEDqeKUV339GJKgcysKKCWGn6AW
         2YHbCS1v6xOMvBPZbESNSqRycPVgSwxjrLmNLgIIAAlgmy3lDe4oxc0auUhNdNG7qqKx
         V3m77mBXn6FaacxzB3KgmhIHK70WxCG3jsy96xjsWyT8MlIN7wOyuN8R7wnErC5+LqjY
         QDe0IB4dO5j6pPhyI2Po89g3zgqEMhgeyQ/LOHI40LbUshEj2ObnOPioyrxmXENejh+M
         YVmUxj3OTFnB5HaBnkR1YZtWoiqIB1UEcvrbFjV8aEvPmCFOpWEuS84sfuWfeVBROchi
         PYnw==
X-Forwarded-Encrypted: i=1; AJvYcCVRHTbLByihjttzoxWaDL3WDP7cNCwvIEgXkt+nK46LamAd9Uq/5f/hplbC8WSyMHh5ns8aabTB5HGf2J+lt/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvmKV9H7dFuxHE22ki5dCYPc9Vmhtv2xvkl/n9akb4HD7Qs+i
	BRiT15rFpo3/IUVrol6YGGEU85+QIHITlItMwoN6vc5RExnShnP9kwa+vUm0UwpMichQ26DCssp
	ZulLnRc/6Z8pqWCe9d0E8wRRx2GL7ciRGSxCuRQ/U
X-Gm-Gg: ASbGnctTRczJ+6NCxLgAvoWJeoIT1BzewzCkFXBuK8nLFUC/RS7r+nDbZk8DSOWZWZL
	W7G2hfa/Py82f+1wRFweNMEnvVh974yS6Vj1XRQpVW5LpgdmlZhtS1zCmnLuzRA3fSXJd804qdX
	PTpZzU4F+YinAgQfLHN0j6wut4PSikK2vMAHXIayrELpKMs0h3b9E/CdAYqmRB37jtnLME80XXT
	VZDM+HlK3GE4ScG7023AmSHJpMSVTevq3wvzvVByyfhFxPXrL9MankGgTouKJAOy/hy8/UaydkX
	M2iYwt5SSY72sS+Ie8nrNbXciryY
X-Google-Smtp-Source: AGHT+IGtby5pPyiG3YXeNYOvRdqpOoXqplSqoinsOg6q6R+lmgBgF7fvZT5JI4DwXsWOP7WlMcJ16mmVNkF6meJEvNU=
X-Received: by 2002:a05:622a:1456:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-4ed2251bf39mr3388191cf.14.1761786410816; Wed, 29 Oct 2025
 18:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <11-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <11-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 29 Oct 2025 18:06:39 -0700
X-Gm-Features: AWmQ_bmXko2ADnbC_c0dxd4seg8had1xXHLwrkuK_dK0NvMRIHGbi4brQ1V7RMM
Message-ID: <CAAywjhROX5jU4j5f1bCUPSKBKJWDGMvzxY72RVWDDst-jrHzkA@mail.gmail.com>
Subject: Re: [PATCH v7 11/15] iommufd: Change the selftest to use iommupt
 instead of xarray
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
> The iommufd self test uses an xarray to store the pfns and their orders t=
o
> emulate a page table. Make it act more like a real iommu driver by
> replacing the xarray with an iommupt based page table. The new AMDv1 mock
> format behaves similarly to the xarray.
>
> Add set_dirty() as a iommu_pt operation to allow the test suite to
> simulate HW dirty.
>
> Userspace can select between several formats including the normal AMDv1
> format and a special MOCK_IOMMUPT_HUGE variation for testing huge page
> dirty tracking. To make the dirty tracking test work the page table must
> only store exactly 2M huge pages otherwise the logic the test uses
> fails. They cannot be broken up or combined.
>
> Aside from aligning the selftest with a real page table implementation,
> this helps test the iommupt code itself.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h           |  39 ++
>  drivers/iommu/iommufd/Kconfig                 |   1 +
>  drivers/iommu/iommufd/iommufd_test.h          |  11 +-
>  drivers/iommu/iommufd/selftest.c              | 438 +++++++-----------
>  include/linux/generic_pt/iommu.h              |  12 +
>  tools/testing/selftests/iommu/iommufd.c       |  60 ++-
>  tools/testing/selftests/iommu/iommufd_utils.h |  12 +
>  7 files changed, 289 insertions(+), 284 deletions(-)
>
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_=
pt/iommu_pt.h
> index 448c5796d4a861..142001f5aa83fd 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -264,6 +264,41 @@ int DOMAIN_NS(read_and_clear_dirty)(struct iommu_dom=
ain *domain,
>  }
>  EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(read_and_clear_dirty), "GENERIC_PT_IOMMU"=
);
>
> +static inline int __set_dirty(struct pt_range *range, void *arg,
> +                             unsigned int level, struct pt_table_p *tabl=
e)
> +{
> +       struct pt_state pts =3D pt_init(range, level, table);
> +
> +       switch (pt_load_single_entry(&pts)) {
> +       case PT_ENTRY_EMPTY:
> +               return -ENOENT;
> +       case PT_ENTRY_TABLE:
> +               return pt_descend(&pts, arg, __set_dirty);
> +       case PT_ENTRY_OA:
> +               if (!pt_entry_make_write_dirty(&pts))
> +                       return -EAGAIN;
> +               return 0;
> +       }
> +       return -ENOENT;
> +}
> +
> +static int __maybe_unused NS(set_dirty)(struct pt_iommu *iommu_table,
> +                                       dma_addr_t iova)
> +{
> +       struct pt_range range;
> +       int ret;
> +
> +       ret =3D make_range(common_from_iommu(iommu_table), &range, iova, =
1);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Note: There is no locking here yet, if the test suite races th=
is it
> +        * can crash. It should use RCU locking eventually.
> +        */
> +       return pt_walk_range(&range, __set_dirty, NULL);
> +}
> +
>  struct pt_iommu_collect_args {
>         struct iommu_pages_list free_list;
>         /* Fail if any OAs are within the range */
> @@ -957,6 +992,10 @@ static void NS(deinit)(struct pt_iommu *iommu_table)
>  }
>
>  static const struct pt_iommu_ops NS(ops) =3D {
> +#if IS_ENABLED(CONFIG_IOMMUFD_DRIVER) && defined(pt_entry_is_write_dirty=
) && \
> +       IS_ENABLED(CONFIG_IOMMUFD_TEST) && defined(pt_entry_make_write_di=
rty)
> +       .set_dirty =3D NS(set_dirty),
> +#endif
>         .get_info =3D NS(get_info),
>         .deinit =3D NS(deinit),
>  };
> diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfi=
g
> index 2beeb4f60ee538..eae3f03629b0c1 100644
> --- a/drivers/iommu/iommufd/Kconfig
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -41,6 +41,7 @@ config IOMMUFD_TEST
>         depends on DEBUG_KERNEL
>         depends on FAULT_INJECTION
>         depends on RUNTIME_TESTING_MENU
> +       depends on IOMMU_PT_AMDV1
>         select IOMMUFD_DRIVER
>         default n
>         help
> diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd=
/iommufd_test.h
> index 8fc618b2bcf967..781a75c79eeaec 100644
> --- a/drivers/iommu/iommufd/iommufd_test.h
> +++ b/drivers/iommu/iommufd/iommufd_test.h
> @@ -31,9 +31,18 @@ enum {
>         IOMMU_TEST_OP_PASID_CHECK_HWPT,
>  };
>
> +enum {
> +       MOCK_IOMMUPT_DEFAULT =3D 0,
> +       MOCK_IOMMUPT_HUGE,
> +       MOCK_IOMMUPT_AMDV1,
> +};
> +
> +/* These values are true for MOCK_IOMMUPT_DEFAULT */
>  enum {
>         MOCK_APERTURE_START =3D 1UL << 24,
>         MOCK_APERTURE_LAST =3D (1UL << 31) - 1,
> +       MOCK_PAGE_SIZE =3D 2048,
> +       MOCK_HUGE_PAGE_SIZE =3D 512 * MOCK_PAGE_SIZE,
>  };
>
>  enum {
> @@ -52,7 +61,6 @@ enum {
>
>  enum {
>         MOCK_FLAGS_DEVICE_NO_DIRTY =3D 1 << 0,
> -       MOCK_FLAGS_DEVICE_HUGE_IOVA =3D 1 << 1,
>         MOCK_FLAGS_DEVICE_PASID =3D 1 << 2,
>  };
>
> @@ -205,6 +213,7 @@ struct iommu_test_hw_info {
>   */
>  struct iommu_hwpt_selftest {
>         __u32 iotlb;
> +       __u32 pagetable_type;
>  };
>
>  /* Should not be equal to any defined value in enum iommu_hwpt_invalidat=
e_data_type */
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/sel=
ftest.c
> index de178827a078a9..2fc90b483ae909 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -12,6 +12,8 @@
>  #include <linux/slab.h>
>  #include <linux/xarray.h>
>  #include <uapi/linux/iommufd.h>
> +#include <linux/generic_pt/iommu.h>
> +#include "../iommu-pages.h"
>
>  #include "../iommu-priv.h"
>  #include "io_pagetable.h"
> @@ -41,21 +43,6 @@ static DEFINE_IDA(mock_dev_ida);
>
>  enum {
>         MOCK_DIRTY_TRACK =3D 1,
> -       MOCK_IO_PAGE_SIZE =3D PAGE_SIZE / 2,
> -       MOCK_HUGE_PAGE_SIZE =3D 512 * MOCK_IO_PAGE_SIZE,
> -
> -       /*
> -        * Like a real page table alignment requires the low bits of the =
address
> -        * to be zero. xarray also requires the high bit to be zero, so w=
e store
> -        * the pfns shifted. The upper bits are used for metadata.
> -        */
> -       MOCK_PFN_MASK =3D ULONG_MAX / MOCK_IO_PAGE_SIZE,
> -
> -       _MOCK_PFN_START =3D MOCK_PFN_MASK + 1,
> -       MOCK_PFN_START_IOVA =3D _MOCK_PFN_START,
> -       MOCK_PFN_LAST_IOVA =3D _MOCK_PFN_START,
> -       MOCK_PFN_DIRTY_IOVA =3D _MOCK_PFN_START << 1,
> -       MOCK_PFN_HUGE_IOVA =3D _MOCK_PFN_START << 2,
>  };
>
>  static int mock_dev_enable_iopf(struct device *dev, struct iommu_domain =
*domain);
> @@ -124,10 +111,15 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_u=
cmd *ucmd,
>  }
>
>  struct mock_iommu_domain {
> +       union {
> +               struct iommu_domain domain;
> +               struct pt_iommu iommu;
> +               struct pt_iommu_amdv1 amdv1;
> +       };
>         unsigned long flags;
> -       struct iommu_domain domain;
> -       struct xarray pfns;
>  };
> +PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, iommu, domain);
> +PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, amdv1.iommu, domain);
>
>  static inline struct mock_iommu_domain *
>  to_mock_domain(struct iommu_domain *domain)
> @@ -344,74 +336,6 @@ static int mock_domain_set_dirty_tracking(struct iom=
mu_domain *domain,
>         return 0;
>  }
>
> -static bool mock_test_and_clear_dirty(struct mock_iommu_domain *mock,
> -                                     unsigned long iova, size_t page_siz=
e,
> -                                     unsigned long flags)
> -{
> -       unsigned long cur, end =3D iova + page_size - 1;
> -       bool dirty =3D false;
> -       void *ent, *old;
> -
> -       for (cur =3D iova; cur < end; cur +=3D MOCK_IO_PAGE_SIZE) {
> -               ent =3D xa_load(&mock->pfns, cur / MOCK_IO_PAGE_SIZE);
> -               if (!ent || !(xa_to_value(ent) & MOCK_PFN_DIRTY_IOVA))
> -                       continue;
> -
> -               dirty =3D true;
> -               /* Clear dirty */
> -               if (!(flags & IOMMU_DIRTY_NO_CLEAR)) {
> -                       unsigned long val;
> -
> -                       val =3D xa_to_value(ent) & ~MOCK_PFN_DIRTY_IOVA;
> -                       old =3D xa_store(&mock->pfns, cur / MOCK_IO_PAGE_=
SIZE,
> -                                      xa_mk_value(val), GFP_KERNEL);
> -                       WARN_ON_ONCE(ent !=3D old);
> -               }
> -       }
> -
> -       return dirty;
> -}
> -
> -static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
> -                                           unsigned long iova, size_t si=
ze,
> -                                           unsigned long flags,
> -                                           struct iommu_dirty_bitmap *di=
rty)
> -{
> -       struct mock_iommu_domain *mock =3D to_mock_domain(domain);
> -       unsigned long end =3D iova + size;
> -       void *ent;
> -
> -       if (!(mock->flags & MOCK_DIRTY_TRACK) && dirty->bitmap)
> -               return -EINVAL;
> -
> -       do {
> -               unsigned long pgsize =3D MOCK_IO_PAGE_SIZE;
> -               unsigned long head;
> -
> -               ent =3D xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
> -               if (!ent) {
> -                       iova +=3D pgsize;
> -                       continue;
> -               }
> -
> -               if (xa_to_value(ent) & MOCK_PFN_HUGE_IOVA)
> -                       pgsize =3D MOCK_HUGE_PAGE_SIZE;
> -               head =3D iova & ~(pgsize - 1);
> -
> -               /* Clear dirty */
> -               if (mock_test_and_clear_dirty(mock, head, pgsize, flags))
> -                       iommu_dirty_bitmap_record(dirty, iova, pgsize);
> -               iova +=3D pgsize;
> -       } while (iova < end);
> -
> -       return 0;
> -}
> -
> -static const struct iommu_dirty_ops dirty_ops =3D {
> -       .set_dirty_tracking =3D mock_domain_set_dirty_tracking,
> -       .read_and_clear_dirty =3D mock_domain_read_and_clear_dirty,
> -};
> -
>  static struct mock_iommu_domain_nested *
>  __mock_domain_alloc_nested(const struct iommu_user_data *user_data)
>  {
> @@ -446,7 +370,7 @@ mock_domain_alloc_nested(struct device *dev, struct i=
ommu_domain *parent,
>
>         if (flags & ~IOMMU_HWPT_ALLOC_PASID)
>                 return ERR_PTR(-EOPNOTSUPP);
> -       if (!parent || parent->ops !=3D mock_ops.default_domain_ops)
> +       if (!parent || !(parent->type & __IOMMU_DOMAIN_PAGING))
>                 return ERR_PTR(-EINVAL);
>
>         mock_parent =3D to_mock_domain(parent);
> @@ -459,6 +383,138 @@ mock_domain_alloc_nested(struct device *dev, struct=
 iommu_domain *parent,
>         return &mock_nested->domain;
>  }
>
> +static void mock_domain_free(struct iommu_domain *domain)
> +{
> +       struct mock_iommu_domain *mock =3D to_mock_domain(domain);
> +
> +       pt_iommu_deinit(&mock->iommu);
> +       kfree(mock);
> +}
> +
> +static void mock_iotlb_sync(struct iommu_domain *domain,
> +                               struct iommu_iotlb_gather *gather)
> +{
> +       iommu_put_pages_list(&gather->freelist);
> +}
> +
> +static const struct iommu_domain_ops amdv1_mock_ops =3D {
> +       IOMMU_PT_DOMAIN_OPS(amdv1_mock),
> +       .free =3D mock_domain_free,
> +       .attach_dev =3D mock_domain_nop_attach,
> +       .set_dev_pasid =3D mock_domain_set_dev_pasid_nop,
> +       .iotlb_sync =3D &mock_iotlb_sync,
> +};
> +
> +static const struct iommu_domain_ops amdv1_mock_huge_ops =3D {
> +       IOMMU_PT_DOMAIN_OPS(amdv1_mock),
> +       .free =3D mock_domain_free,
> +       .attach_dev =3D mock_domain_nop_attach,
> +       .set_dev_pasid =3D mock_domain_set_dev_pasid_nop,
> +       .iotlb_sync =3D &mock_iotlb_sync,
> +};
> +#undef pt_iommu_amdv1_mock_map_pages
> +
> +static const struct iommu_dirty_ops amdv1_mock_dirty_ops =3D {
> +       IOMMU_PT_DIRTY_OPS(amdv1_mock),
> +       .set_dirty_tracking =3D mock_domain_set_dirty_tracking,
> +};
> +
> +static const struct iommu_domain_ops amdv1_ops =3D {
> +       IOMMU_PT_DOMAIN_OPS(amdv1),
> +       .free =3D mock_domain_free,
> +       .attach_dev =3D mock_domain_nop_attach,
> +       .set_dev_pasid =3D mock_domain_set_dev_pasid_nop,
> +       .iotlb_sync =3D &mock_iotlb_sync,
> +};
> +
> +static const struct iommu_dirty_ops amdv1_dirty_ops =3D {
> +       IOMMU_PT_DIRTY_OPS(amdv1),
> +       .set_dirty_tracking =3D mock_domain_set_dirty_tracking,
> +};
> +
> +static struct mock_iommu_domain *
> +mock_domain_alloc_pgtable(struct device *dev,
> +                         const struct iommu_hwpt_selftest *user_cfg, u32=
 flags)
> +{
> +       struct mock_iommu_domain *mock;
> +       int rc;
> +
> +       mock =3D kzalloc(sizeof(*mock), GFP_KERNEL);
> +       if (!mock)
> +               return ERR_PTR(-ENOMEM);
> +       mock->domain.type =3D IOMMU_DOMAIN_UNMANAGED;
> +
> +       mock->amdv1.iommu.nid =3D NUMA_NO_NODE;
> +
> +       switch (user_cfg->pagetable_type) {
> +       case MOCK_IOMMUPT_DEFAULT:
> +       case MOCK_IOMMUPT_HUGE: {
> +               struct pt_iommu_amdv1_cfg cfg =3D {};
> +
> +               /* The mock version has a 2k page size */
> +               cfg.common.hw_max_vasz_lg2 =3D 56;
> +               cfg.common.hw_max_oasz_lg2 =3D 51;
> +               cfg.starting_level =3D 2;
> +               if (user_cfg->pagetable_type =3D=3D MOCK_IOMMUPT_HUGE)
> +                       mock->domain.ops =3D &amdv1_mock_huge_ops;
> +               else
> +                       mock->domain.ops =3D &amdv1_mock_ops;
> +               rc =3D pt_iommu_amdv1_mock_init(&mock->amdv1, &cfg, GFP_K=
ERNEL);
> +               if (rc)
> +                       goto err_free;
> +
> +               /*
> +                * In huge mode userspace should only provide huge pages,=
 we
> +                * have to include PAGE_SIZE for the domain to be accepte=
d by
> +                * iommufd.
> +                */
> +               if (user_cfg->pagetable_type =3D=3D MOCK_IOMMUPT_HUGE)
> +                       mock->domain.pgsize_bitmap =3D MOCK_HUGE_PAGE_SIZ=
E |
> +                                                    PAGE_SIZE;
> +               if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
> +                       mock->domain.dirty_ops =3D &amdv1_mock_dirty_ops;
> +               break;
> +       }
> +
> +       case MOCK_IOMMUPT_AMDV1: {
> +               struct pt_iommu_amdv1_cfg cfg =3D {};
> +
> +               cfg.common.hw_max_vasz_lg2 =3D 64;
> +               cfg.common.hw_max_oasz_lg2 =3D 52;
> +               cfg.common.features =3D BIT(PT_FEAT_DYNAMIC_TOP) |
> +                                     BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> +                                     BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
> +               cfg.starting_level =3D 2;
> +               mock->domain.ops =3D &amdv1_ops;
> +               rc =3D pt_iommu_amdv1_init(&mock->amdv1, &cfg, GFP_KERNEL=
);
> +               if (rc)
> +                       goto err_free;
> +               if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
> +                       mock->domain.dirty_ops =3D &amdv1_dirty_ops;
> +               break;
> +       }
> +       default:
> +               rc =3D -EOPNOTSUPP;
> +               goto err_free;
> +       }
> +
> +       /*
> +        * Override the real aperture to the MOCK aperture for test purpo=
ses.
> +        */
> +       if (user_cfg->pagetable_type =3D=3D MOCK_IOMMUPT_DEFAULT) {
> +               WARN_ON(mock->domain.geometry.aperture_start !=3D 0);
> +               WARN_ON(mock->domain.geometry.aperture_end < MOCK_APERTUR=
E_LAST);
> +
> +               mock->domain.geometry.aperture_start =3D MOCK_APERTURE_ST=
ART;
> +               mock->domain.geometry.aperture_end =3D MOCK_APERTURE_LAST=
;
> +       }
> +
> +       return mock;
> +err_free:
> +       kfree(mock);
> +       return ERR_PTR(rc);
> +}
> +
>  static struct iommu_domain *
>  mock_domain_alloc_paging_flags(struct device *dev, u32 flags,
>                                const struct iommu_user_data *user_data)
> @@ -469,151 +525,30 @@ mock_domain_alloc_paging_flags(struct device *dev,=
 u32 flags,
>                                  IOMMU_HWPT_ALLOC_PASID;
>         struct mock_dev *mdev =3D to_mock_dev(dev);
>         bool no_dirty_ops =3D mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
> +       struct iommu_hwpt_selftest user_cfg =3D {};
>         struct mock_iommu_domain *mock;
> +       int rc;
>
> -       if (user_data)
> -               return ERR_PTR(-EOPNOTSUPP);
>         if ((flags & ~PAGING_FLAGS) || (has_dirty_flag && no_dirty_ops))
>                 return ERR_PTR(-EOPNOTSUPP);
>
> -       mock =3D kzalloc(sizeof(*mock), GFP_KERNEL);
> -       if (!mock)
> -               return ERR_PTR(-ENOMEM);
> -       mock->domain.geometry.aperture_start =3D MOCK_APERTURE_START;
> -       mock->domain.geometry.aperture_end =3D MOCK_APERTURE_LAST;
> -       mock->domain.pgsize_bitmap =3D MOCK_IO_PAGE_SIZE;
> -       if (dev && mdev->flags & MOCK_FLAGS_DEVICE_HUGE_IOVA)
> -               mock->domain.pgsize_bitmap |=3D MOCK_HUGE_PAGE_SIZE;
> -       mock->domain.ops =3D mock_ops.default_domain_ops;
> -       mock->domain.type =3D IOMMU_DOMAIN_UNMANAGED;
> -       xa_init(&mock->pfns);
> +       if (user_data && (user_data->type !=3D IOMMU_HWPT_DATA_SELFTEST &=
&
> +                         user_data->type !=3D IOMMU_HWPT_DATA_NONE))
> +               return ERR_PTR(-EOPNOTSUPP);
>
> -       if (has_dirty_flag)
> -               mock->domain.dirty_ops =3D &dirty_ops;
> +       if (user_data) {
> +               rc =3D iommu_copy_struct_from_user(
> +                       &user_cfg, user_data, IOMMU_HWPT_DATA_SELFTEST, i=
otlb);
> +               if (rc)
> +                       return ERR_PTR(rc);
> +       }
> +
> +       mock =3D mock_domain_alloc_pgtable(dev, &user_cfg, flags);
> +       if (IS_ERR(mock))
> +               return ERR_CAST(mock);
>         return &mock->domain;
>  }
>
> -static void mock_domain_free(struct iommu_domain *domain)
> -{
> -       struct mock_iommu_domain *mock =3D to_mock_domain(domain);
> -
> -       WARN_ON(!xa_empty(&mock->pfns));
> -       kfree(mock);
> -}
> -
> -static int mock_domain_map_pages(struct iommu_domain *domain,
> -                                unsigned long iova, phys_addr_t paddr,
> -                                size_t pgsize, size_t pgcount, int prot,
> -                                gfp_t gfp, size_t *mapped)
> -{
> -       struct mock_iommu_domain *mock =3D to_mock_domain(domain);
> -       unsigned long flags =3D MOCK_PFN_START_IOVA;
> -       unsigned long start_iova =3D iova;
> -
> -       /*
> -        * xarray does not reliably work with fault injection because it =
does a
> -        * retry allocation, so put our own failure point.
> -        */
> -       if (iommufd_should_fail())
> -               return -ENOENT;
> -
> -       WARN_ON(iova % MOCK_IO_PAGE_SIZE);
> -       WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
> -       for (; pgcount; pgcount--) {
> -               size_t cur;
> -
> -               for (cur =3D 0; cur !=3D pgsize; cur +=3D MOCK_IO_PAGE_SI=
ZE) {
> -                       void *old;
> -
> -                       if (pgcount =3D=3D 1 && cur + MOCK_IO_PAGE_SIZE =
=3D=3D pgsize)
> -                               flags =3D MOCK_PFN_LAST_IOVA;
> -                       if (pgsize !=3D MOCK_IO_PAGE_SIZE) {
> -                               flags |=3D MOCK_PFN_HUGE_IOVA;
> -                       }
> -                       old =3D xa_store(&mock->pfns, iova / MOCK_IO_PAGE=
_SIZE,
> -                                      xa_mk_value((paddr / MOCK_IO_PAGE_=
SIZE) |
> -                                                  flags),
> -                                      gfp);
> -                       if (xa_is_err(old)) {
> -                               for (; start_iova !=3D iova;
> -                                    start_iova +=3D MOCK_IO_PAGE_SIZE)
> -                                       xa_erase(&mock->pfns,
> -                                                start_iova /
> -                                                        MOCK_IO_PAGE_SIZ=
E);
> -                               return xa_err(old);
> -                       }
> -                       WARN_ON(old);
> -                       iova +=3D MOCK_IO_PAGE_SIZE;
> -                       paddr +=3D MOCK_IO_PAGE_SIZE;
> -                       *mapped +=3D MOCK_IO_PAGE_SIZE;
> -                       flags =3D 0;
> -               }
> -       }
> -       return 0;
> -}
> -
> -static size_t mock_domain_unmap_pages(struct iommu_domain *domain,
> -                                     unsigned long iova, size_t pgsize,
> -                                     size_t pgcount,
> -                                     struct iommu_iotlb_gather *iotlb_ga=
ther)
> -{
> -       struct mock_iommu_domain *mock =3D to_mock_domain(domain);
> -       bool first =3D true;
> -       size_t ret =3D 0;
> -       void *ent;
> -
> -       WARN_ON(iova % MOCK_IO_PAGE_SIZE);
> -       WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
> -
> -       for (; pgcount; pgcount--) {
> -               size_t cur;
> -
> -               for (cur =3D 0; cur !=3D pgsize; cur +=3D MOCK_IO_PAGE_SI=
ZE) {
> -                       ent =3D xa_erase(&mock->pfns, iova / MOCK_IO_PAGE=
_SIZE);
> -
> -                       /*
> -                        * iommufd generates unmaps that must be a strict
> -                        * superset of the map's performend So every
> -                        * starting/ending IOVA should have been an iova =
passed
> -                        * to map.
> -                        *
> -                        * This simple logic doesn't work when the HUGE_P=
AGE is
> -                        * turned on since the core code will automatical=
ly
> -                        * switch between the two page sizes creating a b=
reak in
> -                        * the unmap calls. The break can land in the mid=
dle of
> -                        * contiguous IOVA.
> -                        */
> -                       if (!(domain->pgsize_bitmap & MOCK_HUGE_PAGE_SIZE=
)) {
> -                               if (first) {
> -                                       WARN_ON(ent && !(xa_to_value(ent)=
 &
> -                                                        MOCK_PFN_START_I=
OVA));
> -                                       first =3D false;
> -                               }
> -                               if (pgcount =3D=3D 1 &&
> -                                   cur + MOCK_IO_PAGE_SIZE =3D=3D pgsize=
)
> -                                       WARN_ON(ent && !(xa_to_value(ent)=
 &
> -                                                        MOCK_PFN_LAST_IO=
VA));
> -                       }
> -
> -                       iova +=3D MOCK_IO_PAGE_SIZE;
> -                       ret +=3D MOCK_IO_PAGE_SIZE;
> -               }
> -       }
> -       return ret;
> -}
> -
> -static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
> -                                           dma_addr_t iova)
> -{
> -       struct mock_iommu_domain *mock =3D to_mock_domain(domain);
> -       void *ent;
> -
> -       WARN_ON(iova % MOCK_IO_PAGE_SIZE);
> -       ent =3D xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
> -       WARN_ON(!ent);
> -       return (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE;
> -}
> -
>  static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
>  {
>         struct mock_dev *mdev =3D to_mock_dev(dev);
> @@ -955,15 +890,6 @@ static const struct iommu_ops mock_ops =3D {
>         .user_pasid_table =3D true,
>         .get_viommu_size =3D mock_get_viommu_size,
>         .viommu_init =3D mock_viommu_init,
> -       .default_domain_ops =3D
> -               &(struct iommu_domain_ops){
> -                       .free =3D mock_domain_free,
> -                       .attach_dev =3D mock_domain_nop_attach,
> -                       .map_pages =3D mock_domain_map_pages,
> -                       .unmap_pages =3D mock_domain_unmap_pages,
> -                       .iova_to_phys =3D mock_domain_iova_to_phys,
> -                       .set_dev_pasid =3D mock_domain_set_dev_pasid_nop,
> -               },
>  };
>
>  static void mock_domain_free_nested(struct iommu_domain *domain)
> @@ -1047,7 +973,7 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mock=
pt_id,
>         if (IS_ERR(hwpt))
>                 return hwpt;
>         if (hwpt->domain->type !=3D IOMMU_DOMAIN_UNMANAGED ||
> -           hwpt->domain->ops !=3D mock_ops.default_domain_ops) {
> +           hwpt->domain->owner !=3D &mock_ops) {
>                 iommufd_put_object(ucmd->ictx, &hwpt->obj);
>                 return ERR_PTR(-EINVAL);
>         }
> @@ -1088,7 +1014,6 @@ static struct mock_dev *mock_dev_create(unsigned lo=
ng dev_flags)
>                 {},
>         };
>         const u32 valid_flags =3D MOCK_FLAGS_DEVICE_NO_DIRTY |
> -                               MOCK_FLAGS_DEVICE_HUGE_IOVA |
>                                 MOCK_FLAGS_DEVICE_PASID;
>         struct mock_dev *mdev;
>         int rc, i;
> @@ -1277,23 +1202,25 @@ static int iommufd_test_md_check_pa(struct iommuf=
d_ucmd *ucmd,
>  {
>         struct iommufd_hw_pagetable *hwpt;
>         struct mock_iommu_domain *mock;
> +       unsigned int page_size;
>         uintptr_t end;
>         int rc;
>
> -       if (iova % MOCK_IO_PAGE_SIZE || length % MOCK_IO_PAGE_SIZE ||
> -           (uintptr_t)uptr % MOCK_IO_PAGE_SIZE ||
> -           check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
> -               return -EINVAL;
> -
>         hwpt =3D get_md_pagetable(ucmd, mockpt_id, &mock);
>         if (IS_ERR(hwpt))
>                 return PTR_ERR(hwpt);
>
> -       for (; length; length -=3D MOCK_IO_PAGE_SIZE) {
> +       page_size =3D 1 << __ffs(mock->domain.pgsize_bitmap);
> +       if (iova % page_size || length % page_size ||
> +           (uintptr_t)uptr % page_size ||
> +           check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
> +               return -EINVAL;
> +
> +       for (; length; length -=3D page_size) {
>                 struct page *pages[1];
> +               phys_addr_t io_phys;
>                 unsigned long pfn;
>                 long npages;
> -               void *ent;
>
>                 npages =3D get_user_pages_fast((uintptr_t)uptr & PAGE_MAS=
K, 1, 0,
>                                              pages);
> @@ -1308,15 +1235,14 @@ static int iommufd_test_md_check_pa(struct iommuf=
d_ucmd *ucmd,
>                 pfn =3D page_to_pfn(pages[0]);
>                 put_page(pages[0]);
>
> -               ent =3D xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
> -               if (!ent ||
> -                   (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZ=
E !=3D
> -                           pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZ=
E)) {
> +               io_phys =3D mock->domain.ops->iova_to_phys(&mock->domain,=
 iova);
> +               if (io_phys !=3D
> +                   pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZE)) {
>                         rc =3D -EINVAL;
>                         goto out_put;
>                 }
> -               iova +=3D MOCK_IO_PAGE_SIZE;
> -               uptr +=3D MOCK_IO_PAGE_SIZE;
> +               iova +=3D page_size;
> +               uptr +=3D page_size;
>         }
>         rc =3D 0;
>
> @@ -1795,7 +1721,7 @@ static int iommufd_test_dirty(struct iommufd_ucmd *=
ucmd, unsigned int mockpt_id,
>         if (IS_ERR(hwpt))
>                 return PTR_ERR(hwpt);
>
> -       if (!(mock->flags & MOCK_DIRTY_TRACK)) {
> +       if (!(mock->flags & MOCK_DIRTY_TRACK) || !mock->iommu.ops->set_di=
rty) {
>                 rc =3D -EINVAL;
>                 goto out_put;
>         }
> @@ -1814,22 +1740,10 @@ static int iommufd_test_dirty(struct iommufd_ucmd=
 *ucmd, unsigned int mockpt_id,
>         }
>
>         for (i =3D 0; i < max; i++) {
> -               unsigned long cur =3D iova + i * page_size;
> -               void *ent, *old;
> -
>                 if (!test_bit(i, (unsigned long *)tmp))
>                         continue;
> -
> -               ent =3D xa_load(&mock->pfns, cur / page_size);
> -               if (ent) {
> -                       unsigned long val;
> -
> -                       val =3D xa_to_value(ent) | MOCK_PFN_DIRTY_IOVA;
> -                       old =3D xa_store(&mock->pfns, cur / page_size,
> -                                      xa_mk_value(val), GFP_KERNEL);
> -                       WARN_ON_ONCE(ent !=3D old);
> -                       count++;
> -               }
> +               mock->iommu.ops->set_dirty(&mock->iommu, iova + i * page_=
size);
> +               count++;
>         }
>
>         cmd->dirty.out_nr_dirty =3D count;
> @@ -2202,3 +2116,5 @@ void iommufd_test_exit(void)
>         platform_device_unregister(selftest_iommu_dev);
>         debugfs_remove_recursive(dbgfs_root);
>  }
> +
> +MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/=
iommu.h
> index 848a5fb76272a9..f2a763aba08846 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -73,6 +73,18 @@ struct pt_iommu_info {
>  };
>
>  struct pt_iommu_ops {
> +       /**
> +        * @set_dirty: Make the iova write dirty
> +        * @iommu_table: Table to manipulate
> +        * @iova: IO virtual address to start
> +        *
> +        * This is only used by iommufd testing. It makes the iova dirty =
so that
> +        * read_and_clear_dirty() will see it as dirty. Unlike all the ot=
her ops
> +        * this one is safe to call without holding any locking. It may r=
eturn
> +        * -EAGAIN if there is a race.
> +        */
> +       int (*set_dirty)(struct pt_iommu *iommu_table, dma_addr_t iova);
> +
>         /**
>          * @get_info: Return the pt_iommu_info structure
>          * @iommu_table: Table to query
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/self=
tests/iommu/iommufd.c
> index 3eebf5e3b974f4..595b0a3ead645c 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -13,9 +13,6 @@
>
>  static unsigned long HUGEPAGE_SIZE;
>
> -#define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
> -#define MOCK_HUGE_PAGE_SIZE (512 * MOCK_PAGE_SIZE)
> -
>  static unsigned long get_huge_page_size(void)
>  {
>         char buf[80];
> @@ -2058,6 +2055,12 @@ FIXTURE_VARIANT(iommufd_dirty_tracking)
>
>  FIXTURE_SETUP(iommufd_dirty_tracking)
>  {
> +       struct iommu_option cmd =3D {
> +               .size =3D sizeof(cmd),
> +               .option_id =3D IOMMU_OPTION_HUGE_PAGES,
> +               .op =3D IOMMU_OPTION_OP_SET,
> +               .val64 =3D 0,
> +       };
>         size_t mmap_buffer_size;
>         unsigned long size;
>         int mmap_flags;
> @@ -2066,7 +2069,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>
>         if (variant->buffer_size < MOCK_PAGE_SIZE) {
>                 SKIP(return,
> -                    "Skipping buffer_size=3D%lu, less than MOCK_PAGE_SIZ=
E=3D%lu",
> +                    "Skipping buffer_size=3D%lu, less than MOCK_PAGE_SIZ=
E=3D%u",
>                      variant->buffer_size, MOCK_PAGE_SIZE);
>         }
>
> @@ -2114,16 +2117,18 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
>         assert((uintptr_t)self->bitmap % PAGE_SIZE =3D=3D 0);
>
>         test_ioctl_ioas_alloc(&self->ioas_id);
> -       /* Enable 1M mock IOMMU hugepages */
> -       if (variant->hugepages) {
> -               test_cmd_mock_domain_flags(self->ioas_id,
> -                                          MOCK_FLAGS_DEVICE_HUGE_IOVA,
> -                                          &self->stdev_id, &self->hwpt_i=
d,
> -                                          &self->idev_id);
> -       } else {
> -               test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
> -                                    &self->hwpt_id, &self->idev_id);
> -       }
> +
> +       /*
> +        * For dirty testing it is important that the page size fed into
> +        * the iommu page tables matches the size the dirty logic
> +        * expects, or set_dirty can touch too much stuff.
> +        */
> +       cmd.object_id =3D self->ioas_id;
> +       if (!variant->hugepages)
> +               ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
> +
> +       test_cmd_mock_domain(self->ioas_id, &self->stdev_id, &self->hwpt_=
id,
> +                            &self->idev_id);
>  }
>
>  FIXTURE_TEARDOWN(iommufd_dirty_tracking)
> @@ -2248,18 +2253,23 @@ TEST_F(iommufd_dirty_tracking, device_dirty_capab=
ility)
>  TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
>  {
>         uint32_t page_size =3D MOCK_PAGE_SIZE;
> +       uint32_t ioas_id =3D self->ioas_id;
>         uint32_t hwpt_id;
> -       uint32_t ioas_id;
>
>         if (variant->hugepages)
>                 page_size =3D MOCK_HUGE_PAGE_SIZE;
>
> -       test_ioctl_ioas_alloc(&ioas_id);
>         test_ioctl_ioas_map_fixed_id(ioas_id, self->buffer,
>                                      variant->buffer_size, MOCK_APERTURE_=
START);
>
> -       test_cmd_hwpt_alloc(self->idev_id, ioas_id,
> -                           IOMMU_HWPT_ALLOC_DIRTY_TRACKING, &hwpt_id);
> +       if (variant->hugepages)
> +               test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
> +                                           IOMMU_HWPT_ALLOC_DIRTY_TRACKI=
NG,
> +                                           MOCK_IOMMUPT_HUGE, &hwpt_id);
> +       else
> +               test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
> +                                           IOMMU_HWPT_ALLOC_DIRTY_TRACKI=
NG,
> +                                           MOCK_IOMMUPT_DEFAULT, &hwpt_i=
d);
>
>         test_cmd_set_dirty_tracking(hwpt_id, true);
>
> @@ -2285,18 +2295,24 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap)
>  TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_no_clear)
>  {
>         uint32_t page_size =3D MOCK_PAGE_SIZE;
> +       uint32_t ioas_id =3D self->ioas_id;
>         uint32_t hwpt_id;
> -       uint32_t ioas_id;
>
>         if (variant->hugepages)
>                 page_size =3D MOCK_HUGE_PAGE_SIZE;
>
> -       test_ioctl_ioas_alloc(&ioas_id);
>         test_ioctl_ioas_map_fixed_id(ioas_id, self->buffer,
>                                      variant->buffer_size, MOCK_APERTURE_=
START);
>
> -       test_cmd_hwpt_alloc(self->idev_id, ioas_id,
> -                           IOMMU_HWPT_ALLOC_DIRTY_TRACKING, &hwpt_id);
> +
> +       if (variant->hugepages)
> +               test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
> +                                           IOMMU_HWPT_ALLOC_DIRTY_TRACKI=
NG,
> +                                           MOCK_IOMMUPT_HUGE, &hwpt_id);
> +       else
> +               test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
> +                                           IOMMU_HWPT_ALLOC_DIRTY_TRACKI=
NG,
> +                                           MOCK_IOMMUPT_DEFAULT, &hwpt_i=
d);
>
>         test_cmd_set_dirty_tracking(hwpt_id, true);
>
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testin=
g/selftests/iommu/iommufd_utils.h
> index 772ca1db6e5971..08e529fde1cc71 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -215,6 +215,18 @@ static int _test_cmd_hwpt_alloc(int fd, __u32 device=
_id, __u32 pt_id, __u32 ft_i
>         ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, 0, =
flags,   \
>                                           hwpt_id, IOMMU_HWPT_DATA_NONE, =
NULL, \
>                                           0))
> +#define test_cmd_hwpt_alloc_iommupt(device_id, pt_id, flags, iommupt_typ=
e, \
> +                                   hwpt_id)                             =
  \
> +       ({                                                               =
  \
> +               struct iommu_hwpt_selftest user_cfg =3D {                =
    \
> +                       .pagetable_type =3D iommupt_type                 =
    \
> +               };                                                       =
  \
> +                                                                        =
   \
> +               ASSERT_EQ(0, _test_cmd_hwpt_alloc(                       =
  \
> +                                    self->fd, device_id, pt_id, 0, flags=
, \
> +                                    hwpt_id, IOMMU_HWPT_DATA_SELFTEST,  =
  \
> +                                    &user_cfg, sizeof(user_cfg)));      =
  \
> +       })
>  #define test_err_hwpt_alloc(_errno, device_id, pt_id, flags, hwpt_id)   =
\
>         EXPECT_ERRNO(_errno, _test_cmd_hwpt_alloc(                      \
>                                      self->fd, device_id, pt_id, 0, flags=
, \
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

