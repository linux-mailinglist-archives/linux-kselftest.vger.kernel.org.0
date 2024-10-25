Return-Path: <linux-kselftest+bounces-20734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48C89B1382
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D351C21D91
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C7A215C77;
	Fri, 25 Oct 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KtTSm/T4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639A214409;
	Fri, 25 Oct 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900262; cv=fail; b=au3A7wI5r9DegmgdP9LKOHlFrBF1Ve1uz6I+uv7a2Mro725KmgDqZIMZHlxns7expLOAcIOHj71l7Y9eDNbTnN7Wl5iVFmCr1XombsEctjohvG6PZzOnWVCiYxtW3PNvm6yxJrzEzzvea9s/Vts/IIQDAdiMayQfeRj/e3DLt7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900262; c=relaxed/simple;
	bh=2BWOdznUcaOqO+bEYWmEERMTEPjG3LfRAiz8eMHjgKE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ui7jWNTC6OSJ3TLk06UKu+2umtAhSEOQXET8sLOIxIYkaDb4XkPOkidAXpbL5TPBqUTlya7XAijFct31HDFM/AGiAM8CwgO+M/inKbBbzAXzcwv+X10DGvC9ptBHOBvYrqNxt8vyiKDgbZ2jLfYoNFuxVUV5R+UwQLjTG1axSoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KtTSm/T4; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqrtJf21ESwKmadNI/r2Z94nQIV8qlyk1HBR038KfueGL6qQdqq0AqSMRQoaN9/Zq0mD5GYrCI33muWi1ia79DVhtoPSFgPyX7TIWw7r6gjrr5lLy30fJGiALzrzn352wxp0urQH5M/TazhxisHJpTPW2aV6RU5HHRYuxAIO+GRVWBmjxIBAdvACSxDyxZ9aPdHGYrwZs2aCVI6YwXCDJ2rvIIqpHSBvxKzh6g2oIhMYwxXhhUGyZF0B6Ob8B+nbj7SwjGsmxXKqCSdSox5iIV57qWjWXfnwta7BePcUf1DeOQMYs/1TiSdDTwRZBm7v2KmE2cEW/dw7kig9N9mO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbYKwhcXeGrTiTJsP3hVB1KQp1HnjaRYO57YH3HGW9w=;
 b=TLpC2CpKp8uwDfi+ppI+i8aOYWZ0IJW/hs9P3TmbTgptCPHz0w+X8R7CyPyNIG5e6WhFF+V2b/pU+Q7Afsb/izeIOhn97uZr/eb9dLv0/JCmJ988czVQr+jgjOUZGjzo5Sqmvnt9fyD7Dvgx36EECLF0JfipX8mHHkFigBx9djLjyWuE5YERAP/WlC5gS9eoGrXydNJ3JhLo3JntZtgFBqjMtWCA//5CWJTZqM15fBOIl/MhJDFfFB2YBYyQFmOwN+T6LDUATquakPlCZq9UnXhVgZytQYxxbCMmYI9C5UzzC7d1QE+g38YlZiKBctCQdzKrg1MNNYTPLf//afuFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbYKwhcXeGrTiTJsP3hVB1KQp1HnjaRYO57YH3HGW9w=;
 b=KtTSm/T4vfwPqT+62vJRZQoWbABJ/WQKdQM0fV/h/ilQJswpTf2IRjFSDKSyv+H+F0YxGhHQlOXJWm0gNKagXvOLcJH3KP7A6L4r8owF9XQYK5ou2GnXiCL6+O08QO3XKW3Y10DQNj3OhoXAx/TKCt4ertfWB7dkQ8dkB5hXKrolN7i8Saah/hXss48H7ZDIEo+6FibvEFs8UrYk4I1DCcZbEo0uEVsDs8FRt0RvNxhbCdfa0dyhP5ze73vt7lZNq9dV9R0r/tZgMVcDJx4jZH5nb7yHfWTGP5tMoW+Svgqt4bmn8R9VlvdowzwVhSWK4dHS/p57Ydw4iWAcXdko2w==
Received: from MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::24)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 23:50:56 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::8d) by MW4P222CA0019.outlook.office365.com
 (2603:10b6:303:114::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:46 -0700
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
Subject: [PATCH v5 00/13] iommufd: Add vIOMMU infrastructure (Part-2: vDEVICE)
Date: Fri, 25 Oct 2024 16:50:29 -0700
Message-ID: <cover.1729897278.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 5129883e-2648-4d6f-0fa0-08dcf54fddf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zv2Y5YwhCEiWi6zNSrqMYoKnVme55IzcglpRbk3+9eov+yufZRXi1IMtPgar?=
 =?us-ascii?Q?XwBQPRdfYFFUtvQC0LRhmr1KzmNMt3T6HXg7jhm9MHaTfZQywmPNjtl3ECCw?=
 =?us-ascii?Q?yhKjkIFk8Ezw9G70bJDHovM8xJg4H7dncIypMw4EUrw4Vg+znUl/y21DXctl?=
 =?us-ascii?Q?PE8iDDTjifkhMMo2jBnqwfDlJjxD6dPioc7oj8ms/0RFJ1K8o2bZFuwAbzq4?=
 =?us-ascii?Q?Y/QypWCrnAXmloiRyMP9zkEf2z+oufbSbYsTkRnhLKQnh1BI8oZ7dJ+Zo3xX?=
 =?us-ascii?Q?MN8ReF1Sq3IWVJYmjvzEkKtAwBZEA0WhPEza7rrMUBzh2jZbfCE/dd9tMjE8?=
 =?us-ascii?Q?zd8JXmWLzTD3ncTv51980xyzn/8al2A6RKfNM114fKnzMRkV2Sn1UlffsZZ1?=
 =?us-ascii?Q?M9LIMbQtr8dc3Ebh+dk+ty4jy3C6Rxs0miZswmtIuQ3aPCLfVNznig7HMVLZ?=
 =?us-ascii?Q?lc82+KEQevFkDKo4cj2CwiAPi392kIjfdtlwecukcsq7Fv1OriR79237gJk9?=
 =?us-ascii?Q?zWnOnvl/pdumTbGWrDyDz5afjCvRTuJ8+ma2kWvVrM+TY/0j7MX1eQFxDlID?=
 =?us-ascii?Q?iQ6kv9YdnR/ZDSkl9935yLH1q958rFxZQ/AWWcvEVcn5/aFvsP4tCRyFioJC?=
 =?us-ascii?Q?bfmyi1GzQ+g1CpGBI4CSaj3MdRcz7reyrGmsTgqidFJZeB875uvKTHw69ab4?=
 =?us-ascii?Q?XmYj8m/lkQeWgdVE/KVPbooey+iawI6XbkeKm7I3++ThdYKs9N9pgN9PggXt?=
 =?us-ascii?Q?6X3R5xO+IBuAhhC2/lZm6zr7TRwn83R69jrGaWZ6zkC7zXDd0V307/KLPqXe?=
 =?us-ascii?Q?nHMmlWHS+Yvn8uDAS2B2gIUvta5ITxMPHiKdTIi743nBkescYm0jnTqZYnSq?=
 =?us-ascii?Q?1z3XDtMorRLeMPanCYLQlTrxhO/mAXQFt/FK3UHRV3Rcyc3T093vJxcf3CKD?=
 =?us-ascii?Q?94hx/MImmJtUoQIO4bmSJvEFNE03FLM7zhYITMNB/5FtQx5C3Mlz3Pn7X2+n?=
 =?us-ascii?Q?huGIjrzX7PeOwC2DbaQD2dM99xhyb7SiuSxgZ3QhReFvO1EAqe7D0got3Wxv?=
 =?us-ascii?Q?HqFKStQzdvE25ohIObvINHdEpJDyUX1+9jrmzoBKrZLLhzPuJTInFZTe06HU?=
 =?us-ascii?Q?KVsMSSfopj6xUk5I3rd+we+i3XFsGBjCTXYlxuHrGCNZ+YnXE5EBWSxCU4x7?=
 =?us-ascii?Q?Sk3P1y4uG4nbNlj8koElC/vbQholDQCcPUWF4BdyyKhLqMo223ipRVexORis?=
 =?us-ascii?Q?IIsXf7zVWHNKjLlRf3H1n+xM6A6xeFzT9ZYZ8qilgSQQvMpKh9eJyibbj88W?=
 =?us-ascii?Q?Hq0UQj6rckiu/LSFkb3mGIEkS8r7DhuEPQcNFncrtBzFUSYB3mu2rd9123vR?=
 =?us-ascii?Q?XTL/5nqdyEpIrYwsCUXS4uyM78DUHPKUlj/qUfVxjHh9NFzNL3+pCHNjvU+T?=
 =?us-ascii?Q?2HqybQMNVz8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:55.4632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5129883e-2648-4d6f-0fa0-08dcf54fddf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378

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
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v5

For testing, try this "with-rmr" branch:
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v5-with-rmr
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_viommu_p2-v5

Changelog
v5
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

Jason Gunthorpe (2):
  iommu: Add iommu_copy_struct_from_full_user_array helper
  iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED

Nicolin Chen (11):
  iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl
  iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
  iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
  iommufd/hw_pagetable: Enforce invalidation op on vIOMMU-based
    hwpt_nested
  iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
  iommufd/viommu: Add iommufd_viommu_find_dev helper
  iommufd/selftest: Add mock_viommu_cache_invalidate
  iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
  iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
  Documentation: userspace-api: iommufd: Update vDEVICE
  iommu/arm-smmu-v3: Add arm_vsmmu_cache_invalidate

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   9 +-
 drivers/iommu/iommufd/iommufd_private.h       |  20 ++
 drivers/iommu/iommufd/iommufd_test.h          |  30 +++
 include/linux/iommu.h                         |  48 ++++-
 include/linux/iommufd.h                       |  21 ++
 include/uapi/linux/iommufd.h                  |  61 +++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  83 +++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 161 +++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  32 ++-
 drivers/iommu/iommufd/device.c                |  11 +
 drivers/iommu/iommufd/driver.c                |  13 ++
 drivers/iommu/iommufd/hw_pagetable.c          |  36 +++-
 drivers/iommu/iommufd/main.c                  |   7 +
 drivers/iommu/iommufd/selftest.c              |  98 ++++++++-
 drivers/iommu/iommufd/viommu.c                | 101 +++++++++
 tools/testing/selftests/iommu/iommufd.c       | 204 +++++++++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        |   4 +
 Documentation/userspace-api/iommufd.rst       |  41 +++-
 18 files changed, 942 insertions(+), 38 deletions(-)

-- 
2.43.0


