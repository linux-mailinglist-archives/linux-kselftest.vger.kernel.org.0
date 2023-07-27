Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F139E7648AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjG0He2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjG0HeA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:34:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3F89EDF;
        Thu, 27 Jul 2023 00:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moZ3kQhZXTYk0eSH5gcJPILZn9yUA4r/+0b7pCDVLwPqLrZFPeCXWqGIceDmLLM90JxBorXjbFxjMLOy4LT26uH1upTmTc34LrTcX1rK13JJ/ayshULxXdc/wf/DDs0xmXLKGm1C9Owrzg0858vJjWK8dhMXvzeZkNT7tu9ll9BEwn3SnUcLPNezi2HSoHT8pUJvMvViapWKH68TImRw3V9DMZn67s5LSGFC9IG+xeOVZ67yxlWWuoUD7qM9IEE2b7QRCsp3leA+wTcFAkr0yZif1pnm7FKmunGHN+a59LiXI3gKY4zv3MrqcXxL5UuFZOyKAqjZ4XbumD+gKCTF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSYOtWb9BEixt+P418G2AtwNQTya+F0MEhsf6tNzeuw=;
 b=b0cYLGQIKlz5vQyKQjIvK08SnaZZ6ukphXdKHvWoKpggf7bbj66OHQe8euo/Q6oC1Yk7UsocwCC+m9pG4WhrVbz2f/wqI+NHASxRgChdCnpL/XxXn2nuTYgy7gpxrzcrdZUynkhecq90YpMVep4IMA9oT3vQXK6/16fOg6VIrtRbtOqBcWTDEZjN92Wr9XERIp6ynnejNKOgcxzUZYr8auZinnmmqStaw2BOvUABdf/37PW7qjW6Jsn34DKWZ5tWugvBxkEfGEY+afZON1HimsuALhuKJMJvX0hDTGfak0/JcPDOlcCMDcbC4JJqKWajW8yM1raZONLfpo90O9GiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSYOtWb9BEixt+P418G2AtwNQTya+F0MEhsf6tNzeuw=;
 b=D+XqZIJJqNJ2gj7l2eqr3nHirF3o6AhLqDdHFbYQm07w24HeWqbiIJa8FMDedVd/PmWLDIBgW44BDsYdHRIh17sZ7I777Jm1HOw73Oh/xSUJIarJYZpMRqrUL0EMBCVVNs5upMfpKMKAta8kCnG5NdVtJ7pKs/gL7BlQU5IS3kSNZ2RPMwkKWM1TtKnbmN2mRY3pfNgMsebkRQA6t2/r1/eT+pNml2tM/fFDdyjmMMb4kewqbS0HXOKW7kcfub5kHTUCOiC4MsakE9WJpesqIemAQC6KvTTCqWNrJNoZZcrujk2FnfzQXTTeMQIerA7T23zxeiohEFzMOP0rKT1HlQ==
Received: from MW4PR04CA0049.namprd04.prod.outlook.com (2603:10b6:303:6a::24)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:23:38 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::90) by MW4PR04CA0049.outlook.office365.com
 (2603:10b6:303:6a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:23:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 00:23:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 00:23:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 00:23:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v9 0/6] cover-letter: Add IO page table replacement support
Date:   Thu, 27 Jul 2023 00:23:05 -0700
Message-ID: <cover.1690440730.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2a3645-db49-450e-5bc4-08db8e726545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6ZHwTE6XrVYl5dYgZ0HnHigA5i8jVi5rVl5loMYK0HdNaQyoKJVpBFGteMH/A5C7GsZ4kcKr6R5NRgp/PXRo6O5IkSAJK6mKLxQv8uO6/tQ/SwFfv+M8/VNqvRFTg4scbJl2QMsBNvt86r57xI5/q2zoLAo35HuVPC1CRSgUejINYpLvP8HVhJBKlWr6wVeJZxeasP9cF1I0HrWAgGA3TYwJZuWD+ZG+OTwGr5n0k2YZtMk7OsQDshyAo/ATPBqtqrULJyvoTsinamiV0fc1DKG3BNKbWMFeYl/WeCCL0Tvg8vmW6VOT492Ly/7Fneopbc5EzIZnMFz2KTCR7dQRaOxbZc7c8xCofXS8ZZAfVLD132wMsvo83DhcNiQAbpG7ClU1XrRCvWi/m7FwiXAHX9fWw8W1kV6tbsiKyiPvobFohuQCRMLJfk8RwoVgVEyKA9vqCnHld+OdZUGXwTZrFPwldDa2oGWF1l3/L2zBUtIS0zd5MzdLH68dLCkJiz8uNx3kjYGsX4GkzcEDkZXr7gpZu0AlKK4D1wUueBjfDYz8dg0nMLe9Y/Rlc4eQ5gyHDz3uPRHg6BGiIdgNANzTPH+7rWjWU7ZJibpSAwEahAwSJ8pdomULl3Nd8AysQ7UZrZGa/QCwirkB7yAy+iiOhM6Yr6P5T6RCg7DAn10Bt/AYD2mt5SkhFOSm5LaiNLdAtyX0GATBtTTD+YGdq5fHqOJ7WhdCVJlWorN+8LsPDnZjmdS1oX5f6ENfD8oCfDbPKQt1FNmV3QBixecNPh9x+FrsSXeSq+VCuEDA+4XHVOBz8rIUwIEbtQGjN350F4c
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(26005)(336012)(186003)(2906002)(86362001)(4326008)(82740400003)(8676002)(36756003)(7416002)(8936002)(54906003)(7696005)(110136005)(966005)(6666004)(478600001)(36860700001)(356005)(316002)(7636003)(41300700001)(5660300002)(47076005)(70586007)(70206006)(40460700003)(83380400001)(2616005)(426003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:23:37.8423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2a3645-db49-450e-5bc4-08db8e726545
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ This series depends on the VFIO device cdev series ]

Changelog
v9:
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
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v9

Thank you
Nicolin Chen

Nicolin Chen (6):
  vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
  iommufd: Allow passing in iopt_access_list_id to iopt_remove_access()
  iommufd: Add iommufd_access_change_ioas helper
  iommufd: Add iommufd_access_replace() API
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
  vfio: Support IO page table replacement

 drivers/iommu/iommufd/device.c                | 123 ++++++++++++------
 drivers/iommu/iommufd/io_pagetable.c          |   6 +-
 drivers/iommu/iommufd/iommufd_private.h       |   3 +-
 drivers/iommu/iommufd/iommufd_test.h          |   4 +
 drivers/iommu/iommufd/selftest.c              |  19 +++
 drivers/vfio/iommufd.c                        |  11 +-
 drivers/vfio/vfio_main.c                      |   4 +
 include/linux/iommufd.h                       |   1 +
 include/uapi/linux/vfio.h                     |   6 +
 tools/testing/selftests/iommu/iommufd.c       |  29 ++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  19 +++
 11 files changed, 175 insertions(+), 50 deletions(-)

-- 
2.41.0

