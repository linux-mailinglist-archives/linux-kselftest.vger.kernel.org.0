Return-Path: <linux-kselftest+bounces-44370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85691C1DFD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 02:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6319C4E2F60
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 01:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5184822172E;
	Thu, 30 Oct 2025 01:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huJLM49L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14123E229
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786468; cv=none; b=SdbyhQdRVster3MVxcreKqp54JTP85KQYFcHDu79z0dPrmKGaMVVyUIzJWvPtO+XNQgFLqiyB71YQLSbpwV5MjbgGx/wv8sO313erNguGMT/f+tUEhqak548PTV9ZbvmpR9AFP4Ugh6LFGCIsZA5fA5XWtuI7pkv0ztHxRSxOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786468; c=relaxed/simple;
	bh=8tAWjgpXV1eqZ8A1xZ+NFLAkTUNs/79UOfIRKhLL2sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdDae5y9oiiLsTVTNnROtHNNIICmzupWz8AKxe1pABQCjAbUPncF1+0Xj4QzFHUCSg0jV8HAl0IL6XeLYaT88zphwOtf9sLpsn24Qh1GG6JJJ1lCjWBLawLjSVtUiRn3Npt2gDaDvEG6C0GxdkzJSds4yWfxEfe7JUIHorzGF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huJLM49L; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ecfafb92bcso93831cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761786465; x=1762391265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id3gb4VM70r8JjlpIpMntwH9hB/tw0n4UthxF1ao5+Q=;
        b=huJLM49Lmk7Llj+uc1Bnpc/xoBjCpdOeSXc8Zn8yOzxkYUqSwa5WyEGJw4dqcpfrbY
         7TN7UF37l5GbZm5z6uRDXPuK8iKOx0LHIYBVOiC0HF3R3Ta4QyWsMLMOMChDVVSQDape
         GkYUFd0rKcoRJvmCph66zeRQSezRdrqi0Wz77BmHaAn4blaUAD6SIf2cbL3gnsVkvJEV
         8D9IlYXNlG/UIDDV+bnRpkfVP0iVOqB8ARJzxigVKYi/XjvZmK4rY+XzyFDQuVkEVD+G
         Jn/y92hOBsJcul46aSDPnX5qR1gDgA7CyNVU7mfrD7s0dTPrroLsta9UGb7IJ73/4M9S
         hSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761786465; x=1762391265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id3gb4VM70r8JjlpIpMntwH9hB/tw0n4UthxF1ao5+Q=;
        b=kCmTrq80ECZRcEwY8IMIgMDPSE7xfbjM7jd3Sn36acQTj3FKFXLVkg42Us/Mp6A8rE
         Bi7d6sAC42MsJe+ePDaBAB5RGb1IGAOlY7zIpUPo7+mj4s2CvNtipkcrGZarm8rino7Z
         RypLMvSFN0YjPwzRVN6O7wovygV+Yk2mq7jVGV0ssxwj2xg+MMt13kBiyBOMI5OpLnNE
         YqMj4X1zNzoPwv5WhMT3MSuLL8TX7FkeqSFKQW4GFfPBUsWai52CWDBGmyhj9hdnpyRR
         ac3M+Gzu16tIgecy14yRLjXOOsO5OikCo6pZ+Gtg51+63sfyL6O1H2Liy67WwR0qDP6m
         LZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI2DX1YDmEx0oGtH5b6T9sn7CxFT8F0XrYmz9ay9u/lWH3rnxvdaGqF6ZZpEKHFvm+FwPsuI17XDGlN1pkZ/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvPs3YL+/B2KgNfKiXjPqy5mn1mvc1xqM6Ta60wHcDTDBEp8B
	ANCx3Jj9f+D30QHCY+nUJ+9R44FAflZBIR94PXJc6YDaJyH2kacH8924r9ZwFivDhj2ix0K6Hyi
	SLZ02B+DGR+5JZ7/Ny89FveJngxatX+6hxY7AiVM6
X-Gm-Gg: ASbGncu8yundBygJA1G1xFRVj3QfAVYCQZh49VTKcc6Di2RmIGYy710WM3JoYU1CaCA
	+JcCFy1Q4P0070ssPMFKi7uEwZqGMWrDpMSOId5HWDAIdpObr8VnxTERDWrKjt97vHa88UaWTGg
	blJ3iS7lWPIHhJmf8n3wokHz71SLR0oYti2a8nXwQYcvcyCBufjxtB+WtO2xUw2sd6/Bbz1iuSA
	J+BLTiOac0tgav4u1K/F0OByr2rRtiikgCL0sIQIZsB5Rqg5Q1R3rd0iFbhjAbcuoYiDId/UgAU
	9uEYqIIe3Ak0/vnCakKh9HbCnP5b
X-Google-Smtp-Source: AGHT+IGk+D8yQ9+SwKPD0nEhpyf/NXripmysWq7Sb6LYWYRSuXaYyS1yHre0OvZakqvcTcUMROj68CxyaozwBa97GHQ=
X-Received: by 2002:a05:622a:260d:b0:4e5:8707:d31 with SMTP id
 d75a77b69052e-4ed23bf51a5mr1888081cf.7.1761786465168; Wed, 29 Oct 2025
 18:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <10-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <10-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 29 Oct 2025 18:07:33 -0700
X-Gm-Features: AWmQ_bkkP7FCKXR-SsBvX0XmrZ4yVNMBIM5BqatCpZRvsfd8j587v0wxvY7VreQ
Message-ID: <CAAywjhRW17C-RbqM6zUSuEF7mB2SXzK1E_zthHJ9iJaEo6ejxQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/15] iommupt: Add a mock pagetable format for iommufd
 selftest to use
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
> emulate a page table. Slightly modify the amdv1 page table to create a
> real page table that has similar properties:
>
>  - 2k base granule to simulate something like a 4k page table on a 64K
>    PAGE_SIZE ARM system
>  - Contiguous page support for every PFN order
>  - Dirty tracking
>
> AMDv1 is the closest format, as it is the only one that already supports
> every page size. Tweak it to have only 5 levels and an 11 bit base granul=
e
> and compile it separately as a format variant.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/fmt/Makefile     |  1 +
>  drivers/iommu/generic_pt/fmt/amdv1.h      | 18 ++++++++++++++++--
>  drivers/iommu/generic_pt/fmt/iommu_mock.c | 10 ++++++++++
>  include/linux/generic_pt/iommu.h          |  6 ++++++
>  4 files changed, 33 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c
>
> diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generi=
c_pt/fmt/Makefile
> index 32f3956c7509f8..f0c22cf5f7bee6 100644
> --- a/drivers/iommu/generic_pt/fmt/Makefile
> +++ b/drivers/iommu/generic_pt/fmt/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) +=3D amdv1
> +iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) +=3D mock
>
>  IOMMU_PT_KUNIT_TEST :=3D
>  define create_format
> diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic=
_pt/fmt/amdv1.h
> index 706a70c8603017..81ced24585ff93 100644
> --- a/drivers/iommu/generic_pt/fmt/amdv1.h
> +++ b/drivers/iommu/generic_pt/fmt/amdv1.h
> @@ -26,11 +26,23 @@
>  #include <linux/string.h>
>
>  enum {
> -       PT_MAX_OUTPUT_ADDRESS_LG2 =3D 52,
> -       PT_MAX_VA_ADDRESS_LG2 =3D 64,
>         PT_ITEM_WORD_SIZE =3D sizeof(u64),
> +       /*
> +        * The IOMMUFD selftest uses the AMDv1 format with some alteratio=
ns It
> +        * uses a 2k page size to test cases where the CPU page size is n=
ot the
> +        * same.
> +        */
> +#ifdef AMDV1_IOMMUFD_SELFTEST
> +       PT_MAX_VA_ADDRESS_LG2 =3D 56,
> +       PT_MAX_OUTPUT_ADDRESS_LG2 =3D 51,
> +       PT_MAX_TOP_LEVEL =3D 4,
> +       PT_GRANULE_LG2SZ =3D 11,
> +#else
> +       PT_MAX_VA_ADDRESS_LG2 =3D 64,
> +       PT_MAX_OUTPUT_ADDRESS_LG2 =3D 52,
>         PT_MAX_TOP_LEVEL =3D 5,
>         PT_GRANULE_LG2SZ =3D 12,
> +#endif
>         PT_TABLEMEM_LG2SZ =3D 12,
>
>         /* The DTE only has these bits for the top phyiscal address */
> @@ -378,6 +390,7 @@ static inline int amdv1pt_iommu_fmt_init(struct pt_io=
mmu_amdv1 *iommu_table,
>  }
>  #define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
>
> +#ifndef PT_FMT_VARIANT
>  static inline void
>  amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
>                           const struct pt_range *top_range,
> @@ -388,6 +401,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *tabl=
e,
>         info->mode =3D top_range->top_level + 1;
>  }
>  #define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
> +#endif
>
>  #if defined(GENERIC_PT_KUNIT)
>  static const struct pt_iommu_amdv1_cfg amdv1_kunit_fmt_cfgs[] =3D {
> diff --git a/drivers/iommu/generic_pt/fmt/iommu_mock.c b/drivers/iommu/ge=
neric_pt/fmt/iommu_mock.c
> new file mode 100644
> index 00000000000000..74e597cba9d9cd
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/fmt/iommu_mock.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + */
> +#define AMDV1_IOMMUFD_SELFTEST 1
> +#define PT_FMT amdv1
> +#define PT_FMT_VARIANT mock
> +#define PT_SUPPORTED_FEATURES 0
> +
> +#include "iommu_template.h"
> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/=
iommu.h
> index 03a906fbe12a83..848a5fb76272a9 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
> @@ -237,6 +237,12 @@ struct pt_iommu_amdv1_hw_info {
>
>  IOMMU_FORMAT(amdv1, amdpt);
>
> +/* amdv1_mock is used by the iommufd selftest */
> +#define pt_iommu_amdv1_mock pt_iommu_amdv1
> +#define pt_iommu_amdv1_mock_cfg pt_iommu_amdv1_cfg
> +struct pt_iommu_amdv1_mock_hw_info;
> +IOMMU_PROTOTYPES(amdv1_mock);
> +
>  #undef IOMMU_PROTOTYPES
>  #undef IOMMU_FORMAT
>  #endif
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

