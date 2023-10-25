Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66C7D6A5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjJYLtm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJYLtl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 07:49:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF212F;
        Wed, 25 Oct 2023 04:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBKNwWd/A/zVNbIXMR5HG4j5To0msbTxmIOo/N9DQum4U3pdDZDuH6TOaptHxxbeNaD0Galj/W/irz5SZSXSQ3T5b3BAHwr1ZhA5j7VYPCEYVQbwhhx4YZ6OSlWpcoqDvEp622o7oM2dHwZpwt4z3/iDkhEf91cKQdh1j9R6VkZ7qxX5vNITg2UA/sSCihDYskt55ZWlsrha5PK3v13pEBDWOCodbt/I0X1L4ShWWKHtO+ymND1AknjG5vYMb2SKVDMuNq8s8H8O02sNNLXWgDNbzC+7d4dv3TBfcCorDdPxWiSle+Gt14YxbTtPB8buEgDyZAEcyRQjm9K7XLnphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiBPp4dSRwEGPBO2djEDRixSU6c5yN+j62FVCilQtZw=;
 b=QPk3tWkwi9dqwaM2Q/IpWmtuwtI1T+tAlb3bP2dEB9F5jfirfqp1aKreVzUBXWlqg74QnZ2m+cW25LUwe25bTUDncxOnk0ZHLmsls3/3xH21dkmaFDDeAg/cig0Vjg2a/VpomwWJEtdxdvqSnP7iQiWPWZ9Eswn/MSRVBfPEk3iKPtpWoERLHj/jC4YxCGleEBD4iRHEjj1/gYMvv9QlhsoA4IgSmONvwwGROGATUPL9awNJcUk+01vmXNznSbKP7GvsBSL1YWoEUoxVwTDKHn58SCin+5ZCukAgmPWtXlLkEEYplqvrEUQPc0kwge4/bFcK6lemEwyWbYr2m2Un4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiBPp4dSRwEGPBO2djEDRixSU6c5yN+j62FVCilQtZw=;
 b=t7IspYoobl5arj0CY/TQhhBvpvxnwBYnQLtktE7tpObIy7qk8LuVV0hY1S+uJ/G8sZLf7tRGZLSi5YV5USWeSAwpAM5EaisAuK46ByGh4ODPJvDSTBzFKAeOmpvRoVTF2zaMVzwTCiB3Fx2OQs9qMIunSKQPEr7ITrF0T5lqSO+38/Vgos0v0+aYpa5A08zSLFLwzTYvRPxve1oesEsRi1rDAuPRaWLbw9nwsUkxLTSdFUHIWzIEw1PN11C90Pg1bQT2RWK0FeXEYP2IBSEwsBVzUlyEGQjK6SbLqM5vl2B9ff0mTXlsu9xrULVQcRw85yg4pjDvSXpLH5QleLcDAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 11:49:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 11:49:32 +0000
Date:   Wed, 25 Oct 2023 08:49:31 -0300
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v7 7/8] iommu/vt-d: Add nested domain allocation
Message-ID: <20231025114931.GY3952@nvidia.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
 <20231024151412.50046-8-yi.l.liu@intel.com>
 <20231024230319.GW3952@nvidia.com>
 <BN9PR11MB5276D670DF35BEDD75FDE9C38CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D670DF35BEDD75FDE9C38CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SN7PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:806:120::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4961d503-efb2-4f3e-2f64-08dbd550741f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfNi0QYvWcBvFbVgO8F95CHcbBkOtVivWh/3/Edf7in/3tV5dDaYzRxph1/+SsgYipAWXLIX4XMFNW8TN2LXfJPmnjponpGHQXkUeF5QGUyKcpO7RG0PImt+J42ODp4fSPW1A8QeJg0/DbDdHWxCOi6e+2x4SFH1kFG/o4EDV2TSmrTaQjR8fmYaxw0rQI6zvQYRY2Ga6YxFPVJ7LreYWSjIATzVRPES5KMMNrThtd8WqH0duYz17sxrRVKYVbFAJ346fuuEg7/QGRc+scCWcPmovqZJIJcwxxLl1V8RndE5MAlfFIS3/DyZg7hUiIHBYUQEeDQOVpxx1C9Rhq8NFCsGHrxa1Id8JwGCiYZEMKNE2KosOLRIeTMqahmkOnkXswST0JRrdYGgykv9yOmSmZLUjxIiKKl24NyWN5i/9lLj8L4/iQHnNhfPU2k2vqrZ4WyaX6EUYhyDUEHqrzWepoK8vvGGT0cV+de97k1bifd+EXGQgOMHkF9YirTlcL/DjYHjJbapWsXuXtFUvFSdwy3+GAfnjeSARSQU8pr1bSRG5lHL13/6UdX9GlEl08Kc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6506007)(5660300002)(33656002)(41300700001)(1076003)(2616005)(2906002)(4744005)(86362001)(6512007)(36756003)(38100700002)(7416002)(478600001)(26005)(6486002)(6916009)(316002)(4326008)(8676002)(8936002)(66556008)(54906003)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zlZ9uslzrSAPaCs6VzS9DD4iDE3nGJLi6+tmF6xZRre0kU52otxHJ+U9/7pp?=
 =?us-ascii?Q?xXjNNc7AUtG0IT+e5gfyO7wWckqpYNOMd4OJ0Iy+426NE/cV6gttwNHm/KJh?=
 =?us-ascii?Q?pAWlRHJHby/kcawPtPmDrXGlrMhQ7orEQqWwzjvU8ghyUs3Q4NBWfkamnd0h?=
 =?us-ascii?Q?re1Fx1VuSWmU35G9Np55vNHmgacoXvkOql0ruzKlaXjFyJ5uV+sh+6NfJ9IV?=
 =?us-ascii?Q?1hkQW8OaXZEJMjr8bFcp4Rkj6vaBUsq2vrGt/dsn+uWtv5Ha29S1YRkCZnRb?=
 =?us-ascii?Q?Lqxd1Q+xbTLj+NynHGhYrrEt1Q2dfr/9cquscoVRLcNnDv006mSD4X2d8w/y?=
 =?us-ascii?Q?4rtyNndTea6AIVTuoRms9mbsleWQ4fjF6FZqR6b80kCpbCHwaMUfRx8YP7WG?=
 =?us-ascii?Q?KhVPHIlRfKBynT7tUdT2EJn+aebOrcKeFUQi+E6HgSPFP/AnBZb/Vr+r+txg?=
 =?us-ascii?Q?La+XFZLrfBT0NxqBh98TkILyO/fQt1IMxaqSRwMUvp6v3SDm9R8Rt8SaVRw3?=
 =?us-ascii?Q?urq2eu1BYyE0HnDz/W3mcJBR1BZEm2uOEjtgFHY7yuW0Kmzr3rz8dcgj8TuY?=
 =?us-ascii?Q?t2sguy3Hsz9gCmCHXyiUVPTO/Twm3FTXjCSw+EpcvBKtCgdycpsswDsUQmnM?=
 =?us-ascii?Q?lFXle37FH7Z2WZvbZgOV1r13u+2arR345bKZCyzFg381tx3OXtw20aL6byDt?=
 =?us-ascii?Q?ap7Ke4fkhQfxLa+y1iG9tE9Ui1aRynGiIfX1XC+PCvZumEXLo1WkpE6gjEbs?=
 =?us-ascii?Q?EIfymCq50E0aJvSOA/JL9mi1UJscKaewJaR+jcDA4YGapdP9oSUfoLN1WIKT?=
 =?us-ascii?Q?5KotJZkuI30yUm07vKNENETxz2+KmkeB3s+vLTxyHK9ajt05oxmkJiQ6+AAs?=
 =?us-ascii?Q?sX0fBncseJXcmVgXLeIOuhKDEmjCuZ4Y7Z6+kwazzhK3kK+CJWh6zLJVFd32?=
 =?us-ascii?Q?mjflmAcFH23xU5IzfNgidhd8MJh+uGTTJ+rGsTIsUlhT75VNZRmdEO4dbHdu?=
 =?us-ascii?Q?rtFudTYF/K22CPU4cL1lmOcPYWXn49mlBUziuzLDll9OSVyHhgzIdhFltW9Q?=
 =?us-ascii?Q?1DEBs/EB8PygdkatWSX+f/WBiv8pJF4X59h+JUKyvIZmxykaBuGm8y8CESo0?=
 =?us-ascii?Q?AAp6QQZi7JBGQAe8GIm/7MwotuQDayGqVP7LVq4U1sQaZGdMDVPfd3AnEwXF?=
 =?us-ascii?Q?mgkxl4bwnH0F8vZa7265V5obNqHh+Smzy5HgWnmuryOTgL2sWl+QJryT4Ftl?=
 =?us-ascii?Q?9zhNGwNcKxYolxyfIbdMOjFTt5U3wWz3nPU9A14mZFa+l+DLOUotTx7sGcI2?=
 =?us-ascii?Q?2bZpzoMbxz8ff7UihqdH+udfYtAqBGhWpORxXN8Vg0DM7iZsUZ3yo2FEPvUb?=
 =?us-ascii?Q?eE2SqjfxjKOcg43gh6b28sTfGIfp/7/W3u1bwPwke1sCShrD0EyuFshiMj1g?=
 =?us-ascii?Q?RQLr6QWBWeDXK9T3Me4sH0SPsfhjb2XFx89EJgDrGIFky6OqYgsPiQszCUwj?=
 =?us-ascii?Q?AIHsg7C7QdYZXyiXzdDZObidrB5ouYpqV1nnogj7mGvS2+D606PJRc/k/j0G?=
 =?us-ascii?Q?NH0NvWKC/RrR7wkVT8sLf1h26RWVd+c2otphtjfs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4961d503-efb2-4f3e-2f64-08dbd550741f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 11:49:32.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twgtFLtpGHb3eDQk0Embf2ut0kMFVZBq4GHWk9cVvGqv9ZcM1McfZZW4WY17ZC3l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 25, 2023 at 07:34:20AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, October 25, 2023 7:03 AM
> >
> > @@ -4849,6 +4855,7 @@ static void *intel_iommu_hw_info(struct device
> > *dev, u32 *length, u32 *type)
> >  	if (!vtd)
> >  		return ERR_PTR(-ENOMEM);
> > 
> > +	vtd->flags = IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
> 
> this doesn't belong to this patch. otherwise looks good:

Ah.. It seems to be some artifact of how I make this diff, it is was
fine in the actual commit.

Thanks,
Jason
