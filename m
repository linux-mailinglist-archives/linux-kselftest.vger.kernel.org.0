Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F24D72454E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjFFOJF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbjFFOIu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 10:08:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ECF139;
        Tue,  6 Jun 2023 07:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSn6vWR6Rc2SBe6zcjKOUTYUpWjOrxayhkYb9cYj8/KqYXHEyLyr5jodc/R+t4bRnK6QwTucCqgWtuuxbcUlPfdIKTTmNkNt9GdgslMyEdIPMIgg6yzC4BiUAJakL2OjGhyNQ9it3b0yYqooMwdS7kLsDNYQMq1u5JhlHiiBEIIL0EkXwwvj4u1A5KJDXRtFrgzGWXDWs5fIc7qhZMfZqtYdcMIzKuHEx3ieObYysc9BD9WlfIaa1kQ4wujpX9Nb0JmE/d0vp+zbqAhRhTjO9ieMEnxwBw5NFxHBqKXUIK0oUt129c8aXR0g1OpXnCcZdTqEYVJ3EvuFlbOAFU3T5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avFlAWeSP6eqgQGjd9uhV0P0U5lGZ4EXqx+DzJ41PDc=;
 b=EKT0F+YFjtyU3dSPZwk4OHIzW2Ry59L8/HbbK+r1R2zFQlFXcGsTghEvCAnduQfOORYQ6k0lXwsa1A1gxizFzJpYKQVlexX97o7AlCK3hlOXqp//hzdn1JhPy+HSZ/gfGveC1IPnhvJKCwpGHNrTTEMCeUeS4Jx0P8ZQ+AHIkFoNkxXVnudRToih+wtaXnW6R0HHX/drRxNIVYVKwDS0i3auoPAiJmWPMuZsIwmE/DLWvY7mNQUIH4lCD92pLe4E6bt/nXNPiszFn05OhC18htNHchV+oTk3eTFK0Zw1GjH+CVtOaYarTsKBNT2PggF5eDHB562O/0TtXLJoZsvAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avFlAWeSP6eqgQGjd9uhV0P0U5lGZ4EXqx+DzJ41PDc=;
 b=PyOFzCl+wLLGIXeOdvag1oppokY0NUeMCbqIrUHvv//kDFnq7e5TRhKx3Rgif8bZIETq+RD2fx1aDFIiVcpmepprt3eABYKnokNBQa1nW62ZI0PGYUfTpzMYmy8+aIT8ZGDYUNEx+3QLoy/4zj5rpPH/FHoOg/iEBki5/pHQzzDcgRNKHLK85sJ4sv2i2Ec/0imvoBa/TSGfLFmNoMvXqUpJ5gEJD0dj7xutuNTbiPMCcCFf61xYbR7DOHbz/KRo+8E0aKNEYovvdqmtdIQeR+KLM8mduIjLBlNNxm22555Z9/vBk/n6rudC40I5d68cOkR+46gBM+UL7FEQjLhMFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 14:08:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 14:08:46 +0000
Date:   Tue, 6 Jun 2023 11:08:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZH897AGywGVbt51Z@nvidia.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-2-yi.l.liu@intel.com>
 <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfDrRDI50oGih2r@Asurada-Nvidia>
 <BN9PR11MB52766A760580E6FBB995A33F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZG2fVj41GgosR1dk@Asurada-Nvidia>
 <BN9PR11MB5276F1410A11ED631CE6824F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZG681VohNlw2vvLD@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG681VohNlw2vvLD@Asurada-Nvidia>
X-ClientProxiedBy: YT3PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 57346cde-b778-402d-24d9-08db66978b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKYHDArzlwULlu58riQb892LUOinv9cPvdVw3lxqab7O8JBr6P8KOve4DIRDFsJ/oCpZLhlIZwKVd+t6qDOnP1qUTKeTat59Z3Csnj7TehxEQXeR3EFbmUNXAbsBJdQwP8UP5gu9toP8SurOtxF4AdsI0qCBD2JeNcmcDho/KKpffJ+JRnEGPed8n0bW1B06hu4zi7auvN6YK2huoCAaG2xqEiZ+yHjDCFMTt1Xu6A59kqkLnPt5WCQDsMm8G8IiZUIbvrGJb9WJwLEnzHs66ZH7nhqu9qwJ+kbevQwBGmi7RQl55Lyw9nK4kx0E5c2Bx86B00TRICt6Wh+weyGUFwoawucotsd/0pGZN6CV9IvJS03zeuviB7qlQUQLFYvI1FZciqOrCXojjB0n/j6u9qmC4/FoEuR2iQU8gnMDhJZOCgjTgxkyow97IZ/fUiVXAMqo6NlZAjOPicl3lWWc5iCVmzftgTrHzO7YmupKVazeBEMgE50UqPmrzR9mRFKsb2foO2hTmZ4DASsCFZ2k7YX9xfN6u1mk7L1aGvvIgOGKZec+1x+EcTuJxZeSyX4Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(2906002)(2616005)(558084003)(86362001)(36756003)(38100700002)(6486002)(41300700001)(5660300002)(316002)(8936002)(8676002)(6862004)(54906003)(37006003)(478600001)(66556008)(66946007)(66476007)(4326008)(6512007)(66899021)(6506007)(6636002)(26005)(186003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUfZ3Th7SWRjvV3p6QH0JVZNj8B1b6ybdcDtqGuxYecnkw4kiluTrNOcJTlh?=
 =?us-ascii?Q?n0VY3LK+K5NnXzC4qdeXop9pQcE0ciriBW2RHtXNacW7Kf7WQfK9E51rJcgr?=
 =?us-ascii?Q?MleLkyw8cwpde6NMHOZx/15QaM2qDdpOiWRiBsdSFUnPOAyll3gRKASFoiM5?=
 =?us-ascii?Q?iztRWfYB1SgsdjOdzlOdW+MKPDhdRciM0VEoHqYso1P2aWK2DbS0wT1yC0NY?=
 =?us-ascii?Q?LUkWXJFtg98ZU1ZK9nVlMRwwIvVZmbbv4tRf1Y/vG4gXZHLxmia8bC+nxxWV?=
 =?us-ascii?Q?XFfMMMtkZLvC2Q2a1AcypGdprOnytgqDuX7d0YalH/jn67flRTC5/31VKIFq?=
 =?us-ascii?Q?QkZ0PaiyVWAZ+g7qPRq1VKD+Y57YTanwJuSUDxV3dtx7pk+bsSvRbY/nur61?=
 =?us-ascii?Q?8BtCm0XxLhxgZfCVmaHYr13FWVvIxFP34dBBK1hhpDXx0tinkZbc4ODaxqww?=
 =?us-ascii?Q?ddayUw7eWEWh2jL78M21mk+A6cIaEYiNS8plYfnyywGdjasvJCEpH5cKeohD?=
 =?us-ascii?Q?L/F6uicudo1v20W5JK2D0yBBdXzUZVZI77NByjBFc1YzWwQSy1JY06VRio95?=
 =?us-ascii?Q?+JqInwyZJL2xbkPCIm8Im1syxFpl56qn09MQTsse5EzAWrNkT1haJtrQINER?=
 =?us-ascii?Q?YuzBI20q6pfuMOeU+k8HNQ7SN0b4a1t6E9bRIfgCK/Pxm2VipjRYqJTEMftN?=
 =?us-ascii?Q?Q1w8nUMjjV/A98EzA0vDzj5YL+Gx9zsLQDdYIdLTFwjnY2kb6xtp/WYvSqBN?=
 =?us-ascii?Q?Abj3VR3XyRxGzlekUrAgqvp+zE+6pI6zZc2L0xV6pkaoSyPRkcyKWBj+OX9c?=
 =?us-ascii?Q?2ZXl50myQZGMiDAfC6BqAzk/+FmxDQ6ddfcouKjBzwaOKQRK6wBlvXPZ987I?=
 =?us-ascii?Q?MlgSosNph/RlRM4DYAAE5XxUUcJC4onWsB7TyT3j6fpsRcaoVajD+abr/Ecq?=
 =?us-ascii?Q?W0YuLcxRoEGxM9sooR7hPLGF03zyhYEc6kWddiMUxQ3UmnBpdr3oAHBNVYio?=
 =?us-ascii?Q?KtlpJjKMwzACjoeSWivynYZz43hN+9/5bWqeEyyDR/C2FwMIjz6WBG5qdpkT?=
 =?us-ascii?Q?kyH/aBDau9zIqShUv7EP1ZidNIEju/t4bhBc8QfXUIQItXP312PKTU6eNz1x?=
 =?us-ascii?Q?pKZngFSxr0wzIOdOmT6eYByKCmqMfZx3469vJWIMtbvk//TB3EaGNTh3z9aK?=
 =?us-ascii?Q?a0b1UAOBhCiTsvE1XNlxcwFTj3WcXguDswU47iffKYU0Y7NeT2cypfqhdzk9?=
 =?us-ascii?Q?5yVYkWTmUPDnizguxZ1HlQJhC/MwAHzGsII6NpFc7Euo/HvpdZYOGnbMismD?=
 =?us-ascii?Q?Ho9yIPrc9LKxDoCUrkpKpVPSSTKFGGCDmhFE4GqZzfB4ckOBg9TyB3LxjuRZ?=
 =?us-ascii?Q?Q3EnciuE9Kub8LwvjQiKKYfOV47Lcw0Lxqb8a2i5+S5mocmx/WIqb0pRzynq?=
 =?us-ascii?Q?cu2OjZ5q8OM9xC9uJpI7MtWFOy05XS625f+KYDsMwg2IDoX1wpBzp4fDd8lC?=
 =?us-ascii?Q?WRR2I1mE/DYCy5emx7YRrGUzr+qX+y3GfYLIo1xoti2NtyG8MOYwdkS2gWha?=
 =?us-ascii?Q?7PBQq2H5DHEetAGzxzrgiJgo3TVvJfrvKezfKhwa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57346cde-b778-402d-24d9-08db66978b52
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:08:46.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSZt8AllVIUHrg1ULRIPSwpzJQqKOpSAXS84QG8rGKv0nYH/hq39OWSs+6ZUzsRg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 06:41:41PM -0700, Nicolin Chen wrote:

> Upon a quick check, I think we could. Though it'd be slightly
> mismatched with the domain_alloc op, it should be fine since
> iommufd is likely to be the only caller.

Ideally the main op would return ERR_PTR too

Jason
