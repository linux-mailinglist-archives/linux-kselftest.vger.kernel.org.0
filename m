Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94D16244A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiKJOtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 09:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKJOtS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 09:49:18 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0856E17063;
        Thu, 10 Nov 2022 06:49:16 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1DF6B732;
        Thu, 10 Nov 2022 14:49:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1DF6B732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668091755; bh=OnvK+2tUvYAfL0KCrr72dtwv0xTn5bAGv19wZNYmwMU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=f+dcELpnMaM1I4cy5d4quAPLBjCS/LGb+m7YcVxJ6Z39qJd41+owPjkcNC3fnzh+0
         2cVitnOOfzPKSqEzvOo8aJptjL4/EwAfILChx9pe2CeyyS7um7qnkYijGs6By4hsy3
         JRvNdmD3FXnAmMqbW4YW6otpVoSTjRJOGidR25+yyypyVOzlnKP/h0/lFRRPPUB4j+
         XTy7Yse+CL3yzh9nxnqHsoC/ooZbTZf/ifnGaRuVNSYQbcWeaXSQOh+dM4UfrttnxT
         h3iWuKUsFl3UT0CI3U5dx4ffobEydI44ecNfpm3/bxGQi8nqR9b04rIizVN2dFkMpv
         8BmSo3l60hlPg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     bpf@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
In-Reply-To: <Y2zE0zfnQ7mt740i@debian.me>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2zE0zfnQ7mt740i@debian.me>
Date:   Thu, 10 Nov 2022 07:49:14 -0700
Message-ID: <87v8nmhnkl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Mon, Nov 07, 2022 at 08:48:57PM -0400, Jason Gunthorpe wrote:
>> From: Kevin Tian <kevin.tian@intel.com>
>> 
>> Add iommufd into the documentation tree, and supply initial documentation.
>> Much of this is linked from code comments by kdoc.
>> 
>
> The patch also exposes htmldocs warnings as Stephen Rothwell has
> reported on linux-next [1] due to the copyright comments mistaken for
> kernel-doc comments, so I have applied the fixup:
>
> ---- >8 ----
>
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 536a34d099968d..76b3761a89423e 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> +/*
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES

Um ... this makes no sense at all.  If kernel-doc thought that was a
kernel-doc comment, the problem is there, not here.

<looks>

So the report you're referring to is

  https://lore.kernel.org/linux-next/20221110182938.40ce2651@canb.auug.org.au/

?  If so, this change will not fix the problem.  That error:

> drivers/iommu/iommufd/device.c:1: warning: no structured comments found
> drivers/iommu/iommufd/main.c:1: warning: no structured comments found

is caused by using .. kernel-doc:: directives to extract documentation
from files where none exists - thus "no structured comments found".

The *real* problem, methinks, is that the directives are added in patch 4
of the series, but the documentation doesn't show up until later.  So
the real fix would be to simply move this patch down.  Or just not worry
about it, since it all works out in the end and nobody will be bisecting
a docs build.

Bagas, you are *again* misadvising people.  Please stop doing that!

Thanks,

jon
