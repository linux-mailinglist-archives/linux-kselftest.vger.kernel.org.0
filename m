Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1254A766421
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 08:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjG1GeJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjG1GeI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 02:34:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF4430E3;
        Thu, 27 Jul 2023 23:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS+/HCGYcIOL75M7nml1nXxWMk8g+M3ek6PietDsRg1fLxV2TmT7f0b2bkSqVF+VBNC20LLbybihYajYDt0OT8c3mNXRdqwax+su1W2RC1x9voTvukGImpz+wLbyCaaQUJ6osXZkmYwP7gwG/7eQ8vor5ikIO/DUKDBrwjDBmLif55jKrEizvgWB+YzwrkXGhab9GI5eRs3jQvvXuGShiYaRaO0ygBoTxmjxcAO1trHV6kalaJdaf2vsX1bGOBDelXDlgGZqBGWM8dKjSD4JHyEU1A7hX0PKdshJk8QYCF+BIGg+3ZWSO/9qTz/cbLUPWXuBx0yrjKhFmh61ICGYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRAiGenlzN3yaQ4q87exgK3Q5pj/2XN7NMciFTN26iE=;
 b=CZwL4V/Mz3uT2m/dL/iIm0qJqhkBMQZR2ulItYRCSZSgi7pZoL/TSk3wBf+U+z+sMsK3Ttt6vAFG+fo6wzqebvPkxhHLbuW2/jg6zQeTq6iak5VbvMzGkndrIAfwL6sofgKaSi3w3HwbUuBYOjO5RBktjOkPrzMB6gZiwRLCBAcO5D+xCsJ9qVldopR7j+pb8wHhQ+T6cw/RKdmapw8omaJE9cSA1ebrd7GzhF7oepmLYiUpmgiVLMC71F+8JAhbrZdV9YE/qp+swLvuAuX/bPY2+CcXVLGEp3EGCkASimK7Dnl3Wi6eIXZCssLdI0gi1yaOzBAziJo3BbqT2ecuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRAiGenlzN3yaQ4q87exgK3Q5pj/2XN7NMciFTN26iE=;
 b=cKbZDTye+1tp4KJK/SURHprC//0C2a/ZNvEeH+FlNSUR0KU4FhxtP4Ajy9UzOZ3ykUL8bHkJLLrPQ29z21JfPL2BOHsZczLSYJXHMB3JIG8CAogekOqmxLd6XDVwfDqVmr4kPXV3T2KXaWxDwZSmPGje73gv4n+vkxY4jDofrktfwv4gqoFy6LFV03SJTtliTX8VIUFI1bWGyIQhovKlz64ymblW/IYnOLWufx5YHScT67DVhJDvAB+akHPnMVFdUfB9Fh05CBvaHmIVCtycvwb+za1ZbtMiTiDbXCsPbf+UISGOulAbQsh3hgmfs4x9Ig/EdBucVumrsBt6vFJsrQ==
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:34:03 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::2) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 06:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 06:34:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 23:33:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 23:33:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 23:33:51 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v11 0/7] Add IO page table replacement support
Date:   Thu, 27 Jul 2023 23:33:22 -0700
Message-ID: <cover.1690523699.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 61517ab4-980c-4ee3-14ce-08db8f34a25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP7R1Uig+eOcX+8Er+l3NhnACVy4paA6m4eZNFmvD2eSjT/E5aYrb5AQmmlzpUgysrqnBrkj4eOuh9rHSy5fK68zGoS5REnJGLrQAh9HbLwCV7c8J9CSjVcq31w4KeWlzrD5D1i5Ca6BNBrxqgl9DbWywqNTONQ4cT5qpGA2KS/J/10dfqvCq6jqz1NSSnl3GoogJGGZA6qZ8/hDra9nj+oHI23E4mb/SQrKLV6tA2+1Z7HejCmuoD5km4q2U+IlQ04nfMOjS54KMlX4m5jZIvjBrx8v5vCPzP35yLZpOWJeLfFrcdLfG9gIcXKp7ND64fGxXsLhiQsr39QfJ4x/sZKcABt4hI8Yu0rT9KC3CsxYIYY/yWWn8lezRPZOhMBMtukIIppmOEdzflt5kp1zZSdn/0rY6CiJlO92T8pzjU8FEF0+tUoen0c9N5JI1MI49SBXyQH3n6DRYwhKzNtkDUDr+wYNHJcWIjv8V9tS7UJ4ngPuxo22Ztc5HNXWkSH3r/uFDTHUuBH/46VkFLPM4iuC9mFIeiqdiH3141LtkdWElCEXGiOpwIWWnaP6/c+s42I8rKeczTHej8qkQ8tAk+aqbTzyvjaQHS8TBQl/LkpltpCtpB42T6mzpCT4kI8nCcNyy1X56VfZRIungzoQneHNHt9cqhHwXa/qXGnG5tMnC/tdNIMMGowSb0Qg5a1zC2z+TVAvwhkX8XhTH6cMAaEy+JQSV2iYFlWRHaY8he1toqNoIa1Itj2qCOVVuC9foyb64SZ8GS398lnN9kFosRxl3lfpkW8gEfhvMXPZvJYIHvC8JhmvdnDML4k3q47o
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(110136005)(6666004)(7696005)(966005)(54906003)(26005)(478600001)(83380400001)(40460700003)(36756003)(86362001)(40480700001)(2906002)(356005)(2616005)(426003)(336012)(47076005)(186003)(8936002)(82740400003)(7636003)(4326008)(8676002)(70206006)(70586007)(41300700001)(316002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:34:02.7200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61517ab4-980c-4ee3-14ce-08db8f34a25d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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

[ This series depends on the VFIO device cdev series ]

Changelog
v11:
 * Added Reviewed-by from Kevin
 * Dropped 'rc' in iommufd_access_detach()
 * Dropped a duplicated IS_ERR check at new_ioas
 * Separate into a new patch the change in iommufd_access_destroy_object
v10:
 https://lore.kernel.org/all/cover.1690488745.git.nicolinc@nvidia.com/
 * Added Reviewed-by from Jason
 * Replaced the iommufd_ref_to_user call with refcount_inc
 * Added a wrapper iommufd_access_change_ioas_id and used it in the
   iommufd_access_attach() and iommufd_access_replace() APIs
v9:
 https://lore.kernel.org/all/cover.1690440730.git.nicolinc@nvidia.com/
 * Rebased on top of Jason's iommufd for-next tree
 * Added Reviewed-by from Jason and Alex
 * Reworked the replace API patches
   * Added a new patch allowing passing in to iopt_remove_access
   * Added a new patch of a helper function following Jason's design,
     mainly by blocking any concurrent detach/replace and keeping the
     refcount_dec at the end of the function
   * Added a call of the new helper in iommufd_access_destroy_object()
     to reduce race condition
   * Simplified the replace API patch
v8:
 https://lore.kernel.org/all/cover.1690226015.git.nicolinc@nvidia.com/
 * Rebased on top of Jason's iommufd_hwpt series and then cdev v15 series:
   https://lore.kernel.org/all/0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com/
   https://lore.kernel.org/kvm/20230718135551.6592-1-yi.l.liu@intel.com/
 * Changed the order of detach() and attach() in replace(), to fix a bug
v7:
 https://lore.kernel.org/all/cover.1683593831.git.nicolinc@nvidia.com/
 * Rebased on top of v6.4-rc1 and cdev v11 candidate
 * Fixed a wrong file in replace() API patch
 * Added Kevin's "Reviewed-by" to replace() API patch
v6:
 https://lore.kernel.org/all/cover.1679939952.git.nicolinc@nvidia.com/
 * Rebased on top of cdev v8 series
   https://lore.kernel.org/kvm/20230327094047.47215-1-yi.l.liu@intel.com/
 * Added "Reviewed-by" from Kevin to PATCH-4
 * Squashed access->ioas updating lines into iommufd_access_change_pt(),
   and changed function return type accordingly for simplification.
v5:
 https://lore.kernel.org/all/cover.1679559476.git.nicolinc@nvidia.com/
 * Kept the cmd->id in the iommufd_test_create_access() so the access can
   be created with an ioas by default. Then, renamed the previous ioctl
   IOMMU_TEST_OP_ACCESS_SET_IOAS to IOMMU_TEST_OP_ACCESS_REPLACE_IOAS, so
   it would be used to replace an access->ioas pointer.
 * Added iommufd_access_replace() API after the introductions of the other
   two APIs iommufd_access_attach() and iommufd_access_detach().
 * Since vdev->iommufd_attached is also set in emulated pathway too, call
   iommufd_access_update(), similar to the physical pathway.
v4:
 https://lore.kernel.org/all/cover.1678284812.git.nicolinc@nvidia.com/
 * Rebased on top of Jason's series adding replace() and hwpt_alloc()
 https://lore.kernel.org/all/0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com/
 * Rebased on top of cdev series v6
 https://lore.kernel.org/kvm/20230308132903.465159-1-yi.l.liu@intel.com/
 * Dropped the patch that's moved to cdev series.
 * Added unmap function pointer sanity before calling it.
 * Added "Reviewed-by" from Kevin and Yi.
 * Added back the VFIO change updating the ATTACH uAPI.
v3:
 https://lore.kernel.org/all/cover.1677288789.git.nicolinc@nvidia.com/
 * Rebased on top of Jason's iommufd_hwpt branch:
 https://lore.kernel.org/all/0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com/
 * Dropped patches from this series accordingly. There were a couple of
   VFIO patches that will be submitted after the VFIO cdev series. Also,
   renamed the series to be "emulated".
 * Moved dma_unmap sanity patch to the first in the series.
 * Moved dma_unmap sanity to cover both VFIO and IOMMUFD pathways.
 * Added Kevin's "Reviewed-by" to two of the patches.
 * Fixed a NULL pointer bug in vfio_iommufd_emulated_bind().
 * Moved unmap() call to the common place in iommufd_access_set_ioas().
v2:
 https://lore.kernel.org/all/cover.1675802050.git.nicolinc@nvidia.com/
 * Rebased on top of vfio_device cdev v2 series.
 * Update the kdoc and commit message of iommu_group_replace_domain().
 * Dropped revert-to-core-domain part in iommu_group_replace_domain().
 * Dropped !ops->dma_unmap check in vfio_iommufd_emulated_attach_ioas().
 * Added missing rc value in vfio_iommufd_emulated_attach_ioas() from the
   iommufd_access_set_ioas() call.
 * Added a new patch in vfio_main to deny vfio_pin/unpin_pages() calls if
   vdev->ops->dma_unmap is not implemented.
 * Added a __iommmufd_device_detach helper and let the replace routine do
   a partial detach().
 * Added restriction on auto_domains to use the replace feature.
 * Added the patch "iommufd/device: Make hwpt_list list_add/del symmetric"
   from the has_group removal series.
v1:
 https://lore.kernel.org/all/cover.1675320212.git.nicolinc@nvidia.com/

Hi all,

The existing IOMMU APIs provide a pair of functions: iommu_attach_group()
for callers to attach a device from the default_domain (NULL if not being
supported) to a given iommu domain, and iommu_detach_group() for callers
to detach a device from a given domain to the default_domain. Internally,
the detach_dev op is deprecated for the newer drivers with default_domain.
This means that those drivers likely can switch an attaching domain to
another one, without stagging the device at a blocking or default domain,
for use cases such as:
1) vPASID mode, when a guest wants to replace a single pasid (PASID=0)
   table with a larger table (PASID=N)
2) Nesting mode, when switching the attaching device from an S2 domain
   to an S1 domain, or when switching between relevant S1 domains.

This series is rebased on top of Jason Gunthorpe's series that introduces
iommu_group_replace_domain API and IOMMUFD infrastructure for the IOMMUFD
"physical" devices. The IOMMUFD "emulated" deivces will need some extra
steps to replace the access->ioas object and its iopt pointer.

You can also find this series on Github:
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v11

Thank you
Nicolin Chen

Nicolin Chen (7):
  vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
  iommufd: Allow passing in iopt_access_list_id to iopt_remove_access()
  iommufd: Add iommufd_access_change_ioas(_id) helpers
  iommufd: Use iommufd_access_change_ioas in
    iommufd_access_destroy_object
  iommufd: Add iommufd_access_replace() API
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
  vfio: Support IO page table replacement

 drivers/iommu/iommufd/device.c                | 128 ++++++++++++------
 drivers/iommu/iommufd/io_pagetable.c          |   6 +-
 drivers/iommu/iommufd/iommufd_private.h       |   3 +-
 drivers/iommu/iommufd/iommufd_test.h          |   4 +
 drivers/iommu/iommufd/selftest.c              |  19 +++
 drivers/vfio/iommufd.c                        |  11 +-
 drivers/vfio/vfio_main.c                      |   4 +
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/vfio.h                     |   6 +
 tools/testing/selftests/iommu/iommufd.c       |  29 +++-
 tools/testing/selftests/iommu/iommufd_utils.h |  19 +++
 11 files changed, 179 insertions(+), 51 deletions(-)

-- 
2.41.0

