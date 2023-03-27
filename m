Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B376CACA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjC0SFc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjC0SFa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:05:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACA530EF;
        Mon, 27 Mar 2023 11:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExcDJOYxyejWa7tfpwN3gUrhpvlHHTNK1T3tr3H694+XJH616zTMUo696kGPO7GM+m2WhSt2ZayF+QZpZ1MvgKsoOSxAGc8jl48kDbw6DnX20gHOw7mkbMI0De5fW1dzxoJyWgAGV8CIZnrhseX2qGEjx9UuNdZLs+gIpceTYoM5dcVXULkxl9yZpkT5qQzIVNPQy41w/BxJJuUtX3Q781hoKZra80pBXLEpHoUncbo2gdPeMhw7p0vEuiknPQYz64TQTzxFBqTUS/2z1glXXVlPbIy8gVLq6vczOLoglxS+rQfa9NLt21dPcJChPmLNXtqnpMazTRgxSqQBPG3gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLAhcl2rlZLJ3jmNhCLW6KNGwYtj3F9WHmEFQYJXLws=;
 b=XudwKw/i1FDfnspnqHi8Q7CQgNFy9ozgAj0Uei/OHeLWWcCBs4Wg8gPxL+W/RiSUvBBxzO8NPhDKg6xKoye+ogjjmJGsKhfsfSuzSPVt46tI+/ZOe8yrVI0IsZ3aK9UM8EcL9k7zKklEFZYN2zrFGWPXCa0csLZETbb5C/SbMUho3KvSX6iyUaJ5AeiDaJXwnU0/Szn5U6niN7mGi32lvORCjuOQepUr9esunFOIetrUra7zvmK9yaLrPYwlAfXBHwtCJghx/KrSBml7oFaDyVvTXgApbAuiL5gyAzQ7MMYlZJiC5ftWAf74ri1a48LuOIar9p+aV9X0KTFe3Lc04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLAhcl2rlZLJ3jmNhCLW6KNGwYtj3F9WHmEFQYJXLws=;
 b=MRn6vm1nLNRrIqDhoYWFdd5/QhDm1g8gIsvthnbckR/lIp0AGrLr1O1Osz0/K2rmyCnSm1DkqOi8eCC3T99W0voZdO3u7tIuP7rEBg8J8XMJVKwLSBkz6po5dunSwOZmdnrTrUqvVtyPGhSccs51maJAZAuM7Bb2AsW2V9qRFBz7FJ3shpdDrTUZSRG6+OadtQ1/HxaHhAc4ThT4HcnLNBaLw9p6mA6yFqjnRsKFCgEjnZH63F/fY2TeZ1U2TneJ05TPW20UEFauDNK0BeBeRWrlkhv8h/joLUO+uPJSa+KpspA2do1Kiz9ReOj9Z0BquY32EYsbrqCDjJpKBouXfw==
Received: from DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18)
 by SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 18:05:26 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::28) by DM6PR02CA0116.outlook.office365.com
 (2603:10b6:5:1b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 18:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.9 via Frontend Transport; Mon, 27 Mar 2023 18:05:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 11:05:13 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 11:05:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 27 Mar 2023 11:05:12 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v6 0/4] Add IO page table replacement support
Date:   Mon, 27 Mar 2023 11:05:01 -0700
Message-ID: <cover.1679939952.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|SJ0PR12MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd3a9e1-08c9-438e-2a9d-08db2eedd7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS53/PS+iCzKZzKXSceNKb91VBzethWtMo2hChfM7OsAnhYKRSgNV8puzpVUansmYcglO2oWpmhj91SjXnmhg9JBW+tO7oj1mFEFKw6GhWRPMd5dQ2xfN/h0YKWnLch35Zd69vgGugFmkYNTfrw1gMNznaVI0g0jhl9ZAvxQYFjgDpDL9t4ow+t4VVavasKpdLXRg0zcRyLkCvVjliHxX+dHXEO4/DGf8T+7G4O0f1KlM51jYVasVz3iHBJjlrVYmevWLgkDkf93AvVWGXcce6xB6Met0Zy3sdPFV7a8SuKqwBaTll3tpgnkvjp8GdFjMvpQV8ROVn94kwygtmklnfOIw4N/N8vFKQ2FdjStOfcBSCY7+acwBuBgfOkkgfCMPaGihwjThrzUP9FO6VJ97GTMGAw8uYCXF/fv7tz16YysGmZAyWec3+qo8COSQqXflDqa9Z1MhgcZ5oVyLmvlmsGLlU2iF3Ju17pDalH3wTu1yxRzdW77lkaQRCgnBAA4GSdC2GUs+6EMx4mJT9cmB/tZVHTrjhOwpLI8PRC5hfpiN9Ee/+HIQTTv6BfA+04XBoCcVlgK7zsMVPevl5vnGfgpBetpqDJ7h9CClS0Ih3v5NfkzgTe5ZF521jtuMInCKtR2UL4CesXJIY38K2/YO2TVf4IMzTUTixoa6AyX5AkZZ1Qjzj90oyi2jRl7xbVpvdfJq86jqZAgTORQTEjt6AOL23ZnG1FbZ64DnmwBr4CtgGD5oUwvsdexGTqz39MWIrZqC0nSukyZUSKkA/z7fBFqjETwLcO5wXclcRM0E0USBEqSEAaEEwq9h7l/wNRZt7J6nXCqFS/Sau9eHm50uJ7dU6hiivTQ80vJrqt9wJ4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(34020700004)(478600001)(316002)(54906003)(110136005)(7636003)(82310400005)(8936002)(5660300002)(86362001)(36756003)(2906002)(7416002)(356005)(70206006)(70586007)(8676002)(40480700001)(41300700001)(4326008)(336012)(186003)(2616005)(426003)(26005)(83380400001)(82740400003)(6666004)(7696005)(47076005)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:05:26.5151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd3a9e1-08c9-438e-2a9d-08db2eedd7dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ This series depends on the VFIO device cdev series ]

Changelog
v6:
 * Rebased on top of cdev v8 series
   https://lore.kernel.org/kvm/20230327094047.47215-1-yi.l.liu@intel.com/
 * Added "Reviewed-by" from Kevin to PATCH-4
 * Squashed access->ioas updating lines into iommufd_access_change_pt(),
   and changed function return type accordingly for simplification.
v5:
 https://lore.kernel.org/linux-iommu/cover.1679559476.git.nicolinc@nvidia.com/
 * Kept the cmd->id in the iommufd_test_create_access() so the access can
   be created with an ioas by default. Then, renamed the previous ioctl
   IOMMU_TEST_OP_ACCESS_SET_IOAS to IOMMU_TEST_OP_ACCESS_REPLACE_IOAS, so
   it would be used to replace an access->ioas pointer.
 * Added iommufd_access_replace() API after the introductions of the other
   two APIs iommufd_access_attach() and iommufd_access_detach().
 * Since vdev->iommufd_attached is also set in emulated pathway too, call
   iommufd_access_update(), similar to the physical pathway.
v4:
 https://lore.kernel.org/linux-iommu/cover.1678284812.git.nicolinc@nvidia.com/
 * Rebased on top of Jason's series adding replace() and hwpt_alloc()
 https://lore.kernel.org/linux-iommu/0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com/
 * Rebased on top of cdev series v6
 https://lore.kernel.org/kvm/20230308132903.465159-1-yi.l.liu@intel.com/
 * Dropped the patch that's moved to cdev series.
 * Added unmap function pointer sanity before calling it.
 * Added "Reviewed-by" from Kevin and Yi.
 * Added back the VFIO change updating the ATTACH uAPI.
v3:
 https://lore.kernel.org/linux-iommu/cover.1677288789.git.nicolinc@nvidia.com/
 * Rebased on top of Jason's iommufd_hwpt branch:
 https://lore.kernel.org/linux-iommu/0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com/
 * Dropped patches from this series accordingly. There were a couple of
   VFIO patches that will be submitted after the VFIO cdev series. Also,
   renamed the series to be "emulated".
 * Moved dma_unmap sanity patch to the first in the series.
 * Moved dma_unmap sanity to cover both VFIO and IOMMUFD pathways.
 * Added Kevin's "Reviewed-by" to two of the patches.
 * Fixed a NULL pointer bug in vfio_iommufd_emulated_bind().
 * Moved unmap() call to the common place in iommufd_access_set_ioas().
v2:
 https://lore.kernel.org/linux-iommu/cover.1675802050.git.nicolinc@nvidia.com/
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
 https://lore.kernel.org/linux-iommu/cover.1675320212.git.nicolinc@nvidia.com/

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
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v6

Thank you
Nicolin Chen

Nicolin Chen (4):
  vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
  iommufd: Add iommufd_access_replace() API
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
  vfio: Support IO page table replacement

 drivers/iommu/iommufd/device.c                | 53 ++++++++++++++-----
 drivers/iommu/iommufd/iommufd_test.h          |  4 ++
 drivers/iommu/iommufd/selftest.c              | 19 +++++++
 drivers/vfio/iommufd.c                        | 11 ++--
 drivers/vfio/vfio_main.c                      |  4 ++
 include/linux/iommufd.h                       |  1 +
 include/uapi/linux/vfio.h                     |  6 +++
 tools/testing/selftests/iommu/iommfd*.c       |  0
 tools/testing/selftests/iommu/iommufd.c       | 29 +++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 19 +++++++
 10 files changed, 127 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/iommu/iommfd*.c

-- 
2.40.0

