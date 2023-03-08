Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92E26B0B09
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 15:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCHO0j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 09:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjCHO0i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 09:26:38 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EB5C3E2D;
        Wed,  8 Mar 2023 06:26:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mxqe1Xyy8+AVyZh7Brbvm0Is0oZ45sxDx4PCAaGoM5ejqpvTYjchop67T5dyILGuo1cNWA7/V9VGtQ3v+rX4JdgyW4UwBju81a5bJiOCrJp8YnAtIiNLnq7YhzKjLamdPCtOG470LkiaOGuVielO+shhq373Z1FizbATqMANIuWP2OFFgGCd1Ks7mGmql9ldtowsMQOc/a3X/6iNb6da7/M47klbpYlcpZcPe32d+Kwrb4mHvG5rn79ZTtwf6zz3tN+NZBfEDoeM8upzR/gnL0g5GfYEhgZcilrSlIrf8PKLgXT00Qz5DdmxQfDs8GtMkafjqrZ6zxh6KI8Vrg7Lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yq8Y6l1P6yD+HtvSBLOpCUGsVxb2mrpgxrw99FR8p8=;
 b=GnwbAJTb+N8RbwLmEnrPOudeior2YX2uxomCKRbR3x6l2ucAy35DPlRCZu3Nl8XvUdt0F1CzinRgNhTr6Jhhs51SXGGNh6HvEJytiEY1Q/xSGSYZtrvABLEXdUyaM1ZfI7AhjSdTETlNch6k3qalvf0n3eWS4lcQQVJcpAXE57AySsZHQu4PZaQGxgIerecZmzEel2Yki6fSv8ZgRWKAgSXnfepF9XQB4R4ZMaWyZFWFqURLwh9LOSaTIzdM758gt9w1MbXiyQp0wZq3SY53ecyrbs+IuNrV22hzfHSuXxVLLQrmOE6DcQE151RlIiOj+HW7WA52VJ1HoGKbpoQRdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yq8Y6l1P6yD+HtvSBLOpCUGsVxb2mrpgxrw99FR8p8=;
 b=Ziq4NlPPNwcL5Jn94yewHo+Cf3kv5PD6JhVeykbo93H8M/9H7AFL0Ms+1wz5Y8w3dDxYWbWcnmLLyfBWMk9x2TYx2OOW5ZiHmMC7T+UvDz7rjNWCP/ydk0bUB6sa1MyfiWZ9v0LtUBJOatA+Uw5dKbdOuCYD/5LmMoP67WRi0oRTxXz2udv9q53e5Htclum77LkpvSMSiKfMzjuKgk29sf5/hb5YQk1nf/Fo86XE7IDY3mYz5O82OyhI+NNcn9YM4tMb+SJVDbBXYg5XVc/pIsAXycTmdFusCCdiIMlTusNhiH/USVJebXGYFq3bgScQRGh9GIL1Vipsi5pvmgwCRw==
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 14:26:30 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::45) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 14:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Wed, 8 Mar 2023 14:26:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 8 Mar 2023
 06:26:19 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 8 Mar 2023 06:26:18 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 8 Mar 2023 06:26:18 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v4 0/5] Add IO page table replacement support
Date:   Wed, 8 Mar 2023 06:25:57 -0800
Message-ID: <cover.1678284812.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea3cfd4-c6a6-4815-c061-08db1fe11c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fn/BXMbTWp32HMj6ySk5JBULocCGpWmgCV2bRD7z+8KymDL3AF20tAp1os4KUut9r6EI3yJs8CmrlVcVXqY7ttG4vrYEFy3nYzSUmi/is68AbYzuto83HqIzf5MyyZ2p7H6gykxF2TWnoZkldcxNi+MRE2/f3+mFM9JF3We3Bt4nW7iKxPsuCiUOER6LBfkgXdHtZI3NdCr9f3V02O5Iu/NSXN/JhCSg+h224YZQ42FBu1Eca8PZBiPShGspDO/DLU+TTcQ0Gvk812GzeT+IFE6vedg/Fg0BIiYHFC8QnE9N3kIWXi1Edxe2LcDJrPycfkeUoq992v/wp0mHl2j1LaYqfIBTd67R2OqqS8nh6eYipcd9BigbIbooQVpYAeQgJCuu6saPDa3AmWyJyTDjL8SQmUfV88ELKXHs16wGDhnWjC12kFQzCHwE8/cAXTIOND8QHQYOIKm1rd98vBxTy0zdBROdu7OadY7KdyZU+bbgRl7sYRcwDxmlfFQW/jRxIu4MJFcuIXuSz5yOs3rSTuCn29bLB8pRcEY29RYlaHlQVQ2fyeIoDPvQ3BHRFLXzuMAFAs4NMJbu2wh4crpoomujO4RmVWFddlGX8Js5w8Cs3Zp2k5zLH7VGbsjHbCpB77krxzdxW2Sjfr1uQnWWpJhpo/lGlP7hrSZgOd+cPTkzobwSIOclRh08z1SGTlteUoC6rh/s9dWoUNchAzAAmWxcr1BsVwMTzN0AUvNRjFTt14u/HpULPWvAeQCmugn/skmHNsGh0mc9weMy1zN16ZVW8GhRoGq1lH3CPGhDe4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199018)(36840700001)(40470700004)(46966006)(426003)(336012)(47076005)(6666004)(54906003)(36756003)(40460700003)(110136005)(86362001)(40480700001)(7636003)(356005)(36860700001)(26005)(83380400001)(82310400005)(82740400003)(186003)(2616005)(7696005)(316002)(5660300002)(8936002)(7416002)(966005)(478600001)(4326008)(41300700001)(2906002)(70586007)(70206006)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:26:30.1495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea3cfd4-c6a6-4815-c061-08db1fe11c27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog
v4:
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
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v4

Thank you
Nicolin Chen

Nicolin Chen (5):
  vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
  iommufd: Add replace support in iommufd_access_set_ioas()
  iommufd/selftest: Add coverage for access->ioas replacement
  vfio: Support IO page table replacement

 drivers/iommu/iommufd/device.c                | 17 +++++++++--
 drivers/iommu/iommufd/iommufd_private.h       |  1 +
 drivers/iommu/iommufd/iommufd_test.h          |  4 +++
 drivers/iommu/iommufd/selftest.c              | 26 +++++++++++++----
 drivers/vfio/iommufd.c                        |  6 ++--
 drivers/vfio/vfio_main.c                      |  4 +++
 include/uapi/linux/vfio.h                     |  6 ++++
 tools/testing/selftests/iommu/iommufd.c       | 29 +++++++++++++++++--
 tools/testing/selftests/iommu/iommufd_utils.h | 22 ++++++++++++--
 9 files changed, 101 insertions(+), 14 deletions(-)

-- 
2.39.2

