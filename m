Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B436CAD3C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjC0SjM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjC0SjJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:09 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEAC3595;
        Mon, 27 Mar 2023 11:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbiSnpSM9Y0rYIDImVnKTGjhpQcea3HFp8TNONyWEw5Sulz2sRyQp1IVNT7MXVs+rNYbQ67NbtE2eZszWvgxK09oJnsJu/p/KrmZ9QhBwn/uteithnE8g4ET3cnAolglgnvgVASVqDDLUgejhPfEcilKBX8Vz3pfupYdlWGXZ9HnfrTrMOR237l7F1BW+c8RK9ifUHEQQ06XgmTjInSYDPzCoALxTo1gwB0EVyX14WFnAfMvujAyK7imtV5DzZ/u3TZF9x5XOq7LZXLSqGHzuV+MWdfmgpbQyyuWkdJJe4DIEA0bH0AfXe9Mpu3CB50/AXsJee3q2NvBR+I1Agfreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y7YumEOzUCn3VLw1igQSGP/Dtd3WM/+4PIP3eoZBlQ=;
 b=CE9gpEGClSjIJAL372ClyyhLpREp4lWMKjVmnayASiuWlIX0+2ATQ8OaN06Isiu4HBICQeUt6gso/rCyX0aPMnAweSOH0kX2Ef99d+DZGNnho1MQkB65SkY2szTf924pPdQChKyLCD6EP/wBcJzI/ajfq0aZ8U+AQyYP27m+ahTSH9FAZ6gBf+hsqPxdZOOdCkql344JVs0VuFx5EA7MQtOb3G4wokhVm0EC5/YVGIEAdx5V/j0E1D15AQBaYTxIIlCOALExkanuV3iyGcHWgVj2MmtOnYuImvTnEf+BAzZX8IpHMpkVw29F/DnhjBpOwlqoAmXoUiWZWBV7WDmLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y7YumEOzUCn3VLw1igQSGP/Dtd3WM/+4PIP3eoZBlQ=;
 b=rP7uFVc0IZkGddWpVetPmjnNSJjJqskRq8k9Ps3jVvWuZy1gSY2RRmZmF8gADb2RxepmC304AmoDLcaAMIEaJVsrYk/EIFaM/akTZTuVva+8aNuc5/BKXRgDDXUzWeA+xxebjXMyXKZJFzsyiBSd1sGBkLI074wPRSCFcJavHApMpHtheF3L2BXnf5hEDuXZt2a1pKEIiV2wX+LgPxjEwai8/usHywgxDVYXMCkjCd6EA72oplkFKOnvJ51FGmmAFcNG06ezyM+mlVMZDgFRA60KcwmyPNbaBzudcODHelWG/MMLw5e0LX1zMrhlnfKoBaD3UziihvoWqF5DsgSw5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:17 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 00/17] Add iommufd physical device operations for replace and alloc hwpt
Date:   Mon, 27 Mar 2023 15:37:54 -0300
Message-Id: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9889ec-a4fa-413a-7f44-08db2ef26bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9MFivW+8YaY0vtXUI+TBdaOTtoOh9/D1E9h0Xv2NairidkDTQdba65xuQLKrJe7Mk0kqbIVBQkCKHTnk3fzb7cymBevvHofK5I56TbeAxgvxQb7VSb732Yg8gBniRskHfeycgkAE9CCCwPjIVJvU1KBSFYFixPSVZROPdpAHMxZDEATPhp1bSBUHe23KUj70JzyUp+Y+vYo0Mznt3ZDBppTVLG8AiSuDtutioI97amOWzpGSrMTu5/9IZYRo566M0lN2TjWxd61HtOCuU4qkBp2vQGOtzPw9iDiUGyrYnBATYUFpJYkAPADfy0v8tmeSuKzboswSFcgN3kjRxp3HChwztgl/UQR+jF4YKDqNGyoYbznXDiRz/1mELjIHY9WCWOsaDBkQE568gvpaAoBIbwF058rq+ldQdRh5LsraRpzGHj+J9n8hVI3zDCoA0T1t+vXZX2EcIEjmU42emVTxLHDPpxeC1xrN6im9qRTt3IRQkBw5mDek0zhahftNeAcHbfClf7yJz6Ii2hOMgXpsjj+H24GCY7BoCf2u7r9j/EKhfm5aLgNApNBgyw+Nuej42UrS387lUNGrSxcDzhTIDLIqJjJvNYJSmcgLOhGmdUTlZ4VZGRnaZavTylnrVydWHNj8+SnFmkMdo+SQEkv5k2j0T2ok7QstE0L80U1cJumtxGhGHPIyaTaNeSNKnRz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(966005)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/28zN/Wau75lnF5aOHGrFpNyBLTD6UAgVt7GiW3+qu9gefbLaprsc1vtK90?=
 =?us-ascii?Q?QPP053ooeTEicw1z4iJZ26iv2peepDNjWXbI378bcU348VJ1eSgqF+GkO8VM?=
 =?us-ascii?Q?izETZ3b5OVDZB1snZVrXWC4Qv9v/enjDBIBBRZIcCmB4OwCNzxwWtUCfJOtJ?=
 =?us-ascii?Q?GAnTkfHtfpTrzm5JB3QPid7pr2OjLBoiVMyHuNSmC79LDTUbhCNsQVhGst9U?=
 =?us-ascii?Q?iMWr5S4iAaKHsDf/kxFnlB/ADWFCVAG8LACso8laAZ8K0W7GX2FB64XRlDMS?=
 =?us-ascii?Q?gWAQE16ZMmpdlhpQElTX8RS1P88fAZvunGq/6U5Mz/+uVNJ3v9PXPPHDbfPO?=
 =?us-ascii?Q?ujMvqmA/XejitLArZwTNGZIv35tdS69Wk8i3w+xNYLpv4/G+epkjLd47UaMo?=
 =?us-ascii?Q?3ZQzNIvJsnl5x9u4o/EaeXhKcUrXh2YekJ0cqpXzdE5IcPuNZUBdz2v7offW?=
 =?us-ascii?Q?X14ontGbQURbcrdl7xxAh1uOU/2EtwArMHrDEDZtLHmobfwddvtG06rPk01j?=
 =?us-ascii?Q?taZbrsFonMaWVqGHh5pichU6fSVKY20oercdC5jSkHuSQqlcIN0UD7Nzd6EG?=
 =?us-ascii?Q?cTLW+eqKZqq3EKNUAMWpoCkq6J+ApqBRkg0DmnIxXDJ7Sf9viFTFsu008IaS?=
 =?us-ascii?Q?s+6lssjNwtUvUvEQ3BPdXPPNRl0ZZY+WDUMuEVUuzX1NysRW4GJU87Qlfiea?=
 =?us-ascii?Q?ee1yrNaE7Cs4Vhv3qex/qeiIDb08Ez9kXZBQrZ6OgS1uDwlTX7QAuD4M6BIz?=
 =?us-ascii?Q?cHV1ZXzTJwJ9B25s/bkeKhkrO2z4rgJtqBwtbpTnrjlhLEpr+rGKRa3xMbKy?=
 =?us-ascii?Q?Rg9foZl3u6/pwf1+AGgNm6wCJsbgEy75UxmPbR52t5sTjeXoC2XBa1dZs41X?=
 =?us-ascii?Q?DwCTUAaP3N0npuXr9X/X7no7DbM53hByF4DY0Bxbo+hHow9JHUh+3+ASXeOp?=
 =?us-ascii?Q?1eVJa8Zbj8Il22B6dbypGElEic73C9lqiGZvdoyZ2evtUtv1a8/qFC3SM36M?=
 =?us-ascii?Q?MrI8DXwEdOy5COsgqhWGR34aWKckim+SoFnkkksOsW3UVSIqtpm5bX0Jybxq?=
 =?us-ascii?Q?caFVwJhQ4jMD3DmcvrY/lMENVQ9J/P9IR2g+xb7BzVEYBDyEQmz1XAzdxjOx?=
 =?us-ascii?Q?hmgGQIIW3UkJDlLd8eRxJvzOClAOvL4afoHgbycoD2yChFN1sR6DauidrlLq?=
 =?us-ascii?Q?+rG6ipISj6UguRFwo4CKILHUggk0ri2bujdMt4u9T2hY78fDxwjZj34yRZiQ?=
 =?us-ascii?Q?qH/SugV6q7yrvaj9kVYtUZ5gORfva1l8+IKpSiv3hLMN7WUurfnzRPgwSUW+?=
 =?us-ascii?Q?NtZrsO6cWWg44AkuiihEqgLlQq12xVYVRaSFpu7yKvZS0HhU9X4EVt4GM0vT?=
 =?us-ascii?Q?fWtHES5D7hgj0dpSfjKOp+PsjA2BVEl7ROWR7jnu3mYmoFjgKgXKwB/wfWpi?=
 =?us-ascii?Q?kIyADk06OB8BfRhmzNCSd1U7F1BWACOZ61u1M0GgttxE6BCBDxdF5I+Nh9Et?=
 =?us-ascii?Q?1ZIogqHmLbzqW6LCoovu/Xu4D8E0KQXV8P5SbzKePnMGiMCO4wbOICDxyyAJ?=
 =?us-ascii?Q?z8LvnsfJOWwNOLLq8bPsdi9HW5ExkY1sMid9Ih1X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9889ec-a4fa-413a-7f44-08db2ef26bdb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:13.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLhjd/2VvkoTTc9D0J4L8lSr5WZqjlST/EukKzU3hjkuKv+9eWkCcGkEXts3sa8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Once review of this is complete I will keep it on a side branch and
accumulate the following series when they are ready so we can have a
stable base and make more incremental progress. When we have all the parts
together to get a full implementation it can go to Linus.

This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

v4:
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
 drivers/iommu/iommufd/device.c                | 523 +++++++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c          |  96 +++-
 drivers/iommu/iommufd/io_pagetable.c          |  27 +-
 drivers/iommu/iommufd/iommufd_private.h       |  51 +-
 drivers/iommu/iommufd/iommufd_test.h          |   6 +
 drivers/iommu/iommufd/main.c                  |  17 +-
 drivers/iommu/iommufd/selftest.c              |  40 ++
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/iommufd.h                  |  26 +
 tools/testing/selftests/iommu/iommufd.c       |  64 ++-
 .../selftests/iommu/iommufd_fail_nth.c        |  52 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  61 +-
 14 files changed, 810 insertions(+), 205 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h


base-commit: fd8c1a4aee973e87d890a5861e106625a33b2c4e
-- 
2.40.0

