Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0976FBE59
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 May 2023 06:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjEIEpA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 May 2023 00:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjEIEo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 May 2023 00:44:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2291B7688;
        Mon,  8 May 2023 21:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF48gTpisUPN00eTXQI0GmIWhytRY/BKGe1E9Gq8LVdiIkhZupyfbZhxDfhxJ3CNiy2QcYmfmkjHDTABhM6pmyrmJqNF7ux2B7Hlhfjyr94H7zj85OnonONUgsyxvFbQDSNY9WTtJGUbxhi8Yb1pt2ewW4AGXLv3Jwf3Trwz0EWxJJDu5xLJF0yP5VukZd2CxHT7qdW/gE99AhEjPGdwhG+kS9/P1Jh2/5D9g2H2l1s7B/tC9eGT/2ohuH4888+UzXZ/GFvDCPPs3hSzGnbdZo9k47Tk4BgQfrnmkx2FMKDEeDWG3TWyedw4UkfN39I1WWYGmjgTGMSxRlBTznRADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyBEzt5p5a88gQh4+2vdrTrR5zmupIJ35J72ns7Ulvg=;
 b=fy0nPIzBsx0377C1L3UE6W7Asqi/pHd63rQre3Ufr0F897d7WjitiCSY4mV4ZZdD6Y2djjMdE8LIOrjZ40oeySdjB4PtwJmTDzWTTx2dgKOsaFHd0vd6Eut1AOF6oreEXTGa/xTOpVKOKUC6HEJnnMwTNZK+xo9uEUJZfdHYosHbYXjUwQfYAEasvfkzH7phQBDD1SNRC8MXBmKc4ZzMcfTXfx6Vqyfj2XhVcuvnvbAWoI9tiyMIwz8ZduXhJOtkmOCLRwKJQSckRgJ/BcZ0bvYE8NNReEd9EGRMAUGcec3h5LQHMZuMS3JG3M0F9kpnaXk/BKEPFqrUs3S/FVr+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyBEzt5p5a88gQh4+2vdrTrR5zmupIJ35J72ns7Ulvg=;
 b=Ti11F2TFt0q8GLIc9v1Pb9BnAygtrQ+3+6hJkFZlhZjnZPtu9qXg4uYpUgAOTcF0BvOnz/vD5yuMgUwDL7vGlC4ulTNeeTzcs3SR5Bf0jNO7QH/jqGtQoeza7lx+8dTpGGIlvvR3gazl2osXc3ZbKzGPdDYvpSyC4pbY5nX7LuWMhp2d5IfRB+8zKd7Z0GSKVm92SNgaKD3Wb4r3gfPWG/b8C4cRo+7bxUR+encUHtXHjrCHUBT6r5LiAbAMDORgqt1d9NQ287+98eKOpgxDYNIiMIGu4DpOt2wA07ooE+/2zrAjuFdCv2A85ypIpvlLKrC4Lq50hMjy9WgYjaNhMg==
Received: from BN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:e6::13)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 04:44:53 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::65) by BN0PR03CA0008.outlook.office365.com
 (2603:10b6:408:e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 04:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 04:44:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 21:44:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 8 May 2023 21:44:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 21:44:40 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>,
        <alex.williamson@redhat.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: [PATCH v7 0/4] Add IO page table replacement support
Date:   Mon, 8 May 2023 21:44:10 -0700
Message-ID: <cover.1683593831.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e9213b-c474-4323-5bac-08db5048214b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEGcFeTwTOF4JV2cIaZccO0JuYBSIgCGF4bL3/fhMK1+5AVmgVK+mGEX2HiZbW4JfBf1ltgVqgk89r5iY8Z4aE8V6UxdXyhymSxt2KcF0PlTnj1pcVOwsyqZKSYhuB6EijBPIdR6gc++QLbtSx4z+K0CUoSe+RyYqBNDV6bOD/lvBDj9vjy4oO3kn0KaN2f9yZsZ0qP1qsdyD+4fj+YLMIBWFxi/J/23mKGQ2ovvQ5XSRb81wtyAeQtFOo8nRN+bgVbQ3YzGuOW+bJ7vcxJuF89uJJ6iu5PMkiPmIy9AwNdX2SUSuiQZmdJEd0mtzxGp+ZpuVSElxmSwXR0OzqyZ3sJIGh69BHbFsbu02SymoOmkokf0xM2T/MHSd4n7jJV/Kvj0R+m/sBrM8akixqqHsmhQT1P4A7lgxFWSgRFkeDu8Mi8mcaoAllgPnHabDYuS9dpZIucvK1Fl6cdxWLS0J0lL9yekEXMK/em8aoFzisWB5eZaY5oiklP64x2BXNnu4qD+1k/BjmemfUByobLeVbEbt/4wEE+o/jIEqp7So9YIcuFAc5332biW5re1MP4aVtCsrbzlr6iSWbp4/qHpilofwQwV9ZrC+2s6ei8OlV+Y+dRDR/jEtXfkTi2PcGFV59FY0ltcPfngBhfjo7u1LKNnM12uZ5Iq3XNgf13Bz7fpXAq0x9RD+TgwAUXXcseid8ODcXoDrRo+4IZk18GQuCtAqEeN31WBTaFfqULg28I5UyGjC/+1iDjpRo2yCiKR00KNnfroBWJox9fFAe6qK+PB0h8BzjqyKq3XCAB8Hj4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(356005)(26005)(7636003)(70206006)(40480700001)(70586007)(86362001)(40460700003)(2906002)(7416002)(4326008)(8676002)(316002)(82310400005)(54906003)(110136005)(41300700001)(8936002)(478600001)(5660300002)(336012)(426003)(36860700001)(83380400001)(2616005)(966005)(82740400003)(7696005)(6666004)(36756003)(47076005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:44:52.7480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e9213b-c474-4323-5bac-08db5048214b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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
v7:
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
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v7

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
 tools/testing/selftests/iommu/iommufd.c       | 29 +++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 19 +++++++
 9 files changed, 127 insertions(+), 19 deletions(-)

-- 
2.40.1

