Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B637637B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGZNhZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjGZNhZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 09:37:25 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A71734;
        Wed, 26 Jul 2023 06:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+rwegzfJCkOt3BVrxOhs2KQPDQd5F+QZiUnPh6+w8+rWZ/n6p2lo8J3dtglyS2RutFAHClQVWAeBkcoYnugG+VbYAi14362Q955c26Pkbby5SoYS5JrVSTzJghuJFbRm1yj20iyz5hdXQGR/ktmuaI284UnIJpEqT/qeGv9EGG7cgqtxaX9bQRjHMxMDDsJQD2kl8VJO8U6ZSVYB4wm1QyUyfTuTzM9/Ig1AXKAAy3l4eQ0lewEWvPBqvBE21NNybIWygNvPKKPErnjAjjWZkdfZ5DBwvOG1qpNYGB/i70NMg7MvrIdY8KdscvaP0k75zB5f0I5z4Judl7jWtBYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=679FG+4JUHRTZrrLXkJ18ms8n5OSJdKQc8JxBuEpaZM=;
 b=Wr4fVjfaKGVo8hAC/uyO9FiBsN4bZmJxdZcXwOVPgr6zTNWtEYAhwDhs3Gfhnb10GS3oWT4CtEg34DlvIUMQXWrzfSFkpDtj6NEsuOq/ke+IcWYE6HlPIXIn+f0ubuSTCig5/l7mEMFwqkV/j5lFBO2BUlayemHDzN9rd7YETdLwdhjsS3mxG4fcNfgha6ZQ+dWQnupIeFPj4nup716/QlIH67ixEsrOsoc3UHgLol9Wowk7eTB7kVrML9OAg7Yrwz06an2Hk1ouvOk9MDvtqn1RV0G3fAeJpCFg/zQHtUYmWD+sSmzEBfshojTJPxrj4kqAl2jKOTDhyCsMZ2NdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=679FG+4JUHRTZrrLXkJ18ms8n5OSJdKQc8JxBuEpaZM=;
 b=tY1GdB6WeMwUrfDfFzGwLw+o/jyzO307p0sulxDTm4zqm/mcWK107xqRoGRajHHJcv18VKAXEDa7W12v1R0PXPl0Dn4+wbY65eyFSf9q33VB5dEBsj7Iha6+QxTznsf/LVnZfILFBwZeh5ZrfrUxRuTY4MIm+ob5w18rnjxU2YG5J5xqJhLICs1aqmb6CUED2mbnH+K+X60Lq9xqMV2obeDZS6QVuEaMEjuQ8Kbo3rZN8S2BsrXASXfbpXJ2B8C59XMW2oTWt1IZni9+me8F4T6qaUnba1eduaxOCyKefmL/X9MEVgMsVe3YIBccTRhMq0vNlhby/ojdyGhO8NLbUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 13:37:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 13:37:15 +0000
Date:   Wed, 26 Jul 2023 10:37:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 00/19] Add iommufd physical device operations for
 replace and alloc hwpt
Message-ID: <ZMEhiuvv1tNQNdUW@nvidia.com>
References: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:208:160::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9ce349-f259-477d-13e0-08db8ddd6c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPCs/pK/Ji1K7+RGaAgxPu5QcSrAg9FcHGPyI1EauXS9dpWVOlgryHqGmCdJz7zaZi9c9b0sYgXWyiCIX0i+CLWAWphP9lc9+TvJVVh95uszG9FHj/wd8wGbDqgi1W9Ef2dlsgcZYF5/wfgk0Phhjb5i+9ou+2zwCmt0H8TpMQtD2+cDRO1XR/jWtF1W90NgSOiEKMfZ6e1bp9UM/RWl1aPAkzTHOyJZWxNFhO+LwAXqwzKCS5gZzvElmTpc59hghshLQBJ6XTmIc7jYPFxJCF31ei5V7WYgciIxP5MXNhkKifpRYHzxDAaef3STnnGAYshK9Ms23Ha+ukWRGRLIXAq8i8ySh/E7Oo1Fyk7ncjvqFhBOKHqO2LpqfFCpCkSukD7egj5LOuM/491lJW4s9vagYhCmqS2P4XH6kopJzt4MqI0hHvVsi8ih9rNkQKsmkrrJ8pp7dVCdjz3WivKXHlUFjxeXV5xMuizEfIN3EvSqsjJZGopBFa3OtvblW8lwrlxdEqaMwnErIwhd/jQFvjdm8KQYUfC2ZazmH6diHlBUctRN9gtW9Mm5wqU0fB5pWqAds7corlAM5AYXbnU9t5obK+/iXEtpnhKXHkeYu2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(316002)(41300700001)(83380400001)(966005)(6512007)(4326008)(478600001)(66476007)(66556008)(54906003)(38100700002)(66946007)(86362001)(6506007)(26005)(2906002)(186003)(6486002)(36756003)(8676002)(2616005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0LlWn+UOOk7I7x9ewb/dXUEDG0k7c1GNnajjr/psD2QvQSJrqFdoICcBZ7cX?=
 =?us-ascii?Q?DCz9ymsgN+DQJxQZCmmg1G2F2dSibMVFL8BejP5fLE3AG80XrUdGW2gdBE4W?=
 =?us-ascii?Q?9mO74EL5fQRKXzSPrv8t59KUUcNySFMT/etr40MI8Br+qSH3pGwSX7ZjKMco?=
 =?us-ascii?Q?2ekZdqFYSEQcUw3sYRyqr0U/g3lpWhgkgzwnqByH3uOyD8GpMWC6tAXEA54F?=
 =?us-ascii?Q?EEvXKQ6G7HI9YPlqiT0SEL13yB7Ht4AY6B86I8eXLG4lDdFGXoqtjWaIqZJp?=
 =?us-ascii?Q?lPU5eAYF4/2jPHudYX21uITWnaIVScHQgM3eGmMWiuHTsfWaZCc+hHRgs32O?=
 =?us-ascii?Q?KPxMYDmIOjA0k53DziURqY91CUUPzzvAcvS1v8hb3OJDTsuHLRbR9TrxaLsj?=
 =?us-ascii?Q?8oYVPQbSm6a/J5IyreT2oNO6xjWvCqY5DagqLKgO7RMYkleDWdTaXgXSsYUO?=
 =?us-ascii?Q?MxVunGcHjtpV5tAsZSj3vd/Ux2EgKCChE50+R/oBLw4LBAALrNaMaiInewCV?=
 =?us-ascii?Q?WGjz7wWSVKtpKEOTLTt/8RSCLgziJQ9XfLDfx/VPa/3cqMTEMNPifUKDhHaF?=
 =?us-ascii?Q?zI4nAp6ky9hP7811ZaulGXrsgHs8COtoYlVbRrFoYaAgnAqmsPrWAavMCBht?=
 =?us-ascii?Q?alznBsCrh+HTvc0BkgnQqseupO51aRuZmSbb/N2g5WlOtdAIvzQzF5b6tY66?=
 =?us-ascii?Q?jPkwn72TAZShjmHxWTBRxbjVWrqi4u8++NgQfUGxc2uJyqOj2SCdjHRTawmY?=
 =?us-ascii?Q?Q+eTQn6ws618US5ilNY8lhQp7D20PULpetAej86YLH3Pu/cBjYytlwwPpNFW?=
 =?us-ascii?Q?x7k5hpCEfgYNWM9VbYov5KlP67ZmPdbZfezVS5F+OWfzOspqMNcIkdA2K1xS?=
 =?us-ascii?Q?5A+RmHPP6l9GKuNjbfkjgKqre3eW83o5fSecfYyD2QH52hvGyz7BF8GPGMuM?=
 =?us-ascii?Q?nPXfL0mM5DcKy3uK8CiIYYpCIWoIwwf3NShqq6ttJAJc6rU1/4GwM25tP5HU?=
 =?us-ascii?Q?0Puq3fLaHv9/Bk6pEOjU67lUjQ9JP0WWg0HMDABmFbf1cxFsQf5XQHK9qTPQ?=
 =?us-ascii?Q?pE+4B5sSNlu0peeL6HH8L/pnWQiViyrEQ6fFxWuN2tl196FomwZUVyPJ6BAU?=
 =?us-ascii?Q?J6nK44cQXtSdzeBC3fdEv2fyW8f9vwoXc94zIlr7H/lnp0+a8mjaQQr/CDys?=
 =?us-ascii?Q?lb8hbm/RcWdF23Meegxx6E2Zila/4lINx9zr7574ah33+IYS1iCfRBe9a8VA?=
 =?us-ascii?Q?rLl7hOZ7HOHemi8O7IYvJIwMHlDyIaaAxtDcZEhHrKqH1TLV44PY7o/D71wH?=
 =?us-ascii?Q?1oC+qLlUwRuFHdtXNWHNmPtawT8ek00j9b/lNcESJ9vxG12SkiN3g1mG22OA?=
 =?us-ascii?Q?uRxX2iy/zmeJ9y1Todwx4cCwRoZTfLCsLHyEZXbECGcnCUETnDaWv2aegOOV?=
 =?us-ascii?Q?X5LdnKgLwbcsLK3W+nOcoNwUIOPSSsWp74x1KjWwCWtJuNqGJZqoSWWd4QBU?=
 =?us-ascii?Q?Sgdn0AxoRjEYMY6x6K5APqYYjbrKlyhBGvF7FC/sqw+x+3x0J3EMOgV3L95G?=
 =?us-ascii?Q?ix3XD4YGpAFxeh8UJGcYMmZM/9jFVLLppXgoKK6z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9ce349-f259-477d-13e0-08db8ddd6c8b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:37:15.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQp+NGatY33VIFnXQjrDEYqvzMFxositYvZ16gHwF1NS45OvmfJSOSSBXO/c9hHr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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

On Mon, Jul 17, 2023 at 03:11:56PM -0300, Jason Gunthorpe wrote:
> This is the basic functionality for iommufd to support
> iommufd_device_replace() and IOMMU_HWPT_ALLOC for physical devices.
> 
> iommufd_device_replace() allows changing the HWPT associated with the
> device to a new IOAS or HWPT. Replace does this in way that failure leaves
> things unchanged, and utilizes the iommu iommu_group_replace_domain() API
> to allow the iommu driver to perform an optional non-disruptive change.
> 
> IOMMU_HWPT_ALLOC allows HWPTs to be explicitly allocated by the user and
> used by attach or replace. At this point it isn't very useful since the
> HWPT is the same as the automatically managed HWPT from the IOAS. However
> a following series will allow userspace to customize the created HWPT.
> 
> The implementation is complicated because we have to introduce some
> per-iommu_group memory in iommufd and redo how we think about multi-device
> groups to be more explicit. This solves all the locking problems in the
> prior attempts.
> 
> This series is infrastructure work for the following series which:
>  - Add replace for attach
>  - Expose replace through VFIO APIs
>  - Implement driver parameters for HWPT creation (nesting)
> 
> Once review of this is complete I will keep it on a side branch and
> accumulate the following series when they are ready so we can have a
> stable base and make more incremental progress. When we have all the parts
> together to get a full implementation it can go to Linus.
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

> Jason Gunthorpe (17):
>   iommufd: Move isolated msi enforcement to iommufd_device_bind()
>   iommufd: Add iommufd_group
>   iommufd: Replace the hwpt->devices list with iommufd_group
>   iommu: Export iommu_get_resv_regions()
>   iommufd: Keep track of each device's reserved regions instead of
>     groups
>   iommufd: Use the iommufd_group to avoid duplicate MSI setup
>   iommufd: Make sw_msi_start a group global
>   iommufd: Move putting a hwpt to a helper function
>   iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
>   iommufd: Allow a hwpt to be aborted after allocation
>   iommufd: Fix locking around hwpt allocation
>   iommufd: Reorganize iommufd_device_attach into
>     iommufd_device_change_pt
>   iommufd: Add iommufd_device_replace()
>   iommufd: Make destroy_rwsem use a lock class per object type
>   iommufd: Add IOMMU_HWPT_ALLOC
>   iommufd/selftest: Return the real idev id from selftest mock_domain
>   iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC
> 
> Nicolin Chen (2):
>   iommu: Introduce a new iommu_group_replace_domain() API
>   iommufd/selftest: Test iommufd_device_replace()

Applied to iommufd for-next, I fixed up the conflicts with the cdev series

Thanks,
Jason
