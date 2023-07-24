Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8C75FFF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGXTr3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 15:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGXTr2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 15:47:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028291712;
        Mon, 24 Jul 2023 12:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGCl7SKwAgJA97FEnSkWOF1J5Itjeg0bRnzs44uzwBio2b6pyknnBRsugpD4g1YG4m5AlfxVYO2bsd3U2g3t2cXFgLoBD/ob91UMbaRjoz77GQBQ0ZwJreqgP7i+s7RKvBwa53BfqHMtwn9GOsfOQSXUgqRMd+WkCEpHVB5hgIgWWWd/Il1A5HkCDr/KnaJJdUJEKrPIkA5KBwNCX3ZCqIWz5iny4uME+NEUXVnHkpvCkhVUWNottSuC0dOzSPze3zOMS4n+JpbezBX/uU5Hn2Tehcn9wBZ17ZdUsrK7axEYbYKli7QoGF2Rf4U3sQdHeJBXtumkIeM0se2S0e2lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E69jBX40xfsE3F9QodggaYDMwtFNYjmiaZdzWf/g268=;
 b=lifE7hbp7gyZwlOwNXqvvYcogHpyu4Rhlt1fSrC2wXV5BxP3mQzxhUzc5VngusyFQwxnql6iriqI9BEvR5VzDj7wF9HUeCoyVtYuQ0EcO/CAExN/UxS8rMXn3D5w6aif12meahO+Z9R9glYsdp3xyxgTgQO5BxwV5eRTFh0k/VdnPT0Ji8P6s/tHxf78QHoYblWf5z0iN3Uc//lgcdNvJimFMxETkx+NKldCtR18629Cx5n9JvR9hETF9Gx3sm/i9XSwIn/wo6LyeeJQ9SSshsRHx3F7eb1O/aqbJ3qumuD2YsrMY1xeGXm30Xeu4kjXGon/ryXB70Jgmhn1f9FheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E69jBX40xfsE3F9QodggaYDMwtFNYjmiaZdzWf/g268=;
 b=kDX9IskRZSBmWFoAGfi+AxcQjwP4IYjc47zY01wMBcumyzcrGNAepA3KGVUMiIp8pMszYG0eA0HUv1f8vIah0BdZ/XkE2AwgqqArl5U6Th1RLJe/QPIVE8Tx+btXfQAod1sxj5/TlPwuO0vXZiEmeJrvuiQmOkXDiRXa62KuRb7o6UNp5HssGUy+/JfWsQzFgirxo6xwlzRAiMtxCyO9GaYizzUY7XB3195T3F4O8BXcMsSJJRyc6mZkauQR3voIULZXtNVh3lKKpJjqlcHdLGm4ZOeFE1Nu2Gl6j6J+oFtYpkWSIpnwE7vXy48ZGtA89C7IUSAU5vBYUUQedlWFzw==
Received: from BYAPR07CA0088.namprd07.prod.outlook.com (2603:10b6:a03:12b::29)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 19:47:23 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:12b:cafe::4b) by BYAPR07CA0088.outlook.office365.com
 (2603:10b6:a03:12b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 19:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:47:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Jul 2023
 12:47:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 24 Jul 2023 12:47:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Jul 2023 12:47:11 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: [PATCH v8 0/4] cover-letter: Add IO page table replacement support
Date:   Mon, 24 Jul 2023 12:47:03 -0700
Message-ID: <cover.1690226015.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: bad9d17f-27b9-4bb6-78fd-08db8c7eccd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q29hlPNymq7Gi68P2vG7wfJGY2ZTklOgtLZPqQ8vIeGhR2mDWsKhkJw0/n5pDjn9dVZf7s0irjeSahMBthxdT2T1A3sATYRFUboqPBex8x+FM2uwq+jiLYHLyMctYoaknx6hrI6oVxDV8mXMWopbqC7ko7iN7ugfjeMzha+2UI32LQYtqHXQaEveX6bq7/LY9n6zh+0rUQle6Mi17WQV+72YqTDHjBQUl5lR/1VMRBTQZ9qoocQOJyzVbeqMGRol5uuZlWHAMxp6xJo/hr05aM1xuW3ASxQ/cacBUn2aVdjeK5at5eaGoDqj8cMBEp0C0RnxgrrYcS+e0v/xHaiGsz+Z5J73HfDt24VPMLYBKZZza0v5TO10eJYZNYqF5vMs+c9+xl+JFBIbx/UJ/71rTtcCT9hbtGMvLAfJjoWMzopY1pkJZTqGwMTyW+D7fvnnhQcrNgucKN8fySLdr8IlFUBDC9fGAs7aDqHC4zQ1L1Iq5stAWlo0ewrbRXXFuEscNA4sma6xEHlkLmQGN2Y13Q3dLMbgqrahcXela5z1vgg6MCryiM3H3APedzlhdCplU4P5hWytU0VbvAGv18epqsUhs9JRUVGM14oPiqY9h7ZgfNub2fFXHW68m/UeRXxCC1jDirma9b3x0PxZ42yjtJqWqICubAkgtMjkyA2R0D01K0QRw1cgstsfR6OoQSpMDTWDnLNcP4kqXIY8CyiFJw/ct1ywHK9u2S0731HpcUKZKygp8RF6pYmcg1aNu8DZx+5Ni6A+5MKV3E10B4DIZwR0FLMU9DJi2IPj1UVQ4xk5qQcBQvPz4K9Z4L87MC2A
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(2616005)(40480700001)(426003)(40460700003)(7696005)(6666004)(478600001)(356005)(7636003)(966005)(86362001)(82740400003)(36756003)(26005)(5660300002)(7416002)(41300700001)(8936002)(8676002)(4326008)(316002)(2906002)(54906003)(110136005)(70586007)(70206006)(336012)(186003)(83380400001)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:47:23.2223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad9d17f-27b9-4bb6-78fd-08db8c7eccd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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
v8:
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
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v8

Thank you
Nicolin Chen

Nicolin Chen (4):
  vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
  iommufd: Add iommufd_access_replace() API
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
  vfio: Support IO page table replacement

 drivers/iommu/iommufd/device.c                | 72 ++++++++++++++-----
 drivers/iommu/iommufd/iommufd_test.h          |  4 ++
 drivers/iommu/iommufd/selftest.c              | 19 +++++
 drivers/vfio/iommufd.c                        | 11 +--
 drivers/vfio/vfio_main.c                      |  4 ++
 include/linux/iommufd.h                       |  1 +
 include/uapi/linux/vfio.h                     |  6 ++
 tools/testing/selftests/iommu/iommufd.c       | 29 +++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 19 +++++
 9 files changed, 142 insertions(+), 23 deletions(-)

-- 
2.41.0

