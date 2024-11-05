Return-Path: <linux-kselftest+bounces-21484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE8C9BD6A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4EE1F21C7D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A7215F63;
	Tue,  5 Nov 2024 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A1fV2G++"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703ED215F4F;
	Tue,  5 Nov 2024 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837150; cv=fail; b=dQoq+RJlD0gImRFH21GZ8QAxb2zzH63Zy0BrJaDe7UDo8PvYA1OcgO/8OVxg6bw7L/1eE0UW8gyn0cn1vaJQiMP7mGzSFPNC0iGO7F+AQfuno0DQkc/X4qqlGmIOHYtZqGYCZURV5dQu5GL08xu3MZvNLkZeDNlrVtZqPYikreE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837150; c=relaxed/simple;
	bh=86nqBWZ+ndhJzPrS1D0edZwYcrU7HJSqmeKOiw83xnE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UjJ87UB79H5kdMRtpcXa8JxNsnvjVIDnf4KfVVbYoWuEYpK3QVVD8glIibjkCIdCUXvL9PewGQONQHa+tHhzlRvn9QqYRS6pyBGPEJ7fVUjkr/+qHhZnNEFgVfB6PcfEvLnBIyOthfHRlueK6HlL+9NCIRiL6266TR6APIxwtqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A1fV2G++; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nfg+8TAcsmoIgRiBFVt2m1rLjjBWyREX77LLC4uihk1R6sqU8TZenvMdVxZKbJvTRPObTA8Jy/n4zObwkRO7Vo+omomWBODkVvhg7EhkYamzrXa09iu/Nal8DBR32D7GmLBqT3mL66qMwcxGWLvzja52ul7Lji9Wpr20mlrpfvczIkvaz0J6Nu/jBjp/brcNEhMPlLVZNCCatpuyL2k3eTCi3zIdP/Iio5At3IhMEXDzwlDqEw005k9NRMidLwnjg7lFc7WNG5JWSG+xqKcBGOfhpUhnZgAABKWgn5gsRe769CSQgV3/cmvIThkaUfqa3WC4Y4GmlTc7UT84eMALsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftAwVupF1RIfjpypmJY+TqJCMPEaefDiiN3ztfxPT9o=;
 b=fWXaM+ieXw40/a/N6nk/2EbW9p9+dyAaYA8qWfUk3O7E+g3S4bzlEmgCNMv4z0C8iJiJnpy2uFPPBp5it/sk25WAV9NOLVOB9bvJl1uVYNOC2MKC3b8CjVnJmhhaFtEb31PZvQ+qcO02i/tw+lmlXH/YIp6BtR5tBbzbpI0ueRcwR7zE+jczPiT39OV3KayhQetodEESEYMuVLGqdTEIBqMoLgzdkYFyj6ixDbkI5xncG+qZcQDktjzVxNO9GSVm4PHb943KmhT76nJuj/GyUK7ot8QgL4hs7hU7f1lDBfxdDkZx4EvzQmc2QSu9YGxtJ7r4/zDseWTT4V6OJ3I3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftAwVupF1RIfjpypmJY+TqJCMPEaefDiiN3ztfxPT9o=;
 b=A1fV2G++kRG9829Cv3ZfvFk10oJpbBUUTj/ogyJ12DNdR65aUORLMSzXzDmw5ImgxgDyk+gRvAtdCtD3Re76s8iVuPgBYhGH8ZgsUFHGdkdjk3DJwjYPDftKlbR17HkTCFAXDnteEjE6Hzzv0his+6TgGhb3kznANNF5aHQRPMVPW+HWJ5xjsYliKNyowpt2lo2TTAfpLT6A/3FYdRxW43neWx/pUalYj6vQw/zsfrttjHgVE3TWfvFfeBMv2LNnMKtpLLl7mhsykFOVBfCKwsfeRt1UuE7KVavGkQ7AC3qxY/Nv1ZD57vXnRVNOuV8ObIB+g5CYIuODvpeSAHUZkw==
Received: from MN0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::12)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 20:05:43 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::89) by MN0P220CA0022.outlook.office365.com
 (2603:10b6:208:52e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:26 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:05:26 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:05:24 -0800
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
Subject: [PATCH v7 00/10] iommufd: Add vIOMMU infrastructure (Part-2: vDEVICE)
Date: Tue, 5 Nov 2024 12:05:08 -0800
Message-ID: <cover.1730836308.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c70227-9cd8-4564-3b30-08dcfdd53aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JOQYyhu54i8r/pvvAx3EnhLKDXDqoSe6dDWEjDitsGV38g5h1FmpDeTAHG5W?=
 =?us-ascii?Q?htelXptP9eAX7y1mMTDSOmOzEkApCFzwtuDVt72n4c5L/vGSxP42h3Ji9ifY?=
 =?us-ascii?Q?SaqO495Uiqbsh/SbA3/W8f3qcbebZeEHMEzKGRMO/bPgFXlmR6IgWqZ+sRoh?=
 =?us-ascii?Q?pAxDpRFWPptMsBue91aavra12jT9D5+UsChk4ncrSbU1+GAB3E2feYk+OeIU?=
 =?us-ascii?Q?5G1C/Swkel0jAKeH7OCXFwt6mARkDLzgpQrTvvWw7zdWGpLxx/+ZHkd6t0RA?=
 =?us-ascii?Q?XdqqkusnoLq3y3sPQ4Jcc9ORIO2XQbp7GGUDfzBy7sPDiw+2axnD0rfKf+X0?=
 =?us-ascii?Q?C3rtJUmVazcgR2iYHzeSC/s3/UTHXZiB0/k9oTu3xBlugENIFB6hWUokfGOY?=
 =?us-ascii?Q?zIXj2Vg7Ko0KhlFtHeDb+09ZDa3AWvfeXyqVI6k2hiokTNpKPg7990KlfQ0u?=
 =?us-ascii?Q?+VjtYCPqt7ZALg/Kig6cthSZz5Vsqy28/XCU0ngMXgCMzOiabETglK30TmZF?=
 =?us-ascii?Q?jvymj4FZoPAhNVWzbwG1znZBIFj4nVD0cKQThbejwAFd0wbZ10ZgqP9RdOhg?=
 =?us-ascii?Q?or9YuBo0S4EKF/JX5UMQaub1/OQltVxkAUWDBz1pOXpHcFPsv/1/PBZrqtHr?=
 =?us-ascii?Q?GgEMSJfB1tG6OGJaK24vAZpImx1zp/sZnZ01QNoPXsm95bjBunNIOAgbP4VF?=
 =?us-ascii?Q?/GscL4dWZnlNkjBIf7bFHd4TkoiTRczk4hotTKPuZH7hdIpcAHEj/cBlBI9A?=
 =?us-ascii?Q?0gHi3TsE2XUi7v3x+AImVsNaTAYFbLwt6k9zND3FTU8+9VnYfyvtPi9Ev52b?=
 =?us-ascii?Q?SRh6WhEJHlNMfOd9H8iBi4pC+m0hT9zQecI4goMPi2A0uMrDuXMzIoC5ztfq?=
 =?us-ascii?Q?TE/aYoPEDhuoFnmnmfJXebtYD4B+TM9t2wX0pSdzRyHMk/lnSBEcnWND85n2?=
 =?us-ascii?Q?XJQVQs+io9pIhvbs7T1IFhl952Z4WcGqQsAWmh/gDALd7LRkg+tLw7Cceac3?=
 =?us-ascii?Q?wIZLSf4UdWPirW2MH7lxVXDZTZtFleW5yVGXDhLNhns7pq1XhOiByE6ipySG?=
 =?us-ascii?Q?b4yscIlg6sol/RPSdR8D6SILazZnziXv9QPnlsCzI2NP681rP3M2SIYaojgb?=
 =?us-ascii?Q?whMmBvmnqWPE1S+RTPMe4gG444OZRNKhG8drAW6xKxUsMmtxDlHfQ61Arfxw?=
 =?us-ascii?Q?2xR/viOE9/pjdq/Q2pavrBvfPCyzrvQwr0Dh3RNBsNpJr3CJU66I/oXGw7gV?=
 =?us-ascii?Q?YdT1/xPxYHltsBSKdXbN96z2qpTrlw3Yel50e5pwzuv3xnPPfyqq3nYYrwWO?=
 =?us-ascii?Q?vxPo2kJckiDvMF1KscL0+LmJ38CKq6Mp8bJ1zrvrqPHJo89DC7SCTo9DWeD9?=
 =?us-ascii?Q?Qe2TYOqXq3MGfSg51mzHsJIlkAthmw9fwDAmjTKDAhSzUwF7mQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:43.1177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c70227-9cd8-4564-3b30-08dcfdd53aa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307

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
https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v7
(QEMU branch for testing will be provided in Jason's nesting series)

Changelog
v7
 * Added "Reviewed-by" from Jason
 * Corrected a line of comments in iommufd_vdevice_destroy()
v6
 https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
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


base-commit: 0780dd4af09a5360392f5c376c35ffc2599a9c0e
-- 
2.43.0


