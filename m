Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FB36A26AC
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBYBwt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBYBwq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:52:46 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B5688DE;
        Fri, 24 Feb 2023 17:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU+0NSPHKXf4fmBMo+swmu9AbpqLazCu2ixueEULch8BKm5MzOQfkzfjyHF8+Y2vQ9p5r6QGKoAcQ+SOXrmEwRfaXSYtAycqGiZA/s5fvN4v9la6rzpTE0ySeS+l3h7LwQ8uMq6vcl51S+5qZKB9OMyofzdPPF/2ZdTIIMbIftQ+tcj7QFZYn/k3OmZxrpEoWtmjSz5qBtMedloiSkdQFnyHqwpyHDBgMYq6vYhypf5YxTstJwmKb7ivim+jt6w/vOlMcv7mn5UfcipnELlbQnP9cgqA9RUqOtvdSHDQ4SM5CiYb6oFleXTMplYOco812Vc/J0CmMcLX1541/WMW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMyfCYV8w1BjAaegotXoxrwWvuxx3sJOTVy2wzAm6VI=;
 b=F3DmAZOPS52VWsdLE8o2Vt4PLhWGxbckq1uSVsXYknS4f5LDGbj/CzKVG3CE8bVlGyRQ0PBzU6uaKTmnTPEbDeQ1j7QksSTdUY+pvYXZiSmGpbxVtMVesD2aYMJGEbiEPxR/jAfbms2ddjJbfp9mGu+oMt5rJpDOaeBpffDY/ZRO4qjrxEIz3pa1sHTmaKxckA/Cz03bNF0SY5185ePxHuZswC5eNE5ktiwRa8ZpzYnME3Rp8qNDEOghNB1xuWSAJb4eGf0U7pZv+lzO2I7sYcbNuvbFKcdKyFy3LEEsa72JjZXXrnk/3j/4XQlcDWj58TxWldUJqsbIsGmaBZBB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMyfCYV8w1BjAaegotXoxrwWvuxx3sJOTVy2wzAm6VI=;
 b=JVjD+iF2MOKq/AgmTRBG1cxdpOsazvh8JpbiltjK3X7dXKAbAYt+6e5fdtU3xTmq1VecqGWZvf+u+bqFoR0G7Uw2UzB2q+HPqSMUS3YkkrQclFN/bt9Du4oa/fM+rn1ZuNxKLRcj26Db/B56kupm5TL173eLmYqE3NPPtlZqzM8ILs4wMLBiMMiCTXr2L8Bn1ZYODgbsiThdajqLyrzhQxDEDlMFmF4x0282lCbOf637xpjJnymHuy/nWXhj8u6MJXYhxPNBDhMzRU61icuzgZGVQPWkYpl9IJKC1R5w9dntpLoCqFIOw6pobSZVBLj5ZGG+oAp6gGOGi1e7U9Euqw==
Received: from MW4PR04CA0335.namprd04.prod.outlook.com (2603:10b6:303:8a::10)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 01:52:40 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::39) by MW4PR04CA0335.outlook.office365.com
 (2603:10b6:303:8a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25 via Frontend
 Transport; Sat, 25 Feb 2023 01:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Sat, 25 Feb 2023 01:52:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:26 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:26 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 17:52:25 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v3 0/5] Add IO page table replacement support for emulated pathway
Date:   Fri, 24 Feb 2023 17:51:37 -0800
Message-ID: <cover.1677288789.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|DM6PR12MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b51d1e-bef6-499c-e1a5-08db16d2fa43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHKVs3b0gmj5HEGVR7cmbfyBipvZfSrdRLRYxMm97y4nl+xa72pLh/50FetCFWN1zgxE+Y3PejDkIXGqb8rVOUEoReNwrFJ4uk/Q/Y1au68nQanUxN7egH2S5zVdora8HaGQfPRsnrLLPH3ih8/K0CwC7pNlDwrnXLQsJwide3zM89NoPTH+lTc05DNlaH5uramS+zLv2iUFFFe9RaM9FaPB7kvxlgGIGKG0oqRnGcKYkWKiVM5FDw1jMFoCgzueoLubiTuxGV8LB588DFHKau/Ds4grQJCDGasBWvXvFUSXP/TK0uQt1HZNYSJ74OdmADWtb7uOIYIKyCGpurv9gtQDcy+euTSZtJaUR2qh9cXN/UVzbltloRvmyF+P+AbZlmEB5EnR4wZg6GXIiyjt+hbpRcZLrG0v0f7gpsVnevW0SO0DMWpLB5T/cA3lu/a7TOLUW6HEsNi5AOkpl8KR8bbICmlSbnDpTa/pfA0TmR72yWILy9f11kFkSSpr0itbuyXhXWBeQARTHTx5Vw0Tn3VLvfzedm1iouZRIzXPmyRThuDCzwQ6h+WBe8620KF5WEzHKBqasLihJp5d5zvl7ND5PWOn5/ioAgHsGIPW9+ZzQLGD9SLNgr6bDfb/8HhlENfRHKH9aEfgGZHF3LtVnv4HOIkpmG94DRVTj3NsZi7h+7FzQ1q1y98RaI377F2tE6q+VHj44MGj5/UhH2alCNmGmgzS8xs+QEM8QCi+O28ptbSGCvxaOmCzhu/8DsjSaSSzlJRabdC5eib89cRGWnnWpSXlU1RPfu/JzqD7u1H8V9iBqLUts7qCKGuDCnYR
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199018)(40470700004)(46966006)(36840700001)(86362001)(36756003)(40460700003)(356005)(70586007)(70206006)(4326008)(186003)(47076005)(336012)(8676002)(426003)(478600001)(316002)(54906003)(7696005)(110136005)(2616005)(6666004)(966005)(2906002)(7636003)(7416002)(5660300002)(82310400005)(8936002)(41300700001)(82740400003)(83380400001)(34020700004)(36860700001)(26005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 01:52:39.9190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b51d1e-bef6-499c-e1a5-08db16d2fa43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog
v3:
 * Rebased on top of Jason's iommufd_hwpt branch:
   https://github.com/jgunthorpe/linux/commits/iommufd_hwpt
   Particularly the following series:
   1) "Revise the hwpt lifetime model"
    https://lore.kernel.org/linux-iommu/0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com/
   2) "Add iommufd physical device operations for replace and alloc hwpt"
    https://lore.kernel.org/linux-iommu/0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com/
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
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v3

Thank you
Nicolin Chen

Nicolin Chen (5):
  vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
  iommufd: Create access in vfio_iommufd_emulated_bind()
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
  iommufd: Add replace support in iommufd_access_set_ioas()
  iommufd/selftest: Add coverage for access->ioas replacement

 drivers/iommu/iommufd/device.c                | 114 ++++++++++++++----
 drivers/iommu/iommufd/iommufd_private.h       |   2 +
 drivers/iommu/iommufd/iommufd_test.h          |   4 +
 drivers/iommu/iommufd/selftest.c              |  25 +++-
 drivers/vfio/iommufd.c                        |  23 ++--
 drivers/vfio/vfio_main.c                      |   4 +
 include/linux/iommufd.h                       |   3 +-
 tools/testing/selftests/iommu/iommufd.c       |  29 ++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  22 +++-
 9 files changed, 185 insertions(+), 41 deletions(-)

-- 
2.39.2

