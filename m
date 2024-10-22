Return-Path: <linux-kselftest+bounces-20349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8B49A94C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8051128339E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCCE1527B1;
	Tue, 22 Oct 2024 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QwgMMwt3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E291494D8;
	Tue, 22 Oct 2024 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556454; cv=fail; b=goPpHZdJ2P4LeJnyiJbnrzsqKxmN4lT882R0Y61DBRh2+fqtyfQ/tQeQQ8SYU/7+lAOUk0kyrKW6/6UETqG6RiJQlJxP6NqPUoSDu8wT8pyGKcxjy0MmyaUg66tgnhYG220nahTfbxUNyHebsh/Gm5EwD/l89hEw9zmHv2jbKcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556454; c=relaxed/simple;
	bh=dmPFkHXmWeKl8Rt68LVnXhOTJehJe5a/jey65diSj9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WuW4WAKX/g6MWrhOul4GaxTss6502U470yS8rTsXgxrvgxOqqzwZ7YtgKTsVjzqwaYr7hda4+MG92+9VqBXx5lJKNzhQzXsfaE/LMz42quyrUNiofegi2T4kZhcrojQHr3NbqrWIa7StjXKKXsLLM+eu/Vpc46VtSnke51xgXwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QwgMMwt3; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AigYS6ler1Z+B5nrzcbI3u9ySHzOhJF1QFXxIaQdEOizEHZY50TDIdp625ZWRruXVEE6e5riIMqJIA9V1ge2RxkZSm6FbSt5ZbhKSI5WbwY4S7FUNpx9mDyguzFHqn2jFhh1JR3yWy8ebUQByiSc6bW24sP9W10LMkupbIVK3kOqMTTB5I7L/oCsfRAY7JPFzcqKq3RFI0pvAcxXXdU1cLNgMpvmHlbyfcCG2TAckni4vAb0lXtAn5NrJx0dIfE0sTYC1LqMBUhHZt5ydBYV+UDNGZusMd0RgrF/BkPOcApgNm3xUSGa1UN/grjFBE2j9zRvczuQTy0BT51jfpwmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCezS9Del6LSe6SehPFVJgMtgg7Dsmwv9IJjJwG0OIY=;
 b=dj7LA28jL2GPDspM8vqH0cBpbYxbZLDrt/mHgdk66k6zlA8LROq0uCdAurUIUufBc6RZ7Yt3CCoVq9JBeS3oG5FDdIWFD/Re+bIvcM/DmnfSg51P4H/A06D/XngPNWPewW0jySUmEMIKTAH4l/t0x8+GTh0+TZW8yizLxYO319pkdAn/O5DqdrNyaSf8hCjhHcZJqeX53RtfBj/ksbjePD0Te4WykbuPuGqTpHx2IxESH5Wl3L84F6b1PQ2phXPaB83q03lNDdERrnx10Rz0SXcH2AvU65NrAs6SPpr4EI3aTzkuCwE7p4YATamgP4JxrDIBp8VlOBvgCHg1BZH0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCezS9Del6LSe6SehPFVJgMtgg7Dsmwv9IJjJwG0OIY=;
 b=QwgMMwt3g/JbAdgbf/pyfY5DgoZI5JLT7Mbaw1CPnVTSPcVWEzpbeRFNyrlX9rc7OtUYsjyomLGzgPn2aSFTgX35TPO4bFTkMwEKFrT6zjDLMLNEY7Ijt4A/0M1TtxlFXIKy5423E0ipPE8z1lRua7Cfm9EXy8xTGU8Sn/LVLdTyBItZ9HsUBuA8bliOwyxxjPrzgkXyDo8rx+gfskPAOzVZV4BrXaPAnvcPQT+4sIdPHJYIhxiLqQaXrUIksztOJM2BC3fJ1QLP8MyD4EKfB3nze40jDVDrATq5K4bLcfPKq3DsdT2Q8uTYJAbZnwMDQ5XFlN9bASsELOGTmZWzGw==
Received: from MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Tue, 22 Oct
 2024 00:20:44 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::94) by MN2PR03CA0027.outlook.office365.com
 (2603:10b6:208:23a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 00:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:20:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 00/14] iommufd: Add vIOMMU infrastructure (Part-2: vDEVICE)
Date: Mon, 21 Oct 2024 17:20:09 -0700
Message-ID: <cover.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c9ae28-2639-42d4-6c2f-08dcf22f5e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UXNlhgurbLYgHOerZdQ9a6c0Hwe5q81e9hvVUbrjJqAxb5AqHIKzwm8Xgt23?=
 =?us-ascii?Q?9YBt1XQLrhDXsYSLdWW67HSvVNAHyhWYLTMBZwSnDq+tCivYgEbQDYBYnvaH?=
 =?us-ascii?Q?1j2OYg116CXj7+7ilfLYn9NA7BblPESWecBDh9efAEebbq4GXmKpN7mqj2aT?=
 =?us-ascii?Q?PlMFEWXOPCzKuZ/Fs1UMv48Vasf+lcFeb3RFv0fXsy0UJMtSJEprglPYAaoL?=
 =?us-ascii?Q?Wi/x6WwaoOFYgrYAIUZzaZ8XO/tzWmh1ZnO9jIHgEZ/K+2YzS9NtNx1yPnoQ?=
 =?us-ascii?Q?0kfOe/Ve3osiePPk4QSZhk0LGrYIBvFHsw2wTyXNCPfruDxFbT6wmKFTjo26?=
 =?us-ascii?Q?Q3bx5LsVdHD8ticeur3zqWwLjKH3r5zPetFmORH0dBa2Vg4/+bbjxWpNt2d1?=
 =?us-ascii?Q?QJcDqakFxFz4H2rc9kTqq0rjt9Nbz4ngEdOog5x9h4SUjMUhHFwjnbL84CMS?=
 =?us-ascii?Q?Zfc4o1ZUcCY70SnV2HXWdheg91Md6VQ6M7po6S8qYq9ndqXJ1XE5NjyP6qfg?=
 =?us-ascii?Q?bL7ztOFUJSn4xQ4gCt7QERxO7vvc7GFzNm97dtKwy/OUsJsyEXJ5x+GtaZH/?=
 =?us-ascii?Q?nI2sfS/DlDbJvguROC87H44SxRKCgiPhtwludiotlTbQ4725M8xZnrHzrU4J?=
 =?us-ascii?Q?Sgel+X4+dLocLJH4WzMnasOHDKI8QwJ0+hj1tLpp2WNjpXNQRekG0C3PYjUg?=
 =?us-ascii?Q?OPinwESMT1UiK4n8Xw2BQ1CIqBlwPAfRG6WPh2sau6V8OdlQbLkvAqOF6+U1?=
 =?us-ascii?Q?tz/t3nmRxBi8UJNiTvSEYRE+rYitD/Tm24ZGkl2k2OFvxAr5YXyDkeLsAUyy?=
 =?us-ascii?Q?OD4ESsgLKnGnqiBN5dNwZgN4iLyJzA0iUoPE93pVN1PLjRS7TYRfy3Vakp3r?=
 =?us-ascii?Q?eh8BWwlAM6vb5AT2vQ0sCg4LTbhLT2zbLMoLfvR86rQBfwkHMLSYTfmAXcUc?=
 =?us-ascii?Q?pyW6XB9BM0kREfq8Z8mIVY/BUG/jOXIxXHGswWAEasjgkzrFD0XQkqRptMx3?=
 =?us-ascii?Q?HJ4yoV5DW6+bt92T7M7yBE9MkPBvIPtaTBFIp/yLEbJv2OfBX9K8xLGM1+Pw?=
 =?us-ascii?Q?CeEB8hZl4reqcn/dd1qXp7cWibPWpL8Ejl+0UjoEU1kdo44ZJo9R36XhQGli?=
 =?us-ascii?Q?V0HFXLGILUYL4U7udpXDjqU6ms4+3dKnpgnMXvZf12RhwfpMRoULHrR8AcTh?=
 =?us-ascii?Q?TvFzYK2t+k7rzF6IwD/y1ze96vsT8dkF78alp05p8eGoXWxvLvFdQG+w1m+1?=
 =?us-ascii?Q?u8g7qosozwXa7CYtcTveS8CprT0Hl2VVUKAq4NzD0OLe2XvJMctNF2YQecwd?=
 =?us-ascii?Q?JqrlTXM4uVl/6plT6OiI/K6GuALE9iRZLJB4Tsx6U4frCjjPeL/xrvDUtzVx?=
 =?us-ascii?Q?6eAk0QbzBTJ1/zsgGeG7334AvaGeBxa1H4dCHU8IOa2jpNfNfs2sAqk4ZgFw?=
 =?us-ascii?Q?0DgvU0r4dcI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:20:43.3709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c9ae28-2639-42d4-6c2f-08dcf22f5e0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

Following the previous vIOMMU series, this adds another vDEVICE structure,
representing the association from an iommufd_device to an iommufd_viommu.
This gives the whole architecture a new "v" layer:
  _______________________________________________________________________
 |                      iommufd (with vIOMMU/vDEVICE)                    |
 |                        _____________      _____________               |
 |                       |             |    |             |              |
 |      |----------------|    vIOMMU   |<---|   vDEVICE   |<------|      |
 |      |                |             |    |_____________|       |      |
 |      |     ______     |             |     _____________     ___|____  |
 |      |    |      |    |             |    |             |   |        | |
 |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
 |      |    |______|    |_____________|    |_____________|   |________| |
 |______|________|______________|__________________|_______________|_____|
        |        |              |                  |               |
  ______v_____   |        ______v_____       ______v_____       ___v__
 |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
 |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
 |____________|   storage|____________|     |____________|     |______|

This vDEVICE object is used to collect and store all vIOMMU-related device
information/attributes in a VM. As an initial series for vDEVICE, add only
the virt_id to the vDEVICE, which is a vIOMMU specific device ID in a VM:
e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vID of Intel VT-d to
a Context Table. This virt_id helps IOMMU drivers to link the vID to a pID
of the device against the physical IOMMU instance. This is essential for a
vIOMMU-based invalidation, where the request contains a device's vID for a
device cache flush, e.g. ATC invalidation.

Therefore, with this vDEVICE object, support a vIOMMU-based invalidation,
by reusing IOMMUFD_CMD_HWPT_INVALIDATE for a vIOMMU object to flush cache
with a given driver data.

As for the implementation of the series, add driver support in ARM SMMUv3
for a real world use case.

This series is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4

For testing, try this "with-rmr" branch:
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4-with-rmr
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_viommu_p2-v4

Changelog
v4
 * Added missing brackets in switch-case
 * Fixed the unreleased idev refcount issue
 * Reworked the iommufd_vdevice_alloc allocator
 * Dropped support for IOMMU_VIOMMU_TYPE_DEFAULT
 * Added missing TEST_LENGTH and fail_nth coverages
 * Added a verification to the driver-allocated vDEVICE object
 * Added an iommufd_vdevice_abort for a missing mutex protection
 * Added a u64 structure arm_vsmmu_invalidation_cmd for user command
   conversion
v3
 https://lore.kernel.org/all/cover.1728491532.git.nicolinc@nvidia.com/
 * Added Jason's Reviewed-by
 * Split this invalidation part out of the part-1 series
 * Repurposed VDEV_ID ioctl to a wider vDEVICE structure and ioctl
 * Reduced viommu_api functions by allowing drivers to access viommu
   and vdevice structure directly
 * Dropped vdevs_rwsem by using xa_lock instead
 * Dropped arm_smmu_cache_invalidate_user
v2
 https://lore.kernel.org/all/cover.1724776335.git.nicolinc@nvidia.com/
 * Limited vdev_id to one per idev
 * Added a rw_sem to protect the vdev_id list
 * Reworked driver-level APIs with proper lockings
 * Added a new viommu_api file for IOMMUFD_DRIVER config
 * Dropped useless iommu_dev point from the viommu structure
 * Added missing index numnbers to new types in the uAPI header
 * Dropped IOMMU_VIOMMU_INVALIDATE uAPI; Instead, reuse the HWPT one
 * Reworked mock_viommu_cache_invalidate() using the new iommu helper
 * Reordered details of set/unset_vdev_id handlers for proper lockings
v1
 https://lore.kernel.org/all/cover.1723061377.git.nicolinc@nvidia.com/

Thanks!
Nicolin

Jason Gunthorpe (2):
  iommu: Add iommu_copy_struct_from_full_user_array helper
  iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED

Nicolin Chen (12):
  iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE and its related struct
  iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
  iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
  iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
  iommufd/hw_pagetable: Enforce cache invalidation op on vIOMMU-based
    hwpt_nested
  iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
  iommufd/viommu: Add vdev_to_dev helper
  iommufd/selftest: Add mock_viommu_cache_invalidate
  iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
  iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
  Documentation: userspace-api: iommufd: Update vDEVICE
  iommu/arm-smmu-v3: Add arm_vsmmu_cache_invalidate

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   9 +-
 drivers/iommu/iommufd/iommufd_private.h       |  12 ++
 drivers/iommu/iommufd/iommufd_test.h          |  30 +++
 include/linux/iommu.h                         |  49 ++++-
 include/linux/iommufd.h                       |  50 +++++
 include/uapi/linux/iommufd.h                  |  61 +++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  83 +++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 162 +++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  32 ++-
 drivers/iommu/iommufd/device.c                |  11 +
 drivers/iommu/iommufd/driver.c                |   7 +
 drivers/iommu/iommufd/hw_pagetable.c          |  36 +++-
 drivers/iommu/iommufd/main.c                  |   7 +
 drivers/iommu/iommufd/selftest.c              | 115 +++++++++-
 drivers/iommu/iommufd/viommu.c                | 108 ++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 204 +++++++++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        |   4 +
 Documentation/userspace-api/iommufd.rst       |  41 +++-
 18 files changed, 983 insertions(+), 38 deletions(-)

-- 
2.43.0


