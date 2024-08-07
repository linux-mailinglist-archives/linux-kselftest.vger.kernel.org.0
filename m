Return-Path: <linux-kselftest+bounces-14952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9481094B0EB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133D91F2491C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F614535E;
	Wed,  7 Aug 2024 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gSkNkZ+I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F694364BC;
	Wed,  7 Aug 2024 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061488; cv=fail; b=RW2MZKgXX6jzBTH5OY/tYCgt2onEIb/VWqai/w45Dcql1pcnzqVuLMeoVWF57pFMIEXETPfSNRhFBd7VGX6dTjpd2EA6qEYxJNk6b6KJC1g5fRkj27TAygwQ+NDCRT3PE1c/VOCT9qczsCfLhaKhbTE0j3g2aZI3ZDVnHxahokE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061488; c=relaxed/simple;
	bh=hFcXKdp27XhYwmOW75fMV9ysnCZV42GgNUvkZgcwo1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JqXBZZwZklHCYR1SFUTlS30SPeSJ3PqbY9I/pS8jZbc8dOP5c/l+jFsYCJwUiUEnn97GM5+5P+sXrqLzBLZSiiTj0Zvrt66Ql9ZiegjSXqy2XM/KgfMEIDyHcVCz9ZXnTMZV+/wdGbpqa7iEBglPJu/QO3swH4npDXlSk4lkIOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gSkNkZ+I; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPKtTTaD459GKk/Is+kyPWXZ1zkeA3boCPly8LtzeTW0bnZpJ4PdsNwvIzr93Iqql4wTR3wDXzlGHS2lWdzjwFrS/buhRhyBb854iW6st1SU3fSUUvo2iCTdna85l/+AAkUbpxVxm9VdkDDcVB0bzPuglMaSADMuTlXdxkbIB2aQLF2pNAAb6s327cmCwPWyi/rCniP2otIKGWmsonb414Gr1TH1qe+45HIaBmxMurIUbA8V6u+R6FveLX0AbMThzH/oQwVMXUH6m+jYyHruxKdhHzepzQlIEGV46mNIJhWXv7Rgc87jbh2t9olyHLU/4WqEZuytVy0kkbWJaHQUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpphAC70b/Jd12DvkLnZDWfeVysUjnb95mx1muyeVrI=;
 b=A1zQAqxQ4FIeHlE9pu3fvFMZtVg+vAjWr4L6yXZY2qrDUBX/cvFOBPDkqlq38CCgPGkxvmlM2/5ZB7fBuidZ4+aODCAHpQlTG8zVkbzhR+wtbZBh6wzGwfgNfNvZunuz1LD2GX3ALfkumLre9YmAqxUUiotTNVAoIpVZZj6TibWXrDVRKB/iLzEk4Gq1bk/VbbrpXg1UNnAqiG/X/zY7nlCvZZ1WCiHL/8LdYwImjgBHX8BmvFkOMoIMQKrZC/x17Z487oGsFTKJ5EIAog0cwWG/j+bWW1jy0jk//mo4wqbzS+RPEtezYwXu8VKha+YeH7AQnAgDs1ut8XonQe9D4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpphAC70b/Jd12DvkLnZDWfeVysUjnb95mx1muyeVrI=;
 b=gSkNkZ+IDWqhjhvrEZIZ0IijWK2AN/SE/kqvLv+xhUX0pSOS753mEz/4+MDFvxmWjRvEOGo2H90yKDQiHeYrH1acuvoLp0qD8WuFRv5cpTwphXJFqSZc56a7sw19MELvTuE3SLSaNo096oAYJnnib/H6UoG3iNNj9tz4tXKTsBYGzM2twS2Pi6YySD8mCS6wTAabE0RF4bBQdMYmkO8oChkKm4405vrK0rYPdpGxybvNHOgpqEkeERE3oWQUn0/nWhIkd1Mhc8l6QxB8kGpOd7L2Y0RDSFNgf5QGALZo0LIWbdArQBslFESgCb3eQI3/AvnghicHGF8ray3UvIj16w==
Received: from BN8PR15CA0049.namprd15.prod.outlook.com (2603:10b6:408:80::26)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 20:11:22 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:80:cafe::53) by BN8PR15CA0049.outlook.office365.com
 (2603:10b6:408:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 00/16] iommufd: Add VIOMMU infrastructure (Part-1)
Date: Wed, 7 Aug 2024 13:10:41 -0700
Message-ID: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a0672b-daa7-4928-8b79-08dcb71d1baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awXk70gXx938NynFD5YWpuQk5SNjwXjWeJxOcaFRSaFiNPk6kR77rrzNt1K8?=
 =?us-ascii?Q?pNkZeWxALH+pUPyz2iKjI4t/YPvO0DIoPoTx98shhyIFoND4xlVCQMJ9kf8G?=
 =?us-ascii?Q?owSxmdAMcI9S3i/aBkcWU1G3ckn37AcHzjothOf/iGIEU33O+FbKO05AonfW?=
 =?us-ascii?Q?oEI0E1sFw06tD5CqXA5JuAGGBDmN38flEt9BU2gGqZ/L8A8Wq5PgMzkX5bvU?=
 =?us-ascii?Q?c5pdOLeOQ+seU0qcuFedGi7AA0aXckeIaXbsc8q3hAtgJyWhKjGnrirdrbxY?=
 =?us-ascii?Q?E7o7KT1ToeS8Qhyo59b+Y4rqLf/YYQZ1mlWArhlQbwGgqMaG7Gn8zCBSP+k3?=
 =?us-ascii?Q?sbcHoNmoAfjuos0iAnRIN0XmEMs/8+JWO5pCuJebuOY1QH5WSNQMVviuvaNa?=
 =?us-ascii?Q?NS8fxtavBRUnPavAuggpO7OqJuBSluqkI2Eb1cXZDX8yBHWYzg7is7NRsFDS?=
 =?us-ascii?Q?TQY9vhlDN5S9gRFVC/S19iMsOak33NAI2YWbwBeW+wkCuVgxakx9oS5+Tpkw?=
 =?us-ascii?Q?wDLj9AjN/op5q3oAnX6K5HX+DXrSZ9Fy2sIoyhXTJFLhQTf7M0+P0bQUrSg2?=
 =?us-ascii?Q?aWWIpzFuqtxfFmq/nUpU0vKqwPzFjsP3vtQFngpUDipHEsIarfuAcvVjOa2L?=
 =?us-ascii?Q?J+oZWWkRxiNCZKJ+Jp68aryUeDBGyKYWDi8EzjC5I7aufR3xpeAqnGRbac5T?=
 =?us-ascii?Q?Cy4WJP+g9wprhK/i2ZmQGNZNEZgJaQnRr9UXiaPxVW2Lv9/RvhEh5sjL3l6B?=
 =?us-ascii?Q?r3LuWAAGDFZlGmxK+XNUwMEDDLdZvhkzsP+WR/x2Os4pObbsjc3TgJunOJ08?=
 =?us-ascii?Q?cmGf6txNwuqsOf4aIpLk0YXX63w/9G5WV+QW4Y8eA1UWozT1fkPlS0HxF7rQ?=
 =?us-ascii?Q?ElEX2dzFJaTTJWnxuLQG+fUQ4eLzG0ExKtL/Je8LDeqyOgbWOgP5IsECINwX?=
 =?us-ascii?Q?2c8hD4AUUThmbMCKqsVsf3/KJnhrbzX9ZMdaxCSnTvViOZ/rliIXj9eaLHuW?=
 =?us-ascii?Q?yQEhJ2XAGsdeQt+x0m7UgRU63IiCQheaAkUwVyLJiviqnEThZhRmtp+3qcwW?=
 =?us-ascii?Q?zHLMfnISOv2sXMBpakzh5BUsyuz2VbfghnkAZOLPIjucjvcVvPL35fgCTVZQ?=
 =?us-ascii?Q?+zMzb05Dp/telgTPaOjVEpQkJcqXSYekJ7wwNxJ2MldITwMIVzyzQRLbIiQb?=
 =?us-ascii?Q?VByewxKpRZMkmKCfIsBrRy6tAhMARpyLI1Kjxll1leomlM2WdTT4SG2kctfK?=
 =?us-ascii?Q?5usWuzFEc2XiyuERakf78jYBoVb5aMcN1bEjSmq9TebfpOD9NIPfZCLXwoaE?=
 =?us-ascii?Q?6Mtdonfa3hu1Otxwy5m0KHj3jG/I8SBUmJJE9G04tA3LiJJOn5TPJCqTNWG0?=
 =?us-ascii?Q?On5Dv3T83DoirGmaXzIn82Vu+WnmwZvaPT0c2UG9X07gujxPxLGZ63rJrcMB?=
 =?us-ascii?Q?oErCQ+LNZW1u2/NFUWpyRCRGcIuityCN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:22.4316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a0672b-daa7-4928-8b79-08dcb71d1baf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619

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
    IOMMUFD_CMD_VIOMMU_INVALIDATE to flush cache by a given driver data

Worth noting that the VDEV_ID is for a per-VIOMMU device list for drivers
to look up the device's physical instance from its virtual ID in a VM. It
is essential for a VIOMMU-based invalidation where the request contains a
device's virtual ID for its device cache flush, e.g. ATC invalidation.

As for the implementation of the series, add an IOMMU_VIOMMU_TYPE_DEFAULT
type for a core-allocated-core-managed VIOMMU object, allowing drivers to
simply hook a default viommu ops for viommu-based invalidation alone. And
provide some viommu helpers to drivers for VDEV_ID translation and parent
domain lookup. Introduce an IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3 for a
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
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p1-v1

Thanks!
Nicolin

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED

Nicolin Chen (15):
  iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and IOMMU_VIOMMU_ALLOC ioctl
  iommu: Pass in a viommu pointer to domain_alloc_user op
  iommufd: Allow pt_id to carry viommu_id for IOMMU_HWPT_ALLOC
  iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
  iommufd/viommu: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
  iommufd/selftest: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID test coverage
  iommufd/viommu: Add cache_invalidate for IOMMU_VIOMMU_TYPE_DEFAULT
  iommufd/viommu: Add IOMMU_VIOMMU_INVALIDATE ioctl
  iommufd/viommu: Make iommufd_viommu_find_device a public API
  iommufd/selftest: Add mock_viommu_invalidate_user op
  iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
  iommufd/selftest: Add coverage for IOMMU_VIOMMU_INVALIDATE ioctl
  iommufd/viommu: Add iommufd_viommu_to_parent_domain helper
  iommu/arm-smmu-v3: Extract an __arm_smmu_cache_invalidate_user helper
  iommu/arm-smmu-v3: Add viommu cache invalidation support

 drivers/iommu/amd/iommu.c                     |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  90 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +
 drivers/iommu/intel/iommu.c                   |   1 +
 drivers/iommu/iommufd/Makefile                |   3 +-
 drivers/iommu/iommufd/device.c                |   9 +
 drivers/iommu/iommufd/hw_pagetable.c          |  27 +-
 drivers/iommu/iommufd/iommufd_private.h       |  37 +++
 drivers/iommu/iommufd/iommufd_test.h          |  30 ++
 drivers/iommu/iommufd/main.c                  |  15 +
 drivers/iommu/iommufd/selftest.c              |  88 +++++-
 drivers/iommu/iommufd/viommu.c                | 249 +++++++++++++++++
 include/linux/iommu.h                         |   6 +
 include/linux/iommufd.h                       |  35 +++
 include/uapi/linux/iommufd.h                  | 139 ++++++++-
 tools/testing/selftests/iommu/iommufd.c       | 263 +++++++++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 126 +++++++++
 17 files changed, 1095 insertions(+), 26 deletions(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c

-- 
2.43.0


