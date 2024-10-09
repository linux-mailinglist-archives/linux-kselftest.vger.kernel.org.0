Return-Path: <linux-kselftest+bounces-19374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5D79971FA
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5831C23451
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3181E1E282B;
	Wed,  9 Oct 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L6ZTtKAL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F91E22E7;
	Wed,  9 Oct 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491955; cv=fail; b=OYfO9hBQua1P+G9HXzir2jlpqMfWSXJMiwoEJy2qzxnlOWwQwTdBtOSkQD3uoZsc+aw6r/FHzvP1fwc2kjQfx72vzHkzgH8BGHlhlBUJSZJcMZgKMDvJOQXhUjyIvvUvQnuwJtyNAThYcWa0EAl0hf1WHFAh8C26YrDwLqOm8zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491955; c=relaxed/simple;
	bh=UYExXZrhMxRzh0rbqHEqfcfyLiz8ilnGuhxz2RRTk5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgeXVCeprWiz3X29NVFKQ4Ck5Wyb4JzknNd5A5EAyl8Egrg664n9A9WodFw5IyaKuqiadoHJmGTrQ38tcmJnI8NWzEQ4VcQDglSz3apZoASqOdwikmYxVRZgB47UmpxYwq+CuXwQxJFeynONd6LJyDOoZ5dyJ7eEPikYEPSUD6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L6ZTtKAL; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfdC2VzjIAq/6PnEgZ6Yg3oM4WSgEUOQe2PRyZJBCizJvPYc9zD1hdsdCrPed27ErOxpzuT/ibBQEdBtY1Xwmls/C7RVOo6fmFPNfMhN9jGJqVffy1HxuYzO8F/odPHELNVfYPnuQf2+gyCLzIoDg0NqusTbIIDOa+zGdCiQNceuiJqBLTvAu1/rNAqeDTNgSsJlfS140w0j1tigJBfeFF9aRwMn5xmiXnXRay710/gWbTUg6RkG33E1qy4b9BaIEOcL6Th7EvglxCSEVQXQ59HyOWFcRHZrjrY0lzclM+Jdchnv3VoZ5sRmcUlDACTXNZrQyc2QQX8im4Rnfa4spw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3SZXdo0jHpdEFvsvI8ej2TYQiE8Uo3Is/iRw6+VXco=;
 b=ITZ9yE8uFO7uBx6fhY+fBeCe2V4S/TK7EduuyW8tchgjGOZzoDl9KobkQZJ3IBSWCYUxYuiQolEn9Gjj8cP+tZ+lA/Js57Ifj9kX4IOMaKIPWhtlPloSvwQf6MDS0HHBlKB4o6tNH+bRQS6u6l0vR2PtP+Ul6y5d5eXIzhOJNoBRjKyYFD9B7rjnz5ZNjh3tolEo20mapw1I7jEjMdUt8Zaq6WlJr8IJVlA79a25lLvugAHMlU3p6Y4rA7buNu8X4ZxnQPIDPJhnC4P+GUIy9UqsJTA9VRQZmAiS48taQQSz1LTGcg/DVf6OQkgpxlnRSxPVLKoMQb/tyYL0z0l87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3SZXdo0jHpdEFvsvI8ej2TYQiE8Uo3Is/iRw6+VXco=;
 b=L6ZTtKALJzqjbQDk1r/iKs+0h3VzrxNl2fyoj7R3fZF4nGeSH++Ljxcpd/r7kkZ+RVPIqjeGwnc2EVWg29saequSoapHSEPqmD51Pg7KollS6aIu7Q6Gzf4w3EMqDjtlHImOYzfi+DWKNFG3d6khzaxo/IMuUsNaRNyMYKgod0GV9i5On2izI903UhI+RNTGbq2fRJDqv3fzeYB4FTHCftBU5OYmZ2t6+LtdWOprf01gx+oQbKBfRi3TC4pBhGsWYKXLaqIeRXXeTMcgd9Tp5i9myaFR8DKHE7JXIiegvsY9G4I0rgUNQleAxIQqIK6VV+vb58F6/WSxRaN1vA1vdw==
Received: from SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) by SJ0PR12MB5663.namprd12.prod.outlook.com
 (2603:10b6:a03:42a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 9 Oct
 2024 16:39:02 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::6b) by SN6PR2101CA0027.outlook.office365.com
 (2603:10b6:805:106::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 00/16] cover-letter: iommufd: Add vIOMMU infrastructure (Part-2: vDEVICE)
Date: Wed, 9 Oct 2024 09:38:12 -0700
Message-ID: <cover.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: d34375fd-701e-4d63-e3e3-08dce880e209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kb+1wVbKGNiqWr9dZaUAHGN7U1ITCLI+h5bDKmBGTZZuNB/kMo35E4Lsd7MD?=
 =?us-ascii?Q?wbJkJiq0AcD2GBf2+2TZND/WqR0VqZALFypbh2T63b9WXUSmmAvPcXIQ+6a4?=
 =?us-ascii?Q?6BnvR0nwhg4U+gQ+moxTsKO9RheKmqMFFJzYZbX0t7RmhTpQz9MVLu5kIdWI?=
 =?us-ascii?Q?QafssqDpH8V/rpK0djYZuRSfOBXU2JMjX38r4aEYyxt8W9KQG/o4sjbOhN2G?=
 =?us-ascii?Q?1hYtk6Fh8CwfaGDg2SZvJMhCN4S45fEf+VO9WdxKdJOJpzPadrEgYcTdKOhy?=
 =?us-ascii?Q?c6jXx9VgC1kD/BM12KUW5uV00cnazc/3C4oAIhlQqoEsgi77Y+Da1N/jaJXF?=
 =?us-ascii?Q?47DaNCQHeUgmubEVb9mKijyy3olFoDnR9qd+QsgIPRIUyT3Pc0ruU0SJoVGx?=
 =?us-ascii?Q?wAAiCk5w9KYIr3e4wVyt+HWJj+/rKxbyETh4n8rXeH3JtWDumMMD8WV2DyCb?=
 =?us-ascii?Q?Lzpkn/olb2X8unfycJ4ud2GVC7Fg7i/uWvJA8H4dbcvIc8g2C04PPMKdbA3V?=
 =?us-ascii?Q?pBmhQRg7PvD2tNg1h+m8PvW8ANTxYQJo7LPEJ4DoY4xmHXX34Lpa9kKynvCg?=
 =?us-ascii?Q?pVfbM2TtnRAIPdelp826Yu0Kekp8aSmpKzyKfcuLi/YzSgpWJ9oJXnK1UuZh?=
 =?us-ascii?Q?UZ6MjsXNZpDrgBcWJB6oKJ0ipVNak/GjonXeDdQv1KOpLI3e0d7oVHyzeKCa?=
 =?us-ascii?Q?c9+W7A8TiWkaetqCx8zfYzxMOpGBs56hSqMRLudiUzOatorC0Lonrc6RFW9s?=
 =?us-ascii?Q?XJ4kuv6pN0+IN9kmdS1/Rg/fAC+WORnpiqy4zkdIBIYiJ65oOiYu63+4m7Ky?=
 =?us-ascii?Q?u2e3rVXBy5UpuBkSRMtR1GvevI/O4tqUhfWbgrFQPL5+TJ8MxiQ/wWSr5HDC?=
 =?us-ascii?Q?O5+X5RkOlmJejG2oPbcMKCcpxkfd1LV0aKFkDH5b3bsm2dxGM3RyKCvPjW1r?=
 =?us-ascii?Q?f3FlUhmZaNFfTaeUjz4f3TJIQvVG1FSccEYZFlnnFbKT88gjv2m6tjizuc4D?=
 =?us-ascii?Q?dC7iGUT3/ET72O/JNg2ekgRC19xaH17KQyDxlw2GNdmlC+OrfsziLGcrs52F?=
 =?us-ascii?Q?ZT0dsibJQMIb8IosEeww314dCyFnaBWIo79Lo2f7airnE1/8qRkfsZkM/MQj?=
 =?us-ascii?Q?TI3N5HDU0jfWEUICRYcBhFb/rl5909TmDSQV3BDj/AAzxdjFd5P/gy5qPNb/?=
 =?us-ascii?Q?C6hb3FCQxT15DJay1+ra1wdieSW1XFXt0VPqQFYVsDCiVMzfo1XlhuZkYInq?=
 =?us-ascii?Q?UlBcUpdZw1VEJcROAb8h15WfJDJ4MAIxMw8gR9Djb1K3DkBT3oesMpNFhLO/?=
 =?us-ascii?Q?obntUOHkttFGBIYI8BemjoTUbTopwbGBclafKzzMMcHHfkomkD9eSMzl7UEy?=
 =?us-ascii?Q?M/DI1cyTmJj5OSZPHHN5HVwIotEE?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:02.3962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34375fd-701e-4d63-e3e3-08dce880e209
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663

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
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v3
Paring QEMU branch for testing:
https://github.com/nicolinc/qemu/commits/wip/for_iommufd_viommu_p2-v3

Changelog
v3
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

Jason Gunthorpe (3):
  iommu: Add iommu_copy_struct_from_full_user_array helper
  iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
  iommu/arm-smmu-v3: Update comments about ATS and bypass

Nicolin Chen (13):
  iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE and its related struct
  iommufd/viommu: Add a default_viommu_ops for IOMMU_VIOMMU_TYPE_DEFAULT
  iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
  iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
  iommu/viommu: Add cache_invalidate for IOMMU_VIOMMU_TYPE_DEFAULT
  iommufd/hw_pagetable: Allow viommu->ops->cache_invalidate for
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
 include/linux/iommu.h                         |  53 ++++-
 include/linux/iommufd.h                       |  50 +++++
 include/uapi/linux/iommufd.h                  |  61 +++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  83 +++++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 162 +++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  50 +++--
 drivers/iommu/iommufd/hw_pagetable.c          |  45 +++-
 drivers/iommu/iommufd/main.c                  |   6 +
 drivers/iommu/iommufd/selftest.c              | 122 ++++++++++-
 drivers/iommu/iommufd/viommu.c                |  93 +++++++-
 drivers/iommu/iommufd/viommu_api.c            |  21 ++
 tools/testing/selftests/iommu/iommufd.c       | 204 +++++++++++++++++-
 Documentation/userspace-api/iommufd.rst       |  58 +++--
 16 files changed, 1007 insertions(+), 52 deletions(-)

-- 
2.43.0


