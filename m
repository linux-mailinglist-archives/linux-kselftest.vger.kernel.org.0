Return-Path: <linux-kselftest+bounces-19620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3280099C256
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E567B28109A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C31547F2;
	Mon, 14 Oct 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9TDCI8u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005514F114
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892751; cv=none; b=FJuTmuQkBL/DUqH7UWTGM9NXWbdPCnDrbzEkNq1k7BJbja983a9Zvwga7EqkHVhQiMYdDseSFBrBPMkSWbHb/HGtkBaqHz16TdLAsKuy8SPGCI0Js0ORAFq4HVcI9HD0SF5jIljVYL5AzW8TYUKw/0KimH6ieP2Y3MeVQqfyhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892751; c=relaxed/simple;
	bh=oFF6VHGttnHusqmr3FN2QG++jdlGO4+8p6CDui+ULbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4OjiFekCZt27T+nePVu74I6DO2az53FvPhjT3GgbkwCl0p/B7Yo4A0TlaKBrFn/Ty4JDs9tBA/+MB3Psygt/pXyffs523cWXU1uBrn1hMCX/vDkNHrGdbBFqpfkl/3Xm3VNxtya9KvzOQQZ6BXMWtUZr/vERtcAopHGgnYgtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o9TDCI8u; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb518014b9so3317701fa.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728892747; x=1729497547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ScjclWrKfNDFbBysTklj+SJ3rFHMGEWxbh3si/BH/Zk=;
        b=o9TDCI8uYdE8bghe9DJ03+YaGJYMSgN/XTBXs4N/EutsP9/OF7mWXqiDevOdbsrXNZ
         bl+pJjxhSPi8EtW8MQ5hyi3/uXSJUlgEeLXi2Svt0xOJNck6ERBuSFjiZr/v8K7hYWim
         4szAFuZCp89lSx7ZwMG3EWDSDNJtHayHBk3EesPgklFkDQ0a+67YY3RSQtIxfA+xaHks
         clLQLEGTnynb8JzzOrhXn0psy3yArNCfTEFHhsAnXIoTwzZJn0paajQm5NPglrg/0Ciu
         kyht2LBrIhR5M5D+QwZF2IhWa9R1WEZI3zS011z7ZDFCzh6L/Y6t5D1lq3K55CKCGk9L
         Rnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892747; x=1729497547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScjclWrKfNDFbBysTklj+SJ3rFHMGEWxbh3si/BH/Zk=;
        b=C4n9lip+swS3f8RLHh2KnB1W1zS3akHGaNfxb8JNYsPQjmOK+4ICSXESc684up39ar
         ur0a4s4hsCnFbcwQjvIlbIIooVIBnSCi4YIFi3dddnougQwvKJatwLS6zHvFt6Qqe3HN
         oP+oMKCDj0JKxg4xeVWfgs6rA9/NU1hz1Egu7cOQI82/Tw+4EjOHg7WC9z8soiunKmya
         7Y+HuJK2Rb6NKSO3nWGmDUMicvU9nBaDoi4VSGTimcCAvwtNC5thgTa4rBkxPI1gxOOS
         FM3D5Dyai+eiYbQeGKX5cMlxPT1ag/sT5zsrQNY2RtbVh/430qjzB5KMt432zt6rrk2/
         dJpg==
X-Forwarded-Encrypted: i=1; AJvYcCX8NcPDaDVn/jKGjig+MLM6Y1np2STiFmyJq9HvBkqaZbPsvdoCP5rxpZvRFnRP/GRnTVy5CQu9/HKENKCr/IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoUkmF4MbHjHsdNN2G5k9PC/u/SA6+WsgUF7CVcL46iJkfGYY
	mbe/lwX4JUHnGHILWWPPfJGuyhb6IKZJ9W0ATfRAXeYsBlC5ioGBqb7jox64IPUB+uaM+Oh2TI6
	vCBPbjUDmb053wjJ13jEEom4nKiHCiEafvTMlYA==
X-Google-Smtp-Source: AGHT+IEKyEtol/S+SVKZojpSYhC7ViJe62dDg31X0hlm2J4WIW4keP+c77Z9R7yIc1BX887mjL23tAglKwfPJlsZKB8=
X-Received: by 2002:a05:6512:3e21:b0:539:ebb6:7b36 with SMTP id
 2adb3069b0e04-539ebb67d8cmr1600580e87.25.1728892746567; Mon, 14 Oct 2024
 00:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728491453.git.nicolinc@nvidia.com> <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia> <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
In-Reply-To: <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 14 Oct 2024 15:58:55 +0800
Message-ID: <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
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

Hi, Nico

On Sat, 12 Oct 2024 at 18:18, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> On Sat, 12 Oct 2024 at 12:49, Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > On Sat, Oct 12, 2024 at 11:23:07AM +0800, Zhangfei Gao wrote:
> >
> > > > diff --git a/drivers/iommu/iommufd/viommu_api.c b/drivers/iommu/iommufd/viommu_api.c
> > > > new file mode 100644
> > > > index 000000000000..c1731f080d6b
> > > > --- /dev/null
> > > > +++ b/drivers/iommu/iommufd/viommu_api.c
> > > > @@ -0,0 +1,57 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> > > > + */
> > > > +
> > > > +#include "iommufd_private.h"
> > > > +
> > > > +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
> > > > +                                               size_t size,
> > > > +                                               enum iommufd_object_type type)
> > > > +{
> > > > +       struct iommufd_object *obj;
> > > > +       int rc;
> > > > +
> > > > +       obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> > > > +       if (!obj)
> > > > +               return ERR_PTR(-ENOMEM);
> > > > +       obj->type = type;
> > > > +       /* Starts out bias'd by 1 until it is removed from the xarray */
> > > > +       refcount_set(&obj->shortterm_users, 1);
> > > > +       refcount_set(&obj->users, 1);
> > >
> > > here set refcont 1
> > >
> > > iommufd_device_bind -> iommufd_object_alloc(ictx, idev,
> > > IOMMUFD_OBJ_DEVICE): refcont -> 1
> > > refcount_inc(&idev->obj.users); refcount -> 2
> > > will cause iommufd_device_unbind fail.
> > >
> > > May remove refcount_inc(&idev->obj.users) in iommufd_device_bind
> >
> > Hmm, why would it fail? Or is it failing on your system?
>
> Not sure, still in check, it may only be on my platform.
>
> it hit
> iommufd_object_remove:
> if (WARN_ON(obj != to_destroy))
>
> iommufd_device_bind refcount=2
> iommufd_device_attach refcount=3
> //still not sure which operation inc the count?
> iommufd_device_detach refcount=4
>

Have a question,
when should iommufd_vdevice_destroy be called, before or after
iommufd_device_unbind.

Now iommufd_vdevice_destroy (ref--) is after unbind, hits the if
(!refcount_dec_if_one(&obj->users)) check.

iommufd_device_bind
iommufd_device_attach
iommufd_vdevice_alloc_ioctl

iommufd_device_detach
iommufd_device_unbind // refcount check fail
iommufd_vdevice_destroy ref--

Thanks

