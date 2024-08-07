Return-Path: <linux-kselftest+bounces-14957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E394B0F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F07B283951
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CCA146D48;
	Wed,  7 Aug 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ggINxS2E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B44145FF5;
	Wed,  7 Aug 2024 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061495; cv=fail; b=KCml6ElCtMimwb9WO7RdX2U0Ai7k5+xVO4oLg2DH/2QdOTbP5evW4zKPWqApoe/OFvt2TeaR7t7Q8ZDgqqn80FIWc+8fY2qi/mwpu8uLYUgViC2MeDl2dpd3ECveSeLO/UmyOR8C5iDSXhX8gRgeb37GuMa62uzWxLd/Lr7tM24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061495; c=relaxed/simple;
	bh=ry1Dz1VNj4lggUVOCZRO9hXCwYamUaFYLTPNRN0gQdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJnK/iQkA8p8SGZuuW+qlm+b8wXe3HYTY7Uyikrx4DqS4zL1r4C3wPgRwslA3XHkjUXUdyfzT7ROz5YZxYqiX00xdioT/+i4OV4pFceQZr0c9FFA/6QCqzhAVFV+4Jbe16DdcCyYEKh5URQQ5ek6nx3grJA1rfZoE0zr9+I5fKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ggINxS2E; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBRExV8fhwR3dOHP7uwoNuA8soDcj00wQjhPpHWvOccULe96eJoAlWMoZUO91DowCJrvc9kXmf3/VWMFZie0jwGQ0CAMoH6uNoaQG4KhVv6JiZ10h9sEWDm1u33aoEgi67suYRxOGAerhMpKwqOMqxKYfPRNVsE67ezHV1tDNTAmLugu5/zIY6x6TZihwPa0amVcSpUUS4eOeYRC4i0VblZbuPZfdtX1ZPDb2eQ9Casytfnp/JQYqSCcihdgrtmh6EkNiiCuqwYmXR0OLo8Ifd9tDWMdq0s0cqJzYI00WVgmkoXN286wPlEh+c5/d84JWlkYfnRDS64MOwGZLEOccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTp8oEpJJZI+rcs6AILGCBaCefNRwcbwWthdXWw2cOY=;
 b=zVLsmhiMP5GuBh2651fTYyHmRrws/fg+24SG5YJxYm35V4hCgtHH3F1tatZb2kVACqg6okRy/N+OdomjukF4maZTfjm7dpwtFxa2+C/x0XwZLBSs9tH/TE0DSyYrqAOl64C9gibsA7caG5UlvRgWnR3RMWkaUqbHvRVldu5HyOkhNUmlKaPHf9Zi59C4fa7lkPRO03NhHs1inX86eWJndROg6QuRxMlpzs7AxRqjBBzz+y2C187pk42KzjOevxmpSPDVclw0weRBSpkRFx14xtDkc6v54vV1sPuOQ3B2ntMoLKzMzYI6y/F0USWCnvLNidGAO0pXY1i77F85MLC7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTp8oEpJJZI+rcs6AILGCBaCefNRwcbwWthdXWw2cOY=;
 b=ggINxS2EVAry6AxFkSPTbO1q0IklLVvePLB/puFtN2955wQE1JcCws+5tIImTVYnNKca6iz+NsrKP7wWBGn1k8k0lGr9ygRl/Y+FwMu270tUVDWZPhgrLPvuD9FIepV6YHMv58BBqa3m6rNnJjYACGVQyo3we5tt9GU+VVfDvyZWHYzOorXMSTkRS/eHY2iWI8KtcqzWOzN8yJ0DIIu5MJJhSIcXhE1i8ux2zYj+zCT+wO45EHA4EW0KZzqhBNG+uKsckgibNsIAAscloc8vYasYY7OyGWmLOuH6SSKeANczOk/JxqGC/S1Q99pktZljO+tiBSvsMq6+YamZ29vnog==
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Wed, 7 Aug
 2024 20:11:29 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::6d) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 20:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Wed, 7 Aug 2024 20:11:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 13:11:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 13:11:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 05/16] iommufd/viommu: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Date: Wed, 7 Aug 2024 13:10:46 -0700
Message-ID: <e35a24d4337b985aabbcfe7857cac2186d4f61e9.1723061378.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723061377.git.nicolinc@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd15d10-65c3-41e4-63c0-08dcb71d1f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fo89YhO36k3L2O8SIn+es08Ati5guUHiGiK/4Ei+zqheuKAGtXWsD7JxUzOo?=
 =?us-ascii?Q?PSPXkMB56Q1aphnPhd6k+I7gg1jP5rqnYBiuozCnwE4V2YhkhWYSodxPxHT5?=
 =?us-ascii?Q?IlAnBsItmJzDTG/wD+mYW0znjaG9F/9WuqYnUd55evrmNzlTefzH1d8goRMf?=
 =?us-ascii?Q?zSa/0wbkrzAS0IK7lPB/1J5HzjcxvUXyPpU00sWoiRWP6fwU8VWeCq/lGbEF?=
 =?us-ascii?Q?aS6cjFdwL6n7H6wm75yfSL8B4ooNMtud4qzByeXzyJoFplmHv/zCZ9CTHOGJ?=
 =?us-ascii?Q?SppP9yUPdF9VWHLwsPqrLQ/QVU4AYNJ+GO55Jg+UCBGEmGsiBROhdhpqmIcu?=
 =?us-ascii?Q?Kn3jK3ULDU4R1mtihhTFyKZSDy6Yk5g0NTHJPXgqDxnB6IpW+a8O647cFOWo?=
 =?us-ascii?Q?/ciTys5k/meoSRsEfuwx6hW0fsO9eSzqI7y1ruiX8HQp5pX9HkLn+NLV040Z?=
 =?us-ascii?Q?PLa1DFvhlOFNpgdXSE/LbXqKCC+x5oqhxxou/haYmgtAvgd/Df5pGryGIzVc?=
 =?us-ascii?Q?POFoJmIdiNPVaYhHf1chyQV2gQRa8Jl6A82Npq9Uoy6UUzyuYA0jSCmBd0Sa?=
 =?us-ascii?Q?xZOQ1teU8bqElbZzHEJ6nUSkQnpCuRDV0BIs7bWiDAUCNT+VSMDboUMW7rTm?=
 =?us-ascii?Q?0PXgr33PI4V2AEc7IEqakHxWtPGWBgVSSsmtnMk8/D3YXz/jUwLEF8jW08rE?=
 =?us-ascii?Q?rMHJ0s7KL2D1+exqQiqw16XQJ5llsl2VFZmbSa/aaLlzoFngbed16kaT4i6f?=
 =?us-ascii?Q?f5tiGQHrVfB7pqeeArlegc3/AdMS13yHVIyPoLHaPk4zj56tO6X+ZLSnc4rG?=
 =?us-ascii?Q?DiWiUBkAOsRhkWDQCugGHQtyoDosfsO2yG/dDCL7UOhdOnT87XeuseSlbYZJ?=
 =?us-ascii?Q?ZhpldvYzh2ThqzGO8A/5TNAGrJgXtNK07Y+KgemANbBcp+04LkyRkPFpWr0j?=
 =?us-ascii?Q?+b/KcikQ8Gt7U5O5LhFdYiSfgGnS25Ukiat2jcgNOqx2nQ3EJqWg7iKkBwwL?=
 =?us-ascii?Q?XOzQDg9VqpgyT6eWuqe/BaGI331/gVcSivfilQ+uM8cV3aPW6kjGzfJwmczx?=
 =?us-ascii?Q?leNeUv5YMi+1m3z5Z1kDNC0Bn83dPKoxuF0v1nstGYiovUFVBJiIfffI9JDu?=
 =?us-ascii?Q?E9/8zwAB9h6J4ZNs1kCXQBiVTnYr8eFiWXm5NoFOBwMo4u6/v96R9Ob1lJIE?=
 =?us-ascii?Q?4MP7Yv05iBab7yRCVH19HgI3qjeve4nh8I69eVFILWauy/pqpGdeieTChW1p?=
 =?us-ascii?Q?QpFVPZ1CmbY2MXK8UTHU20wSuEBaYgYuihPTdSdfrhTmS2pxoabesD3Ty8kB?=
 =?us-ascii?Q?lp6DAEJXOwnUtfk84vMmL2lrfRmxSgUbrPXhnzzR0jIfjJi6O6VyW34f9D8W?=
 =?us-ascii?Q?GECfgFkD6IZlX1W8Ztlb1AgSVq4V97oC/NYl09e4Ugo6ICLbJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 20:11:28.7654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd15d10-65c3-41e4-63c0-08dcb71d1f78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

Introduce a pair of new ioctls to set/unset a per-viommu virtual device id
that should be linked to a physical device id via a struct device pointer.

Continue the support IOMMU_VIOMMU_TYPE_DEFAULT for a core-managed viommu.
Provide a lookup function for drivers to load device pointer by a virtual
device id.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |   9 ++
 drivers/iommu/iommufd/iommufd_private.h |  20 ++++
 drivers/iommu/iommufd/main.c            |   6 ++
 drivers/iommu/iommufd/viommu.c          | 118 ++++++++++++++++++++++++
 include/uapi/linux/iommufd.h            |  40 ++++++++
 5 files changed, 193 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5fd3dd420290..ed29bc606f5e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -135,7 +135,14 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
+	struct iommufd_vdev_id *vdev_id, *curr;
 
+	list_for_each_entry(vdev_id, &idev->vdev_id_list, idev_item) {
+		curr = xa_cmpxchg(&vdev_id->viommu->vdev_ids, vdev_id->vdev_id,
+				  vdev_id, NULL, GFP_KERNEL);
+		WARN_ON(curr != vdev_id);
+		kfree(vdev_id);
+	}
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
@@ -217,6 +224,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	idev->igroup = igroup;
 	mutex_init(&idev->iopf_lock);
 
+	INIT_LIST_HEAD(&idev->vdev_id_list);
+
 	/*
 	 * If the caller fails after this success it must call
 	 * iommufd_unbind_device() which is safe since we hold this refcount.
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 443575fd3dd4..10c63972b9ab 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -417,6 +417,7 @@ struct iommufd_device {
 	struct iommufd_ctx *ictx;
 	struct iommufd_group *igroup;
 	struct list_head group_item;
+	struct list_head vdev_id_list;
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
@@ -533,12 +534,31 @@ struct iommufd_viommu {
 	struct iommufd_ctx *ictx;
 	struct iommu_device *iommu_dev;
 	struct iommufd_hwpt_paging *hwpt;
+	struct xarray vdev_ids;
 
 	unsigned int type;
 };
 
+struct iommufd_vdev_id {
+	struct iommufd_viommu *viommu;
+	struct device *dev;
+	u64 vdev_id;
+
+	struct list_head idev_item;
+};
+
+static inline struct iommufd_viommu *
+iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VIOMMU),
+			    struct iommufd_viommu, obj);
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
+int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd);
+int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 288ee51b6829..199ad90fa36b 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -334,6 +334,8 @@ union ucmd_buffer {
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_viommu_set_vdev_id set_vdev_id;
+	struct iommu_viommu_unset_vdev_id unset_vdev_id;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -387,6 +389,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VIOMMU_SET_VDEV_ID, iommufd_viommu_set_vdev_id,
+		 struct iommu_viommu_set_vdev_id, vdev_id),
+	IOCTL_OP(IOMMU_VIOMMU_UNSET_VDEV_ID, iommufd_viommu_unset_vdev_id,
+		 struct iommu_viommu_unset_vdev_id, vdev_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 35ad6a77c9c1..05a688a471db 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -10,7 +10,14 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_viommu *viommu =
 		container_of(obj, struct iommufd_viommu, obj);
+	struct iommufd_vdev_id *vdev_id;
+	unsigned long index;
 
+	xa_for_each(&viommu->vdev_ids, index, vdev_id) {
+		list_del(&vdev_id->idev_item);
+		kfree(vdev_id);
+	}
+	xa_destroy(&viommu->vdev_ids);
 	refcount_dec(&viommu->hwpt->common.obj.users);
 }
 
@@ -73,3 +80,114 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_set_vdev_id *cmd = ucmd->cmd;
+	struct iommufd_hwpt_nested *hwpt_nested;
+	struct iommufd_vdev_id *vdev_id, *curr;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	int rc = 0;
+
+	if (cmd->vdev_id > ULONG_MAX)
+		return -EINVAL;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	hwpt = idev->igroup->hwpt;
+
+	if (hwpt == NULL || hwpt->obj.type != IOMMUFD_OBJ_HWPT_NESTED) {
+		rc = -EINVAL;
+		goto out_put_idev;
+	}
+	hwpt_nested = container_of(hwpt, struct iommufd_hwpt_nested, common);
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_put_idev;
+	}
+
+	if (hwpt_nested->viommu != viommu) {
+		rc = -EINVAL;
+		goto out_put_viommu;
+	}
+
+	vdev_id = kzalloc(sizeof(*vdev_id), GFP_KERNEL);
+	if (IS_ERR(vdev_id)) {
+		rc = PTR_ERR(vdev_id);
+		goto out_put_viommu;
+	}
+
+	vdev_id->viommu = viommu;
+	vdev_id->dev = idev->dev;
+	vdev_id->vdev_id = cmd->vdev_id;
+
+	curr = xa_cmpxchg(&viommu->vdev_ids, cmd->vdev_id,
+			  NULL, vdev_id, GFP_KERNEL);
+	if (curr) {
+		rc = xa_err(curr) ? : -EBUSY;
+		goto out_free_vdev_id;
+	}
+
+	list_add_tail(&vdev_id->idev_item, &idev->vdev_id_list);
+	goto out_put_viommu;
+
+out_free_vdev_id:
+	kfree(vdev_id);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
+
+static struct device *
+iommufd_viommu_find_device(struct iommufd_viommu *viommu, u64 id)
+{
+	struct iommufd_vdev_id *vdev_id;
+
+	xa_lock(&viommu->vdev_ids);
+	vdev_id = xa_load(&viommu->vdev_ids, (unsigned long)id);
+	xa_unlock(&viommu->vdev_ids);
+	if (!vdev_id || vdev_id->vdev_id != id)
+		return NULL;
+	return vdev_id->dev;
+}
+
+int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_unset_vdev_id *cmd = ucmd->cmd;
+	struct iommufd_vdev_id *vdev_id;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	int rc = 0;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_put_idev;
+	}
+
+	if (idev->dev != iommufd_viommu_find_device(viommu, cmd->vdev_id)) {
+		rc = -EINVAL;
+		goto out_put_viommu;
+	}
+
+	vdev_id = xa_erase(&viommu->vdev_ids, cmd->vdev_id);
+	list_del(&vdev_id->idev_item);
+	kfree(vdev_id);
+
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0e384331a9c8..d5e72682ba57 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -52,6 +52,8 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
+	IOMMUFD_CMD_VIOMMU_SET_VDEV_ID = 0x90,
+	IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID = 0x91,
 };
 
 /**
@@ -906,4 +908,42 @@ struct iommu_viommu_alloc {
 	__u32 out_viommu_id;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
+
+/**
+ * struct iommu_viommu_set_vdev_id - ioctl(IOMMU_VIOMMU_SET_VDEV_ID)
+ * @size: sizeof(struct iommu_viommu_set_vdev_id)
+ * @viommu_id: viommu ID to associate with the device to store its virtual ID
+ * @dev_id: device ID to set its virtual ID
+ * @__reserved: Must be 0
+ * @vdev_id: Virtual device ID
+ *
+ * Set a viommu-specific virtual ID of a device
+ */
+struct iommu_viommu_set_vdev_id {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 __reserved;
+	__aligned_u64 vdev_id;
+};
+#define IOMMU_VIOMMU_SET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_SET_VDEV_ID)
+
+/**
+ * struct iommu_viommu_unset_vdev_id - ioctl(IOMMU_VIOMMU_UNSET_VDEV_ID)
+ * @size: sizeof(struct iommu_viommu_unset_vdev_id)
+ * @viommu_id: viommu ID associated with the device to delete its virtual ID
+ * @dev_id: device ID to unset its virtual ID
+ * @__reserved: Must be 0
+ * @vdev_id: Virtual device ID (for verification)
+ *
+ * Unset a viommu-specific virtual ID of a device
+ */
+struct iommu_viommu_unset_vdev_id {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 __reserved;
+	__aligned_u64 vdev_id;
+};
+#define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
 #endif
-- 
2.43.0


