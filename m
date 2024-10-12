Return-Path: <linux-kselftest+bounces-19597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A049499B2E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2558EB2288C
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E11531D2;
	Sat, 12 Oct 2024 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdV0GKgr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7738145A19
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728296; cv=none; b=SpFM/iFrXSPmIsUhNGhx51ZkI0q7SZkl5ZNKPOCcLA3z712AlNA9vRy8DXRiKraIgSsxAA1zSBOLXD+pMnath2fQmlV3xgEcJLTXuJ0jdYaB5Tv9mNkIEwl3RPXb35xxpu6EMgGJEFV25vuViw+94v0yaPPo+bsxgHsJ5WkMPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728296; c=relaxed/simple;
	bh=suB/gvK3RVIdTIVj3t4mfWLPv0ww9krbFp7E65wTf2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYx21+P2UWqDCEMvNCRm3dI9b0yB4xH1STQVdtr6dBj4cNdJXuua4lRNsh8BZ6E8rutfCRR0BYidfkXnTqEyaTxVhIUS8EXB+YGQCs3cfHaLHYtdP5M5NmQO6IJmPNzAQ7VFw5Gk9RIarfTfu4oOoW/YC2qbkUxx8cp5083zo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kdV0GKgr; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so3431315e87.0
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Oct 2024 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728728293; x=1729333093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TqMjcC1AHeZ0rlGgmH16x4sW7vgPdZLOnPDdmB4aH0c=;
        b=kdV0GKgrkR6OTSbiSAd35ytNLVLJsxnzi5wlfbMBSTZ2HLCbTFssYLg59F9OaX8cYi
         nDmAjfMc7CTEKh+kzrGEx0LVXbp7H7VICrYslyxzSVjN9aBFbEfpD72cyuKtOS1GZ0/o
         BZ7YDh6LFbqNFn0y3c69dguQ3ed9AzlBnC0rlnar3Q0wvZA7jRr5DcJHgDKyOagSbUTm
         tb9V/HHYzhUCeOJmqIsI3fUOgEN7/UEJEzT4IUv11Vmzp746mW/FXFm4raxaDQmWvwvV
         qyL4FU2g6mZWOFJ/E3ZZBmgHMHJyqZlGfkyF8sm6UYlp5cahi0vlrXyNEw5DqvZPf43+
         NWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728728293; x=1729333093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqMjcC1AHeZ0rlGgmH16x4sW7vgPdZLOnPDdmB4aH0c=;
        b=oyZMsVV8FYqRxzbNlbnn4u/UtgvxdRPt6oIPuR8F7NDkaNvvaThYHRVPhw6aWISzKV
         2n5ID8KTqg/x4VCoipQ4pcePw36TzYTzMyHhU2jMETS3Mh/PyvW5/+secQGhI0VUxt87
         yhBzihbxlEbhG8gL61Ha0jDLHrrWXOnfLS2gNMfNBe870IFOGPA0TI69klRTmb0mZb+c
         kpNXBGffX4r+IMGKTUmjci/cywUwQtwKJQFUJ+T/QTwXt8JG5El7p8M23DzkfY+yIHlT
         8djj9j7Tm/uXRAA0RDOysE+S2liaWisBbm18oywGKKmsTyy44PetmFl0KNDBWgxOydTl
         AvkA==
X-Forwarded-Encrypted: i=1; AJvYcCUjDD1c7rGGeHHydm03+FuRFtiA0RB10agJOgwgalpLaIKaxbVOPMZIKXPk0YP3JZmPUvfxLHVVhOTZIZ+uWsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUXbOnYuPgldWc/mFmCij/WaYsAhMsBcfzke2crwnyvOZir6H
	C0UqolV/2oZxN9sxZGcoS9zUmsrEq5P2WqvY4TrYbC3oQCYnBZmE+wZy8GcKG6/mt8iNj2yl4Hz
	7OTdTdbTAwEMh5BUW7K1JU8K39+kEXGzJ/tRXgw==
X-Google-Smtp-Source: AGHT+IGKwx5nKYmIdfK4265lwZmlfRajEDE6ymLUhhDbGn/6VtvHNpCQcZb2C0Db73mm6sCx/G3nlJDjNP9fje8CkFg=
X-Received: by 2002:a05:6512:b9e:b0:52e:fa6b:e54a with SMTP id
 2adb3069b0e04-539da4d53femr2076954e87.30.1728728292983; Sat, 12 Oct 2024
 03:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com> <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
In-Reply-To: <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sat, 12 Oct 2024 18:18:01 +0800
Message-ID: <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com, 
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com, 
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com, yi.l.liu@intel.com, 
	aik@amd.com, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 12:49, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Sat, Oct 12, 2024 at 11:23:07AM +0800, Zhangfei Gao wrote:
>
> > > diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> > > new file mode 100644
> > > index 000000000000..c1731f080d6b
> > > --- /dev/null
> > > +++ b/drivers/iommu/iommufd/viommu_api.c
> > > @@ -0,0 +1,57 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> > > + */
> > > +
> > > +#include "iommufd_private.h"
> > > +
> > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > +                                               size_t size,
> > > +                                               enum iommufd_object_type type)
> > > +{
> > > +       struct iommufd_object *obj;
> > > +       int rc;
> > > +
> > > +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > > +       if (!obj)
> > > +               return ERR_PTR(-ENOMEM);
> > > +       obj->type = type;
> > > +       /* Starts out bias'd by 1 until it is removed from the xarray */
> > > +       refcount_set(&obj->shortterm_users, 1);
> > > +       refcount_set(&obj->users, 1);
> >
> > here set refcont 1
> >
> > iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
> > IOMMUFD_OBJ_DEVICE): refcont -> 1
> > refcount_inc(&idev->obj.users); refcount -> 2
> > will cause iommufd_device_unbind fail.
> >
> > May remove refcount_inc(&idev->obj.users) in iommufd_device_bind
>
> Hmm, why would it fail? Or is it failing on your system?

Not sure, still in check, it may only be on my platform.

it hit
iommufd_object_remove:
if (WARN_ON(obj != to_destroy))

iommufd_device_bind refcount=2
iommufd_device_attach refcount=3
//still not sure which operation inc the count?
iommufd_device_detach refcount=4

Thanks



>
> This patch doesn't change the function but only moved it..
>
> Thanks
> Nicolin

