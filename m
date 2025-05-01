Return-Path: <linux-kselftest+bounces-32125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FCAAA671D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC1C3BEC8D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229227C146;
	Thu,  1 May 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T/BYjza5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31227BF7D;
	Thu,  1 May 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140549; cv=fail; b=T0/UBTGspyRZvI+NWHdbBVUSd5qNyQ34+gpc6oF4A+hdvBfsFtpGNqhe2DnWgsJG2xuwp08BLFsm+2DvvP7S9TlzH1B7do3WPhmcLAz7WwJtUAog0Fk54lMk7UNXZ5PQwV/ZnWQ0VUm4ZFZ/3Kcd9RngtdA8e+0OViVMpG4FyLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140549; c=relaxed/simple;
	bh=V5vuIwIeidc9qli67r1k8ImUp9NQoi31MRTKrlPMH4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JE2AWOsVXvvr68MkpPmFC2lWks7/sXQIjbXc6drJ42LqolObEwdSVLW9EhiOoZwDkwOyg6nGWsK2XwJ3ctlS+IL/TQrkoWIhEwTNO3vq6aDKayBmfLIJmu/f+knkOWLNPWBQTrHWvKWmqFFbDQ7/ESDJ8VwTiN+ISce3UZ+Jd6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T/BYjza5; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nP2yE+A6UHdZPdYKGHmbRTG0ireWaZEekNyzksmjtB7ax0RV0wXLuj72e8PovMam+MnvplmfC+j0daVhJq+ZA0Xc2emRaQlO4EFenqEZVnawE/7+1e0wdKt+3JSOOsK4Tr3PItt7GQznW5t3xvhOKvYzVtM+D27+yzTa62VSdTUpFXIFdWrS5ayvm3aUpJsTCu4+nsZMS+2PAANXFdfB27kZt0ClPh/xrbbetsi3RXzEjQn86Qgd9SbhCOpuDHhiUdh+570KTx6jPmhlkOyZAJYmHg4jobUuvqHvOeSaD7OJCoIM2u+SoWQdF+0e+taRUf4HAdU3siEw4h6nR431qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bdeIlzut8Ixg0cScjJNIwVfQZ55Ri3NgmZ/YDa+0sY=;
 b=TDU/25GOIaFF6Nm/XQY9+h/rq7eBMctDvBuu/LO21axi8JkE8oxmhauSgwdx5kQL0CuGhN2SClw6Vfu1FEqrj3pUhDQ20o/HtRsfSkU7Ro2/ODrWLcaYosYC0EeiQVhcJ1dX1WaZ33zluMmUjm1UrIHiaSrST/XOsRl6BSoTI8V3OHdqPErTwMIpbm5zpjVe/PcfSsCCZPfa+47tNIpfNNWgPL8rBsrvG+rq9bs8LCzARlm9rKHN5vlQnu9rFnjboPAJsLRC2PpswNqhElJ5N0JUEUfhUP5GlbzZJAiYPV2BSURxTyJppqn0h/oD11/8uPwgdKGodGdhZr33FZfd7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bdeIlzut8Ixg0cScjJNIwVfQZ55Ri3NgmZ/YDa+0sY=;
 b=T/BYjza5NYSgBkU7a+bWkRYiIIl9NIvxe46IE24Ekpc/yhCgr83BorBw1C2hsmhauAly8l+YMEFXFgiNUURIHENieeblY87gYkO2h3bp2RcMdUQolDKH9pE+0wnmE968Qzj5wSCQmTkOLGVxL5h7o0pIKSG+TuvoJ6do9VoPF5nKIMwINDLbxZC+RyN9XcIJF3OsKUScJrvYGeBR1HqekOw1bCxrb49DH03BMZQS+d0ZQpa4I3O414jJ1wD5EJ9KWOXPHi7v1FUDqtzpl9dOP5P6tFFEN0mS8oA6e7PHx/ImZtkGO4uN/aGyvrLl4xUPJDWQ0JxoUV0tdqaXxorSIQ==
Received: from CH2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:610:60::13)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Thu, 1 May
 2025 23:02:23 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::db) by CH2PR14CA0003.outlook.office365.com
 (2603:10b6:610:60::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 23:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:02:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:02:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:02:06 -0700
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
Subject: [PATCH v3 14/23] iommufd: Add mmap interface
Date: Thu, 1 May 2025 16:01:20 -0700
Message-ID: <34626e2425b9d4335e47c2bc35cd215dad75e646.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: d50e5803-ebcf-4f1c-e496-08dd89043bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rg0/n9+47lARFCeN2kt+GEv8oXNa0gSQ4+oIQFF7qZEVoN1Mzmx8R5RVbVh1?=
 =?us-ascii?Q?O2j65Z4v8fEaRQyQr4v72OOsNtdQ42ZeY/8/Sd+Jkz+byxd2S4wEx5Wev62A?=
 =?us-ascii?Q?KPXkhPtTMnmSbWkiaA3Y1rDaXj6T+FEnghOR08x8bJqvq+dHI1l8T77CjbIq?=
 =?us-ascii?Q?UEdq9bezWhQz9N8F9RG+4toi47AeeGnA0rWfsH3n5yt9rQS73zy5shcJHGhY?=
 =?us-ascii?Q?DdNAWICZ7uLbF22NXmRzTcwKCDwNigHCqhFiFXBgvq71CBzHWg4+yz5ji44f?=
 =?us-ascii?Q?tfOEeGt7UAqSOwfxAqW0Z0EZaUcACIz64gWpj1CFmP33JQiqE7LVMtHQZiNa?=
 =?us-ascii?Q?2zTO/nSTP/3ZPLvEmRhWBhHzIi/sJhoKthLSNAjpUHeOu2pFmtnZCsWFArnM?=
 =?us-ascii?Q?4ph64jFd/90avjMigDkYmz7X64GXlfQSfUd6AnGLwlwdZ5zrgrKA5nWPsR5n?=
 =?us-ascii?Q?M5/QBbpAMLh3fZEeHrHdErZbWp+KbKmGVEtEs23w1ioEifosDTYnnrpumxP5?=
 =?us-ascii?Q?GDlRbX2WrwZB9HoFTWbStbgJScKE6X4VTU3u7uFY38fGDACmcvaw9hPlVJ5s?=
 =?us-ascii?Q?Cy7hO0F+f/GCwNkCGvporE8qAz2pbpGYBByVe/8I99V+FRqfodObGYZ7hLdC?=
 =?us-ascii?Q?BUgSyeMHfB3TJI0R6rt7bnDFyt89+5oTsOCBomyooSWsEvWSES2t6CnMGr62?=
 =?us-ascii?Q?Fo3TLGBppsnudS4EgkP8GZ0KkFb3Z4NM+8nc2hP76CYLdNNy/3llqzN80FkE?=
 =?us-ascii?Q?VVgU8vGUuYCRoG0uw/OJtC41nT0rwniyo7uBz7enUC2yKjK5ES9n9tBhRQpE?=
 =?us-ascii?Q?/UlrvXPh6m0xNay/0B+0gWVqPntAU47vMJowuGBz3xRhHT1n+65ahvO2Ge3H?=
 =?us-ascii?Q?SkkSR430bXAbvlNSn/T1UZPr8q4EYbpoGmrRgDvCwXoWRIIckWhWkzh2FKBK?=
 =?us-ascii?Q?T1p2/iTFmuRLbxYujX5AkOBOAxXO5o4xyi06PLDfIFt2Afqr3lmz++0upCRd?=
 =?us-ascii?Q?ekc5sDhNYSAoK2k6v4xEHCr2wJhmpTHHWS4PAjIuHjk7gEohTIQh0WinEtwb?=
 =?us-ascii?Q?G3KFFzAF1f5tVTgqBOLKh/YoEC3C8FOtIrwc5ZrcM4jf1hl5z6k5vLSXjzgE?=
 =?us-ascii?Q?JvXjTZqC7n+fK+erdCu4NCnS0egBoK5l/0MHj6jnQrcYj0gcVQE+qKfTD1xw?=
 =?us-ascii?Q?2AKc/XzATXwFroMxs5xTujF5sDG4txmp2KqnfFo910Q4uCCQlUT3Bg3xWkbz?=
 =?us-ascii?Q?xU27XpFOhgluZY6QXhkGtbc06Bw+zyQWXRRziHvu/eoRstWRov/V7a6aGk1G?=
 =?us-ascii?Q?0dwl/ClkMIUQKSFjezTTK5QGNyyJIQdMAzzWa5/nS19UhRvsghuFq0tkT6bD?=
 =?us-ascii?Q?Vw1XmsOs/+ItvBPhYZ7pqfJPDcU390Qv9l/R4Q73O59/KEkiXeEQzMbMEvUF?=
 =?us-ascii?Q?6cn4VxmeH1tPf9mV+bwhL3Ghy6st3zhIwj6AHw5nZ+BBczuWWGZs3GzvVb/c?=
 =?us-ascii?Q?uO0qTOYjkvRRbVOfgUifoASlPyrjVp7o86xK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:22.9356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50e5803-ebcf-4f1c-e496-08dd89043bab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480

For vIOMMU passing through HW resources to user space (VMs), allowing a
guest VM to control the passed through the HW directly by R/W accessing
the hardware MMIO registers, add an mmap infrastructure to map a region
of hardware MMIO pages to user space.

Maintain an mt_mmap per ictx to store iommufd_mmap structure pointers,
for pfn and owner validations. To allow IOMMU drivers to add and delete
mmappable regions onto/from the mt_mmap, add a pair of vIOMMU helpers:
iommufd_viommu_alloc_mmap() and iommufd_viommu_destroy_mmap().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 11 +++++
 include/linux/iommufd.h                 | 40 +++++++++++++++
 drivers/iommu/iommufd/driver.c          | 46 +++++++++++++++++
 drivers/iommu/iommufd/main.c            | 65 +++++++++++++++++++++++++
 4 files changed, 162 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 595d5e7021c4..cbeef1161283 100644
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
+	/* inclusive pfn range for mmap() */
+	unsigned long pfn_start;
+	unsigned long pfn_end;
+};
+
 /*
  * The IOVA to PFN map. The map automatically copies the PFNs into multiple
  * domains and permits sharing of PFNs between io_pagetable instances. This
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index cbe9910dbdff..e06b6f6704c1 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -239,6 +239,11 @@ int _iommufd_object_depend(struct iommufd_object *obj_dependent,
 			   struct iommufd_object *obj_depended);
 void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 			      struct iommufd_object *obj_depended);
+int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
+			phys_addr_t base, size_t size, unsigned long *immap_id);
+void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+			   struct iommufd_object *owner,
+			   unsigned long immap_id);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -271,6 +276,20 @@ _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 {
 }
 
+static inline int _iommufd_alloc_mmap(struct iommufd_ctx *ictx,
+				      struct iommufd_object *owner,
+				      phys_addr_t base, size_t size,
+				      unsigned long *immap_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+					 struct iommufd_object *owner,
+					 unsigned long immap_id)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -387,4 +406,25 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		_iommufd_object_undepend(&vqueue_dependent->member.obj,        \
 					 &vqueue_depended->member.obj);        \
 	})
+
+/*
+ * Helpers for IOMMU driver to alloc/destroy an mmapable area for a structure.
+ * Driver should report the @out_immap_id to user space for an mmap() syscall
+ */
+#define iommufd_viommu_alloc_mmap(viommu, member, base, size, out_immap_id)    \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_viommu,               \
+					  viommu->member));                    \
+		static_assert(offsetof(typeof(*viommu), member.obj) == 0);     \
+		_iommufd_alloc_mmap(viommu->member.ictx, &viommu->member.obj,  \
+				    base, size, out_immap_id);                 \
+	})
+#define iommufd_viommu_destroy_mmap(viommu, member, immap_id)                  \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_viommu,               \
+					  viommu->member));                    \
+		static_assert(offsetof(typeof(*viommu), member.obj) == 0);     \
+		_iommufd_destroy_mmap(viommu->member.ictx, &viommu->member.obj,\
+				      immap_id);                               \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 0bcf0438d255..58dfc7bff210 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -78,6 +78,52 @@ void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
 
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
+			phys_addr_t base, size_t size, unsigned long *immap_id)
+{
+	struct iommufd_mmap *immap;
+	int rc;
+
+	if (WARN_ON_ONCE(!immap_id))
+		return -EINVAL;
+	if (!PAGE_ALIGNED(base))
+		return -EINVAL;
+	if (!size || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
+	if (!immap)
+		return -ENOMEM;
+	immap->owner = owner;
+	immap->pfn_start = base >> PAGE_SHIFT;
+	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
+
+	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
+			       0, LONG_MAX >> PAGE_SHIFT, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(immap);
+		return rc;
+	}
+
+	/* mmap() syscall will right-shift the immap_id to vma->vm_pgoff */
+	*immap_id <<= PAGE_SHIFT;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_alloc_mmap, "IOMMUFD");
+
+/* Driver should use a per-structure helper in include/linux/iommufd.h */
+void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
+			   struct iommufd_object *owner, unsigned long immap_id)
+{
+	struct iommufd_mmap *immap;
+
+	immap = mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT);
+	WARN_ON_ONCE(!immap || immap->owner != owner);
+	kfree(immap);
+}
+EXPORT_SYMBOL_NS_GPL(_iommufd_destroy_mmap, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 23ed58f1f7b1..040d9ff68f53 100644
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
@@ -410,11 +411,75 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
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
+ * Kernel driver must first do iommufd_ctx_alloc_mmap() to register an mmappable
+ * MMIO region to the iommufd core to receive an "immap_id". Then, driver should
+ * report to user space this immap_id and the size of the registered MMIO region
+ * for @vm_pgoff and @size of an mmap() call, via an IOMMU_VIOMMU_ALLOC ioctl in
+ * the output fields of its driver-type data structure.
+ *
+ * Note the @size is allowed to be smaller than the registered size as a partial
+ * mmap starting from the registered base address.
+ */
+static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct iommufd_ctx *ictx = filp->private_data;
+	size_t size = vma->vm_end - vma->vm_start;
+	struct iommufd_mmap *immap;
+	int rc;
+
+	if (!PAGE_ALIGNED(size))
+		return -EINVAL;
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+	if (vma->vm_flags & VM_EXEC)
+		return -EPERM;
+
+	/* vm_pgoff carries an index (immap_id) to an mtree entry (immap) */
+	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
+	if (!immap)
+		return -ENXIO;
+	if (size >> PAGE_SHIFT > immap->pfn_end - immap->pfn_start + 1)
+		return -ENXIO;
+
+	vma->vm_pgoff = 0;
+	vma->vm_private_data = immap;
+	vma->vm_ops = &iommufd_vma_ops;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_IO);
+
+	rc = remap_pfn_range(vma, vma->vm_start, immap->pfn_start, size,
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


