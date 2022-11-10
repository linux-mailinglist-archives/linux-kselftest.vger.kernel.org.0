Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90162465A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 16:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKJPwU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 10:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiKJPwS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 10:52:18 -0500
X-Greylist: delayed 3783 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 07:52:18 PST
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640762FC20;
        Thu, 10 Nov 2022 07:52:18 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7B7C037E;
        Thu, 10 Nov 2022 15:52:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7B7C037E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668095537; bh=xpFTWZn9sbFBGd6WKn9o/SIHLSDqMwfNDLiBmx96Qjw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=quXtIBVHhn6GRJvpgOS+7BTs3aZN6UDPSZkHRixCPa1D2mE8KI2+f7xpptqPAUzCb
         iYmP6g2ejS1Cn6vCrSix4w9C3MBwyU0eSF4mclPDsgxBks6KOFxoiDds4MYkj7xKdU
         Sot2p5dw8GRWYAFNKJLjgBFdyLG0KCcVsMJkM4vTQg0crFcfmHbprSaz5LBVmEaVRk
         wuq/T23gU9DmYOUF9KeNhvxdk7awpM/9NRTvATLZjhGjcG+++PIQbf/zWiZBQC4L9m
         +TU3oQG1Js9TOxRMlqh0Riw1SkkS8CRV4dVRvH6FHCwiBWfztDHquhlc3LZDzdHp7R
         y4+9067GwoQYg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, bpf@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
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
In-Reply-To: <Y20Y9Jlp3vG8x27a@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <Y2zE0zfnQ7mt740i@debian.me> <87v8nmhnkl.fsf@meer.lwn.net>
 <Y20QotPsxivvV53l@nvidia.com> <87r0yahmlg.fsf@meer.lwn.net>
 <Y20XhjH96k4x7qdx@nvidia.com> <87mt8yhlqr.fsf@meer.lwn.net>
 <Y20Y9Jlp3vG8x27a@nvidia.com>
Date:   Thu, 10 Nov 2022 08:52:16 -0700
Message-ID: <87iljmhknj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> writes:

>> Single is nicer but it's not worth a great deal of angst; nothing we do
>> is going to turn kernel-doc into a thing of beauty :)
>
> I will leave it be then because it is a bit tricky to tell if the new
> regex breaks anything, and the first three attempts to create it
> didn't work at all...

That's fine.  If you want to keep it as part of your series feel free to
add:

Acked-by: Jonathan Corbet <corbet@lwn.net>

Otherwise I can carry it through the docs tree.

Thanks,

jon
