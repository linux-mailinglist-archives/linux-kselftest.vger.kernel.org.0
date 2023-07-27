Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B61765623
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjG0OnJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 10:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjG0OnI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 10:43:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E49271F;
        Thu, 27 Jul 2023 07:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkR2LiVQOEvJIIaNwhbEdOg601rCh7Mgancil57tQuCn3XNn4pIBn4E8OO7y+Npy4iHDsCSD+uCq2FOycUsDbK6POD4eI/hRH7OJ+1CHxSGC0mUZypSTxELomz2mMXwtPHGlLi5gA64JWh1iEWXAJ+IEY6MyNiXK5npK+FQ9u/tJ97ibjj7pWA+F1NEMpfRoA04E3m9zc53/Fe3x0gZY4oWscSOILXQXzZg1fa7q66ui7ec1c6dh34gBS48kyGOWTyBEgECWnIfJbiQaa1ZXZw10onURWZt09C5oGA9EBGJ/XUrbgu21yG+94oXRPmwsViuLvX/GbU8+lNrS8IaB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urp2sM6/MOc9vQITmqHRR3ge1K3bYRAMuquvSoLP68w=;
 b=gjwaFDg57+1fRYZQ2NuzyIkO2ci4vWX/bXSpRDUI+a+IxEbdKiYrqtcC+pFSjRSPdP/ToGxPUx39yD/B1i8Nitv7uDn2Ng/VZHh6ESqHwtZ8gY9HNb4WTc+0uVwla+BaZfg+gwU9xOeTs95rQhn5AxX+Hrduz12Rn27Q/TesTpRd1JlNBYNdh0w7f8nC5JdUWrRvvRGuM7noXqBwrMQIDwHeHs98U9gkQNJ+huqE4TWmb770yV0U0rH9blAr1Ho0UeoDO6ogWnLpQSSYjBcSxYMo877mRb6PhtYSCy92pq1KcUmXgmqktPJfjuKmVXeEyH5CfQQkGFq5hH17jZr65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urp2sM6/MOc9vQITmqHRR3ge1K3bYRAMuquvSoLP68w=;
 b=TEybk1o0MLIkPqC/PLXJsTFQL5r0XihIMuZI/d6AbjID2jfpRH67adoNP7uHapF3A/qppPGEanBWHwqdfq0AwN/nl6z8QLWQoP8ndYQbPO6qz8vplI9S+apAMEbxjfdY/k/WM4qlCAiCds7gOR4Ks0HKa+x2ILtr6gSatZ3tZw5Cpkjuno1Tuu/MVw72T3Ay3Xe8nAdwemtrHRiTIm5L+lQuF5ntVlrxxxLNDT9eIcSrO2yzv4KXhOSo+2JAifykfLvGJIsr26rzUyabhcgBWHT2i6z8NjuRAPuvMn9TRjelbp+JrO8sfoLDQ2H7nRp1WE5WMFisG728cPus9qHWlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 14:43:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 14:43:05 +0000
Date:   Thu, 27 Jul 2023 11:43:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Message-ID: <ZMKCd5S9VpNGf631@nvidia.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-3-yi.l.liu@intel.com>
 <BN9PR11MB527625066E23A1C4968905D68C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527625066E23A1C4968905D68C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b74851-dec6-4dd0-09f4-08db8eafc959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upD4ceA9ZK33wxIgAgEa1zHNcYDxhSLL8G4DU7U2WKT3ifhbUzUqWk1FAbSMpfeS6/twMotuPL5eMaGZCzhdwyYJlwfQyXUMJVna65twbl1ORhzAlQyhEDS70VC+mEFYRqktNK3HflSBYoecL42Unss+2DDdvhIAyKqsDMFywdsyPcAuOoJLxjmXJb3VL+4paK2u7Xiyem7+dW4Q4ZIeHYvziC1AJgj5Q/tsNeYyyOOcPyFvMbDbOmbNRlmzggC8XmjqIoIIWU4jEWhMn2KTpjL2WVGm5oCR/2jAK4ti03q5RLadG0Eacw6oYQYyJYni53Bvo81/8mfLXxyiA9VPZ+d47IHJZc3ORc3tH2cCLgPvptzNxLqtO3C4LS7nRUAr5aXMRhGLoIhKe285DGYYqpdgOz8uBuL6faW5sFuUZBuKbfnrMsVRwpr3kbWRaKHXf5gcipWUmAkpkInizxOoC36kZ8KE7ZwUY2aOoYIqxlvgC88Dp7PJ3uQCVymlXLSIokbWcBo6hREjsnFF3QGHpePmchxi26wLjKsIhEtNGAFkGs9N3NhdV3QqanuHIZN7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(186003)(6512007)(6486002)(478600001)(54906003)(83380400001)(86362001)(6506007)(66476007)(316002)(2906002)(26005)(2616005)(41300700001)(4326008)(8936002)(66556008)(8676002)(66946007)(5660300002)(6916009)(36756003)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KGve0Ce8hSfwG0NiqE3FGjH5jfb+24ov0TsZQxmTbpZ02aY+mAKdABN8BNRl?=
 =?us-ascii?Q?ZTY4gaIaeAaAmg40OJH4llIfDOdYxDh9gmzzJeTT0PooM+HGcjbAh0WjYVNP?=
 =?us-ascii?Q?Z8NkIj8piblPCfJlgYlBufm6UBh5SN/ueo+9/GFpec65TRln5wPxuIaP6EOM?=
 =?us-ascii?Q?e71GW86o0mK24QCTnv8mFd8xyWilKcqr6epND30nBpCmYomF8QshmRpII4iE?=
 =?us-ascii?Q?1DGGk9f5TNh2ZNceszwLxb75tby6FPpkofA8zbFzyZqZhcQzfLAmivE1ybWv?=
 =?us-ascii?Q?qoMb1QbxBIPbd2c1yr+i46DBI/Y8Euz6bUt7qfXLBoK4E32KQH2Xbky9WgTY?=
 =?us-ascii?Q?X03otjsmqVcQBf3h0kFM0k7+CxxYu6Lry3w/W9uuIbMyaPrPc7nF3EKVpVk/?=
 =?us-ascii?Q?4K+2S0HQ5zwMSaiYN0c5LpZW/843+ky2cGUWZ0AVyOlKhILPltMxGHB9X0bu?=
 =?us-ascii?Q?W1ZM2SkdnPNVh+hw2Ma+nr5f8RWrSa+A1uRJcESt9FPC74cHrE3yFLV8c/uS?=
 =?us-ascii?Q?VrdFnvBFEC3yqtoFJKj0oNK2Ku+jnOZ6HF+mNPb/aE7NPHx+WKHnDzWOso8O?=
 =?us-ascii?Q?IUxWxZhkPWz+c1N+IzZvukbTJUStl6OmQQxDTaZ1VF+vA3DZYHJnMrwMh0ii?=
 =?us-ascii?Q?jLrk7bY8NUakpZtUeh9EwoaU8NvDMvgFNUuJ1hSPNYHs8UARGHuPfvwaooSD?=
 =?us-ascii?Q?xWhZooJkX5L32GVC+68xjC15FlABDAwJu6ZymJZ2YeSu6s3kYwskvkh0Au/+?=
 =?us-ascii?Q?gVKrbTeHszNNJohPPMLqpczY7XuDD5KNR5DY9/DGWXLbfeJeVFHuTskzwz2d?=
 =?us-ascii?Q?hddw+LZ6W80Jvs1zigmNaQNfUZZ2crTNaDgi4zV/wV051W2Kgw3pjWzlrk40?=
 =?us-ascii?Q?sqWYXIdtA7ncbx5EDcWE1LfgVWCbpPlbcFq6O5KkLsYKMCsEOOoqMhNIZCrv?=
 =?us-ascii?Q?zPyx5rSiJmOF4wqiDxKoLr13Hug0ZJlOUwKHPBWm4KD8Zb4hZfYSNh/TNqM2?=
 =?us-ascii?Q?ulBqAhSCEnhwRa1eSb50hNcdr0W3X/slcO1BTW1HMDduZjZbWZ3WtM4tPhJv?=
 =?us-ascii?Q?gL+wTYfV7HrLRDt+ilUJnEgal7VSMyS/fdYi8gtaWmBW4/KuOT6bGt8ennpS?=
 =?us-ascii?Q?JCEVk4X5JFu7L9PQ/8sMO9iLHb6kSJ8LWdI1XBYdEILUv95w5ZLoUaq28gSA?=
 =?us-ascii?Q?EL7ybg3p4kp2mRwxVpz89SgW5aIRTnst+Kl0fDvjRMgCyZpHAajH8qhSacmN?=
 =?us-ascii?Q?Cirzj4CdEq2uZNRRcV3rLS1EnZTH0LASNTNYoda7oLDr5VyjmHw0dZKOqNC3?=
 =?us-ascii?Q?cMdd4J4TJlxlqlASG3hZZwAjSxGwiv8fm4geaQZ/gnPQ37YGLjJrE6OhrWtY?=
 =?us-ascii?Q?IocFIi8i3cYKqBKx0RPH21e3U08b2NnIdI6m3tR9osjF/VNRyJu4zM5SRQw3?=
 =?us-ascii?Q?5DNWt5in50LRziM06BJfmAu0P/qqF1RFMcHDPaP3uXMx+Mphgi35Dpg0P/KU?=
 =?us-ascii?Q?bdtA2yyGZK0lzH+HBUSVnKMq3Di1X68DMtXYVXffAzTafGDLNOY4aRnUPfMa?=
 =?us-ascii?Q?akvDB859oGJBX6ZrWkpHMGYKIfe41XRB49M1HzgQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b74851-dec6-4dd0-09f4-08db8eafc959
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 14:43:05.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKGQtzbhn39Ur9EVSGnYtWc9SJ2Tu0W0DSSagbXveHL6IVyGzReaQ1n+m624d1Mf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 07:57:57AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, July 24, 2023 7:00 PM
> > 
> > @@ -252,11 +258,20 @@ struct iommu_iotlb_gather {
> >   * @remove_dev_pasid: Remove any translation configurations of a specific
> >   *                    pasid, so that any DMA transactions with this pasid
> >   *                    will be blocked by the hardware.
> > + * @hw_info_type: One of enum iommu_hw_info_type defined in
> > + *                include/uapi/linux/iommufd.h. It is used to tag the type
> > + *                of data returned by .hw_info callback. The drivers that
> > + *                support .hw_info callback should define a unique type
> > + *                in include/uapi/linux/iommufd.h. For the drivers that do
> > + *                not implement .hw_info callback, this field is
> > + *                IOMMU_HW_INFO_TYPE_NONE which is 0. Hence, such drivers
> > + *                do not need to care this field.
> 
> every time looking at this field the same question came out why it is required
> (and looks I forgot your previous response).
> 
> e.g. why cannot the type be returned in @hw_info():
> 
> 	void *(*hw_info)(struct device *dev, u32 *length, int *type);

u32 *type
 
> NULL callback implies IOMMU_HW_INFO_TYPE_NONE.

If every one of these queries has its own type it makes sense

Though, is it not possible that we can have a type for the entire
driver?

Jason
