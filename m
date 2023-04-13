Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0180B6E0CC2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDMLhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDMLhU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 07:37:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A231F2;
        Thu, 13 Apr 2023 04:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYatIqv5caUkXkEYdO/ZDUZNF/j4wHyVw+WCq5zerFhHK2gu4Jg3Iawk9q2vKmVkCsdQ9AGTO/Na8DOnEVJJvm56sX97rsCDBeYLsGGqkdVPYuMaDm+qHgzUFlb/ItC+8iOZpLd2WUXGjgzhzIYfd8c1W86bghJ6zrVLYL48xGc1K1GtKgiVeR41UvkdkiIZBy8F8Gi+WNOSmiPqO+nKzOkYxpTuEzurNht5j+gZG56+C0THkOgYf9FpxkhKZQ2JgkuFGTBbAx5Oozcnls16n84F3CkjZNtp6gMKev+GSnt8jtBkqgg5GvX/ZPQfZgSw4hTHkMVKHXqvFAu2q+MeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUEnUGRSm67SxvbwGWHw9CEKtoO0GNtJ7P+FK/IXP78=;
 b=Q9uq9fyfy1w3E3FlgVr3psJ1jrBCA7gmpqCHY4vq0Xd1gmIRpuQM5cI9w08s/I4obrdNeqReFR44k0LEDoylqe00Y9nXBpioDg8WH4zk6do4d5ju7gsfMx0Blih/Nsgln9FhWVll1rqscrTZ4LMV9peQ0qo7bY2k9JrgPNyu3h6yk/qIU+QoPutl8w0VUEo0W+2t6ZKLnxK9rUFe4s4XOXCZIWMLl1sDIx3ERLdE8kH1i0qk/R7yvpLIYjRj5LfP3YTv8cDRvBJHKh9Z/r0zoBeMZ1NeE2Z3dY+mwGgjVIsjIPMsKXmsvEe5CZxqBhRjwVSYV0SSPDhLUuiL3yVA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUEnUGRSm67SxvbwGWHw9CEKtoO0GNtJ7P+FK/IXP78=;
 b=eLeRl+hpoFapAA61brAIyggCvhSBnhxYhaZP+EjsivqYxoTDgvLYa+t7/Yy5jlCHVBRcSzQzUReipE9vySSPBz0Dkta4oHOsRBxhMLEYnaE0r6jQPxeHaKEtHZCSqnNGcyDb8lUcIagSJvcgHTw/l3CUyeQlNWlp6C+W7a2HHDVNG32K2HGWeu1X+0MG7tOC5QJsgHOHOdizuBGpZDi/gVQbWdYXJ/lF5kZRco7XfMHKt+Dnf/L0b6KA1jdTA6uyOuzhL0jIXTy5WxWGIxSPgDja47B7uAy3rDyKnEiPi+JbCH6uOyXm02A6dLpvt091GRjVZgOpNAZkUJ514fiQoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 11:37:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 11:37:16 +0000
Date:   Thu, 13 Apr 2023 08:37:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu: Add new iommu op to create domains owned by
 userspace
Message-ID: <ZDfpatOGY7hTkC/G@nvidia.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-2-yi.l.liu@intel.com>
 <ZAqAJgoQ3f0L2Gfo@nvidia.com>
 <ZDdQVEksXbeilBoo@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDdQVEksXbeilBoo@Asurada-Nvidia>
X-ClientProxiedBy: CH0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:610:b3::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1312cefe-e03f-444c-6dd1-08db3c136e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOQc8t8CBjRQRUTZI7agp4HwX4VL9JagzKwiveR3ydMq1mWrfoodGkEqEsMK0mikX6XOiHX5L7V2mVLQmWaJLAny+pqzBVN9om53GEXMK8LoEz9njHRq6EtGiUkNu46yStBHlp/Dj11t5ghRFspHOD1pWNIf2T6eLD5CTa+x9PtXQJSaLaGcyv1CSEMGGElgwppGl1f0UzHfmzvW+fFyhHbECpAEbAMfKtWR76mp9qhKCcr2ZTiCvdFAkwh5+xUVEptL8zrsW0z9xvH+pdPxwUVN4XwfBbiWaIan94TKuEM0CpIkfxfY4oHCECLNxSwBLejPwcSEfF3cTv9AnFlPGppnQdtRGQSA3g+zSHF+AzVD4d2a6EtuRDlmOrmF5q47/7wOYdNJsq1/yGK1OejoFAJzaMaJjaSPPBsbWUYENrUT2OHmMb5esjVJw+V9XOALIICPJqN9eBcBD7lgYrnUgXXmgpXZcXIfj7aXdsjnKXz6b+Pz9gHCbOVw3IsgJCKFwDUaSVFa+XPmyGX+ZBznHq1eNATgnFvzPcN5XjS6jQx4Dh5s5zuYQmYQ9YXSs8Bp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(316002)(38100700002)(4326008)(66556008)(66946007)(66476007)(2616005)(5660300002)(41300700001)(36756003)(86362001)(6486002)(6636002)(6512007)(6506007)(26005)(186003)(2906002)(83380400001)(6862004)(7416002)(8676002)(8936002)(37006003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gt7DGkbttuF6SQrpOJjLZfWaHf7CBVdv41CNRzatUXMGWZWmfrIO7ivqp15J?=
 =?us-ascii?Q?XHKA80hVTwjB46cTl7xZXejVcmb0pS0TxwKnHy4PIObHEHkWcckpfNu9tfpY?=
 =?us-ascii?Q?zinzMxCyAd8YFO00XsTTjTJd+ee81WMhoGiY9I882aceZPMAauiwsL5hpJLs?=
 =?us-ascii?Q?JP+E1Gl48IlyzjMxdUQI2ojdQsuFMCbjKmRcwEDomKmmU+UHdOmdWkNJmosn?=
 =?us-ascii?Q?jQLisRwYCu7WzaqiIaE+vkJi+mvyj83isQNzdp+gcrNbvnoA+diZcXF4WrBW?=
 =?us-ascii?Q?NWNgY6rZsrGWhd+VwFr4Sws8+K7SIch0fJZytW8y3aYazyUR2pxOkwZwO52o?=
 =?us-ascii?Q?1HKDoOSN5fvY/yFWNxsOMfd8psVqgszVHCzc9mNtD0GoH+ucDfMmrkSFaeZM?=
 =?us-ascii?Q?SbVH+Yfl30GklZNPzGS70ArJnb8wGBufJcZNo5SKcot8WO0kQ8283B6Q9+Fn?=
 =?us-ascii?Q?KaIEe+TVCSugnH7SZXkIgqLJMUgMIm4A0/0iwllpl61STdqU541cdQ9wLmjl?=
 =?us-ascii?Q?jX+M2fDic/IB7y0phl/LGrEqK96GsAzNVS2fu4N8IzJmrrKKiW+eG/xUHaAB?=
 =?us-ascii?Q?5P1BsQROanUXqJuLdwmuF5FI7bJLWRHebEGA0leZQIPsw1YUIWWRCqVqkG/O?=
 =?us-ascii?Q?oMPf00U1zbIv+/Ozgg73pkvQagEGATCMjhpY5qqfXGfbJd7ErQiokQQZmTZg?=
 =?us-ascii?Q?rbROtSpOZlfKVk0Mc9tSUM87vv7kmNgABRvhNndmlHHhdA8z9e0Tp6ewdpSP?=
 =?us-ascii?Q?srbU94HyP5xuVU5VIW7oYABFUBHgIZ+Cwn345VWhtyBr1r8oLpPnjtj6h7p4?=
 =?us-ascii?Q?VxCH8Mmc6D6I90mcH9z25icSCH3uoVeY6gTMHfVLg7Yv+wKVYQTOIRcPxxKh?=
 =?us-ascii?Q?bJ4X0xYGFpY0qwPTd70M5pgoFvqf/9D27ppR5qlPENA5MP7CBLC3NPW3n/nc?=
 =?us-ascii?Q?HNS2VihcpXc4Ee9hPipHYRtjqJJbwITqKPd4g0C/HvmDPXaRBkpoj6MFU+aN?=
 =?us-ascii?Q?vvTXlBcNTBHzXBA4hmCI9LEovtIdocXqqHBURRlirb2ZLdFC2g6U/Q49y58t?=
 =?us-ascii?Q?iGjF4Ho8FujKNqB7YxtuhH4g0ff6NuWUYV1T7OiDsBb+/K8ScF8vX5ZI3sPE?=
 =?us-ascii?Q?ywyu2Dp+rPGdSxm4QQkvKDtGdns5sDxKHZ+UYEcIQ7l7pOHWHVAWbo6vPN7+?=
 =?us-ascii?Q?ksCOelEpZEDJsAZEnyN8gK+4COjM3bpBoT5m6V9l+lgZqn7hTyDzH5B4zmvo?=
 =?us-ascii?Q?LU1CD4VYvpGQe/o/eQ1mWDCjOx9BQjshiNiK86pXDbD+bHPi6UU6j6+Hkiim?=
 =?us-ascii?Q?4pff0B/u9KNSe+zXtLQewCosEP+lP1GmuR6lH7kDl4Rd48nI5Dx8ueTVBvFb?=
 =?us-ascii?Q?2XGzrpiVOvM/h7RhT6lAAXuuDPQDY8mk7zkZd3/Cn5jUcaw7cXJLG19aXCby?=
 =?us-ascii?Q?+EjaDTN3oTugyrxlnAfrztw+Y/NV2HSgUwXZgdgy9zAyr0Oo8e2SBYbwqnBa?=
 =?us-ascii?Q?QQdilO1evdFBovRhShZ0Dinw1KfPbTV/OypbLcm7OyJLQMyzq6kTbjeyAGj7?=
 =?us-ascii?Q?90IN2ePGROuCOEa7kjiX/YpfsvhNSMknlutXiIKw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1312cefe-e03f-444c-6dd1-08db3c136e6f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 11:37:16.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlxfqPbS9qFzZuB9E+b6M1vwxLHTZmCP2O3IvsBBN3phxMpGeZ/QLbyiPJaAX+zF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 12, 2023 at 05:44:04PM -0700, Nicolin Chen wrote:
> Hi Jason,
> 
> On Thu, Mar 09, 2023 at 08:56:06PM -0400, Jason Gunthorpe wrote:
> > On Thu, Mar 09, 2023 at 12:08:59AM -0800, Yi Liu wrote:
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index 3ef84ee359d2..a269bc62a31c 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -229,6 +229,7 @@ struct iommu_iotlb_gather {
> > >   *           after use. Return the data buffer if success, or ERR_PTR on
> > >   *           failure.
> > >   * @domain_alloc: allocate iommu domain
> > > + * @domain_alloc_user: allocate user iommu domain
> > >   * @probe_device: Add device to iommu driver handling
> > >   * @release_device: Remove device from iommu driver handling
> > >   * @probe_finalize: Do final setup work after the device is added to an IOMMU
> > > @@ -266,6 +267,9 @@ struct iommu_ops {
> > >  
> > >  	/* Domain allocation and freeing by the iommu driver */
> > >  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> > > +	struct iommu_domain *(*domain_alloc_user)(struct device *dev,
> > > +						  struct iommu_domain *parent,
> > > +						  const void *user_data);
> > 
> > Since the kernel does the copy from user and manages the zero fill
> > compat maybe this user_data have a union like Robin suggested.
> > 
> > But yes, this is the idea.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> We pass in a read-only data to this ->domain_alloc_user() while
> it also returns NULL on failure, matching ->domain_alloc(). So,
> there seems to be no error feedback pathway from the driver to
> user space.
> 
> Robin remarked in the SMMU series that an STE configuration can
> fail. So, a proper error feedback is required for this callback
> too.
> 
> To return a driver/HW specific error, I think we could define a
> "u8 out_error" in the user_data structure. So, we probably need
> a non-const pass-in here. What do you think?

What is wrong with err_ptr?

Jason
