Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598CB61FAB8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiKGRBC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 12:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiKGRBA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 12:01:00 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D172250B;
        Mon,  7 Nov 2022 09:00:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmhQCtAmDAu6Eq2N7DwmNYMFFyeOXU4AK8QgRYbW1pQt7NE5BqaL3SJgG4taFeNXRVb32iLc6PrCVJbcrQO/mUO9fFc2OkAPYdz4utPSlnEjsX2Mx2xolUGw3d9xnmr+HcCvOQ+N53wryXOjGqBJcBuRtI3H4zyNLN6zC//i+K+GEmlAUvbCVLPbhBmmFtJY9RI1zuxDpSLJ2iMCEocyzGzaSU+Ii3LOyDpeKAQtBW12BLAeiQ7vJ1Q7dMOBjK7Bpk7RDRXtnildxvKgAI/8pFURYr9oCVnLN86vBDjdFWfQngvfKI7fQLXN3+5GeWR1p9hRyknsUggk1Q9KrKUsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q86kIaktkqg5dJmgcVvPJJ5cKL0IhXPDeN1hkLVuMtM=;
 b=SuIVerdy9yVzRejdL5dOaVDbr3JyxdiwKQHoUvI91PEduNOtDQe/45V67pxGNb6k4SkWzG29pvBWwRH7IMMz9/pGKkgocFXf05xsS7Fwc4DmBOtE2H1oJgGvqzkzjJbFo8xGNGnftnyrTHNAKEgj1yvGBYCaZISNeDYPhNByHx/ivxAYWeBX8TIPU0Hc1HvbNLqL5VXmEE1lvtfI+N9fF5cqNkELGHf9amMly15eG6u8Q6wWCvDuJ2Ys6S6KuANbH00m5ceOAVUGG/VmuLAVS+Il3P0QbGCo91eR0DURgtTGEUTlJhn3DzHtOt0DOmXdC2ekjhu8GRHybEHqbnClOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q86kIaktkqg5dJmgcVvPJJ5cKL0IhXPDeN1hkLVuMtM=;
 b=KH+nCHtogbWI1JhfdF0OplRm9v0H8n8rg9K1x60W8un6UZ0+YfjNUv1N0sobHWL5pX6Av2FUC+MctOY4EcxwWWZc3v/DD+peNbwCfrjN27+Zb5V8b1dBehpb6eCjFqy6MZPip9gdKrISwYSO2LmZbP2sTL16zNWuSZhUMc/RWQ3MXA0u+WMW1q6ezPMR6WeTx23Jwosa9EM00Yjyt4lm6KzgztPJgAKkLMvzaXeUv/Sle367DQ74o6C8cfKALc4Jraol+SqZGCnG2ftwP9u71L9L5t+8ULFLg/x0LWFOQI+xT3JkvJ+QvHHB7qrCijTnk0CjFN6nwA21L1/kmyyPZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 17:00:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 17:00:53 +0000
Date:   Mon, 7 Nov 2022 13:00:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 05/15] iommufd: File descriptor, context, kconfig and
 makefiles
Message-ID: <Y2k5xIp3TksL94MV@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <5-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB527695C6CE5BEA4AFACF3DBB8C389@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527695C6CE5BEA4AFACF3DBB8C389@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a65bd6-6e9c-49b7-5bbe-08dac0e1a129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPOV6R+BKNUxNo3VxvreQH+55vSJpDYweNjze+MqxcvlgEdV52nlQgk0hruycLfrhid0Loylht3MfDtUyhf1k7ww57WLcgRYbAJvB6aRDwAzVR8FNC2ftToinI6HKNwjS1yYXJtslGxwWLfv+D+sv+4qkF1QEClWKuxl+fVKBpyBk6G0ZtMHcfr3Vhm3N75znZxLdMX9FjTrwIFkll8AejHw+dk87rfZZNVSpWUQsy1FpqT4Zf6nc0G/4zODFnGNc973KH728eicOCaVHl0QFMhZVMow/or2F0yS6x6zrgd243Br5KiCoNn0ErQWj/PHlVHc5d4OjtqV1XDfgK5ZMt5peH6grhc0MB2SNoulzpMJYzGNRXzzYJO+qDEu5Z1MRK+jnFZEZDcgIeshCJvQCHgW/K6n4Ev0UCMagF0aCBaQumE2YSLUIztQ99ugpCyTVaxo4e10OJeZd+TCeOc4lCf+JKe51D9qFGp6BsPuSw3br51vWkIuGO50xRtdDEZCRNfLKZFvxmaSGsn3pCgpuLHPE0fY5+x+c0aYQRUZKxiheeOAXJ5e0BM4FczynSaxCnm7xcuLI33OC5A2EVMo7MDHimQ1PQTZKk1ogOgFLUzP+ZV73neMpTjH/J7nft8w1G4cEg1/1fLbwiz4Db1oTuAdbbQ0XxcO6G0sUSo8W61zrkg+G6/lxUh18fra+bCfeY7dnt4Z/PmY8mYUyHmArA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(66899015)(2906002)(7416002)(5660300002)(8936002)(7406005)(6506007)(2616005)(36756003)(8676002)(6486002)(66946007)(66556008)(66476007)(4326008)(38100700002)(6916009)(54906003)(316002)(86362001)(41300700001)(6512007)(83380400001)(186003)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7myQjLT/aIppn1xgVdjH2Oqf2o/DhSFuRS4YP3U+ZYQARgIsXoTBuD+3+7dO?=
 =?us-ascii?Q?PWxTAyGCf0qLYzKAp/jXgiPz3aK0ZQ2vNunxQ76uHA9j+DklQgslxfWeBWXj?=
 =?us-ascii?Q?foHY6FyNcnCrHty5h4rE5ZjLOf+bPuYKPVzX3PVtDYcFl+yPYeNKiAUnjvOi?=
 =?us-ascii?Q?/PripGLLzUMNjKqAHdqTBS4JcrfNJpABf0DMPC3+IavChnPRYNrohgsBs9LD?=
 =?us-ascii?Q?yEDATKTqussj/kd3VNaib0UAYJfKu+61VdWqgAv46S0qvAohMjWUBg+Zcafk?=
 =?us-ascii?Q?T95At5mufOxF/dB+8rjpdSc0itWyDVScTQ0uxrj2SwqtpMSxj8QyCdT6G/YV?=
 =?us-ascii?Q?0/YcQKZe1xFfXF4K47I/VH3AfYZNGrej6w8DJwZ6dOgyKc3mI4R/LdHQGVqG?=
 =?us-ascii?Q?k7MS+4aJq1xrFS8XNXP9cDTO0O48Od5tnsJll9yjBKStDI8iaxSN+OjOj3qO?=
 =?us-ascii?Q?wIkDfEEs3NcNQQSYZpTbOC88oFRO0w2jPVx0gXJJq1x8/D/5e8XOv31DHaAs?=
 =?us-ascii?Q?jTyQVRjnVz2cM4Gv58P1LFbfikweW3Je5g+CVCdAi+wf8oZaVQGASrKyHHI5?=
 =?us-ascii?Q?7EoCcjJ8ivlxZPKzfc3W3KaXwG5p3kP9/moilNde6WgHVE7famP6WtPFmxNa?=
 =?us-ascii?Q?0TBwsSTOZ9cp1wgwngqu5RWKIvRKpH9uSkUeqI76oO8BkRhXxxjptdxWYmE+?=
 =?us-ascii?Q?WSZwavsfKaedrJaVH4JBHzL0EI6l2s7v9FLaZYATLgNDx7Kg7hf1i/Et9/tv?=
 =?us-ascii?Q?VtIs1Mdz+NmzRKXGA3KruaPznivUbSePhHrnpSW2y4l4fqVs604N/DdBtwLx?=
 =?us-ascii?Q?RHwZWCUSpL5iyHNlS8xazPsrln0nQq9+emBvUwMbLoqyTU9Ptd0vRe+rQB1u?=
 =?us-ascii?Q?71pYLhqlDiXR/ulSqzO2FgVf8wVo4AHviprCht8BggtHhEQhU/P9y60LxQUW?=
 =?us-ascii?Q?Sz3qAxZKFNoPza0kfZp33ysiilDHLimKhi9Oajvx+WgWumdisRIxZzpWzVkx?=
 =?us-ascii?Q?9TEotRd5ZFFJwwqPTT930Y2xsyqCOpyR023MAvQksBUEetNMmUvBmBMTJqpx?=
 =?us-ascii?Q?hg835lR418z6ywg4Xl7CMOvdr2yYWatQrM3tCfmUCaLOx/HpFh/fRKnvbKGg?=
 =?us-ascii?Q?H2nxzg5i3/xQL6Rz2fjfsM4s/Z3Mj33w9G2sJTL1RNCoh9mQ00Y7WFgHDamJ?=
 =?us-ascii?Q?XYehOgiFNPcq1gu4gd03eIuLclMG7d1G0ekH3VFGmSMm+Q5bzuuzcsGiYqgL?=
 =?us-ascii?Q?Ui6WJ0qGgmJVgXk7ev0eBVf7odZQTeIYSVxUz0G/OMZL2BF+MYWxsKUrnjRf?=
 =?us-ascii?Q?nC7qfJCtdCgKsU8OZLtn3AQj3bfGAkVyMilI6WFRtI0CEr94plh/Vj7pz5Eq?=
 =?us-ascii?Q?PR9ag5/RsnUGnmRr1NGGDfuHSzQVk5EGpVhMhHeXrJeKe5wpdlbhsdCNHd6Z?=
 =?us-ascii?Q?3T5w9r+8vq1igDlU/GjckxD1JwL9g2lS+se5iiO1NTzkDEVxH1ORvLiU/pff?=
 =?us-ascii?Q?BIOgiE4G5Z/n6Fh6ZKQQDoa1B+buWrQR1Zzz3w87NG5domMV55z4e7Osc+mk?=
 =?us-ascii?Q?qF+Q7btTzp1Q9fV9ZYw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a65bd6-6e9c-49b7-5bbe-08dac0e1a129
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:00:53.5678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oqz/uYXNF9oiYuQwtATAw35YBIM1Y0S8HxjpS8TwB9KnX0xdOapyGIMSLjQaQXly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 03, 2022 at 07:22:11AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, October 26, 2022 2:12 AM
> > 
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10714,6 +10714,16 @@ F:	drivers/iommu/dma-iommu.h
> >  F:	drivers/iommu/iova.c
> >  F:	include/linux/iova.h
> > 
> > +IOMMU FD
> 
> remove the space, i.e. IOMMUFD

OK

> > +config IOMMUFD
> > +	tristate "IOMMU Userspace API"
> > +	select INTERVAL_TREE
> > +	select INTERVAL_TREE_SPAN_ITER
> > +	select IOMMU_API
> > +	default n
> > +	help
> > +	  Provides /dev/iommu the user API to control the IOMMU subsystem
> > as
> > +	  it relates to managing IO page tables that point at user space
> > memory.
> > +
> > +	  This would commonly be used in combination with VFIO.
> 
> remove this line

Sure
 
> > +/**
> > + * iommufd_put_object_keep_user() - Release part of the refcount on obj
> 
> what does 'part of the refcount' mean?
> 
> > + * @obj - Object to release
> > + *
> > + * Objects have two protections to ensure that userspace has a consistent
> > + * experience with destruction. Normally objects are locked so that destroy
> > will
> > + * block while there are concurrent users, and wait for the object to be
> > + * unlocked.
> > + *
> > + * However, destroy can also be blocked by holding users reference counts
> > on the
> > + * objects, in that case destroy will immediately return EBUSY and will not
> > wait
> > + * for reference counts to go to zero.
> > + *
> > + * This function switches from blocking userspace to returning EBUSY.
> 
> Not sure where "switch from... to..." comes from. Also this function alone
> doesn't deal anything with EBUSY. Probably it is clearer that this interface
> is used for long-term refcounting which the destroy path should favor to
> not block as it did for transient refcounting in concurrent ioctl paths.

How about this:

/**
 * iommufd_ref_to_users() - Switch from destroy_rwsem to users refcount
 *        protection
 * @obj - Object to release
 *
 * Objects have two refcount protections (destroy_rwsem and the refcount_t
 * users). Holding either of these will prevent the object from being destroyed.
 *
 * Depending on the use case, one protection or the other is appropriate.  In
 * most cases references are being protected by the destroy_rwsem. This allows
 * orderly destruction of the object becuase iommufd_object_destroy_user() will
 * wait for it to become unlocked. However, as a rwsem, it cannot be held across
 * a system call return. So cases that have longer term needs must switch
 * to the weaker users refcount_t.
 *
 * With users protection iommufd_object_destroy_user() will return -EBUSY to
 * userspace and refuse to destroy the object.
 */

With a function rename.

> > + * It should be used in places where the users will be held beyond a single
> > + * system call.
> 
> 'users' or 'external drivers'? Do we ever allow userspace to hold the lock
> of a kernel object for undefined time?

"users" is the name of the variable and the refcount

We don't allow userspace to hold a lock, but we do allow it to hold a
refcount. And the refcount is defined so that it must be unheld
internally in the kernel when the fd is released. Eg this is part of
what the access_ops unmap callback is doing.

 
> > +++ b/drivers/iommu/iommufd/main.c
> > @@ -0,0 +1,345 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (C) 2021 Intel Corporation
> > + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> > + *
> > + * iommufd provides control over the IOMMU HW objects created by
> > IOMMU kernel
> > + * drivers. IOMMU HW objects revolve around IO page tables that map
> > incoming DMA
> > + * addresses (IOVA) to CPU addresses.
> 
> "to bus addresses".

CPU address is correct, these are all phys_addr_t's. The IOVA is the
"bus address" in kernel terminology.

> > + *
> > + * The API is divided into a general portion that is intended to work with any
> > + * kernel IOMMU driver, and a device specific portion that  is intended to be
> > + * used with a userspace HW driver paired with the specific kernel driver.
> > This
> > + * mechanism allows all the unique functionalities in individual IOMMUs to
> > be
> > + * exposed to userspace control.
> 
> there is no device specific portion in this series.

Lets drop the paragraph

> > +/*
> > + * Allow concurrent access to the object. This should only be done once the
> > + * system call that created the object is guaranteed to succeed.
> 
> an object is not always created by a system call, e.g. iommufd_access

Yes, but that is actually a special case, "iommufd_access" is a "leaf"
object that doesn't have any way for userspace to block it. Something
like that can always be destroyed, indeed we require it as part of the
drive facing API. So this guidance isn't aimed at that.

How about:


/*
 * Allow concurrent access to the object.
 *
 * Once another thread can see the object pointer it can prevent object
 * destruction. Expect for special kernel-only objects there is no in-kernel way
 * to reliably destroy a single object. Thus all APIs that are creating objects
 * must use iommufd_object_abort() to handle their errors and only call
 * iommufd_object_finalize() once object creation cannot fail.
 */

> > +static int iommufd_destroy(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_destroy *cmd = ucmd->cmd;
> > +	struct iommufd_object *obj;
> > +
> > +	obj = iommufd_get_object(ucmd->ictx, cmd->id,
> > IOMMUFD_OBJ_ANY);
> > +	if (IS_ERR(obj))
> > +		return PTR_ERR(obj);
> > +	iommufd_put_object_keep_user(obj);
> > +	if (!iommufd_object_destroy_user(ucmd->ictx, obj))
> > +		return -EBUSY;
> 
> Add a comment that it implies a refcnt hold by external driver in a
> long time so return error instead of blocking...

Lets do "See iommufd_ref_to_users" 

> > +	nr = _IOC_NR(cmd);
> > +	if (nr < IOMMUFD_CMD_BASE ||
> > +	    (nr - IOMMUFD_CMD_BASE) >= ARRAY_SIZE(iommufd_ioctl_ops))
> > +		return -ENOIOCTLCMD;
> 
> According to the description in iommufd.h:
> 
> 	*  - ENOTTY: The IOCTL number itself is not supported at all

Yes, it is weird, but in ioctl handlers you return ENOTTY by returning
ENOIOCTLCMD which is then converted to ENOTTY in vfs_ioctl()
 
> > +	op = &iommufd_ioctl_ops[nr - IOMMUFD_CMD_BASE];
> > +	if (op->ioctl_num != cmd)
> > +		return -ENOIOCTLCMD;
> > +	if (ucmd.user_size < op->min_size)
> > +		return -EOPNOTSUPP;
> 
> -EINVAL?

Yes

> > +/**
> > + * DOC: General ioctl format
> > + *
> > + * The ioctl mechanims follows a general format to allow for extensibility.
> 
> mechanism

It was changed to "interface" in another comment

Thanks,
Jason 
