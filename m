Return-Path: <linux-kselftest+bounces-16423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F15DB9614D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDCF1F21155
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA91CC163;
	Tue, 27 Aug 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlASPNxm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3DD45025;
	Tue, 27 Aug 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778109; cv=fail; b=YpSYTyIIeHTcbiDyHqgJpVW5WEwJBlZu+VT2FjEjEjKJi1psiH5uB3mrCMn+If9DZGPr3ZJqX333aTkiK4lyCeKI8m+RnJzNExK5G1IN6fcSwKmUAX9Az0sg3jeNVq76ouxltKDmCAD/SzmtxhYuqRmz8EKOEeFLzZgElmiw1As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778109; c=relaxed/simple;
	bh=Y9FF2mfYw8mkMHkHcVIK3LGCowT2A1/x209213BF+jU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOg1Eo3I4uuJQ5HnZwOmspTrwNfzvml37tRXEFtWVhfzx2XbUZFpu707A9K6XNcXsDOrpxuj86xSFNZeSpXOr8zUJvy1CJhmp2vVAhQ/8agfgDPTbuZJYbybHJOrvTLYcgmxBeBnwgVqvVRgoy4nRxNrEBI+xyY3VitYg/YSb1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BlASPNxm; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHmupc9wgM03GKmNpQjyaLp5Jtyfl13Xy7g4iduiio/SVQsTOwzaKmTiVBj2KGFtGbsBq0m1q5W9+3mwNIDZGmZmpEDinhInRi1qN74rtoNiSsnc3Ir0XSYos10m2yV5hoSvHeGDe5vIUlHmGppG9jZVrkN2cS8cdBu0O6McCv5ZBxhzzNjYNkxxjXcbLiMcJ72DE1YvddRZd1AtqEWGkKKo974sk5uoHhHBAh8zOA9rcw4UIJD+4i2rYfbuqn8Tm41WrXZ8GhTH+pPlx20oTqLNxn2/+nLm/dW7BLst5ArPRDX1lyr2YnFGZnLmEsq6y4V3FXEKlCUHGtFaKodIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiY4DGnj7OOYrUmlV3i4SyqOQHAYBstBRR+GqUJE9RY=;
 b=ocL0uJ8d68EpbTLoYTGX+/FcD1Whe0JlIGMJcp3/BVzof1DXzUUdvQEzkTuxAyWR5MHNf1G5Agzns7+trAegmBt8qH3hUxcwE+fTMJJ8bzHmw5wX5GiDjfd3Ur5fUD6oS2oPsDVtjTPsssOrDFm3aVGvcf/l8TqxIQXObfw/iXLCcUHfCaHznenPGeySg2WraCzKjLs9qygoLZ28jrWY0fwiSINPDMlOXtTxdhUJaMVNGpv5AVHLm2PkgseaJ7AkKF5tFX8uc2GV0vmeTAB+j5jrvmbgiHQAiLWrjTOngj20viS29bM0VQ4NglFKdNaE69fnfWMIV62/p0pQ55SG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiY4DGnj7OOYrUmlV3i4SyqOQHAYBstBRR+GqUJE9RY=;
 b=BlASPNxm0KnQVjFyTCkQx2W4/ZwEgwcGNx/4Dqcf8J5a/ibuQsiP/6xMq9kfHntNKIAE00rhA730D7PxrDTwSWd3Luhs9//QQzraF3umCvyJU8G5WaMfJ91lVLEi6n9jiYP2x+ZyGrDJOhrABhZ9h4Rerf2bCHR3hh+nlJTWD9UOzU956Z3f1VIcLFFKiy2QQ97NyCIXODntPlvMsuD3RvvApv+0XUjBGGM0mjtsSXkT/iHHeguQQe02gMJgknu8Epc1xZSmw88CW6QDVtxREpwFK5facpJZ1hlx0GRp4L+yueqipPm0nw0ARhSRujjeMqYbBKnDITIh4Wi7k/vDCA==
Received: from PH8PR07CA0038.namprd07.prod.outlook.com (2603:10b6:510:2cf::18)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:01:44 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::89) by PH8PR07CA0038.outlook.office365.com
 (2603:10b6:510:2cf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 17:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:01:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Date: Tue, 27 Aug 2024 09:59:37 -0700
Message-ID: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 528dfcd7-32ef-4e8b-e180-08dcc6b9ed50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8h68tnj6NFCDiGuJVAJtkzU0MeCr5Ja0/Bbi74g1A0yvfzRJY81L2QnUCIHt?=
 =?us-ascii?Q?ruf9tl8AfcGKi8TPErEklSadsz1B6pWHNJEVMnYUhJjHo3EWn7xckYzdJigW?=
 =?us-ascii?Q?bG3tHJt8p4oqipvGrggpn8D63HGdsImrBA9uv/JTZqsVy02n0Uztekdedulo?=
 =?us-ascii?Q?jxiSIB3meG1IxTq4vky4bnsGrvDFwJybPbS5y0bTrI8dEqQIfNhouCLuYrm2?=
 =?us-ascii?Q?ZEj1LC58TF6CJpPNNbHsfOXTKCSD4LT/MQkTVhSAU3/cVfBastcfOdcxFMX9?=
 =?us-ascii?Q?9c9eyuf20bf2XMAch7PYT56Z+W+Z/3KFA1I+3Qob/lqMThO7Swsjc0uFzhQK?=
 =?us-ascii?Q?vf5aZE8R96WY4dAK1dUZcnTIRg8e0/wrLQGa9aP9m4HTlChH0sL0rcJyDQGf?=
 =?us-ascii?Q?rU8pN5VVsJzSzeC3qDP5DV3iCgYWoBxA5IbMbefbwFFH6tgIAGw1gcyVfwye?=
 =?us-ascii?Q?Jdr3qg8d0OG6lqwX0PN9Ju9sEVA65vl7L+UAiAsAzR9GXdZNPTFLLDHMnWaK?=
 =?us-ascii?Q?98t9PJmJfKjBVR/mxc66N8Z9RexX84EqDgD7m5SSdtC/IQfKdS3bH+w1meIJ?=
 =?us-ascii?Q?3fsT4zYKgVawa853HU/3DkvHYob9q6H/jWLJ/RkHqSrXZ2fvptWukTSsGt87?=
 =?us-ascii?Q?9QDk7/mV+ag6903mU6Na2V2xYGagZIggw0Oe6N1FqhC3kL12SGubNZpZ1Qbg?=
 =?us-ascii?Q?lbnJvc1Ea+2nALbrtqbgQj/TUI8vTEYrz7IbjD0DSMeH577l0goJmLujOiQV?=
 =?us-ascii?Q?vya4p+/m+y7H7tTcnGw8OvfaG/mnd7wX2LwGr/01GDBs3RXrx6KrBo2QWYra?=
 =?us-ascii?Q?sMahN7qQKNTkqavVGjExfvEcOMw245GgLggnEM0WkDw2mRhjhTdywHep9Rtv?=
 =?us-ascii?Q?u+aiKq8Q6eXXs6tYe9FB5jZIDZNt7CSrtMg3nSRPX7B6F3jDpySh7WZrBdW6?=
 =?us-ascii?Q?dBLn7cHpKUta3T1hdfe/wVhXtSnaavPdfw0l2VeH6xGsrJSXYaesb1ZNj3Ka?=
 =?us-ascii?Q?8TLdTW6HGC4yiO76TcfNPF+dbPiHZzpWpnCE6zdjinTxhA7SCyQCYqM5dMRt?=
 =?us-ascii?Q?/QFZgpXpZSHpIBIcGfXLwOLjhhKmkPlHYr7cj8xy4FCgOpjRAjfuCU3s3cZ4?=
 =?us-ascii?Q?p313fC8WIXg2SfBIeN8qKuitRDintpDUfrRbMThWH2MLuXfnhWLJP7iQmMKl?=
 =?us-ascii?Q?OJANR8jvLVZTM8N+8uZhGk4Zq0O8cvS8QwrBdJIEjDWLhKmp+mEhgbdyQDJq?=
 =?us-ascii?Q?sXs/zIDc59pzXFwGvuoAu9IxKfvsa+aO9ND1gufFJnzDuuMRTeiwOhSMmjlF?=
 =?us-ascii?Q?WljN/ZZgmfjg9gtJej4ndYabGXikfpHLvtjM+K0cDZCtneE8CtsWnxFl1gLE?=
 =?us-ascii?Q?DiuxLlOb4tEVtJqLEWOJ57GTcdWnV3n4dIHhFXGzjw/I8GDgmWEJ6LVd44c0?=
 =?us-ascii?Q?k0ZbqixCYT5vpGJfQ24qFquooFEN9jkvqnOz+faKiajFaBYDTJNH2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:01:43.1424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528dfcd7-32ef-4e8b-e180-08dcc6b9ed50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

This series introduces a new VIOMMU infrastructure and related ioctls.

IOMMUFD has been using the HWPT infrastructure for all cases, including a
nested IO page table support. Yet, there're limitations for an HWPT-based
structure to support some advanced HW-accelerated features, such as CMDQV
on NVIDIA Grace, and HW-accelerated vIOMMU on AMD. Even for a multi-IOMMU
environment, it is not straightforward for nested HWPTs to share the same
parent HWPT (stage-2 IO pagetable), with the HWPT infrastructure alone.

The new VIOMMU object is an additional layer, between the nested HWPT and
its parent HWPT, to give to both the IOMMUFD core and an IOMMU driver an
additional structure to support HW-accelerated feature:
                     ----------------------------
 ----------------    |         |  paging_hwpt0  |
 | hwpt_nested0 |--->| viommu0 ------------------
 ----------------    |         | HW-accel feats |
                     ----------------------------

On a multi-IOMMU system, the VIOMMU object can be instanced to the number
of vIOMMUs in a guest VM, while holding the same parent HWPT to share the
stage-2 IO pagetable. Each VIOMMU then just need to only allocate its own
VMID to attach the shared stage-2 IO pagetable to the physical IOMMU:
                     ----------------------------
 ----------------    |         |  paging_hwpt0  |
 | hwpt_nested0 |--->| viommu0 ------------------
 ----------------    |         |     VMID0      |
                     ----------------------------
                     ----------------------------
 ----------------    |         |  paging_hwpt0  |
 | hwpt_nested1 |--->| viommu1 ------------------
 ----------------    |         |     VMID1      |
                     ----------------------------

As an initial part-1, add ioctls to support a VIOMMU-based invalidation:
    IOMMUFD_CMD_VIOMMU_ALLOC to allocate a VIOMMU object
    IOMMUFD_CMD_VIOMMU_SET/UNSET_VDEV_ID to set/clear device's virtual ID
    (Resue IOMMUFD_CMD_HWPT_INVALIDATE for a VIOMMU object to flush cache
     by a given driver data)

Worth noting that the VDEV_ID is for a per-VIOMMU device list for drivers
to look up the device's physical instance from its virtual ID in a VM. It
is essential for a VIOMMU-based invalidation where the request contains a
device's virtual ID for its device cache flush, e.g. ATC invalidation.

As for the implementation of the series, add an IOMMU_VIOMMU_TYPE_DEFAULT
type for a core-allocated-core-managed VIOMMU object, allowing drivers to
simply hook a default viommu ops for viommu-based invalidation alone. And
provide some viommu helpers to drivers for VDEV_ID translation and parent
domain lookup. Add VIOMMU invalidation support to ARM SMMUv3 driver for a
real world use case. This adds supports of arm-smmuv-v3's CMDQ_OP_ATC_INV
and CMDQ_OP_CFGI_CD/ALL commands, supplementing HWPT-based invalidations.

In the future, drivers will also be able to choose a driver-managed type
to hold its own structure by adding a new type to enum iommu_viommu_type.
More VIOMMU-based structures and ioctls will be introduced in part-2/3 to
support a driver-managed VIOMMU, e.g. VQUEUE object for a HW accelerated
queue, VIRQ (or VEVENT) object for IRQ injections. Although we repurposed
the VIOMMU object from an earlier RFC discussion, for a referece:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

This series is on Github:
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p1-v2
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_viommu_p1-v2

Changelog
v2
 * Limited vdev_id to one per idev
 * Added a rw_sem to protect the vdev_id list
 * Reworked driver-level APIs with proper lockings
 * Added a new viommu_api file for IOMMUFD_DRIVER config
 * Dropped useless iommu_dev point from the viommu structure
 * Added missing index numnbers to new types in the uAPI header
 * Dropped IOMMU_VIOMMU_INVALIDATE uAPI; Instead, reuse the HWPT one
 * Reworked mock_viommu_cache_invalidate() using the new iommu helper
 * Reordered details of set/unset_vdev_id handlers for proper lockings
 * Added arm_smmu_cache_invalidate_user patch from Jason's nesting series
v1
 https://lore.kernel.org/all/cover.1723061377.git.nicolinc@nvidia.com/

Thanks!
Nicolin

Jason Gunthorpe (3):
  iommu: Add iommu_copy_struct_from_full_user_array helper
  iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
  iommu/arm-smmu-v3: Update comments about ATS and bypass

Nicolin Chen (16):
  iommufd: Reorder struct forward declarations
  iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and IOMMU_VIOMMU_ALLOC ioctl
  iommu: Pass in a viommu pointer to domain_alloc_user op
  iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
  iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
  iommufd/viommu: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
  iommufd/selftest: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID test coverage
  iommufd/viommu: Add cache_invalidate for IOMMU_VIOMMU_TYPE_DEFAULT
  iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
  iommufd/viommu: Add vdev_id helpers for IOMMU drivers
  iommufd/selftest: Add mock_viommu_invalidate_user op
  iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
  iommufd/selftest: Add VIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
  iommufd/viommu: Add iommufd_viommu_to_parent_domain helper
  iommu/arm-smmu-v3: Add arm_smmu_cache_invalidate_user
  iommu/arm-smmu-v3: Add arm_smmu_viommu_cache_invalidate

 drivers/iommu/amd/iommu.c                     |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 218 ++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
 drivers/iommu/intel/iommu.c                   |   1 +
 drivers/iommu/iommufd/Makefile                |   5 +-
 drivers/iommu/iommufd/device.c                |  12 +
 drivers/iommu/iommufd/hw_pagetable.c          |  59 +++-
 drivers/iommu/iommufd/iommufd_private.h       |  37 +++
 drivers/iommu/iommufd/iommufd_test.h          |  30 ++
 drivers/iommu/iommufd/main.c                  |  12 +
 drivers/iommu/iommufd/selftest.c              | 101 ++++++-
 drivers/iommu/iommufd/viommu.c                | 196 +++++++++++++
 drivers/iommu/iommufd/viommu_api.c            |  53 ++++
 include/linux/iommu.h                         |  56 +++-
 include/linux/iommufd.h                       |  51 +++-
 include/uapi/linux/iommufd.h                  | 117 +++++++-
 tools/testing/selftests/iommu/iommufd.c       | 259 +++++++++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 126 +++++++++
 18 files changed, 1299 insertions(+), 38 deletions(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c
 create mode 100644 drivers/iommu/iommufd/viommu_api.c

-- 
2.43.0


