Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECFC690E27
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 17:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBIQRE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 11:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBIQRC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 11:17:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378559E7B;
        Thu,  9 Feb 2023 08:16:58 -0800 (PST)
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCMMc4S8Lz67ZcT;
        Fri, 10 Feb 2023 00:12:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Feb 2023 16:16:55 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.017;
 Thu, 9 Feb 2023 16:16:55 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH 00/17] Add Intel VT-d nested translation
Thread-Topic: [PATCH 00/17] Add Intel VT-d nested translation
Thread-Index: AQHZPD95hqLckmeZEk+opw51qnHtYq7GX1jwgABqPwCAAAE1QA==
Date:   Thu, 9 Feb 2023 16:16:55 +0000
Message-ID: <7608ccc7c989483c80089e98d64bc1eb@huawei.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <0bea6077f0634587b744ec2b421205e1@huawei.com>
 <Y+Ua/KKu9/YuywyN@Asurada-Nvidia>
In-Reply-To: <Y+Ua/KKu9/YuywyN@Asurada-Nvidia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.52]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Nicolin Chen [mailto:nicolinc@nvidia.com]
> Sent: 09 February 2023 16:11
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Yi Liu <yi.l.liu@intel.com>; joro@8bytes.org;
> alex.williamson@redhat.com; jgg@nvidia.com; kevin.tian@intel.com;
> robin.murphy@arm.com; cohuck@redhat.com; eric.auger@redhat.com;
> kvm@vger.kernel.org; mjrosato@linux.ibm.com;
> chao.p.peng@linux.intel.com; yi.y.sun@linux.intel.com; peterx@redhat.com;
> jasowang@redhat.com; lulu@redhat.com; suravee.suthikulpanit@amd.com;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org;
> linux-kselftest@vger.kernel.org; baolu.lu@linux.intel.com;
> zhangfei.gao@linaro.org
> Subject: Re: [PATCH 00/17] Add Intel VT-d nested translation
> 
> Hi Shameer,
> 
> On Thu, Feb 09, 2023 at 10:11:42AM +0000, Shameerali Kolothum Thodi
> wrote:
> 
> > > This series first introduces new iommu op for allocating domains for
> > > iommufd,
> > > and op for syncing iotlb for first stage page table modifications, and then
> > > add the implementation of the new ops in intel-iommu driver. After this
> > > preparation, adds kernel-managed and user-managed hw_pagetable
> > > allocation for
> > > userspace. Last, add self-test for the new ioctls.
> > >
> > > This series is based on "[PATCH 0/6] iommufd: Add iommu capability
> > > reporting"[1]
> > > and Nicolin's "[PATCH v2 00/10] Add IO page table replacement
> support"[2].
> > > Complete
> > > code can be found in[3]. Draft Qemu code can be found in[4].
> > >
> > > Basic test done with DSA device on VT-d. Where the guest has a vIOMMU
> > > built
> > > with nested translation.
> 
> > Thanks for sending this out. Will go through this one. As I informed before
> we keep
> > an internal branch based on your work and rebase few patches to get the
> ARM
> > SMMUv3 nesting support. The recent one is based on your
> "iommufd-v6.2-rc4-nesting"
> > branch and is here,
> >
> >
> https://github.com/hisilicon/kernel-dev/commits/iommufd-v6.2-rc4-nesting
> -arm
> >
> > Just wondering any chance the latest "Add SMMUv3 nesting support"
> series will
> > be send out soon? Please let me know if you need any help with that.
> 
> I had an initial discussion with Robin/Jason regarding the SMMUv3
> nesting series, and I received quite a few inputs so I'd need to
> finish reworking before sending out -- hopefully we can see them
> in the maillist in the following weeks.

Thanks for that update. Sure, looking forward to it.

Shameer
