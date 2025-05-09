Return-Path: <linux-kselftest+bounces-32713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA56DAB0864
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657AE3BFAB6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A3A248889;
	Fri,  9 May 2025 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ck62+1lZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC22459FD;
	Fri,  9 May 2025 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759830; cv=fail; b=IfvX15dmR4y134NIkzmO6oSE+WPHgGSM3mwor0abeZpWBpO65svEylObrQ6MN133yHmoC5H8LWvzluJxRvSAn/oEzbk/ZPPInz29dPkKv5y9Ct92aw3VA5mD5pTHu/5dXQwGscTtHkwzbUOeO3sc/MpnpYiQ+mS7dvB2i708lkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759830; c=relaxed/simple;
	bh=PmX3+ANYKfIepngQYzkKHzf7+vURNhS1P40bN03azUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyBUx2LlUaZL36bYOCkG+kj8THwtX23WKJ3gMUGMC9PG5+WrWOKqa0zyKWlObOGxM70R7vr+BG2sC/JGLi+rC8mltgLaPgmkoBMd0HRPrE3W5VAiyR4bRf4VzAZPvEeOPSD0K6YFrmDBd3gyPH/CdAUs+Ne4NDpQRbaPwP1Y5sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ck62+1lZ; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXmtVNbX//v6b8XwpXgfOMMSeHQxyY2nflLnlBGJTApHr0iI8m/6aONRnNIW5s8Lv/IUzjaAzLpvMpqXhYk8g3rAFA4ioRWLdDqXRNS1vQdBYfdZD1aXuXIM2r7SG6Xw+mCswK4rVI5JqF6athcqehA+u2FLqx3zQr3G3MUoOTRXx+sVpMtLX+Z1LUnbr6oAJHCMsU8bHPA9UscWbDJcku/BO+2Fi9FHnPvn1/JRHuGoMxB9Gp8LGDl2VH9ADzQ4CPWI9OBUo3zLkgk7Wxb9XCGFAfA/bAO8E9ATOr9l/5/+dV/vSNRqDZbQvZ5+Td9M+kaNhZetHGrQtuWHZl7gIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5olI9RRcckO2itHeVBLwDTP2AbZY5XOtVbwWfhW38Y=;
 b=yzxIEzRZdNTRAF0J6kueeZhZiC+KjesUs+MUWECa1UBis2i/g1RGH6o8EIVBX4ZaWNY+V/MzHL+g15RMaMiEO5DftM3lMlvLmIXYf0ejG8yd+d8RRpiuvXzkEUDEULt5T35j+AImxHfw6rQXD9LClS60XTeK7H61DWvBmoNTtFg2T1JvfQBeOUNOmhQ/mE9YGInsHx7iEo5HO/LNXnA/ckbJVntruTkV7oKOMbskcS5xZi8q/t+o45GSndy1cD5FcuIj612wXdcdi8pesy56SiFsOpQu2kEWR96DiLyzNTHPPvk/52MkNdizMX6oS6bpG/WUcLyH8V99nEKzRhbSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5olI9RRcckO2itHeVBLwDTP2AbZY5XOtVbwWfhW38Y=;
 b=ck62+1lZIkkv4i/NCrT01K6RHXSud6xNru6aVV04vouGXlYpeC8i8zff608vjr83Wg28rSQ7pN30uDkvsJ4ES74NNgSYiOm6T0OOxrKPC+jiknhdouXibtq8LsLrM80s7wOPYKFyuRffKebYRsIniz72fpF1arpP/D98Ojf7uw/GsYFbIWIUsiw6KFiIK+q/ZURk1hh0FXN19m78nlhTvagSpTZCRJT8KZvF64jJr0XFekJ/FlyM/esV69e7ZmIC/qu3AJLIER5hCuefuDy8cDWqjjMA445WHnYODF5goPFaRlSaf1EV0KBtel1fE4o+W+ItRTjqc2fQU7N7vYzYsw==
Received: from BN8PR15CA0060.namprd15.prod.outlook.com (2603:10b6:408:80::37)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 03:03:40 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::26) by BN8PR15CA0060.outlook.office365.com
 (2603:10b6:408:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Fri,
 9 May 2025 03:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v4 14/23] iommufd: Add mmap interface
Date: Thu, 8 May 2025 20:02:35 -0700
Message-ID: <ee9ee287264fd75eb4fc64a63f20d03e9ba18161.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5d0de6-c91a-48f4-c4a2-08dd8ea619c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JrDhqaKV0NQbXgrbywRJjWV+o/CVIBZ6LKPttnZgzT1pw02d9NkhPaaFqLEM?=
 =?us-ascii?Q?mUfjtya5NiuyD0x1K0G1b4xOlhjrEM7Q/mUoYxfFB5jt9CVGQWReqJQo0Sye?=
 =?us-ascii?Q?v4QjzGVmtsnFnPwcdKO0mA8OKD424mk2lCRAkc1aQjxYK5265Dq4pO0w4Yrx?=
 =?us-ascii?Q?OvUc9AKyfkYy5Z46wmuZXTttoQwOBG7XE3Jz8ACn0MY7iIzi2QguBUVZmGBy?=
 =?us-ascii?Q?/JdkzmEs458HFlWm9L0Jggx3ochf/akVc/OYQYpN480io+Cb5YiUXnUNBnvk?=
 =?us-ascii?Q?i/te2pWKcf107xPK1kuuNQwiWyw/XMAc07Neh7Z5nNskhQ/d3/VsUd4wp+AT?=
 =?us-ascii?Q?pZgJzO4LcEwEIMNQFORkRfaR3oZbZ46E9v/cnHb15F34fO+cZE/iiKUobh1w?=
 =?us-ascii?Q?nbSvHj3wKkRtTDJV8Bn3RWjLguRefYn1pgAHG5gCopwxeBWnG24QscEvc//K?=
 =?us-ascii?Q?bnwk9JS9Zg8Fod1ORvIxcFRTVw0muJccCeghly2R2R1jMLMM9groDL11y1wh?=
 =?us-ascii?Q?0SAHiB3n7tvSEw4f3LzTeX25V6IGjNSgc2VK2iHpnKEQFVLYmcyxtAsyDpCC?=
 =?us-ascii?Q?Q32yiTjhD8+dLs+Ew5do64Vg2W47iMpofgFoOMO47CYHCN5A6qu+h4Tgd0nW?=
 =?us-ascii?Q?sHlpukaa2bF4cO7bK49YGbLt7Xjeqi/bfgqKSKbjNrXwH4zwVx5OzER4RGbS?=
 =?us-ascii?Q?VR8d1DZSdZXw2uQmOHruRv2kjraR+5GSYRnrLHhL1GfiU0XizmX4GyRhw86C?=
 =?us-ascii?Q?QwsF2C8Al/fr70JXUULtkwSoWhZkQjizU1GGFrB6eNEkynvWjhcd1fU7D8RR?=
 =?us-ascii?Q?pLKLU7ecrdmbQHYVLX8hrtPUOoPaRKD9egQnsMvqkTNBZwnczhW3y2alPys/?=
 =?us-ascii?Q?ENrO6ZTwQ8vcinoDvpd12KvucPt+/U1MvNv2qbyJ2ritYfz2DmV1RSh5H5G3?=
 =?us-ascii?Q?I6gMLVv0U1UO6AFr5TLVkPQsTKiZO0aLffbcjmSvYpiKw1XcVJVvDKcZc6yw?=
 =?us-ascii?Q?6glEksGjXO2qtnZdISEMqYKTszfK3cFv2hCl37NVJOESh2MrHhZd9ZOvSv05?=
 =?us-ascii?Q?Rc5QvuksKo1ddpdb1lWaUKTmN0CKEHD4H/VewkbH9PWyKii8pIuNg1u25Hd0?=
 =?us-ascii?Q?lzRhu6P7GlaZtaMvnIUAq/j/gNR27OPzxOPnB4ABs1qyoIjGMYRv0n08fPlN?=
 =?us-ascii?Q?CuarZFyYBcUlTRQMUSMfNqWho39y6F1+djTF0ZY6rRbV3TDC/qKy7TkWASzj?=
 =?us-ascii?Q?ucBzSoe/76RRI6PPv07YzkkYW8GvZLt/YRu4RtNPT0HoutPGnUvKcVpJiV8j?=
 =?us-ascii?Q?3/7sGyzE8WPcpOqtaP8WEElN2bMw1mKBDhAGGIVp10+pBD7moOxBZ3ZocoiX?=
 =?us-ascii?Q?PX7gkdRlZljLEU5ArCIHDsmGExYDj+lvSSvjhftrpVnIzVwhbi9wlcM+1g+/?=
 =?us-ascii?Q?a87btAOXM83+8mqDwkiEYNveec/v+L34GLKQZ544MPWUp9jKzWsKx5NPZI+t?=
 =?us-ascii?Q?Im0hjXC2uISKUY2Kc+BY+QB6VM5/cdN33fSk?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:40.2386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5d0de6-c91a-48f4-c4a2-08dd8ea619c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746

For vIOMMU passing through HW resources to user space (VMs), allowing a VM
to control the passed through HW directly by accessing hardware registers,
add an mmap infrastructure to map the physical MMIO pages to user space.

Maintain an maple tree per ictx as a translation table managing mmappable
regions, from an allocated for-user mmap offset to an iommufd_mmap struct,
where it stores the real PFN range for a remap_pfn_range call.

To allow an IOMMU driver to add and delete mmappable regions onto/from the
maple tree, add iommufd_viommu_alloc/destroy_mmap helpers.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 11 +++++
 include/linux/iommufd.h                 | 39 ++++++++++++++++
 drivers/iommu/iommufd/driver.c          | 52 +++++++++++++++++++++
 drivers/iommu/iommufd/main.c            | 61 +++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 36a4e060982f..c87326d7ecfc 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -7,6 +7,7 @@
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/iova_bitmap.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/uaccess.h>
 #include <linux/xarray.h>
@@ -44,6 +45,7 @@ struct iommufd_ctx {
 	struct xarray groups;
 	wait_queue_head_t destroy_wait;
 	struct rw_semaphore ioas_creation_lock;
+	struct maple_tree mt_mmap;
 
 	struct mutex sw_msi_lock;
 	struct list_head sw_msi_list;
@@ -55,6 +57,15 @@ struct iommufd_ctx {
 	struct iommufd_ioas *vfio_ioas;
 };
 
+/* Entry for iommufd_ctx::mt_mmap */
+struct iommufd_mmap {
+	struct iommufd_object *owner;
+
+	/* Physical range for remap_pfn_range() */
+	unsigned long base_pfn;
+	unsigned long num_pfns;
+};
+
 /*
  * The IOVA to PFN map. The map automatically copies the PFNs into multiple
  * domains and permits sharing of PFNs between io_pagetable instances. This
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ddca0d2835df..47af130f4212 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -245,6 +245,10 @@ int _iommufd_object_depend(struct iommufd_object *obj_dependent,
 			   struct iommufd_object *obj_depended);
 void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 			      struct iommufd_object *obj_depended);
+int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
+			phys_addr_t base, size_t length, unsigned long *offset);
+void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+			   struct iommufd_object *owner, unsigned long offset);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -277,6 +281,20 @@ _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 {
 }
 
+static inline int _iommufd_alloc_mmap(struct iommufd_ctx *ictx,
+				      struct iommufd_object *owner,
+				      phys_addr_t base, size_t length,
+				      unsigned long *offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+					 struct iommufd_object *owner,
+					 unsigned long offset)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -390,4 +408,25 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		_iommufd_object_undepend(&dependent->member.obj,               \
 					 &depended->member.obj);               \
 	})
+
+/*
+ * Helpers for IOMMU driver to alloc/destroy an mmapable area for a structure.
+ * Driver should report the @out_offset and @length to user space for an mmap()
+ */
+#define iommufd_viommu_alloc_mmap(viommu, member, base, length, out_offset)    \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_viommu,               \
+					  viommu->member));                    \
+		static_assert(offsetof(typeof(*viommu), member.obj) == 0);     \
+		_iommufd_alloc_mmap(viommu->member.ictx, &viommu->member.obj,  \
+				    base, length, out_offset);                 \
+	})
+#define iommufd_viommu_destroy_mmap(viommu, member, offset)                    \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_viommu,               \
+					  viommu->member));                    \
+		static_assert(offsetof(typeof(*viommu), member.obj) == 0);     \
+		_iommufd_destroy_mmap(viommu->member.ictx,                     \
+				      &viommu->member.obj, offset);            \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 0bcf0438d255..2d2695e2562d 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -78,6 +78,58 @@ void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
 
+/*
+ * Allocate an @offset to return to user space to use for an mmap() syscall
+ *
+ * Driver should use a per-structure helper in include/linux/iommufd.h
+ */
+int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
+			phys_addr_t base, size_t length, unsigned long *offset)
+{
+	struct iommufd_mmap *immap;
+	unsigned long startp;
+	int num_pfns, rc;
+
+	if (WARN_ON_ONCE(!offset))
+		return -EINVAL;
+	if (!PAGE_ALIGNED(base))
+		return -EINVAL;
+	if (!length || !PAGE_ALIGNED(length))
+		return -EINVAL;
+	num_pfns = length >> PAGE_SHIFT;
+
+	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
+	if (!immap)
+		return -ENOMEM;
+	immap->owner = owner;
+	immap->base_pfn = base >> PAGE_SHIFT;
+	immap->num_pfns = length >> PAGE_SHIFT;
+
+	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->num_pfns,
+			       0, U32_MAX >> PAGE_SHIFT, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(immap);
+		return rc;
+	}
+
+	/* mmap() syscall will right-shift the offset in vma->vm_pgoff */
+	*offset = startp << PAGE_SHIFT;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_alloc_mmap, "IOMMUFD");
+
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+			   struct iommufd_object *owner, unsigned long offset)
+{
+	struct iommufd_mmap *immap;
+
+	immap = mtree_erase(&ictx->mt_mmap, offset >> PAGE_SHIFT);
+	WARN_ON_ONCE(!immap || immap->owner != owner);
+	kfree(immap);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_destroy_mmap, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 10410e2f710a..1d7f3584aea0 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -213,6 +213,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	xa_init(&ictx->groups);
 	ictx->file = filp;
+	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
 	init_waitqueue_head(&ictx->destroy_wait);
 	mutex_init(&ictx->sw_msi_lock);
 	INIT_LIST_HEAD(&ictx->sw_msi_list);
@@ -410,11 +411,71 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 	return ret;
 }
 
+static void iommufd_fops_vma_open(struct vm_area_struct *vma)
+{
+	struct iommufd_mmap *immap = vma->vm_private_data;
+
+	refcount_inc(&immap->owner->users);
+}
+
+static void iommufd_fops_vma_close(struct vm_area_struct *vma)
+{
+	struct iommufd_mmap *immap = vma->vm_private_data;
+
+	refcount_dec(&immap->owner->users);
+}
+
+static const struct vm_operations_struct iommufd_vma_ops = {
+	.open = iommufd_fops_vma_open,
+	.close = iommufd_fops_vma_close,
+};
+
+/*
+ * Kernel driver must first use the for-driver helpers to register an mmappable
+ * MMIO region to the iommufd core to allocate an offset. Then, it should report
+ * to user space this offset and the length of the MMIO region for mmap syscall,
+ * via a prior IOMMU_VIOMMU_ALLOC ioctl.
+ */
+static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct iommufd_ctx *ictx = filp->private_data;
+	size_t length = vma->vm_end - vma->vm_start;
+	struct iommufd_mmap *immap;
+	int rc;
+
+	if (!PAGE_ALIGNED(length))
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+	if (vma->vm_flags & VM_EXEC)
+		return -EPERM;
+
+	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
+	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
+	if (!immap)
+		return -ENXIO;
+	if (length >> PAGE_SHIFT != immap->num_pfns)
+		return -ENXIO;
+
+	vma->vm_pgoff = 0;
+	vma->vm_private_data = immap;
+	vma->vm_ops = &iommufd_vma_ops;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_IO);
+
+	rc = remap_pfn_range(vma, vma->vm_start, immap->base_pfn, length,
+			     vma->vm_page_prot);
+	if (!rc) /* vm_ops.open won't be called for mmap itself. */
+		refcount_inc(&immap->owner->users);
+	return rc;
+}
+
 static const struct file_operations iommufd_fops = {
 	.owner = THIS_MODULE,
 	.open = iommufd_fops_open,
 	.release = iommufd_fops_release,
 	.unlocked_ioctl = iommufd_fops_ioctl,
+	.mmap = iommufd_fops_mmap,
 };
 
 /**
-- 
2.43.0


