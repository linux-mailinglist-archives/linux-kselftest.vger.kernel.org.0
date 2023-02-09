Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3311D69122F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 21:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBIUpO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 15:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjBIUpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 15:45:13 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC768ACA;
        Thu,  9 Feb 2023 12:45:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBUSqFRZJOFz/zp+vTUxhQxnWsnu1XC5eApBq6FLRnBKWYbOK5GvpVuZJP+yseo3KwYkHGesKFuMKT3M8L2lrYvEVSToKqQ4W/8RUisHHQ+VbsVPjE7lAPcIdGe5q6FYStfdQRlcSTX+LN6FBsEFqvKELEZQ0LFOk8Cz/j1daDgq5hLQqKi5XO2qWbbrxbzOO5RsT5CvvXPldBRrGa7qTODX5//uYq2Dem4FMf1KpG0B8IJWotN2OpW2aE/pRKUyfLuTR/b9bEranVJ6ZArIINgZrNUW6HW3RcEkf5gk/TiSNDY5xARUi/el5h8d+EWF06Zm5zF6e70FAsxe307K3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFVgd6p8cNTqIQivE3M4dvYQ1S8OOpWnwFzD4956oyw=;
 b=P8b+KUb5p0C+dpVxqmy7C/tl1uM1tJ3QmXZSfAO1wNhUxl49JHYW9/HpqUUC3TI8kYkLzB6JBMnCguVhwqE35za8ORDVEBvruE9njwYAAh3Kvuk2n9+kaUKRsN+8RlVw6S/quMdi/QI+4nQQGGlkeQcrIS39swNi5r05iI5YJLeuJLQXF2ViHt3WcB2Tcix2/nl8X6XBPClDxrUE42THFHnFuMZkQ7GvxPLHq4JjuU23NbFNbIdiDXp6bWmnpnzhORty5xAM27jYvmaAh/fksQxeK/cbBtTyvFeZTQjjPulcs72/d6KaSrr4Sb7otJNjRduvkivoa7tOyU+esDIKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFVgd6p8cNTqIQivE3M4dvYQ1S8OOpWnwFzD4956oyw=;
 b=ZwkVglB80oPWcGpMHIYhEDNYOGzRhxUoj0WKCvQMY1P+SkRkzCNfnxGOrjkDUNxfeQm7BpaXxKL69cPGtVzGlWNkrjQdrjIY3U5MLbHbTM03PDFvvmBbvucvsbtFSithP0gPOyM8LToJ9hn5UDMzQlsEMLhkqBuwACpRlemqLolCpzR2Oo3ZIUgBI9d7KtP9JtPKF7jtygv0eQnxd+e7Ofk/PpTu2HQsOcKMZEpe4D6WsjorzFdEyKe7olFw2RhFo+ZKCZeGbaRGTVbi7+6LM6rLeJ+mNn+Gk9oFs9MPDJa/fCnuqu5MZGCsr3yex2Blm6hNxfTP7yZS5Wf2T7ngLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Thu, 9 Feb
 2023 20:45:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 20:45:08 +0000
Date:   Thu, 9 Feb 2023 16:45:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH 09/17] iommufd: Add kernel-managed hw_pagetable
 allocation for userspace
Message-ID: <Y+VbUrpPQWkOVyW/@nvidia.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209043153.14964-10-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:208:32e::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: dd027b51-2844-4fdf-91e4-08db0ade8804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RAiiwkFdi8j0ott6aQ5QKsSMgz6//HK5o9dH2T3HkY9RhJhmVzGLfucY2YzbEf/n7FYtxnf83pzuq2bMl49OR8Xs5khb2IG8Pqk3YDXoPgZGIo/t9TYJgvY62CA/CWDQ16O1WhyxYBzdZCHIf9gWHACj8POLqJjS5dySJccNs5W47VzlO4xOoWeRojE9UUQY57e6EeYsgLRimQF+lCg6+tLyrGpHb9U8yKIg/TEBt8JNox9avhfPtwgbaPP3wUkjjEnX7T3kCONQQkg1f8ibuKfJYxCrdBEi6jzEYPKM2iYcmKfhA12Ohzxyhjjj/Fnts1tjBrpcU99CDTzlpt+rFLRoyPj1zpaqGVSPzj+EVXmMJxqdioKVKN60fqQuPO44FZ/C8XXysdHItR8hzuAeB/wMTaMCFQ1y1OZxQIx56cm4G0WZ7jxA3lcqUXyNHI2W2FD/57/MK/hg8n1ysP+uAlsgKRtCHYVKIVk5acIXr1FcG/H+WueWA6SsnW2L7e57a20A3WiWL/IrlZKi9RD3A1BqBv0oSSf/T1mCg+jSHiUxNoe7JvAq+BhvQXVF+ML2/3xff8+bZgkJeElwrm0atAYmMUQm8dDNTPHoOGV4rEp1QOMRvd/5x0mt7efg69Utt9z6e9TsZ852KZ+t+HcKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199018)(26005)(83380400001)(86362001)(6512007)(186003)(36756003)(6506007)(66946007)(316002)(66476007)(8676002)(6916009)(66556008)(41300700001)(8936002)(2616005)(4326008)(7416002)(2906002)(5660300002)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DR1/Vkv798NuPMHaiFQwiG/THM/8q/7IBgz9sn5ynVtqYaXEBxB3CNg5ogbH?=
 =?us-ascii?Q?XaDWrkfF+4QV3ZKlm6O+/uzsUV2gminjI9gwW8elcCwqvoCzd1HJNPQyvhPu?=
 =?us-ascii?Q?PCPDAbU1bV+o057K6hpMbw0W1KYLBV8s/+OwISZCmjSCDflEjGJ6lIm4fL7h?=
 =?us-ascii?Q?o4juwP7wxnfUuRL2JrNH9/0al0ctPVM9mfmfpa+BqD9UOLcBOn7biDzZENrS?=
 =?us-ascii?Q?/fD6bPc3yHWT6keTYxOR3R7k6KJc3fsss4/Foh3m8w3/WdS+g9eRALLSiICi?=
 =?us-ascii?Q?a2RawkPLSojkioHIpcXFer1S6ioVoVGMhpqPYeTzX89Sm90EuUt8wVAwGGl/?=
 =?us-ascii?Q?+CJhk4MPcRG2PcR6N5CBE2jIA8l6S8Y2+pwnSrbAwXi5kqLJrzEzqXML/AHV?=
 =?us-ascii?Q?2czbrQVX9yerFGlJXx2o4CyshcF0RamGRd7UJNIKNKFBpkfRBftDl/8ExbjU?=
 =?us-ascii?Q?2KtIJpjtXNMS3LPo9heWpZ1UGZRyIkL5u1NUe/wmM6H3PBzbPHqSU1hEweO8?=
 =?us-ascii?Q?CqC5YnYt63Q0KbVEYtrFkXT+ghCCaNuXD5HV5xCsPKYd8cMMn+I/CL+OCTRS?=
 =?us-ascii?Q?xSZ5IUslW/0a74GjP4PZRFcIHfao/yfpEU6JrM8gbpe8gEBF45i4D8tLhiTi?=
 =?us-ascii?Q?PUz/DT+Ba0VeL6rrNKg9OjHs29CZRn/0GhEMwOVby9uOXUcTPeJOyhRyAzG4?=
 =?us-ascii?Q?QdN0KtPJ51OITIybpjs4Lpquc+7/Lkgqmmgu2eUa/a4sQg9besKb1xFNsNvk?=
 =?us-ascii?Q?pXTGSJyjw8OUoVAhA4aAKtLMWwXe/7DqtpLvEHAC2yQQ3XHzJBu1SGQHlNlf?=
 =?us-ascii?Q?MdVvanHLImpal2XU02k4Ox/F/BGIwIg5lgQqYmdtRhDxKVPdPh2hn1XJQXGz?=
 =?us-ascii?Q?wy4kcjlFiHtW+WHIslULc0DOa/XdZYlNw9bTcPv9QR91zh498SntRj2jmIkZ?=
 =?us-ascii?Q?ToBxJDt0pqPcnB6O5h5DJUvCyI3cRGmuya8E2ld3LuzubuMb+BqxoHw3DPkf?=
 =?us-ascii?Q?vfSFTLxKVqUZdBWAco6qXnCX6+BGRa7VGttskPGm2x+ePN1cqojWzD/dZnQx?=
 =?us-ascii?Q?/vgd+Lp2jQLUPb+dm5+znPkHR/T18RyreX+0nqWyuSlHRcERPZHnyFSElKwc?=
 =?us-ascii?Q?CwQOVF6e4ANnXVVlWnjRI/mPcVmQwTuBfdDEOHy08wWcy0+bbl319twiXd15?=
 =?us-ascii?Q?zmH7YeUV0364LvNvTCH1Q8u/CLtx0SBiPv4t6VG8aKNxFuPwXViavM1Koz0f?=
 =?us-ascii?Q?l9JUdHrm+aNri+L/qhPoj06xXi/gF7d7bxjB0ej4QJ048gcrECJqs8DSEK5l?=
 =?us-ascii?Q?EmcLnx7/tc80r3clVeCeH447WigUZctX65Hkehn2yqnpun38elStbZoes9EO?=
 =?us-ascii?Q?WEO42+BPTQwh+K2iJGwVZFjMUOnFtohyC96OgDPdK+GTkHfaHlZMYUOsLWOE?=
 =?us-ascii?Q?V1Sw3vMIocDQrMAUCyqTRj0gS37mT/BjVXea9dpLC3sVEGP9ozD8+2nBI4BU?=
 =?us-ascii?Q?xfjz/OtJ/fY5J7iEGs05rNl/abCr7Xv5YgdDRfjCEN4cAhlNlZkposxtVug4?=
 =?us-ascii?Q?TFn1YFc/U/nwmko+i7w5CBDZa7QsLtplObl+Isfx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd027b51-2844-4fdf-91e4-08db0ade8804
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 20:45:08.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9SFa2FVej0oju9ShCWvpim7u/QAVPqvE9AHlRKqW/P1gehRZeJ/ILhyueNSy6Xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 08, 2023 at 08:31:45PM -0800, Yi Liu wrote:
> Today iommufd allocates the kernel-managed hw_pagetabe implicitly when
> device is attached to an IOAS. This links the hw_pagetable to IOPT within
> IOAS.
> 
> However, this is not the perfect way. It makes much sense to let userspace
> explicitly request hw_pagtable allocation via iommufd. The reason is even
> though the hw_pagetable is kernel-managed, the mappings are feed by
> userspace. Also, this makes the lifecircle of kernel-managed hw_pagetable
> more clear during usage. This is very important in the usage of nested
> translation, in which the kernel-managed hw_pagetable would be used as the
> stage-2 hw_pagetable. In such case, both stage-1 and stage-2 hw_pagetable
> should be allocated by userspace to ensure the life-circle.
> 
> This adds an ioctl IOMMU_HWPT_ALLOC for the hw_pagetable allocation. For
> kernel-managed hw_pagetable, userspace should provide an IOAS ID in the
> allocation request.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c          |  11 ++-
>  drivers/iommu/iommufd/hw_pagetable.c    | 116 ++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |  15 +++
>  drivers/iommu/iommufd/main.c            |   3 +
>  include/uapi/linux/iommufd.h            |  48 ++++++++++
>  5 files changed, 191 insertions(+), 2 deletions(-)

This patch and its requirements should all be first in the series. A
mini series who's only job is to add IOMMU_HWPT_ALLOC

Then patches to add IOMMU_HWPT_INVALIDATE

Then the vt-d implementation of all this, including the vt-d specific
changes to the uapi/etc.

Jason
