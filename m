Return-Path: <linux-kselftest+bounces-21177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2F9B6F5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35C9281B29
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B96218D9F;
	Wed, 30 Oct 2024 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="anRNiIVZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACDC218D89;
	Wed, 30 Oct 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324171; cv=fail; b=j9YEkk+oteRJdApuRSkx/JQFpXLj10Y05BdVVe838DMPW2gfgC4BPZZzNhKRNPYcqL7R8z9BZrpsxHjPJGVmAKPIhsKVhOPrsxVtvw7iVAzZLu51w4M/d05KLD4sTL5F9YO/StuDShfLAaWaav5tHGIg94oPaenebz7jqjlObns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324171; c=relaxed/simple;
	bh=HxyDpwJe65RJ7sZnJhIMmrgnU9Sw4y8G1A7Ip+HydUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XwSNiH7DqRlaoZkgC30U+lUVEneb2znTH0BM34PAbA442ha3bux21lEBqOwKomPV5c3nGDqV0jlZOCOYAHGjNFMC193LhyMbfYmKAVjzZoXA3mGpYMw3u3Hn5ilg3T8z5O4q9XykoligufHcKw1VZjyOz8Wax1/odkZzskVrQXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=anRNiIVZ; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLC7sqJT8XFZYNl86p87VVQWJePgJIBnuek7ruRPYs5CABHV43nALS9gwsxpPYJ1kME7Gl2BtaL0Sns7TWQeY8NPtdVEpOlY5UlUCMPLmYKcmzJyPPkKXFbsjscFRRg7eMXuoyjq9CYSGcdAX1JgIzy3vcuqZGz3TEH9dghtLe3ifUNy6qnwzJ1yQ9oHuEHKvhdzmxyD9s7fWM8jEUAaU5XgXtf0a7priRMJmEseaiKZxkJSypkT0ifD4fy/TM075lVPzIR+kH7Q8eGR3XrUQKapPCJcQ7rcHjexYbhyqznBwA78hhAgZ68du1oR/fPGLRjhC1DZVwkoGjGhYzeAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wCABQjkx9pDbQZpIIkyVeGLSu6wS7p+F3RDTqMtMs4=;
 b=lpVclIZoY0oyK+ZyaoxtF1vJwNsq67jM8cYjasyIml4bpkIxWRuLG5KXt9iUPVkiU7gEJFLQECPQmwUP+mlIhW0iWMSW6PatVjvD13KGXIEinM1cpgfQfKYkEfM+V7f8IPhkP8Dc0RHpejfZIcUW0Nsf+2dPNKoUWRQsB2XaMQeqFmUI/MHxpMKuXF4xYEH3y+JjXTZ2hrLLboQqh1wP9zhDHKsMLWUj5z8/PJ3ZSvCKVgjabHTsSN5CErHYatslKBJ6xf6YnT2sGfS12+q8AWFsg3w5uHyxHFcumv8ZQS9BRcIM9EvzhD84J2NZzz3MNEBouEGmi84G+237nwYayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wCABQjkx9pDbQZpIIkyVeGLSu6wS7p+F3RDTqMtMs4=;
 b=anRNiIVZKVePR6YmMGYTbf0uOeaQoEWlzL0OeVs7gl6FOAm6luSEYg+yTgHgt6TxLjqb0YABzIYaiSSeFZed8Grr3jRGC4XnMwU7DBTh4kiAJHVN++NHk9eWY2XZ2toOsSmJjYUgtvJBQQT4Qxrk8PvjzoS44LF4EDMrhQAJtE0m91MCFNh4WYCpa8sptKelJ8OL5se9QsYNrwWVanlqtwH1WSZ/Lar31CmYdHpr3Pe+g9TgqdHdkJfllnxE37oaZFHuItloJmVQNgqz3KIKXRYtk5+BA6oOygQ5E6enjb5vffmcVvpDS+WjQn20SzO9sxEu7d6sxt1mEgifMbx56w==
Received: from MW4PR04CA0203.namprd04.prod.outlook.com (2603:10b6:303:86::28)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 21:36:04 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::89) by MW4PR04CA0203.outlook.office365.com
 (2603:10b6:303:86::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Wed, 30 Oct 2024 21:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:36:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v6 00/10] iommufd: Add vIOMMU infrastructure (Part-2: vDEVICE)
Date: Wed, 30 Oct 2024 14:35:26 -0700
Message-ID: <cover.1730313494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 26320708-e5a9-47d0-7f45-08dcf92adada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q7jmCyjDdCIi6TJgUsWHECo41p8Oy3vtYBBjVL86cWaLjxc+7qK7GdQLGlVj?=
 =?us-ascii?Q?3eAInzJ+i+67DZDjD8GW15p2UJ68tuhB7S1LRE4EF3hSlH06L6Tpfw4Ce4kw?=
 =?us-ascii?Q?TQyTDJhbAiO3uEPqBB9HRpeiigJecbv/o33h8AbiUBAWMemRwqKdn+PrXslo?=
 =?us-ascii?Q?k5QdPpUzPo0WdGvmdKc/fj4nHq9m0PO16FPJahH/9rFo5c31BmkU2HXrSwrn?=
 =?us-ascii?Q?MurP5+WjbczX5SnJ34+LivE81ceG45hYJZl+2ApMFabsnWS88PvDDCvyow8N?=
 =?us-ascii?Q?4GMOh9mj+4vk+JLfmjoyv5NZjDe3cKgAR4Vg0qLt+sLOH6ispss2qnhfNFVq?=
 =?us-ascii?Q?ZNeO2nQlyZsjAWfprqKGUpti6CgT0h0NhST9hMg646A+ZFtciFPL0jkj546D?=
 =?us-ascii?Q?O57eJMz3+McvQG0lSytr67eK++QYiZoLBjPG4aQIMvF7+oHnMhvJ036Vcm8E?=
 =?us-ascii?Q?1tFg+AGdGOt7+uo5I4DOoaawg2b9Rt2eZKwVCRC25T1MD/ATyqfiRnOpyMKc?=
 =?us-ascii?Q?fSv2+Gp9kXUkoX3hBNlbmcRP59DIowTFVO4icWEJKGfvW+MsW1cGZZu3O/Vz?=
 =?us-ascii?Q?FO6nOi82VR+1jaUsCQIzywz4FsI/y2eFXmqgG1a5BOxB6hMBvvhuRjcE8QmI?=
 =?us-ascii?Q?WlbQSQP80y/UWRg7EpBRzjdGIFZ/di0zOfWnqZaSgmtR7DQ/e3Yp+mq/N67F?=
 =?us-ascii?Q?kf9CnQ3FRhRr/d6wQ97mlLHBGWgP0+K5mvA0rLskp9RpMuQpH6TQ1vptHlpf?=
 =?us-ascii?Q?djaMowsWwLiEejU3waOpJPzS2kRTxPBYaCfy4BpRORaXigX3rURVGDiZveN9?=
 =?us-ascii?Q?6OURO/LQQN2fiGJra/XOek0H503EAxV4oSJAJs6Kp5XVMgaDtBxMvGolcmAh?=
 =?us-ascii?Q?CfAgXN/QChjsY8U0Axo/MW/Qc2dkGhdbxYGslxfASAOXWIxK40BG3qu5ZxeO?=
 =?us-ascii?Q?gRppzNTZ/L1ckL6mgpMJ7owjA9es2QTdbo8I7jRieS1Hm3n5jL/vnzmUb1HB?=
 =?us-ascii?Q?Dfm7Q+R6dK0iDkqhCXtRTorrTxeAXo4xeeP3572bydBL01TCX4St9WKobtxb?=
 =?us-ascii?Q?0iY0QygLpObDiShd29FwFD64/BuPjs8xY0A01ojXCrExgW89fAGom1hl0Zmh?=
 =?us-ascii?Q?ZJRzVpLRzk3dDKELpzBg6YVlsLNhTGQ9r4bXVUlEVKqCk0h7yV5WJlNVeOsj?=
 =?us-ascii?Q?h/iJ7KhoWPX1+fwl53NO/4pctb50i5ztrHmmaJrt5CJBE9YeaIpRz7Ad97S0?=
 =?us-ascii?Q?hPYGAp3cAhxx9D4GIdSFvqxnVxNetqaa1pmKVVP2akdhhg0agbhtK6gfj5ko?=
 =?us-ascii?Q?HE8cB8TPXltj+G8mwwsfvk74BqXcCXzCF7nSyBxocA1u30ZInKigOZQmiGnS?=
 =?us-ascii?Q?AO4wmShpHbpnzXdaga96TQvXHwlIEvcs6AjQepaP1LfjbePIYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:36:03.3744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26320708-e5a9-47d0-7f45-08dcf92adada
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380

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
e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vRID of Intel VT-d to
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
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v6
(QEMU branch for testing will be provided in Jason's nesting series)

Changelog
v6
 * Fixed kdoc in the uAPI header
 * Fixed indentations in iommufd.rst
 * Replaced vdev->idev with vdev->dev
 * Added "Reviewed-by" from Kevin and Jason
 * Updated kdoc of struct iommu_vdevice_alloc
 * Fixed lockdep function call in iommufd_viommu_find_dev
 * Added missing iommu_dev validation between viommu and idev
 * Skipped SMMUv3 driver changes (to post in a separate series)
 * Replaced !cache_invalidate_user in WARN_ON of the allocation path
   with cache_invalidate_user validation in iommufd_hwpt_invalidate
v5
 https://lore.kernel.org/all/cover.1729897278.git.nicolinc@nvidia.com/
 * Dropped driver-allocated vDEVICE support
 * Changed vdev_to_dev helper to iommufd_viommu_find_dev
v4
 https://lore.kernel.org/all/cover.1729555967.git.nicolinc@nvidia.com/
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

Jason Gunthorpe (1):
  iommu: Add iommu_copy_struct_from_full_user_array helper

Nicolin Chen (9):
  iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl
  iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
  iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
  iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
  iommufd/viommu: Add iommufd_viommu_find_dev helper
  iommufd/selftest: Add mock_viommu_cache_invalidate
  iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
  iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
  Documentation: userspace-api: iommufd: Update vDEVICE

 drivers/iommu/iommufd/iommufd_private.h       |  18 ++
 drivers/iommu/iommufd/iommufd_test.h          |  30 +++
 include/linux/iommu.h                         |  48 ++++-
 include/linux/iommufd.h                       |  22 ++
 include/uapi/linux/iommufd.h                  |  31 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  83 +++++++
 drivers/iommu/iommufd/driver.c                |  13 ++
 drivers/iommu/iommufd/hw_pagetable.c          |  40 +++-
 drivers/iommu/iommufd/main.c                  |   6 +
 drivers/iommu/iommufd/selftest.c              |  98 ++++++++-
 drivers/iommu/iommufd/viommu.c                |  76 +++++++
 tools/testing/selftests/iommu/iommufd.c       | 204 +++++++++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        |   4 +
 Documentation/userspace-api/iommufd.rst       |  41 +++-
 14 files changed, 688 insertions(+), 26 deletions(-)

-- 
2.43.0


