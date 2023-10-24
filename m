Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A357D5A00
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjJXR4M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXR4L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 13:56:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B17990;
        Tue, 24 Oct 2023 10:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g16VE7JYw6OvclQIHP1Dr9PHFK/zkN7Tio7/8HG3vOrkU9N0Ka5XOVD/aQUWOOZp1YbxflLylYxXqwC8ONE451Kv9aRTJPyuGwLBIRp3DUW8hu8rkC72oEC8vkrx3Ra3KUz6adHBMhyNDVsNCIMXyM/diXGXdB5u0xkyiUtWjQCSEv67MXK7A/jympOGT/l+C9vyEAJX9QvWrkX+PUBmpusN6Yco8Mnp07C6PeW6llYXnl1c7B82VF5dT5F9FKgDmDejfpMsBNP3qs0SegaL+Fu1AXyiB+ywUdsO6RH7kr0AtIj/PEVZef0aLSohaTJh2M7yj/BuGNo0TMLMfP4l7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnEeaGnPDFRUjt78QOek/uf2Nf5Bh8v08ai2vOEVDvM=;
 b=oRq2kkO6eODUbNI+Ar6CmOMVszNKk59TJmBmHclthfBKIOH0tOyx6mBBFcZDCTDJofv8C96czrvTwJ06u5V2/SkOamtgP5KhoM3ZmB9JagWCNCXUBlnNNWQF+O00JBKomOVSv4HpOs4xAtnvsZG+pIy4Dtyur38qrvNHiJO8t4wPVLQSxPmOFcHpMVFGPpM6mj18Ayy1/7hduWKYjw5DGV0+vo8eCFnUwTwulULEWRumVS5ZU4NXXk51n61xWDu9+amcWRkzn+pG00I33DauBqKRHR5Azy/AWkVtkXU9oH4/mNM6C9h+DjTbiRyjTdfGXkfi7jt/2qrr9yGcFQoMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnEeaGnPDFRUjt78QOek/uf2Nf5Bh8v08ai2vOEVDvM=;
 b=VKSK5EmrX6c7RwNclACqWB+6kxkSplWEYBqe53VrKaMt+j6lledgv0Zn2Cm7ioSEol4SLD6l15EF6NXzz4Z/neyEtQwJHaY+HvEfv65QHYyOIElh4OPGfmxiug0We1VaveIYN53VrJIAj83llx/9Kcn2G2ANxwJfY3KrGsX+t+ssBroQyWE9y7TByFYX8iCXgjULhqj7Hf5tX7vBxHiVavd931FFw0JSPEE1QjxU/55uY4Ey5WUHrh5VfI971XG9iPFOu+LdR8Wj5c2UxyGfNMz8dT30Zv89YcMQ1/4FRmZMTZH1Dmpo4CiAhWX/4HxgZzYSZ1/x8FPFscRoxCwkyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 17:56:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 17:56:06 +0000
Date:   Tue, 24 Oct 2023 14:56:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v6 00/10] iommufd: Add nesting infrastructure (part 1/2)
Message-ID: <20231024175604.GU3952@nvidia.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150609.46884-1-yi.l.liu@intel.com>
X-ClientProxiedBy: SA0PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:806:6f::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: b274a030-46b4-41bc-2e9f-08dbd4ba7ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOLqVvuCkYU4cVf+8O7Lqp4xJucG7iKmDG137eJ/sf8E8+2SCK1vX5xr7NhMfjKvLTvjPF8QZ98GIVeum1HzRZz+KWhjrB+7JfH+qLMmJKyy/YcH2jTR54O5Uui4zCf0Z6oz+ZUgoSrFIiSAUKXrCL4K/IN0SPP4eGtIVaxSdRRRF/A4kYJyMy/rhDixAJftvO4mPN4tRwoCYeJXRqLTLeftgQi8G5ONmJyb8SowinJgXI8tY2TZ/Suld0BLbmr2QJ9wyCBFnzhjYCkhOmIpEDtOpqXRkvJBss52SBIpx6zzKMc5Xr12Eu0EIHNid6HpVtL/vpU3CHnpAqo/+gbID4nt9cC9eSQdczY/Zw92smIDdsYPAnPCuV/8BKfRtqfB6o4+UrW97+LV3OdY5af3y8FI58FPUQL1lYj9fvGY2MQhR9zSPG2nduvRJuDAf0f963xLaEJjpN0jkdKh2u0wrejYVYqInbyIc6OygIunaE4jZoEc2u2lGG7HnegEYbIFNfJlKrAfjhqXOBjF0WYMghTDBooQvVSDVL2Y0B+dKIW0iEP9+/f0laTyhIHYr3mL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2616005)(1076003)(26005)(38100700002)(2906002)(36756003)(4744005)(7416002)(6506007)(6512007)(33656002)(4326008)(66476007)(66946007)(66556008)(8676002)(41300700001)(5660300002)(86362001)(8936002)(6486002)(6916009)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Pl55ThFXZq9UEGNBfmt6TPqnzVg3h1vvISf8i3/qvekixCOfJaVHdTu74gH?=
 =?us-ascii?Q?DNMtIWfQn/hCQ5TCjuZ39zR7FxNrCQcyXRLaghCkgs21OG/8ONmXi9TAIvkm?=
 =?us-ascii?Q?zvX1gLTeghABMMJ49tw9Yqa98bnLdp4mrBbP1eUjyddnl7aDooxuV++NT01r?=
 =?us-ascii?Q?LNjRol038DA7gGf6w4J+yHikrnxm+LstWyBcaqm+p3Yt5Qab/LWpdV6m9TmU?=
 =?us-ascii?Q?TS8ubB4ouv5dnTGju+XxeJtwDWo2KauhvfCRrS7pRxfpTTZJhURkdDghN25U?=
 =?us-ascii?Q?5IDpzx5LwrIhmwvX5LLoxbSOLIG63tY9VDByRDRZD48aOX+PfH3EJv7Yk0qW?=
 =?us-ascii?Q?cZ8yy1db7fVYhCzG8MqgMYLINHsG6+aBaPm9mA9tQNt42mxq5JZbb3VHeHYD?=
 =?us-ascii?Q?D0Oykke9hC348vBKrEIhKmKTaANMFMW9N1hKn5a9N0WQVai0FQdHspdJAdwb?=
 =?us-ascii?Q?XjtzC+6jT0vOkAtsG5S1Ns1wYtkLmJHSrevn7qXWcOUAxiixZ9ZfbU1kSVOC?=
 =?us-ascii?Q?qk/2EEqUMJ0akCWySdBHnymV3nWF/rSFYo8cay5xuVVl/GIr8uZO5TFjsy/3?=
 =?us-ascii?Q?SAZsuHRtit1NCVgBGhFPaKPKBgRmSanTyYyZr6Afieg32oqyvAFn2npoNeZA?=
 =?us-ascii?Q?7+VcccXQ1/WWzKpP4xET8XBumV7HZhop6BJXfiUpZZwuBaYLe2yNhzNw67tR?=
 =?us-ascii?Q?nOCQysIQVIT5+JNwtJWWmZU8iOctISVH0SNPPZJ9wLhEV990H1VS9NsvTXwT?=
 =?us-ascii?Q?3DTzbOs+oHtw09RObKmX1NQ6UTymix0R34z+XfEoKpygDBLCQ/jWMVIb6m7k?=
 =?us-ascii?Q?JJTXcZ3q8+dDsf+yCRULFN94LKxZsVfR8hu5xp3YZM+smHx3UIbpjfJRzr5M?=
 =?us-ascii?Q?Z9F+O5h5sp+RUz/iUvMDI49HQXtOvci+EsZTysHwHa6iM1kYDgEoYqRDjB3q?=
 =?us-ascii?Q?OkF+oXJUEfMW5nnEKNuyG4mfoik3BfapZ4el9rasagjnQj87+Hzo7sbkXTUJ?=
 =?us-ascii?Q?aKzNyUbjMTRt+HIIQ7P5kaxD17G3NzHKpQyhDoSICqkHXhtxGUwGcJw5IrXK?=
 =?us-ascii?Q?tgNnlmXkC6kfP9Ig5C8cQgf/zra0nWuGJtikS7RFfCezUq0KcULVeAzL2iTy?=
 =?us-ascii?Q?gPdEgl7iiTkh4ze+Z3Gnvkmxog2g44Dj55rBVSiM9ghRpnHwo6EPJ0y3Q1b0?=
 =?us-ascii?Q?ndEM5J0NUpwjB4ClPWcYl2lOmgkmdj5Om2VPeuIafdiSQR037rY2KVAtVzMK?=
 =?us-ascii?Q?c2K+cwGeqwXcxqmyLP+MMLKa88CWejojWSK9kjXUb4FNj2ZuekqtyfgJDWbC?=
 =?us-ascii?Q?iomTLSPdomOR3IJBZTkaf9T73t0Tp7xX5tNtzp/9tiWTvKnfQMYGDg7HqPYq?=
 =?us-ascii?Q?MQT5f6mhQ0N+aIVdsYbWWPGvkZWaO5vn617vG/20KP53gVDcGlVfrhBMKO6L?=
 =?us-ascii?Q?cVfMbeSui12aoaLVPRBtbIlqTB+SmsC/x+CQ1LG3C7Jmys8Ib6C+Uhs1BelX?=
 =?us-ascii?Q?n+NlqwIU19xVWpifj3uKvn4raJ7KofhiozlH6M14IUtVSD96TrjSl6dAkCvs?=
 =?us-ascii?Q?KcxmvQL5GNITImtFt0Gi7QJa6IMpeCJ2A1QVbBot?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b274a030-46b4-41bc-2e9f-08dbd4ba7ed0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:56:06.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIKSTieRWUdT5lTe//OqlancfsOID2cJqh9+7YAP4BKHvX9BHuEIR+00WeJwlzSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 08:05:59AM -0700, Yi Liu wrote:

> Jason Gunthorpe (2):
>   iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
>   iommufd/device: Wrap IOMMUFD_OBJ_HWPT_PAGING-only configurations
> 
> Lu Baolu (1):
>   iommu: Add IOMMU_DOMAIN_NESTED
> 
> Nicolin Chen (6):
>   iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
>   iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
>   iommufd: Add a nested HW pagetable object
>   iommu: Add iommu_copy_struct_from_user helper
>   iommufd/selftest: Add nested domain allocation for mock domain
>   iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with nested HWPTs
> 
> Yi Liu (1):
>   iommu: Pass in parent domain with user_data to domain_alloc_user op

I made the changes noted in the thread and pushed this to linux-next

If we need more things then lets have a v6 no later than thursday,
otherwise please check/retest what I pushed carefully.

Thanks,
Jason
