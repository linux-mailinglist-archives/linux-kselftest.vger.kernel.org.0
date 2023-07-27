Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA97765D3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjG0UZO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjG0UZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:25:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E2E2733;
        Thu, 27 Jul 2023 13:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs2QpM0BLf8mqHORXboaQrKky7jyoWS5+1L5NrEa/2/3Fp0LYWPRhsU72BSdiP4hPR9vTuU9kzGAZYekCExALB/n/r/PFD344NyM4Ie9cPmyAEIjbpOh/amoAduWdbA7CTrzaIif5cKkPA1AQ6U0ZzOB5AuVxR/LHMOdA86lFViZeCxWR+rYH7mNTItJpsgA4Le7Uqg0GAgrIxhbF55SUi58HiUbf6mWhtT0X33uHk9yfUTbvVAuD9CDmbG3NYWj5kv2AgrqsgVk7k18ePXscOSNAvrII6HtYaUohMcVuXXK760gbne7kFocc/bRbdt3zSESsBjU+IWjNB32GklPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PelSJEPcz/ab3zi5ED1L5xHVrYdl/NISEdrjsGkyVgc=;
 b=TEw9nylCMjZF4IxAh0PLbSuuw/avNHTKbWGoXrrwuGr/D34UzA0iVPP6IZ7YndBZ/Bv12Pfgx7616AGVuNZhHb6mViqaVLc4qjniaSVhOsFhm7JThuFmUHzQFsdetiVHAPcFzWZjUJYn9N7QzxGMI9n9joggJLROZzcejC32CV+DznglJm7PC0r8VpWpZ4YU/YN13Bi3zIbprtjxoqwfnQ1nskLqGpUv/ub4JPhMOHLcBhJs8O2WQ0+lIHvTfsOiTka8d+jwWJ6l/NTXvJliGur+ZYhGYLsxYRRLWEh8kWYhUw4DOiPPSvXYM1THz8GmOAeXt9eQS3UnnCdIgg2B3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PelSJEPcz/ab3zi5ED1L5xHVrYdl/NISEdrjsGkyVgc=;
 b=ntBkgiwKfwKlc3jTAckBBB/4vyIBpvuQSjxm9/6iQCY3W+rdbwigdWUW2qBReb/oN0m1jp9cAB5Nu6RnNsL1O1cuJ51JxBvL309ilWDjQtG/GBOfdFr2ZlfdXpH7sgfFFGA5U9q/ivYbYQqYQ3HR9hOfgzW9/PWwOt/GnFo63YC7lxIp9r1Oo4iMbf+77lMLrwIupnrcNY1YZYmSSshdN+CI6fhVdS+kgtLo+2RVUgWoqX++MSVjKxd5rdDKdey/q2fIE7P0qgw/Ge0PeYptHSypa8agy4o6J506snAftgaYRVYzGYEDwTCD2mXzIpbdq5rKouwmdU1Oz/Cv90GkbA==
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:25:06 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c3:cafe::c1) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5 via Frontend
 Transport; Thu, 27 Jul 2023 20:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 20:25:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 13:24:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 13:24:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 13:24:46 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v10 0/6] Add IO page table replacement support
Date:   Thu, 27 Jul 2023 13:24:31 -0700
Message-ID: <cover.1690488745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 333059fd-a1c2-4477-9e16-08db8edf9006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEtDv7dXwtKn43Fd/Rxu1rn4XhX4/jvnpyd2zK2SjnU2VRibZgh+2Z1YIr/PuTEFZA2P//tefadM00l+D8+i6gpSLHf2z8hVzuSbdLtAH/3RnMAM52xjveMKuTFsXh+KnaQyG5UpAjpK8vZ21ZldRbbLaRdn3z+qKUIkHkmujyO34Ji2ckZ0TseZ05LGXAlKG8+0gEjnvrglzIGhGnnHoUU6JXOOZUnz8nyFLOkr76ZsKECKbmxYvNo3ywsxvk9QxT/BlGOFBlehY5jePQQbcA7JGsRpa2vNNCbtUPEquK3CPx0wAJX337H29OUITHUtnOROlrUCht80qYtQdy/TuYmoeuZu98aDb8kErB4l8s4bqg4HgRXn397OHn1LvSk2U+eDvSbCncUQL+tkn1d16SlPG5EXs9tMkI/tPudcn/Dc0XwlqtaPIH52p+n3suaBfPAb5LrNvicT6XbSUegEKXznEM663NC9e085O3uYVLrYxmV7dx93jbzi00YNZUFbVDzs7ATDXzDSOo+mRTwbKq2zs0mwTxUfskFdVxieI9iWDtBFp74e5wYGD4VHShwriLNPMQMhAh5ZXy8MECGcNA+jnOKmIbmwFGB57cfHKu/Z83jkHRQWAo5UCG8/iObRJvpCtICWh+9mQ0b3r8CLYxYJaoYtUQqDKiYq4DpgbWy7+BjnWtT8Ac0sJzRsDpQ5BsknLERpfsd58UXykLtVyt56CVe4+g4vU281bm1HZobiBJg1o1Z9vBK4k47kchYqeEKZfkUiin9ETi7y91W4yA3bMwbd5oVSd5kWbBsqXBdgS8dZQ2XXr2SKDeYReAzL
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(316002)(8936002)(8676002)(7416002)(40460700003)(5660300002)(41300700001)(36756003)(86362001)(40480700001)(426003)(7696005)(6666004)(54906003)(478600001)(82740400003)(7636003)(356005)(26005)(186003)(336012)(110136005)(966005)(2616005)(83380400001)(70586007)(70206006)(36860700001)(47076005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 20:25:04.6854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333059fd-a1c2-4477-9e16-08db8edf9006
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ This series depends on the VFIO device cdev series ]

Changelog
v10:
 * Added Reviewed-by from Jason
 * Replaced the iommufd_ref_to_user call with refcount_inc
 * Added a wrapper iommufd_access_change_ioas_id and used it in the
   iommufd_access_attach() and iommufd_access_replace() APIs
v9:
 https://lore.kernel.org/linux-iommu/cover.1690440730.git.nicolinc@nvidia.com/
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
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v10

Thank you
Nicolin Chen

Nicolin Chen (6):
  vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
  iommufd: Allow passing in iopt_access_list_id to iopt_remove_access()
  iommufd: Add iommufd_access_change_ioas(_id) helpers
  iommufd: Add iommufd_access_replace() API
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
  vfio: Support IO page table replacement

 drivers/iommu/iommufd/device.c                | 132 ++++++++++++------
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
 11 files changed, 184 insertions(+), 50 deletions(-)

-- 
2.41.0

