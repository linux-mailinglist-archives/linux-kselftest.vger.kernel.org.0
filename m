Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3946DE13C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjDKQnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDKQnk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03355BA;
        Tue, 11 Apr 2023 09:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuQuVwqPel4RA77o3G8J0ZSZIdpV4QGh33T4A19vOv/IM6CwE+6GwEPZGbwOJ5EvT8FxP7rOTHDXaCzVjzERo0KD2cRWvNXoVezs4h9aSY96B4Px6HiKxiK+xSAmkPVfbwoGgG5mKA9Odmwm5gcu4ykbH7Mp6mJYkWdV9CEjaNeJAw/gYKwYNCtU3XZ1T8NesKp6qDawzpvRL7Nm1Iu0TqMxHZKlLCJVy/Pu4WXWQRkupSsmd7ThGDGDazCvDO5GB33r5mzWY/Svl9mHubcDZOkCPYzzRvYtsYxJnxDE6bc6kW2R9oWNkxdN8lKV57JWVlBcf6WTbdkfnAdasZXrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wf9f+VmXsYv60CMmc/TIxiY5CYFHQ2mNb/7gRrSiJcw=;
 b=KoE60o3MhBLy4qo7zZmLvUtyyDeRhQlF5d2CXwj97lnbAjrqfcjL+RexuSymG5KGkPygPR5vvLoRDwnhJXTieg8omqOLSRpmcSweZgk6yl8B9cd2fAPWikpp9L9aigNxxvJcRGFtIXiS75KEDNu0fKEsRpZ+N4sTC0m1kbAJyWEnBANbh5USo2VC2ChLlGO6WkUZ7UDBWS+QAqq/lj7xZVdkwceHopyy6CQOWzyAoICtm+V+U6dWBeH17N4pvlZFWPW0RVM0RdYMGoh7O+8EKvPld0MNk8VS7uRTvGB/M1s9xDFlYztFiiKvWqxItJqDOabkGlm3wROVO6GgMG2Fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf9f+VmXsYv60CMmc/TIxiY5CYFHQ2mNb/7gRrSiJcw=;
 b=LnI2u3RYbN414ZR0mm165veTY+Dtu6SOd96Wv+dvJSvEhp5PgUpsnMp6t8K6wGU78FKxysqMjoDXeHI++NX1L+apgxCHSpFfOyyaprT/KS++5Fd3HsaZwfMSPCmSjpYullgXrcm4zo1Kom0wbRqfTEY0JH68RMlFGblpq3yCIRtSQEXZUMmy2nDuHHXZQVClpNSFnjwNvPWoaHkfdkBuM02BZVd2K2dCSTR2T+BIsixX/i/E23rE0GjJXPAlOjgtC74ALGls3RC4I2qVPhzuyy0fxXOTD6W8AmPLkpoW7P1/ZxNr+uGbJWn/gjdMeEUgtl+l41m+2H0QbWrycdfQgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:23 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 00/17] Add iommufd physical device operations for replace and alloc hwpt
Date:   Tue, 11 Apr 2023 13:43:01 -0300
Message-Id: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: bad29b85-b481-4699-cdf3-08db3aabdc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDSkKYUusehyHN+znpbgb2tAekrl+2NT2r7MtjMDiKCM4A/XtxWkvYEJpdJloq/sLW78n4fSMprMLXX0Z6H1yd9zWNJYCIZQsHWLU2nuLOgl3ITPBE8Ce+sYCNld8yOOCNli0DecazmHRosgjczlf0cCLTiJVYUPiXs0HRxenDlo9XGvJPOK+Tp2eMguH/SMziiQbCm6cB418yhccr/u/VEmvYqzQoiqaScWMRmAcJykdUJ2zVuvyb1vg0zXPhI/sKtAtCFAbajMoZPlaWnMfhR1KmGhZd4HECMKimJfeA1SOn8YZvNBAAzgMTBUMuXPkvZ0Ko8OqCfRSZ2m9jGUEIdL5VDIZCELqMgemgMWM1a2Ih6OxMUmBaPKrhVCOBJv859EQ1FfIgnnMtDCVrSsNkErIJ417VU5f91b6cmMbP6ymrS8zrNGBq6rYL3oPW375aBO2BPyNqHNH3FEh8N7axMxtV7ujZihlRRR/RUhWppYJWQRln3uFAItqf49Y/mKE1NNLQNZyJoPKjU2EmYcUTRrTzM59jiKinidNAZWldwgT7A9xdO9a7LPMR3PJ9zsezaZ1KMdxuSJex15q/uUSwba88lPjranD+y32uOVU9lM8Y2LGoXIIBw4A/A6zHruumgBaMfXC2RZ/3Pa8NfDKODQyOhFol5cN6zw1JXaB78WhljtB5LA68gkqOOnABBa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(966005)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+kqzWFUBXSR+5eGnzzlSW2K92a2K8wn2Wc16dZgXySImjPjUMC4HyygiPQxd?=
 =?us-ascii?Q?fThaO0ool4+Tk/iauuoLW2FfTkz2XqlPvt3LRF2bDCTSgSFkpuowUDwVHsJQ?=
 =?us-ascii?Q?y+y6T2k3U4FZSZ8RtAq5fk0nJ+4UswL6GuB6iVBrGJpyhedryESW1vkB2bFy?=
 =?us-ascii?Q?CiHcdsEmzJww/ZD48fVMmIs92BO4/q0I54xyG5TR0T3m+Ku5k/VsKXkeRqNi?=
 =?us-ascii?Q?8xOOFi0FLCOayalAyhToEgveu3sOVQLbR9gWOGMkzPsYv3q2wbpsOya1QgRC?=
 =?us-ascii?Q?vplRknX8HsUBjPOoV0sM2zTW73VgotVVePvKjTabxgsn+lGqnbnMRcqZyT9D?=
 =?us-ascii?Q?nqtEQi1VFvdvO2vo+vSVx6cBuf/qhwmM/fK92d7IYQAhKGmFN2dWg/M1NLZu?=
 =?us-ascii?Q?kske/m9U1/rU8/Mv6IU5BAPL/w+T/4JgyR2QINfBLAS4rWoJ2QQPiFh8dlOj?=
 =?us-ascii?Q?ENoods6j44gGSDX6dUxsPemJCsYhzRGR0FDSNak0kNmYhgXzdEjRShecEaWL?=
 =?us-ascii?Q?pou/XERtUV/ZeFqi4ZriJR28qH3KGi5n2SvMyiSWVPWGRTqfxIz1jOOMSfiO?=
 =?us-ascii?Q?PE4OnuNKKwRSq4EQxyybdDoXCDt3Zgh3oqMgv9dDeoAAb7fGxODNPJmHaAIe?=
 =?us-ascii?Q?m2P0+gD9e9fmx3gMKR4FAO3JX82TZW5TL249rzvL6GfLU6Trqd7pC0UTE8Sd?=
 =?us-ascii?Q?ErK9CaJZe85H91uWq2fCGhG508DEOgdwTfbAqiP/hq2eAuMg/apfLI2jVDqG?=
 =?us-ascii?Q?Ild+Rd4Xdgu6it4xK4+G1flP74ZZboBBbG58iuBr1gdMHHvBOqpiBD5I9NNY?=
 =?us-ascii?Q?aF4F2l+Sydb1LfUCCJvIL0q9rU7E1L5Kwq75NE7kG+7zS/ZIJ/NSj5N7BdwT?=
 =?us-ascii?Q?8QxqX5/LQk2jaoboWsJ5LxzLkmgZV0Qb3UcUxiUEfk9la/5GyVOf9wdpDGTv?=
 =?us-ascii?Q?PXvGFLWHL25BffWTlrnPnnui8lY3e/qpp3N1lVRe5WJV3HYCub4VF6BgbHBt?=
 =?us-ascii?Q?7m0g/kOIaDuFWUABvdtT9KKQubmRDBpOgtV+3/amVZbRB2BBVFR7w+2d1eo7?=
 =?us-ascii?Q?93LDofgE+f7Sla5nuNBgr3zJ98rKGmsv/GnRj4X4lYHdT9FUAFZNJYI+RdWB?=
 =?us-ascii?Q?XGwOCxEuul91Bu6GPitT3+jM/5b44FonYUJjBodz8Z3c/1PP7IbiB/u72wsh?=
 =?us-ascii?Q?QXmrpPHfcmNMGN21kEWSBXYRpFj4D7NYg5L7hWv2px9yDZUURbniKC+eM/Jx?=
 =?us-ascii?Q?pHGVAEQZe8A7fpfa/zr8o8IBo+OehkjJXEdswmmJVsQUBzFzjHkIMFIPUwM/?=
 =?us-ascii?Q?mn8FHBdxW/R70RYOQluIsuTNjLtaVrQPOv0KIp/MUZk5rrpMXYQ98FXf8WHe?=
 =?us-ascii?Q?nmeAaspImB5IKL7881yWixaho3svltMiuonbxzL8/molX0x6cRkHDfk7mIvA?=
 =?us-ascii?Q?APTwKwAn2MJouLjqStlQAqITioeo8XtVUpJMayB3Ul6pNG5ENhngLuKtxYvV?=
 =?us-ascii?Q?KZ1SPAH0Ko0eb14MQ7S2FxX9vfWSpDVEi3RnMXdcNVIqyX/Rk6Ug2a+Yx0WB?=
 =?us-ascii?Q?Z5Bt68luZhMGgJLNszFl4Ln2TtAnyMWEb7q8TSKD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad29b85-b481-4699-cdf3-08db3aabdc9b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:21.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh49Xiep0Wzisvy+FKSFbnIpyADpZbgwKK7rf2N34jAIvT8fRDKSINnEmz5c4O5r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is the basic functionality for iommufd to support
iommufd_device_replace() and IOMMU_HWPT_ALLOC for physical devices.

iommufd_device_replace() allows changing the HWPT associated with the
device to a new IOAS or HWPT. Replace does this in way that failure leaves
things unchanged, and utilizes the iommu iommu_group_replace_domain() API
to allow the iommu driver to perform an optional non-disruptive change.

IOMMU_HWPT_ALLOC allows HWPTs to be explicitly allocated by the user and
used by attach or replace. At this point it isn't very useful since the
HWPT is the same as the automatically managed HWPT from the IOAS. However
a following series will allow userspace to customize the created HWPT.

The implementation is complicated because we have to introduce some
per-iommu_group memory in iommufd and redo how we think about multi-device
groups to be more explicit. This solves all the locking problems in the
prior attempts.

This series is infrastructure work for the following series which:
 - Add replace for attach
 - Expose replace through VFIO APIs
 - Implement driver parameters for HWPT creation (nesting)

I'll update the linux-next branch with this version and keep it on a side
branch and accumulate the following series when they are ready so we can have
a stable base and make more incremental progress. When we have all the parts
together to get a full implementation it can go to Linus.

This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

v5:
 - Got back to the v3 version of the code, keep the comment changes from
   v4. Syzkaller says the group lock change in v4 didn't work.
 - Adjust the fail_nth test to cover the path syzkaller found. We need to
   have an ioas with a mapped page installed to inject a failure during
   domain attachment.
v4: https://lore.kernel.org/r/0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com
 - Refine comments and commit messages
 - Move the group lock into iommufd_hw_pagetable_attach()
 - Fix error unwind in iommufd_device_do_replace()
v3: https://lore.kernel.org/r/0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com
 - Refine comments and commit messages
 - Adjust the flow in iommufd_device_auto_get_domain() so pt_id is only
   set on success
 - Reject replace on non-attached devices
 - Add missing __reserved check for IOMMU_HWPT_ALLOC
v2: https://lore.kernel.org/r/0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com
 - Use WARN_ON for the igroup->group test and move that logic to a
   function iommufd_group_try_get()
 - Change igroup->devices to igroup->device list
   Replace will need to iterate over all attached idevs
 - Rename to iommufd_group_setup_msi()
 - New patch to export iommu_get_resv_regions()
 - New patch to use per-device reserved regions instead of per-group
   regions
 - Split out the reorganizing of iommufd_device_change_pt() from the
   replace patch
 - Replace uses the per-dev reserved regions
 - Use stdev_id in a few more places in the selftest
 - Fix error handling in IOMMU_HWPT_ALLOC
 - Clarify comments
 - Rebase on v6.3-rc1
v1: https://lore.kernel.org/all/0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com/

Jason Gunthorpe (15):
  iommufd: Move isolated msi enforcement to iommufd_device_bind()
  iommufd: Add iommufd_group
  iommufd: Replace the hwpt->devices list with iommufd_group
  iommu: Export iommu_get_resv_regions()
  iommufd: Keep track of each device's reserved regions instead of
    groups
  iommufd: Use the iommufd_group to avoid duplicate MSI setup
  iommufd: Make sw_msi_start a group global
  iommufd: Move putting a hwpt to a helper function
  iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
  iommufd: Reorganize iommufd_device_attach into
    iommufd_device_change_pt
  iommufd: Add iommufd_device_replace()
  iommufd: Make destroy_rwsem use a lock class per object type
  iommufd: Add IOMMU_HWPT_ALLOC
  iommufd/selftest: Return the real idev id from selftest mock_domain
  iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC

Nicolin Chen (2):
  iommu: Introduce a new iommu_group_replace_domain() API
  iommufd/selftest: Test iommufd_device_replace()

 drivers/iommu/iommu-priv.h                    |  10 +
 drivers/iommu/iommu.c                         |  41 +-
 drivers/iommu/iommufd/device.c                | 516 +++++++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c          |  96 +++-
 drivers/iommu/iommufd/io_pagetable.c          |  27 +-
 drivers/iommu/iommufd/iommufd_private.h       |  51 +-
 drivers/iommu/iommufd/iommufd_test.h          |   6 +
 drivers/iommu/iommufd/main.c                  |  17 +-
 drivers/iommu/iommufd/selftest.c              |  40 ++
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/iommufd.h                  |  26 +
 tools/testing/selftests/iommu/iommufd.c       |  67 ++-
 .../selftests/iommu/iommufd_fail_nth.c        |  67 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  63 ++-
 14 files changed, 825 insertions(+), 203 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h


base-commit: fd8c1a4aee973e87d890a5861e106625a33b2c4e
-- 
2.40.0

