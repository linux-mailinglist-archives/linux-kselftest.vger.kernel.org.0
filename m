Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB95702F1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjEOOBK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbjEOOBD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:01:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAFB270D;
        Mon, 15 May 2023 07:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8ct8nEHaAn6Jgvk7JHVduovgFGePWm+jnFT5Fwv2LkRLkyXWWobzxuHtSnG2YR1Nz7wg7uEQeNaJD0x+DfY5orGt9xI5FXNWGmXLYg7wHsGlgYc0piGDZfk3KOhPx9qp7bGukGv5BkWNJ899dM4KqXLpr+BVPFRy0JjcETGIDElqIFjW6PBCsTb1wLCyC+1GDbt+ivP2EaXjRYTdUePEw0HwfVUISaV/FUPrA0FBV817enOPS2fpUNAhn+/42Vpr2WOJXUhGUNJP9Gpe1V+RchoNhijEF6RpB42jjPWUOD2ko6zLoWpjBGdPWGJo5/PgI3OvndQlQBpFjnk+pi59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mY119RisLy/kIv9XIZ5QHLObL8Sagpz3f5rzf2usLA=;
 b=m+ZrrOPuz3r5v/zdoSoq7ujJwtYO6ODUYp45TZtKE9WvOAg6DBAPIjDMmTBQz0gspJSg+wG7EyBdRRRbNdECPtpdQSJc5ytcO5Fz3k73My5QnZuy08W3cIgBmd3KjBxLjVTw13MRkRkljtrO3iaOpdz3DrGKEQCe0ccSaIKfs+nwTtzVBQVscLkKFG841Z9OrYoHtSut8L9GTsI+/lpnF0no57TJ7+WVL80oQWRhf2ycCElm0ByZcCdrKffCgegoJDqNxe6PKh2tNt7aVfXLas7oryR+4MGAnjdeAxgYPH1TwgRHOJA2l4xNMRaw2uqOPCSsEQAGUGqY9vA5VmR4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mY119RisLy/kIv9XIZ5QHLObL8Sagpz3f5rzf2usLA=;
 b=DfWK0xKxug2rxs3AzjcWDbwwB9iK8R2rjWbja9wyDlDf6rGaVA+H4qkU5Ik7luruqkLuQWXLPZNdx3e5LbDhYdkEEqxkXI1iuktdjWKm0fnc1fOd/HPPpOOUmqclYK2Kov1TB0ViozFaIkeevb55PPYdF3dmV9b5DDUuLx/50vrOnKQoHDVVdIUdVIQG4kiCzTi24yawMOCEfs3UEHavf2YteF6rnryFgHycEtEGzBps9G6QmCeizUit3hlIi3loQzcm1SE8dT7oty2X7eSpoMa/KLNyXb89uM980ddCmG/fudPmgGqQVCKMAeTJIFJMntsRjDHhXbKSuqUIRahgww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:47 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 00/19] Add iommufd physical device operations for replace and alloc hwpt
Date:   Mon, 15 May 2023 11:00:15 -0300
Message-Id: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E0E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:f) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e9ba18-60ac-4fce-c832-08db554cc32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ykZccoMBvGdcdrIxFXpFWN4rimBKvRf8M268Ht2d8RecjYcK06tNX5oU3FqrI/Lb+5gFjBWyYd8qsQ4g09YoIUPRYzMTfzvkhp5JtnvXLIoreXA1osHa8HC6YDf/DN2luOP+CgHXiUi44lcHvZy5LgdBjBEnAC+CGfE7G/L3Lnq4E7tBAkQVDqrQw5s//cS4SC88tZSc6ugF6czydSsMGoDbqKz0vZeoY05iIC+phQbDK/DiexRThUUVWS00+WkVw4qmKuzvPxhBwBocfEwyj3r3QJ5knrNDGDxYewCwvkrKCrtrq//mXgnS6qCr/lhRm6uhSvIjzicPWP0IRdTMGZvONCTJpYMIODGw8aFwmD0s2kdVO9/YvfdFZ4W6Pk8ifiRMdCdYQN3TnTr3EKBCCVfLMMnJpflvU16zY30KgSsjJrHZ9t2u2JDWLn/wPNFg7F0qsu97qFqstO8jf/rxf7TDxkMg3owFbLbN6/vjCvFpLuaLv3cru1h6knxN4OTOrdkGunpdf8ivquNLmkxt8MYmjlDAbKArVz33Ogipz/SFcfzuVvSQ+E4D3VbLM77QfkJlNpp6uoqr5rdDfwVlyA0iWTnJk5Aw92dUkHz65RlPmYJh/V7Sa0wHo4P5hRiIMw8KstP7ENNy1/td4CVRZgJLlhN/LZtBKhrLVIfgyPaqIZGZJi47rrXk3xgRian
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(966005)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I7AMJ3fe5ca17QSyhBxwkcXlZJ3Kd+LpwiLKJa+4w9MP9Hux9FcfnLug/hQ/?=
 =?us-ascii?Q?QJGn/js61+yaZFEacw3ybc9YJIGFzAJ0VCwBoTJil+GhXU74JWhzvu+p1WGc?=
 =?us-ascii?Q?+5G7sVO5zYCWh8XEIj6zx8DXLqembrGwe/F/xCcYSlPSUJp4vDazdE2TBUfk?=
 =?us-ascii?Q?tv64py2kGFHqolkPkFC04W27pHtzd4BVcLiHRAMHMibywad5tsDq1rAkV41Q?=
 =?us-ascii?Q?MbuC+XsprIKTRDdbIJymluswRzkkxT8i+CasKoJ3rA/oiOJlQuU1lsIIafjJ?=
 =?us-ascii?Q?dw6C5CRi1wNJU/IQ1frYOcMhQTzZMl9EhcXfxKCaE4cetml7oPXD3H32CvGa?=
 =?us-ascii?Q?P4j/Gmf/ebtNX8AeJtKfSE32kuUcFxs4EAgP3lwoBSAuJ086zXwNFVCc3Ub4?=
 =?us-ascii?Q?4tlX6iPevheklbDSCC3iiMs+F9HieAWPVh24WOQaeXt7TJrh5dL6WjL5cZqV?=
 =?us-ascii?Q?wbSKAkHfaeAh5HtEkpIGepielYFLeWQe3LigsC5wjZ0Vn0+vSSUg2w2287qp?=
 =?us-ascii?Q?W9XQ/UWy2iO9VxH9JzV++OPWd5njOyts0TXpeiVfJuLuDgPF0ksNItWnToWZ?=
 =?us-ascii?Q?rBG2dDMSY43J/24w92W6GLMePygpIfeSWOTW9Rgrn1P0Tw0OvjRDE9fR92Q7?=
 =?us-ascii?Q?GOyamweOtqml1bKksZDYobaUYtLkWY7izYLcJu647agHx9uf/fD9zjyYzuof?=
 =?us-ascii?Q?cAIiaNnlrWDNrQHg+x6yB24EFr/K1rkyRHPwTiDtoKoHwGQpgcPSls0cpGjp?=
 =?us-ascii?Q?Zz54dsN9svt3kXoYS+VtBrw2gLyXYbbKjYD5l5cV2FHRcVrC+hfnssoY5EAv?=
 =?us-ascii?Q?fmrO/0Zk01hv2mMtCLjJOGc51FXdbrslkKnOMON7pp4wphF6EcU2iR/60bIv?=
 =?us-ascii?Q?FklJDkyl99wm+lijadPjb00I4mL7rpo29fy5FG0scIoyaOGx6yD9AUrHRGJz?=
 =?us-ascii?Q?m0ZehnEAfHmKC8XNZvctHAnTCy3Nz3H8iQvtqpxRZAa8JrqgmnWgscQFdPOH?=
 =?us-ascii?Q?5qKmme2FKLmlPBjeUQc1ftPKuWMMeILrbYZ5I7uQZDlFmvLinqM9kF31adE6?=
 =?us-ascii?Q?k3+AD+paI6dkXLUjefnkcck2w9Z2w0KD4wbZ2VGAR0ASCTo7bpEsYf9hWm3m?=
 =?us-ascii?Q?/iuAuNHZ/qs6CuGOaNaTEtX1VEleCQq6VTqPX1VKKcBahUNLwArif5nnFqut?=
 =?us-ascii?Q?2epvSaZOgBKcXuH2nzaZI6Du/NDYwF6XMX8vkcbIsqSE4TIegSeFbZ7Ox8Uj?=
 =?us-ascii?Q?JcNcnacO/8iz3WEQi/2YdvWugaDMf0zteShXx49n7JjerNCs55HR7gpHAZUa?=
 =?us-ascii?Q?17EU8PQc/zSerP2xcLRmDerGsI/yGOCaNY1kioMH5HfNAiP5Dy/ljnn0eOf6?=
 =?us-ascii?Q?xTFvhmpMRvg3OFC3GhXldFNr0QpUrqIIRlH7syicPSXprkX8qe/uu2WMVZ+U?=
 =?us-ascii?Q?OXlCaRJqzMG556vGy7JV5EytpM1nFXok0coy6IkqG2/1wCEMb5TKuDmovxbw?=
 =?us-ascii?Q?YYMuyNL86vVAIcxBaHoMm3pIBMNulpMzBJOswChLbD0U73zwReBQ7hQFz3Vg?=
 =?us-ascii?Q?32ho+j335CNjFPoL9a4yHOH0CmbyJJQmOv1H/G8m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e9ba18-60ac-4fce-c832-08db554cc32e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:38.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPg/zLjoHTH8BFZZorsJ1e0nOK/Ap6b7VRYS1KVpx0sL2tTDbURufhPzX4IKz6bp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

v7:
 - Rebase to v6.4-rc2, update to new signature of iommufd_get_ioas()
v6: https://lore.kernel.org/r/0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com
 - Go back to the v4 locking arragnment with now both the attach/detach
   igroup->locks inside the functions, Kevin says he needs this for a
   followup series. This still fixes the syzkaller bug
 - Fix two more error unwind locking bugs where
   iommufd_object_abort_and_destroy(hwpt) would deadlock or be mislocked.
   Make sure fail_nth will catch these mistakes
 - Add a patch allowing objects to have different abort than destroy
   function, it allows hwpt abort to require the caller to continue
   to hold the lock and enforces this with lockdep.
v5: https://lore.kernel.org/r/0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com
 - Go back to the v3 version of the code, keep the comment changes from
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

Jason Gunthorpe (17):
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
  iommufd: Allow a hwpt to be aborted after allocation
  iommufd: Fix locking around hwpt allocation
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
 drivers/iommu/iommufd/device.c                | 553 +++++++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c          | 112 +++-
 drivers/iommu/iommufd/io_pagetable.c          |  32 +-
 drivers/iommu/iommufd/iommufd_private.h       |  52 +-
 drivers/iommu/iommufd/iommufd_test.h          |   6 +
 drivers/iommu/iommufd/main.c                  |  24 +-
 drivers/iommu/iommufd/selftest.c              |  40 ++
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/iommufd.h                  |  26 +
 tools/testing/selftests/iommu/iommufd.c       |  67 ++-
 .../selftests/iommu/iommufd_fail_nth.c        |  67 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  63 +-
 14 files changed, 868 insertions(+), 226 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h


base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
-- 
2.40.1

